# Système de gestion de fichier

## Partie I

### Structure de l'arbre

>[ / | parent {null}| child{usr} | next{null}]
>[usr | parent{/} | child{type.txt} | next{bin}] [bin | parent{/} | child{...} | next{etc}]
>[type.txt | parent{usr} | child{null} | next{type.dll}] [type.dll | parent{usr} | child{null} | next{null}]

### Type

#### Record : node

- name : String
- rights : String
- size : Integer
- parentFolder : Access of record **node**
- child : Access of record **node**
- next : Access of record **node**
- **#**author : String
- **#**modifDate : date (record)
- **#**createDate : date (record)![1578324087507](/home/n7student/.config/Typora/typora-user-images/1578324087507.png)

#### Record : date

- minute : Integer
- hour : Integer
- day : Integer
- month : Integer
- year : Integer

### Fonction et procédure

#### pathToNode(path : IN String) return Node

Permet de passer du chemin renseigner à un noeud.

#### init(root : IN OUT Node)

Initiliase un arbre afin de pouvoir exécuter des commandes dessus plutôt que de créer à chaque fois un arbre.

#### createDMS() return Node

Créé un SGF ne contenant que le dossier racine.

#### pwd()

Obtention du répertoire de travail ou répertoire courant.

#### touch(path : IN String)

Création d'un fichier.

#### vim(file : IN OUT node)

Modifie la taille d'un fichier.

#### mkdir(path : IN String)

Création d'un répertoire.

#### cd()

Changement du répertoire courant en précisant le chemin du nouveau répertoire.

#### ls(folder : IN OUT node)

Affichage du contenu d'un répertoire désigné.