FROM arm64v8/ubuntu:16.04

RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apt-get update && apt-get install -y \
    pkg-config zip g++ zlib1g-dev unzip python python-numpy \
    build-essential openjdk-8-jdk git wget swig && \
    mkdir /workspace && \
    cd /workspace && \
    wget https://github.com/bazelbuild/bazel/releases/download/0.16.0/bazel-0.16.0-dist.zip && \
    mkdir bazel && \
    cd bazel && \
    unzip ../bazel-0.16.0-dist.zip && \
    bash ./compile.sh && \
    cd output && \
    cp bazel /usr/local/bin && \
    cd / && \
    rm -r /workspace/bazel && \
    rm /workspace/bazel-0.16.0-dist.zip && \
    wget --no-check-certificate https://dl.google.com/go/go1.10.3.linux-arm64.tar.gz && \
    tar -C /usr/local -xzf go1.10.3.linux-arm64.tar.gz && \
    rm go1.10.3.linux-arm64.tar.gz

ENV PATH=$PATH:/usr/local/go/bin
ENV GOPATH=/root/go

RUN mkdir -p $GOPATH/src/github.com/tensorflow && \
    cd $GOPATH/src/github.com/tensorflow && \
    git clone https://github.com/tensorflow/tensorflow.git && \
    cd tensorflow && \
    git checkout v1.10.0 && \
    # echo -e "\nn" | ./configure && \
    bazel build --config opt //tensorflow:libtensorflow.so

ENV LIBRARY_PATH=${GOPATH}/src/github.com/tensorflow/tensorflow/bazel-bin/tensorflow
ENV LD_LIBRARY_PATH=${GOPATH}/src/github.com/tensorflow/tensorflow/bazel-bin/tensorflow

RUN apt-get remove -y --auto-remove \
    wget git zip unzip

# CMD [ "sh", "-c", "echo $GOPATH" ]