USER_REF=$1

LISTA=/home/vagrant/UTN-FRA_SO_Examenes/202406/bash_script/Lista_Usuarios.txt

LISTA_USUARIOS=$2

PASS_USUARIOS=$(sudo cat /etc/shadow | grep "$1" | awk -F ':' '{print $2}')

USUARIO_1=$(grep Prog1 $LISTA | awk -F ',' '{print $1}')
USUARIO_2=$(grep Prog2 $LISTA | awk -F ',' '{print $1}')
USUARIO_3=$(grep Test1 $LISTA | awk -F ',' '{print $1}')
USUARIO_4=$(grep Supervisor $LISTA | awk -F ',' '{print $1}')

GRUPO_PROG=$(grep Prog1 $LISTA | awk -F ',' '{print $2}')
GRUPO_TESTERS=$(grep Test1 $LISTA | awk -F ',' '{print $2}')
GRUPO_SUPERVISORES=$(grep Supervisor $LISTA | awk -F ',' '{print $2}')

RUTA_USER1=$(grep Prog1 $LISTA | awk -F ',' '{print $3}')
RUTA_USER2=$(grep Prog2 $LISTA | awk -F ',' '{print $3}')
RUTA_USER3=$(grep Test1 $LISTA | awk -F ',' '{print $3}')
RUTA_USER4=$(grep Supervisor $LISTA | awk -F ',' '{print $3}')

sudo groupadd $GRUPO_PROG
sudo groupadd $GRUPO_TESTERS
sudo groupadd $GRUPO_SUPERVISORES

sudo useradd -m -s /bin/bash -c "User Prog1" -g $GRUPO_PROG -p $PASS_USUARIOS -d $RUTA_USER1 $USUARIO_1
sudo useradd -m -s /bin/bash -c "User Prog2" -g $GRUPO_PROG -p $PASS_USUARIOS -d $RUTA_USER2 $USUARIO_2
sudo useradd -m -s /bin/bash -c "User Test1" -g $GRUPO_TESTERS -p $PASS_USUARIOS -d $RUTA_USER3 $USUARIO_3
sudo useradd -m -s /bin/bash -c "User Supervisor" -g $GRUPO_SUPERVISORES -p $PASS_USUARIOS -d $RUTA_USER4 $USUARIO_4

echo "Probando script"

ls -l /work/

ls -l /usr/local/bin/
