#!/bin/sh

set -e

if [ ! -d "$HOME/.kube" ]; then
    mkdir -p $HOME/.kube
fi

if [ ! -f "$HOME/.kube/config" ]; then
    if [ ! -z "${AWS_ACCESS_KEY_ID}" ]      && \
       [ ! -z "${AWS_SECRET_ACCESS_KEY}" ]  && \
       [ ! -z "${AWS_SESSION_TOKEN}" ]      && \
       [ ! -z "${AWS_DEFAULT_REGION}" ]     && \
       [ ! -z "${EKS_CLUSTER}" ]; then

        aws eks --region $AWS_DEFAULT_REGION update-kubeconfig --name $EKS_CLUSTER

    else
        echo "No authorization data found. Please provide AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_SESSION_TOKEN, AWS_DEFAULT_REGION, EKS_CLUSTER variables. Exiting..."
        exit 1
    fi
fi

echo "/usr/local/bin/kubectl" >> $GITHUB_PATH

$*