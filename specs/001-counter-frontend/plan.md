# 實作計畫：計數器前端介面

**分支**: `001-counter-frontend` | **日期**: 2025-11-20 | **規格**: [spec.md](./spec.md)
**輸入**: 功能規格來自 `/specs/001-counter-frontend/spec.md`

**備註**: 此文件由 `/speckit.plan` 指令產生。執行流程詳見 `.specify/templates/commands/plan.md`。

## 摘要

建構計數器前端介面，使用者可透過點擊按鈕遞增計數。實作採用 Flutter 3.16+ 與 StatelessWidget + setState 狀態管理模式，完全遵循 Figma 設計規格，包含漸層背景、白色卡片容器、大型計數顯示以及圓形浮動按鈕。

## 技術背景

**語言/版本**: Flutter SDK 3.16+, Dart 3.0+  
**主要相依套件**: flutter/material.dart (內建)  
**儲存**: N/A（計數器狀態不持久化）  
**測試**: flutter_test (內建), integration_test  
**目標平台**: iOS 15+, Android 8.0+ (API level 26+)  
**專案類型**: 單一行動應用程式 (single mobile app)  
**效能目標**: 維持 60 FPS, 冷啟動 < 3 秒（中階裝置）, UI 更新回應 < 100ms  
**限制條件**: 峰值記憶體 < 50MB, 快速連點 CPU 使用率 < 30%  
**規模/範圍**: 單一頁面應用程式，約 300-500 行程式碼，1 個主要 Widget

## 憲章檢查

*關卡: 必須在 Phase 0 研究前通過。Phase 1 設計後重新檢查。*

**最新檢查**: 2025-11-20 Phase 1 完成後  
**檢查結果**: ✅ 全部通過（無變更）

### I. 程式碼品質 ✅ 通過

- **可讀性優先**: 使用明確的命名（`CounterPage`, `incrementCounter`）
- **單一職責**: `CounterPage` 僅負責 UI 呈現與狀態管理
- **DRY 原則**: 設計規格已定義統一的設計代幣（顏色、間距、字體）
- **靜態分析零容忍**: 所有程式碼將通過 `flutter analyze` 檢查
- **文件要求**: 所有公開 Widget 和方法將包含 Dart doc 註解

**評估**: ✅ 無違規。專案規模小，架構簡單清晰。

### II. 測試標準 ✅ 通過

- **測試優先**: 將採用 TDD 流程開發
- **覆蓋率要求**:
  - Widget 測試: 目標 60%（需涵蓋 `CounterPage` widget）
  - 業務邏輯: 目標 80%（`setState` 遞增邏輯）
- **測試分層**:
  - 單元測試: 測試計數遞增邏輯
  - Widget 測試: 測試 UI 元件渲染與互動
  - 整合測試: 測試「開啟 → 點擊 → 驗證顯示」流程
- **測試命名**: 使用 `test('should increment counter when button is tapped')` 格式
- **測試隔離**: 每個測試獨立執行，無共享狀態

**評估**: ✅ 無違規。測試計畫明確，符合憲章要求。

### III. 使用者體驗一致性 ✅ 通過

- **設計系統遵循**:
  - 使用統一的設計代幣（已從 Figma 提取）
  - 顏色: `#EFF5FE`, `#E0E7FF`, `#030213`, `#FFFFFF`, `#364153`, `#101828`
  - 間距: `16px` 圓角, `320×372px` 卡片尺寸, `64×64px` 按鈕
  - 字體: Inter Regular 16px（標題）, Inter Bold 72px（計數）
- **平台一致性**:
  - 遵循 Material Design 3 指南
  - 使用 Material 元件（`FloatingActionButton`, `Card`, `Text`）
- **互動回饋**:
  - 按鈕點擊提供視覺回饋（Material splash effect）
  - UI 更新 < 100ms
- **無障礙功能**:
  - 所有互動元件包含 `Semantics` 標籤
  - 按鈕包含 `tooltip` 說明
  - 顏色對比度符合 WCAG AA 標準

**評估**: ✅ 無違規。完整遵循設計規格與無障礙要求。

### IV. 效能需求 ✅ 通過

