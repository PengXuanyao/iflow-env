# syntax=docker/dockerfile:1
ARG BASE_IMAGE=ubuntu:20.04
FROM ${BASE_IMAGE}
LABEL maintainer="https://hub.docker.com/u/iedaopensource"

ARG IFLOW_WORKSPACE=/opt/iFlow
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends git && \
    git clone https://gitee.com/oscc-project/iFlow.git ${IFLOW_WORKSPACE}

ENV TZ=Asia/Shanghai

RUN ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime && \
    export DEBIAN_FRONTEND=noninteractive           && \
    bash ${IFLOW_WORKSPACE}/build_iflow.sh          && \
    rm -rf ${IFLOW_WORKSPACE}/tools/lemon-1.3.1*    && \
    apt-get autoremove -y && apt-get clean -y
RUN strip --remove-section=.note.ABI-tag /usr/lib/x86_64-linux-gnu/libQt5Core.so.5

WORKDIR ${IFLOW_WORKSPACE}/scripts

# build this image use:
#  docker build -t iflow .
