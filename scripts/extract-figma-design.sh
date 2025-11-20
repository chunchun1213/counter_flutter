#!/bin/bash

# Figma Design Assets Extractor
# 此腳本會從 Figma REST API 讀取設計資源並提取所有必要資訊

set -e

# ==================== 設定 ====================
FIGMA_FILE_KEY="AWdcwmlvvrrjn8t19P0tR7"
FIGMA_NODE_ID="0-1"
OUTPUT_DIR="design-assets"
DESIGN_SPEC_FILE="docs/design-spec.json"

# 檢查 Token
if [ -z "$FIGMA_ACCESS_TOKEN" ]; then
    echo "❌ 錯誤: 找不到 FIGMA_ACCESS_TOKEN 環境變數"
    echo ""
    echo "請執行以下步驟："
    echo "1. 依照 docs/figma-token-setup.md 建立 Figma Personal Access Token"
    echo "2. 建立 .env 檔案: cp .env.example .env"
    echo "3. 在 .env 中填入您的 Token"
    echo "4. 執行: source .env"
    echo "5. 重新執行此腳本"
    exit 1
fi

echo "🚀 開始提取 Figma 設計資源..."
echo "📄 Figma 檔案 ID: $FIGMA_FILE_KEY"
echo ""

# 建立輸出目錄
mkdir -p "$OUTPUT_DIR"
mkdir -p "$(dirname "$DESIGN_SPEC_FILE")"

# ==================== 1. 獲取檔案資訊 ====================
echo "📥 [1/6] 讀取 Figma 檔案資訊..."
FILE_DATA=$(curl -s -H "X-Figma-Token: $FIGMA_ACCESS_TOKEN" \
    "https://api.figma.com/v1/files/$FIGMA_FILE_KEY")

# 檢查 API 回應
if echo "$FILE_DATA" | grep -q '"status":4'; then
    echo "❌ 錯誤: Figma API 認證失敗，請檢查您的 Token 是否正確"
    exit 1
fi

if echo "$FILE_DATA" | grep -q '"err"'; then
    echo "❌ 錯誤: 無法讀取 Figma 檔案"
    echo "$FILE_DATA" | jq '.err' || echo "$FILE_DATA"
    exit 1
fi

echo "✅ 檔案資訊讀取成功"
FILE_NAME=$(echo "$FILE_DATA" | jq -r '.name')
echo "   檔案名稱: $FILE_NAME"

# ==================== 2. 提取所有頁面 ====================
echo ""
echo "📄 [2/6] 提取所有頁面..."
PAGES=$(echo "$FILE_DATA" | jq -c '.document.children[]')
PAGE_COUNT=$(echo "$PAGES" | wc -l | tr -d ' ')
echo "   找到 $PAGE_COUNT 個頁面"

PAGE_INDEX=0
while IFS= read -r page; do
    PAGE_INDEX=$((PAGE_INDEX + 1))
    PAGE_NAME=$(echo "$page" | jq -r '.name')
    PAGE_ID=$(echo "$page" | jq -r '.id')
    echo "   [$PAGE_INDEX/$PAGE_COUNT] $PAGE_NAME (ID: $PAGE_ID)"
done <<< "$PAGES"

# ==================== 3. 提取樣式 (Styles) ====================
echo ""
echo "🎨 [3/6] 提取設計系統樣式..."

# 3.1 色彩
echo "   → 提取色彩定義..."
COLORS=$(echo "$FILE_DATA" | jq '[
    .styles | to_entries[] | 
    select(.value.styleType == "FILL") | 
    {
        name: .value.name,
        key: .key,
        description: .value.description
    }
]')
echo "      找到 $(echo "$COLORS" | jq 'length') 個色彩樣式"

# 3.2 文字樣式
echo "   → 提取文字樣式..."
TEXT_STYLES=$(echo "$FILE_DATA" | jq '[
    .styles | to_entries[] | 
    select(.value.styleType == "TEXT") | 
    {
        name: .value.name,
        key: .key,
        description: .value.description
    }
]')
echo "      找到 $(echo "$TEXT_STYLES" | jq 'length') 個文字樣式"

# 3.3 特效 (陰影等)
echo "   → 提取特效樣式..."
EFFECT_STYLES=$(echo "$FILE_DATA" | jq '[
    .styles | to_entries[] | 
    select(.value.styleType == "EFFECT") | 
    {
        name: .value.name,
        key: .key,
        description: .value.description
    }
]')
echo "      找到 $(echo "$EFFECT_STYLES" | jq 'length') 個特效樣式"

