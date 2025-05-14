ARG PYTHON_VERSION=3.13

FROM python:${PYTHON_VERSION}-slim-bookworm AS build
ARG PYTHON_VERSION
ARG USERNAME=developer
ARG USER_UID=1000
ARG USER_GID=$USER_UID
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME
USER $USERNAME
WORKDIR /usr/src/app
COPY . .
RUN pip install --no-cache-dir -r requirements.txt
ENV PATH=/home/$USERNAME/.local/bin:$PATH
EXPOSE 5000
ENTRYPOINT ["gunicorn"]
CMD [ "-w", "4", "app:app", "-b", "0.0.0.0:8080" ]

LABEL version="1.3"
LABEL description="A container for a simple flask web application."

HEALTHCHECK --interval=10m --timeout=5s CMD curl -f http://127.0.0.1:8080/ || exit 1
