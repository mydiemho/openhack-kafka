#!/bin/sh
set -e

export RESOURCE_GROUP="team12-rg-2"
export AKS_CLUSTER="team12-aks"
echo "Creating resource group"
az group create --name ${RESOURCE_GROUP} --location westus2

echo "Creating AKS cluster"
az aks create \
    --resource-group ${RESOURCE_GROUP} \
    --name ${AKS_CLUSTER} \
    --node-count 3 \
    --enable-addons monitoring \
    --generate-ssh-keys

az aks get-credentials --resource-group ${RESOURCE_GROUP} --name ${AKS_CLUSTER}   
