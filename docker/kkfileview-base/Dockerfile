FROM ubuntu:24.04

# Update sources to use Aliyun mirrors and install required packages
RUN sed -i 's@//archive.ubuntu.com@//mirrors.aliyun.com@g' /etc/apt/sources.list && \
    sed -i 's@//security.ubuntu.com@//mirrors.aliyun.com@g' /etc/apt/sources.list && \
    apt-get update && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y --no-install-recommends \
        openjdk-8-jre \
        tzdata \
        locales \
        xfonts-utils \
        fontconfig \
        libreoffice-nogui \
        ttf-mscorefonts-installer \
        ttf-wqy-microhei \
        ttf-wqy-zenhei \
        xfonts-wqy && \
    echo 'Asia/Ho_Chi_Minh' > /etc/timezone && \
    ln -sf /usr/share/zoneinfo/Asia/Ho_Chi_Minh /etc/localtime && \
    localedef -i zh_CN -c -f UTF-8 -A /usr/share/locale/locale.alias zh_CN.UTF-8 && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set environment variables for locale
ENV LANG=zh_CN.UTF-8 LC_ALL=zh_CN.UTF-8
