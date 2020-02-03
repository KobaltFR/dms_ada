# Manuel de l'utilisateur - Système de gestion de fichiers

<div align="justify">

## <b>Introduction</b>

Afin d'utiliser mon système de gestion de fichier, je vous invite à récupérer les fichiers présents dans le dossier "src" de l'archive, puis à les compiler. Ensuite, afin de lancer le programme principal je vous invite à lancer le fichier "main_dms" à l'aide de la commande suivante :
<pre>
./main_dms
</pre>
Une fois lancé, le programme vous invite à choisir entre l'invite de commandes (Prompt command) ou le menu de commandes (Menu), à l'heure actuelle, le menu de commande n'est pas disponible et vous serez redirigé vers l'invite de commandes si vous le choisissez.
<pre>
What do you want to do ? (Enter 'exit' to stop)
(P)rompt command
(M)enu
</pre>
Je vous invite donc à entrer le caractère 'M' ou 'P' au clavier, puis à appuyer sur la touche entrer.
Une fois cela fait, vous êtes donc dans l'invite de commande et pouvez entrer les différentes commandes.

## <b> Les commandes </b>

L'invite de commande se présente sous cette forme :
<pre>
[/] > 
</pre>
Vous trouverez entre les crochets le nom du dossier courant. Les commandes tappées au clavier apparaitront après le '>'. Vous pouvez entrer des commandes ou bien "exit" afin de quitter le programme.

### <u>1. cd</u>
#### Description
La commande cd vous permet de vous déplacer d'un dossier vers un autre.
#### Synopsis
<pre>
cd [chemin d'accès]
</pre>
#### Exemple
Vous vous trouvez dans le dossier racine '/', un des enfants du dossier racine est le dossier 'bin' : 
<pre>
[/] > 
[/] > cd bin
[bin] > 
</pre>
Vous pouvez utiliser des chemins relatifs contenant '..' et '.' mais aussi des chemins d'accès absolus : 

<pre>
[/] > 
[/] > cd bin
[bin] > cd .
[bin] > 
[bin] > cd ..
[/] > 
</pre>

(Dans l'exemple suivant, le dossier 'bin' contient un dossier 'folder')
<pre>
[/] > 
[/] > cd /bin/folder
[folder] > 
[folder] > cd /
[/] >
</pre>

### <u>2. pwd</u>
#### Description
La commande pwd vous permet d'afficher le chemin absolu du dossier courant.
#### Synopsis
<pre>
pwd
</pre>
#### Exemple
Vous vous trouvez dans le dossier 'share' qui est un enfant du dossier 'usr', lui même enfant du dossier racine '/' : 
<pre>
[share] > 
[share] > pwd
/usr/share
[share] > 
</pre>

### <u>3. ls</u>
#### Description
La commande ls vous permet d'afficher les enfants du dossier courant. Vous pouvez le faire de façon récursive avec l'option '-r' ou de manière détaillée avec l'option '-l'
#### Synopsis
<pre>
ls [-r/-l] [chemin d'accès]
</pre>
#### Exemple
Vous vous trouvez dans le dossier racine '/', qui contient les dossiers 'bin' et 'usr' ainsi que le fichier 'tree.adb'. Le dossier 'usr' contient lui même le dossier 'share' et le fichier 'dms.sh'.
<pre>
[/] > 
[/] > ls
/ 
    bin/
    tree.adb 
    usr/
[/] > 
</pre>

<pre>
[/] > 
[/] > ls -l
/ 
    drwx 1 ''  bin/
    -rwx 1 'adb'  tree.adb 
    drwx 1 ''  usr/
[/] > 
</pre>

<pre>
[/] > 
[/] > ls -r
/ 
    bin/
    tree.adb 
    usr/
        dms.sh 
        share/
[/] > 
</pre>

<pre>
[/] > 
[/] > ls usr
usr/
    dms.sh 
    share/
[/] > 
</pre>

<pre>
[/] > 
[/] > ls -l /usr
usr/
    -rwx 1 'sh'  dms.sh 
    drwx 1 ''  share/
[/] > 
</pre>

### <u>4. mkdir</u>
#### Description
La commande mkdir vous permet de créer un dossier. Attention le chemin d'accès est obligatoire ! (mais il peut être relatif ou absolu)
#### Synopsis
<pre>
mkdir [chemin d'accès]
</pre>
#### Exemple
Vous vous trouvez dans le dossier racine '/' :
<pre>
[/] > 
[/] > mkdir bin
[/] > ls
/ 
    bin/
[/] > mkdir /bin/folder
[/] > ls -r
/ 
    bin/
        folder/
[/] > 
</pre>

### <u>5. touch</u>
#### Description
La commande touch vous permet de créer un fichier. Attention le chemin d'accès est obligatoire !(mais il peut être relatif ou absolu)
#### Synopsis
<pre>
touch [chemin d'accès]
</pre>
#### Exemple
Vous vous trouvez dans le dossier racine '/' :
<pre>
[/] > 
[/] > touch shell.sh
[/] > ls -l
/ 
    -rwx 1 'sh'  shell.sh 
[/] > mkdir bin
[/] > touch /bin/fichier
[/] > ls -r
/ 
    bin/
        fichier 
    shell.sh 
[/] > 
</pre>

### <u>6. vim</u>
#### Description
La commande vim vous permet de modifier la taille d'un fichier. Attention la taille et le chemin d'accès sont obligatoires ! (Le chemin d'accès peut être relatif ou absolu)
#### Synopsis
<pre>
vim [taille] [chemin d'accès]
</pre>
#### Exemple
Vous vous trouvez dans le dossier racine '/', qui contient un fichier enfant "test.txt" :
<pre>
[/] > 
[/] > ls -l
/ 
    -rwx 1 'txt'  test.txt
[/] > vim 25 test.txt
[/] > ls -l
/ 
    -rwx 25 'txt'  test.txt 
[/] > 
</pre>
<pre>
[/] > 
[/] > mkdir bin
[/] > cd bin
[bin] > touch fichier.file
[bin] > cd /
[/] > vim 50 /bin/fichier.file
[/] > cd bin
[bin] > ls -l
bin/
    -rwx 50 'file'  fichier.file
[bin] > 
</pre>

</div>