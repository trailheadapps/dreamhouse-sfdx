#!/usr/bin/env bash

set -o errexit    # always exit on error
set -o pipefail   # don't ignore exit codes when piping output
set -o nounset    # fail on unset variables

#################################################################
# Script to setup a fully configured pipeline for Salesforce DX #
#################################################################

### Declare values

# Create a unique var to append
TICKS=$(echo $(date +%s | cut -b1-13))

# Name of your team (optional)
HEROKU_TEAM_NAME="emea-hbb"

# Descriptive name for the Heroku app
HEROKU_APP_NAME="dhpackage"

# Name of the Heroku apps you'll use
# COMMENTED RANDOM NAME GENERATION
# HEROKU_DEV_APP_NAME="dev$TICKS"
# HEROKU_STAGING_APP_NAME="staging$TICKS"
# HEROKU_PROD_APP_NAME="prod$TICKS"
HEROKU_DEV_APP_NAME="devdh"
HEROKU_STAGING_APP_NAME="stagingdh"
HEROKU_PROD_APP_NAME="proddh"

# Pipeline
# COMMENTED RANDOM NAME GENERATION
# HEROKU_PIPELINE_NAME="pipeline$TICKS"
HEROKU_PIPELINE_NAME="dreamhousesfdx"

# Usernames or aliases of the orgs you're using
DEV_HUB_USERNAME="MyDevHub"
DEV_USERNAME="MyDevTestSB"
STAGING_USERNAME="MyStagingSB"
PROD_USERNAME="MyProd"

# Repository with your code
GITHUB_REPO="salesforceplatform/dreamhouse-sfdx"

# Your package name
PACKAGE_NAME="Dreamhouse-App"

### Setup script

# Support a Heroku team
HEROKU_TEAM_FLAG=""
if [ ! "$HEROKU_TEAM_NAME" == "" ]; then
  HEROKU_TEAM_FLAG="-t $HEROKU_TEAM_NAME"
fi

# Clean up script
echo "heroku pipelines:destroy $HEROKU_PIPELINE_NAME
heroku apps:destroy -a $HEROKU_DEV_APP_NAME -c $HEROKU_DEV_APP_NAME
heroku apps:destroy -a $HEROKU_STAGING_APP_NAME -c $HEROKU_STAGING_APP_NAME
heroku apps:destroy -a $HEROKU_PROD_APP_NAME -c $HEROKU_PROD_APP_NAME
rm -- \"destroy$TICKS.sh\"" > destroy$TICKS.sh

echo ""
echo "Run ./destroy$TICKS.sh to remove resources"
echo ""

chmod +x "destroy$TICKS.sh"

# Create three Heroku apps to map to orgs
heroku apps:create $HEROKU_DEV_APP_NAME $HEROKU_TEAM_FLAG
heroku apps:create $HEROKU_STAGING_APP_NAME $HEROKU_TEAM_FLAG
heroku apps:create $HEROKU_PROD_APP_NAME $HEROKU_TEAM_FLAG

# Set the stage (since STAGE isn't required, review apps don't get one)
heroku config:set STAGE=DEV -a $HEROKU_DEV_APP_NAME
heroku config:set STAGE=STAGING -a $HEROKU_STAGING_APP_NAME
heroku config:set STAGE=PROD -a $HEROKU_PROD_APP_NAME

# Set whether or not to use DCP packaging
heroku config:set SFDX_INSTALL_PACKAGE_VERSION=true -a $HEROKU_DEV_APP_NAME
heroku config:set SFDX_INSTALL_PACKAGE_VERSION=true -a $HEROKU_STAGING_APP_NAME
heroku config:set SFDX_INSTALL_PACKAGE_VERSION=true -a $HEROKU_PROD_APP_NAME

# Set whether to create package version
heroku config:set SFDX_CREATE_PACKAGE_VERSION=true -a $HEROKU_DEV_APP_NAME
heroku config:set SFDX_CREATE_PACKAGE_VERSION=false -a $HEROKU_STAGING_APP_NAME
heroku config:set SFDX_CREATE_PACKAGE_VERSION=false -a $HEROKU_PROD_APP_NAME

# Package name
heroku config:set SFDX_PACKAGE_NAME="$PACKAGE_NAME" -a $HEROKU_DEV_APP_NAME
heroku config:set SFDX_PACKAGE_NAME="$PACKAGE_NAME" -a $HEROKU_STAGING_APP_NAME
heroku config:set SFDX_PACKAGE_NAME="$PACKAGE_NAME" -a $HEROKU_PROD_APP_NAME

