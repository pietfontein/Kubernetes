#!/bin/bash
set -e

echo "Running health checks for $APP_NAME in namespace $NAMESPACE"

# Wait for pods to be ready
kubectl wait --for=condition=ready pod \
  -l app=$APP_NAME \
  -n $NAMESPACE \
  --timeout=300s

# Get service details
SERVICE_INFO=$(kubectl get service ${APP_NAME}-service -n $NAMESPACE -o json)

# Determine how to access the service
if echo "$SERVICE_INFO" | jq -e '.spec.type == "LoadBalancer"' > /dev/null; then
  # LoadBalancer service
  IP=$(kubectl get service ${APP_NAME}-service -n $NAMESPACE -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
  PORT=80
  URL="http://$IP"
elif echo "$SERVICE_INFO" | jq -e '.spec.type == "NodePort"' > /dev/null; then
  # NodePort service - use port-forward
  kubectl port-forward service/${APP_NAME}-service 8080:80 -n $NAMESPACE &
  PF_PID=$!
  sleep 5
  URL="http://localhost:8080"
else
  # ClusterIP service - use port-forward
  kubectl port-forward service/${APP_NAME}-service 8080:80 -n $NAMESPACE &
  PF_PID=$!
  sleep 5
  URL="http://localhost:8080"
fi

# Run health check
echo "Health check URL: $URL/health"
curl -f "$URL/health" || exit 1

# Clean up port-forward if used
if [ -n "$PF_PID" ]; then
  kill $PF_PID
fi

echo "Health check passed successfully"
