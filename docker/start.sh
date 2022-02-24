#!/bin/bash

cd /user/src/app

if [ $# -eq 0 ]; then
  echo "Usage: start.sh [PROCESS_TYPE](server)"
  exit 1
fi

PROCESS_TYPE=$1

if [ "$PROCESS_TYPE" = "server" ]; then
  gunicorn \
    --reload \
    --bind 0.0.0.0:8000 \
    --workers "$WORKERS" \
    --timeout 120 \
    --log-level INFO \
    --access-logfile "-" \
    --error-logfile "-" \
    config.wsgi:application
elif [ "$PROCESS_TYPE" = "worker" ]; then
  celery -A config.celery_app worker -l INFO
fi
