From anapsix/alpine-java
COPY  target/junitsample-0.0.1-SNAPSHOT.jar /home/junitsample-0.0.1-SNAPSHOT.jar
CMD ["java","-jar","/home/testprj-1.0-SNAPSHOT.jar"]
