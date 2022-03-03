FROM centos:7 as builder


RUN yum install -y gcc make ctags && \
    curl -LO http://www.ftpproxy.org/download/ftpproxy-1.2.3.tgz && \
    mkdir /usr/local/man && \
    tar -zxf ftpproxy-1.2.3.tgz && \
    rm ftpproxy-1.2.3.tgz && \
    cd ftpproxy-1.2.3 && \
    make && \
    make install


FROM alpine:latest

COPY --from=builder /usr/local/sbin/ftp.proxy /usr/bin/ftproxy
