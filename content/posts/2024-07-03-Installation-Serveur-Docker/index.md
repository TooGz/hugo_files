---
title: "Installation d'un serveur Docker sous Ubuntu Server 24.04"
description: "Notes en vracs du suivi de l'installation & configuration"
slug: "installation-docker-ubuntu-server"
date: 2024-07-03T09:11:28+02:00
author: "TooGz"
tags: ["Docker", "Adminsys", "Ubuntu"]
cover:
    image: img/cover.jpg
    alt: "<text>"
    caption: "<text>"

ShowToc: true
draft: true
---

# Ubuntu Server 24.04 LTS
## Installation

Installation basique
Configuration OpenSSH


# Docker & Portainer

docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest


root