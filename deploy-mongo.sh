#!/bin/bash

# Deploy GameStore to k3s cluster
# Usage: ./deploy.sh

K8S_DIR="k8s"

echo "Deploying MongoDB and MongoDBExpress to namespace: mongo"

# Check if kubectl is available
if ! command -v kubectl &> /dev/null; then
    echo "kubectl not found. Please install kubectl first."
    exit 1
fi

# Check if k8s directory exists
if [ ! -d "$K8S_DIR" ]; then
    echo "k8s directory not found. Please create it and add your YAML files."
    exit 1
fi

# Create namespace
echo "Creating namespace..."
kubectl apply -f ${K8S_DIR}/mongo-namespace.yaml

# Deploy mongo secret
echo "Deploying mongo secret"
kubectl apply -f ${K8S_DIR}/mongo-secret.yaml

# Deploy mongo config map
echo "Deploying mongo config map"
kubectl apply -f ${K8S_DIR}/mongo-configmap.yaml

# Deploy mongo
echo "Deploying mongo"
kubectl apply -f ${K8S_DIR}/mongo-deployment.yaml

# Deploy mongo service
echo "Deploying mongo service"
kubectl apply -f ${K8S_DIR}/mongo-service.yaml

# Deploy mongo express
echo "Deploying mongo express"
kubectl apply -f ${K8S_DIR}/mongo-express-deployment.yaml

# Deploy mongo express service
echo "Deploying mongo express service"
kubectl apply -f ${K8S_DIR}/mongo-express-service.yaml

echo ""
echo "Deployment complete!"
echo ""
echo "Check status with:"
echo "  kubectl get all -n mongo"
echo ""
echo "Access the frontend at:"
echo "  http://pi.local:30000"
