# Suspend_External_USB_HDD #
Script that suspends USB HDD WesternDigital in Linux

Algunos discos duros externos de WesternDigital no entran en suspensión automáticamente, cuando están conectados por USB a una máquina con Linux.

## Instalación ##
Para resolver este problema y que no estén activos de forma permanente descarga el script en el directorio que desees y dale permisos de ejecución

Guarda este script actualizado como suspend_disks.sh.
`chmod +x suspend_disks.sh`

## Ejecución ##

`sudo ./suspend_disks.sh`

O si quieres ver paso por paso como se ejecuta:
`bash -x suspend_disks.sh`


### Cambios realizados ###
Detección de estados "IDLE_A" y "ACTIVE":

Si el disco está en IDLE_A, ACTIVE, o IDLE, intentará suspenderlo con hdparm -y.
Forzar suspensión solo cuando sea necesario:

Si el estado es ambiguo pero no STANDBY, el script fuerza la suspensión.

El método más confiable para detectar y gestionar discos en tu caso parece ser **smartctl** en combinación con **hdparm -y**

`sudo hdparm -y /dev/sdb`

`sudo smartctl -n standby /dev/sdb`

En mi caso, smartctl suspende bien los discos, pero no detecta bien el estado en el que se encuentran:

`/dev/sda:
 setting standby to 240 (20 minutes)
SG_IO: bad/missing sense data, sb[]:  f0 00 01 00 50 00 00 0a 00 00 00 00 00 1d 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00`

Si el disco está en suspensión, debería devolver algo como:
`Device is in STANDBY mode`

Si está activo:
`Device is in ACTIVE or IDLE mode`

### Revisa el estado de los discos: ###

`sudo smartctl -n standby /dev/sda`
`sudo smartctl -n standby /dev/sdb`
`sudo smartctl -n standby /dev/sdc`

Si los discos todavía no entran en STANDBY, verifica manualmente si hdparm -y funciona:

`sudo hdparm -y /dev/sda`
`sudo hdparm -y /dev/sdb`
`sudo hdparm -y /dev/sdc`
