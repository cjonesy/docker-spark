# docker-spark
[![Docker Hub](https://img.shields.io/badge/docker-ready-blue.svg)](https://hub.docker.com/r/cjonesy/docker-spark/)
[![Docker Build Status](https://img.shields.io/docker/build/cjonesy/docker-spark.svg)]()
[![Docker Pulls](https://img.shields.io/docker/pulls/cjonesy/docker-spark.svg)]()
[![Docker Stars](https://img.shields.io/docker/stars/cjonesy/docker-spark.svg)]()
[![Build Status](https://travis-ci.org/cjonesy/docker-spark.svg)](https://travis-ci.org/cjonesy/docker-spark/branches)

This repository contains **Dockerfile** of [Apache Spark](https://github.com/apache/spark) for [Docker](https://www.docker.com/)'s [automated build](https://hub.docker.com/r/cjonesy/docker-spark/) published to the public [Docker Hub Registry](https://registry.hub.docker.com/).

## Installation

Pull the image from the Docker repository.
```
docker pull cjonesy/docker-spark:latest
```

## Build
```
docker build --rm -t cjonesy/docker-spark:latest .
```

## Usage

### For a Spark shell inside the container
```
docker run -it cjonesy/docker-spark:latest spark-shell
```

### For a PySpark shell inside the container
```
docker run -it cjonesy/docker-spark:latest pyspark
```

### For a Bash shell inside the container
```
docker run -it cjonesy/docker-spark:latest bash
```

## Configuration

### spark-defaults.conf
It is possible to override the following values in `spark-defaults.conf` from environment variables.

| Property                      | Environment Variable          | Default Value            |
| ----------------------------- | ----------------------------- | ------------------------ |
| spark.driver.cores            | SPARK_DRIVER_CORES            | 1                        |
| spark.driver.maxResultSize    | SPARK_DRIVER_MAXRESULTSIZE    | 1g                       |
| spark.driver.memory           | SPARK_DRIVER_MEMORY           | 5g                       |
| spark.exector.memory          | SPARK_EXECUTOR_MEMORY         | 5g                       |
| spark.local.dir               | SPARK_LOCAL_DIR               | /tmp                     |
| spark.logConf                 | SPARK_LOGCONF                 | true                     |
| spark.master                  | SPARK_MASTER                  | local                    |
| spark.driver.supervise        | SPARK_DRIVER_SUPERVISE        | false                    |
| spark.driver.extraClassPath   | SPARK_DRIVER_EXTRACLASSPATH   | /jars/*                  |
| spark.executor.extraClassPath | SPARK_EXECUTOR_EXTRACLASSPATH | /jars/*                  |
| spark.python.worker.memory    | SPARK_PYTHON_WORKER_MEMORY    | 512m                     |
| spark.ui.enabled              | SPARK_UI_ENABLED              | true                     |
| spark.eventLog.enabled        | SPARK_EVENTLOG_ENABLED        | false                    |
| spark.eventLog.dir            | SPARK_EVENTLOG_DIR            | file:///tmp/spark-events |


Example:
```
docker run -e SPARK_UI_ENABLED=false -it cjonesy/docker-spark spark-shell
```

## How to contribute

*Imposter syndrome disclaimer*: I want your help. No really, I do.

There might be a little voice inside that tells you you're not ready; that you need to do one more tutorial, or learn another framework, or write a few more blog posts before you can help me with this project.

I assure you, that's not the case.

This project has some clear Contribution Guidelines and expectations that you can read here ([CONTRIBUTING](CONTRIBUTING.md)).

The contribution guidelines outline the process that you'll need to follow to get a patch merged. By making expectations and process explicit, I hope it will make it easier for you to contribute.

And you don't just have to write code. You can help out by writing documentation, tests, or even by giving feedback about this work. (And yes, that includes giving feedback about the contribution guidelines.)

Thank you for contributing!
