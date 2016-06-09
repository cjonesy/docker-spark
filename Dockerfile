FROM java:8-jre-alpine
MAINTAINER cjonesy


#-------------------------------------------------------------------------------
# Spark configs
#-------------------------------------------------------------------------------
ENV SPARK_VERSION=1.6.1 \
    SPARK_HADOOP_VERSION=2.6
ENV SPARK_PACKAGE=spark-$SPARK_VERSION-bin-hadoop$SPARK_HADOOP_VERSION


#-------------------------------------------------------------------------------
# Set Environment Variables
#-------------------------------------------------------------------------------
ENV SPARK_HOME=/usr/spark
ENV PATH=$PATH:$SPARK_HOME/bin \
    PYTHONPATH=$SPARK_HOME/python/lib/py4j-0.9-src.zip:$SPARK_HOME/python/


#-------------------------------------------------------------------------------
# Install Spark and dependencies
#-------------------------------------------------------------------------------
RUN apk add --no-cache bash python py-pip curl unzip gcc postgresql-dev \
                       python-dev musl-dev libffi-dev && \
    curl -sL --retry 3 \
    "http://d3kbcqa49mib13.cloudfront.net/$SPARK_PACKAGE.tgz" | \
    gunzip | tar x -C /usr/ && \
    ln -s /usr/$SPARK_PACKAGE $SPARK_HOME && \
    rm -rf $SPARK_HOME/examples $SPARK_HOME/ec2 && \
    rm $SPARK_HOME/lib/spark-examples-*-hadoop*.jar


#-------------------------------------------------------------------------------
# Entry
#-------------------------------------------------------------------------------
ENTRYPOINT ["sh", "-c"]
CMD ["tail", "-f", "/dev/null"]
