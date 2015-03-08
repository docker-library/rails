#!/bin/bash

[ "$RUN_BUNDLE_INSTALL" == "false" ] || bundle install
[ "$RUN_MIGRATIONS" == "true" ] && rake db:migrate
[ "$RUN_DB_SETUP" == "true" ] && rake db:setup
[ -n "$RUN_INIT_SCRIPT" ] && $RUN_INIT_SCRIPT

exec "$@"
