# A project for managing Azure ARM deployments

TL;DR: `^(deploy)+remove$` # many deployments followed by a single remove


The following assumes you've run:

```
az login
```

[Optional] Then you can define your environment: # defaults to `$(hostname)`

```
ENV=dev
```

Deploy with:

```
./deploy.sh
```

Remove with:

```
./remove.sh
```

## What

Both deploy.sh and remove.sh load constants and variables into the environment by calling vars.sh and use those to deploy or remove the resources described in deploy.json

The deployment model is that an entire resource group is deployed containing only those resources declared in deploy.json, using the parameter definitions defined in deploy.$ENV.json.  This is accomplished by doing a "Complete" deployment to the resource group.  This deployment (and the deploy.json) must be the exclusive contributor to deploy.json.  Anything else that is added to that resource group and not represented in deploy.json will be deleted during the next deployment.  Otherwise, one ends up with a accumulative history of assets deployed by the ARM template without a record of what resources they are or how to remove them.

To remove a complete resource group deployment is enacted but with an empty resource group.  Once that has succeeded the resource group itself is deleted.  This order ensures that removal is completed before the script exits, avoiding timing issues, especially during scripting.

## Conventions

There is a prefix defined herein.  This prefix SHOULD be composed of `$ENV-$SCOPE-$PROJECT`.  The prefix SHOULD be used as the resource group name.  The prefix SHOULD be used as a prefix for all resource names in the format `${PREFIX}-${RESOURCE}`.

Using this convention, like namespaces, avoids conflicts.  Particularly importantly it ensures that unique environments can be deployed in parallel without conflict so that each engineer can have their own environment without contention.  It is expected that continuous integration and shared environments will be used to provide conflict detection.
