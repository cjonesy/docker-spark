FROM phusion/baseimage:0.9.15
MAINTAINER Charlie Jones <cjones73@gmail.com>

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]


#-------------------------------------------------------------------------------
# Configuration Variables
#-------------------------------------------------------------------------------
ENV SPARK_VERSION=1.6.1 \
    SPARK_HADOOP_VERSION=2.6
ENV SPARK_PACKAGE=spark-$SPARK_VERSION-bin-hadoop$SPARK_HADOOP_VERSION


#-------------------------------------------------------------------------------
# Environment Variables
#-------------------------------------------------------------------------------
ENV SPARK_HOME=/usr/spark \
    JAVA_HOME=/usr/jdk1.8.0_31
ENV PATH=$PATH:$SPARK_HOME/bin:$JAVA_HOME/bin \
    PYTHONPATH=$SPARK_HOME/python/lib/py4j-0.9-src.zip:$SPARK_HOME/python/ \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8


#-------------------------------------------------------------------------------
# Perform Install
#-------------------------------------------------------------------------------
RUN echo "=======================================> Installing Dependencies" && \
    apt-get update && \
    apt-get install -y curl unzip python2.7 python-pip libpq-dev python-dev \
                       libffi-dev libyaml-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    echo "===============================================> Installing Java" && \
    curl -\#L --retry 3 --insecure \
         --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
         "http://download.oracle.com/otn-pub/java/jdk/8u31-b13/server-jre-8u31-linux-x64.tar.gz" | \
    gunzip | \
    tar x -C /usr/ && \
    ln -s $JAVA_HOME /usr/java && \
    rm -rf $JAVA_HOME/man && \
    echo "==============================================> Installing Spark" && \
    curl -\#L --retry 3 \
    "http://d3kbcqa49mib13.cloudfront.net/$SPARK_PACKAGE.tgz" | \
    gunzip | \
    tar x -C /usr/ && \
    ln -s /usr/$SPARK_PACKAGE $SPARK_HOME && \
    rm -rf /usr/$SPARK_PACKAGE/examples /usr/$SPARK_PACKAGE/ec2 && \
    rm /usr/$SPARK_PACKAGE/lib/spark-examples-*-hadoop*.jar
