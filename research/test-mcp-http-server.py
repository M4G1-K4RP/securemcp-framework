#!/usr/bin/env python3
"""
HTTP-based MCP Server for traffic analysis
"""
import asyncio
import json
from mcp import Server
from mcp.transport.http import HTTPTransport
from mcp.types import Tool, TextContent

# Create server
app = Server("http-analysis-server")

@app.list_tools()
async def list_tools() -> list[Tool]:
    return [
        Tool(
            name="security_test",
            description="Security testing tool",
            inputSchema={
                "type": "object",
                "properties": {
                    "test_type": {"type": "string"},
                    "payload": {"type": "string"}
                }
            }
        )
    ]

@app.call_tool()
async def call_tool(name: str, arguments: dict) -> list[TextContent]:
    if name == "security_test":
        test_type = arguments.get("test_type", "basic")
        payload = arguments.get("payload", "")
        
        # Log dla security analysis
        print(f"Security test: {test_type}, Payload: {payload}")
        
        return [TextContent(
            type="text", 
            text=f"Security test completed: {test_type}"
        )]
    
    raise ValueError(f"Unknown tool: {name}")

async def main():
    print("Starting HTTP-based MCP server on http://localhost:8080")
    transport = HTTPTransport(host="localhost", port=8080)
    await transport.start(app)

if __name__ == "__main__":
    asyncio.run(main())
