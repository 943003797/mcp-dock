# mcp-dock

常用MCP工具

```bash
# clone 仓库
git clone https://github.com/943003797/mcp-dock

# init & update submodule
git submodule update --init --recursive

# update submodule
git submodule update --remote --recursive
```


---



## chrome-devtools-mcp

### 启动

**macOS:**

```bash

```

**Linux:**

```bash

```

**Windows:**

```bash
运行 chrome-devtools-mcp.bat. -端口9333, 远程可用

运行 chrome-devtools-mcp-only-local.bat. -端口9222, 仅本地
```

### 配置

要在支持MCP的AI助手（如Claude、Gemini、Cursor或Copilot）中使用，添加以下配置：

```json
{
  "mcpServers": {
    "chrome-devtools": {
      "command": "npx",
      "args": ["-y", "chrome-devtools-mcp@latest"]
    }
  }
}
```
