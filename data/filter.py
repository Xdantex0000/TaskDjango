from datetime import date

from .models import Company
from django.contrib import admin
from django.utils.translation import gettext_lazy as _

class TaskDifficultyListFilter(admin.SimpleListFilter):
    title = 'Task difficulty'
    parameter_name = 'difficulty'
    
    def lookups(self, request, model_admin):
        return (
            ('easy', 'Easy'),
            ('medium', 'Medium'),
            ('hard', 'Hard'),
        )

    def queryset(self, request, queryset):
        if self.value() == 'easy':
            return queryset.filter(difficulty='Easy')
        if self.value() == 'medium':
            return queryset.filter(difficulty='Medium')
        if self.value() == 'hard':
            return queryset.filter(difficulty='Hard')

class TaskCompanyListFilter(admin.SimpleListFilter):
    title = 'Task company'
    parameter_name = 'company'
    
    def lookups(self, request, model_admin):
        returning_tuple = ()
        for company in Company.objects.all().order_by('name'):
            returning_tuple += ((company.name.lower(), company.name),)
        return returning_tuple

    def queryset(self, request, queryset):
        for company in Company.objects.all():
            if self.value() == company.name.lower():
                return queryset.filter(company=company)