---
title: "Optimisation Html5 Boilerplate"
description: "Optimiser pour mon usage le template HTML5 Boilerplate"
slug: "2024-03-26-Optimisation-Html5-Boilerplate"
date: 2024-03-26T11:52:39+01:00
author: "TooGz"
tags: ["html5", "template"]
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

ShowToc: true
---

# HTML
---
[lien docs](https://github.com/h5bp/html5-boilerplate/tree/main/docs)

Par défaut, HTML5 Boilerplate est livré avec 2 pages `html`.
 
 - `index.html` - Une brique HTML qui sera utilisée comme base pour toutes les pages du projet.
 - `404.html`

## index.html
---

### Language Attribute

``` html
<html class="no-js" lang="fr">
```

### Open Graph Metadata

[OPENGRAPH](https://ogp.me/)

``` html
<meta property="og:site_name" content="{{ nom du site }}">
<meta property="og:title" content="{{ titre de la page }}">
<meta property="og:type" content="website"><!-- https://ogp.me/#types -->
<meta property="og:image" content="{{ url/de/l/image/a/la/une/de/la/page.jpg }}">
<meta property="og:url" content="{{ url/de/la/page.html }}">
<meta property="og:description" content="{{ description de la page }}">
<meta property="og:local" content="fr_FR">
<meta property="og:author" content="{{ nom de l'auteur de la page}}">
```
