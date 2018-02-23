# how to build image

docker build --build-arg git_username=USERNAME --build-arg git_password=PASS--no-cache=true -t image:kujon-demo .

# how to run image

docker container run --publish 9000:9000 --publish 9002:9002 --publish 9004:9004 --publish 9005:9005 --name kujon-demo kujon/kujon-demo

# how to start image

docker container start kujon-mobi

# how to connect

docker exec -it kujon-demo bash

# mongo demo create db

db.createUser({ user: 'kujon', pwd: 'ZZ2982skhH3sGIms', roles: [ { role: "dbAdmin", db: "demo" } ] });

