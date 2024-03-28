---
title: "Script Analyse Indicateurs MVNO"
description: "<text>"
slug: "2024-03-28-Test2"
date: 2024-03-28T09:59:59+01:00
author: "TooGz"
tags: ["Scripting", "bash"]
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
draft: false
---

# Analyse d'un Script Bash pour la Supervision Dynamique des Indicateurs en Erreur

Dans le monde de la technologie de l'information, il est crucial de disposer d'outils qui permettent de surveiller efficacement la performance et l'état des systèmes. Aujourd'hui, je vous présente un script Bash qui joue un rôle essentiel dans la supervision des indicateurs en erreur, un outil indispensable pour les administrateurs de systèmes et les développeurs.

## Introduction

Ce script Bash a été conçu pour analyser et superviser dynamiquement les indicateurs en état d'erreur. Grâce à une approche systématique, il vérifie les valeurs retournées par un service web et détermine si ces dernières dépassent les seuils prédéfinis. 

## Le Script en Détail

Le script se compose de plusieurs sections, chacune ayant un rôle spécifique dans le processus de supervision :

### Changelog

Le changelog documente l'évolution du script, incluant les auteurs, les versions, les dates, ainsi que les commentaires détaillant les modifications apportées au fil du temps. Cela permet de suivre facilement les améliorations et les optimisations réalisées.

### Description du Fonctionnement

Cette section décrit le but du script et explique comment il fonctionne. Le script parse les valeurs retournées par le service web `https://crm.v3.mvno.afone.priv/indicateur.php`, vérifiant si elles dépassent les seuils définis. Les données sont présentées dans un format spécifique, incluant l'ID de l'indicateur, sa valeur, le seuil et un code couleur.

### Variables de Configuration

Le script permet d'activer ou de désactiver le mode débogage via une variable `DEBUG_MODE`. Il définit également l'URL du service web à interroger et le chemin des fichiers utilisés pour le traitement des données.

### Fonctions

Plusieurs fonctions sont définies pour faciliter le traitement des données :

- `debug` : affiche les messages de débogage si le mode correspondant est activé.
- `round` : arrondit les nombres à virgule flottante.
- `replace_float_number_in_string` : remplace un nombre à virgule flottante par une variable dans une chaîne de caractères.
- Et d'autres fonctions pour le téléchargement, le nettoyage des données, et l'analyse des indicateurs.

### Flux Principal

Le script exécute un ensemble d'opérations, incluant le téléchargement des données depuis le CRM, le nettoyage des données, l'analyse des indicateurs en fonction des seuils définis, et finalement, la génération d'un rapport sur les indicateurs en état critique.

## Conclusion

Ce script Bash est un outil puissant pour la surveillance des indicateurs en erreur, offrant une approche dynamique et configurable pour les administrateurs et les développeurs. Grâce à sa documentation claire et à son code organisé, il est facilement adaptable et peut servir de base pour des besoins de surveillance spécifiques.


# Script

