from django.urls import path
from .views import TaskAPI

urlpatterns = [
    path('task/', TaskAPI.as_view()),
]
