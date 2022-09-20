FROM tomcat:8.0.36-jre8

COPY Fortinet_CA_SSL.cer /root/

RUN export FGTCA=$(base64 /root/Fortinet_CA_SSL.cer -w0) && \
    echo $FGTCA| base64 -d > /usr/local/share/ca-certificates/Fortinet_CA_SSL.crt && \
    update-ca-certificates

RUN rm -rf /usr/local/tomcat/webapps/*
ADD target/log4shell-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080 
CMD ["catalina.sh", "run"]
