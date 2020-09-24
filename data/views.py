from rest_framework.response import Response
from rest_framework import generics
from .models import Task, Company, Solution, Difficulty
from .serializers import TaskSerializer, CompanySerializer, SolutionSerializer, MyTokenObtainPairSerializer, RegisterSerializer
from rest_framework.permissions import IsAuthenticated
import json
from rest_framework_simplejwt.views import TokenObtainPairView
from django.contrib.auth.models import User

# Create your views here.


class RegisterAPI(generics.GenericAPIView):
    serializer_class = RegisterSerializer
    queryset = User.objects.all()

    def post(self, request):
        serializer = self.get_serializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
        return Response({'status': '200', 'message': serializer.data}, status=200)


class TaskAPI(generics.GenericAPIView):
    serializer_class = TaskSerializer
    queryset = Task.objects.all()

    def get(self, request):
        if 'type' in request.GET:
            if request.GET['type'] == 'unread':
                return Response({'status': 'OK', 'message': self.get_serializer().uploadUnreadMessages()}, status=200)
        elif 'company' in request.GET:
            if 'difficulty' in request.GET:
                try:
                    receivedDifficulty = Difficulty.objects.get(
                        levelOfDiff=request.GET['difficulty'])
                    receivedCompany = Company.objects.get(
                        name=request.GET['company'])
                    return Response(self.get_serializer(self.get_queryset().filter(difficulty=receivedDifficulty.levelOfDiff, company=receivedCompany.name), many=True).data, status=200)
                except Difficulty.DoesNotExist:
                    return Response({'status': '404', 'message': 'Difficulty does not exist'}, status=404)
                except Company.DoesNotExist:
                    return Response({'status': '404', 'message': 'Company does not exist'}, status=404)
            else:
                try:
                    receivedCompany = Company.objects.get(
                        name=request.GET['company'])
                    return Response(self.get_serializer(self.get_queryset().filter(company=receivedCompany.name), many=True).data, status=200)
                except Company.DoesNotExist:
                    return Response({'status': '404', 'message': 'Company does not exist'}, status=404)
        else:
            return Response({'status': '404', 'message': 'Something went wrong'}, status=404)


class CompanyAPI(generics.GenericAPIView):
    serializer_class = CompanySerializer
    queryset = Company.objects.all()

    def get(self, request):
        return Response(self.get_serializer(self.get_queryset(), many=True).data, status=200)


class SolutionAPI(generics.GenericAPIView):
    serializer_class = SolutionSerializer
    queryset = Solution.objects.all()
    permission_classes = [IsAuthenticated]

    def get(self, request):
        return Response(self.get_serializer(self.get_queryset(), many=True).data, status=200)

    def post(self, request):
        jsonText = json.loads(request.body)
        jsonText.update({'user': request.user.id})
        serializer = self.get_serializer(data=jsonText)
        if serializer.is_valid():
            serializer.save()
        return Response({'status': '200', 'message': serializer.data}, status=200)


class MyTokenObtainPairView(TokenObtainPairView):
    serializer_class = MyTokenObtainPairSerializer
