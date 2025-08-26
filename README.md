# 🔁 Self-Hosted CI/CD Pipeline: Jenkins / GitLab CI + Local Kubernetes

## Overview

This project demonstrates a fully self-hosted CI/CD pipeline that automates the software lifecycle: **build → test → deploy** into a local Kubernetes cluster. It uses either Jenkins or GitLab CI running in Docker, and deploys containerized applications to Minikube or Kind.

Perfect for showcasing DevOps skills without relying on cloud services.

## 🧩 Architecture

```
+----------------+       +----------------+       +------------------+
|  Git Repo      |  -->  | CI Server      |  -->  | Kubernetes Cluster|
| (Local/Remote) |       | (Jenkins/GitLab)|       | (Minikube/Kind)  |
+----------------+       +----------------+       +------------------+
       |                        |                          |
       |                        |                          |
       |                        |                          |
       |                        |                          |
       |                        |                          |
       v                        v                          v
 Commit Code         Build & Test App           Deploy via kubectl/Helm
```

## 🔧 Tech Stack

- **CI Tools**: Jenkins or GitLab CI (Dockerized)
- **Containerization**: Docker
- **Kubernetes**: Minikube or Kind
- **Deployment**: kubectl, Helm (optional)
- **Languages**: Python / Node.js / Go (customizable)

## 🚀 Getting Started

### 1. Clone the Repo

```bash
git clone https://github.com/yourusername/self-hosted-cicd-k8s.git
cd self-hosted-cicd-k8s
```

### 2. Start Kubernetes Cluster

Using Minikube:

```bash
minikube start
```

Or Kind:

```bash
kind create cluster
```

### 3. Launch CI Server

#### Jenkins

```bash
docker-compose up -d jenkins
```

#### GitLab CI

```bash
docker-compose up -d gitlab
```

### 4. Configure CI Pipeline

- Jenkins: Use `Jenkinsfile` in the repo
- GitLab CI: Use `.gitlab-ci.yml`

Pipeline stages:

```yaml
stages:
  - build
  - test
  - deploy
```

Each stage runs in a container and uses `kubectl` or Helm to deploy to the local cluster.

### 5. Trigger Pipeline

Push code or manually trigger via Jenkins/GitLab UI.

### 6. Verify Deployment

```bash
kubectl get pods
kubectl get svc
```

Access the app via NodePort or Ingress.

## 📁 Folder Structure

```
.
├── Jenkinsfile / .gitlab-ci.yml
├── docker-compose.yml
├── app/
│   └── main.py / index.js
├── k8s/
│   └── deployment.yaml
│   └── service.yaml
└── ci/
    └── Dockerfile
```

## 🧪 Features

- Automated build/test/deploy pipeline
- Rollback on failure (optional)
- Local-only setup (no cloud required)
- Extensible to multiple environments

## 📚 Learning Outcomes

- Master CI/CD fundamentals with Jenkins/GitLab
- Deploy containerized apps to Kubernetes
- Practice YAML-based infrastructure and Helm
- Build a portfolio-ready DevOps pipeline
+------------------+
|  Developer Push  |
|  (Git Commit)    |
+--------+---------+
         |
         v
+------------------+
|   CI Server      |
| Jenkins / GitLab |
+--------+---------+
         |
         v
+------------------+
|   Build Stage    |
| Docker Image     |
+--------+---------+
         |
         v
+------------------+
|   Test Stage     |
| Unit / Lint / E2E|
+--------+---------+
         |
         v
+------------------+
|   Deploy Stage   |
| kubectl / Helm   |
+--------+---------+
         |
         v
+--------------------------+
| Local Kubernetes Cluster |
| Minikube / Kind          |
+--------------------------+
         |
         v
+------------------+
| Running Services |
| App + Monitoring |
+------------------+

