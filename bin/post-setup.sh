#!/usr/bin/env bash

TARGET_ORG_ALIAS=${1:-}
STAGE=${2:-}

### Not required
### This script will execute after the org has been setup
sfdx force:org:open
sfdx force:user:permset:assign -n dreamhouse
sfdx force:data:tree:import -p data/sample-data-plan.json
sfdx force:apex:test:run -w 3