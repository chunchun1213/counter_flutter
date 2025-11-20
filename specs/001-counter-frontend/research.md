# 技術研究：計數器前端介面

**功能**: 001-counter-frontend  
**研究日期**: 2025-11-20  
**研究者**: AI Agent (GitHub Copilot)

## 研究目的

針對計數器前端功能的技術實作方案進行研究，確保技術選型符合專案需求、效能目標與憲章規範。

## 研究議題

### 1. 狀態管理方案選擇

**決策**: 使用 `StatefulWidget` + `setState`

**理由**:
- **簡單性**: 計數器只有單一狀態（計數值），不需要複雜的狀態管理框架
- **效能**: `setState` 對於單一頁面、單一狀態的場景效能最佳（無額外框架開銷）
- **學習曲線**: 團隊所有成員都熟悉 `setState`，無需學習新框架
- **維護成本**: 減少相依套件，降低未來維護負擔
- **憲章遵循**: 符合「簡單優先」原則，避免過度設計

**考慮過的替代方案**:
1. **Provider**:
   - 優點: 官方推薦，解耦狀態與 UI
   - 缺點: 對單一狀態場景過度複雜，增加程式碼量
   - 為何拒絕: 殺雞用牛刀，不符合簡單性原則
   
2. **flutter_bloc**:
   - 優點: 事件驅動架構，測試性強
   - 缺點: 學習曲線陡峭，需要 3 個額外檔案（event, state, bloc）
   - 為何拒絕: 技術債務過高，單一計數器不需要事件流
   
3. **Riverpod**:
   - 優點: 編譯時安全，無 context 依賴
   - 缺點: 相對較新，團隊不熟悉，語法較複雜
   - 為何拒絕: 學習成本與專案規模不匹配

**實作細節**:
```dart
class CounterPage extends StatefulWidget {
  const CounterPage({super.key});
  
  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;
  
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    // UI implementation
  }
}
```

---

### 2. 設計代幣實作策略

**決策**: 使用獨立的常數類別 (Constants Classes) 儲存設計代幣

**理由**:
- **類型安全**: Dart 的 `const` 提供編譯時檢查
- **集中管理**: 所有設計規格集中在 `theme/` 目錄
- **易於維護**: 設計變更只需修改單一位置
- **符合憲章**: 遵循「設計系統遵循」原則，禁止硬編碼樣式值

**考慮過的替代方案**:
1. **ThemeData 擴展**:
   - 優點: Flutter 官方推薦的主題系統
   - 缺點: 對於客製化設計參數（如特定 shadow, gradient）不夠靈活
   - 為何拒絕: 需要客製化漸層背景與雙層陰影，ThemeData 支援有限
   
2. **JSON 配置檔案**:
   - 優點: 可動態載入，支援熱更新
   - 缺點: 失去編譯時類型檢查，增加解析開銷
   - 為何拒絕: 過度設計，計數器應用不需要動態主題

**實作細節**:

```dart
// lib/theme/app_colors.dart
class AppColors {
  AppColors._(); // Private constructor to prevent instantiation
  
  static const Color backgroundStart = Color(0xFFEFF5FE);
  static const Color backgroundEnd = Color(0xFFE0E7FF);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color titleText = Color(0xFF364153);
  static const Color counterText = Color(0xFF101828);
  static const Color buttonBackground = Color(0xFF030213);
  static const Color buttonIcon = Color(0xFFFFFFFF);
}

// lib/theme/app_text_styles.dart
class AppTextStyles {
  AppTextStyles._();
  
  static const TextStyle title = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    fontWeight: FontWeight.w400, // Regular
    color: AppColors.titleText,
  );
  
  static const TextStyle counter = TextStyle(
    fontFamily: 'Inter',
    fontSize: 72,
    fontWeight: FontWeight.w700, // Bold
    color: AppColors.counterText,
  );
}

// lib/theme/app_theme.dart
class AppTheme {
  AppTheme._();
  
  static const double cardWidth = 320;
  static const double cardHeight = 372;
  static const double cardBorderRadius = 16;
  static const double buttonSize = 64;
  
  static final List<BoxShadow> cardShadows = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      offset: const Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -1,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.06),
      offset: const Offset(0, 2),
      blurRadius: 4,
      spreadRadius: -1,
    ),
  ];
  
  static final List<BoxShadow> buttonShadows = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      offset: const Offset(0, 10),
      blurRadius: 15,
      spreadRadius: -3,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      offset: const Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -2,
    ),
  ];
  
  static LinearGradient get backgroundGradient => const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.backgroundStart, AppColors.backgroundEnd],
  );
}
```

---

### 3. 字體整合方式

**決策**: 使用 Google Fonts 套件載入 Inter 字體

**理由**:
- **自動下載**: 首次執行時自動下載字體，無需手動管理字體檔案
- **快取機制**: 字體快取至本機，避免重複下載
- **版本管理**: 套件管理字體版本，確保一致性
- **零配置**: 無需修改 `pubspec.yaml` 的 `fonts` 區塊
- **效能**: 按需載入，不會影響啟動時間

**考慮過的替代方案**:
1. **手動下載字體檔案**:
   - 優點: 離線可用，完全掌控字體版本
   - 缺點: 需手動下載 `.ttf` 檔案，配置 `pubspec.yaml`，增加專案大小
   - 為何拒絕: 維護成本較高，Google Fonts 套件已提供良好的快取機制
   
