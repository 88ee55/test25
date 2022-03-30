FROM nginxinc/nginx-unprivileged:1.20-alpine

COPY config.conf /etc/nginx/conf.d/
COPY index.html /usr/share/nginx/html/
