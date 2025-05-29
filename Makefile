# CI镜像构建和管理
.PHONY: build test push clean help

# 变量定义
IMAGE_NAME ?= ci-image
TAG ?= latest
REGISTRY ?= ghcr.io/your-org
FULL_IMAGE_NAME = $(REGISTRY)/$(IMAGE_NAME):$(TAG)

help: ## 显示帮助信息
	@echo "可用命令:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

build: ## 构建Docker镜像
	@echo "🔨 构建镜像: $(FULL_IMAGE_NAME)"
	docker build -t $(FULL_IMAGE_NAME) .
	docker tag $(FULL_IMAGE_NAME) $(IMAGE_NAME):$(TAG)
	@echo "✅ 镜像构建完成"

test: ## 测试构建的镜像
	@echo "🧪 测试镜像功能..."
	docker run --rm $(IMAGE_NAME):$(TAG) bash -c "\
		echo '=== 验证工具版本 ===' && \
		bazel version && \
		echo '=== 验证编译器 ===' && \
		gcc --version && \
		g++ --version && \
		echo '=== 验证代码质量工具 ===' && \
		clang-format --version && \
		clang-tidy --version && \
		echo '=== 验证覆盖率工具 ===' && \
		lcov --version && \
		echo '=== 验证用户权限 ===' && \
		whoami && \
		pwd && \
		echo '✅ 所有工具验证通过'"

run: ## 运行镜像进行交互式测试
	@echo "🚀 启动交互式容器..."
	docker run -it --rm -v $(PWD):/workspace $(IMAGE_NAME):$(TAG)

push: ## 推送镜像到仓库
	@echo "📤 推送镜像到仓库..."
	docker push $(FULL_IMAGE_NAME)
	@echo "✅ 镜像推送完成"

clean: ## 清理本地镜像
	@echo "🧹 清理本地镜像..."
	docker rmi -f $(IMAGE_NAME):$(TAG) $(FULL_IMAGE_NAME) 2>/dev/null || true
	@echo "✅ 清理完成"

size: ## 显示镜像大小
	@echo "📏 镜像大小信息:"
	docker images $(IMAGE_NAME):$(TAG)

login: ## 登录到容器仓库
	@echo "🔐 登录到容器仓库..."
	docker login $(REGISTRY)

all: build test ## 构建并测试镜像

# 快速开发命令
dev: build run ## 构建镜像并启动交互式容器

# CI/CD相关命令
ci: build test push ## 完整的CI流程：构建、测试、推送 
