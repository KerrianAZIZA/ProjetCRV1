#!/bin/bash


echo "Mise à zéro des réplicas des deployments et statefulsets..."
kubectl scale deployment --all --replicas=0
kubectl scale statefulset --all --replicas=0

# 1. Supprimer toutes les ressources Kubernetes (pods, deployments, services, etc.)
echo "Suppression des pods, deployments, services, volumes, etc. sur Kubernetes..."
kubectl delete pods --all --grace-period=0 --force
kubectl delete deployments --all --grace-period=0 --force
kubectl delete services --all --grace-period=0 --force
kubectl delete persistentvolumeclaim --all --grace-period=0 --force
kubectl delete persistentvolume --all --grace-period=0 --force

if [ $? -ne 0 ]; then
    echo "Erreur lors de la suppression des ressources Kubernetes."
    exit 1
fi

# 2. Eteindre Minikube
echo "Arrêt de Minikube..."
minikube stop
if [ $? -ne 0 ]; then
    echo "Erreur lors de l'arrêt de Minikube."
    exit 1
fi

# 3. Supprimer les conteneurs Docker
echo "Suppression des conteneurs Docker..."
docker stop $(docker ps -a -q)
docker rm -f $(docker ps -a -q)
if [ $? -ne 0 ]; then
    echo "Erreur lors de la suppression des conteneurs Docker."
    exit 1
fi

# 4. Supprimer les images Docker
echo "Suppression des images Docker..."
docker rmi -f redis:latest react:latest nodejs:latest
if [ $? -ne 0 ]; then
    echo "Erreur lors de la suppression des images Docker."
    exit 1
fi

# 5. Nettoyer les volumes Docker inutilisés
echo "Suppression des volumes Docker inutilisés..."
docker volume prune -f
if [ $? -ne 0 ]; then
    echo "Erreur lors de la suppression des volumes Docker."
    exit 1
fi

echo "Nettoyage de Minikube"
minikube delete
echo "Nettoyage terminé."
