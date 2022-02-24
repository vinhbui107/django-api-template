FROM python:3.8-slim

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

RUN apt-get update \
  && apt-get install -y --no-install-recommends build-essential libpq-dev \
  && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt \
    && rm -rf /tmp/requirements.txt \

WORKDIR /user/src/app
COPY manage.py /
COPY config /config
COPY apps /apps
COPY docker/entrypoint.sh /
COPY docker/start.sh /
RUN chmod +x /*.sh

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/start.sh", "server" ]
