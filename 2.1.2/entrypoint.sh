#!/usr/bin/env bash
set -e

# Overrides for spark-defaults.conf
if [[ -n $SPARK_DRIVER_CORES ]]; then
  sed -i "s/^spark.driver.cores.*$/spark.driver.cores $SPARK_DRIVER_CORES/" $SPARK_HOME/conf/spark-defaults.conf
fi

if [[ -n $SPARK_DRIVER_MAXRESULTSIZE ]]; then
  sed -i "s/^spark.driver.maxResultSize.*$/spark.driver.maxResultSize $SPARK_DRIVER_MAXRESULTSIZE/" $SPARK_HOME/conf/spark-defaults.conf
fi

if [[ -n $SPARK_DRIVER_MEMORY ]]; then
  sed -i "s/^spark.driver.memory.*$/spark.driver.memory $SPARK_DRIVER_MEMORY/" $SPARK_HOME/conf/spark-defaults.conf
fi

if [[ -n $SPARK_EXECUTOR_MEMORY ]]; then
  sed -i "s/^spark.executor.memory.*$/spark.executor.memory $SPARK_EXECUTOR_MEMORY/" $SPARK_HOME/conf/spark-defaults.conf
fi

if [[ -n $SPARK_LOCAL_DIR ]]; then
  sed -i "s/^spark.local.dir.*$/spark.local.dir $SPARK_LOCAL_DIR/" $SPARK_HOME/conf/spark-defaults.conf
fi

if [[ -n $SPARK_LOGCONF ]]; then
  sed -i "s/^spark.logConf.*$/spark.logConf $SPARK_LOGCONF/" $SPARK_HOME/conf/spark-defaults.conf
fi

if [[ -n $SPARK_MASTER ]]; then
  sed -i "s/^spark.master.*$/spark.master $SPARK_MASTER/" $SPARK_HOME/conf/spark-defaults.conf
fi

if [[ -n $SPARK_DRIVER_SUPERVISE ]]; then
  sed -i "s/^spark.driver.supervise.*$/spark.driver.supervise $SPARK_DRIVER_SUPERVISE/" $SPARK_HOME/conf/spark-defaults.conf
fi

if [[ -n $SPARK_DRIVER_EXTRACLASSPATH ]]; then
  sed -i "s/^spark.driver.extraClassPath.*$/spark.driver.extraClassPath $SPARK_DRIVER_EXTRACLASSPATH/" $SPARK_HOME/conf/spark-defaults.conf
fi

if [[ -n $SPARK_EXECUTOR_EXTRACLASSPATH ]]; then
  sed -i "s/^spark.executor.extraClassPath.*$/spark.executor.extraClassPath $SPARK_EXECUTOR_EXTRACLASSPATH/" $SPARK_HOME/conf/spark-defaults.conf
fi

if [[ -n $SPARK_PYTHON_WORKER_MEMORY ]]; then
  sed -i "s/^spark.python.worker.memory.*$/spark.python.worker.memory $SPARK_PYTHON_WORKER_MEMORY/" $SPARK_HOME/conf/spark-defaults.conf
fi

if [[ -n $SPARK_UI_ENABLED ]]; then
  sed -i "s/^spark.ui.enabled.*$/spark.ui.enabled $SPARK_UI_ENABLED/" $SPARK_HOME/conf/spark-defaults.conf
fi

if [[ -n $SPARK_EVENTLOG_ENABLED ]]; then
  sed -i "s/^spark.eventLog.enabled.*$/spark.eventLog.enabled $SPARK_EVENTLOG_ENABLED/" $SPARK_HOME/conf/spark-defaults.conf
fi

if [[ -n $SPARK_EVENTLOG_DIR ]]; then
  sed -i "s/^spark.eventLog.dir.*$/spark.eventLog.dir $SPARK_EVENTLOG_DIR/" $SPARK_HOME/conf/spark-defaults.conf
fi

echo "Executing: $@"
exec "$@"
