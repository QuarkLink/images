FROM ubuntu:24.04

# 镜像元数据
LABEL maintainer="QuarkLink"
LABEL description="CI/CD build image for C++ projects with Bazel, clang tools, and coverage analysis"
LABEL version="1.0"

# 最小化CI环境 - 只包含必需工具
ENV DEBIAN_FRONTEND=noninteractive

# 安装最基本的CI工具
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    unzip \
    build-essential \
    gcc \
    g++ \
    clang-format \
    clang-tidy \
    lcov \
    bc \
    sudo \
    # 添加一些额外的有用工具
    vim \
    tree \
    htop \
    python3 \
    python3-pip \
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

# 创建非root用户
RUN groupadd -r ciuser && useradd -r -g ciuser -m -s /bin/bash ciuser \
    && echo 'ciuser ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# 设置工作目录并修改权限
WORKDIR /workspace
RUN chown -R ciuser:ciuser /workspace

# 添加一些有用的别名和环境变量
RUN echo 'alias ll="ls -la"' >> /home/ciuser/.bashrc && \
    echo 'alias la="ls -la"' >> /home/ciuser/.bashrc && \
    echo 'export PATH="/usr/local/bin:$PATH"' >> /home/ciuser/.bashrc

# 切换到非root用户
USER ciuser

# 设置Git配置（CI环境常用）
RUN git config --global user.email "ci@example.com" && \
    git config --global user.name "CI User" && \
    git config --global init.defaultBranch main

# 默认命令
CMD ["/bin/bash"] 
