FROM phusion/baseimage:0.9.15
MAINTAINER "Charlie Jones" cjones73@gmail.com

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Versions
ENV SPARK_VERSION 1.6.1
ENV SPARK_HADOOP_VERSION 2.6

# Installing dependencies
RUN apt-get update && \
    apt-get install -y curl unzip python2.7 python-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set language
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Java Install
ENV JAVA_HOME /usr/jdk1.8.0_31
ENV PATH $PATH:$JAVA_HOME/bin
RUN curl -sL --retry 3 --insecure \
         --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
         "http://download.oracle.com/otn-pub/java/jdk/8u31-b13/server-jre-8u31-linux-x64.tar.gz" | \
    gunzip | \
    tar x -C /usr/ && \
    ln -s $JAVA_HOME /usr/java && \
    rm -rf $JAVA_HOME/man

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
