#!/bin/sh
set -e

export RESOURCE_GROUP="team12-rg"

echo "Creating resource group"
az group create --name ${RESOURCE_GROUP} --location westus2

echo "Creating AKS cluster"
az aks create \
    --resource-group ${RESOURCE_GROUP} \
    --name MyAKS \
    --node-count 3 \
    --enable-addons monitoring \
    --generate-ssh-keys

echo "Setting up dev spaces"
az aks use-dev-spaces -g ${RESOURCE_GROUP} -n MyAKS