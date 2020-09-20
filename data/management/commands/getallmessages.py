from django.core.management.base import BaseCommand, CommandError
from data.serializers import TaskSerializer
import argparse


class Command(BaseCommand):
    help = "Help text"

    def handle(self, *args, **options):
        TaskSerializer.uploadAllMessages()
