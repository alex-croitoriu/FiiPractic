FROM openjdk:11
ADD springboot /springboot
WORKDIR /springboot
RUN chmod +x ./gradlew && ./gradlew build --no-daemon

FROM openjdk:11-jre-slim
RUN groupadd -r fiipractic && useradd -r -g fiipractic fiipractic
COPY --from=0 springboot/build/libs/spring-boot-FiiPractic-1.0.jar springboot/spring-boot-FiiPractic-1.0.jar
RUN chown -R fiipractic:fiipractic springboot
USER fiipractic
EXPOSE 8080
ENTRYPOINT java -jar springboot/spring-boot-FiiPractic-1.0.jar