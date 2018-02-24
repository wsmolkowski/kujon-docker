FROM nginx:1.13.9
COPY nginx.conf /etc/nginx/nginx.conf
COPY ../ssl/kujon.mobi.cert.2018 /etc/ssl/
COPY ../ssl/kujon.mobi.key /etc/ssl/
COPY dhparam.pem /etc/ssl/
EXPOSE 80 443
