# Generated by Django 2.1.1 on 2020-09-26 14:53

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('data', '0012_auto_20200926_1722'),
    ]

    operations = [
        migrations.AlterField(
            model_name='user',
            name='validationString',
            field=models.CharField(blank=True, max_length=4, null=True),
        ),
    ]