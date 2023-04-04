# Use the official OpenJDK 8 image as the base image
FROM openjdk:8-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the compiled JAR file (built using `./mvnw clean package`) into the container
COPY target/*.jar app.jar

# Set the entry point for the application
ENTRYPOINT ["java", "-jar", "app.jar"]

# Expose the port your application will run on
EXPOSE 8080