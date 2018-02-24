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


# login to cloud.canister.io
docker login --username=kujon cloud.canister.io:5000
