FROM jboss/wildfly:16.0.0.Final
## Create admin user for accessing management console
RUN /opt/jboss/wildfly/bin/add-user.sh admin Admin#70365 --silent

##copy com.zip includes oracle and sql server driver packages
COPY com.zip /opt/jboss/wildfly/modules
RUN cd /opt/jboss/wildfly/modules && unzip com.zip
RUN cd /opt/jboss/wildfly/modules && rm -f com.zip

RUN cd /opt/jboss/wildfly/modules && ls
RUN cd /opt/jboss/wildfly/modules/com/oracle/main && pwd

## replace standalone.xml with updated file included database connection details
RUN cd /opt/jboss/wildfly/standalone/configuration && rm -f standalone.xml
COPY standalone.xml /opt/jboss/wildfly/standalone/configuration

## copy necessory deployments files to deployments directory 
#COPY YourApp.war /opt/jboss/wildfly/standalone/deployments

## start wildfly
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]