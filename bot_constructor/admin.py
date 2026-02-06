from django.contrib import admin

# Register your models here.

from .models import Bot, Scenario, Step

class StepInline(admin.TabularInline):
    model = Step
    extra = 1

@admin.register(Scenario)
class ScenarioAdmin(admin.ModelAdmin):
    inlines = [StepInline]

admin.site.register(Bot)
