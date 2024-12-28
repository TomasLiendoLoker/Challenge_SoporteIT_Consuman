# Tarea 1: Configuración Inicial de una Infraestructura Básica

## Enunciado 1:

**Crear una máquina virtual (VM): Utilizando el virtualizador de tu preferencia (VirtualBox, VMware, Hyper-V, etc.), instala Windows Server 2019.**

## Procedimiento 1:

### Creación de la Máquina Virtual en Hyper-V

Se crea la siguiente máquina virtual empleando el virtualizador **Hyper-V** obteniendo como resumen los siguientes aspectos:

![Máquina Virtual](../media/417767e3973af7a0d1002e37da3ff87f.png)

---

### Requisitos del Sistema

Para los requisitos de la **memoria RAM**, **almacenamiento**, etc., me basé en las especificaciones publicadas en la página de Microsoft:

![Requisitos de Microsoft](../media/83910e2070ca38cf0c37f4b7ba51b2a3.png)
![Especificaciones adicionales](../media/6bcb7046ec941b794be7624ea721ad6d.png)

---

### Configuración de Red

La configuración del **adaptador de red** se encuentra en **LAN (Red privada)**, como se puede observar en la siguiente imagen:

![Configuración de Red](../media/d963efcfacb17c517276f0dde503b1b8.png)

---

### Elección de la Experiencia de Escritorio

Se elige la **experiencia de escritorio** para una mayor facilidad:

![Experiencia de escritorio](../media/d711a1ba010b05e24569bfbb1e6a302c.png)

---

### Creación de Servidor

Como creamos un **servidor desde 0**, elegimos la siguiente opción:

![Opciones de creación](../media/c59e9e56e2589d6cdac443e845cdba26.png)

---

### Almacenamiento Designado

El almacenamiento designado es el siguiente:

![Almacenamiento](../media/ff60a8119fada465fc5e4e3a3156acd7.png)

---

### Credenciales

Teniendo en cuenta las siguientes credenciales:

- **Usuario**: administrador
- **Contraseña**: Tomy@dev10

![Credenciales](../media/fcc68b404962bd6eee2f765cfd2ff01d.png)

---




## Enunciado 2:

**Configurar un Active Directory (AD):**

- **Promocionar el servidor a controlador de dominio.**
- **Crear un dominio, por ejemplo: empresa.local.**

## Procedimiento 2: Promoción del Servidor a Controlador de Dominio

### Pasos Previos para Promocionar el Servidor a Controlador de Dominio

#### 1. Configuración de Dirección IP Estática

Se configura una **dirección IP estática** para el servidor con el objetivo de que la misma no cambie de forma dinámica como estaba por defecto. Se configura como **servidor DNS** al mismo servidor, por lo que usamos la dirección IP previamente configurada: `192.168.0.2`.

![Configuración IP Estática](../media/52483e61b1072b0e9d4993e06590c284.png)

![Configuración DNS](../media/96a0e4a86d7fb13cbb0cfaff39da3716.png)

![Configuración Final](../media/bb5292ceb37e71b25af73f478ab6cbfd.png)

---

#### 2. Instalación del Active Directory

Posteriormente, se procede a realizar la instalación del **Active Directory (AD)**:

![Instalación AD](../media/572f0cf826da6016b6b0945e50a2d2e5.png)

![Instalación en Proceso](../media/2c12e157c6dd3f3869f5c08bada4b661.png)

---

#### 3. Selección de Características

En la ventana de **"Características"**, dejamos las opciones seleccionadas por defecto (Paso 4) y confirmamos la instalación (Paso 5). Luego llegamos al último paso (Paso 6), en la pestaña de **"Resultados"**, que veremos a continuación:

![Resultados de Instalación](../media/e02dc7d93450b770d16ffe86a0528b15.png)

![Confirmación de Resultados](../media/cc52a6f39702656ba4673312d67f0962.png)

---

#### 4. Promoción del Servidor a Controlador de Dominio

