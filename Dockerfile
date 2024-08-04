## 이미 JRE가 설정된 베이스 이미지를 사용한다.
#FROM eclipse-temurin:17
#LABEL authors="sangjun"
#
## 작업 폴더 workspace를 생성하고, 이동
#WORKDIR workspace
#
## 프로젝트에서 애플리케이션 JAR 파일의 위치를 인수로 지정한다.
#ARG JAR_FILE=build/libs/*.jar
#
## 애플리케이션 JAR 파일을 로컬 머신에서 이미지 안으로 복사한다.
#COPY ${JAR_FILE} catalog-service.jar
#
## 애플리케이션을 실행하기 위한 컨테이너 진입점을 설정한다.
#ENTRYPOINT ["java", "-jar", "catalog-service.jar"]
# ---
#
#FROM eclipse-temurin:17 AS builder
#WORKDIR workspace
#ARG JAR_FILE=build/libs/*.jar
#COPY ${JAR_FILE} catalog-service.jar
#RUN java -Djarmode=layertools -jar catalog-service.jar extract

FROM eclipse-temurin:17
RUN useradd spring
USER spring
WORKDIR workspace
COPY --from=builder workspace/dependencies/ ./
COPY --from=builder workspace/spring-boot-loader/ ./
COPY --from=builder workspace/snapshot-dependencies/ ./
COPY --from=builder workspace/application/ ./
ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher" ]


