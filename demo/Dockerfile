FROM python:3.6

RUN apt-get update && apt-get install -y git supervisor npm && rm -rf /var/lib/apt/lists/*

RUN adduser --gecos "" --disabled-password --home=/home/demo demo

RUN mkdir /home/demo/app

ENV HOME /home/demo/app

WORKDIR $HOME

RUN git clone -b development https://kujonmobi:BVRzgDUt6UynjMUmXgAx@bitbucket.org/kujonmobi/kujon-server.git .

RUN cp config/ssl/* /etc/ssl/

RUN cp config/supervisor/conf.d/kujon-demo.conf /etc/supervisor/conf.d/ && cp config/supervisor/supervisord.conf /etc/supervisor/

RUN pip install -r requirements.txt

RUN npm install bower -g && ln -s /usr/bin/nodejs /usr/bin/node

WORKDIR $HOME/web/static

RUN bower --allow-root install

RUN chown -R demo:demo $HOME

EXPOSE 9000 9002 9004 9005

CMD supervisord -c /etc/supervisor/supervisord.conf