Ahora, vamos a promover el servidor a **Controlador de Dominio** donde ingresamos el **nombre de dominio raíz**:

![Promoción a Controlador de Dominio](../media/36534145116be91bfe0eb9cdae4ff034.png)

**Credenciales:**
- **Usuario**: administrador
- **Contraseña**: Tomy@dev10

---

#### 5. Advertencia por Falta de Servidor DNS

Todavía no se cuenta con un servidor **DNS** instalado (para la resolución de nombres de dominios a direcciones IP), pero se instalará más adelante. Por esta razón, nos aparece la siguiente advertencia:

![Advertencia de DNS](../media/6746f898f5945e541cef26913f31b4ce.png)

![Advertencia Continuación](../media/72497ad5b15fa385365d2e34aba84bc6.png)

![Advertencia de Finalización](../media/8226ea5e1b0e0ce15c95fba5ef4fdc8b.png)

---

#### 6. Instalación del AD y DNS

Finalmente, podemos observar que se ha instalado el **Active Directory (AD)** y **DNS** con sus consolas correspondientes, ya que estos van de la mano:

![Instalación Finalizada](../media/a52f0e125004f3de9e51eb0b7f5426ce.png)

![Consola AD y DNS](../media/f45b16ad688a8beb672cda3cf3abd22d.png)

---



## Enunciado 3:

**Gestión de usuarios en el AD:**

- **Usuario Administrador:** Permisos de administración total sobre el dominio.
- **Usuario Técnico:** Permisos limitados para gestionar recursos específicos (como crear grupos o modificar usuarios).
- **Usuario Estándar:** Permisos básicos de uso (inicio de sesión y acceso limitado).

## Procedimiento 3:

Primero creamos unidades organizativas con el objetivo de mantener una estructura más clara (usuarios organizados y categorizados) y permitir una mejor administración de políticas y permisos de subconjunto de usuarios.

![Imagen1](../media/e9f10c9cd85b9f5d538f2dfe4c9e6a17.png)

Se crean las UO correspondientes, siguiendo la siguiente estructura:

- **EmpresaDev.local**
  - **Usuarios**
    - **Administradores**
    - **Técnicos**
    - **Estándar**

![Imagen2](../media/81c81398add01ea61abcd6e10b4801c3.png)

A continuación se crearon grupos de seguridad previamente creando Unidades Organizativas (UO), respetando la siguiente estructura actualizada:

- **EmpresaDev.local**
  - **Usuarios**
    - **Administradores**
    - **Técnicos**
    - **Estándar**
  - **Grupos**
  - **Grupos de Seguridad**
  - **Grupos de Distribución**

Se procede a crear los grupos correspondientes de seguridad:

![Imagen3](../media/87a9d0f47fc56bbd011c150b2bc6cb8c.png)

Se elige el ámbito global ya que necesitamos gestionar recursos y usuarios dentro del mismo dominio. Donde los miembros tienen que ser del mismo dominio del cual se crea el grupo y los permisos del grupo pueden asignarse a recursos en cualquier dominio del bosque.

Además, son más eficientes en entornos con un solo dominio como se está planteando en dicho desafío.

![Imagen4](../media/58bbbd853c7227903765413ae4e483bd.png)

En base a la lógica anterior, se crean los demás grupos de seguridad, obteniendo como resultado los 3 grupos de seguridad:

![Imagen5](../media/b23f8ec1c20a44dd828d31459360d766.png)

Ahora a continuación se crearán los usuarios en sus respectivas OU y asignando a cada uno al grupo de seguridad correspondiente.

![Imagen6](../media/0327603dd9e87c242f2647c14bbd5d7b.png)

Creación de usuario administrador

Para el caso de la Unidad Organizativa “Usuarios” y luego la Subunidad Organizativa “Administradores” se crea el siguiente usuario administrador:

**Usuario:** admin1  
**Contraseña:** Firefox@15

![Imagen7](../media/c874c30be6e8e17b1a278a83ad45438b.png)

