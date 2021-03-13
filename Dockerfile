FROM ubuntu:18.04

WORKDIR /root

RUN apt update && apt install -y git wget curl python2.7 pkg-config && \
    ln /usr/bin/python2.7 /usr/bin/python2 && \
    ln /usr/bin/python2.7 /usr/bin/python && \
    git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git && \
    export PATH=$PATH:"/root/depot_tools" && \
    fetch v8 && \
    groupadd -r v8ers && useradd -r -g v8ers v8er
RUN wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/1.12/gosu-amd64" && \
    chmod +x /usr/local/bin/gosu && \
    gosu nobody true

CMD [ "exec", "gosu", "v8er", "/root/v8/build/install-build-deps.sh" ]

WORKDIR /root/v8

RUN export PATH=$PATH:"/root/depot_tools" && \
    git checkout bdaa7d66a3 && \
    gclient sync && \
    tools/dev/gm.py x64.debug
