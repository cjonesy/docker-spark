FROM debian:jessie-slim
MAINTAINER cjonesy

ENV SPARK_HOME=/usr/spark
ENV PATH=$PATH:$SPARK_HOME/bin
ENV PYTHONPATH=$SPARK_HOME/python/:$SPARK_HOME/python/lib/py4j-0.10.4-src.zip:$SPARK_HOME/python/lib/
ENV PYSPARK_PYTHON=/usr/bin/python

# Install Dependencies
RUN echo 'deb http://deb.debian.org/debian jessie-backports main' > /etc/apt/sources.list.d/jessie-backports.list \
 && apt-get update -y \
 && mkdir /usr/share/man/man1 \
 && apt-get install -t jessie-backports -y \
            ca-certificates-java \
            openjdk-8-jre-headless \
            git \
            curl \
            python \
            zip \
            --no-install-recommends \
 && curl -o /tmp/get-pip.py https://bootstrap.pypa.io/get-pip.py \
 && python /tmp/get-pip.py --disable-pip-version-check --no-cache-dir \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /tmp/* \
 && apt-get clean

# Install Spark
ENV SPARK_VERSION=2.2.0
ENV HADOOP_VERSION=2.6

RUN curl --retry 3 \ 
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