Con la opción marcada, el usuario administrador cuando intente loguearse por primera vez deberá escoger una contraseña en base a los requerimientos de seguridad definidos. De esta manera, la contraseña con la cual creamos a dicho usuario (la default) ya no tendrá vigencia y la que funcionará es la configurada por el propio administrador.

![Imagen8](../media/5269d5259e38704575931a0779d11397.png)

Resumen final:

![Imagen9](../media/a6c8056efee078035dadc3c4a789cf8c.png)

![Imagen10](../media/aa0fceda63334488aa27b18d849c6d15.png)

Con la misma lógica explicada anteriormente se crean el usuario técnico 1 (Juan Liendo) y el usuario estándar 1 (Arturo Liendo).

**Usuario:** tecnico1  
**Contraseña:** Firefox@16  

**Usuario:** estandar1  
**Contraseña:** Firefox@17  

![Imagen11](../media/8da866531a24c608a24381b7cd440843.png)

![Imagen12](../media/23f48e79450bcce02f3170f51342c7fc.png)

A continuación se procede a realizar la asignación de permisos a los grupos creados previamente y luego agregar a los usuarios al grupo correspondiente.

Asignación de permisos al usuario administrador

Para el caso del usuario administrador creado “admin1”, lo que se va a hacer es que el grupo “Administrador_Global” sea miembro de otro grupo: **“Administradores”**, por lo que va a heredar sus privilegios. Es decir, los administradores tendrán acceso completo y sin restricciones al equipo o dominio.

![Imagen13](../media/8ee2f3092ee6cb3711970f9f218e60fd.png)

Basándonos en los siguientes pasos:

![Imagen14](../media/87b93788a0811956abe5bcf3d72f06c5.png)

Encontramos dicho grupo al cual queremos formar parte con el grupo de “Administrador_Global”.

![Imagen15](../media/69adaca34c63751b885a268bcb2a14f3.png)

Por lo tanto, concluimos aplicando y aceptamos los cambios realizados para dicho grupo:

![Imagen16](../media/56c4be1c504aa21edaf562533eaf6b99.png)

Chequeado nuevamente en dicho grupo “Administrador_Global” y seleccionando propiedades, se verifica lo anterior:

![Imagen17](../media/80bc5b483bd43cb15daf9223dd31ed16.png)

Sumar al usuario admin1

Ahora se va a sumar al usuario admin1, es decir, Tomás Liendo, como miembro del grupo “Administrador Global”.

![Imagen18](../media/aec6907d53847c5cfa8ce758e605d992.png)

Chequeado nuevamente en dicho grupo “Administrador_Global” y seleccionando propiedades, se verifica lo anterior:

![Imagen19](../media/e1b46c86ba25f5933d8bdb7ac87ae74f.png)

Asignación de permisos al grupo Técnicos

Siguiendo la lógica anterior, agregamos los demás permisos y usuarios a los grupos siguientes.

Respecto a los permisos para el grupo **“Técnicos_Global”**, donde hay una gestión limitada del AD, es decir, el usuario **tecnico1** deberá tener permisos específicos, como crear grupos o modificar usuarios. Entonces:

Vamos a usar el Asistente de Delegación:

![Imagen20](../media/d767c97d5f264d5784321959f26a96e1.png)

Seleccionamos el grupo correspondiente en cuestión: **“Técnicos_Global”**.

![Imagen21](../media/3fb9617d19fa36eb8b11d0d9dcd41faf.png)

A continuación, seleccionamos las siguientes tareas que va a poder realizar dicho grupo **“Técnicos_Global”**:

![Imagen22](../media/603f34e4acfbf817bac5b64cc12ca45e.png)

Obteniendo como resultado:

![Imagen23](../media/bc645d8c8d55dc1c8cd32f8045e22b1a.png)

Sumar al usuario tecnico1

Ahora se va a sumar al usuario **tecnico1**, es decir, Juan Liendo, como miembro del grupo **“Técnicos_Global”**.

![Imagen24](../media/cd02795cde0df7fcfd00bc7cb6854d5e.png)

