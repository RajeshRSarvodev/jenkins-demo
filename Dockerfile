FROM nginx:alpine

COPY build/app.txt /usr/share/nginx/html/app.txt