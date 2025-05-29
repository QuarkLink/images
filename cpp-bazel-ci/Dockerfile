FROM ubuntu:22.04

# 镜像元数据
LABEL maintainer="QuarkLink"
LABEL description="CI/CD build image for C++ projects with Bazel, clang tools, and coverage analysis"
LABEL version="1.0"

# 最小化CI环境 - 只包含必需工具
ENV DEBIAN_FRONTEND=noninteractive

# 安装最基本的CI工具
RUN apt update && apt install -y --no-install-recommends \
    wget \
    clang-format \
    clang-tidy \
    lcov \
    unzip \
    ca-certificates \
    git \
    g++ \
    make \
    bc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 安装Bazel
RUN wget -O bazel-installer.sh \
    "https://github.com/bazelbuild/bazel/releases/download/8.2.1/bazel-8.2.1-installer-linux-x86_64.sh" \
    && chmod +x bazel-installer.sh \
    && ./bazel-installer.sh \
    && rm bazel-installer.sh

# 验证安装
RUN bazel version && \
    clang-format --version && \
    clang-tidy --version && \
    lcov --version

# 创建具有root权限的ciuser用户
RUN groupadd -g 1000 ciuser && \
    useradd -u 1000 -g ciuser -G root -m -s /bin/bash ciuser

# 设置工作目录
WORKDIR /workspace
RUN chown ciuser:ciuser /workspace

# 预创建GitHub Actions工作目录
RUN mkdir -p /__w/_temp /__w/_actions /__w/_tool && \
    chgrp -R root /__w && \
    chmod -R g+w /__w

# 切换到ciuser用户
USER ciuser

# 默认命令
CMD ["/bin/bash"] 
