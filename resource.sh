#!/bin/sh

# Environment varialbes:
#   - K8S_SHELL_NAMESPACE
#     Default to 'default'.

NAMESPACE=${K8S_SHELL_NAMESPACE:-default}



qos() {

  kubectl get -n $NAMESPACE pods -o custom-columns=\
NAME:.metadata.name\
,UID:.metadata.uid\
,NODE:.spec.nodeName\
,QOS:.status.qosClass

}


resource_quota() {

  kubectl get -n $NAMESPACE deployments -o custom-columns=\
NAME:.metadata.name\
,MEMROY_REQUESTS:.spec.template.spec.containers[0].resources.requests.memory\
,CPU_REQUESTS:.spec.template.spec.containers[0].resources.requests.cpu\
,MEMORY_LIMITS:.spec.template.spec.containers[0].resources.limits.memory\
,CPU_LIMITS:.spec.template.spec.containers[0].resources.limits.cpu

} 


resource_quota_pod() {

  kubectl get -n $NAMESPACE pods -o custom-columns=\
NAME:.metadata.name,\
MEMROY_REQUESTS:.spec.containers[0].resources.requests.memory\
,CPU_REQUESTS:.spec.containers[0].resources.requests.cpu\
,MEMORY_LIMITS:.spec.containers[0].resources.limits.memory\
,CPU_LIMITS:.spec.containers[0].resources.limits.cpu

}

help() {
  echo "Usage:"
  echo "  sh resource.sh <function>"
  echo ""
  echo "Available functions:"
  echo "  - help"
  echo "  - qos"
  echo "  - resource_quota"
  echo "  - resource_quota_pod"
}

fn_name=${1:-help}

$fn_name
