#!/bin/bash

source ../common.sh

echo -e  "\n Starting script --> create pvc and apply into bash app, create app with statefulset with different pvc in Openshift Cluster"

prompt

execute "login to OCP4" '''oc login -u developer -p developer https://api.ocp4.example.com:6443'''
execute "Create New Project" '''oc new-project mylab1'''
execute "Creating New app for the bash app from git" '''oc new-app --strategy docker --name mybashapp --context-dir /lab12 https://github.com/arunprabhur/EX288.git '''
execute "watch  pods" '''watch oc get po'''
execute " setting startup probe " '''oc set probe deployment mybashapp --startup -- /opt/project/startupprobe.sh'''
execute " setting readiness probe " '''oc set probe deployment mybashapp --readiness -- /opt/project/readinessprobe.sh'''

execute " setting liveness probe " '''oc set probe deployment mybashapp --liveness -- /opt/project/livenessprobe.sh'''
execute "check deployment yaml for these probes" '''oc get deployment mybashapp -o yaml | yq r - -C | less -R'''
execute "Deleting the project" '''oc delete project mylab1'''
endofscript

echo "End of script"
