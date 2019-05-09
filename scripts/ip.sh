#!/bin/sh

set -e

echo "set up static ip"
export RESOURCE_GROUP="team12-rg"

NODE_RESOURCE_GROUP=$(az aks show --resource-group ${RESOURCE_GROUP} --name myAKS --query nodeResourceGroup -o tsv)
echo ${NODE_RESOURCE_GROUP}

az network public-ip create \
    --resource-group ${NODE_RESOURCE_GROUP} \
    --name myAKSPublicIP \
    --allocation-method static

PUBLIC_IP=$(az network public-ip show --resource-group ${NODE_RESOURCE_GROUP} --name myAKSPublicIP --query ipAddress --output tsv)
echo ${PUBLIC_IP}