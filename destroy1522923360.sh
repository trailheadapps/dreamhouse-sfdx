heroku pipelines:destroy dreamhousesfdx
heroku apps:destroy -a devDH -c devDH
heroku apps:destroy -a stagingDH -c stagingDH
heroku apps:destroy -a prodDH -c prodDH
rm -- "destroy1522923360.sh"
