#!/bin/sh

# Environment varialbes:
#   - K8S_TOOL_NAMESPACE
#     Default to 'default'.

NAMESPACE=${K8S_TOOL_NAMESPACE:-default}




RESOURCE_QUOTA_COLUMNS=NAME:.metadata.name\
,MEMROY_REQUESTS:.spec.template.spec.containers[0].resources.requests.memory\
,CPU_REQUESTS:.spec.template.spec.containers[0].resources.requests.cpu\
,MEMORY_LIMITS:.spec.template.spec.containers[0].resources.limits.memory\
,CPU_LIMITS:.spec.template.spec.containers[0].resources.limits.cpu




qos() {

  kubectl get -n $NAMESPACE pods -o custom-columns=\
NAME:.metadata.name\
,UID:.metadata.uid\
,NODE:.spec.nodeName\
,QOS:.status.qosClass

}


resource_quota() {

  kubectl get -n $NAMESPACE deployments -o custom-columns=$RESOURCE_QUOTA_COLUMNS

} 


resource_quota_pod() {

  kubectl get -n $NAMESPACE pods -o custom-columns=$RESOURCE_QUOTA_COLUMNS

}

fn_name=$1

$fn_name
