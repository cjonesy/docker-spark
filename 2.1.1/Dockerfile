FROM centos:7
MAINTAINER cjonesy

ENV SPARK_HOME=/usr/spark
ENV PATH=$PATH:$SPARK_HOME/bin
ENV PYTHONPATH=$SPARK_HOME/python/:$SPARK_HOME/python/lib/py4j-0.10.4-src.zip:$SPARK_HOME/python/lib/
ENV PYSPARK_PYTHON=/usr/bin/python

# Install Dependencies
RUN yum install -y \
        python \
        zip \
        java-1.8.0-openjdk \
 && yum clean all \
 && curl -o /tmp/get-pip.py https://bootstrap.pypa.io/get-pip.py \
 && python /tmp/get-pip.py --disable-pip-version-check --no-cache-dir \
 && rm -rf /var/cache/yum \
 && rm -rf /tmp/*

# Install Spark
ENV SPARK_VERSION=2.1.1
ENV HADOOP_VERSION=2.6

RUN curl -L --retry 3 \
    "https://archive.apache.org/dist/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION.tgz" | \
    gunzip | tar x -C /usr/ \
 && ln -s /usr/spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION $SPARK_HOME \
 && rm -rf $SPARK_HOME/examples

COPY spark-defaults.conf $SPARK_HOME/conf/spark-defaults.conf

COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

# SparkContext web UI on 4040
# Spark driver web UI on 8080
# Spark executor web UI on 8081
EXPOSE 4040 8080 8081

CMD ["sh"]
