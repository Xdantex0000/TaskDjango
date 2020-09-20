from rest_framework.response import Response
from rest_framework import generics
from .models import Task
from .serializers import TaskSerializer

# Create your views here.


class TaskAPI(generics.GenericAPIView):
    serializer_class = TaskSerializer
    queryset = Task.objects.all()

    def get(self, request):
        return Response(self.get_serializer(self.get_queryset(), many=True).data, status=200)
