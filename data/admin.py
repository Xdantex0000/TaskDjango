from django.contrib import admin
from .models import Task, Difficulty, Company, Solution
from .serializers import TaskSerializer
from .filter import TaskDifficultyListFilter, TaskCompanyListFilter

# Register your models here.

class TaskAdmin(admin.ModelAdmin):
    ordering = ('number',)
    change_list_template = "admin/template.html"
    list_filter = (TaskDifficultyListFilter,TaskCompanyListFilter,)


admin.site.register(Task, TaskAdmin)
admin.site.register(Difficulty)
admin.site.register(Company)
admin.site.register(Solution)
