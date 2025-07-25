#!/bin/bash
echo "=== ENDPOINT ENUMERATION SESSION ===" | tee endpoint-results.txt
echo "Date: $(date)" | tee -a endpoint-results.txt
echo "" | tee -a endpoint-results.txt

echo "=== TEST 1: ROOT ENDPOINTS ===" | tee -a endpoint-results.txt
curl -v http://localhost:8001/ 2>&1 | tee -a endpoint-results.txt
echo "" | tee -a endpoint-results.txt
curl -v http://localhost:9000/ 2>&1 | tee -a endpoint-results.txt
echo "" | tee -a endpoint-results.txt

echo "=== TEST 2: MCP ENDPOINTS ===" | tee -a endpoint-results.txt  
curl -v http://localhost:8001/messages 2>&1 | tee -a endpoint-results.txt
echo "" | tee -a endpoint-results.txt
curl -v http://localhost:8001/message 2>&1 | tee -a endpoint-results.txt
echo "" | tee -a endpoint-results.txt
curl -v http://localhost:8001/sse 2>&1 | tee -a endpoint-results.txt
echo "" | tee -a endpoint-results.txt

echo "=== TEST 3: OAUTH ENDPOINTS ===" | tee -a endpoint-results.txt
curl -v http://localhost:9000/authorize 2>&1 | tee -a endpoint-results.txt
echo "" | tee -a endpoint-results.txt
curl -v http://localhost:9000/token 2>&1 | tee -a endpoint-results.txt
echo "" | tee -a endpoint-results.txt

echo "=== TESTS COMPLETED ===" | tee -a endpoint-results.txt
