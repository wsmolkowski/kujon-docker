FROM nginx:latest
COPY nginx.conf /etc/nginx/nginx.conf
COPY ssl/kujon.mobi.withintermediate20180323.crt /etc/ssl/
COPY ssl/kujon.mobi.key /etc/ssl/
COPY dhparam.pem /etc/ssl/
EXPOSE 80 443