Verificando en las propiedades del grupo **“Técnicos_Global”**:

![Imagen25](../media/3eb4ac67037795898179a35bd8c7caa0.png)

Asignación de permisos al grupo Estándar

Por último, para el usuario estándar 1 (Arturo Liendo), lo que se va a hacer es que el grupo **“Estandar_Global”** sea miembro de otro grupo: **“Usuarios”**, por lo que va a heredar sus privilegios. Es decir, los usuarios estándares no podrán hacer cambios accidentales o intencionados en el sistema y pueden ejecutar la mayoría de aplicaciones.

![Imagen26](../media/70ca04ae5b68b6a2f50c84bfa2fea4fa.png)

Por lo tanto, llegamos al siguiente resultado:

![Imagen27](../media/9e290f68c6361a2fa0c20a399f1e2553.png)

![Imagen28](../media/ad179b4814540dbc86d0d064aca8b503.png)



## Enunciado 4:

**Crear y unir un workstation:**

- **Crear una nueva VM con Windows 10 o Windows 11 como estación de trabajo.**
- **Unir la estación de trabajo al dominio configurado en el AD.**


## Procedimiento 4:

La lógica para instalar Windows 10 en una máquina virtual (Hyper - V) es muy parecida a la ya explicada anteriormente, es decir, cuando instalamos Windows Server 2019. Por ende directamente veremos como quedó configurada:

![](../media/d3ed9a5b5cd62760162b977e73992e88.png)

Se le asignó 2GB de memoria RAM, 50 GB para almacenamiento y el adaptador de RED para LAN, es decir, configurada para una red privada. Lo cual podemos corroborar en la siguiente imagen donde se observa la administración de los conmutadores virtuales:

![](../media/d963efcfacb17c517276f0dde503b1b8.png)

Las especificaciones fueron decididas en base a la documentación que indica la página oficial de Windows:

![](../media/bca2704e822082a31d5bbb9e58213438.png)

Unir la estación de trabajo al dominio configurado en el AD:

El usuario en cuestión para el S.O de Windows 10 es:

usuario: TomasL

pass: 123456

Primero vamos a chequear la dirección IP que tiene configurada (segmento de red al cual pertenece) la estación de trabajo:

![](../media/058b0a4fe4fe3d95f7fc0b183dd73eea.png)

Segundo chequeamos el Windows Server 2019 (servidor) la dirección IP que tiene configurada (segmento de red al cual pertenece):

![](../media/ca561adf59a09d4ca456acee4d162240.png)

Es decir, la estación de trabajo pertenece a otra red diferente a la cual tiene configurada nuestro servidor. Por lo tanto, debemos en primera instancia configurar dicha dirección IP y que la misma pertenezca al mismo segmento de red en cual se encuentra el servidor.

En el servidor antes vamos a abrir el centro de administración de Active Directory:

![](../media/8957f24d72b705987750a27990e387ec.png)

Luego chequeamos en el usuario administrador (cuenta principal) y observamos que dicha cuenta posee en “Miembros de” Usuarios de Dominio. Esto quiere decir, que el administrador forma parte del grupo de usuarios de dominio, lo cual le permite agregar clientes al dominio creado previamente. En la siguiente imagen se puede observar y aclarar lo explicado:

![](../media/f8b4121feacf8c7b9f2e3e33438be601.png)

Ahora en base a lo explicado anteriormente se procede a configurar la estación de trabajo en Windows 10:

![](../media/a058ccb6af29ccba88cf256e3dd1575b.png)

![](../media/faa75c057f3c9ed339aa14e17478fc28.png)

De esta manera le configuramos la dirección IPV4 privada 192.168.0.3/24 donde lo interesante a destacar aquí es que el servidor DNS que le vamos a configurar es la dirección IP del servidor (Windows Server 2019) porque dicho servidor es el que se va a encargar de dicho servicio. Es decir, de la resolución de nombres de dominio.

Ahora volvemos a chequear y ya está realizada la configuración de dicha dirección IP:

