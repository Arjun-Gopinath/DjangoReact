from .models import Header
from rest_framework import viewsets, permissions, generics
from .serializers import HeaderSerializer


class HeaderViewSet(viewsets.ModelViewSet):
    queryset = Header.objects.all()
    permission_classes = [
        permissions.AllowAny
    ]
    serializer_class = HeaderSerializer
