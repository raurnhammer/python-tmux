FROM python:3.11.11-bookworm

ARG UID=1000
ARG GID=1000

# Set the working directory in the container
WORKDIR /app

# Create a non-root user and group with specific IDs
RUN groupadd -g $GID appgroup && useradd -u $UID -g $GID -s /bin/bash -m appuser

USER $UID

CMD ["/bin/sh", "-c", "--", "while true; do sleep 30; done;"]