![](../media/65b6b0ffe1689b39e874618569e2abd1.png)

Ahora realizamos un ping a la dirección IP que tiene configurada el servidor desde la estación de trabajo y observamos que todos los paquetes fueron enviados sin ninguna pérdida. Como se puede observar en la siguiente imagen:

![](../media/19ecf837a61106e2f2678c2385353076.png)

Ahora voy a cambiar el nombre de las estación de trabajo a uno que sea más fácil de recordar y que siga determinada nomenclatura para el futuro si quiero agregar nuevas estaciones.

También voy a modificar el nombre de dominio ¿Por cual? Por el que cree anteriormente. Por lo tanto:

Nombre del equipo: ET-01

Dominio: EmpresaDev.local

![](../media/33ddb621e71219cbaa2bb319bf4fa479.png)

Observamos que nos pide para realizar dicha acción: el nombre y la contraseña de una cuenta que posea estos permisos para unir al dominio. Por lo tanto, aquí vamos a usar las credenciales del administrador (cuenta principal) :

usuario: administrador

pass: admin@dev10

![](../media/80375e882020de20e2be27710cb5030d.png)

Aquí vamos a retomar un momento al servidor (Windows Server 2019) y vamos a usar el usuario previamente creado en la sección anterior que pertenece al grupo “Adminstrador_Global” el cual posee los permisos de administración total sobre el dominio. Tener en cuenta que previamente en el servidor cuando nos iniciamos por primera vez nos va a pedir que actualicemos la contraseña porque así lo habiamos configurado entonces:

![](../media/3fe258299e9d74108a835e9901ac6aaa.png)

Credenciales anteriores:

usuario: admin1

pass: Firefox@15

Credenciales actuales:

usuario: admin1

pass: Firefox_15

Ahora si volvemos a la estación de trabajo y completamos con dicho usuario explicado anteriormente:

![](../media/ea6327b4978c697de8d816d478002597.png)

Luego de esperar unos momentos, aparece el siguiente cartel:

![](../media/773fa046713ef7e5e7d7d765bd52559f.png)

De esta manera la estación de trabajo ET-01 se ha unido correctamente al dominio EmpresaDev.local.

A continuación vamos a reiniciar la estación de trabajo y nos vamos a loguear con el usuario estándar conocido como “estándar 1” (Arturo Liendo) que pertenece all grupo “Estándar Global".Es decir, los usuarios estándares no podrán hacer cambios accidentales o intencionados en el sistema y pueden ejecutar la mayoría de aplicaciones.

![](../media/7c4e7a07f795a4b2fd2d5f494d47823e.png)

Donde las credenciales son:

usuario: estandar1

pass: Firefox_17

Y ya nos reconoce el usuario del dominio creado anteriormente:

![](../media/65f6cd5fc40769765e382c7a22673ccd.png)

![](../media/982b26815d966c6e888f21a02dcb9a03.png)

![](../media/03cd108a957014dfe6593a2c5e7ba174.png)

Si ingresamos \\\\192.168.0.2 (ip del servidor) podemos observar las siguientes carpetas compartidas que hacen parte del dominio:

![](../media/e0d7dcd04796496795ae6dab4d3a40ed.png)

Pero si quiero acceder a dichas carpetas tengo el acceso denegado como fue configurado dicho usuario con la menor cantidad de privilegios:

![](../media/d3fa0456c92dc0b53b7bfd4976240cd8.png)

Desde el servidor podemos chequear que la estación de trabajo ya forma parte del dominio:

![](../media/926bea7ed1f939ee6cd8e898a8d309b7.png)


## Enunciado 5:

**Configurar y levantar un sitio web estático:**

- **Instalar y configurar IIS en el servidor.**
- **Crear un sitio web que muestre la página estática "Hola Mundo".**
- **Configurar el sitio para que sea accesible desde la LAN.**


## Procedimiento 5:

Para instalar IIS en el servidor, primero nos dirigimos a “Agregar roles y características”:

