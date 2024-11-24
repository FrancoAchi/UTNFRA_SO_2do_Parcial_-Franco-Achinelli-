#!/bin/bash

# Crear estructura de directorios
echo "Creando estructura de directorios..."
mkdir -p /tmp/2do_parcial/alumno
mkdir -p /tmp/2do_parcial/equipo

# Crear el archivo de template para datos_alumno.txt
echo "Creando template para datos_alumno.txt..."
cat > datos_alumno.j2 <<EOF
Nombre: {{ Franco }} Apellido: {{ Achinelli }}
Division: {{ C113 }}
EOF

# Crear el archivo de template para datos_equipo.txt
echo "Creando template para datos_equipo.txt..."
cat > datos_equipo.j2 <<EOF
IP: {{ 192.168.56.3 }}
Distribucion: {{ Ubuntu 22.04 }}
Cantidad de Cores: {{ }}
EOF

# Crear el playbook de Ansible
echo "Creando playbook de Ansible..."
cat > generate_files.yml <<EOF
- name: Generar archivos de datos
  hosts: localhost
  vars:
    # Variables para el archivo datos_alumno.txt
    nombre: "Franco"
    apellido: "Achinelli"
    division: "C113"

    # Variables para el archivo datos_equipo.txt
    ip: "192.168.1.33"
    distribucion: "Ubuntu 22.04"
    cores: 
  tasks:
    - name: Crear archivo de alumno
      template:
        src: datos_alumno.j2
        dest: /tmp/2do_parcial/alumno/datos_alumno.txt

    - name: Crear archivo de equipo
      template:
        src: datos_equipo.j2
        dest: /tmp/2do_parcial/equipo/datos_equipo.txt
EOF

# Ejecutar el playbook
echo "Ejecutando el playbook de Ansible..."
ansible-playbook generate_files.yml

# Configurar sudoers para el grupo "2PSupervisores"
echo "Configurando sudoers para el grupo 2PSupervisores..."
if ! grep -q "^%2PSupervisores" /etc/sudoers; then
	    echo "%2PSupervisores ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers > /dev/null
    echo "Configuración de sudoers actualizada."
else
	    echo "El grupo 2PSupervisores ya está configurado en sudoers."
fi

# Crear el grupo 2PSupervisores (si no existe)
echo "Creando el grupo 2PSupervisores (si no existe)..."
if ! grep -q "^2PSupervisores" /etc/group; then
	    sudo groupadd 2PSupervisores
	        echo "Grupo 2PSupervisores creado."
	else
		    echo "El grupo 2PSupervisores ya existe."
fi

# Finalización
echo "¡Script completado exitosamente!"
