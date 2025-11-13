# web-frontend/Dockerfile
FROM nginx:stable-alpine
LABEL maintainer="yogeshkumar@example.com"
COPY nginx.conf /etc/nginx/nginx.conf
COPY . /usr/share/nginx/html
EXPOSE 80
HEALTHCHECK --interval=10s --timeout=2s --start-period=5s \
  CMD wget -q -O- http://localhost/healthz || exit 1

