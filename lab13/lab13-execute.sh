#!/bin/bash

source ../common.sh

echo -e  "\n Starting script --> create Java Spring app using external builder image in Openshift Cluster"

prompt

execute "login to OCP4" '''oc login -u developer -p developer https://api.ocp4.example.com:6443'''
execute "Create New Project" '''oc new-project mylab1'''
execute "Creating New app for the Java Spring app from git using s2i image" '''oc new-app --name myjavaapp --context-dir /lab13/SpringBasicRefresherApp registry.redhat.io/fuse7/fuse-java-openshift-jdk17-rhel8:1.13-14.1733302831~https://github.com/arunprabhur/EX288.git '''
execute "watch  pods" '''watch oc get po'''
execute "Deleting the project" '''oc delete project mylab1'''
endofscript

echo "End of script"
