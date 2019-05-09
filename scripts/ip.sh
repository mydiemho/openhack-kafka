#!/bin/sh

set -e

export RESOURCE_GROUP="team12-rg-2"
export AKS_CLUSTER="team12-aks"

NODE_RESOURCE_GROUP=$(az aks show --resource-group ${RESOURCE_GROUP} --name ${AKS_CLUSTER} --query nodeResourceGroup -o tsv)
echo ${NODE_RESOURCE_GROUP}

for instance in 0 1 2; do
    echo "set up static ip"
    IP_NAME="${AKS_CLUSTER}-${instance}"
    az network public-ip create \
        --resource-group ${NODE_RESOURCE_GROUP} \
        --name ${IP_NAME} \
        --allocation-method static
done

echo "IP addresses:"
for instance in 0 1 2; do
    IP_NAME="${AKS_CLUSTER}-${instance}"
    PUBLIC_IP=$(az network public-ip show --resource-group ${NODE_RESOURCE_GROUP} --name ${IP_NAME} --query ipAddress --output tsv)
    echo ${PUBLIC_IP}
done