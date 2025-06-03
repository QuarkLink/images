# C++ Bazel CI/CD Docker 镜像

## 项目简介

这是一个专为C++项目CI/CD流水线设计的轻量级Docker镜像。镜像预装了Bazel构建系统、clang静态分析工具和代码覆盖率工具，为C++项目提供完整的持续集成环境。

## 主要特性

- **Bazel 8.2.1**: 现代化的构建系统，支持大规模C++项目
- **clang-format**: 自动化代码格式化工具
- **clang-tidy**: 静态代码分析和lint工具
- **lcov**: 代码覆盖率分析工具
- **基础开发工具**: git、g++、curl等必需工具
- **轻量级设计**: 最小化镜像大小，仅包含CI/CD必需组件
- **用户权限管理**: 内置ciuser用户，确保安全的构建环境

## 镜像详情

### 基础镜像
- Ubuntu 22.04 LTS

### 安装的工具版本
- Bazel: 8.2.1
- clang-format: 系统默认版本
- clang-tidy: 系统默认版本
- lcov: 系统默认版本
- g++: 系统默认版本

### 用户配置
- 用户名: `ciuser`
- 用户ID: 1001
- 组ID: 1000
- 工作目录: `/workspace`
