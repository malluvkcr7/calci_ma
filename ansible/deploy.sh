#!/bin/bash
# Ansible Deployment Script for Jenkins CI/CD
# This script works with Jenkins environment variables

echo "🚀 Starting Ansible Deployment of Scientific Calculator"
echo "======================================================="

# Variables (can be overridden by Jenkins environment)
DOCKER_IMAGE="${DOCKER_IMAGE:-malluvkcr7/sci-calc:latest}"
CONTAINER_NAME="${CONTAINER_NAME:-sci-calc-app}"
HOST_PORT="${HOST_PORT:-8090}"
CONTAINER_PORT="${CONTAINER_PORT:-8080}"
BUILD_NUMBER="${BUILD_NUMBER:-latest}"

# If BUILD_NUMBER is set, use versioned image
if [ "$BUILD_NUMBER" != "latest" ] && [ -n "$BUILD_NUMBER" ]; then
    DOCKER_IMAGE="malluvkcr7/sci-calc:${BUILD_NUMBER}"
fi

echo "📦 Deployment Configuration:"
echo "  - Image: $DOCKER_IMAGE"
echo "  - Container: $CONTAINER_NAME"
echo "  - Port Mapping: $HOST_PORT:$CONTAINER_PORT"
echo "  - Build Number: $BUILD_NUMBER"
echo

# Step 1: Stop and remove existing container (if exists)
echo "🛑 Stopping existing container..."
docker rm -f $CONTAINER_NAME 2>/dev/null || echo "  No existing container found"

# Step 2: Check if image exists or pull it
echo "⬇️  Checking Docker image..."
if docker inspect $DOCKER_IMAGE >/dev/null 2>&1; then
    echo "  ✅ Image $DOCKER_IMAGE found locally"
else
    echo "  📥 Pulling image from registry..."
    if docker pull $DOCKER_IMAGE; then
        echo "  ✅ Successfully pulled $DOCKER_IMAGE"
    else
        echo "  ❌ Failed to pull image"
        exit 1
    fi
fi

# Step 3: Deploy container
echo "🚀 Deploying container..."
CONTAINER_ID=$(docker run -d \
    --name $CONTAINER_NAME \
    -p $HOST_PORT:$CONTAINER_PORT \
    --restart=unless-stopped \
    --label "app=sci-calc" \
    --label "deployed-by=ansible" \
    --label "deployment-time=$(date -Iseconds)" \
    $DOCKER_IMAGE)  # Run web interface

if [ $? -eq 0 ]; then
    echo "  ✅ Container deployed successfully"
    echo "  📋 Container ID: ${CONTAINER_ID:0:12}"
else
    echo "  ❌ Failed to deploy container"
    exit 1
fi

# Step 4: Verify deployment
echo "🔍 Verifying deployment..."
sleep 2

if docker ps | grep -q $CONTAINER_NAME; then
    echo "  ✅ Container is running"
    
    # Test the calculator functions
    echo "🧪 Testing calculator functions..."
    
    echo "  Testing sqrt(16):"
    RESULT=$(docker exec $CONTAINER_NAME python calculator.py sqrt 16)
    echo "    Result: $RESULT"
    
    echo "  Testing factorial(5):"
    RESULT=$(docker exec $CONTAINER_NAME python calculator.py factorial 5)
    echo "    Result: $RESULT"8090
    
    echo "  Testing power(2, 3):"
    RESULT=$(docker exec $CONTAINER_NAME python calculator.py power 2 3)
    echo "    Result: $RESULT"
    
    # Wait for web server to start
    echo "  Waiting for web server..."
    sleep 3
    
    echo "  Testing web interface:"
    if curl -s http://localhost:$HOST_PORT >/dev/null 2>&1; then
        echo "    ✅ Web interface is accessible"
    else
        echo "    ⚠️  Web interface not yet ready (may need more time)"
    fi
    
    echo
    echo "🎉 Deployment completed successfully!"
    echo "📊 Deployment Summary:"
    echo "  - Status: ✅ RUNNING"
    echo "  - Container: $CONTAINER_NAME"
    echo "  - Image: $DOCKER_IMAGE"
    echo "  - Web Interface: http://localhost:$HOST_PORT"
    echo "  - CLI Mode: docker exec -it $CONTAINER_NAME python calculator.py"
    
else
    echo "  ❌ Container is not running"
    docker logs $CONTAINER_NAME
    exit 1
fi

echo
echo "🔧 Management Commands:"
echo "  View logs:        docker logs $CONTAINER_NAME"
echo "  Stop:             docker stop $CONTAINER_NAME"
echo "  Remove:           docker rm -f $CONTAINER_NAME"
echo "  CLI Calculator:   docker exec -it $CONTAINER_NAME python calculator.py"
echo "  Web Interface:    Open http://localhost:$HOST_PORT in browser"