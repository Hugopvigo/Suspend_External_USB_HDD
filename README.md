<div align="center">

# 💾 Suspend External USB HDD

### *Script para suspender discos duros USB Western Digital en Linux*

![Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-000?style=for-the-badge&logo=linux&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

---

*Algunos discos duros externos de Western Digital no entran*
*en suspensión automáticamente en Linux. Este script lo soluciona.*

</div>

---

## ✨ Características

| | |
|---|---|
| 💤 | **Suspensión automática** — detecta y suspende discos WD |
| 🔍 | **Detección inteligente** — usa `smartctl` para verificar estado |
| 🛡️ | **Modo seguro** — solo suspende cuando es necesario |
| 📋 | **Logging** — muestra el estado de cada disco |

---

## 🚀 Instalación

```bash
# 1. Clonar
git clone https://github.com/Hugopvigo/Suspend_External_USB_HDD.git
cd Suspend_External_USB_HDD

# 2. Dar permisos
chmod +x suspend_disks.sh

# 3. Ejecutar
sudo ./suspend_disks.sh
```

### Modo verbose

```bash
sudo bash -x suspend_disks.sh
```

---

## 🔧 Cómo funciona

1. **Detecta** discos USB conectados con `smartctl`
2. **Verifica** el estado actual (IDLE, ACTIVE, STANDBY)
3. **Suspende** solo si el disco no está ya en standby
4. Usa `hdparm -y` para forzar la suspensión cuando es necesario

### Estados detectados

| Estado | Acción |
|--------|--------|
| `IDLE_A` | Intenta suspender |
| `ACTIVE` | Intenta suspender |
| `IDLE` | Intenta suspender |
| `STANDBY` | Ya suspendido, no hace nada |

---

## 📋 Requisitos

- Linux (Ubuntu 20.04+ recomendado)
- `smartctl` (parte de `smartmontools`)
- `hdparm`
- Permisos root

```bash
# Instalar dependencias
sudo apt install smartmontools hdparm
```

---

## 📁 Estructura

```
Suspend_External_USB_HDD/
├── suspend_disks.sh    ← Script principal
└── README.md
```

---

## 📝 License

MIT — ver [LICENSE](LICENSE)
