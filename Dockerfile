FROM centos:7
MAINTAINER cjonesy


#-------------------------------------------------------------------------------
# Install dependencies
#-------------------------------------------------------------------------------
RUN yum install -y epel-release \
    yum install -y \
        java-1.8.0-openjdk java-1.8.0-openjdk-devel python-setuptools \
        python-devel postgresql-devel gcc libffi-devel openssl-devel libxml2 \
        libxml2-devel libxslt libxslt-devel htop && \
    yum clean all && \
    easy_install pip
    

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