![](../media/72784bb43045c3cffa09f0b75d8250e0.png)

En la siguiente imagen veremos el paso a paso de cómo se realiza dicha configuración:

![](../media/d64f0acec92b0bdf46bf23b4b91e17f5.png)

Una vez instalado el ISS en el panel de administración del servidor podemos ver que ya se encuentra dicho servicio con su consola correspondiente:

![](../media/186a0e83f4f721d9c358260207ea82ad.png)

Ahora en la consola de IIS seleccionamos la siguiente opción:

![](../media/b974d8d14a0cb71c8a55d998871b9170.png)

Donde podemos observar que ya se encuentra un sitio web por default:

![](../media/e78f9f43e7e6e3970f84b03c386d6c5a.png)

En base a que el servicio ISS ya se encuentra activo desde el servidor, como lo observamos en la imagen anterior. Lo que voy a realizar a continuación es: probar ingresar a dicho sitio web por default desde la estación de trabajo denominada “ET-01” (Windows 10) previamente configurada en el mismo segmento de red en el cual se encuentra el servidor empleando el navegador.

![](../media/1fd4509bc0a8d8c2b6a60a45fd4d5a5f.png)

Como se puede observar, se pudo ingresar a dicho sitio web.

Para subir el archivo index.html se pueden realizar diversos procedimientos, en este caso, voy a plantear 2 situaciones:

En la primera situación: se va agregar un nuevo adaptador de red a la máquina virtual dónde está configurado el Windows Server 2019 del tipo WAN, es decir, una red externa para de esta manera permitir acceder a internet y descargar dicho archivo.

![](../media/28771736c723b680db37315bab6ae617.png)

![](../media/4da0c86d2462b687002f0b7e4ecb6ee7.png)

![](../media/05a85ae15984470717468b02e13e84c7.png)

Con la siguiente URL se puede acceder al archivo index.html: <https://drive.google.com/drive/folders/1MtW7kZGbD7e1P-QzHH4tLICdTSm4UPNn?usp=sharing>

Por ende, desde el servidor vamos a acceder a dicha URL y descargar el contenido.

La segunda situación y la que voy a elegir por su simplicidad, es la de emplear Sesión Mejorada, chequeando previamente que se encuentre activida. Gracias a esto puedo arrastrar archivos entre el host y la máquina virtual empleada.

![](../media/15eb0ffdc179d30edeeef178310b2f0f.png)

A continuación vamos a crear un nuevo sitio web:

![](../media/817e93e2cbd87f6dc32c64176147df0c.png)

Nos aparecerá la siguiente pantalla, donde ingresamos el nombre del sitio que será “prueba_tecnica” y la ruta donde vamos a alojar el archivo “index.html”

![](../media/4a1df28ff0e7b8474772b4167da0bd55.png)

![](../media/db053cd784ae567edce3122b68382695.png)

Nos aparecerá la siguiente advertencia que el puerto 80 ya está usado para el otro sitio web por default:

![](../media/6ff23387ef5e5dfd30c4222be7e2d2a8.png)

Por ende a continuación lo que se hace es detener dicho sitio web por default:

![](../media/cd7de0bee85f336699f0291974cc8670.png)

Y luego iniciar el sitio web “prueba_tecnica”:

![](../media/d00acbfcfa9a9abc9f4d203e09a93f16.png)

Concluyendo, vamos a ingresar nuevamente desde la máquina virtual donde está instalado Windows 10 (estación de trabajo denominada ET-01) y obtenemos como resultado que el sitio web ha sido actualizado. Lo cual lo podemos observar en la siguiente imagen:

![](../media/89434c75a8dbe8f8e0e70809d53bd2bb.png)

Si ingresamos directamente el dominio (que hemos creado previamente) en el navegador desde la misma estación de trabajo ¿Que pasa? Aparece también dicho sitio web ¿Por qué? Porque el servidor realiza la traducción o resolución del nombre de dominio de dirección IP.

![](../media/1352635cdb833233887dd7dead7e63ff.png)
