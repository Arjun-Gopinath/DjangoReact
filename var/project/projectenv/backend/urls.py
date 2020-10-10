from django.urls import path
from . import views
from .api import HeaderViewSet
from rest_framework import routers
from django.conf.urls import url

router = routers.DefaultRouter()
router.register('api/headers', HeaderViewSet)  # API HeaderView
router.register('new', HeaderViewSet)  # Update view

urlpatterns = [
    path('', views.index, name="headers"),  # Header view
    path('api/headers/<int:pk>', views.header_detail),  # Api Header Instance
    path('new/<int:pk>', views.update_new)  # Update view
]

urlpatterns += router.urls
