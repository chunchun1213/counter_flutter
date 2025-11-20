# Counter App 設計規格文件

**來源**: Figma 設計檔案 `AWdcwmlvvrrjn8t19P0tR7`  
**提取日期**: 2025-11-20  
**頁面**: Page 1 - Counter App

---

## 📐 頁面佈局規格

### 整體結構

```
Counter App (393×852)
└── Container (320×372)
    ├── Heading 1
    │   └── 計數器 (Text)
    ├── Container
    │   └── 37 (Text - 計數顯示)
    └── Button (FloatingActionButton)
        └── Icon (+號圖示)
```

### 尺寸規格

| 元件 | 寬度 | 高度 | 說明 |
|------|------|------|------|
| 畫面整體 | 393px | 852px | iPhone 14 Pro 尺寸 |
| 卡片容器 | 320px | 372px | 白色卡片區域 |
| 標題區 | 224px | 24px | "計數器"文字區域 |
| 數字顯示區 | 224px | 108px | 大數字顯示區域 |
| 浮動按鈕 | 64px | 64px | 圓形加號按鈕 |
| 按鈕圖示 | 16px | 16px | +號圖示 |

---

## 🎨 色彩系統

### 主要顏色

| 名稱 | HEX | RGB | 用途 | 使用場景 |
|------|-----|-----|------|----------|
| **primary-background** | `#EFF5FE` | rgb(239, 245, 254) | 主背景色（漸層起始） | 整體畫面背景 |
| **primary-background-end** | `#E0E7FF` | rgb(224, 231, 255) | 主背景色（漸層結束） | 整體畫面背景 |
| **card-background** | `#FFFFFF` | rgb(255, 255, 255) | 卡片背景 | Container 容器背景 |
| **button-primary** | `#030213` | rgb(3, 2, 19) | 主要按鈕色 | FloatingActionButton 背景 |
| **text-primary** | `#364153` | rgb(54, 65, 83) | 主文字色 | 標題"計數器" |
| **text-counter** | `#10182 8` | rgb(16, 24, 40) | 計數文字色 | 數字顯示 |
| **icon-white** | `#FFFFFF` | rgb(255, 255, 255) | 白色圖示 | 按鈕內+號圖示 |

### 顏色轉換函式 (Flutter)

```dart
// RGB 轉換為 Dart Color
Color rgbToColor(double r, double g, double b, [double a = 1.0]) {
  return Color.fromRGBO(
    (r * 255).round(),
    (g * 255).round(),
    (b * 255).round(),
    a,
  );
}

// Figma 實際顏色定義
static const Color primaryBackground = Color(0xFFEFF5FE);
static const Color cardBackground = Color(0xFFFFFFFF);
static const Color buttonPrimary = Color(0xFF030213);
static const Color textPrimary = Color(0xFF364153);
static const Color textCounter = Color(0xFF101828);
static const Color iconWhite = Color(0xFFFFFFFF);

// 背景漸層
static const LinearGradient backgroundGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFFEFF5FE), // 起始色
    Color(0xFFE0E7FF), // 結束色
  ],
);
```

---

## 📏 間距標準

### Padding (內邊距)

| 名稱 | 數值 | 使用場景 |
|------|------|----------|
| `spacing-0` | 0px | 無內距元件 |
| `spacing-1` | 4px | 極小間距 |
| `spacing-2` | 8px | 小間距 |
| `spacing-3` | 12px | 中小間距 |
| `spacing-4` | 16px | 標準間距（卡片圓角） |
| `spacing-5` | 20px | 中等間距 |
| `spacing-6` | 24px | 大間距 |
| `spacing-8` | 32px | 特大間距 |

### Margin (外邊距)

| 名稱 | 數值 | 使用場景 |
|------|------|----------|
| `margin-card` | 36px | 卡片與螢幕邊緣距離 |
| `margin-vertical` | 240px | 卡片頂部距離 |

### Flutter 間距常數

