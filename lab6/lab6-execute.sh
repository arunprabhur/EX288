#!/bin/bash

source ../common.sh

echo -e  "\n Starting script --> Import image into image stream, run a app with that stream and switch the app with new base image by changing the pointer in image stream of Openshift Cluster"

prompt

execute "login to OCP4" '''oc login -u developer -p developer https://api.ocp4.example.com:6443'''
execute "Create New Project" '''oc new-project mylab1'''
execute "Create a ubi-redhat-image stream" '''oc import-image ubi-redhat-is --from registry.access.redhat.com/ubi8-minimal:8.10-1154 --confirm'''
echo -e "To run a local folder \n 1. oc new-app --name mybashapp --strategy docker \n"
echo -e "2. oc start-build buildconfig/mybashapp --from-dir ."
read -p "Enter to continue"
execute "Creating New app for the bash app from git" '''oc new-app --strategy docker --name mybashapp --context-dir /lab6 https://github.com/arunprabhur/EX288.git'''
sleep 15
execute "check pods running status" '''oc get po'''
sleep 15
clear
execute "View all resources created" ''' oc get all'''
execute "View the ubi-redhat-is tagged image" '''oc get istag'''
execute "Change tag of ubi-redhat-is from redhat 8 to redhat 9" '''oc tag registry.access.redhat.com/ubi9-minimal:9.5-1734497536 ubi-redhat-is:latest'''
execute "view again ubi-redhat-is image tagged now" '''oc get istag'''
execute "describe ubi-redhat-is image to see all tags" ''' oc describe is/ubi-redhat-is'''
execute "Check whether new build is created and running" '''oc get po'''
execute "Deleting Project" '''oc delete project mylab1'''
endofscript

echo "End of script"
