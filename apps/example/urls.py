from django.urls import path
from apps.example.views import Test

example_patterns = [
    path('', Test.as_view())
]
