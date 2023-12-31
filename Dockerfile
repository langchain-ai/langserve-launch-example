FROM python:3.11-slim

WORKDIR /app

# First, copy only the files necessary for installing dependencies
COPY pyproject.toml poetry.lock ./

# Install poetry and dependencies
RUN pip install poetry && \
    poetry config virtualenvs.create false && \
    poetry install --no-interaction --no-ansi --only main

# Now, copy the rest of your application code ( split for caching and build speeds )
COPY . .

# Setting the PORT environment variable
ARG PORT=8001
ENV PORT=$PORT

# The command to run your application
CMD exec uvicorn langserve_launch_example.server:app --host 0.0.0.0 --port "$PORT"