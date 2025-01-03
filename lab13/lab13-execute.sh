#!/bin/bash

source ../common.sh

echo -e  "\n Starting script --> create Java Spring app using external builder image in Openshift Cluster"

prompt

execute "login to OCP4" '''oc login -u developer -p developer https://api.ocp4.example.com:6443'''
execute "Create New Project" '''oc new-project mylab1'''
echo "First need to create secret for ergistry.redhat.io to download builder images"
read -p "Enter redhat user account id: " USERNAME

read -p "Enter redhat user password: " -s PASSWORD

echo -e "\n Creating Secret........." 
oc create secret docker-registry redhatio-secrets --docker-server registry.redhat.io --docker-username $USERNAME --docker-password $PASSWORD

execute "link secret to builder service account " ''' oc secret link builder redhatio-secrets'''

execute "Creating New app for the Java Spring app from git using s2i image" '''oc new-app --name myjavaapp --context-dir /lab13/SpringBasicRefresherApp registry.redhat.io/fuse7/fuse-java-openshift-jdk17-rhel8:1.13-14.1733302831~https://github.com/arunprabhur/EX288.git '''
execute "watch  pods" '''watch oc get po'''

execute "Get logs from build pod" '''oc logs myjavaapp-1-build'''
execute "Expose the service for my java app" '''oc expose svc/myjavaapp'''
execute "Get get Route Details" ''' oc get route'''

execute "Verify whether able to access the service" '''curl myjavaapp-mylab1.apps.ocp4.example.com/info'''

execute "adding probe " '''oc set probe deployment myjavaapp --liveness --get-url http://:8080/healthcheck'''
execute " Pod must have been restarted for adding probe" '''oc get po'''

execute " Creating a invalid provbe with wrong url" '''oc set probe deployment myjavaapp --liveness --get-url http://:8080/invalid'''

execute " Pod must have been restarted for adding probe" '''watch oc get po'''


execute "Deleting the project" '''oc delete project mylab1'''
endofscript

echo "End of script"