# ==================== 4. 提取元件 (Components) ====================
echo ""
echo "🧩 [4/6] 提取可重用元件..."
COMPONENTS=$(echo "$FILE_DATA" | jq '[
    .components | to_entries[] | 
    {
        name: .value.name,
        key: .key,
        description: .value.description,
        componentSetId: .value.componentSetId
    }
]')
COMPONENT_COUNT=$(echo "$COMPONENTS" | jq 'length')
echo "   找到 $COMPONENT_COUNT 個元件"

# ==================== 5. 分析節點並提取設計參數 ====================
echo ""
echo "🔍 [5/6] 分析設計參數..."

# 遞迴函數來分析節點
analyze_node() {
    local node="$1"
    local node_type=$(echo "$node" | jq -r '.type')
    local node_name=$(echo "$node" | jq -r '.name')
    
    # 提取各種屬性
    case "$node_type" in
        "FRAME"|"GROUP"|"COMPONENT"|"INSTANCE")
            # 提取佈局屬性
            echo "$node" | jq '{
                type: .type,
                name: .name,
                width: .absoluteBoundingBox.width,
                height: .absoluteBoundingBox.height,
                x: .absoluteBoundingBox.x,
                y: .absoluteBoundingBox.y,
                layoutMode: .layoutMode,
                primaryAxisAlignItems: .primaryAxisAlignItems,
                counterAxisAlignItems: .counterAxisAlignItems,
                paddingLeft: .paddingLeft,
                paddingRight: .paddingRight,
                paddingTop: .paddingTop,
                paddingBottom: .paddingBottom,
                itemSpacing: .itemSpacing,
                cornerRadius: .cornerRadius,
                fills: .fills,
                strokes: .strokes,
                effects: .effects
            }'
            ;;
        "TEXT")
            # 提取文字屬性
            echo "$node" | jq '{
                type: .type,
                name: .name,
                characters: .characters,
                fontSize: .style.fontSize,
                fontFamily: .style.fontFamily,
                fontWeight: .style.fontWeight,
                letterSpacing: .style.letterSpacing,
                lineHeight: .style.lineHeightPx,
                fills: .fills
            }'
            ;;
    esac
}

