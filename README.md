<<<<<<< HEAD
Ce projet a été fait par Kerrian AZIZA et Luka BALY

Il est constitué de 3 repértoires différents: deployments, redis-node et redis-react
Pour lancer le projet, il suffit d'executer le script deploy.sh et pour arrêter le projet, il suffit d'appeler shutdown.sh
Attention : s'il y a déjà des images nommées redis, nodejs ou react, le script ne se lancera pas, il faudra d'abord les supprimer. 

## Structure du projet

Le projet est structuré de la manière suivante :

```
.
├── deploy.sh                          # Script d'automatisation pour déployer l'infrastructure
├── shutdown.sh
├── redis-node
	├── Dockerfile
├── redis-react
	├── Dockerfile
├── deployement
	├── redis-deployment.yml               # Déploiement de Redis (master et réplicas)
	├── backend-deployment.yml             # Déploiement du backend NodeJS
	├── backend-service.yml                # Service de NodeJS
	├── backend-hpa.yml                    # Horizontal Pod Autoscaler pour NodeJS
	├── redis-hpa.yml                      # Horizontal Pod Autoscaler pour Redis
	├── redis-pv.yml                       # Volumes persistents de Redis
	├── redis-pvc.yml                      # Claim Volumes persistents de Redis
	├── redis-service.yml                  # Service pour Redis
	├── prometheus-config.yml              # Fichier de configuration de Prometheus
	├── prometheus-deployment.yml          # Déploiement de Prometheus
	├── prometheus-service.yml             # Service Kubernetes pour Prometheus et Grafana
	├── redis-node-frontend-deployment.yml # Déploiement de React
	├── redis-node-frontend-hpa.yml        # Horizontal Pod Autoscaler pour React
	├── redis-node-frontend-service.yml    # Service de React
└── README.md                          # Ce fichier
```

Pour accéder aux différents services, il est impératif d'ouvrir un autre terminal pour lancer la commande minikube tunnel
L'explication du projet et des implémentations se trouvera dans le rapport.
=======
# ProjetCRV1
>>>>>>> ac5958fdd734464fdf5a4447940a4041e6cc5875
