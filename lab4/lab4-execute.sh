#!/bin/bash

source ../common.sh

echo -e  "\n Starting script --> Creating & analyzing build configurations & building applications in Openshift Cluster"

prompt

execute "login to OCP4" '''oc login -u developer -p developer https://api.ocp4.example.com:6443'''
execute "Create New Project" '''oc new-project mylab1'''
execute "Create only build - New Build" ''' oc new-build --name mybashapp --context-dir lab4 https://github.com/arunprabhur/EX288.git'''

execute "view the status of build, Ctrl+C to terminate" '''oc get po -w'''
execute "view build config Name" '''oc get bc'''
execute "addign more logger to build" '''oc set env bc/mybashapp BUILD_LOGLEVEL="3"'''
execute "Describe build config for mybashapp yaml" '''oc describe bc/mybashapp'''
execute "Get BuildConfig Yaml fopr mybashapp" '''oc get bc/mybashpp -o yaml'''
execute "Start a new Build" '''oc start-build bc/mybashapp'''
execute "View detailed logs for build 2" '''oc logs pod/mybashapp-2-build'''
execute "view the status of build, Ctrl+C to terminate" '''oc get po -w'''
execute "Deleting Project" '''oc delete project mylab1'''
endofscript

echo "End of script"
