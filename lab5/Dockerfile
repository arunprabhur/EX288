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

#Execute my script while starting container
ENTRYPOINT ["/opt/project/test.sh"]

CMD ["Sample","Text"]
 
