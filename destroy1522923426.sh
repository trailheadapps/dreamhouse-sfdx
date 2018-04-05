heroku pipelines:destroy dreamhousesfdx
heroku apps:destroy -a devdh -c devdh
heroku apps:destroy -a stagingdh -c stagingdh
heroku apps:destroy -a proddh -c proddh
rm -- "destroy1522923426.sh"
