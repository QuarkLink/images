# Docker CI/CD 镜像仓库

这个仓库维护了多个专门用于CI/CD流水线的Docker镜像，每个镜像针对不同的技术栈和使用场景进行优化。

## 🐳 可用镜像

### [cpp-bazel-ci](./cpp-bazel-ci/)
专门为C++项目CI/CD流水线设计的镜像，集成了Bazel构建系统和完整的代码质量工具链。

- **基础镜像**: Ubuntu 24.04 LTS
- **构建系统**: Bazel 8.2.1
- **编译器**: GCC, G++
- **代码质量**: clang-format, clang-tidy
- **覆盖率**: lcov
- **大小**: ~1.2GB

**使用场景**: C++项目的编译、测试、代码质量检查和覆盖率分析

```bash
# 使用示例
docker pull ghcr.io/your-org/images/cpp-bazel-ci:latest
```

## 📁 仓库结构

```
images/
├── .github/workflows/          # CI/CD 工作流
│   └── build-images.yml       # 多镜像构建流程
├── cpp-bazel-ci/              # C++ Bazel CI 镜像
│   ├── Dockerfile             # 镜像定义
│   ├── README.md              # 详细文档
│   ├── Makefile               # 构建脚本
│   └── .dockerignore          # 构建忽略文件
├── examples/                   # 使用示例
│   └── github-actions.yml     # GitHub Actions 示例
└── README.md                   # 本文档
```

## 🚀 快速开始

### 选择镜像
根据您的项目技术栈选择合适的镜像：

- **C++项目**: 使用 `cpp-bazel-ci`
- **其他语言**: 即将支持...

### 本地构建

```bash
# 构建特定镜像
cd cpp-bazel-ci
make build

# 测试镜像
make test

# 运行交互式容器
make run
```

### 在GitHub Actions中使用

```yaml
name: CI Pipeline
on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    container:
      image: ghcr.io/your-org/images/cpp-bazel-ci:latest
    steps:
      - uses: actions/checkout@v4
      - name: 构建项目
        run: bazel build //...
      - name: 运行测试
        run: bazel test //...
```

## 🔄 自动化构建

本仓库使用GitHub Actions实现自动化构建和发布：

- **变更检测**: 只构建有文件变更的镜像
- **PR测试**: Pull Request会构建和测试镜像，但不推送
- **自动发布**: 合并到主分支后自动构建并推送到GitHub Container Registry
- **多平台支持**: 支持linux/x86_64架构

### 镜像标签策略

- `latest`: 主分支的最新版本
- `vX.Y.Z`: 语义化版本标签
- `branch-name`: 分支构建版本
- `pr-N`: Pull Request构建版本

## 📋 添加新镜像

要添加新的CI镜像，请按以下步骤操作：

1. **创建镜像目录**
   ```bash
   mkdir new-image-name
   cd new-image-name
   ```

2. **添加必需文件**
   - `Dockerfile` - 镜像定义
   - `README.md` - 镜像文档
   - `Makefile` - 构建脚本
   - `.dockerignore` - 构建忽略

3. **更新CI工作流**
   在`.github/workflows/build-images.yml`中添加新镜像的构建作业

4. **更新主README**
   在本文档中添加新镜像的说明

## 🔒 安全性

所有镜像都遵循以下安全最佳实践：

- **非root用户**: 容器以非特权用户运行
- **最小化原则**: 只包含必需的工具和依赖
- **定期更新**: 基础镜像和工具定期更新
- **扫描检查**: 自动化安全扫描（规划中）

## 🤝 贡献指南

欢迎贡献新的镜像或改进现有镜像！

1. Fork本仓库
2. 创建特性分支: `git checkout -b feature/new-image`
3. 提交变更: `git commit -m '添加新镜像'`
4. 推送分支: `git push origin feature/new-image`
5. 创建Pull Request

## 📞 支持

如果您在使用过程中遇到问题，请：

1. 查看对应镜像的README文档
2. 检查[Issues](../../issues)中是否有相关问题
3. 创建新的Issue描述问题

## 📄 许可证

本项目采用MIT许可证，详见[LICENSE](./LICENSE)文件。
