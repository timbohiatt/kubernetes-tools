#!/usr/bin/env bash

#
#   This Script will Setup Istio with Ingress Gateway; 
#   It expects thats KubeConfig and Context is already configured.
#

# Setup Istio & Istio Ingress Gateway
echo "[INSTALL] - Install Istio"
# Setup Istio 
helm repo add istio https://istio-release.storage.googleapis.com/charts
helm repo update
kubectl create namespace istio-system
helm upgrade istio-base istio/base -n istio-system --install
helm upgrade istiod istio/istiod -n istio-system --install --wait
helm upgrade istiod istio/istiod -n istio-system --install --wait

#Sleep
sleep 60s

# Setup Istio Gateway
echo "[INSTALL] - Install Istio Gateway"
kubectl create namespace istio-ingress
kubectl label namespace istio-ingress istio-injection=enabled
helm install istio-ingress istio/gateway -n istio-ingress --wait