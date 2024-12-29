#!/bin/bash

source ../common.sh

echo -e  "\n Starting script --> create secrets and config map,apply it into a pod as env and mount as a file in Openshift Cluster"

prompt

execute "login to OCP4" '''oc login -u developer -p developer https://api.ocp4.example.com:6443'''
execute "Create New Project" '''oc new-project mylab1'''
execute "create a secret from literal" '''oc create secret generic mybashappsecret --from-literal BASHAPPENV=SECRETVALUE'''
execute "Creating New app for the bash app from git" '''oc new-app --strategy docker --name mybashapp --context-dir /lab9 -e BASHAPP=secret/mybashappsecret  https://github.com/arunprabhur/EX288.git '''

execute "Check whether new build is created and running" '''watch -n 2 oc get po'''
endofscript

echo "End of script"
