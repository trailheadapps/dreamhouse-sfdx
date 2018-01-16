#!/bin/bash

sfdx force:org:create -s -a usertest -f config/project-scratch-def.json
sfdx force:source:push
sfdx force:user:permset:assign -n dreamhouse
sfdx force:data:tree:import -p assets/data/Broker__c-Property__c-plan.json