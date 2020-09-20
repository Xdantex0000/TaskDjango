from django.db import models
import uuid
from enum import Enum

# Create your models here.


class Task(models.Model):
    uuid = models.UUIDField(
        primary_key=True, default=uuid.uuid4, editable=False)
    number = models.IntegerField()
    difficulty = models.ForeignKey('Difficulty', on_delete=models.CASCADE)
    company = models.ForeignKey(
        'Company', on_delete=models.SET_NULL, null=True)
    taskText = models.TextField()

    def __str__(self):
        return f'Task #{self.number}'


class Difficulty(models.Model):
    levelOfDiff = models.CharField(primary_key=True, max_length=20)

    def __str__(self):
        return self.levelOfDiff

    class Meta:
        verbose_name_plural = "Difficulties"


class Company(models.Model):
    name = models.CharField(primary_key=True, max_length=30)

    def __str__(self):
        return self.name

    class Meta:
        verbose_name_plural = "Companies"
