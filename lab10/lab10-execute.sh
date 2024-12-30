#!/bin/bash

source ../common.sh

echo -e  "\n Starting script --> create secrets and config map,apply it into a pod as env and mount as a file in Openshift Cluster"

prompt

execute "login to OCP4" '''oc login -u developer -p developer https://api.ocp4.example.com:6443'''
execute "Create New Project" '''oc new-project mylab1'''
execute "create a secret from file" '''oc create secret generic file-secret --from-file secret.properties'''
execute "create a config map from file" '''oc create cm file-cm-secret --from-file cm.properties'''
execute "Creating New app for the bash app from git" '''oc new-app --strategy docker --name mybashapp --context-dir /lab10  https://github.com/arunprabhur/EX288.git '''
execute "Watch for pods" '''watch oc get po'''
execute "Setting the secret to file mount of  the pods" '''oc set volume deployment mybashapp --add -t secret -m /mnt/secret --name secretvol --secret-name file-secret'''

POD_RUNNING=$(oc get po | grep 'Running' | cut -d " " -f1)
echo "Viewing property file available in running pod" 
echo "oc rsh ${POD_RUNNING} cat /mnt/secret/secret.properties"
oc rsh ${POD_RUNNING} cat /mnt/secret/secret.properties
read -p "Enter to continue"
execute "Setting the cm to file mount of the pods" '''oc set volume deployment mybashapp --add -t configmap -m /mnt/configmap --name cmvol --configmap-name file-cm-secret'''
execute "Check whether new build is created and running" '''watch -n 2 oc get po'''
echo "View CM property file availabe running pod" 
echo "oc rsh $(oc get po | grep 'Running' | cut -d " " -f1) cat /mnt/configmap/cm.properties"
oc rsh $(oc get po | grep 'Running' | cut -d " " -f1) cat /mnt/configmap/cm.properties
read -p "Enter to continue"
echo "Update different value in secret.propeties file"
read -p "enter to continue and wait fro 60 seconds"
execute "Updating secret in secret.properties" '''oc set data secret/file-secret --from-file secret.properties'''
sleep 60
POD_RUNNING=$(oc get po | grep 'Running' | cut -d " " -f1)
echo "Viewing property file available in running pod" 
echo "oc rsh ${POD_RUNNING} cat /mnt/secret/secret.properties"
oc rsh ${POD_RUNNING} cat /mnt/secret/secret.properties
read -p "Enter to continue"
echo "Update different value in cm.propeties file"
read -p "enter to continue and wait for 60 seconds"

execute "Updating secret in configmap" '''oc set data cm/file-cm-secret --from-file cm.properties'''
sleep 60
echo "View CM property file availabe running pod" 
echo "oc rsh $(oc get po | grep 'Running' | cut -d " " -f1) cat /mnt/configmap/cm.properties"
oc rsh $(oc get po | grep 'Running' | cut -d " " -f1) cat /mnt/configmap/cm.properties
read -p "Enter to continue"
execute "Deleting the project" '''oc delete project mylab1'''
endofscript

echo "End of script"
