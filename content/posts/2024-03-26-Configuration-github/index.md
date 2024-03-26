---
title: "Configuration Github"
description: "Configuration et utilisation de Github pour du developpement WEB"
slug: "configuration-github"
date: 2024-03-26T11:18:52+01:00
author: "TooGz"
tags: ["github", "token"]
cover:
    image: img/cover.webp
    alt: "<text>"
    caption: "<text>"
    relative: false # To use relative path for cover image, used in hugo Page-bundles
params:
    cover:
        linkFullImages: true
    ShowReadingTime: true
    ShowPostNavLinks: true

ShowToc: false
---


Afin de pouvoir se connecter a son github distant, il faut configurer un **Personal Token** sur son espace Github

# Comment créer un token d'accès personnel sur GitHub ?

La création d'un PAT sur GitHub est un processus simple et direct. Voici les étapes à suivre :

1. **Accédez à votre compte GitHub** et cliquez sur votre photo de profil en haut à droite, puis sélectionnez **Settings**.

2. Dans le menu latéral, sélectionnez **Developer settings**.

3. Sous **Developer settings**, cliquez sur **Personal access tokens** puis sur **Generate new token**.

4. **Donnez un nom à votre token**. Choisissez un nom descriptif pour vous rappeler de l'usage prévu de ce token.

5. **Sélectionnez les scopes ou permissions**. Les scopes déterminent quelles actions vous pouvez effectuer avec ce token. Pour la plupart des opérations Git, le scope `repo` est suffisant.

6. **Configurez la durée de validité** du token selon vos besoins.

7. Cliquez sur **Generate token**. Copiez votre nouveau token et gardez-le dans un endroit sûr ; GitHub ne le montrera plus après que vous quittiez la page.

# Bonnes pratiques de gestion des PATs

- **Ne partagez jamais vos tokens** : Traitez-les comme des mots de passe et ne les exposez dans aucun fichier de configuration public.
- **Utilisez des tokens avec le minimum de permissions nécessaires** pour l'opération prévue.
- **Revoquez les tokens non utilisés** ou ceux dont vous n'avez plus besoin depuis les settings de votre compte GitHub.

Les tokens d'accès personnel représentent une méthode d'authentification moderne et sécurisée pour les opérations Git et API sur GitHub. Leur création et gestion prudente permettent de sécuriser l'accès à vos projets tout en facilitant l'intégration avec d'autres outils et services.

