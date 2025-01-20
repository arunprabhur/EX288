#!/bin/bash

source ../common.sh

echo -e  "\n Starting script --> Using pipeline and understanding tekton commands in Openshift Cluster"

prompt

execute "login to OCP4" '''oc login -u developer -p developer https://api.ocp4.example.com:6443'''
execute "Create New Project" '''oc new-project mylab1'''
execute "View customTask.yaml" '''cat customTask.yaml'''
execute "View mypipeline.yaml" '''cat mypipeline.yaml'''
execute "Apply & create customTask" '''oc apply -f customTask.yaml'''
execute "Apply & create MyPipeline" '''oc apply -f mypipeline.yaml'''
execute "view the pipeline using tekton" '''tkn p describe mysecond-pipeline'''
execute "view the task using tekton" '''tkn t describe mysecondtask'''
execute "Trigger the pipeline from tekton" '''tkn p start mysecond-pipeline -w name=pipeworkspace,volumeClaimTemplateFile=shared-volume-pipeline.yaml'''
execute "view logs of pipeline" '''tkn p logs mysecond-pipeline -f'''
execute "view pipeline run from tekton" '''tkn pr ls'''
execute "Deleting the project" '''oc delete project mylab1'''
endofscript

echo "End of script"
