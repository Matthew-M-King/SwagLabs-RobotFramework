#!/bin/bash -x
echo "ENV_SETUP"
echo $ENV_SETUP
echo "PLATFORM"
echo $PLATFORM
source $ENV_SETUP
export LD_LIBRARY_PATH=$$LDLIBRARY_PATH:/usr/lib/x86_64-linux-gnu/odbc/
ROBOT_OPTIONS="--output output/output.xml --log output/log.html --report output/report.html"
if [ "$DRY_RUN" = "true" ]; then
    ROBOT_OPTIONS+=" --dryrun"
fi
export ROBOT_OPTIONS
robot $ROBOT_OPTIONS -L trace -v target_sut:$PLATFORM $@ || true