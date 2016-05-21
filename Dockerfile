FROM java:8-jre-alpine
MAINTAINER "Charlie Jones" cjones73@gmail.com

# Versions
ENV SPARK_VERSION 1.6.1
ENV SPARK_HADOOP_VERSION 2.6

# Installing dependencies
RUN apk add --no-cache bash python py-pip curl unzip

# Spark Install
ENV SPARK_PACKAGE spark-$SPARK_VERSION-bin-hadoop$SPARK_HADOOP_VERSION
ENV SPARK_HOME /usr/spark-$SPARK_VERSION
ENV PATH $PATH:$SPARK_HOME/bin
RUN echo $SPARK_PACKAGE
RUN curl -sL --retry 3 "http://d3kbcqa49mib13.cloudfront.net/$SPARK_PACKAGE.tgz" | \
    gunzip | \
    tar x -C /usr/ && \
    mv /usr/$SPARK_PACKAGE $SPARK_HOME && \
    rm -rf $SPARK_HOME/examples $SPARK_HOME/ec2 && \
    rm $SPARK_HOME/lib/spark-examples-*-hadoop*.jar

CMD ["tail -f /dev/null"]
