from io import BytesIO
import qrcode
from django.contrib.auth import authenticate
from django.db import transaction
from django.db.models import F, Q
from django.http import HttpResponse
from django.shortcuts import get_object_or_404
from django.utils import timezone
from rest_framework import generics, permissions, status
from rest_framework.authtoken.models import Token
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from .models import Category, Event, TicketType, Booking, Ticket
from .serializers import CategorySerializer, EventSerializer, RegisterSerializer, BookingSerializer

class CategoryList(generics.ListAPIView):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer
    pagination_class = None

class EventList(generics.ListAPIView):
    serializer_class = EventSerializer
    def get_queryset(self):
        qs = Event.objects.filter(published=True).select_related('category').prefetch_related('ticket_types')
        p = self.request.query_params
        if p.get('category'): qs = qs.filter(category__slug=p['category'])
        if p.get('city'): qs = qs.filter(city__iexact=p['city'])
        if p.get('featured') == 'true': qs = qs.filter(featured=True)
        if p.get('search'):
            s = p['search']
            qs = qs.filter(Q(title__icontains=s) | Q(venue__icontains=s) | Q(city__icontains=s) | Q(summary__icontains=s))
        return qs

class EventDetail(generics.RetrieveAPIView):
    serializer_class = EventSerializer
    lookup_field = 'slug'
    queryset = Event.objects.filter(published=True).select_related('category').prefetch_related('ticket_types')

@api_view(['POST'])
def register(request):
    serializer = RegisterSerializer(data=request.data)
    serializer.is_valid(raise_exception=True)
    user = serializer.save()
    token, _ = Token.objects.get_or_create(user=user)
    return Response({'token': token.key, 'user': {'username': user.username, 'email': user.email}}, status=201)

@api_view(['POST'])
def login(request):
    user = authenticate(username=request.data.get('username', ''), password=request.data.get('password', ''))
    if not user: return Response({'detail': 'Invalid username or password.'}, status=400)
    token, _ = Token.objects.get_or_create(user=user)
    return Response({'token': token.key, 'user': {'username': user.username, 'email': user.email}})

@api_view(['GET'])
@permission_classes([permissions.IsAuthenticated])
def current_user(request):
    u = request.user
    return Response({'username': u.username, 'email': u.email, 'is_staff': u.is_staff})

@api_view(['GET', 'POST'])
@permission_classes([permissions.IsAuthenticated])
def bookings(request):
    if request.method == 'GET':
        qs = Booking.objects.filter(user=request.user).select_related('event__category', 'ticket_type').prefetch_related('tickets', 'event__ticket_types')
        return Response(BookingSerializer(qs, many=True, context={'request': request}).data)
    try:
        ticket_type_id = int(request.data.get('ticket_type_id', 0))
        quantity = int(request.data.get('quantity', 0))
    except (ValueError, TypeError):
        return Response({'detail': 'Invalid ticket selection.'}, status=400)
    if not 1 <= quantity <= 10:
        return Response({'detail': 'Choose between 1 and 10 tickets.'}, status=400)
    with transaction.atomic():
        # Conditional update prevents overselling even when multiple purchases arrive together.
        updated = TicketType.objects.filter(
            pk=ticket_type_id, active=True, event__published=True,
            event__start_at__gt=timezone.now(), capacity__gte=F('sold') + quantity
        ).update(sold=F('sold') + quantity)
        if updated != 1:
            return Response({'detail': 'Tickets are unavailable or event has started.'}, status=400)
        ticket_type = TicketType.objects.select_related('event').get(pk=ticket_type_id)
        booking = Booking.objects.create(user=request.user, event=ticket_type.event,
                                         ticket_type=ticket_type, quantity=quantity,
                                         total=ticket_type.price * quantity)
        Ticket.objects.bulk_create([Ticket(booking=booking) for _ in range(quantity)])
    booking = Booking.objects.select_related('event__category', 'ticket_type').prefetch_related('tickets', 'event__ticket_types').get(pk=booking.pk)
    return Response(BookingSerializer(booking, context={'request': request}).data, status=status.HTTP_201_CREATED)

@api_view(['GET'])
@permission_classes([permissions.IsAuthenticated])
def ticket_qr(request, code):
    ticket = get_object_or_404(Ticket, code=code, booking__user=request.user)
    # Demo QR payload. Production validation must perform authenticated server-side check-in.
    payload = f'EVNIVO-DEMO:{ticket.code}'
    img = qrcode.make(payload)
    out = BytesIO()
    img.save(out, format='PNG')
    response = HttpResponse(out.getvalue(), content_type='image/png')
    response['Cache-Control'] = 'private, no-store'
    return response
