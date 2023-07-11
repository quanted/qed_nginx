# uses debian stertch-slim
# https://github.com/nginxinc/docker-nginx/blob/master/stable/stretch/Dockerfile
# FROM nginx:stable
FROM nginx:stable-alpine

# Remove default configuration from Nginx
RUN rm /etc/nginx/conf.d/default.conf

ARG config=nginx.conf

# Overwrite the NGINX conf
COPY $config /etc/nginx/conf.d/

# Copies cyanweb angular content to /usr/share/nginx/html/cyanweb:
COPY --from=ghcr.io/usepa/cyanweb-angular:dev /app/dist /usr/share/nginx/html

# Copies HMS webapp angular content to /usr/share/nginx/html/hms/webapp:
COPY --from=ghcr.io/quanted/hms-webapp:dev /app/dist /usr/share/nginx/html
