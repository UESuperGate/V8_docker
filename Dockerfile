FROM centos:7

WORKDIR /root

ENV PATH=$PATH:"/root/depot_tools"

RUN yum groupinstall -y "Development Tools" \
	&& yum install -y git gdb bzip2 wget \
	&& git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git /root/depot_tools \
	&& echo 'export PATH=$PATH:"/root/depot_tools"' >> /root/.bashrc \
	&& fetch v8 \
    && cd v8 \
    && git checkout bdaa7d66a3 && gclient sync \
    && tools/dev/gm.py x64.release
