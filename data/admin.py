from django.contrib import admin
from .models import Task, Difficulty, Company
from .serializers import TaskSerializer

# Register your models here.


def readAllUnread():
    TaskSerializer.uploadUnreadMessages


readAllUnread.short_description = 'Read all unread messages'


class TaskAdmin(admin.ModelAdmin):
    actions = [readAllUnread]


admin.site.register(Task, TaskAdmin)
admin.site.register(Difficulty)
admin.site.register(Company)
