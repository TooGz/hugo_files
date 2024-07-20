---
title: "Installation d'un serveur Docker sous Ubuntu Server 24.04"
description: "Découvrez notre guide complet pour l'installation et la configuration de Docker CE sur Ubuntu 24.04. Suivez chaque étape détaillée, de l'installation d'Ubuntu Server à la configuration avancée de Docker et Portainer, pour optimiser la gestion et la maintenance de vos environnements Docker. Parfait pour les débutants et les administrateurs expérimentés."
slug: "installation-docker-ubuntu-server"
date: 2024-07-03T09:11:28+02:00
author: "TooGz"
tags: ["Docker", "Adminsys", "Ubuntu", "Devops", "Portainer", "zsh", "Linux"]
cover:
    image: img/cover.webp
    alt: "<text>"
    caption: "<text>"

ShowToc: true
draft: true
---


# Table des Matières
1. [Introduction](#1-introduction)
2. [Pré-requis](#2-pré-requis)
3. [Installation d'Ubuntu 24.04 Server](#3-installation-dubuntu-2404-server)
   - [Téléchargement de l'image ISO](#téléchargement-de-limage-iso)
   - [Création du média d'installation](#création-du-média-dinstallation)
   - [Installation de la distribution](#installation-de-la-distribution)
4. [Configuration Initiale du Serveur](#4-configuration-initiale-du-serveur)
   - [Connexion au serveur](#connexion-au-serveur)
   - [Mise à jour du système](#mise-à-jour-du-système)
   - [Configuration du réseau](#configuration-du-réseau)
   - [Création d'utilisateurs](#création-dutilisateurs)
5. [Sécurisation du Serveur](#5-sécurisation-du-serveur)
   - [Configuration du pare-feu](#configuration-du-pare-feu)
   - [Configuration de SSH](#configuration-de-ssh)
   - [Installation et configuration de fail2ban](#installation-et-configuration-de-fail2ban)
   - [Mise en place de sauvegardes](#mise-en-place-de-sauvegardes)
6. [Installation et Configuration des Logiciels](#6-installation-et-configuration-des-logiciels)
   - [Docker](#docker)
     - [Installation de Docker](#installation-de-docker)
     - [Vérification de l'installation de Docker](#vérification-de-linstallation-de-docker)
   - [Portainer](#portainer)
     - [Installation de Portainer](#installation-de-portainer)
     - [Accéder à l'interface Portainer](#accéder-à-linterface-portainer)
7. [Surveillance et Maintenance](#7-surveillance-et-maintenance)
   - [Installation des outils de surveillance](#installation-des-outils-de-surveillance)
     - [Installation de cAdvisor](#installation-de-cadvisor)
     - [Installation de Netdata](#installation-de-netdata)
   - [Configuration des alertes](#configuration-des-alertes)
   - [Automatisation des tâches de maintenance](#automatisation-des-tâches-de-maintenance)
8. [Dépannage](#8-dépannage)
   - [Problèmes courants et solutions](#problèmes-courants-et-solutions)
9. [Conclusion](#9-conclusion)
10. [Annexes](#10-annexes)


# 1. Introduction

Afin de consigner toutes les étapes nécessaires et les informations importantes pour l'installation d'un serveur Docker sous Ubuntu 24.04, j'ai décidé de rédiger cet article. Ce guide me servira de référence personnelle, facilitant ainsi la gestion future et la maitenance de mon système et de mes environnements Docker. En documentant le plus possible chaque étape, de l'installation initiale à la configuration avancée, je maximise les chances de ne rien oublier et de disposer d'une ressource la plus fiable et complète possible. Si vous suivez ce guide, j'espère qu'il vous sera également utile et qu'il vous permettra de naviguer facilement dans le processus d'installation de Docker sur votre système Ubuntu.

# 2. Pré-requis

Avant de commencer, assurez-vous d'avoir :

- Un ordinateur ou un serveur dédié.
- Une connexion internet stable.
- Un accès physique ou une console d'administration à distance.

Dans mon cas, cela sera un "vieux" portable Dell utilisé ecran fermé. Je part sur un Core i7 avec 16GB de ram et 256GB en SSD. Avec cette machine je devrais etre tranquille un moment.

# 3. Installation d'Ubuntu 24.04 Server
## 3.1 Téléchargement de l'image ISO

Téléchargez l'image ISO d'Ubuntu 24.04 Server depuis le [site officiel d'Ubuntu](https://ubuntu.com/download/server).

## 3.2 Création du média d'installation

Créez un média d'installation (USB/CD) avec un outil comme Rufus (Windows) ou Etcher (Linux/macOS).

## 3.3 Installation de la distribution

Insérez le média d'installation dans votre serveur et démarrez-le.
Sélectionnez "Install Ubuntu Server" dans le menu de démarrage.
Suivez les instructions à l'écran pour installer Ubuntu 24.04 sur votre machine :
Sélectionnez votre langue.
Configurez le clavier.
Configurez le réseau.
Configurez le stockage et partitionnez votre disque selon vos besoins.
Créez un utilisateur et définissez un mot de passe.
Installez les logiciels supplémentaires nécessaires.
Redémarrez le serveur une fois l'installation terminée.
















# 4. Configuration Initiale du Serveur

## 4.1 Connexion et mises à jour

- Se connecter en SSH

```bash
ssh username@server_ip
```

- Mise à jour post install

```bash
sudo apt update && sudo apt upgrade && sudo apt autoremove && sudo apt autoclean
```











# 6. Installation et configuration des applications


## 6.1 Changement de Shell [Oh my ZSH !]

- Installation **zsh**

    ```bash
    sudo apt install zsh
    ```

- Installataion [**oh-my-zsh**](https://ohmyz.sh/)
    ```bash
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    ```

- Thème [**Powerlevel10k**](https://github.com/romkatv/powerlevel10k)

    1. Cloner le repo
        ```bash
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
        ```
    2. Spécifier le thème `ZSH_THEME="powerlevel10k/powerlevel10k`dans `~/.zshrc`

- Installation de [**Zsh Syntax Highlighting**](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#oh-my-zsh)
    
    1. Cloner le repo
        ```bash
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
        ```
    2. Ajouter le plugin dans `~/.zshrc`
        ```bash
        plugins=( [plugins...] zsh-syntax-highlighting)
        ```
- Installation de [**Zsh Autosuggestions**](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh)

    1. Cloner le repo
    ```bash
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    ```    
    
    2. Ajouter le plugin dans `~/.zshrc`
    ```bash
    plugins=( 
        # other plugins...
        zsh-autosuggestions
    )
    ```

- Recharger le shell pour prendre en compte les modifications

    ```bash
    zsh
    ```

## 6.2 Installation de Docker CE

1. Ajout des repository Docker

```bash 
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$UBUNTU_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

2. Installation du paquet Docker

```bash
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

3. Exécuter l'image Docker `hello-world` pour valider le bon fonctionnement.

```bash
sudo docker run hello-world
```

Cette commande télécharge une image de test est l'éxécute en tant que conteneur. Ce conteneur affiche une message et se termine.

## 6.3 Installation de Portainer

Portainer est un outil pratique pour gérer vos conteneurs Docker via une interface graphique. Il vous permet de déployer, surveiller et administrer facilement vos conteneurs, sans avoir passer par la ligne de commande. Avec Portainer, vous pouvez voir vos stacks, volumes, réseaux et images Docker en un coup d'œil, tout en profitant de fonctionnalités avancées comme la gestion des utilisateurs et la surveillance en temps réel.

1. Création du volume que Portainer utilisera pour y stocker sa BDD

    ```bash
    docker volume create portainer_data
    ```

    Volume accessible dans `/var/lib/docker/volumes`

2. Télécharger et installer le conteneur Portainer

```bash
docker run -d -p 8000:8000 -p 9443:9443 --name bvn_portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
```