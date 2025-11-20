# Figma Personal Access Token 設定指南

**文件類型**: 操作指南  
**建立日期**: 2025-11-20  
**適用對象**: 開發團隊成員、設計師

## 📋 概述

Figma Personal Access Token (個人存取權杖) 允許外部應用程式透過 Figma API 存取您的設計檔案。本指南將協助您建立並設定 Token，以便在開發流程中整合 Figma 設計資源。

## 🎯 使用情境

- 自動化設計資源匯出（圖示、圖片、樣式）
- 整合設計系統與程式碼（Design Tokens）
- 透過 MCP (Model Context Protocol) 讓 AI 助手讀取 Figma 設計
- 建構設計與開發間的自動化工作流程

## 🔑 建立 Personal Access Token

### 步驟 1: 登入 Figma

1. 前往 [Figma 官網](https://www.figma.com)
2. 使用您的帳號登入

### 步驟 2: 進入設定頁面

1. 點擊右上角的**個人頭像**
2. 選擇 **Settings**（設定）
3. 在左側選單中找到 **Account**（帳戶）標籤

### 步驟 3: 產生新的 Token

1. 向下捲動至 **Personal access tokens** 區塊
2. 點擊 **Generate new token**（產生新權杖）按鈕
3. 為您的 Token 輸入一個有意義的名稱
   - 建議命名範例：
     - `Counter Flutter 開發專案`
     - `本機開發環境 - [您的名字]`
     - `CI/CD 自動化工具`
4. 點擊 **Generate token**（產生權杖）

### 步驟 4: 複製並保存 Token

⚠️ **重要提醒**：Token 只會顯示一次！請立即複製並妥善保存。

1. Token 產生後會顯示一串類似這樣的字串：
   ```
   figd_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
   ```
2. 點擊 **Copy**（複製）按鈕
3. 將 Token 保存到安全的地方（見下方「安全保存」章節）

## 🔒 Token 安全保存方式

### 方式 1: 環境變數（推薦用於開發環境）

#### macOS / Linux

編輯您的 shell 設定檔案：

```bash
# 編輯 ~/.zshrc (如果使用 zsh) 或 ~/.bashrc (如果使用 bash)
nano ~/.zshrc

# 加入以下內容
export FIGMA_ACCESS_TOKEN="figd_你的實際Token"

# 重新載入設定
source ~/.zshrc
```

#### Windows (PowerShell)

```powershell
# 設定使用者層級環境變數
[System.Environment]::SetEnvironmentVariable('FIGMA_ACCESS_TOKEN', 'figd_你的實際Token', 'User')

# 重新啟動 PowerShell 以套用變更
```

### 方式 2: .env 檔案（推薦用於專案開發）

1. 在專案根目錄建立 `.env` 檔案：

```bash
# .env
FIGMA_ACCESS_TOKEN=figd_你的實際Token
```

2. **務必**將 `.env` 加入 `.gitignore`：

```bash
# .gitignore
.env
.env.local
```

3. 建立 `.env.example` 範本供團隊參考：

```bash
# .env.example
FIGMA_ACCESS_TOKEN=your_figma_token_here
```

### 方式 3: VS Code 設定檔（用於 MCP 整合）

如果使用 VS Code 的 MCP (Model Context Protocol) 整合：

1. 開啟 VS Code 設定 (`Cmd/Ctrl + ,`)
2. 搜尋 "MCP" 或相關擴充功能設定
3. 在設定中加入 Figma Token

或直接編輯 `settings.json`：

```json
{
  "mcp.servers": {
    "talktofigma": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-figma"],
      "env": {
        "FIGMA_PERSONAL_ACCESS_TOKEN": "figd_你的實際Token"
      }
    }
  }
}
```

## ✅ 驗證 Token 是否有效

### 使用 curl 測試（終端機）

```bash
curl -H "X-Figma-Token: $FIGMA_ACCESS_TOKEN" \
     https://api.figma.com/v1/me
```

成功的回應範例：

```json
{
  "id": "1234567890",
  "email": "your-email@example.com",
  "handle": "Your Name",
  "img_url": "https://..."
}
```

### 使用 Flutter/Dart 測試

```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> testFigmaToken() async {
  const token = String.fromEnvironment('FIGMA_ACCESS_TOKEN');
  
  final response = await http.get(
    Uri.parse('https://api.figma.com/v1/me'),
    headers: {'X-Figma-Token': token},
  );
  
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print('✅ Token 有效！使用者：${data['handle']}');
  } else {
    print('❌ Token 無效或已過期');
  }
}
```

## 🚨 安全性最佳實踐

### ✅ 應該做的事

- ✅ 使用環境變數或加密的設定管理工具
- ✅ 將 `.env` 檔案加入 `.gitignore`
- ✅ 為不同環境使用不同的 Token（開發、測試、正式環境）
- ✅ 定期更換 Token（建議每 3-6 個月）
- ✅ 為 Token 使用描述性名稱，方便日後管理
- ✅ 限制 Token 的存取權限（僅授予必要權限）

### ❌ 不應該做的事

- ❌ **絕對不要**將 Token 直接寫在程式碼中
- ❌ **絕對不要**將 Token 提交到 Git 版本控制
- ❌ **絕對不要**在公開的地方分享 Token（Slack、Email、截圖）
- ❌ **絕對不要**在前端程式碼中暴露 Token
- ❌ **絕對不要**使用同一個 Token 給多個不同的服務

## 🔄 Token 管理

### 檢視現有 Token

1. 前往 Figma Settings → Account
2. 捲動至 **Personal access tokens**
3. 查看所有已建立的 Token 列表

### 撤銷 Token

如果 Token 洩漏或不再使用：

1. 在 Token 列表中找到該 Token
2. 點擊 **Delete**（刪除）按鈕
3. 確認刪除

⚠️ **注意**：撤銷後，所有使用該 Token 的服務將立即無法存取。

### 重新產生 Token

Token 無法編輯或重新顯示，如需更換：

1. 刪除舊的 Token
2. 按照上述步驟產生新的 Token
3. 更新所有使用該 Token 的服務設定

## 📚 常見問題

### Q1: Token 遺失了怎麼辦？

A: Token 無法重新顯示。您需要：
1. 撤銷舊的 Token
2. 產生新的 Token
3. 更新所有服務的設定

### Q2: 一個帳號可以建立多少個 Token？

A: Figma 沒有明確限制 Token 數量，但建議為不同用途建立不同的 Token，方便管理。

### Q3: Token 會過期嗎？

A: Personal Access Token 預設不會過期，但基於安全考量，建議定期更換。

### Q4: Token 權限範圍是什麼？

A: Personal Access Token 擁有與您的帳號相同的權限，可以存取所有您有權限的檔案。

### Q5: 如何在 CI/CD 環境中使用 Token？

A: 使用 CI/CD 平台的加密環境變數功能（例如 GitHub Secrets、GitLab CI/CD Variables）。

## 🔗 相關資源

- [Figma API 官方文件](https://www.figma.com/developers/api)
- [Figma Authentication 說明](https://www.figma.com/developers/api#authentication)
- [MCP Figma Server](https://github.com/modelcontextprotocol/servers/tree/main/src/figma)

## 📝 更新記錄

| 日期 | 版本 | 變更內容 | 作者 |
|------|------|---------|------|
| 2025-11-20 | 1.0.0 | 初始版本，包含完整設定指南 | - |

---

**注意事項**：本文件遵循專案憲章第 V 條「文件語言政策」，屬於使用者導向文件，因此使用繁體中文撰寫。如需技術整合文件，請參考英文版本的 API 文件。
