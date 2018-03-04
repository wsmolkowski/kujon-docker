# how to build app image

docker build --build-arg git_username=USERNAME --build-arg git_password=PASS--no-cache=true -t image:kujon-demo .

# how to run image

docker container run --publish 9000:9000 --publish 9002:9002 --publish 9004:9004 --publish 9005:9005 --name kujon-demo kujon/kujon-demo

# how restore mongo
mongorestore -d kujon-demo kujon-demo/
mongorestore -d kujon-prod kujon-prod/

#mongo create admin
mongo admin
db.createUser( {
     user: "admin",
     pwd: "jfh472837r61HdgFd",
     roles: [ { role: "userAdminAnyDatabase", db: "admin" } ]
   });

# mongo demo create db
  use kujon-prod;
  db.createUser({ user: 'kujprod', pwd: '4567GhdF13Kd', roles: [ { role: "dbAdmin", db: "kujon-prod" } ] });

  use kujon-demo;
  db.createUser({ user: 'kujdemo', pwd: 'jsH28s3284sh', roles: [ { role: "dbAdmin", db: "kujon-demo" } ] });


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
