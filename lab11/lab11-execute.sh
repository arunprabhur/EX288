#!/bin/bash

source ../common.sh

echo -e  "\n Starting script --> create secrets and config map,apply it into a pod as env and mount as a file in Openshift Cluster"

prompt

execute "login to OCP4" '''oc login -u developer -p developer https://api.ocp4.example.com:6443'''
execute "Create New Project" '''oc new-project mylab1'''
execute "Creating New app for the bash app from git" '''oc new-app --strategy docker --name mybashapp --context-dir /lab1111111111111111111111  https://github.com/arunprabhur/EX288.git '''
execute "setting persistent volume for the application" '''oc set volumes deployment/mybashapp --add -t pvc --claim-mode rwo --claim-name test-pvc-claim --claim-size 2Gi --mount-path /shared --name shared-volume'''
execute "Check whether new pvc is created" '''watch -n 2 oc get pvc'''

execute "Deleting the project" '''oc delete project mylab1'''
endofscript

echo "End of script"
