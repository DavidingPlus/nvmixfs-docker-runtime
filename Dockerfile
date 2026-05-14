FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV XMAKE_ROOT=y
ENV PATH="/root/.local/bin:${PATH}"

# 让 KERNEL_VERSION 可以在构建镜像时传入
ARG KERNEL_VERSION=5.4.0-216-generic

WORKDIR /app


# 安装基本依赖包。
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    build-essential \
    python3 \
    python3-pip \
    cmake \
    tzdata \
    linux-headers-${KERNEL_VERSION} \
    git \
    && rm -rf /var/lib/apt/lists/*

# 安装 XMake。
RUN curl -fsSL https://xmake.io/shget.text | bash

# 安装 Conan。
RUN pip3 install --no-cache-dir conan==2.6.0 \
    && conan profile detect


COPY . .
