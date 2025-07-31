#!/bin/bash

# Variables
FRONTEND_IMAGE="kakarot404/pools-app-frontend-for-docker:v1" 
BACKEND_IMAGE="kakarot404/pools-app-backend-for-docker:v1"
NETWORK_NAME="mongo-network"

echo  "Creating Docker network if it does not exists..."
docker network inspect $NETWORK_NAME >/dev/null 2>&1 || docker network create $NETWORK_NAME

echo "Building Docker images..."

# Building backend image
echo "Building backend image now, Thank You for your patience"
cd ./Pools-App-Backend || { echo "Error: Backend directory not found!"; exit 1; }
docker build -t $BACKEND_IMAGE .

sleep 5

# Building frontend image
echo "🛠 Building frontend image..."
cd ../Pools-App-Frontend || { echo "Error: Frontend directory not found!"; exit 1; }
docker build -t $FRONTEND_IMAGE .

sleep 5

# Pushing images to Docker Hub
echo "📦 Pushing images to Docker Hub..."
docker push kakarot404/pools-app-frontend-for-docker:v1
docker push kakarot404/pools-app-backend-for-docker:v1

echo "Starting containers..."

# Lets start MongoDB container first
echo "Running MongoDB container..."
docker run -d \
  --name mongo-container \
  -p 27017:27017 \
  --network $NETWORK_NAME \
  -e MONGO_INITDB_ROOT_USERNAME=admin \
  -e MONGO_INITDB_ROOT_PASSWORD=password \
  mongo
  
# Now Backend container
sleep 5
echo "🔌 Running Backend container..."
docker run -d \
  --name backend-container \
  -p 1234:1234 \
  --network $NETWORK_NAME \
  $BACKEND_IMAGE

# Finally Frontend container
sleep 5
echo "🌐 Running Frontend container..."
docker run -d \
  --name poolapp-frontend \
  -p 4200:4200 \
  --network $NETWORK_NAME \
  $FRONTEND_IMAGE

sleep 5
echo "We are ALMOST THERE.... !"
sleep 5
echo "Success!! All services started. Open http://localhost:4200 in your browser!"
