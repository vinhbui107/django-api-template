"""config URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.urls import path
from django.conf.urls import include

from apps.example.urls import example_patterns
from apps.utils.health_check import HealthCheckView


urlpatterns_v1 = [
    path('test', include(example_patterns))
]


urlpatterns = [
    path('status', HealthCheckView.as_view()),
    path('v1/', include(urlpatterns_v1))
]
