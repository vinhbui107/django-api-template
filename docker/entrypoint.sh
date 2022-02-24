#!/bin/bash

# Bash options
set -o errexit
set -o pipefail
set -o nounset

# Health of dependent services
postgres_ready() {
  python <<END
import sys
from psycopg2 import connect
from psycopg2.errors import OperationalError
try:
    connect(
        dbname="${DB_NAME}",
        user="${DB_USERNAME}",
        password="${DB_PASSWORD}",
        host="${DB_HOST}",
        port="${DB_PORT}",
    )
except OperationalError:
    sys.exit(-1)
END
}

redis_ready() {
  python <<END
import sys
from redis import Redis
from redis import RedisError
try:
    redis = Redis.from_url("${CELERY_BROKER_URL}", db=0)
    redis.ping()
except RedisError:
    sys.exit(-1)
END
}

until postgres_ready; do
  echo >&2 "Waiting for PostgreSQL to become available..."
  sleep 5
done
echo >&2 "PostgreSQL is available"

until redis_ready; do
  echo >&2 "Waiting for Redis to become available..."
  sleep 5
done
echo >&2 "Redis is available"

# Idempotent Django commands
python manage.py collectstatic --noinput
python manage.py makemigrations
python manage.py migrate
exec "$@"
