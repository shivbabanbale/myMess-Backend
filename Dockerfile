# ---------- Stage 1: Build ----------
    FROM maven:3.8.5-openjdk-17 AS build
    WORKDIR /app
    COPY . .
    RUN mvn clean package -DskipTests
    
    # ---------- Stage 2: Run ----------
    FROM openjdk:17-jdk-slim
    WORKDIR /app
    COPY --from=build /app/target/*.jar myMess.jar
    ENTRYPOINT ["java", "-jar", "myMess.jar"]
    