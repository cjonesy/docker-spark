FROM centos:7
MAINTAINER cjonesy

#-------------------------------------------------------------------------------
# Install dependencies
#-------------------------------------------------------------------------------
RUN yum install -y python-setuptools python-devel gcc wget && \
    yum clean all && \
    easy_install pip


#-------------------------------------------------------------------------------
# Install Java
#-------------------------------------------------------------------------------
ENV JAVA_VERSION=8u101
ENV JAVA_BUILD=13
ENV JAVA_HOME=/usr/java/default

RUN wget --no-cookies --no-check-certificate \
         --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
         "http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}-b${JAVA_BUILD}/jdk-${JAVA_VERSION}-linux-x64.rpm" \
         -O /tmp/jdk-${JAVA_VERSION}-linux-x64.rpm && \
         yum localinstall -y /tmp/jdk-${JAVA_VERSION}-linux-x64.rpm && \
         rm /tmp/jdk-${JAVA_VERSION}-linux-x64.rpm


#-------------------------------------------------------------------------------
# Install Hadoop
#-------------------------------------------------------------------------------
ENV HADOOP_VERSION=2.6.4
ENV HADOOP_HOME=/usr/hadoop
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV PATH=$PATH:$HADOOP_HOME/bin

RUN curl -L --retry 3 \
    "http://www.gtlib.gatech.edu/pub/apache/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz" | \
    gunzip | tar x -C /usr/ && \
    ln -s /usr/hadoop-$HADOOP_VERSION $HADOOP_HOME && \
    rm -rf $HADOOP_HOME/share/doc


#-------------------------------------------------------------------------------
# Install Spark
#-------------------------------------------------------------------------------
ENV SPARK_VERSION=1.6.1
ENV SPARK_HOME=/usr/spark
ENV SPARK_DIST_CLASSPATH="$HADOOP_HOME/etc/hadoop/*:$HADOOP_HOME/share/hadoop/common/lib/*:$HADOOP_HOME/share/hadoop/common/*:$HADOOP_HOME/share/hadoop/hdfs/*:$HADOOP_HOME/share/hadoop/hdfs/lib/*:$HADOOP_HOME/share/hadoop/hdfs/*:$HADOOP_HOME/share/hadoop/yarn/lib/*:$HADOOP_HOME/share/hadoop/yarn/*:$HADOOP_HOME/share/hadoop/mapreduce/lib/*:$HADOOP_HOME/share/hadoop/mapreduce/*:$HADOOP_HOME/share/hadoop/tools/lib/*"
ENV PATH=$PATH:$SPARK_HOME/bin
ENV PYTHONPATH=$SPARK_HOME/python/lib/py4j-0.9-src.zip:$SPARK_HOME/python/
ENV PYSPARK_PYTHON=/usr/bin/python

RUN curl -L --retry 3 \
    "http://d3kbcqa49mib13.cloudfront.net/spark-$SPARK_VERSION-bin-without-hadoop.tgz" | \
    gunzip | tar x -C /usr/ && \
    ln -s /usr/spark-$SPARK_VERSION-bin-without-hadoop $SPARK_HOME && \
    rm -rf $SPARK_HOME/examples $SPARK_HOME/ec2 && \
    rm $SPARK_HOME/lib/spark-examples-*-hadoop*.jar


#-------------------------------------------------------------------------------
# Entry
#-------------------------------------------------------------------------------
ENTRYPOINT ["sh", "-c"]
