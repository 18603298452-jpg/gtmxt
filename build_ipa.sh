#!/bin/bash
#
# The Freak Circus - iOS WebView App Build Script
# 
# 使用方法:
#   1. 确保已安装Xcode和Xcode命令行工具
#   2. 运行此脚本: ./build_ipa.sh
#   3. 生成的IPA文件将在 ipa_output 目录中
#

set -e

# 配置
PROJECT_NAME="The Freak Circus"
SCHEME="The Freak Circus"
BUNDLE_ID="com.thefreakcircus.app"
BUILD_DIR="build"
IPA_OUTPUT_DIR="ipa_output"
ARCHIVE_PATH="${BUILD_DIR}/${PROJECT_NAME}.xcarchive"

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  The Freak Circus - iOS 构建脚本${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""

# 检查Xcode是否安装
if ! command -v xcodebuild &> /dev/null; then
    echo -e "${RED}错误: 未找到Xcode命令行工具${NC}"
    echo "请先安装Xcode，然后运行: xcode-select --install"
    exit 1
fi

echo -e "${YELLOW}检查Xcode版本...${NC}"
xcodebuild -version
echo ""

# 创建输出目录
mkdir -p "${IPA_OUTPUT_DIR}"

# 清理旧的构建
echo -e "${YELLOW}清理旧的构建文件...${NC}"
rm -rf "${BUILD_DIR}"
rm -rf "${IPA_OUTPUT_DIR}"/*.ipa
echo ""

# 构建Archive
echo -e "${YELLOW}开始构建Archive...${NC}"
xcodebuild archive \
    -project "${PROJECT_NAME}.xcodeproj" \
    -scheme "${SCHEME}" \
    -configuration Release \
    -archivePath "${ARCHIVE_PATH}" \
    -sdk iphoneos \
    CODE_SIGN_IDENTITY="" \
    CODE_SIGNING_REQUIRED=NO \
    CODE_SIGNING_ALLOWED=NO

if [ $? -ne 0 ]; then
    echo -e "${RED}构建失败!${NC}"
    exit 1
fi

echo -e "${GREEN}Archive构建成功!${NC}"
echo ""

# 导出IPA（未签名）
echo -e "${YELLOW}导出未签名的IPA...${NC}"

# 创建导出配置
EXPORT_PLIST="${BUILD_DIR}/exportOptions.plist"
cat > "${EXPORT_PLIST}" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>method</key>
    <string>development</string>
    <key>compileBitcode</key>
    <false/>
    <key>uploadSymbols</key>
    <false/>
    <key>signingStyle</key>
    <string>manual</string>
</dict>
</plist>
EOF

# 手动创建IPA（因为我们不签名）
APP_PATH="${ARCHIVE_PATH}/Products/Applications/${PROJECT_NAME}.app"
PAYLOAD_DIR="${BUILD_DIR}/Payload"

mkdir -p "${PAYLOAD_DIR}"
cp -R "${APP_PATH}" "${PAYLOAD_DIR}/"

# 创建IPA
IPA_PATH="${IPA_OUTPUT_DIR}/${PROJECT_NAME}-unsigned.ipa"
cd "${BUILD_DIR}"
zip -r "../${IPA_PATH}" "Payload"
cd ..

if [ -f "${IPA_PATH}" ]; then
    echo -e "${GREEN}IPA文件生成成功!${NC}"
    echo -e "文件位置: ${YELLOW}${IPA_PATH}${NC}"
    echo ""
else
    echo -e "${RED}IPA生成失败!${NC}"
    exit 1
fi

# 显示文件信息
echo -e "${YELLOW}文件信息:${NC}"
ls -lh "${IPA_PATH}"
echo ""

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  构建完成!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo -e "${YELLOW}下一步:${NC}"
echo "1. 使用AltStore或TrollStore对IPA进行自签名"
echo "2. 安装到你的iOS设备上"
echo "3. 享受游戏吧!"
echo ""
echo -e "详细的安装教程请查看 ${GREEN}INSTALL_GUIDE.md${NC} 文件"
