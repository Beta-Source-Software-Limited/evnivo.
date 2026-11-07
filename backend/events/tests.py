from datetime import timedelta
from django.contrib.auth import get_user_model
from django.test import TestCase
from django.utils import timezone
from rest_framework.test import APIClient
from .models import Category, Event, TicketType, Ticket
class BookingTests(TestCase):
    def setUp(self):
        self.user = get_user_model().objects.create_user(username='buyer', password='StrongPass123!')
        cat = Category.objects.create(name='Music', slug='music')
        self.event = Event.objects.create(category=cat, title='Test concert', slug='test-concert',
            summary='Test', description='Test description', venue='Hall', city='Dhaka',
            start_at=timezone.now()+timedelta(days=5), end_at=timezone.now()+timedelta(days=5, hours=2))
        self.ticket_type = TicketType.objects.create(event=self.event, name='General', price=100, capacity=2)
        self.client = APIClient()
    def test_public_event_list(self):
        response = self.client.get('/api/events/')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data['count'], 1)
    def test_authenticated_booking_and_inventory(self):
        self.client.force_authenticate(user=self.user)
        response = self.client.post('/api/bookings/', {'ticket_type_id': self.ticket_type.id, 'quantity': 2})
        self.assertEqual(response.status_code, 201)
        self.assertEqual(Ticket.objects.count(), 2)
        self.ticket_type.refresh_from_db()
        self.assertEqual(self.ticket_type.sold, 2)
        again = self.client.post('/api/bookings/', {'ticket_type_id': self.ticket_type.id, 'quantity': 1})
        self.assertEqual(again.status_code, 400)
    def test_anonymous_cannot_book(self):
        self.assertEqual(self.client.post('/api/bookings/', {'ticket_type_id': self.ticket_type.id, 'quantity': 1}).status_code, 401)
