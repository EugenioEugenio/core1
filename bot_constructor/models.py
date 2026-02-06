from django.db import models

# Create your models here.


class Bot(models.Model):
    name = models.CharField(max_length=255)
    api_key = models.CharField(max_length=255)  # Ключ OpenAI
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.name

class Scenario(models.Model):
    bot = models.ForeignKey(Bot, related_name='scenarios', on_delete=models.CASCADE)
    title = models.CharField(max_length=255)
    is_active = models.BooleanField(default=True)

    def __str__(self):
        return f"{self.title} (Bot: {self.bot.name})"

class Step(models.Model):
    scenario = models.ForeignKey(Scenario, related_name='steps', on_delete=models.CASCADE)
    order = models.PositiveIntegerField(default=0)
    system_prompt = models.TextField(help_text="Инструкция для GPT")
    config = models.JSONField(default=dict, blank=True, help_text="Параметры: model, temperature и т.д.")

    class Meta:
        ordering = ['order']

    def __str__(self):
        return f"Step {self.order} for {self.scenario.title}"
