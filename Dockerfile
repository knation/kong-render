# syntax=docker/dockerfile:1.2

FROM kong:2.6.0

# Create directory in which to store kong config
RUN mkdir -p /home/kong/render-config

# Create directory to mount render secrets to
RUN mkdir -p /tmp/render
RUN chmod 777 /tmp/render

USER root

# Copy config files stored in render as secrets
RUN --mount=type=secret,id=kong_config,dst=/tmp/render/kong.config \
    --mount=type=secret,id=cluster_cert,dst=/tmp/render/cluster.cert \
    --mount=type=secret,id=ca_cert,dst=/tmp/render/ca.cert \
    --mount=type=secret,id=cluster_key,dst=/tmp/render/cluster.key \
    cp /tmp/render/* /home/kong/render-config/

# Set config files to read only
RUN chmod 644 /home/kong/render-config/*

USER kong

EXPOSE 8001
EXPOSE 8443

ENTRYPOINT ["kong", "start", "-c", "/home/kong/render-config/kong.config"]
