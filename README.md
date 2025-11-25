# Counter Flutter App

一個簡潔美觀的計數器應用程式，展示 Flutter 開發最佳實踐，包含完整的設計系統、測試覆蓋率和規格驅動開發流程。

## 📱 功能特色

- ✨ 簡潔直觀的使用者介面
- 🎨 基於 Figma 設計的精美視覺呈現
- ⚡ 流暢的動畫效果（60 FPS）
- ♿ 完整的無障礙功能支援
- 🧪 高覆蓋率的自動化測試
- 📐 遵循 Material Design 3 設計規範

## 🎯 核心功能

### 使用者需求

- **初始顯示**：開啟應用程式時顯示數字 0
- **計數遞增**：點擊圓形按鈕，數字增加 1
- **視覺回饋**：UI 更新響應時間 < 100ms
- **自動化測試**：所有 UI 元件可精確定位

### 驗收標準

✅ 開啟 App 預設畫面顯示 0  
✅ 連按三次按鈕，畫面顯示 3  
✅ UI 元件皆可被自動化測試精確定位  
✅ 視覺效果與設計稿一致（< 5% 差異）  
✅ 測試覆蓋率：Widget 60%+、業務邏輯 80%+

## 🛠 技術規格

### 開發環境

- **Flutter SDK**: 3.16+
- **Dart**: 3.0+
- **目標平台**: iOS 15+, Android 8.0+ (API 26+)

### 核心技術

- **狀態管理**: StatefulWidget + setState
- **設計系統**: 自訂 Design Tokens（Colors, Typography, Spacing）
- **字體**: Google Fonts - Inter (Regular 16px, Bold 72px)
- **測試框架**: flutter_test, integration_test

### 設計資源

