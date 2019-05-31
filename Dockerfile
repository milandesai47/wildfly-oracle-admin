FROM jboss/wildfly:16.0.0.Final
## Create admin user for accessing management console
RUN /opt/jboss/wildfly/bin/add-user.sh admin Admin#70365 --silent

COPY com.zip /opt/jboss/wildfly/modules
RUN cd /opt/jboss/wildfly/modules && unzip com.zip
RUN cd /opt/jboss/wildfly/modules && rm -f com.zip
## create oracle modules file
#RUN cd /opt/jboss/wildfly/modules && mkdir -p com/{oracle/main, 

RUN cd /opt/jboss/wildfly/modules && ls
RUN cd /opt/jboss/wildfly/modules/com/oracle/main && pwd

## copy necessory ojdbc6, ojdbc7 driver classes for database connection
#COPY ojdbc6.jar /opt/jboss/wildfly/modules/com/oracle/main
#COPY ojdbc7.jar /opt/jboss/wildfly/modules/com/oracle/main
#COPY module.xml /opt/jboss/wildfly/modules/com/oracle/main

## create sql server module file
#RUN cd /opt/jboss/wildfly/modules && mkdir -p com/oracle/main
#RUN cd /opt/jboss/wildfly/modules/com/oracle/main && pwd

#RUN cd /opt/jboss/wildfly/modules/com/oracle/main && ls

## replace standalone.xml with updated file included database connection details
RUN cd /opt/jboss/wildfly/standalone/configuration && rm -f standalone.xml
COPY standalone.xml /opt/jboss/wildfly/standalone/configuration

## copy necessory deployments files to deployments directory 
#COPY WebConnect.war /opt/jboss/wildfly/standalone/deployments

## start wildfly
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]