#!/bin/bash

source ../common.sh

echo -e  "\n Starting script --> create pvc and apply into bash app, create app with statefulset with different pvc in Openshift Cluster"

prompt

execute "login to OCP4" '''oc login -u developer -p developer https://api.ocp4.example.com:6443'''
execute "Create New Project" '''oc new-project mylab1'''
execute " Creating new Helm Chart" '''helm create myhelmchart'''

execute "Delete Project" ''' oc delete project mylab1'''
endofscript

echo "End of script"
