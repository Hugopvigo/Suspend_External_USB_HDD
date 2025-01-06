#!/bin/bash

# Ruta del archivo de log
LOG_FILE="/var/log/suspend_disks.log"

# Configura el tiempo de espera para suspensión (en minutos, traducido a hdparm -S)
SPINDOWN_TIME=240  # 20 minutos de inactividad

# Lista de discos a suspender
DISKS=("/dev/sda" "/dev/sdb" "/dev/sdc")

# Configurar el tiempo de espera para cada disco
for DISK in "${DISKS[@]}"; do
    if [ -b "$DISK" ]; then
        echo "Verificando configuración de tiempo de espera para $DISK..."
        hdparm -S $SPINDOWN_TIME $DISK 2>/dev/null || echo "No se pudo configurar el tiempo de espera para $DISK"
    else
        echo "Dispositivo $DISK no encontrado o no es un bloque válido."
    fi
done

# Verificar y suspender discos
for DISK in "${DISKS[@]}"; do
    if [ -b "$DISK" ]; then
        echo "Comprobando estado de $DISK..."
        STATUS=$(smartctl -n standby "$DISK" 2>/dev/null | grep -E "is in|ACTIVE" | awk '{print $NF}')

        if [ "$STATUS" == "STANDBY" ]; then
            echo "$DISK ya está en suspensión. No se realiza ninguna acción."
        elif [[ "$STATUS" == "IDLE_A" || "$STATUS" == "ACTIVE" || "$STATUS" == "IDLE" || "$STATUS" == "mode" ]]; then
            echo "$DISK está en estado $STATUS. Intentando suspender..."
            hdparm -y "$DISK" 2>/dev/null && echo "$DISK suspendido correctamente." || echo "No se pudo suspender $DISK"
        else
            echo "Estado de $DISK no identificado o no soportado. Estado reportado: $STATUS"
        fi
    else
        echo "Dispositivo $DISK no encontrado o no es un bloque válido."
    fi
done

echo "Proceso de suspensión completado."