```dart
class AppSpacing {
  static const double spacing0 = 0.0;
  static const double spacing1 = 4.0;
  static const double spacing2 = 8.0;
  static const double spacing3 = 12.0;
  static const double spacing4 = 16.0;
  static const double spacing5 = 20.0;
  static const double spacing6 = 24.0;
  static const double spacing8 = 32.0;
  
  // 特定用途間距
  static const double cardMarginHorizontal = 36.5;
  static const double cardMarginVertical = 240.0;
}
```

---

## ✏️ 排版參數

### 文字樣式

| 樣式名稱 | 字體 | 大小 | 粗細 | 行高 | 字距 | 用途 |
|---------|------|------|------|------|------|------|
| **heading1** | Inter | 16px | 400 (Regular) | 24px | -0.3125px | 標題"計數器" |
| **counter-display** | Inter | 72px | 700 (Bold) | 108px | 0.123px | 數字顯示 |

### Flutter 文字樣式

```dart
class AppTextStyles {
  // 標題樣式
  static const TextStyle heading1 = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16.0,
    fontWeight: FontWeight.w400, // Regular
    height: 1.5, // 24/16 = 1.5
    letterSpacing: -0.3125,
    color: Color(0xFF364153),
  );
  
  // 計數器數字樣式
  static const TextStyle counterDisplay = TextStyle(
    fontFamily: 'Inter',
    fontSize: 72.0,
    fontWeight: FontWeight.w700, // Bold
    height: 1.5, // 108/72 = 1.5
    letterSpacing: 0.123,
    color: Color(0xFF101828),
  );
}
```

---

## 🔲 其他視覺參數

### 圓角 (Corner Radius)

| 元件 | 圓角數值 | 說明 |
|------|---------|------|
| **卡片容器** | 16px | Container 的圓角 |
| **浮動按鈕** | 完全圓形 | 使用 width/2 作為圓角 |

```dart
class AppBorderRadius {
  static const double card = 16.0;
  static BorderRadius get cardBorderRadius => BorderRadius.circular(card);
  static BorderRadius circular(double radius) => BorderRadius.circular(radius);
}
```

### 陰影 (Shadow)

#### 卡片陰影 (Card Shadow)

```dart
static final List<BoxShadow> cardShadows = [
  // Shadow 1: 淺層陰影
  BoxShadow(
    color: Color(0x1A000000), // rgba(0, 0, 0, 0.1)
    offset: Offset(0, 8),
    blurRadius: 10.0,
    spreadRadius: -6.0,
  ),
  // Shadow 2: 深層陰影
  BoxShadow(
    color: Color(0x1A000000), // rgba(0, 0, 0, 0.1)
    offset: Offset(0, 20),
    blurRadius: 25.0,
    spreadRadius: -5.0,
  ),
];
```

#### 按鈕陰影 (Button Shadow)

```dart
static final List<BoxShadow> buttonShadows = [
  // Shadow 1: 淺層陰影
  BoxShadow(
    color: Color(0x1A000000), // rgba(0, 0, 0, 0.1)
    offset: Offset(0, 4),
    blurRadius: 6.0,
    spreadRadius: -4.0,
  ),
  // Shadow 2: 深層陰影
  BoxShadow(
    color: Color(0x1A000000), // rgba(0, 0, 0, 0.1)
    offset: Offset(0, 10),
    blurRadius: 15.0,
    spreadRadius: -3.0,
  ),
];
```

### 邊框 (Stroke)

| 元件 | 寬度 | 樣式 | 顏色 | 說明 |
|------|------|------|------|------|
| **+號圖示** | 1.33px | 實線 | #FFFFFF | 按鈕內圖示描邊 |

```dart
class AppStrokes {
  static const double iconStrokeWidth = 1.33;
  static const Color iconStrokeColor = Color(0xFFFFFFFF);
}
```

---

## 🧩 UI 元件規格

### 1. 卡片容器 (Card Container)

**用途**: 主要內容容器，包含標題、數字和按鈕

**結構**:
```
Container (Frame)
├── 背景色: #FFFFFF
├── 圓角: 16px
├── 陰影: cardShadows
├── 尺寸: 320×372px
└── 內容: Column 垂直排列
```

**屬性**:
- backgroundColor: `#FFFFFF`
- cornerRadius: `16px`
- width: `320px`
- height: `372px`
- shadows: 雙層陰影（見陰影章節）

