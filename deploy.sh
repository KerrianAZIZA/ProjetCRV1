#!/bin/bash

# 1. Construire les images Docker

echo "Construction de l'image Docker pour React..."
docker build -t react:latest ./redis-react --file ./redis-react/Dockerfile
if [ $? -ne 0 ]; then
    echo "Erreur lors de la construction de l'image Docker React."
    exit 1
fi

echo "Construction de l'image Docker pour Node.js..."
docker build -t nodejs:latest ./redis-node --file ./redis-node/Dockerfile
if [ $? -ne 0 ]; then
    echo "Erreur lors de la construction de l'image Docker Node.js."
    exit 1
fi

# 2. Puller l'image Redis officielle
echo "Pull de l'image Docker Redis avec le tag latest..."
docker pull redis:latest
docker run -d --name redis redis:latest
if [ $? -ne 0 ]; then
    echo "Erreur lors du pull de l'image Docker Redis."
    exit 1
fi

# 3. Démarrer Minikube
echo "Démarrage de Minikube..."
minikube start --driver=docker
if [ $? -ne 0 ]; then
    echo "Erreur lors du démarrage de Minikube."
    exit 1
fi

# 4. Appliquer les fichiers Kubernetes
echo "Application des fichiers Kubernetes dans /deployment..."

# Vérifie que le dossier /deployment existe
if [ ! -d "./deployment" ]; then
    echo "Le dossier /deployment n'existe pas !"
    exit 1
fi

# Applique tous les fichiers YAML dans le dossier /deployment
kubectl apply -f ./deployment/
if [ $? -ne 0 ]; then
    echo "Erreur lors de l'application des fichiers Kubernetes."
    exit 1
fi

echo "Tout est prêt ! Les services sont déployés."

#Attente que les Pods soient prêts
echo "Attente que les Pods soient prêts..."
kubectl wait --for=condition=ready pod --all --timeout=100s

echo "Vérification du statut des Pods..."
kubectl get pods
