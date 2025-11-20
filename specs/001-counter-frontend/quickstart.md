# 快速開始指南：計數器前端介面

**功能**: 001-counter-frontend  
**建立日期**: 2025-11-20  
**適用對象**: 開發團隊成員

## 📋 概述

本指南協助你快速設定開發環境、執行應用程式並進行測試。完成本指南後，你將能夠建構並執行計數器應用程式。

---

## 🔧 前置需求

### 必要工具

| 工具 | 最低版本 | 驗證指令 | 安裝連結 |
|------|---------|---------|---------|
| Flutter SDK | 3.16.0 | `flutter --version` | [flutter.dev](https://docs.flutter.dev/get-started/install) |
| Dart | 3.0.0 | `dart --version` | (隨 Flutter 安裝) |
| Git | 2.30+ | `git --version` | [git-scm.com](https://git-scm.com/downloads) |

### 開發裝置

- **iOS**: macOS + Xcode 14+（iOS 15+ 模擬器或實體裝置）
- **Android**: Android Studio + Android SDK 26+（Android 8.0+ 模擬器或實體裝置）

### 驗證環境

執行以下指令檢查環境是否正確設定：

```bash
flutter doctor -v
```

確保以下項目顯示綠色勾選 ✅：
- Flutter SDK
- Android toolchain（如需 Android 開發）
- Xcode（如需 iOS 開發）
- VS Code 或 Android Studio

---

## 🚀 快速開始

### 步驟 1: 取得專案

```bash
# 複製專案（如果尚未複製）
git clone <repository-url>
cd counter_flutter

# 切換至功能分支
git checkout 001-counter-frontend
```

### 步驟 2: 安裝相依套件

```bash
flutter pub get
```

**預期輸出**:
```
Running "flutter pub get" in counter_flutter...
Resolving dependencies... (completed in 2.3s)
Got dependencies!
```

### 步驟 3: 執行應用程式

#### 方式 A: 使用指令列

```bash
# 列出可用裝置
flutter devices

# 在特定裝置上執行
flutter run -d <device-id>

# 範例：在 iOS 模擬器上執行
flutter run -d "iPhone 15 Pro"

# 範例：在 Android 模擬器上執行
flutter run -d emulator-5554
```

#### 方式 B: 使用 VS Code

1. 開啟 VS Code
2. 按下 `F5` 或點擊「執行 → 啟動偵錯」
3. 選擇目標裝置
4. 等待應用程式建構並啟動

#### 方式 C: 使用 Android Studio

1. 開啟 Android Studio
2. 點擊工具列的「Run」按鈕（綠色三角形）
3. 選擇目標裝置
4. 等待應用程式建構並啟動

**預期結果**:
- 應用程式在 3 秒內啟動（中階裝置）
- 顯示淺藍色漸層背景
- 中央顯示白色卡片，內含「計數器」標題與數字 `0`
- 右下方顯示深藍色圓形按鈕（+ 號）

---

## 🧪 執行測試

### 單元測試與 Widget 測試

```bash
# 執行所有測試
flutter test

# 執行特定測試檔案
flutter test test/widget_test/counter_page_test.dart

# 執行測試並顯示覆蓋率
flutter test --coverage

# 產生覆蓋率報告（需安裝 lcov）
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

**預期輸出**:
```
00:02 +5: All tests passed!
```

### 整合測試

```bash
# 啟動模擬器或連接實體裝置
flutter devices

# 執行整合測試
flutter test integration_test/counter_flow_test.dart

# 或使用 drive 指令
flutter drive \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/counter_flow_test.dart
```

**預期結果**:
- 應用程式自動啟動
- 自動點擊按鈕
- 驗證計數增加
- 測試通過並關閉應用程式

---

## 🔍 程式碼品質檢查

### 靜態分析

```bash
# 執行靜態分析
flutter analyze

# 預期輸出：
# Analyzing counter_flutter...
# No issues found!
```

### 程式碼格式化

```bash
# 檢查格式（不修改檔案）
dart format --set-exit-if-changed .

# 自動格式化所有檔案
dart format .

# 格式化特定目錄
dart format lib/ test/
```

---

## 📁 專案結構導覽

```
counter_flutter/
├── lib/
│   ├── main.dart                 # 應用程式進入點
│   ├── pages/
│   │   └── counter_page.dart     # 計數器主頁面
│   ├── widgets/                  # 可重用元件（如需元件化）
│   └── theme/                    # 設計代幣
│       ├── app_colors.dart       # 顏色定義
│       ├── app_text_styles.dart  # 文字樣式
│       └── app_theme.dart        # 主題設定
├── test/
│   ├── widget_test/              # Widget 測試
│   └── integration_test/         # 整合測試
├── design-assets/                # Figma 提取的設計資源
├── docs/                         # 文件
└── specs/001-counter-frontend/   # 功能規格與計畫
```

---

## 🎯 開發工作流程

### 1. 開始新功能

```bash
# 確認在正確的分支
git checkout 001-counter-frontend

# 拉取最新變更
git pull origin 001-counter-frontend

# 開始開發...
```

### 2. 測試驅動開發（TDD）流程

```bash
# 1️⃣ Red: 撰寫失敗的測試
flutter test test/widget_test/counter_page_test.dart
# 預期：測試失敗（因為功能尚未實作）

# 2️⃣ Green: 實作最小程式碼讓測試通過
# 編輯 lib/pages/counter_page.dart
flutter test test/widget_test/counter_page_test.dart
# 預期：測試通過

# 3️⃣ Refactor: 重構程式碼
# 重構同時確保測試持續通過
flutter test
```

### 3. 提交變更

```bash
# 檢查變更
git status
git diff

# 執行品質檢查
flutter analyze
dart format .
flutter test

# 提交（使用 Conventional Commits 格式）
git add .
git commit -m "feat: implement counter increment functionality"

# 推送至遠端
git push origin 001-counter-frontend
```

---

## 🐛 常見問題排解

### 問題 1: `flutter pub get` 失敗

**症狀**:
```
Error: Unable to resolve dependencies
```

**解決方案**:
```bash
# 清除快取
flutter clean
flutter pub cache repair

# 重新取得套件
flutter pub get
```

---

### 問題 2: 應用程式無法啟動

**症狀**:
```
No devices found
```

**解決方案**:
```bash
# iOS: 啟動模擬器
open -a Simulator

# Android: 啟動模擬器
emulator -avd <avd-name>

# 列出可用裝置
flutter devices
```

---

### 問題 3: 測試失敗

**症狀**:
```
Expected: <1>
Actual: <0>
```

**解決方案**:
1. 檢查測試程式碼是否正確使用 `await tester.pump()`
2. 確認 Widget 使用正確的 `Key` 識別符號
3. 執行 `flutter test --verbose` 查看詳細錯誤資訊

---

### 問題 4: 熱重載不生效

**症狀**:
按下 `r` 後變更未反映在應用程式中

**解決方案**:
```bash
# 停止應用程式並重新啟動
# 或按下 R 進行完整重新啟動（Hot Restart）
```

---

## 📚 相關文件

- [功能規格 (spec.md)](./spec.md)
- [實作計畫 (plan.md)](./plan.md)
- [技術研究 (research.md)](./research.md)
- [資料模型 (data-model.md)](./data-model.md)
- [詳細設計規格 (design-spec-detailed.md)](../../docs/design-spec-detailed.md)
- [專案憲章 (constitution.md)](../../.specify/memory/constitution.md)

---

## 🔗 外部資源

- [Flutter 官方文件](https://docs.flutter.dev/)
- [Dart 語言導覽](https://dart.dev/guides/language/language-tour)
- [Material Design 3](https://m3.material.io/)
- [Flutter Widget Catalog](https://docs.flutter.dev/ui/widgets)
- [Flutter 測試最佳實踐](https://docs.flutter.dev/testing)

---

## ✅ 檢查清單

開始開發前，確保以下項目已完成：

- [ ] Flutter SDK 3.16+ 已安裝
- [ ] 環境變數已正確設定（`flutter doctor` 全綠）
- [ ] Git 分支已切換至 `001-counter-frontend`
- [ ] 相依套件已安裝（`flutter pub get`）
- [ ] 應用程式可成功執行（`flutter run`）
- [ ] 測試可成功執行（`flutter test`）
- [ ] 靜態分析無錯誤（`flutter analyze`）
- [ ] 已閱讀 `spec.md` 與 `plan.md`

---

**指南版本**: 1.0  
**最後更新**: 2025-11-20  
**維護者**: 開發團隊

如有任何問題，請參考專案 README 或聯絡團隊成員。