# 收集所有設計參數
echo "   → 分析圓角 (Corner Radius)..."
CORNER_RADII=$(echo "$FILE_DATA" | jq -r '
    .. | objects | select(.cornerRadius != null) | 
    "\(.name // "unnamed"):\(.cornerRadius)"
' | sort -u | head -20)

echo "   → 分析間距 (Spacing)..."
SPACINGS=$(echo "$FILE_DATA" | jq -r '
    .. | objects | 
    select(.itemSpacing != null or .paddingLeft != null) | 
    "itemSpacing:\(.itemSpacing // "null") padding:[\(.paddingLeft // 0),\(.paddingTop // 0),\(.paddingRight // 0),\(.paddingBottom // 0)]"
' | sort -u | head -20)

echo "   → 分析陰影效果..."
EFFECTS=$(echo "$FILE_DATA" | jq '[
    .. | objects | select(.effects != null and (.effects | length) > 0) | 
    {
        name: .name,
        effects: .effects
    }
] | unique_by(.name) | .[0:10]')

echo "   → 分析文字樣式..."
TEXT_PROPS=$(echo "$FILE_DATA" | jq '[
    .. | objects | select(.type == "TEXT") | 
    {
        name: .name,
        fontSize: .style.fontSize,
        fontFamily: .style.fontFamily,
        fontWeight: .style.fontWeight,
        lineHeight: .style.lineHeightPx
    }
] | unique_by(.fontSize) | .[0:10]')

# ==================== 6. 匯出圖片資源 ====================
echo ""
echo "🖼️  [6/6] 匯出圖片資源..."

# 收集所有需要匯出的節點 ID
echo "   → 收集可匯出的節點..."
EXPORTABLE_NODES=$(echo "$FILE_DATA" | jq -r '
    .. | objects | 
    select(.type == "COMPONENT" or .type == "FRAME" or .type == "VECTOR" or .type == "RECTANGLE") | 
    select(.name != null and .id != null) | 
    .id
' | head -50)  # 限制前 50 個節點

if [ -z "$EXPORTABLE_NODES" ]; then
    echo "   ⚠️  未找到可匯出的節點"
else
    EXPORT_COUNT=$(echo "$EXPORTABLE_NODES" | wc -l | tr -d ' ')
    echo "   找到 $EXPORT_COUNT 個可匯出節點"
    
    EXPORT_INDEX=0
    while IFS= read -r node_id; do
        EXPORT_INDEX=$((EXPORT_INDEX + 1))
        
        # 獲取節點名稱
        NODE_NAME=$(echo "$FILE_DATA" | jq -r --arg id "$node_id" '
            .. | objects | select(.id == $id) | .name
        ' | head -1)
        
        # 生成安全的檔案名稱
        SAFE_NAME=$(echo "$NODE_NAME" | sed 's/[^a-zA-Z0-9_-]/_/g' | tr '[:upper:]' '[:lower:]')
        
        echo "   [$EXPORT_INDEX/$EXPORT_COUNT] 匯出: $NODE_NAME"
        
        # 嘗試匯出 SVG
        echo "      → 嘗試 SVG 格式..."
        IMAGE_URL=$(curl -s -H "X-Figma-Token: $FIGMA_ACCESS_TOKEN" \
            "https://api.figma.com/v1/images/$FIGMA_FILE_KEY?ids=$node_id&format=svg" | \
            jq -r ".images[\"$node_id\"]")
        
        if [ "$IMAGE_URL" != "null" ] && [ -n "$IMAGE_URL" ]; then
            curl -s -o "$OUTPUT_DIR/${SAFE_NAME}.svg" "$IMAGE_URL"
            echo "      ✅ SVG 已儲存: ${SAFE_NAME}.svg"
        else
            # 備用: 匯出 PNG @2x
            echo "      → SVG 失敗，嘗試 PNG @2x..."
            IMAGE_URL=$(curl -s -H "X-Figma-Token: $FIGMA_ACCESS_TOKEN" \
                "https://api.figma.com/v1/images/$FIGMA_FILE_KEY?ids=$node_id&format=png&scale=2" | \
                jq -r ".images[\"$node_id\"]")
            
            if [ "$IMAGE_URL" != "null" ] && [ -n "$IMAGE_URL" ]; then
                curl -s -o "$OUTPUT_DIR/${SAFE_NAME}@2x.png" "$IMAGE_URL"
                echo "      ✅ PNG @2x 已儲存: ${SAFE_NAME}@2x.png"
            else
                echo "      ⚠️  匯出失敗"
            fi
        fi
        
        # 避免 API rate limit
        sleep 0.5
    done <<< "$EXPORTABLE_NODES"
fi

# ==================== 7. 產生設計規格 JSON ====================
echo ""
echo "📝 產生設計規格文件..."

cat > "$DESIGN_SPEC_FILE" <<EOF
{
  "metadata": {
    "figmaFileKey": "$FIGMA_FILE_KEY",
    "fileName": "$FILE_NAME",
    "extractedAt": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
    "pageCount": $PAGE_COUNT,
    "componentCount": $COMPONENT_COUNT
  },
  "colors": $COLORS,
  "textStyles": $TEXT_STYLES,
  "effectStyles": $EFFECT_STYLES,
  "components": $COMPONENTS,
  "designTokens": {
    "cornerRadii": $(echo "$CORNER_RADII" | jq -R -s 'split("\n") | map(select(length > 0))'),
    "spacings": $(echo "$SPACINGS" | jq -R -s 'split("\n") | map(select(length > 0))'),
    "effects": $EFFECTS,
    "textProperties": $TEXT_PROPS
  }
}
EOF

echo "✅ 設計規格已儲存: $DESIGN_SPEC_FILE"

# ==================== 完成 ====================
echo ""
echo "🎉 完成！設計資源提取完畢"
echo ""
echo "📂 輸出檔案："
echo "   - 設計規格: $DESIGN_SPEC_FILE"
echo "   - 圖片資源: $OUTPUT_DIR/"
echo ""
echo "💡 下一步："
echo "   1. 檢視 $DESIGN_SPEC_FILE 了解設計系統"
echo "   2. 查看 $OUTPUT_DIR/ 資料夾中的匯出圖片"
echo "   3. 執行 /speckit.specify 建立功能規格"
