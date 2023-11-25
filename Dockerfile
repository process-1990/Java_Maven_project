FROM maven AS build
WORKDIR /app
COPY . . 
RUN mvn insall

FROM openjdk:11.0
WORKDIR /app
COPY --from=build /app/target/Uber.jar /app/
EXPOSE 9099
CMD [ "java","-jar","Uber.jar" ]