**互動狀態**:
- Default: 預設顯示狀態
- (無其他狀態)

**Figma Component Name**: `Container`

**Flutter Widget 範例**:

```dart
Container(
  width: 320,
  height: 372,
  decoration: BoxDecoration(
    color: AppColors.cardBackground,
    borderRadius: AppBorderRadius.cardBorderRadius,
    boxShadow: AppShadows.cardShadows,
  ),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      // 標題
      Text('計數器', style: AppTextStyles.heading1),
      // 數字顯示
      Text('0', style: AppTextStyles.counterDisplay),
      // 按鈕
      CounterButton(),
    ],
  ),
)
```

---

### 2. 標題文字 (Heading Text)

**用途**: 顯示"計數器"標題

**屬性**:
- text: "計數器"
- fontFamily: Inter
- fontSize: 16px
- fontWeight: 400 (Regular)
- color: `#364153`
- lineHeight: 24px
- letterSpacing: -0.3125px

**Figma Component Name**: `計數器` (Text Node)

**Flutter Widget 範例**:

```dart
Text(
  '計數器',
  style: AppTextStyles.heading1,
  semanticsLabel: 'counter_title', // 自動化測試用
)
```

---

### 3. 計數顯示 (Counter Display)

**用途**: 顯示當前計數數字

**屬性**:
- text: 動態數字 (預設: "0")
- fontFamily: Inter
- fontSize: 72px
- fontWeight: 700 (Bold)
- color: `#101828`
- lineHeight: 108px
- letterSpacing: 0.123px
- textAlign: center

**Figma Component Name**: `37` (Text Node - 範例數字)

**Flutter Widget 範例**:

```dart
Text(
  '$_counter', // 動態計數值
  key: Key('counter_display'), // 自動化測試用
  style: AppTextStyles.counterDisplay,
  semanticsLabel: 'counter_value_$_counter',
)
```

---

### 4. 浮動動作按鈕 (FloatingActionButton)

**用途**: 點擊增加計數

**結構**:
```
Button (Frame)
├── 背景色: #030213
├── 圓形: 完全圓角
├── 陰影: buttonShadows
├── 尺寸: 64×64px
└── 內容: Icon (+號)
```

**屬性**:
- backgroundColor: `#030213`
- width: `64px`
- height: `64px`
- cornerRadius: `32px` (完全圓形)
- shadows: 雙層陰影（見陰影章節）

**互動狀態**:
- **Default**: 預設深藍色背景
- **Hover**: (Web) 略微變亮
- **Pressed**: 按下時縮小 95%
- **Disabled**: (未使用)

**Figma Component Name**: `Button`

**Flutter Widget 範例**:

```dart
FloatingActionButton(
  key: Key('increment_button'), // 自動化測試用
  onPressed: _incrementCounter,
  backgroundColor: AppColors.buttonPrimary,
  elevation: 0, // 使用 decoration shadow
  child: Container(
    width: 64,
    height: 64,
    decoration: BoxDecoration(
      color: AppColors.buttonPrimary,
      shape: BoxShape.circle,
      boxShadow: AppShadows.buttonShadows,
    ),
    child: Icon(
      Icons.add,
      color: AppColors.iconWhite,
      size: 24,
      semanticLabel: 'add_button',
    ),
  ),
)
```

---

### 5. 圖示 (Icon - Plus Sign)

**用途**: +號圖示，表示增加動作

**屬性**:
- 類型: Vector (線條)
- 大小: 16×16px
- 描邊寬度: 1.33px
- 描邊顏色: `#FFFFFF`
- 樣式: 圓角線段

**Figma Component Name**: `Icon` / `Vector`

**Flutter Widget 範例**:

```dart
Icon(
  Icons.add,
  color: AppColors.iconWhite,
  size: 24, // 放大以符合視覺比例
)

// 或使用自訂 SVG
SvgPicture.asset(
  'assets/icons/icon_plus.svg',
  width: 16,
  height: 16,
  color: AppColors.iconWhite,
)
```

---

## 📱 頁面佈局規格

### 頁面結構樹狀圖

