FROM xmlangel/base-ubuntu14.04 
EXPOSE 8080
RUN apt-get update && apt-get -y install software-properties-common
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get -y update
RUN echo "oracle-java7-installer shared/accepted-oracle-license-v1-1 boolean true" | debconf-set-selections
RUN apt-get -y install oracle-java7-installer maven
ENV TOMCAT_MAJOR 8
ENV TOMCAT_VERSION 8.5.9
RUN wget http://ftp.riken.jp/net/apache/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz
RUN mv apache-tomcat-${TOMCAT_VERSION}.tar.gz /usr/local/ && cd /usr/local/ && tar -xvzf apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
 mv apache-tomcat-${TOMCAT_VERSION} apache-tomcat
COPY code/ /root/devops
RUN cd /root/devops && mvn clean install && cp /root/devops/target/TestProject.war /usr/local/apache-tomcat/webapps/
WORKDIR /usr/local/apache-tomcat/bin/
#RUN chmod +x *.sh
#RUN ls -al
CMD ["/usr/local/apache-tomcat/bin/catalina.sh", "run"]
