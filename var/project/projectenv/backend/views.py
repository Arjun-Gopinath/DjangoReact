from django.shortcuts import render, redirect
from .models import Header
from .serializers import HeaderSerializer
from rest_framework import permissions, viewsets, generics, status
from rest_framework.response import Response
from django.views.decorators.csrf import csrf_exempt, ensure_csrf_cookie

from django.http.response import JsonResponse
from rest_framework.parsers import JSONParser
from rest_framework.decorators import api_view

# Header View


def index(request, format=None):
    header_obj = Header.objects.get(pk=1)
    context = {
        "headers": header_obj,
    }
    return render(request, "index.html", context)

# Update view


@ensure_csrf_cookie
def update_new(request, pk, format=None):
    try:
        header = Header.objects.get(pk=pk)
    except header.DoesNotExist:
        return JsonResponse({'message': 'No data'}, status=status.HTTP_404_NOT_FOUND)

    if request.method == 'PUT':
        header_data = JSONParser().parse(request)
        header_serializer = HeaderSerializer(header, data=header_data)
        if header_serializer.is_valid():
            header_serializer.save()
            return JsonResponse(header_serializer.data)
        return JsonResponse(header_serializer.errors, status=status.HTTP_400_BAD_REQUEST)

# API Header Instance View


@api_view(['GET', 'PUT', 'DELETE'])
@ensure_csrf_cookie
def header_detail(request, pk, format=None):

    try:
        header = Header.objects.get(pk=pk)
    except header.DoesNotExist:
        return JsonResponse({'message': 'No data'}, status=status.HTTP_404_NOT_FOUND)

    if request.method == 'GET':
        header_serializer = HeaderSerializer(header)
        return JsonResponse(header_serializer.data)

    elif request.method == 'PUT':
        header_data = JSONParser().parse(request)
        header_serializer = HeaderSerializer(header, data=header_data)
        if header_serializer.is_valid():
            header_serializer.save()
            return JsonResponse(header_serializer.data)
        return JsonResponse(header_serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    elif request.method == 'DELETE':
        header.delete()
        return JsonResponse({'message': 'Header was deleted successfully!'}, status=status.HTTP_204_NO_CONTENT)
