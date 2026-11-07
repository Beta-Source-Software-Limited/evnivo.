from django.contrib import admin
from .models import Category, Event, TicketType, Booking, Ticket

@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    list_display = ('name', 'slug', 'icon')
    prepopulated_fields = {'slug': ('name',)}

class TicketTypeInline(admin.TabularInline):
    model = TicketType
    extra = 1
    readonly_fields = ('sold',)

@admin.register(Event)
class EventAdmin(admin.ModelAdmin):
    list_display = ('title', 'category', 'city', 'start_at', 'published', 'featured')
    list_filter = ('published', 'featured', 'category', 'city')
    search_fields = ('title', 'venue', 'city')
    prepopulated_fields = {'slug': ('title',)}
    inlines = [TicketTypeInline]

class TicketInline(admin.TabularInline):
    model = Ticket
    extra = 0
    can_delete = False
    readonly_fields = ('code', 'checked_in_at')

@admin.register(Booking)
class BookingAdmin(admin.ModelAdmin):
    list_display = ('reference', 'user', 'event', 'quantity', 'total', 'status', 'created_at')
    list_filter = ('status', 'event')
    search_fields = ('reference', 'user__username', 'user__email')
    readonly_fields = ('reference', 'user', 'event', 'ticket_type', 'quantity', 'total', 'created_at')
    inlines = [TicketInline]
    def has_add_permission(self, request): return False
    def has_delete_permission(self, request, obj=None): return False

@admin.register(Ticket)
class TicketAdmin(admin.ModelAdmin):
    list_display = ('code', 'booking', 'checked_in_at')
    search_fields = ('code',)
    readonly_fields = ('code', 'booking')
    def has_add_permission(self, request): return False
