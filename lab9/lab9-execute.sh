#!/bin/bash

source ../common.sh

echo -e  "\n Starting script --> create secrets and config map,apply it into a pod as env and mount as a file in Openshift Cluster"

prompt

execute "login to OCP4" '''oc login -u developer -p developer https://api.ocp4.example.com:6443'''
execute "Create New Project" '''oc new-project mylab1'''
execute "create a secret from literal" '''oc create secret generic mybashappsecret --from-literal BASH_SECRET_ENV=ENV_SECRETVALUE'''
execute "create a config map from literal" '''oc create cm mybashcm --from-literal BASH_CM_SECRET=CM_SECRET'''
execute "Creating New app for the bash app from git" '''oc new-app --strategy docker --name mybashapp --context-dir /lab9  https://github.com/arunprabhur/EX288.git '''
execute "Setting the secret to environment variable of the pods" '''oc set env deployment mybashapp --from secret/mybashappsecret'''
execute "Setting the cm to environment variable of the pods" '''oc set env deployment mybashapp --from cm/mybashcm'''
execute "Check whether new build is created and running" '''watch -n 2 oc get po'''
execute "Updating the value of secret dynamically" '''oc set data secret/mybashappsecret --from-literal BASH_SECRET_ENV=UPDATED_VALUE'''

execute "Deleting the project" '''oc delete project mylab1'''
endofscript

echo "End of script"
