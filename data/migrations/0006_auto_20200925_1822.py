# Generated by Django 2.1.1 on 2020-09-25 15:22

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('admin', '0003_logentry_add_action_flag_choices'),
        ('data', '0005_auto_20200925_1821'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='user',
            name='user_ptr',
        ),
        migrations.DeleteModel(
            name='User',
        ),
    ]
