#!/bin/bash

source ../common.sh

echo "Starting script"
prompt

execute "login to OCP4" '''oc login -u developer -p developer https://api.ocp4.example.com:6443'''
execute "Create New Project" '''oc new-project mylab1'''
execute "Create New App" '''oc new-project mylab1'''

endofscript

echo "End of script"
