#!/bin/sh
HEROKU=/usr/local/bin/heroku
LOCAL_DB=selectors_choice_dev
APP=selectorschoice
PGUSER=postgres

echo "Dropping $LOCAL_DB"
RAILS_ENV=development bundle exec rake db:drop
echo "Pulling db from heroku app $APP"
$HEROKU pg:pull DATABASE_URL $LOCAL_DB -a $APP
