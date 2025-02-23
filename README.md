
## Project: Deploying SpringBoot To-Do API Application on Docker container
- Mondodb, mongo-express are deployed in the same docker network along with Springboot application to communicate with each other using their names. 
- Used Docker Multi-Stage Build
  
This project demonstrates how to build and deploy a Spring Boot application (To-Do API) with MongoDB integration using Docker. The application will communicate with a MongoDB database and provide a simple interface for managing tasks. Docker multi-stage builds are used to optimize the image creation process.

## Prerequisites

Before you begin, ensure you have the following installed:

- Docker (for building and running containers)
- Maven (for building the Spring Boot application)
- JDK 11 or 18 (for building and running the application)

## Setup Instructions

### 1. Build and Run MongoDB

To set up MongoDB in a Docker container, run the following command:

```bash
docker pull mongo:4.4.6
```

Next, run the MongoDB container with the required environment variables:

```bash
docker run -e MONGO_INITDB_ROOT_USERNAME=root -e MONGO_INITDB_ROOT_PASSWORD=password -p 27017:27017 -d --net mongo-net --name mongodb1 mongo:4.4.6
```

You can connect to MongoDB using [MongoDB Compass](https://www.mongodb.com/products/compass) with the following credentials:
- **Username**: root
- **Password**: password
- **Host**: localhost/ipaddr of container/name of mongodb if you use same custom docker network for both mongodb and mongo-express
- **Port**: 27017

### 2. Run Mongo-Express

Mongo-Express is a web-based admin interface to interact with MongoDB. To run Mongo-Express in Docker, use the following command:

```bash
docker run -e ME_CONFIG_MONGODB_ADMINUSERNAME=root -e ME_CONFIG_MONGODB_ADMINPASSWORD=password -e ME_CONFIG_MONGODB_SERVER=mongodb1 -p 8082:8081 --net mongo-net -d mongo-express:1.0.2
```

Once Mongo-Express is running, you can access the admin interface at:

[http://localhost:8082](http://localhost:8082)

- **Username**: admin
- **Password**: pass

### 3. Build the Spring Boot To-Do API

Ensure you have Maven and JDK 11 or 18 installed before proceeding.

To build the Spring Boot To-Do API Docker image, run the following command:

```bash
docker build -t todo-api:1.0.1 .
```

### 4. Run the Spring Boot Application

Once the image is built, you can run the application with the following command:

```bash
docker run -d -p 8080:8080 -e spring.data.mongodb.host=mongodb1 --net mongo-net todo-api:1.0.1
```

Check the container logs to confirm that the application is successfully connected to MongoDB:

```bash
docker logs <container-id>
```

### 5. Testing the API with Postman

Once the container is running, you can interact with the To-Do API using [Postman](https://www.postman.com/). The API will be accessible at `http://localhost:8080`.

## Docker Multi-Stage Build

Followed Docker best practices to build docker image of springboot application by using multi stage build in Dockerfile, please refer the 'Dockerfile'.

- **Build image**:

    ```bash
    docker build . -t multi-stage-example:v1
    ```

- **Build image using a specific stage**:

    ```bash
    docker build . -t multi-stage-example:v1 --target=builder
    ```

- **Run the image**:

    ```bash
    docker run multi-stage-example:v1 -p 8080:8080
    ```

## Notes

- If you are using Mongo-Express, ensure that the `ME_CONFIG_MONGODB_ENABLE_ADMIN` environment variable is set to `"false"` when configuring the MongoDB connection.
  
  You may need to adjust the following Mongo-Express environment variables:
  - `ME_CONFIG_MONGODB_AUTH_DATABASE`: Default is 'db'.
  - `ME_CONFIG_MONGODB_AUTH_USERNAME`: Default is 'admin'.
  - `ME_CONFIG_MONGODB_AUTH_PASSWORD`: Default is 'pass'.

Refer to the [Mongo-Express Docker Hub](https://hub.docker.com/_/mongo-express) for more details on configuring Mongo-Express.

## Conclusion

This project sets up a complete Dockerized environment for a Spring Boot To-Do API with MongoDB. By using multi-stage builds, Docker optimizes the build process and ensures that the resulting images are small and efficient.
```

### Key Updates:
1. **Section headers**: Added clear section titles (e.g., Setup Instructions, Docker Multi-Stage Build, etc.).
2. **Practical details**: Each step (e.g., building, running MongoDB, and running the Spring Boot app) is clearly outlined with the necessary commands.
3. **Docker multi-stage**: The multi-stage build section was cleaned up with examples of common Docker commands.
4. **Formatting**: Lists, code blocks, and sections are now clearly formatted for better readability.

This structure follows industry practices and will make it easier for other developers to follow along and set up the project correctly.
































   

Docker commands used:
    docker build . -t multi-stage-example:v1 - Build image
    docker build . -t multi-stage-example:v1 --target=builder - Build image using a specific stage
    docker run multi-stage-example:v1 -p 8080:8080 - Run image
