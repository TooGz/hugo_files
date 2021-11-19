---
title: "Configurer PGP pour chiffrer ses mails"
description: "<text>"
slug: "Configurer-PGP-pour-chiffrer-ses-mails"
date: 2021-11-18T09:56:25+01:00
author: "TooGz"
tags: ["tuto", "PGP", "mail"]
cover:
    image: img/cover.jpg
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

# Présentation succinte

PGP (Pretty Good Privacy) est un système de chiffrement open-source, couramment utilisé pour le chiffrage d’emails ou de fichiers.

Inventé en 1991, PGP s’est imposé comme un standard pour la sécurité des emails. Sa popularité est liée à deux principaux avantages.

Tout d’abord, ce système est à l’origine un  "freeware" (logiciel gratuit). Cette gratuité lui a permis de se propager très rapidement parmi les internautes qui désiraient profiter d’un niveau de sécurité supplémentaire pour leurs échanges d’emails.

En outre, PGP utilise à la fois le chiffrement symétrique et le chiffrement par clé publique. Ceci permet à des utilisateurs de s’envoyer des messages chiffrés, sans même avoir besoin d’échanger des clés de chiffrement privées au préalable. Ainsi, le PGP permet de renforcer facilement et à moindre coût la sécurité des emails.

# Fonctionnement de PGP

Il existe de nombreux systèmes de chiffrement. En guise d’exemples, on peut citer SSL pour le chiffrement de sites web, ou Kerberos pour l’authentification des utilisateurs d’un réseau.

Le PGP partage plusieurs caractéristiques avec ces systèmes. Il repose sur une combinaison entre les clés de chiffrement symétriques, et les clés de chiffrement publiques.

Tout d’abord, PGP génère une clé de session aléatoire en utilisant un premier algorithme. Cette clé est un très long nombre qui ne peut pas être deviné, et ne peut être utilisé qu’une seule fois.

La clé de session est ensuite chiffrée. Ce chiffrement est effectué en utilisant la clé publique du destinataire. Chaque clé publique est associée à une personne en particulier, mais n’importe qui peut l’utiliser pour lui envoyer un message.

L’expéditeur envoie sa clé de session PGP chiffrée au destinataire, et celui-ci est ensuite en mesure de la déchiffrer en utilisant sa clé privée. En utilisant la clé de session, le destinataire peut finalement déchiffrer le message.

Le chiffrement symétrique est plus rapide que le chiffrement par clé publique, mais requiert le partage d’une clé de chiffrement en texte clair avec le destinataire. Ce fonctionnement ne serait pas sécurisé.

C’est la raison pour laquelle on utilise une clé de chiffrement publique pour chiffrer la clé de session. Ainsi, PGP combine l’efficacité du chiffrement symétrique et la sécurité du chiffrement par clé publique.


# Configuration des clients mails

## Thunderbird

### Générer sa clé PGPk

Le client mail Thunderbird supporte nativement OpenPGP depuis la version 78.

1. Aller dans Parametres de comptes > Choisir votre compte > Chiffrement de bout en bout.


2. Cliquer sur Ajouter une clé ...

![](img/thunderbolt-configuration-pgp-0.png#center)


3. Ensuite, créer une clé OpenPGP

![](img/thunderbolt-configuration-pgp-1.png#center)


4. Générer la clé

![](img/thunderbolt-configuration-pgp-2.png#center)

``` txt
Type de clé: RSA
Taille de la clé: plus fort possible (ici 4096)
```


![](img/thunderbolt-configuration-pgp-3.png#center)
![](img/thunderbolt-configuration-pgp-4.png#center)

5. Sauvegarder ses clés

Cliquer sur la clé nouvellement crée et sur *Plus* > *sauvegarder la clé secrete dans un fichier* afin de la sauvergarder dans un endroit sur. (Gestionnaire de password ?)

Ajouter un mot de passe lors de l'export de la clé.

![](img/thunderbolt-configuration-pgp-6.png#center)
![](img/thunderbolt-configuration-pgp-7.png#center)

Faire de même pour la clé publique (pas de mot de passe requis).

6. Les clés sont maintenant disponibles dans le dossier choisi précédement.

![](img/thunderbolt-configuration-pgp-8.png#center)

### Importer les clés publiques des correspondants avec qui on souhaite chiffré ses mails

Afin de pouvoir échangé de manière chiffrée, il est nécéssaire d'ajouter la clé publique de vos destinataires dans le gestionnaire de clé de thunderbird.


