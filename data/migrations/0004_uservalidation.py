# Generated by Django 2.1.1 on 2020-09-25 14:22

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('data', '0003_auto_20200920_1430'),
    ]

    operations = [
        migrations.CreateModel(
            name='UserValidation',
            fields=[
                ('username', models.CharField(max_length=30, primary_key=True, serialize=False)),
                ('password', models.TextField()),
                ('email', models.TextField()),
                ('validationString', models.CharField(max_length=4)),
            ],
        ),
    ]
