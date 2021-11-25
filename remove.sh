# load shared variables
. vars.sh

# perform the initial deployment
az group deployment create --resource-group $RG --name $DN \
        --template-file remove.json \
        --mode Complete \
        --parameters @$ENV.deploy.json

# create a resource group for this deployment
az group delete -n $RG
