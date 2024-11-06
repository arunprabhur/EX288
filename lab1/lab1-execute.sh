#!/bin/bash

source ../common.sh

echo "Starting script"
prompt

execute "login to OCP4" '''oc login -u developer -p developer https://api.ocp4.example.com:6443'''

endofscript

echo "End of script"
