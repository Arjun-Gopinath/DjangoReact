# Generated by Django 3.1.1 on 2020-10-11 11:41

import django.contrib.postgres.fields
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('backend', '0003_auto_20201009_0941'),
    ]

    operations = [
        migrations.AlterField(
            model_name='header',
            name='icon',
            field=django.contrib.postgres.fields.ArrayField(base_field=models.IntegerField(default=60136), size=None),
        ),
    ]
