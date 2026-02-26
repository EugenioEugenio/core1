#!/usr/bin/env sh
#
#python manage.py migrate --noinput
#DJANGO_SUPERUSER_USERNAME="kroot" \
#DJANGO_SUPERUSER_PASSWORD="1234" \
#DJANGO_SUPERUSER_EMAIL="kroot@kroot.es" \
#python manage.py createsuperuser --noinput # ||tru
##python manage.py createsuperuser --noinput || echo "User already exists"
#python manage.py runserver --noreload 0.0.0.0:8000



#python manage.py migrate --noinput
#
# Создаем, если нет. Если есть — идем дальше.
#DJANGO_SUPERUSER_USERNAME="kroot" \
#DJANGO_SUPERUSER_PASSWORD="1234" \
#DJANGO_SUPERUSER_EMAIL="kroot@kroot.es" \
#python manage.py createsuperuser --noinput || echo "User already exists"
#
# Гарантированно обновляем пароль (на случай если юзер был создан криво)
#python manage.py shell -c "from django.contrib.auth import get_user_model; User = get_user_model(); u = User.objects.get(username='kroot'); u.set_password('1234'); u.save()"
#
#python manage.py runserver --noreload 0.0.0.0:8000
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#!/usr/bin/env sh

## 1. Применяем миграции (теперь автоматически при старте)
#echo "Applying migrations..."
#python manage.py migrate --noinput
#
## 2. Создаем суперпользователя (игнорируем ошибку, если он уже есть)
#echo "Creating superuser..."
#python manage.py createsuperuser \
#    --noinput \
#    --username admin \
#    --email admin@example.com \
#    || echo "Superuser already exists."
#
## 3. Устанавливаем пароль (так как --noinput не ставит пароль в старых версиях)
## Или используйте DJANGO_SUPERUSER_PASSWORD в окружении
#python manage.py shell -c "from django.contrib.auth import get_user_model; User = get_user_model(); u = User.objects.filter(username='root').first(); u.set_password('123'); u.save()"
#
## 4. Запускаем сервер
#echo "Starting server..."
#python manage.py runserver 0.0.0.0:8000


#!/usr/bin/env sh

python manage.py migrate --noinput

# Django сам подхватит переменные DJANGO_SUPERUSER_...
python manage.py createsuperuser --noinput || echo "Superuser already exists"

python manage.py runserver 0.0.0.0:8000
