from django.urls import path
from . import views
urlpatterns = [
    path('categories/', views.CategoryList.as_view()),
    path('events/', views.EventList.as_view()),
    path('events/<slug:slug>/', views.EventDetail.as_view()),
    path('auth/register/', views.register),
    path('auth/login/', views.login),
    path('auth/me/', views.current_user),
    path('bookings/', views.bookings),
    path('tickets/<uuid:code>/qr/', views.ticket_qr),
]