- **Figma 設計檔案**: [查看設計](https://www.figma.com/design/AWdcwmlvvrrjn8t19P0tR7/Untitled?node-id=0-1)
- **設計規格文件**: [`docs/design-spec-detailed.md`](docs/design-spec-detailed.md)
- **設計資產**: `design-assets/` 目錄

## 📦 專案結構

```
counter_flutter/
├── lib/
│   ├── main.dart                 # 應用程式進入點
│   ├── pages/
│   │   └── counter_page.dart     # 計數器頁面（主畫面）
│   └── theme/
│       ├── app_colors.dart       # 顏色設計代幣
│       ├── app_text_styles.dart  # 文字樣式
│       └── app_theme.dart        # 主題配置（尺寸、陰影、漸層）
├── test/
│   ├── widget_test/              # Widget 測試
│   │   ├── counter_page_initial_test.dart
│   │   ├── counter_page_increment_test.dart
│   │   ├── counter_page_keys_test.dart
│   │   ├── counter_page_boundary_test.dart
│   │   └── counter_page_multidevice_test.dart
│   └── widget_test.dart          # 基礎測試
├── integration_test/
│   └── counter_flow_test.dart    # 端對端測試
├── specs/
│   └── 001-counter-frontend/     # 功能規格文件
│       ├── spec.md               # 完整功能規格
│       ├── plan.md               # 技術實作計畫
│       ├── tasks.md              # 任務清單
│       ├── research.md           # 技術研究
│       ├── data-model.md         # 資料模型
│       ├── quickstart.md         # 快速開始指南
│       └── analyze-01.md         # 規格一致性分析
└── design-assets/                # Figma 匯出資源
    ├── counter_app.svg
    ├── container.svg
    ├── button.svg
    └── ...
```

## 🚀 快速開始

### 1. 環境需求

確認已安裝：
```bash
flutter doctor
```

必須通過以下檢查：
- ✅ Flutter SDK
- ✅ Dart SDK
- ✅ Xcode (iOS 開發)
- ✅ Android Studio / Android SDK (Android 開發)

### 2. 安裝依賴

```bash
flutter pub get
```

### 3. 執行應用程式

#### iOS 模擬器
```bash
flutter run -d ios
```

#### Android 模擬器
```bash
flutter run -d android
```

#### 特定裝置
```bash
# 列出所有裝置
flutter devices

# 指定裝置執行
flutter run -d <device-id>
```

### 4. 執行測試

#### 所有測試
```bash
flutter test
```

#### Widget 測試
```bash
flutter test test/widget_test/
```

#### 整合測試
```bash
flutter test integration_test/
```

#### 測試覆蓋率
```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### 5. 程式碼品質檢查

#### 靜態分析
```bash
flutter analyze
```

#### 程式碼格式化
```bash
dart format lib/ test/
```

## 🧪 測試策略

### 測試金字塔

- **單元測試**: 無（純 UI 應用）
- **Widget 測試**: 60%+ 覆蓋率
  - 初始狀態測試
  - 計數遞增測試
  - Key 與無障礙測試
  - 邊界情況測試
  - 多裝置適配測試
- **整合測試**: 80%+ 業務邏輯覆蓋率
  - 完整使用者流程測試

### TDD 工作流程

1. ✍️ **Red**: 撰寫失敗的測試
2. ✅ **Green**: 實作最少程式碼使測試通過
3. ♻️ **Refactor**: 重構並優化程式碼

## 🎨 設計系統

### 色彩系統

| 名稱 | HEX | 用途 |
|------|-----|------|
| 淺藍背景（起始） | `#EFF5FE` | 漸層背景起點 |
| 淺藍背景（結束） | `#E0E7FF` | 漸層背景終點 |
| 卡片背景 | `#FFFFFF` | 白色卡片容器 |
| 按鈕深藍 | `#030213` | 圓形按鈕背景 |
| 標題文字 | `#364153` | 「計數器」文字 |
| 數字文字 | `#101828` | 計數數字 |

### 排版系統

| 元素 | 字體 | 大小 | 粗細 | 用途 |
|------|------|------|------|------|
| 標題 | Inter | 16px | Regular (400) | 「計數器」標題 |
| 數字 | Inter | 72px | Bold (700) | 計數顯示 |

### 間距系統

- **標準間距**: 16px
- **中等間距**: 24px
- **大間距**: 48px（標題↔數字、數字↔按鈕）

### 元件尺寸

- **卡片容器**: 320×372px
- **圓形按鈕**: 64×64px（完全圓形）
- **卡片圓角**: 16px

## 📊 效能指標

### 目標效能

- ⚡ **冷啟動**: < 3 秒（中階裝置）
- 🎯 **UI 更新**: < 100ms
- 🎬 **幀率**: 60 FPS
- 💾 **記憶體**: < 50MB（峰值）
- 🔋 **CPU 使用率**: < 30%（快速連點時）

### 驗證方式

使用 Flutter DevTools 監控：
```bash
flutter run --profile
```

## ♿ 無障礙功能

- ✅ 所有 UI 元件有唯一 Key 識別符號
- ✅ 計數顯示具有 semanticsLabel
- ✅ 按鈕包含 tooltip 說明
- ✅ 色彩對比度符合 WCAG AA 標準（4.5:1）
- ✅ 支援螢幕閱讀器

## 📝 開發流程

本專案遵循 Speckit 規格驅動開發流程：

1. **Constitution** (憲章) - 定義專案原則
2. **Specify** (規格化) - 撰寫功能規格
3. **Clarify** (澄清) - 消除歧義
4. **Plan** (規劃) - 技術實作計畫
5. **Tasks** (任務化) - 分解可執行任務
6. **Analyze** (分析) - 一致性檢查
7. **Implement** (實作) - 程式碼開發

詳細文件請參考 `specs/001-counter-frontend/` 目錄。

## 🐛 已知問題與解決方案

### ~~問題 1: 按鈕位置錯誤~~ ✅ 已修正

- **問題**: 按鈕出現在螢幕左下角
- **原因**: 使用了 `Scaffold.floatingActionButton`
- **解決**: 將按鈕移至 Card 的 Column 內
- **參考**: `specs/001-counter-frontend/ISSUE-BUTTON-POSITION.md`

### ~~問題 2: 按鈕形狀不正確~~ ✅ 已修正

- **問題**: 按鈕不是完美圓形
- **解決**: 使用 `BoxDecoration(shape: BoxShape.circle)`

### ~~問題 3: 間距過小~~ ✅ 已修正

- **問題**: 標題與數字間距擁擠
- **解決**: 使用 `MainAxisAlignment.spaceEvenly` 均勻分配空間

## 🤝 貢獻指南

### 分支策略

- `main`: 穩定版本
- `001-counter-frontend`: 功能開發分支（當前）

### Commit 規範

遵循 Conventional Commits：
```
feat: 新增功能
fix: 修正錯誤
docs: 文件更新
style: 格式調整
refactor: 程式碼重構
test: 測試相關
chore: 建置工具或輔助工具
```

### 提交前檢查

```bash
# 1. 靜態分析
flutter analyze

# 2. 格式化
dart format lib/ test/

# 3. 測試
flutter test

# 4. 覆蓋率檢查
flutter test --coverage
```

## 📄 授權

本專案僅供學習與展示用途。

## 📞 聯絡資訊

- **專案負責人**: chunchun1213
- **Repository**: [counter_flutter](https://github.com/chunchun1213/counter_flutter)
- **分支**: 001-counter-frontend

## 🔗 相關資源

- [Flutter 官方文件](https://docs.flutter.dev/)
- [Material Design 3](https://m3.material.io/)
- [Google Fonts](https://fonts.google.com/)
- [Figma 設計檔案](https://www.figma.com/design/AWdcwmlvvrrjn8t19P0tR7/Untitled?node-id=0-1)

---

**專案狀態**: ✅ MVP 完成  
**最後更新**: 2025-11-25  
**版本**: 1.0.0
