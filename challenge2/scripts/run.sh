#!/bin/sh
# set -e

export RESOURCE_GROUP="team12-challenge2-rg"
echo "Creating resource group"
az group create --name ${RESOURCE_GROUP} --location westus2

export EH_NAMESPACE="team12-eh-namespace"
echo "Creating Event Hub Namespace"
# Create an Event Hubs namespace. Specify a name for the Event Hubs namespace.
az eventhubs namespace create --verbose \
    --name ${EH_NAMESPACE} \
    --resource-group ${RESOURCE_GROUP} \
    --location westus2 \
    --enable-kafka true

export EH_NAME="team12-eh"
echo "Create Event Hub"
# Create an event hub. Specify a name for the event hub. 
az eventhubs eventhub create --name ${EH_NAME} \
    --resource-group ${RESOURCE_GROUP} \
    --namespace-name ${EH_NAMESPACE}