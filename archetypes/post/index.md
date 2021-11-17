---
title: "{{ replace .Name "-" " " | title }}"
description: "<text>"
slug: "{{ replace .Name "-" "-" | title }}"
date: {{ .Date }}
author: "TooGz"
tags: ["tag1", "tag2"]
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