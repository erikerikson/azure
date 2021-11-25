## validate assumptions
# if [ -z "${ENV+1}" ]; then
#   echo The environment variable ENV must be set - it indicates the environment into which the deployment is being made
#   exit 1
# fi

# Set shared constants but allow them to be overridden
if [ -z "${ENV+1}" ]; then
  export ENV=$(hostname)
fi
if [ -z "${SCOPE+1}" ]; then
  export SCOPE=SCOPE
fi
if [ -z "${PROJECT+1}" ]; then
  export PROJECT=PROJECT
fi
if [ -z "${REGION+1}" ]; then
  export REGION=westus2
fi

# Set shared variables
export PREFIX=$ENV-$SCOPE-$PROJECT
export RG=$PREFIX # Resource Group
export DN=$PREFIX # Deployment Name
