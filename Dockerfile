# Use Ubuntu base image
FROM ubuntu:22.04 AS base

# Metadata
LABEL maintainer="ubuntuuser"
LABEL description="Hardened Ubuntu container image"

# Ensure non-interactive
ENV DEBIAN_FRONTEND=noninteractive

# 1. Update package lists and install minimal dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       ca-certificates \
       curl \
       # Possibly other packages your app needs
    && rm -rf /var/lib/apt/lists/*

# Remove or lock down any default setuid binaries not needed

RUN apt-get purge -y iputils-ping \
    && chmod 755 /bin/ping

# Create non-root user and group
ARG USER_NAME=ubuntuuser
ARG USER_UID=1000
ARG USER_GID=1000

RUN groupadd --gid $USER_GID $USER_NAME \
    && useradd --uid $USER_UID --gid $USER_GID --shell /bin/bash --create-home $USER_NAME

#  Copy entrypoint script (optional)
COPY scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

#  Switch to the new non-root user
USER $USER_UID:$USER_GID

#  Set working directory
WORKDIR /home/$USER_NAME

#  Run an empty CMD, or specify entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/bin/bash"]
