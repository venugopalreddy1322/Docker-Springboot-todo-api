# todo-api
Building a docker image from Springboot application
Springboot application todo will communicate with mongoDB

To login to mongo-express 

from official website: https://hub.docker.com/_/mongo-express

The following are only needed if ME_CONFIG_MONGODB_ENABLE_ADMIN is "false"

Name                            | Default         | Description
--------------------------------|-----------------|------------
ME_CONFIG_MONGODB_AUTH_DATABASE | 'db'            | Database name
ME_CONFIG_MONGODB_AUTH_USERNAME | 'admin'         | Database username
ME_CONFIG_MONGODB_AUTH_PASSWORD | 'pass'          | Database password

NOTE: Read Dockerfile for more information

    Commands used

    # To Run mongodb database
    docker run -e MONGO_INITDB_ROOT_USERNAME=root -e MONGO_INITDB_ROOT_PASSWORD=password -p 27017:27017 -d --net mongo-net --name mongodb1 mongo:4.4.6

    # To Run mongo-express 
    docker run -e ME_CONFIG_MONGODB_ADMINUSERNAME=root -e ME_CONFIG_MONGODB_ADMINPASSWORD=password -e ME_CONFIG_MONGODB_SERVER=mongodb1 -p 8082:8081 --net mongo-net -d mongo-express:1.0.2

    # To build Springboot TO-DO-API
    [
        Prerequisites: 
        maven:jdk-11 to build
        jdk-11/18 to run
    ]
    docker build -t todo-api:1.0.1 .

    # To build Springboot TO-DO-API
    docker run -d -p 8080:8080 -e spring.data.mongodb.host=mongodb1 --net mongo-net todo-api:1.0.1
    -Then check the logs of container created to check whether it is connected to mongodb or not
    docker logs <container-id>




    docker build . -t multi-stage-example:v1 - Build image
    docker build . -t multi-stage-example:v1 --target=builder - Build image using a specific stage
    docker run multi-stage-example:v1 -p 8080:8080 - Run image
