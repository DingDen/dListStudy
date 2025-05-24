# Etapa de build
FROM eclipse-temurin:21-jdk AS build
WORKDIR /app

COPY . .

# Usa o wrapper do Maven para compilar e empacotar o projeto
RUN ./mvnw clean package -DskipTests

# Etapa de runtime
FROM eclipse-temurin:21-jre
WORKDIR /app

# Copia o jar do build anterior
COPY --from=build /app/target/dslist-0.0.1-SNAPSHOT.jar app.jar

# Expõe a porta padrão do Spring Boot
EXPOSE 8080

# Comando para rodar o app
ENTRYPOINT ["java", "-jar", "app.jar"]