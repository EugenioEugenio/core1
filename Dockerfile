FROM python:3.13-alpine
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
#COPY run.sh .
RUN sed -i 's/\r$//' run.sh && chmod +x run.sh
EXPOSE 8000
# CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
CMD ["sh", "./run.sh"]
#ENTRYPOINT ["top", "-b"]