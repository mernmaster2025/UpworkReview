#!/bin/sh

echo "Waiting for MySQL... $MYSQL_HOST $MYSQL_USER $MYSQL_PASSWORD"
sleep 10

# Wait for MySQL to be ready
# until mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p "$MYSQL_PASSWORD" -e "SELECT 1;" > /dev/null 2>&1
# do
#   echo "MySQL is unavailable - sleeping"
#   sleep 3
# done

echo "MySQL is up - running Django setup"

# Django commands AFTER MySQL is ready
python manage.py collectstatic --noinput
python manage.py makemigrations
python manage.py migrate

# Start Gunicorn
exec gunicorn --reload --config gunicorn-cfg.py config.wsgi
