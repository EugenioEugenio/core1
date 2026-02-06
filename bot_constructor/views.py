from django.shortcuts import render

# Create your views here.
import openai
from rest_framework import viewsets, status
from rest_framework.decorators import action
from rest_framework.response import Response
from .models import Bot, Scenario, Step
from .serializers import BotSerializer, ScenarioSerializer, StepSerializer


class BotViewSet(viewsets.ModelViewSet):
    queryset = Bot.objects.all()
    serializer_class = BotSerializer

    import openai
    from rest_framework.response import Response

    # ... внутри BotViewSet ...

    @action(detail=True, methods=['post'])
    def chat(self, request, pk=None):
        bot = self.get_object()
        user_message = request.data.get("message", "")

        # 1. Получаем сценарий и шаг (как мы писали ранее)
        scenario = bot.scenarios.filter(is_active=True).first()
        if not scenario:
            return Response({"error": "У этого бота нет активных сценариев"}, status=400)

        step = scenario.steps.first()

        # 2. Попытка запроса к OpenAI
        try:
            client = openai.OpenAI(api_key=bot.api_key)
            response = client.chat.completions.create(
                model=step.config.get("model", "gpt-3.5-turbo"),
                messages=[
                    {"role": "system", "content": step.system_prompt},
                    {"role": "user", "content": user_message}
                ],
                timeout=10  # Чтобы сервер не завис, если OpenAI тормозит
            )
            answer = response.choices.message.content
            return Response({"answer": answer, "step_id": step.id})

        except openai.RateLimitError:
            return Response({
                "error": "Ошибка 429: Лимиты OpenAI исчерпаны. Проверьте баланс в личном кабинете OpenAI."
            }, status=429)
        except Exception as e:
            return Response({"error": f"Произошла ошибка: {str(e)}"}, status=500)





#    @action(detail=True, methods=['post'])
#     def chat(self, request, pk=None):
#     # Просто возвращаем текст без вызова OpenAI
#        user_message = request.data.get("message", "пусто")
#        return Response({
#            "answer": f"Бот получил ваше сообщение: {user_message}",
#            "status": "success"
#        })


class ScenarioViewSet(viewsets.ModelViewSet):
    queryset = Scenario.objects.all()
    serializer_class = ScenarioSerializer


class StepViewSet(viewsets.ModelViewSet):
    queryset = Step.objects.all()
    serializer_class = StepSerializer
