#!/bin/bash

Usage="Usage: restart-failed-worker.sh"

if [ "$#" -ne 0 ]; then
  echo $Usage
  exit 1
fi

bin=`cd "$( dirname "$0" )"; pwd`

# Load the Tachyon configuration
. "$bin/tachyon-config.sh"

if [ -e $TACHYON_HOME/conf/tachyon-env.sh ] ; then
  . $TACHYON_HOME/conf/tachyon-env.sh
fi

RUN=`ps -ef | grep "tachyon.Worker" | grep "java" | wc | cut -d" " -f7`

if [[ $RUN -eq 0 ]] ; then
  echo "Restarting worker @ `hostname`"
#echo "($JAVA_HOME/bin/java -cp $TACHYON_JAR -Dtachyon.home=$TACHYON_HOME -Dtachyon.is.system=true -Dtachyon.logger.type="WORKER_LOGGER" $TACHYON_JAVA_OPTS tachyon.Worker `hostname`) &"
  ($JAVA_HOME/bin/java -cp $TACHYON_JAR -Dtachyon.home=$TACHYON_HOME -Dtachyon.is.system=true -Dtachyon.logger.type="WORKER_LOGGER" $TACHYON_JAVA_OPTS tachyon.Worker `hostname`) &
fi
