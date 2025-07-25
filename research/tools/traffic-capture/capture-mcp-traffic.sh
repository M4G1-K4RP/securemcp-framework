#!/bin/bash
# MCP Traffic Capture Script

CAPTURE_DIR="../../analysis/traffic-captures"
mkdir -p $CAPTURE_DIR

echo "Starting MCP traffic capture..."
echo "Capture directory: $CAPTURE_DIR"

# Start tcpdump w tle dla HTTP traffic
sudo tcpdump -i lo0 -w "$CAPTURE_DIR/mcp-http-$(date +%Y%m%d-%H%M%S).pcap" \
    'port 8080 or port 3000 or port 8000' &
TCPDUMP_PID=$!

echo "tcpdump started with PID: $TCPDUMP_PID"
echo "Press ENTER to stop capture..."
read

# Stop tcpdump
sudo kill $TCPDUMP_PID
echo "Traffic capture stopped"
echo "Capture files saved in: $CAPTURE_DIR"
ls -la $CAPTURE_DIR
