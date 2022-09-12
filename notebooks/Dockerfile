FROM python:3.8.13-slim-bullseye AS base

ENV APP_HOME="/app" \
    POETRY_HOME=/opt/poetry \
    POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_CREATE=true \
    POETRY_VIRTUALENVS_IN_PROJECT=true \
    VENV_PATH=/app/.venv

ENV PATH="${POETRY_HOME}/bin:${PATH}"
ENV PATH="${VENV_PATH}/bin:${PATH}"

# ----- build -----
FROM base AS build

RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    curl \
    gcc \
    python3-dev \
    && curl -sSL 'https://install.python-poetry.org' | python3 - --version 1.1.11 \
    && poetry --version

# ----- development -----
FROM build AS development

WORKDIR ${APP_HOME}

COPY --from=build ${POETRY_HOME}    ${POETRY_HOME}
COPY pyproject.toml ${APP_HOME}
COPY poetry.lock ${APP_HOME}

RUN set -ex \
    && mkdir src \
    && touch src/__init__.py \
    && poetry install

EXPOSE 8888

CMD [ "poetry", "run", "jupyter", "notebook", "--allow-root", "--ip=0.0.0.0" ]
