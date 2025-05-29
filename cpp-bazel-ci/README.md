# C++ Bazel CI 镜像

专门为C++项目CI/CD流水线设计的Docker镜像，集成了Bazel构建系统和完整的代码质量工具链。

## 🛠️ 包含的工具

### 基础工具
- `curl`, `wget` - 网络下载工具
- `git` - 版本控制系统
- `unzip` - 文件解压工具
- `sudo` - 权限管理工具

### 编译工具链
- `build-essential` - 基础编译工具包
- `gcc`, `g++` - GNU编译器集合
- `python3`, `python3-pip` - Python运行环境

### 代码质量工具
- `clang-format` - 代码格式化工具
- `clang-tidy` - 静态代码分析工具
- `lcov` - 代码覆盖率分析工具

### 构建系统
- **Bazel 8.2.1** - Google开源的现代构建工具

### 实用工具
- `bc` - 数学计算器（用于覆盖率阈值计算）
- `vim` - 文本编辑器
- `tree` - 目录结构显示工具
- `htop` - 系统监控工具

## 🚀 快速开始

### 本地构建
```bash
cd cpp-bazel-ci
docker build -t cpp-bazel-ci:latest .
```

### 运行容器
```bash
docker run -it --rm -v $(pwd):/workspace cpp-bazel-ci:latest
```

### 在GitHub Actions中使用
```yaml
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

## 📋 使用示例

### 代码格式检查
```bash
find . -name "*.cpp" -o -name "*.cc" -o -name "*.h" -o -name "*.hpp" \
  | xargs clang-format --dry-run --Werror
```

### 静态代码分析
```bash
# 生成编译数据库
bazel run @hedron_compile_commands//:refresh_all

# 运行静态分析
find . -name "*.cpp" -o -name "*.cc" | xargs clang-tidy -p .
```

### 生成覆盖率报告
```bash
# 运行覆盖率测试
bazel coverage //... --combined_report=lcov

# 生成HTML报告
genhtml bazel-out/_coverage/_coverage_report.dat -o coverage_html

# 检查覆盖率阈值
COVERAGE=$(lcov --summary bazel-out/_coverage/_coverage_report.dat 2>&1 | grep "lines......" | awk '{print $2}' | sed 's/%//')
echo "当前覆盖率: ${COVERAGE}%"
```

## 🔒 安全特性

- **非root用户**: 容器以`ciuser`用户身份运行，提高安全性
- **最小化镜像**: 只包含必需的CI工具，减少攻击面
- **权限控制**: 合理的sudo配置，满足CI需求

## 📊 镜像信息

- **基础镜像**: Ubuntu 24.04 LTS
- **用户**: ciuser (非root)
- **工作目录**: /workspace
- **架构**: linux/x86_64
- **大小**: 约 1.2GB

## 🔧 自定义配置

### 环境变量
```bash
# 设置Bazel配置
export BAZEL_OPTS="--disk_cache=/tmp/bazel_cache"

# 设置并行编译数
export BAZEL_JOBS=4
```

### Git配置
镜像预设了基本的Git配置，可以根据需要覆盖：
```bash
git config --global user.email "your-ci@example.com"
git config --global user.name "Your CI"
```

## 📝 更新日志

### v1.0
- 基于Ubuntu 24.04
- 集成Bazel 8.2.1
- 包含完整的C++开发工具链
- 支持代码质量检查和覆盖率分析 
