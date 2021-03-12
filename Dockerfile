FROM ubuntu:20.04

WORKDIR /root

RUN apt update && apt install -y git wget curl python2.7 && \
    git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git && \
    export PATH=$PATH:"/root/depot_tools" && \
    fetch v8 && cd v8 && git checkout bdaa7d66a3 && gclient sync && \
    tools/dev/gm.py x64.release