# Turn on debug logging
heroku config:set SFDX_BUILDPACK_DEBUG=true -a $HEROKU_DEV_APP_NAME
heroku config:set SFDX_BUILDPACK_DEBUG=true -a $HEROKU_STAGING_APP_NAME
heroku config:set SFDX_BUILDPACK_DEBUG=true -a $HEROKU_PROD_APP_NAME

# Setup sfdxUrl's for auth
devHubSfdxAuthUrl=$(sfdx force:org:display --verbose -u $DEV_HUB_USERNAME --json | jq -r .result.sfdxAuthUrl)
heroku config:set SFDX_DEV_HUB_AUTH_URL=$devHubSfdxAuthUrl -a $HEROKU_DEV_APP_NAME

devSfdxAuthUrl=$(sfdx force:org:display --verbose -u $DEV_USERNAME --json | jq -r .result.sfdxAuthUrl)
heroku config:set SFDX_AUTH_URL=$devSfdxAuthUrl -a $HEROKU_DEV_APP_NAME

stagingSfdxAuthUrl=$(sfdx force:org:display --verbose -u $STAGING_USERNAME --json | jq -r .result.sfdxAuthUrl)
heroku config:set SFDX_AUTH_URL=$stagingSfdxAuthUrl -a $HEROKU_STAGING_APP_NAME

stagingSfdxAuthUrl=$(sfdx force:org:display --verbose -u $PROD_USERNAME --json | jq -r .result.sfdxAuthUrl)
heroku config:set SFDX_AUTH_URL=$stagingSfdxAuthUrl -a $HEROKU_PROD_APP_NAME

# Add buildpacks to apps
heroku buildpacks:add -i 1 https://github.com/heroku/salesforce-cli-buildpack -a $HEROKU_DEV_APP_NAME
heroku buildpacks:add -i 1 https://github.com/heroku/salesforce-cli-buildpack -a $HEROKU_STAGING_APP_NAME
heroku buildpacks:add -i 1 https://github.com/heroku/salesforce-cli-buildpack -a $HEROKU_PROD_APP_NAME

heroku buildpacks:add -i 2 https://github.com/heroku/salesforce-buildpack -a $HEROKU_DEV_APP_NAME
heroku buildpacks:add -i 2 https://github.com/heroku/salesforce-buildpack -a $HEROKU_STAGING_APP_NAME
heroku buildpacks:add -i 2 https://github.com/heroku/salesforce-buildpack -a $HEROKU_PROD_APP_NAME

# Create Pipeline
# Valid stages: "test", "review", "development", "staging", "production"
heroku pipelines:create $HEROKU_PIPELINE_NAME -a $HEROKU_DEV_APP_NAME -s development $HEROKU_TEAM_FLAG
heroku pipelines:add $HEROKU_PIPELINE_NAME -a $HEROKU_STAGING_APP_NAME -s staging
heroku pipelines:add $HEROKU_PIPELINE_NAME -a $HEROKU_PROD_APP_NAME -s production

# Setup your pipeline
heroku pipelines:connect $HEROKU_PIPELINE_NAME --repo $GITHUB_REPO
heroku reviewapps:enable -p $HEROKU_PIPELINE_NAME -a $HEROKU_DEV_APP_NAME --autodeploy --autodestroy

heroku ci:config:set -p $HEROKU_PIPELINE_NAME SFDX_DEV_HUB_AUTH_URL=$devHubSfdxAuthUrl
heroku ci:config:set -p $HEROKU_PIPELINE_NAME SFDX_AUTH_URL=$devSfdxAuthUrl
heroku ci:config:set -p $HEROKU_PIPELINE_NAME SFDX_BUILDPACK_DEBUG=true
heroku ci:config:set -p $HEROKU_PIPELINE_NAME SFDX_INSTALL_PACKAGE_VERSION=true
heroku ci:config:set -p $HEROKU_PIPELINE_NAME SFDX_CREATE_PACKAGE_VERSION=false
heroku ci:config:set -p $HEROKU_PIPELINE_NAME SFDX_PACKAGE_NAME="$PACKAGE_NAME"
heroku ci:config:set -p $HEROKU_PIPELINE_NAME HEROKU_APP_NAME="$HEROKU_APP_NAME"