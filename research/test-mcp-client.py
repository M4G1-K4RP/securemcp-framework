#!/usr/bin/env python3
"""
Simple MCP Client for protocol analysis
"""
import asyncio
import json
from mcp import Client
from mcp.transport.stdio import StdioTransport

async def test_mcp_communication():
    """Test communication with MCP server"""
    print("Starting MCP Client...")
    
    # Create transport (stdio for local testing)
    transport = StdioTransport()
    
    try:
        async with Client(transport) as client:
            # List available tools
            print("\n=== Listing Tools ===")
            tools = await client.list_tools()
            print(f"Available tools: {[tool.name for tool in tools]}")
            
            # Test echo tool
            print("\n=== Testing Echo Tool ===")
            result = await client.call_tool("echo", {"message": "Hello MCP!"})
            print(f"Echo result: {result}")
            
            # Test time tool
            print("\n=== Testing Time Tool ===")
            result = await client.call_tool("get_time", {})
            print(f"Time result: {result}")
            
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    asyncio.run(test_mcp_communication())
