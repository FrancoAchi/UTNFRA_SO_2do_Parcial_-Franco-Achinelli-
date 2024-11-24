#!/bin/bash

#discos
DISCO2="/dev/sdd"
DISCO1="/dev/sdc"

#particion del disco 1 (2GB)
{
	echo n
	echo p
	echo 
	echo
	echo +1.5G
	#Cambiar de tipo
	echo t
	echo 8E
	#guardar
	echo w
} | sudo fdisk "${DISCO1}"

#particion del disco 2 (1GB)
{
	echo n
	echo p
	echo
	echo
	echo +512M

	echo t
	echo 82

	echo w
} | sudo fdisk "${DISCO2}"

#limpiamos
sudo wipefs -a /dev/${DISCO2}1
sudo wipefs -a /dev/${DISCO1}1

#creamos volumenes fisicos
sudo pv create /dev/${DISCO1}1 /dev/${DISCO2}1

#creamos grupos
sudo vgcrate vg_datos /dev/${DISCO2}1
sudo vgcrate vg_temp /dev/${DISCO2}1

#creamos voluemenes logicos
sudo lvcreate -L 5M -n lv_docker vg_datos
sudo lvcreate -L 1.5G -n lv_workareas vg_datos
sudo lvcreate -L 512M -n lv_swap vg_temp

#LVM
sudo mkdir work
sudo mount /dev/mapper/vg_datos-lv_workareas /work/
sudo mount /dev/mapper/vg_datos-lv_docker /var/lib/docker

#Reiniciar servicio docker
sudo systemct1 restart docker

#Verificar el estado del servicio
sudo systemct1 status docker

lsblk

