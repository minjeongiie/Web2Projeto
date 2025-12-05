FROM eclipse-temurin:17-jdk

# Instalar Tomcat 11
ENV CATALINA_HOME=/opt/tomcat
ENV PATH="$CATALINA_HOME/bin:${PATH}"

RUN mkdir -p /opt/tomcat
RUN curl -L -o /tmp/tomcat.tar.gz https://dlcdn.apache.org/tomcat/tomcat-11/v11.0.0-M14/bin/apache-tomcat-11.0.0-M14.tar.gz \
    && tar -xzf /tmp/tomcat.tar.gz -C /opt/tomcat --strip-components=1 \
    && rm /tmp/tomcat.tar.gz

# Copiar o WAR para o Tomcat
COPY target/*.war $CATALINA_HOME/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
