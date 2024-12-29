#!/bin/bash

source ../common.sh

echo -e  "\n Starting script --> create application, new deployment, enable pre and post lifecycle hook and redeploy it in Openshift Cluster"

prompt

execute "login to OCP4" '''oc login -u developer -p developer https://api.ocp4.example.com:6443'''
execute "Create New Project" '''oc new-project mylab1'''
echo "Creating New app for the bash app from git" 
echo '''oc new-app --strategy docker --name mybashapp --context-dir /lab8 https://github.com/arunprabhur/EX288.git --as-deployment-config -o yaml > application.yaml --> Executing Command'''
oc new-app --strategy docker --name mybashapp --context-dir /lab8 https://github.com/arunprabhur/EX288.git --as-deployment-config -o yaml > application.yaml
read -p "Please enter"

execute "Apply the app configfile" '''oc apply -f application.yaml'''
execute "Let's scale replicas to 5" '''oc scale --replicas 5 dc/mybashapp'''
execute "Check whether new build is created and running" '''watch -n 2 oc get po'''
execute "update dc with pre hook with default rolling strategy" '''oc set deployment-hook dc/mybashapp --failure-policy abort --pre -c mybashapp -- /opt/project/pre-hook.sh'''
execute "Rollout new version with only pre hook" '''oc rollout latest dc/mybashapp'''
execute "Watch the pods" '''watch -n 2 oc get po'''
execute "update dc with post hook with default rolling strategy" '''oc set deployment-hook dc/mybashapp --failure-policy abort --post -c mybashapp -- /opt/project/post-hook.sh'''
execute "Rollout new version with both pre and post hook" '''oc rollout latest dc/mybashapp'''
execute "watch pods agian" '''watch -n 2 oc get po'''
read -p "Press Enter to delete project"
execute "Deleting Project" '''oc delete project mylab1'''
endofscript

echo "End of script"
