#My First ContainerFile

FROM registry.access.redhat.com/ubi8-minimal:latest

MAINTAINER Arun prabhu.arun10@gmail.com
LABEL project="Arun'sProject"

ENV PROJECT="DEMO PROJECT"

WORKDIR /opt

#Create Project Folder
RUN mkdir project

#Move the script to container user folder
ADD test.sh project/
COPY post-hook.sh pre-hook.sh project/

#Adding group access for root, Openshift user will be part of this group
RUN chgrp -R 0 project &&  chmod -R g=u project

USER 1000
#Execute my script while starting container
ENTRYPOINT ["/opt/project/test.sh"]

CMD ["Sample","Text"]
 