```
Scaffold
├── Body (Container with Gradient Background)
│   └── Center
│       └── Card Container
│           ├── Heading Text ("計數器")
│           ├── Counter Display (數字)
│           └── Floating Action Button (+)
```

### 元素位置關係和對齊方式

| 元素 | 水平對齊 | 垂直對齊 | 定位方式 |
|------|---------|---------|---------|
| **Card Container** | 居中 | 居中 | Center widget |
| **標題** | 居中 | 頂部 | Column 內第一個元素 |
| **數字顯示** | 居中 | 中間 | Column 內居中 |
| **按鈕** | 居中 | 底部 | Column 內最後元素 |

### 關鍵尺寸和斷點

- **設計基準**: iPhone 14 Pro (393×852)
- **最小寬度**: 320px
- **最大寬度**: 無限制（保持卡片固定寬度320px）
- **響應式**: 卡片始終居中，背景填滿整個螢幕

### Flutter 頁面程式碼範例

```dart
import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);

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
    return Scaffold(
      body: Container(
        // 背景漸層
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        // 居中對齊
        child: Center(
          child: Container(
            // 卡片容器
            width: 320,
            height: 372,
            padding: EdgeInsets.symmetric(
              vertical: AppSpacing.spacing6,
              horizontal: AppSpacing.spacing4,
            ),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: AppBorderRadius.cardBorderRadius,
              boxShadow: AppShadows.cardShadows,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 標題
                Text(
                  '計數器',
                  key: Key('counter_title'),
                  style: AppTextStyles.heading1,
                ),
                
                // 數字顯示
                Text(
                  '$_counter',
                  key: Key('counter_display'),
                  style: AppTextStyles.counterDisplay,
                  semanticsLabel: 'counter_value_$_counter',
                ),
                
                // 浮動按鈕
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppColors.buttonPrimary,
                    shape: BoxShape.circle,
                    boxShadow: AppShadows.buttonShadows,
                  ),
                  child: IconButton(
                    key: Key('increment_button'),
                    onPressed: _incrementCounter,
                    icon: Icon(
                      Icons.add,
                      color: AppColors.iconWhite,
                      size: 24,
                    ),
                    tooltip: '增加計數',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

---

## 📋 設計資產清單

### 已匯出資源 (design-assets/)

| 檔案名稱 | 格式 | 尺寸 | 用途 |
|---------|------|------|------|
| `counter_app.svg` | SVG | 393×852 | 完整頁面截圖 |
| `container.svg` | SVG | 320×372 | 卡片容器 |
| `heading_1.svg` | SVG | 224×24 | 標題區域 |
| `button.svg` | SVG | 64×64 | 浮動按鈕 |
| `icon.svg` | SVG | 16×16 | +號圖示 |
| `vector.svg` | SVG | - | 圖示向量元素 |

### 使用方式

```dart
// 1. 將 SVG 檔案放入 assets/icons/
// 2. 在 pubspec.yaml 中註冊
// 3. 使用 flutter_svg 套件載入

import 'package:flutter_svg/flutter_svg.dart';

SvgPicture.asset(
  'assets/icons/icon.svg',
  width: 16,
  height: 16,
  color: Colors.white,
)
```

---

## ✅ 驗收標準

根據設計規格，實作必須符合以下標準：

### 視覺一致性
- ✅ 所有顏色必須與上述色彩系統完全一致
- ✅ 字體、字號、行高必須精確匹配
- ✅ 圓角、陰影必須符合規格
- ✅ 間距必須使用標準間距值

### 元件規格
- ✅ 卡片容器尺寸 320×372px
- ✅ 按鈕尺寸 64×64px 圓形
- ✅ 標題字號 16px，數字字號 72px

### 自動化測試支援
- ✅ 所有互動元件必須有唯一 Key
- ✅ 文字元件必須有 semanticsLabel
- ✅ 按鈕必須有 tooltip

---

**文件版本**: 1.0  
**最後更新**: 2025-11-20  
**設計來源**: [Figma 連結](https://www.figma.com/design/AWdcwmlvvrrjn8t19P0tR7/Untitled?node-id=0-1)