- **幀率效能**: 目標 60 FPS
  - 使用 `const` 建構子減少重建
  - 避免在 `build()` 中執行耗時運算
- **啟動時間**: 冷啟動 < 3 秒（中階裝置）
  - 單一頁面應用，啟動快速
- **記憶體使用**: 峰值 < 50MB
  - 無複雜圖片或快取，記憶體佔用低
- **網路請求**: N/A（無網路呼叫）
- **效能監控**: 使用 Flutter DevTools 驗證效能指標

**評估**: ✅ 無違規。專案簡單，效能要求易達成。

### V. 文件語言政策 ✅ 通過

- **憲章與治理**（英文）: constitution.md 已使用英文
- **使用者導向文件**（繁體中文）:
  - ✅ spec.md 已使用繁體中文
  - ✅ plan.md（本文件）使用繁體中文
  - ✅ 後續 tasks.md 將使用繁體中文
  - ✅ quickstart.md 將使用繁體中文
- **程式碼與技術製品**（英文）:
  - 變數名稱、函式名稱、註解使用英文
  - Commit 訊息使用英文（Conventional Commits 格式）
- **例外**:
  - UI 字串（「計數器」、「加一」）使用繁體中文

**評估**: ✅ 無違規。語言政策明確遵循。

### 整體憲章檢查結果: ✅ 全部通過

**無需複雜度追蹤表**: 所有檢查項目均通過，無違規事項需記錄。

## Project Structure

### Documentation (this feature)

```text
specs/[###-feature]/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
├── contracts/           # Phase 1 output (/speckit.plan command)
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created by /speckit.plan)
```

### 原始碼（專案根目錄）

```text
lib/
├── main.dart                 # 應用程式進入點
├── pages/
│   └── counter_page.dart     # 計數器主頁面（包含 UI 與 setState 邏輯）
├── widgets/
│   ├── counter_display.dart  # 計數顯示元件（可選，用於元件化）
│   └── increment_button.dart # 浮動按鈕元件（可選，用於元件化）
└── theme/
    ├── app_colors.dart       # 設計代幣：顏色定義
    ├── app_text_styles.dart  # 設計代幣：文字樣式
    └── app_theme.dart        # 主題設定

test/
├── widget_test/
│   ├── counter_page_test.dart      # CounterPage Widget 測試
│   ├── counter_display_test.dart   # CounterDisplay Widget 測試
│   └── increment_button_test.dart  # IncrementButton Widget 測試
└── integration_test/
    └── counter_flow_test.dart      # 端對端測試：開啟 → 點擊 → 驗證

design-assets/               # Figma 提取的設計資源（已存在）
├── counter_app.svg
├── container.svg
├── heading_1.svg
├── button.svg
├── icon.svg
└── vector.svg

docs/                        # 文件（已存在）
├── design-spec-detailed.md  # 詳細設計規格
├── design-spec.json         # Figma API 提取的 JSON 資料
└── figma-token-setup.md     # Figma Token 設定指南

specs/001-counter-frontend/  # 功能規格與計畫（已存在）
├── spec.md                  # 功能規格
├── plan.md                  # 實作計畫（本文件）
├── research.md              # Phase 0 研究成果（待建立）
├── data-model.md            # Phase 1 資料模型（待建立）
├── quickstart.md            # Phase 1 快速開始指南（待建立）
├── contracts/               # Phase 1 API 契約（本專案可能跳過）
└── tasks.md                 # Phase 2 任務清單（待建立）
```

**結構決策**: 採用 **單一行動應用程式 (Single Mobile App)** 結構。此專案為純前端 Flutter 應用，不涉及後端 API 或多模組架構。所有程式碼位於 `lib/` 目錄下，按照 Flutter 官方慣例組織：

- **`pages/`**: 頁面級元件（路由層級）
- **`widgets/`**: 可重用的 UI 元件
- **`theme/`**: 設計系統相關（顏色、文字樣式、主題）
- **`test/`**: 測試檔案，鏡像 `lib/` 結構

此結構簡單清晰，適合小型專案，易於擴展。

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| [e.g., 4th project] | [current need] | [why 3 projects insufficient] |
| [e.g., Repository pattern] | [specific problem] | [why direct DB access insufficient] |
