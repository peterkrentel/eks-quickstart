#!/bin/bash

set -e  # Exit if any command fails
set -o pipefail

# Optional: Create cluster (uncomment if needed)
# echo "Creating EKS cluster..."
# eksctl create cluster -f cluster-config.yaml

echo "Waiting for Kubernetes API to be ready..."
until kubectl version --short &> /dev/null; do
  echo "Waiting for cluster..."
  sleep 5
done

echo "Applying IngressClass..."
kubectl apply -f ingressclass.yaml

echo "Creating namespace if not exists..."
kubectl get ns game-2048 &> /dev/null || kubectl create namespace game-2048

echo "Deploying 2048 game app..."
kubectl apply -n game-2048 -f https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.8.0/docs/examples/2048/2048_full.yaml

echo "Waiting for 2048 deployment to be ready..."
kubectl rollout status -n game-2048 deployment/2048-deployment

echo "🎉 All done."
