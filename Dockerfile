# Use Ubuntu base image
FROM ubuntu:22.04 AS base

# Metadata
LABEL maintainer="me"
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

# 2. Remove or lock down any default setuid binaries not needed
# Example: if we know we don't need ping (part of iputils-ping),
# we can remove or set permissions to remove SUID bits
RUN chmod -s /bin/ping

# 3. Create non-root user and group
ARG USER_NAME=ubuntuuser
ARG USER_UID=1000
ARG USER_GID=1000

RUN groupadd --gid $USER_GID $USER_NAME \
    && useradd --uid $USER_UID --gid $USER_GID --shell /bin/bash --create-home $USER_NAME

# 4. Copy entrypoint script (optional)
COPY scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# 5. Switch to the new non-root user
USER $USER_UID:$USER_GID

# 6. Set working directory
WORKDIR /home/$USER_NAME

# 7. Run an empty CMD, or specify entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/bin/bash"]
