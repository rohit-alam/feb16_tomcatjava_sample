FROM ubuntu:latest

# Install necessary dependencies
RUN apt-get update && \
    apt-get install -y wget openjdk-17-jre-headless && \
    apt-get clean

# Create a group and user for Tomcat
RUN groupadd tomcat && \
    useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat

# Set the Tomcat home directory
ENV CATALINA_HOME /opt/tomcat

# Change to the Tomcat directory
WORKDIR /opt/tomcat

# Download and extract Tomcat
RUN wget -q https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.85/bin/apache-tomcat-9.0.85.tar.gz && \
    tar -xzf apache-tomcat-9.0.85.tar.gz --strip-components=1 && \
    rm apache-tomcat-9.0.85.tar.gz

# Change ownership of Tomcat directory
RUN chown -R tomcat: /opt/tomcat

# Switch to the Tomcat user and start Tomcat in the foreground
USER tomcat
CMD ["bin/catalina.sh", "run"]

# Expose Tomcat port
EXPOSE 8080