2. **系統字體**:
   - 優點: 零額外成本，啟動最快
   - 缺點: 無法保證 Inter 字體在所有裝置上可用，視覺一致性差
   - 為何拒絕: 違反憲章「設計系統遵循」原則，無法達成視覺一致性目標

**實作細節**:

```yaml
# pubspec.yaml
dependencies:
  flutter:
    sdk: flutter
  google_fonts: ^6.1.0
```

```dart
// lib/theme/app_text_styles.dart
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  AppTextStyles._();
  
  static TextStyle title = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.titleText,
  );
  
  static TextStyle counter = GoogleFonts.inter(
    fontSize: 72,
    fontWeight: FontWeight.w700,
    color: AppColors.counterText,
  );
}
```

---

### 4. 測試策略

**決策**: 採用三層測試金字塔（單元測試 + Widget 測試 + 整合測試）

**理由**:
- **憲章要求**: 必須達到 Widget 測試 60% 覆蓋率、業務邏輯 80% 覆蓋率
- **回歸保護**: 測試防止未來變更破壞既有功能
- **TDD 友善**: 支援 Red-Green-Refactor 開發流程
- **CI/CD 整合**: 自動化測試確保每次提交的品質

**測試分層規劃**:

1. **單元測試 (Unit Tests)**:
   - 測試對象: 狀態遞增邏輯（如果抽離成獨立函式）
   - 工具: `flutter_test`
   - 範例:
     ```dart
     test('should increment counter from 0 to 1', () {
       int counter = 0;
       counter++;
       expect(counter, 1);
     });
     ```

2. **Widget 測試 (Widget Tests)**:
   - 測試對象: `CounterPage`, `CounterDisplay`, `IncrementButton`
   - 工具: `flutter_test`, `find.byKey()`, `tester.tap()`
   - 範例:
     ```dart
     testWidgets('should display initial counter value 0', (tester) async {
       await tester.pumpWidget(const MaterialApp(home: CounterPage()));
       expect(find.text('0'), findsOneWidget);
     });
     
     testWidgets('should increment counter when button is tapped', (tester) async {
       await tester.pumpWidget(const MaterialApp(home: CounterPage()));
       await tester.tap(find.byKey(const Key('increment_button')));
       await tester.pump();
       expect(find.text('1'), findsOneWidget);
     });
     ```

3. **整合測試 (Integration Tests)**:
   - 測試對象: 完整使用者流程（開啟 → 點擊 → 驗證）
   - 工具: `integration_test` 套件
   - 範例:
     ```dart
     testWidgets('counter flow test', (tester) async {
       app.main();
       await tester.pumpAndSettle();
       
       expect(find.text('0'), findsOneWidget);
       await tester.tap(find.byKey(const Key('increment_button')));
       await tester.pumpAndSettle();
       expect(find.text('1'), findsOneWidget);
     });
     ```

**Golden Tests (視覺回歸測試)**:
- 用途: 驗證 UI 與設計規格一致性
- 工具: `flutter_test` 的 `matchesGoldenFile()`
- 範例:
  ```dart
  testWidgets('counter page matches golden file', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: CounterPage()));
    await expectLater(
      find.byType(CounterPage),
      matchesGoldenFile('goldens/counter_page.png'),
    );
  });
  ```

---

### 5. 效能最佳化策略

**決策**: 使用 `const` 建構子 + 避免 `build()` 中的耗時運算

**理由**:
- **憲章要求**: 維持 60 FPS，UI 更新 < 100ms
- **減少重建**: `const` Widget 不會在父元件重建時重新建立
- **記憶體效率**: `const` 實例在編譯時建立，減少 GC 壓力

**最佳實踐**:

1. **使用 const 建構子**:
   ```dart
   // ✅ 好的實踐
   const Text('計數器', style: AppTextStyles.title)
   
   // ❌ 避免
   Text('計數器', style: AppTextStyles.title)
   ```

2. **避免在 build() 中執行耗時運算**:
   ```dart
   // ✅ 好的實踐
   class _CounterPageState extends State<CounterPage> {
     late final LinearGradient _gradient = AppTheme.backgroundGradient;
     
     @override
     Widget build(BuildContext context) {
       return Container(decoration: BoxDecoration(gradient: _gradient));
     }
   }
   
   // ❌ 避免
   @override
   Widget build(BuildContext context) {
     final gradient = LinearGradient(...); // 每次重建都建立新實例
     return Container(decoration: BoxDecoration(gradient: gradient));
   }
   ```

3. **使用 Flutter DevTools 驗證效能**:
   - 監控幀率（應保持 60 FPS）
   - 檢查 Widget 重建次數
   - 分析記憶體使用量（峰值 < 50MB）

---

## 研究結論

所有技術選擇均已明確，無需進一步釐清。研究結果符合以下標準：

✅ **簡單性**: 選擇最簡單的技術方案（`setState` 而非複雜狀態管理）  
✅ **效能**: 所有選擇都考慮到 60 FPS 與快速啟動的目標  
✅ **可維護性**: 設計代幣集中管理，易於未來修改  
✅ **憲章遵循**: 所有決策符合程式碼品質、測試標準、UX 一致性與效能要求  
✅ **無過度設計**: 拒絕所有不必要的複雜性（如 BLoC、JSON 配置檔案）

---

## 下一步

- ✅ Phase 0 完成，無未解決的技術問題
- ➡️ 進入 Phase 1：建立 `data-model.md` 與 `quickstart.md`
- ➡️ 更新 agent context（執行 `update-agent-context.sh`）
