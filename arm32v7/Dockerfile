FROM arm32v7/ubuntu:16.04

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# RUN apt-get update && apt-get install -y \
#     wget git swig python-numpy pkg-config g++ zlib1g-dev \
#     build-essential openjdk-8-jdk python zip unzip \
#     nano python-pip python-dev python-wheel

RUN apt-get update && apt-get install -y \
    build-essential openjdk-8-jdk python zip unzip \
    wget git curl swig python-numpy

ENV BAZEL_JAVAC_OPTS="-J-Xms256m -J-Xmx512m"

RUN wget https://github.com/bazelbuild/bazel/releases/download/0.16.0/bazel-0.16.0-dist.zip && \
    mkdir bazel && \
    cd bazel && \
    unzip ../bazel-0.16.0-dist.zip && \
    bash ./compile.sh && \
    cd output && \
    cp bazel /usr/local/bin && \
    cd / && \
    rm -r /bazel && \
    rm bazel-0.16.0-dist.zip

RUN wget --no-check-certificate https://dl.google.com/go/go1.10.3.linux-armv6l.tar.gz && \
    tar -C /usr/local -xzf go1.10.3.linux-armv6l.tar.gz && \
    rm go1.10.3.linux-armv6l.tar.gz && \
    go get -u github.com/golang/dep/cmd/dep

ENV PATH=$PATH:/usr/local/go/bin
ENV GOPATH=/root/go

RUN DEP_VERSION=$(curl --silent "https://api.github.com/repos/golang/dep/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/') && \
    curl -fsSL -o /usr/local/bin/dep https://github.com/golang/dep/releases/download/$DEP_VERSION/dep-linux-amd64 && chmod +x /usr/local/bin/dep

RUN mkdir -p $GOPATH/src/github.com/tensorflow && \
    cd $GOPATH/src/github.com/tensorflow && \
    git clone https://github.com/tensorflow/tensorflow.git && \
    cd tensorflow && \
    git checkout v1.10.0 && \
    # echo -e "\nn" | ./configure && \
    # sed -i '\@https://github.com/google/protobuf/archive/0b059a3d8a8f8aa40dde7bea55edca4ec5dfea66.tar.gz@d' tensorflow/workspace.bzl && \
    # bazel build --config opt //tensorflow:libtensorflow.so
    bazel build -c opt --copt=-DRASPBERRY_PI --copt=-mfpu=neon-vfpv4 --copt=-std=gnu11 --copt=-DS_IREAD=S_IRUSR --copt=-DS_IWRITE=S_IWUSR --copt=-O3 --config=monolithic --copt=-funsafe-math-optimizations --copt=-ftree-vectorize --copt=-fomit-frame-pointer --local_resources 400,2.0,1.0 //tensorflow:libtensorflow.so

ENV LIBRARY_PATH=${GOPATH}/src/github.com/tensorflow/tensorflow/bazel-bin/tensorflow
ENV LD_LIBRARY_PATH=${GOPATH}/src/github.com/tensorflow/tensorflow/bazel-bin/tensorflow
