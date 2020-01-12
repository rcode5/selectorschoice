#!/bin/bash 
pg_restore --verbose --clean --no-acl --no-owner -h localhost -d selectors_choice_dev $1
