# kong-render
Kong docker image wrapped for deployment on Render.

## Create kong.conf

Create a local `kong.conf` file (do not check this into git) and include the necessary configuration (e.g., what's provided by Kong Cloud Konnect).

If you're referencing any other files, such as data plane certificates, use the path `/home/kong/render-config/` (e.g., `/home/kong/render-config/cluster.cert`).

## Create web service

Create a new web service on Render, pointing to this repository. Leave settings to their defaults.

## Add secrets to Render

Add all secret files to Render. The following file names are supported:
- `kong.conf` (required)
- `cluster.key`
- `cluster.cert`
- `ca.cert`

## How it works

Render will build from the instructions in `Dockerfile`, which pulls the kong image, copies in the secret files, and sets the entry point. All secrets (including `kong.conf`) will live in `/home/kong/render-config/` within the image. The entrypoint is configured to look there for the config file by default.

## Ports

By default, only ports `8001` and `8443` are exposed from the Docker image for web traffic. If you need to expose more (such as for the Admin API), fork this repository and modify `Dockerfile` accordingly.

## Future Improvements

1. Configurable health check route
2. Don't store configuration and certificates in the Docker image.
3. Configure which ports are exposed from Docker image.
