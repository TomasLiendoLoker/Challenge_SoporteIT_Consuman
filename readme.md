# ✨ Prueba Técnica - Junior en Soporte IT - CONSUMAN 

## **Autor**
Tomás Liendo Loker

## **Introducción**
Este repositorio contiene la resolución de una prueba técnica para la posición de Junior en Soporte IT. El trabajo está dividido en tres desafíos principales, documentados y organizados en carpetas separadas.

---

## 🚀 Tarea 1: **Configuración Inicial de una Infraestructura Básica**

En este primer punto, nos enfocamos en la creación y configuración de una infraestructura básica utilizando **Windows Server 2019**. Los pasos incluyen la instalación de una máquina virtual (VM), la configuración de un **Active Directory (AD)**, y la creación de **usuarios con diferentes roles** dentro del dominio. Además, se llevará a cabo la configuración de una estación de trabajo unida al dominio y se establecerá un **sitio web estático** accesible desde la LAN. A continuación, se detallan los pasos principales:

- **Instalación de una máquina virtual** con Windows Server 2019.
- **Configuración del Active Directory (AD)**, incluyendo la creación de un dominio y la promoción del servidor a controlador de dominio.
- **Gestión de usuarios en el AD**: Creación de tres tipos de usuarios con diferentes roles y permisos: Administrador, Técnico y Estándar.
- **Creación de una estación de trabajo** (Windows 10/11) y unión al dominio.
- **Configuración de un sitio web estático** utilizando IIS para mostrar una página "Hola Mundo".

> [Ver detalles completos aquí](./Tarea_1/Tarea_1_Configuración_Inicial.md)

---

##  🚀 Tarea 2: **Configuración de SQL Server y Base de Datos**

En este segundo punto, nos enfocamos en la configuración de SQL Server en un entorno controlado, así como en la creación y diseño de una base de datos para un pequeño videojuego de rol (RPG). Los objetivos principales fueron:

- **Instalación y configuración de SQL Server** en una máquina virtual con **Windows Server 2019**, habilitando el inicio de sesión con el usuario `sa`.
- **Creación de la base de datos** para representar la lógica del juego, con las siguientes tablas:
  1. **Jugadores**
  2. **Personajes**
  3. **Habilidades**
  4. **Equipamientos**
  5. **Personajes_Habilidades** (tabla intermedia)
  6. **Personajes_Equipamientos** (tabla intermedia)
- **Desarrollo de procedimientos almacenados** para gestionar niveles de personajes y sus relaciones con habilidades y equipamientos.

### Procedimientos Almacenados Principales

1. **SubirNivelPersonaje_habilidad**: Incrementa el nivel de un personaje y actualiza las habilidades asociadas si el nuevo nivel cumple con los requisitos.
2. **SubirNivelPersonaje_equipamiento**: Incrementa el nivel de un personaje y actualiza los equipamientos asociados si el nuevo nivel cumple con los requisitos.

> [Ver detalles completos aquí](./Tarea_2/Tarea_2_%20Configuración%20de%20SQL%20Server%20y%20Base%20de%20Datos.md)
---

## 🚀 Tarea 3: **Interconexión y Gestión Avanzada**

En este tercer punto, se profundiza en la interconexión y administración de recursos entre dos servidores configurados en la misma red. El objetivo principal es realizar las siguientes actividades:

- **Creación de una nueva máquina virtual** con Windows Server 2022.
- **Unión al dominio existente** y configuración en el mismo segmento de red que la primera VM.
- **Acceso al sitio web** estático "Hola Mundo" desde la nueva VM.
- **Gestión de permisos sobre una carpeta compartida**, diferenciando los accesos según los roles creados en el AD (Administrador, Técnico y Estándar).
- **Prueba de permisos** mediante la simulación de acciones con los tres roles desde otra VM.

> [Ver detalles completos aquí](./Tarea_3/Tarea_3_%20Interconexión%20y%20Gestión%20Avanzada.md)