``` bash
#!/bin/bash

######################################################################################
#                                 -- Changelog --
######################################################################################
# Auteur  |  Ver  |   Date   |  DA / INC | Commentaires 
#---------|-------|----------|-----------|--------------------------------------------
#  GBO    |  1.0  | 20230420 | DA_17523  | Création du script initial pour le suivi et la
#         |       |          |           | supervision dynamique des indicateurs en erreur.
#  GBO    |  1.1  | 20240220 | DA_18524  | Optimisation du script pour améliorer la performance
#         |       |          |           | et supprimer les fichiers temporaires.
#         |       |          |           | Ajout de la fonction de debug et amélioration de la 
#         |       |          |           | gestion des erreurs.
#  GBO    |  1.2  | 20240305 | DA_17523  | Gestion des nombres a virgules flottantes
#---------|-------|----------|-----------|--------------------------------------------

######################################################################################
#                        -- Description du fonctionnement --
######################################################################################
# Ce script a pour but de retourner de manière dynamique en supervision les indicateurs
# qui sont en état d'erreur. Il parse les valeurs retournées par le 
# service web (https://crm.v3.mvno.afone.priv/indicateur.php) et vérifie si elles 
# dépassent les seuils définis. Les indicateurs sont présentés dans le format suivant :
#
#   [ID Indicateurs];[Valeur];[Seuil];[Code Couleur]
#       
# Exemple de données :
#       537;0;0<5;0
#       539;0;0<5;0
#       540;0;0<5;0
#       541;0;0<5;0
#
######################################################################################

# Varibles de configuration
DEBUG_MODE=0 # Activer (1) ou désactiver (0) le mode débogage
URL_CRM="http://recette.crm.mvno.afone.priv/indicateur.php"
FILE_DATA="./check_indicateurs_mvno_DATA"
FILE_DATA_CLEANED="./check_indicateurs_mvno_DATA_cleaned"

# FONCTIONS

# Afficher les messages de débogage si le mode débogage est activé.
# $1 : Le message de débogage à afficher.
debug() {
    [ "$DEBUG_MODE" -eq 1 ] && echo "[$(date '+%Y-%m-%d %H:%M:%S')] - Debug: $1"
}

# Arrondir vers le haut pour 0.5, et vers le bas pour tout le reste
# $1 : nombre a arrondir
#
# echo $(round 3.5)  # Output: 4
# echo $(round 3.2)  # Output: 3
# echo $(round 3.8)  # Output: 4
# echo $(round 4.0)  # Output: 4
# echo $(round 4.5)  # Output: 5
# echo $(round 4.7)  # Output: 5

round() {
  local num="$1"
  local int_part=$(echo "$num" | cut -d'.' -f1)
  local decimal_part=$(echo "$num" | cut -d'.' -f2)
  local rounded_decimal=$(echo "0.$decimal_part" | bc -l)
  local rounded_int=0
  
  if (( $(echo "$rounded_decimal >= 0.5" | bc -l) )); then
    rounded_int=$(echo "$int_part + 1" | bc)
  else
    rounded_int="$int_part"
  fi
  
  echo "$rounded_int"
}

# Fonction pour remplacer un nombre à virgule flottante par une variable dans une chaîne
# Arguments : $1 = chaîne de caractères, $2 = nom de la variable
replace_float_number_in_string() {
    # Utilise sed pour remplacer les nombres à virgule flottante par la variable
    modified_string=$(echo "$1" | sed -E "s/([0-9]+\.[0-9]+)/$2/g")
    echo "$modified_string"
}

# Télécharge les données depuis la CRM
debug "Début du téléchargement des données depuis la CRM."
if curl -s -k -m 5 $URL_CRM -o $FILE_DATA; then
    debug "Téléchargement réussi et données sauvegardées."
else
    echo "Erreur lors de la récupération des données."
    exit 1
fi

# Supprime tous les espaces du fichier de données pour nettoyer les entrées.
debug "Nettoyage des données."
sed 's/ //g' $FILE_DATA  > $FILE_DATA_CLEANED
debug "Nettoyage terminé."

# Lire le contenu du fichier nettoyé.
debug "Lecture des données."
data=$(cat $FILE_DATA_CLEANED)

# Initialiser une variable pour suivre le nombre de critiques.
critiques=0
output_centreon=""

# Expression régulière pour identifier le pattern global
regex="[0-9]+[[:space:]]*(<|<=|>|>=|==|!=)[[:space:]]*[0-9]+([[:space:]]*(&&|\|\|)[[:space:]]*[0-9]+[[:space:]]*(<|<=|>|>=|==|!=)[[:space:]]*[0-9]+)*"

debug "Début de l'analyse des indicateurs."
# Boucle pour traiter chaque ligne du fichier de données.
while IFS= read -r line; do
    # Extraction des différentes parties de chaque ligne de données.
    indicateur=$(echo "$line" | cut -d ';' -f1)
    sed 's/ //g' $indicateur  > $indicateur
    debug "Nettoyage terminé."
    debug "INDICATEUR: $indicateur"
    nom_indicateur=$(echo "$line" | cut -d ';' -f5)
    debug "NOM: $nom_indicateur"
    period=$(echo "$line" | cut -d ';' -f6)
    debug "PERIOD: $period"
    seuil_operateur=$(echo "$line" | cut -d ';' -f3)
    debug "SEUIL OPERATEUR: $seuil_operateur"
    valeur=$(echo "$line" | cut -d ';' -f2)
    debug "valeur: $valeur"
    debug "seuil_operateur: $seuil_operateur"
    
    echo "$nom_indicateur [IND $indicateur] $period"

    # Detection et traitement des nombres a virgules flottantes
    if [[ $valeur =~ ^-?[0-9]+\.[0-9]+$ ]]; then
        debug "$valeur est un nombre décimal"
        valeur_arrondi=$(round "$valeur")
        debug "valeur arrondi: $valeur_arrondi"
        seuil_operateur=$(replace_float_number_in_string "$seuil_operateur" "$valeur_arrondi")
        debug "seuil_operateur_arrondi: $seuil_operateur"
    fi
    
    if [[ $seuil_operateur =~ $regex ]]; then

        debug "L'expression correspond au pattern global."
        
        # Formate les expressions de comparaison pour faciliter leur évaluation :
        # 1. Encadre chaque comparaison numérique (ex. 3<5) avec des crochets pour la lisibilité.
        # 2. Ajoute des espaces autour des opérateurs logiques (&&, ||) et les place également entre crochets pour distinguer clairement les expressions logiques.
        comparaison=$(echo $seuil_operateur | sed -E 's/(-?[0-9]+[<>=!]{1,2}[0-9]+)/[ \1 ]/g;s/\|\|/ ] \|\| [ /g;s/&&/ ] \&\& [ /g')
        debug "comparaison apres formattage: $comparaison"
        # Nettoie les crochets superflus pour s'assurer que les expressions sont correctement formatées. Supprime les espaces redondants autour des crochets ouverts ou fermés.
        comparaison=$(echo $comparaison | sed -E 's/\[\s+\[/[/g; s/\]\s+\]/]/g')
        debug "comparaison apres le nettoyage des crochets en trop: $comparaison"
        # Transforme les opérateurs de comparaison en leur équivalent bash pour l'évaluation. Par exemple, '<=' devient '-le' pour être utilisé dans des expressions bash.
        comparaison_bash=$(echo "$comparaison" | sed -e 's/<=/ -le /g; s/</ -lt /g; s/>=/ -ge /g; s/>/ -gt /g; s/==/ -eq /g; s/!=/ -ne /g')
        debug "comparaison apres remplacement <>=!: $comparaison_bash"

    else
        echo "L'expression a comparé ne correspond pas au pattern attendu"
        exit 3
        debug "L'expression ne correspond pas au pattern attendu."
    fi



    if eval "$comparaison_bash"; then
        debug "Comparaison OK"
        output_centreon="OK: Tous les indicateurs sont dans les seuils."
    else
        debug "Comparaison échouée"
        resultat="CRITICAL"
        critiques=$((critiques+1))
        output_centreon="$output Indicateur $indicateur : $comparaison\n"
    fi


    # Affichage du résultat pour chaque indicateur.
    debug "Indicateur $indicateur : $comparaison RESULTAT: $resultat"
done <<< "$data"

debug "Analyse terminée. $critiques indicateur(s) critique(s) détecté(s)."

# Suppression des fichiers temporaires
debug "Suppression des fichiers temporaires."
#rm -f $FILE_DATA *
debug "Fichiers temporaires supprimés."

# Vérification du nombre de critiques et sortie du script avec le statut approprié.
if [[ $critiques -gt 0 ]]; then
    echo "CRITICAL: $critiques indicateur(s) critique(s). | $output_centreon"
    exit 2
else
    echo $output_centreon
    exit 0
fi
```

