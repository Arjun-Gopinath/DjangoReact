from rest_framework import serializers
from .models import Header


class HeaderSerializer(serializers.ModelSerializer):
    class Meta:
        model = Header
        fields = ('title', 'pos', 'icon', 'colour', 'text')

    def create(self, validated_data):

        return Header.objects.create(**validated_data)

    def update(self, instance, validated_data):

        instance.title = validated_data.get('title', instance.title)
        instance.pos = validated_data.get('pos', instance.pos)
        instance.icon = validated_data.get('icon', instance.icon)
        instance.colour = validated_data.get('colour', instance.colour)
        instance.text = validated_data.get('text', instance.text)
        instance.save()
        return instance
