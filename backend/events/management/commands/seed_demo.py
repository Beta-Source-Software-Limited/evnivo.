from datetime import timedelta
from django.core.management.base import BaseCommand
from django.utils import timezone
from events.models import Category, Event, TicketType

CATS = [('Music', 'music', '🎵'), ('Technology', 'technology', '💻'),
        ('Festivals', 'festivals', '🎉'), ('Sports', 'sports', '🏆'),
        ('Arts & Culture', 'arts', '🎨'), ('Business', 'business', '💼')]
EVENTS = [
('Dhaka Soundwave Festival', 'music', 'Live music, lights, and unforgettable performances.', 'Experience a spectacular night of local and international artists, creative stage design, and unforgettable energy.', 'Army Stadium', 'Dhaka', 14, 1800, 'https://images.unsplash.com/photo-1459749411175-04bf5292ceea?w=1200&q=85'),
('Future Forward Tech Summit', 'technology', 'Ideas and innovation come together.', 'Hear from builders, engineers, and entrepreneurs. Enjoy thoughtful talks, hands-on demos, and networking.', 'BICC Convention Center', 'Dhaka', 28, 2500, 'https://images.unsplash.com/photo-1540575467063-178a50c2df87?w=1200&q=85'),
('Colors of Bangladesh', 'festivals', 'Celebrate art, culture, and community.', 'A colorful celebration of culture with live music, food, performances, and creative activities.', 'City Convention Hall', 'Sylhet', 35, 850, 'https://images.unsplash.com/photo-1492684223066-81342ee5ff30?w=1200&q=85'),
('Live Music Under the Stars', 'music', 'An open-air night of incredible music.', 'Join us for an inspiring open-air evening with fantastic live performances and a welcoming crowd.', 'Open Air Arena', 'Chattogram', 42, 1200, 'https://images.unsplash.com/photo-1501386761578-eac5c94b800a?w=1200&q=85'),
('Champions Sports Night', 'sports', 'Be part of the live sporting atmosphere.', 'Enjoy thrilling live sport and an unforgettable fan experience.', 'Sports Complex', 'Dhaka', 49, 600, 'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?w=1200&q=85'),
('The Creative Arts Expo', 'arts', 'Discover extraordinary creative talent.', 'Explore paintings, contemporary art, installations, and inspiring conversations with artists.', 'National Art Gallery', 'Dhaka', 56, 500, 'https://images.unsplash.com/photo-1579783902614-a3fb3927b6a5?w=1200&q=85'),
]
class Command(BaseCommand):
    help = 'Add sample categories, events and ticket types (safe to run repeatedly).'
    def handle(self, *args, **kwargs):
        from django.utils.text import slugify
        for name, slug, icon in CATS:
            Category.objects.update_or_create(slug=slug, defaults={'name': name, 'icon': icon})
        for name, slug, summary, description, venue, city, days, price, image in EVENTS:
            event, created = Event.objects.get_or_create(slug=slugify(name), defaults={
                'title': name, 'category': Category.objects.get(slug=slug), 'summary': summary,
                'description': description, 'venue': venue, 'city': city,
                'start_at': timezone.now() + timedelta(days=days),
                'end_at': timezone.now() + timedelta(days=days, hours=4),
                'image_url': image, 'featured': True, 'published': True})
            if created:
                TicketType.objects.create(event=event, name='General Admission', price=price, capacity=250)
                TicketType.objects.create(event=event, name='VIP', price=price * 2, capacity=60)
        self.stdout.write(self.style.SUCCESS('Demo events ready.'))
