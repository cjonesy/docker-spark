#!/usr/bin/env bash
set -e

if [[ -n $SPARK_DEFAULTS ]]; then
IFS=';'; for default in $SPARK_DEFAULTS; do
    echo "$default" >> $SPARK_HOME/conf/spark-defaults.conf
done
else
cat > $SPARK_HOME/conf/spark-defaults.conf << EOF
spark.driver.memory              5g
spark.executor.memory            5g
spark.driver.extraClassPath      /jars/*
spark.executor.extraClassPath    /jars/*
EOF
fi

echo "Executing: $@"
exec $@
