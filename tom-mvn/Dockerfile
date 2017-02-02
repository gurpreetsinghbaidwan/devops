FROM ubuntu
# Install Java
RUN apt-get update && apt-get -y upgrade \
     && apt-get -y install software-properties-common \
     && add-apt-repository ppa:webupd8team/java \
     && apt-get -y update 

# Accept the license
RUN echo "oracle-java7-installer shared/accepted-oracle-license-v1-1 boolean true" | debconf-set-selections

RUN apt-get -y install oracle-java7-installer

# INstall Tomcat
RUN mkdir  -p /usr/local/tomcat
RUN wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.0.14/bin/apache-tomcat-8.0.14.tar.gz
RUN tar -xzvf apache-tomcat-8.0.14.tar.gz
RUN cp -pvr apache-tomcat-8.0.14 /usr/local/tomcat
EXPOSE 8080
# Install maven 
RUN apt-get install -y maven \
    &&  mvn -version \
    &&  apt-get update 

COPY mvn.zip /
RUN apt-get install unzip 
RUN unzip mvn.zip

WORKDIR /Test_Project
RUN mvn clean install
#RUN cd /Test_Project
#RUN ls -la /Test_Project/target
RUN cp /Test_Project/target/Test_Project.war /usr/local/tomcat/apache-tomcat-8.0.14/webapps/
#RUN ls -la /usr/local/tomcat/apache-tomcat-8.0.14/webapps

RUN apt-get autoremove

CMD ["/usr/local/tomcat/apache-tomcat-8.0.14/bin/catalina.sh", "run"]
 
