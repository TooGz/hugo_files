---
title: "Naviguer sereinement sur le dark web avec Tails"
description: "<text>"
slug: "Naviguer-sereinement-sur-le-dark-web-avec-Tails"
date: 2021-11-15T10:52:46+01:00
author: "TooGz"
tags: ["IT", "Linux", "Tails"]
cover:
    image: img/cover.gif
    alt: "<text>"
    caption: "<text>"
    relative: false # To use relative path for cover image, used in hugo Page-bundles
params:
    cover:
        linkFullImages: true
    ShowReadingTime: true
    ShowPostNavLinks: true

ShowToc: true
---

## Utiliser un ordinateur dédié pour les activités anonymes

Utiliser le même ordinateur pour plusieurs identités, c'est prendre le risque de mélanger les identités et de créer un lien entre les deux. Cela augmente également le risque d'infection inattentionnelle par un malware.

Utiliser un disque dur unique et chiffré, avec un mot de passe unique également.

## Cacher son adresse IP

### Utiliser le réseau Tor

le [réseau Tor][tor] assigne une adresse IP aléatoire n'importe où sur Terre à chaque nouvelle connexion. Les connexions passent par de multiples endroits (multihopping) avant d'arriver à destination, rendant le tracage bien plus difficile.

Cependant, les noeuds de sortie Tor sont souvent blacklistés et ne peuvent etre utilisés avex tout les services. Tor est plus lent qu'un service de VPN (bien que complémentaire)

### Utiliser un VPN qui ne log RIEN

Choisir un fournisseur VPN qui ne log rien à propos de ses utilisateurs **ET** un logiciel client qui ne fait pas fuiter du traffic. Cela rends plus difficile la remonté jusqu'à la source. Le fournisseurs doit également permettre de payer anonymement.

[Mullvad VPN][mullvad] rempli tout ces critères et bien plus encore.

### Utiliser un VPN via TOR ou plusieurs VPN simultanément

Utiliser plusieurs services VPN ensemble ou un VPN passant par un tunnel Tor. Anonymat coté Tor et et fournisseur VPN (qui normalement ne log rien).

Personne n'aura l'image complète sur vos activités en ligne.





[tor]:https://www.torproject.org "Site du projet Tor"
[mullvad]:https://mullvad.net/fr/ "Site du VPN Mullvad"