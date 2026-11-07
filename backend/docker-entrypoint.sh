#!/bin/sh
set -eu

# This starter currently has no checked-in model migration; generate it on first boot.
# For a production deployment, commit reviewed migration files to Git.
python manage.py makemigrations events --noinput
python manage.py migrate --noinput
python manage.py seed_demo
python manage.py collectstatic --noinput
exec gunicorn config.wsgi:application --bind 0.0.0.0:8000 --workers 2 --access-logfile -
