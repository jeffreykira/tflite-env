FROM jingweiwu/arm64v8_tflite:0.2

RUN rm /bin/sh && ln -s /bin/bash /bin/sh
ENV PATH=$PATH:/usr/local/go/bin
ENV GOPATH=/root/go
ENV LIBRARY_PATH=${GOPATH}/src/github.com/tensorflow/tensorflow/bazel-bin/tensorflow
ENV LD_LIBRARY_PATH=${GOPATH}/src/github.com/tensorflow/tensorflow/bazel-bin/tensorflow

CMD [ "sh", "-c", "echo $GOPATH" ]