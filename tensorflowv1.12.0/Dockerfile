FROM arm32v7/ubuntu:16.04

RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apt-get update && apt-get install -y \
    wget git swig python-numpy \
    build-essential openjdk-8-jdk python zip unzip

RUN wget https://github.com/bazelbuild/bazel/releases/download/0.21.0/bazel-0.21.0-dist.zip && \
    mkdir bazel && \
    cd bazel && \
    unzip ../bazel-0.21.0-dist.zip && \
    bash ./compile.sh && \