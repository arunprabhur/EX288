#!/bin/bash

source ../common.sh

echo -e  "\n Starting script --> create pvc and apply into bash app, create app with statefulset with different pvc in Openshift Cluster"

prompt

execute "login to OCP4" '''oc login -u developer -p developer https://api.ocp4.example.com:6443'''
execute "Create New Project" '''oc new-project mylab1'''
execute "Creating New app for the bash app from git" '''oc new-app --strategy docker --name mybashapp --context-dir /lab11  https://github.com/arunprabhur/EX288.git '''
execute "setting persistent volume for the application" '''oc set volumes deployment/mybashapp --add -t pvc --claim-mode rwo --claim-name test-pvc-claim --claim-size 2Gi --mount-path /shared --name shared-volume'''
execute "Check whether new pvc is created" '''watch -n 2 oc get pvc,pod'''


echo -e  "Copying a text file into a pod and store int the shared drive\n oc cp sample-shared-file.txt $(oc get po | grep Running | cut -d " " -f1):/shared/ "
oc cp sample-shared-file.txt $(oc get po | grep Running | cut -d " " -f1):/shared/
read -p "press enter to continue"
clear
echo -e "Print the shared file data from pod \n oc rsh $(oc get po | grep Running | cut -d " " -f1) cat /shared/sample-shared-file.txt"
oc rsh $(oc get po | grep Running | cut -d " " -f1) cat /shared/sample-shared-file.txt
read -p "press enter to continue"
clear

echo -e "delete existing running pod oc delete pod \n $(oc get po | grep Running | cut -d " " -f1)"
oc delete pod $(oc get po | grep Running | cut -d " " -f1)
read -p "Enter to continue" 
clear
sleep 10

echo -e "Print the shared file data from new pod \n oc rsh $(oc get po | grep Running | cut -d " " -f1) cat /shared/sample-shared-file.txt"
oc rsh $(oc get po | grep Running | cut -d " " -f1) cat /shared/sample-shared-file.txt
read -p "press enter to continue"
clear

execute "delete deployment, so we can try statefulset" '''oc delete deployment mybashapp'''
execute "Apply statefulset" '''oc apply -f mybashapp-stateful-set.yaml'''

execute "watch statefulset, po, pvc" '''watch oc get po,pvc,statefulset'''

execute "scale to 5" '''oc scale statefulset mybashapp --replicas 5'''


execute "watch statefulset, po, pvc" '''watch oc get po,pvc,statefulset'''
execute "Deleting the project" '''oc delete project mylab1'''
endofscript

echo "End of script"
