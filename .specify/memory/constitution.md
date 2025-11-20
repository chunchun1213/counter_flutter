<!--
Sync Impact Report:
Version: 1.0.0 (Initial constitution - MINOR bump for new governance framework)
Ratification: 2025-11-20
Last Amendment: 2025-11-20

Added Sections:
- Core Principles: Code Quality, Testing Standards, User Experience Consistency, Performance Requirements
- Performance Standards: Quantifiable performance benchmarks
- Development Workflow: Quality gates and review process

Templates Status:
✅ plan-template.md - Constitution Check section aligns with new principles
✅ spec-template.md - Requirements and success criteria align with UX/quality principles
✅ tasks-template.md - Task categorization supports quality gates and testing discipline
✅ checklist-template.md - Compatible with quality verification workflows
✅ agent-file-template.md - No constitution-specific references to update

Follow-up TODOs: None - all placeholders filled
-->

# Counter Flutter 專案憲章

## 核心原則

### I. 程式碼品質 (NON-NEGOTIABLE)

所有程式碼必須符合以下品質標準：

- **可讀性優先**：程式碼必須清晰表達意圖，優先選擇明確的命名而非簡潔但模糊的命名
- **單一職責**：每個類別、函式必須只有一個明確的職責，功能必須內聚
- **無重複原則 (DRY)**：邏輯重複超過兩次必須重構為可復用元件
- **靜態分析零容忍**：所有程式碼必須通過 `flutter analyze` 且無警告，禁止使用 `// ignore` 規避檢查（除非有書面理由並記錄於程式碼審查）
- **文件化要求**：所有公開 API、複雜邏輯必須包含 Dart 文件註解，說明用途、參數與回傳值

**理由**：高品質程式碼降低維護成本、減少錯誤，並提升團隊協作效率。品質債務會隨時間累積，預防優於事後補救。

### II. 測試標準 (NON-NEGOTIABLE)

測試是品質保證的基石，必須嚴格執行：

- **測試優先 (Test-First)**：新功能開發遵循 Red-Green-Refactor 循環
  1. 撰寫失敗的測試
  2. 實作最小程式碼使測試通過
  3. 重構並保持測試通過
- **覆蓋率要求**：
  - 業務邏輯（BLoC/Provider/Service）：**最低 80% 覆蓋率**
  - UI Widget：**最低 60% 覆蓋率**
  - 工具函式/輔助類別：**100% 覆蓋率**
- **測試分層**：
  - **單元測試 (Unit)**：測試獨立邏輯單元（函式、類別方法）
  - **Widget 測試**：測試 UI 元件行為與互動
  - **整合測試 (Integration)**：測試端到端使用者流程（關鍵路徑必須包含）
- **測試命名**：使用 `test('should [expected behavior] when [condition]')` 格式，清楚描述測試意圖
- **測試隔離**：每個測試必須獨立執行，不依賴執行順序或共享狀態

**理由**：測試是回歸保護網，確保變更不會破壞既有功能。測試優先強制開發者思考 API 設計與邊界條件。

### III. 使用者體驗一致性

使用者介面必須提供流暢、一致且符合平台規範的體驗：

- **設計系統遵循**：
  - 使用統一的設計 token（顏色、字體、間距）
  - 建立可復用的 UI 元件庫（按鈕、輸入框、卡片等）
  - 禁止在業務邏輯層硬編碼樣式值
- **平台一致性**：
  - 遵循 Material Design 3 準則
  - 支援系統主題（淺色/深色模式）
  - 尊重系統無障礙設定（字體大小、螢幕閱讀器）
- **互動回饋**：
  - 所有使用者操作必須提供即時視覺回饋（載入狀態、按鈕按下效果）
  - 錯誤訊息必須明確指引使用者如何修正
  - 耗時操作（>500ms）必須顯示進度指示器
- **無障礙 (Accessibility)**：
  - 所有互動元件必須支援鍵盤/語音導航
  - 使用 `Semantics` widget 為螢幕閱讀器提供描述
  - 顏色對比度符合 WCAG AA 標準（最低 4.5:1）

**理由**：一致的體驗建立使用者信任，降低學習成本。無障礙設計擴大使用者群體並符合法規要求。

### IV. 效能要求

應用程式必須在目標裝置上流暢執行，符合以下效能基準：

- **畫面更新效能**：
  - 維持 **60 FPS**（16ms/frame），複雜動畫場景允許降至 55 FPS
  - 禁止在 `build()` 方法中執行耗時運算或 I/O 操作
  - 使用 `const` constructor 減少不必要的 widget 重建
