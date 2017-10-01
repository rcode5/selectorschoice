#!/bin/sh
cwd=`dirname "$0"`
PRODUCTION=selectorschoice
DEVELOPMENT_DB=selectors_choice_dev

echo "Loading data into development from $PRODUCTION on heroku (destructive)..."

sleep 3

set -x

export RAILS_ENV=development
rake db:drop
heroku pg:pull DATABASE_URL $DEVELOPMENT_DB -a $PRODUCTION
