FROM python:3.11-slim

WORKDIR /app

COPY . /app

ARG PORT
ENV PORT=$PORT

RUN pip install poetry && \
  poetry config virtualenvs.create false && \
  poetry install --no-interaction --no-ansi --only main

CMD exec uvicorn langserve_launch_example.server:app --host 0.0.0.0 --port $PORT