- **啟動時間**：
  - 冷啟動至首個可互動畫面：**< 3 秒**（中階裝置）
  - 熱重載響應時間：**< 500ms**
- **記憶體使用**：
  - 應用程式峰值記憶體：**< 150MB**（不含快取資料）
  - 圖片必須使用適當尺寸與格式，避免載入原始高解析度圖檔
  - 列表使用 `ListView.builder` 或 `GridView.builder` 實現虛擬滾動
- **網路請求**：
  - API 請求必須設定逾時時間（預設 30 秒）
  - 實作請求快取策略，避免重複請求相同資料
  - 大型資料使用分頁載入
- **效能監控**：
  - 使用 Flutter DevTools 定期檢查效能瓶頸
  - 關鍵路徑必須通過效能測試（`integration_test` + 效能追蹤）
  - 發布前必須在低階裝置（記憶體 < 2GB）驗證效能

**理由**：效能直接影響使用者滿意度與留存率。流暢的體驗是高品質應用的基本要求。

## 開發工作流程

### 程式碼審查 (Code Review)

所有程式碼變更必須經過審查才能合併：

- **審查檢查清單**：
  - ✅ 符合憲章所有核心原則
  - ✅ 測試覆蓋率達標且測試通過
  - ✅ 靜態分析無警告
  - ✅ 無程式碼異味（過長函式、深層巢狀、魔術數字）
  - ✅ 變更包含必要的文件更新
- **審查時效**：程式碼審查必須在 24 小時內完成初次回饋
- **建設性回饋**：審查意見必須具體且提供改進建議，避免模糊或主觀批評

### 品質閘門 (Quality Gates)

程式碼合併前必須通過以下自動化檢查：

1. **靜態分析**：`flutter analyze` 零錯誤/零警告
2. **格式化**：`dart format --set-exit-if-changed .` 通過
3. **測試套件**：所有測試通過且覆蓋率達標
4. **建構驗證**：`flutter build apk/ios` 成功完成

### 版本控制

- **分支策略**：使用功能分支（`###-feature-name`）開發，完成後合併至 `main`
- **提交訊息**：遵循 Conventional Commits 格式（`feat:`, `fix:`, `docs:`, `test:`, `refactor:`）
- **變更追蹤**：使用 `/speckit.*` 指令建立規格文件與任務追蹤

## 技術約束

### 技術棧

- **Flutter SDK**：最低版本 3.10（穩定版本）
- **Dart 版本**：最低 3.0
- **狀態管理**：優先使用 `flutter_bloc` 或 `provider`，保持一致性
- **網路請求**：使用 `dio` 或 `http` 套件
- **本地儲存**：`shared_preferences`（設定）、`sqflite`（結構化資料）、`hive`（高效能 NoSQL）

### 相依性管理

- 新增第三方套件必須評估：
  - 套件維護狀態（最近 6 個月內有更新）
  - 社群支援（pub.dev 評分 > 130）
  - 授權相容性
- 定期更新相依性（每月檢查一次），修復已知漏洞

## 治理規則

### 憲章優先級

本憲章規範優先於所有其他開發慣例與個人偏好。任何衝突以憲章為準。

### 修訂流程

憲章修訂必須遵循以下流程：

1. **提案**：撰寫修訂提案，說明變更原因、影響範圍與遷移計畫
2. **審查**：團隊審查並討論提案
3. **批准**：達成共識後更新憲章
4. **版本控制**：更新版本號與修訂日期
5. **同步更新**：更新所有相關模板與文件

### 版本控制規則

- **MAJOR**：移除或重新定義核心原則（破壞性變更）
- **MINOR**：新增原則或章節
- **PATCH**：文字澄清、錯字修正、非語意修改

### 合規性審查

- 所有 Pull Request 必須驗證憲章合規性
- 每月進行一次程式碼庫健康度審查，檢查測試覆蓋率、靜態分析結果與效能指標
- 複雜度增加（如新增第三方服務、架構變更）必須在程式碼審查中明確說明理由

### 執行時開發指引

- 使用 `.specify/templates/agent-file-template.md` 產生的開發指引檔案作為日常開發參考
- 使用 `.github/prompts/speckit.*.prompt.md` 指令進行規格化開發流程

**版本**: 1.0.0 | **批准日期**: 2025-11-20 | **最後修訂**: 2025-11-20
