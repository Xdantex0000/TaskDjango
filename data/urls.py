from django.urls import path
from .views import TaskAPI, CompanyAPI, SolutionAPI, MyTokenObtainPairView, RegisterAPI, UserAPI
from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    TokenRefreshView,
    TokenVerifyView,
)

urlpatterns = [
    path('task/', TaskAPI.as_view()),
    path('register/', RegisterAPI.as_view()),
    path('userData/', UserAPI.as_view()),
    path('company/', CompanyAPI.as_view()),
    path('solution/', SolutionAPI.as_view()),
    path('token/', MyTokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('token/verify/', TokenVerifyView.as_view(), name='token_verify'),
]
