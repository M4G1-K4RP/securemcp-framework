#!/usr/bin/env python3
"""
Simple MCP Server for protocol analysis
"""
import asyncio
import json
from mcp import Server, serve
from mcp.types import Tool, TextContent

# Create server instance
app = Server("test-analysis-server")

@app.list_tools()
async def list_tools() -> list[Tool]:
    """List available tools"""
    return [
        Tool(
            name="echo",
            description="Echo back the input",
            inputSchema={
                "type": "object",
                "properties": {
                    "message": {"type": "string"}
                },
                "required": ["message"]
            }
        ),
        Tool(
            name="get_time",
            description="Get current server time",
            inputSchema={"type": "object", "properties": {}}
        )
    ]

@app.call_tool()
async def call_tool(name: str, arguments: dict) -> list[TextContent]:
    """Handle tool calls"""
    match name:
        case "echo":
            message = arguments.get("message", "No message provided")
            return [TextContent(type="text", text=f"Echo: {message}")]
        case "get_time":
            import datetime
            current_time = datetime.datetime.now().isoformat()
            return [TextContent(type="text", text=f"Current time: {current_time}")]
        case _:
            raise ValueError(f"Unknown tool: {name}")

if __name__ == "__main__":
    print("Starting MCP Analysis Test Server...")
    print("Server will run on stdio transport")
    asyncio.run(serve())
