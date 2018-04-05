heroku pipelines:destroy pipeline1522920455
heroku apps:destroy -a dev1522920455 -c dev1522920455
heroku apps:destroy -a staging1522920455 -c staging1522920455
heroku apps:destroy -a prod1522920455 -c prod1522920455
rm -- "destroy1522920455.sh"
