#!/bin/bash
echo "=== Starting MCP OAuth Demo Servers ==="

# Start Authorization Server w tle
echo "Starting Authorization Server on port 9000..."
cd ../mcp-python-sdk/examples/servers/simple-auth
python -m mcp_simple_auth.auth_server --port=9000 &
AUTH_SERVER_PID=$!
echo "Authorization Server PID: $AUTH_SERVER_PID"

# Wait for AS to start
sleep 3

# Start Resource Server (MCP Server) w tle  
echo "Starting Resource Server on port 8001..."
python -m mcp_simple_auth.server --port=8001 --auth-server=http://localhost:9000 --transport=streamable-http &
RESOURCE_SERVER_PID=$!
echo "Resource Server PID: $RESOURCE_SERVER_PID"

echo "=== Servers Started ==="
echo "Authorization Server: http://localhost:9000"
echo "Resource Server (MCP): http://localhost:8001"
echo ""
echo "To stop servers: kill $AUTH_SERVER_PID $RESOURCE_SERVER_PID"
echo "Press ENTER to stop all servers..."
read

kill $AUTH_SERVER_PID $RESOURCE_SERVER_PID
echo "Servers stopped"
