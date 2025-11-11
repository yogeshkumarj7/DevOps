FROM nginx:stable-alpine

RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/nginx.conf

COPY index.html /usr/share/nginx/html/index.html
COPY page2.html /usr/share/nginx/html/page2.html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
