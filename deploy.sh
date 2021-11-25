# load shared variables
. vars.sh

# create a resource group for this deployment
az group create -l $REGION -n $RG

# perform the initial deployment
az group deployment create --resource-group $RG --name $DN \
        --template-file deploy.json \
        --mode Complete \
        --parameters @$ENV.deploy.json
        --parameters PREFIX=$PREFIX
