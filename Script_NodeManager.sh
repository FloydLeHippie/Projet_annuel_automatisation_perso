#!/bin/bash

#Commenter la source cdrom
sudo sed -e '/cdrom/s/^/#/g' -i /etc/apt/sources.list

#Rajouter la source bullseye-back-ports
echo "deb http://deb.debian.org/debian/ bullseye-backports main contrib" | sudo tee -a /etc/apt/sources.list

#Mise à jours de la liste des paquets
sudo apt update

#Installation d'ansible
sudo apt install ansible -y

#Génération d'une clé SSH
sudo ssh-keygen

#Copie de la clé publique ssh sur les hôtes ansible
read -e -p "Entrez l'adresse ip du node 1 :" IP1
sudo ssh-copy-id ansible@$IP1

#Créeation du fichier hosts
sudo echo "[Node1]
$IP1
">> /home/Projet_Ansible/host.txt

sudo ansible-playbook -i host.txt -u ansible /home/Projet_Ansible/Playbook_Install_Docker.yml
