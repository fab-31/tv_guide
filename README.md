# tv_guide
Ces scripts permettent de télécharger automatiquement une playlist iptv.

## Installation
Sous Kodi, dans le dossier de votre choix
 ` git clone git@github.com:fab-31/tv_guide.git `
  
Créer un fichier secret.env comme il suit
```bash
 #Full URL to your tvguide.xml
 URL_RAW_PLAYLIST_TV="<votre url vers votre IPTV>"

 #Destination folder to tvguide.xml
 TARGET="Le chemin d'accés complet vers le m3u utilisé par KODI : TV.m3u"

 #Destination folder with filename to the tv guide file
 TVGUIDE="Le chemin d'accés complet vers le guide tv utilisé par KODI : tvguide.xml"    
```

## Lancement
```bash
 sh get-and-process-TV-playlist.sh
 sh get-tvguide.sh
```

## Todolist
- [ ] Finir l'intégration des logos
- [ ] Concaténer des deux scripts bash
- [ ] guide tv des chaines manquantes
- [ ] ajouter des options de lancement pour gérer les filtres des chaines
- [ ] faire une fonction pour déplacer les chaines


