# config/celery.py
import os
from celery import Celery

# Set default Django settings module
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "config.settings")

app = Celery("upworkreview")

# Load Celery config from Django settings using namespace
app.config_from_object("django.conf:settings", namespace="CELERY")

# Auto-discover tasks across installed apps
app.autodiscover_tasks()

@app.task(bind=True)
def debug_task(self):
    print(f"Request: {self.request!r}")
