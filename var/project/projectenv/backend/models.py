from django.db import models
from django.contrib.postgres.fields import ArrayField


class Header(models.Model):
    title = ArrayField(models.TextField(default="Title"))

    pos = models.TextField(max_length=5, default="left")

    icon = ArrayField(models.TextField(default="backup"))

    colour = models.CharField(max_length=7, default="#000000")

    text = ArrayField(models.TextField(default="text"))
