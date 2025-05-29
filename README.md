# CI Build Image

这是一个专门为C++项目CI/CD流水线设计的Docker镜像，包含了完整的开发和测试工具链。

## 包含的工具

### 基础工具
- `curl`, `wget` - 网络下载工具
- `git` - 版本控制
- `unzip` - 压缩文件处理
- `sudo` - 权限管理

### 编译工具
- `build-essential` - 基础编译工具
- `gcc`, `g++` - GNU编译器集合

### 代码质量工具
- `clang-format` - 代码格式化
- `clang-tidy` - 静态代码分析
- `lcov` - 代码覆盖率分析

### 构建系统
- `Bazel 8.2.1` - 现代构建工具

### 其他工具
- `bc` - 数学计算器（用于覆盖率计算）

## 使用方法

### 在GitHub Actions中使用

```yaml
name: CI Pipeline
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    container:
      image: your-registry/ci-image:latest
    steps:
      - uses: actions/checkout@v4
      - name: 运行测试
        run: |
          bazel test //...
```

### 本地开发使用

```bash
# 构建镜像
docker build -t ci-image .

# 运行容器
docker run -it --rm -v $(pwd):/workspace ci-image

# 在容器中执行命令
bazel build //...
bazel test //...
```

## 镜像信息

- **基础镜像**: Ubuntu 24.04
- **用户**: ciuser (非root用户)
- **工作目录**: /workspace
- **架构**: linux/x86_64

## 安全性

- 使用非root用户运行，提高安全性
- 最小化安装，减少攻击面
- 定期更新基础镜像

## 构建命令

```bash
docker build -t ci-image:latest .
```

## 版本历史

- `latest` - 包含最新的工具版本
- 基于Ubuntu 24.04 LTS
- Bazel 8.2.1 
