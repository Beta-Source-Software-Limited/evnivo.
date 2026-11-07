from django.contrib.auth import get_user_model
from django.contrib.auth.password_validation import validate_password
from rest_framework import serializers
from .models import Category, Event, TicketType, Booking, Ticket
User = get_user_model()

class CategorySerializer(serializers.ModelSerializer):
    class Meta: model = Category; fields = ('id', 'name', 'slug', 'icon')

class TicketTypeSerializer(serializers.ModelSerializer):
    available = serializers.IntegerField(read_only=True)
    class Meta: model = TicketType; fields = ('id', 'name', 'price', 'capacity', 'available', 'active')

class EventSerializer(serializers.ModelSerializer):
    category = CategorySerializer(read_only=True)
    ticket_types = TicketTypeSerializer(many=True, read_only=True)
    image = serializers.SerializerMethodField()
    starting_price = serializers.SerializerMethodField()
    class Meta:
        model = Event
        fields = ('id', 'title', 'slug', 'summary', 'description', 'venue', 'city', 'address', 'start_at', 'end_at', 'image', 'featured', 'category', 'ticket_types', 'starting_price')
    def get_image(self, obj):
        request = self.context.get('request')
        if obj.image:
            url = obj.image.url
            return request.build_absolute_uri(url) if request else url
        return obj.image_url
    def get_starting_price(self, obj):
        prices = [t.price for t in obj.ticket_types.all() if t.active]
        return str(min(prices)) if prices else None

class RegisterSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True, validators=[validate_password])
    class Meta: model = User; fields = ('id', 'username', 'email', 'password', 'first_name')
    def create(self, validated_data): return User.objects.create_user(**validated_data)

class TicketSerializer(serializers.ModelSerializer):
    class Meta: model = Ticket; fields = ('code', 'checked_in_at')

class BookingSerializer(serializers.ModelSerializer):
    event = EventSerializer(read_only=True)
    ticket_type = TicketTypeSerializer(read_only=True)
    tickets = TicketSerializer(many=True, read_only=True)
    class Meta:
        model = Booking
        fields = ('reference', 'event', 'ticket_type', 'quantity', 'total', 'status', 'created_at', 'tickets')
