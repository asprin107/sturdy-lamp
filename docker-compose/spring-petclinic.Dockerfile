FROM gradle:jdk17 as build
COPY ./spring-petclinic /spring-petclinic
WORKDIR /spring-petclinic
RUN gradle build


FROM openjdk:17.0.2-jdk as app
COPY --from=build /spring-petclinic/build/libs/spring-petclinic-*.*.*.jar spring-petclinic.jar
ENTRYPOINT ["java", "-jar", "spring-petclinic.jar"]
