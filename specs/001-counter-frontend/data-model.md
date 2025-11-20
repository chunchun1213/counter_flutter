# 資料模型：計數器前端介面

**功能**: 001-counter-frontend  
**建立日期**: 2025-11-20  
**來源**: 從 `spec.md` 提取實體定義

## 資料實體

### 1. Counter State（計數器狀態）

**描述**: 代表計數器的當前狀態，包含計數值與相關操作。

**屬性**:

| 屬性名稱 | 類型 | 預設值 | 說明 | 驗證規則 |
|---------|------|--------|------|---------|
| `count` | `int` | `0` | 當前計數值 | 無上限，最小值 0 |

**行為（方法）**:

| 方法名稱 | 參數 | 回傳值 | 說明 |
|---------|------|--------|------|
| `incrementCounter()` | 無 | `void` | 將計數值遞增 1 |

**生命週期**:
- **建立**: 應用程式啟動時，`_CounterPageState` 初始化時建立
- **持續時間**: 應用程式執行期間持續存在
- **銷毀**: 應用程式關閉時自動銷毀
- **持久化**: ❌ 不持久化（關閉應用後重置為 0）

**狀態轉換圖**:

```
[初始狀態: count = 0]
         |
         | 使用者點擊按鈕
         v
[count = count + 1]
         |
         | 使用者再次點擊按鈕
         v
[count = count + 1]
         |
         ... (無限循環)
```

**實作範例（Dart）**:

```dart
// lib/pages/counter_page.dart
class _CounterPageState extends State<CounterPage> {
  // 資料實體：Counter State
  int _count = 0;
  
  // 行為：遞增計數
  void incrementCounter() {
    setState(() {
      _count++;
    });
  }
}
```

---

### 2. CounterPage（計數器頁面）

**描述**: 代表計數器的視覺呈現與互動介面，包含標題、計數顯示、浮動按鈕等 UI 元件。

**屬性**:

| 屬性名稱 | 類型 | 預設值 | 說明 | 來源 |
|---------|------|--------|------|------|
| `title` | `String` | `"計數器"` | 頁面標題 | 固定值（來自設計規格） |
| `backgroundGradient` | `LinearGradient` | `#EFF5FE → #E0E7FF` | 背景漸層色 | `AppTheme.backgroundGradient` |
| `cardSize` | `Size` | `320×372` | 卡片尺寸 | `AppTheme.cardWidth/Height` |
| `buttonSize` | `double` | `64` | 浮動按鈕尺寸 | `AppTheme.buttonSize` |

**關聯實體**:
- **監聽**: `Counter State`（當 `_count` 改變時，UI 自動更新）
- **包含**: `CounterDisplay`（顯示計數值的 Widget）
- **包含**: `IncrementButton`（浮動按鈕 Widget）

**生命週期**:
- **建立**: 使用者開啟應用程式時，`MaterialApp` 路由至 `CounterPage`
- **重建**: 每次 `setState()` 呼叫後，`build()` 方法重新執行
- **銷毀**: 應用程式關閉或頁面導航離開時

**Widget 樹結構**:

```
CounterPage (StatefulWidget)
└── _CounterPageState (State<CounterPage>)
    └── Scaffold
        ├── body: Container (漸層背景)
        │   └── Center
        │       └── Card (白色卡片)
        │           └── Column
        │               ├── Text("計數器") [標題]
        │               ├── SizedBox (間距)
        │               ├── Text("$_count") [計數顯示]
        │               └── SizedBox (間距)
        └── floatingActionButton: FloatingActionButton
            └── Icon(Icons.add) [+ 號圖示]
```

---

## 資料流向

```
[使用者點擊浮動按鈕]
         |
         v
[觸發 incrementCounter() 方法]
         |
         v
[setState(() { _count++ })]
         |
         v
[Flutter 框架標記 Widget 為髒狀態]
         |
         v
[框架呼叫 build() 方法]
         |
         v
[重新建立 Widget 樹]
         |
         v
[Text("$_count") 顯示新的計數值]
         |
         v
[畫面更新完成（< 100ms）]
```

---

## 資料驗證規則

### 輸入驗證

| 驗證項目 | 規則 | 錯誤處理 |
|---------|------|---------|
| 計數值 | 必須為非負整數 | 初始化時確保 `_count = 0`，不提供減法操作 |
| 點擊頻率 | 無限制 | 所有點擊都應正確註冊（憲章要求） |

### 邊界情況

| 情況 | 當前行為 | 預期行為 |
|------|---------|---------|
| 計數達到 `int` 最大值（2^63-1） | Dart 會溢位至負數 | 實務上不會達到，可忽略 |
| 快速連點（20 次/秒） | 所有點擊正確註冊 | CPU < 30%，無掉幀 |
| 畫面旋轉 | 狀態保留 | 計數值不重置 |

---

## 資料不包含的內容（明確排除）

為避免過度設計，以下資料**不**納入此功能：

❌ **計數歷史記錄**: 不儲存過去的計數值  
❌ **使用者設定**: 不支援自訂起始值或遞增步長  
❌ **持久化儲存**: 不使用 `shared_preferences` 或 `sqflite`  
❌ **網路同步**: 不與後端 API 同步計數值  
❌ **多計數器**: 僅支援單一計數器實例  
❌ **減法操作**: 不提供減少計數的按鈕  
❌ **重置功能**: 不提供重置為 0 的按鈕  

---

## 實作檢查清單

在實作資料模型時，確保以下項目已完成：

- [ ] `_count` 初始化為 `0`
- [ ] `incrementCounter()` 方法使用 `setState()` 包裹
- [ ] 計數顯示使用 `Text("$_count")` 動態更新
- [ ] Widget 使用 `Key` 以支援測試（`Key('counter_display')`）
- [ ] 狀態轉換經過單元測試驗證
- [ ] Widget 測試涵蓋點擊 → 遞增 → 顯示更新流程
- [ ] 整合測試驗證完整使用者流程

---

## 未來擴展考量（本階段不實作）

若未來需求變更，以下擴展點可考慮：

1. **持久化支援**: 使用 `shared_preferences` 儲存計數值
2. **減法與重置**: 新增 `-` 按鈕與重置按鈕
3. **計數上限**: 設定最大值（例如 999）並顯示警告
4. **動畫效果**: 數字改變時加入淡入淡出動畫
5. **多計數器**: 支援建立與管理多個獨立計數器

---

**資料模型版本**: 1.0  
**最後更新**: 2025-11-20  
**下一步**: 建立 `quickstart.md` 與更新 agent context
