#!/bin/bash

source ../common.sh

echo -e  "\n Starting script --> create helm and apply into bash app, install app, upgrade, rollback & uninstall in Openshift Cluster"

prompt

execute "login to OCP4" '''oc login -u developer -p developer https://api.ocp4.example.com:6443'''
execute "Create New Project" '''oc new-project mylab1'''
execute "Creating new Helm Chart" '''helm create myhelmchart'''
execute "Removing default files from templates of helm folder" ''' rm myhelmchart/templates/*.yaml'''
echo "Creating application yaml into helm chart myhelmchar" 
echo "oc new-app --strategy docker --name mybashapp --context-dir /lab2 https://github.com/arunprabhur/EX288.git -o yaml > myhelmchart/templates/application.yaml"
oc new-app --strategy docker --name mybashapp --context-dir /lab2 https://github.com/arunprabhur/EX288.git -o yaml > myhelmchart/templates/application.yaml
read -p "Press Enter to continue"
echo "Adding NOTES.TXT --> Information regarding Bash Application is added in the notes > NOTES>txt"
echo "Information regarding Bash Application is added in the notes" > myhelmchart/templates/NOTES.txt
tree .
read -p "Press Enter to continue"
execute "Installing using helm chart" ''' helm install myhelmchart myhelmchart'''
execute "Watch the pods running" '''watch oc get po'''
execute "view helm apps" '''helm ls'''
execute "Reinstall a new version of helm app" '''helm upgrade myhelmchart myhelmchart'''
execute "Rollback the version" '''helm rollback myhelmchart'''
execute "View history of apps" '''helm history myhelmchart'''
execute "Unintstall the app" '''helm uninstall myhelmchart'''
rm -rf myhelmchart
execute "Delete Project" ''' oc delete project mylab1'''
endofscript

echo "End of script"
