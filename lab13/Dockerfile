#My First ContainerFile

FROM registry.access.redhat.com/ubi8/openjdk-21:1.21-1.1733300817 

MAINTAINER Arun prabhu.arun10@gmail.com
LABEL project="JAVA Spring Refresher Project"

ENV PROJECT="JAVA SPRING PROJECT"

WORKDIR /opt

#Create Project Folder
RUN mkdir project

#Move the script to container user folder
COPY SpringBasicRefresherApp/target/SpringRefresher-0.0.1-SNAPSHOT.jar project/
#COPY startup.sh project/

RUN java -version

#Adding group access for root, Openshift user will be part of this group
#RUN chgrp -R 0 project &&  chmod -R g=u project

USER 1001
#Execute my script while starting container
ENTRYPOINT ["java","-jar"] 

CMD ["/opt/project/SpringRefresher-0.0.1-SNAPSHOT.jar"]
 
