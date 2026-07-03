# The Freak Circus - iOS WebView 应用

🎪 **怪胎马戏团** - 心理恐怖视觉小说游戏的iOS原生应用版本

## ⚡ 快速开始（3步获取IPA）

### 第1步：上传到GitHub

1. 注册/登录 [GitHub](https://github.com/)
2. 创建新仓库（Public或Private均可）
3. 上传本项目所有文件

### 第2步：触发云编译

1. 进入仓库的 **Actions** 标签页
2. 点击 **Build iOS IPA** → **Run workflow**
3. 等待 5-10 分钟

### 第3步：下载IPA

1. 点击进入完成的工作流
2. 在底部 **Artifacts** 区域下载 IPA
3. 使用 Sideloadly / AltStore 签名安装

---

## 📦 项目结构

```
TheFreakCircus/
├── .github/
│   └── workflows/
│       └── build.yml          # GitHub Actions 云编译配置
├── The Freak Circus.xcodeproj/
│   └── project.pbxproj        # Xcode 项目文件
├── TheFreakCircus/            # 源代码目录
│   ├── AppDelegate.swift      # 应用入口
│   ├── SceneDelegate.swift    # 场景管理
│   ├── ViewController.swift   # WebView 主控制器
│   ├── Info.plist             # 应用配置
│   └── Assets.xcassets/       # 资源文件
│       ├── AppIcon.appiconset # 应用图标
│       └── AccentColor.colorset
├── Base.lproj/
│   └── LaunchScreen.storyboard # 启动画面
├── Payload/                   # IPA 结构模板
│   └── The Freak Circus.app/
├── build_ipa.sh               # 本地编译脚本（Mac用）
├── generate_icons.py          # 图标生成脚本
├── INSTALL_GUIDE.md           # 详细安装指南
└── README.md                  # 本文件
```

---

## ✨ 应用特性

- 🎮 **全屏游戏体验** - 完美适配iPhone屏幕，无黑边
- 🌐 **WKWebView 引擎** - 高性能网页渲染
- 🔋 **屏幕常亮** - 游戏时不会自动锁屏
- 📱 **横竖屏支持** - 自由切换屏幕方向
- ⏳ **加载指示器** - 显示加载状态
- 🔄 **错误重试** - 网络问题自动提示重试
- 👆 **手势支持** - 支持前进后退滑动手势
- 🎨 **精美图标** - 定制的恐怖风格应用图标

---

## 🎯 游戏信息

- **游戏名称**: The Freak Circus（怪胎马戏团）
- **游戏类型**: 心理恐怖视觉小说
- **官方网站**: https://playthefreakcircus.com
- **系统要求**: iOS 14.0 或更高版本
- **支持设备**: iPhone（推荐）、iPad

---

## 📖 详细文档

- [安装指南](INSTALL_GUIDE.md) - 包含多种安装方案的详细教程
  - GitHub Actions 云编译教程
  - Sideloadly Windows 版签名安装教程
  - Web Clip（添加到主屏幕）方案
  - 其他云编译服务推荐
  - 常见问题解答

---

## 🛠️ 本地编译（需要Mac）

如果你有Mac电脑，可以直接在本地编译：

```bash
# 安装Xcode后运行
chmod +x build_ipa.sh
./build_ipa.sh
```

编译完成后，IPA 文件将在 `ipa_output/` 目录中。

---

## ⚠️ 重要说明

1. **本项目提供的 IPA 模板** 包含完整的资源文件和配置，但二进制文件为占位符，**不能直接运行**
2. **推荐使用 GitHub Actions 云编译**，完全免费，5-10分钟即可得到真正可运行的 IPA
3. 游戏版权归原作者所有，本项目仅提供网页封装服务
4. 请遵守相关法律法规，仅供个人学习使用

---

## ❓ 遇到问题？

请查看 [INSTALL_GUIDE.md](INSTALL_GUIDE.md) 中的常见问题部分，或搜索相关错误信息。

祝你游戏愉快！🎪🎭
