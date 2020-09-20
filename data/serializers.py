# i ball wash rot

from rest_framework import serializers
from .models import Task, Company, Difficulty
from .mailparse import MailParse
from task import settings
import re

mailparse = MailParse(settings.EMAIL['EMAIL'], settings.EMAIL["PASSWORD"])


class TaskSerializer(serializers.ModelSerializer):
    class Meta:
        model = Task
        fields = '__all__'

    @staticmethod
    def uploadAllMessages():
        Task.objects.all().delete()
        Difficulty.objects.all().delete()
        Company.objects.all().delete()

        messages = mailparse.getAllMessages()
        TaskSerializer.uploadData(messages)

    @staticmethod
    def uploadUnreadMessages():
        messages = mailparse.getUnreadMessages()
        TaskSerializer.uploadData(messages)

    @staticmethod
    def uploadData(messages):
        addedTasks = 0
        for message in messages:
            if re.search(r'Daily Coding Problem: Problem #', message[1]) != None:
                taskDictionary = {}
                regularResult = re.split(r'\s', re.split(
                    r'Daily Coding Problem: Problem #', message[1])[1])
                taskDictionary['Number'] = regularResult[0]
                taskDictionary['Difficulty'] = regularResult[1].replace(
                    '[', '').replace(']', '')

                otherContent = ''.join(
                    elem for elem in message[2:]).replace('=\n', ' ')
                if re.search(r'asked\s+by\s+', otherContent) != None:
                    otherContent = otherContent[re.search(
                        r'asked\s+by\s+', otherContent).end():]
                    taskDictionary['Company'] = re.search(
                        r'\w+', otherContent).group(0)
                elif re.search(r'asked\s+', otherContent) != None:
                    otherContent = otherContent[re.search(
                        r'asked\s+', otherContent).end():]
                    taskDictionary['Company'] = re.search(
                        r'\w+', otherContent).group(0)
                else:
                    taskDictionary['Company'] = 'No Company'
                otherContent = otherContent[re.search(
                    r'\w+', otherContent).end():]
                otherContent = otherContent[re.search(
                    r'^.', otherContent).end():]
                otherContent = otherContent[:re.search(
                    r'Upgrade\s+to\s+premium', otherContent).start()]
                taskDictionary['Text'] = otherContent
                try:
                    Difficulty.objects.get(
                        levelOfDiff=taskDictionary['Difficulty'])
                except Difficulty.DoesNotExist:
                    Difficulty.objects.create(
                        levelOfDiff=taskDictionary['Difficulty'])
                try:
                    Company.objects.get(
                        name=taskDictionary['Company'])
                except Company.DoesNotExist:
                    Company.objects.create(
                        name=taskDictionary['Company'])
                try:
                    Task.objects.get(
                        number=taskDictionary['Number'])
                except Task.DoesNotExist:
                    Task.objects.create(number=taskDictionary['Number'], difficulty=Difficulty.objects.get(
                        levelOfDiff=taskDictionary['Difficulty']), company=Company.objects.get(name=taskDictionary['Company']), taskText=taskDictionary['Text'])
                    addedTasks += 1
        print(f'Added {addedTasks} tasks')
