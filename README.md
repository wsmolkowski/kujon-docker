# how to build image

docker build --build-arg git_username=USERNAME --build-arg git_password=PASS--no-cache=true -t image:kujon-demo .

# how to run image

docker container run --publish 9000:9000 --publish 9002:9002 --publish 9004:9004 --publish 9005:9005 --name kujon-demo kujon/kujon-demo

# how to start image


#mongo create admin
db.createUser( {
     user: "admin",
     pwd: "jfh472837r61HdgFd",
     roles: [ { role: "userAdminAnyDatabase", db: "admin" } ]
   });
# mongo demo create db
  db.createUser({ user: 'kujprod', pwd: '4567GhdF13Kd', roles: [ { role: "dbAdmin", db: "kuj-prod" } ] });
  db.createUser({ user: 'kujdemo', pwd: 'jsH28s3284sh', roles: [ { role: "dbAdmin", db: "kuj-demo" } ] });


# Docker

Add Docker’s official GPG key:

  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  apt-get update
  apt-get install docker-ce

To turn on experimental docker functions create following file by:

  vi /etc/docker/daemon.json

and add below content to it

    {
        "experimental": true
    }
and save file (by CTRL+X and Enter ) and exit. In terminal type:

    sudo service docker restart .  

To check that experimental funcions are ON, type in terminal:

    docker version

And you should see  Experimental: true

# Docker registry

copy certs to /etc/ssl

Create a password file with one entry for the user doc, with password "test":

    docker run --entrypoint htpasswd registry:2 -Bbn doc test > auth/htpasswd


    docker run -d -p 5000:5000 --restart=always --name registry -v /home/doc/kujon-docker/nginx/ssl:/certs -v /home/doc/kujon-docker/nginx/auth:/auth -e "REGISTRY_AUTH=htpasswd" -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm"  -e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/kujon.mobi.cert.2018 -e REGISTRY_HTTP_TLS_KEY=/certs/kujon.mobi.key registry:2
