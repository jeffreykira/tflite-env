FROM arm32v7/ubuntu:16.04

RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apt-get update && apt-get install -y \
    python-software-properties software-properties-common && \
    add-apt-repository ppa:webupd8team/java

RUN apt-get update && apt-get install -y \
    autoconf automake libtool \
    pkg-config zip g++ zlib1g-dev unzip oracle-java8-jdk \
    git vim curl wget gawk

RUN git clone https://github.com/google/protobuf.git && \
    cd protobuf && \
    git checkout v3.1.0 && \
    ./autogen.sh && \
    ./configure && \
    make -j 4 && \
    make install && \
    ldconfig

RUN wget https://github.com/bazelbuild/bazel/releases/download/0.5.1/bazel-0.5.1-dist.zip && \
    unzip -d bazel bazel-0.5.1-dist.zip && \
    cd bazel && \
    # vi scripts/bootstrap/compile.sh && \
    chmod u+w ./* -R && \
    ./compile.sh