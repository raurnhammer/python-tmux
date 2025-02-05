FROM python:3.11.11-bookworm

ARG UID=1000
ARG GID=1000

# Set the working directory in the container
WORKDIR /app

RUN apt update && apt install -y tmux curl
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz \
    && rm -rf /opt/nvim || true \
    && tar -C /opt -xzf nvim-linux-x86_64.tar.gz
# Create a non-root user and group with specific IDs
RUN groupadd -g $GID appgroup && useradd -u $UID -g $GID -s /bin/bash -m appuser
RUN echo 'export PATH=$PATH:/opt/nvim-linux-x86_64/bin' >> /home/appuser/.bashrc

USER $UID

RUN pip install pandas boto3 pyarrow s3fs

CMD ["/bin/sh", "-c", "--", "while true; do sleep 30; done;"]
