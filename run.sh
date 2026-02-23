#!/usr/bin/env sh
#
#python manage.py migrate --noinput
#DJANGO_SUPERUSER_USERNAME="kroot" \
#DJANGO_SUPERUSER_PASSWORD="1234" \
#DJANGO_SUPERUSER_EMAIL="kroot@kroot.es" \
#python manage.py createsuperuser --noinput # ||tru
##python manage.py createsuperuser --noinput || echo "User already exists"
#python manage.py runserver --noreload 0.0.0.0:8000



python manage.py migrate --noinput

# Создаем, если нет. Если есть — идем дальше.
DJANGO_SUPERUSER_USERNAME="kroot" \
DJANGO_SUPERUSER_PASSWORD="1234" \
DJANGO_SUPERUSER_EMAIL="kroot@kroot.es" \
python manage.py createsuperuser --noinput || echo "User already exists"

# Гарантированно обновляем пароль (на случай если юзер был создан криво)
python manage.py shell -c "from django.contrib.auth import get_user_model; User = get_user_model(); u = User.objects.get(username='kroot'); u.set_password('1234'); u.save()"

python manage.py runserver --noreload 0.0.0.0:8000
