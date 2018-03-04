FROM python:3.6

RUN apt-get update && apt-get install -y git supervisor npm && rm -rf /var/lib/apt/lists/*

RUN adduser --gecos "" --disabled-password --home=/home/appuser appuser

RUN mkdir /home/appuser/app

ENV HOME /home/appuser/app

WORKDIR $HOME

RUN git clone https://kujonmobi:BVRzgDUt6UynjMUmXgAx@bitbucket.org/kujonmobi/kujon-server.git .

COPY supervisor/kujon-prod.conf /etc/supervisor/conf.d/

RUN pip install -r requirements.txt

RUN npm install bower -g && ln -s /usr/bin/nodejs /usr/bin/node

WORKDIR $HOME/web/static

RUN bower --allow-root install

RUN chown -R appuser:appuser $HOME

EXPOSE 8000 8002 8004 8005

WORKDIR $HOME

CMD supervisord -c /etc/supervisor/conf.d/kujon-prod.conf
