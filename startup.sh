#!/bin/bash
# OnlineJudge Startup Script
# Run this to start all services and verify health

set -e

echo "🚀 Starting OnlineJudge System..."

# Ensure test_case permissions
echo "📁 Setting test case permissions..."
chmod -R 755 OnlineJudge/data/test_case 2>/dev/null || true

# Start all services
echo "🐳 Starting Docker containers..."
docker compose up -d --build

# Wait for services to be healthy
echo "⏳ Waiting for services to start..."
sleep 10

# Check container status
echo ""
echo "📊 Container Status:"
docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}' | grep -E 'NAMES|oj-'

# Verify backend API
echo ""
echo "🔍 Verifying backend API..."
if curl -s -f http://localhost:8000/api/website > /dev/null; then
    echo "✅ Backend API is responding"
else
    echo "❌ Backend API is not responding"
    exit 1
fi

# Verify frontend
echo ""
echo "🔍 Verifying frontend..."
if curl -s -f http://localhost:8080 > /dev/null; then
    echo "✅ Frontend is responding"
else
    echo "❌ Frontend is not responding"
    exit 1
fi

# Check judge-server health
echo ""
echo "🔍 Checking judge-server..."
JUDGE_STATUS=$(docker inspect --format='{{.State.Health.Status}}' oj-judge-server 2>/dev/null || echo "no health check")
if [ "$JUDGE_STATUS" = "healthy" ] || docker ps | grep -q "oj-judge-server.*Up"; then
    echo "✅ Judge server is running"
else
    echo "⚠️  Judge server status: $JUDGE_STATUS"
fi

# Verify test cases exist
echo ""
echo "🔍 Verifying test cases..."
TEST_CASE_COUNT=$(find OnlineJudge/data/test_case -type f -name "*.in" 2>/dev/null | wc -l | tr -d ' ')
if [ "$TEST_CASE_COUNT" -gt 0 ]; then
    echo "✅ Found $TEST_CASE_COUNT test case input files"
else
    echo "⚠️  No test case files found - judging may fail"
fi

echo ""
echo "✨ System is ready!"
echo ""
echo "📌 Access URLs:"
echo "   Frontend:  http://localhost:8080"
echo "   Backend:   http://localhost:8000"
echo "   Admin:     http://localhost:8080/admin"
echo ""
echo "🔑 Default admin credentials:"
echo "   Username: root"
echo "   Password: rootroot"
echo ""
