import uuid
from django.conf import settings
from django.core.validators import MinValueValidator
from django.db import models
from django.utils.text import slugify

class Category(models.Model):
    name = models.CharField(max_length=80, unique=True)
    slug = models.SlugField(unique=True)
    icon = models.CharField(max_length=20, default='✨')
    def __str__(self): return self.name
    class Meta: ordering = ['name']

class Event(models.Model):
    category = models.ForeignKey(Category, on_delete=models.PROTECT, related_name='events')
    title = models.CharField(max_length=200)
    slug = models.SlugField(max_length=230, unique=True)
    summary = models.CharField(max_length=280)
    description = models.TextField()
    venue = models.CharField(max_length=180)
    city = models.CharField(max_length=90)
    address = models.CharField(max_length=250, blank=True)
    start_at = models.DateTimeField()
    end_at = models.DateTimeField()
    image = models.ImageField(upload_to='events/', blank=True, null=True)
    image_url = models.URLField(blank=True, help_text='Optional remote image if no image uploaded')
    featured = models.BooleanField(default=False)
    published = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    def __str__(self): return self.title
    class Meta: ordering = ['start_at']

class TicketType(models.Model):
    event = models.ForeignKey(Event, on_delete=models.CASCADE, related_name='ticket_types')
    name = models.CharField(max_length=100)
    price = models.DecimalField(max_digits=10, decimal_places=2, validators=[MinValueValidator(0)])
    capacity = models.PositiveIntegerField(default=100)
    sold = models.PositiveIntegerField(default=0)
    active = models.BooleanField(default=True)
    def __str__(self): return f'{self.event.title} · {self.name}'
    @property
    def available(self): return max(0, self.capacity - self.sold)
    class Meta: unique_together = ('event', 'name')

class Booking(models.Model):
    STATUS = [('demo_confirmed', 'Demo Confirmed'), ('cancelled', 'Cancelled')]
    reference = models.UUIDField(default=uuid.uuid4, editable=False, unique=True)
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.PROTECT, related_name='event_bookings')
    event = models.ForeignKey(Event, on_delete=models.PROTECT)
    ticket_type = models.ForeignKey(TicketType, on_delete=models.PROTECT)
    quantity = models.PositiveSmallIntegerField(validators=[MinValueValidator(1)])
    total = models.DecimalField(max_digits=12, decimal_places=2)
    status = models.CharField(max_length=20, choices=STATUS, default='demo_confirmed')
    created_at = models.DateTimeField(auto_now_add=True)
    def __str__(self): return f'{self.reference} - {self.user.username}'
    class Meta: ordering = ['-created_at']

class Ticket(models.Model):
    code = models.UUIDField(default=uuid.uuid4, editable=False, unique=True)
    booking = models.ForeignKey(Booking, on_delete=models.CASCADE, related_name='tickets')
    checked_in_at = models.DateTimeField(null=True, blank=True)
    def __str__(self): return str(self.code)
