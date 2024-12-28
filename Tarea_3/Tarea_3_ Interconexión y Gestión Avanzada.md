# Tarea 3: Interconexión y Gestión Avanzada

## Enunciado 1:

### Crear una nueva VM:

- Configurar una nueva VM con Windows Server 2022.
- Unirla al mismo segmento de red que la primera VM.
- Unir la nueva VM al dominio configurado en el AD del primer servidor.

## Procedimiento 1:

Usando la misma lógica de instalación que se empleó para instalar Windows Server 2019 en una máquina virtual empleando Hyper-v, se aplicará para configurar una nueva máquina virtual usando ahora Windows Server 2022.

A continuación se puede observar el resumen de la máquina que se creará:

![](../media/e391a04233f0329299d03cb4e79c36d5.png)

Para los requisitos de la memoria RAM, almacenamiento, etc. Me base en las especificaciones publicadas en la página de Microsoft :

![](../media/b8f65dcf94eda2b5af3fceff4a97750b.png)

![](../media/42050c17858ab6f2268cf7384d2986df.png)

Además aclarar que la configuración del adaptador de red se encuentra en LAN (Red privada) como se puede observar en la siguiente imagen:

![](../media/bc8df34e912f9cce64bcc89b63b1e91a.png)

Se elige la experiencia de escritorio para una mayor facilidad:

![](../media/773fa7d11f46362a7c083ca38cc8213a.png)

Cómo creamos un servidor desde 0 elegimos la siguiente opción:

![](../media/c9fd375f7f51edd1ebbd8b3f922c00d7.png)

Almacenamiento designado:

![](../media/dc259c51e2b2f093f2ff48f06c428094.png)

Teniendo en cuenta las siguientes credenciales:

![](../media/c5e0482435f423c0e3036bb4f17ad32b.png)

usuario: administrador

contraseña: Tomy@dev20

Ahora lo que realizaré será unir el servidor (Windows Server 2022) al mismo segmento de red al cual pertenece el servidor principal (Windows Server 2019):

Por lo tanto, primero voy a chequear la dirección IP que tiene configurada (segmento de red al cual pertenece) el servidor (Windows Server 2022):

![](../media/4cfcf2fca8435ff81bbd17890d2b5561.png)

![](../media/7d376fef5358508d223d1e8982dab60b.png)

Segundo chequeamos el Windows Server 2019 (servidor principal) la dirección IP que tiene configurada (segmento de red al cual pertenece):

![](../media/daf8b40b55b6a00d7bc11e296d27ce6d.png)

Es decir, el servidor (Windows Server 2022) pertenece a otra red diferente a la cual tiene configurada nuestro servidor principal (Windows Server 2019). Por lo tanto, debemos en primera instancia configurar dicha dirección IP y que la misma pertenezca al mismo segmento de red en cual se encuentra el servidor principal.

![](../media/54206c728b45f043a7a83349628d0e1e.png)

![](../media/079b23b2f1f3e1ecd07f36083e776b5a.png)

De esta manera le configuramos la dirección IPV4 privada 192.168.0.4/24 donde lo interesante a destacar aquí es que el servidor DNS que le vamos a configurar es la dirección IP del servidor principal (Windows Server 2019) porque dicho servidor es el que se va a encargar de dicho servicio. Es decir, de la resolución de nombres de dominio.

Ahora volvemos a chequear y ya está realizada la configuración de dicha dirección IP:

![](../media/6170c1202d009ee80677c9beb7c42333.png)

Ahora realizamos un ping a la dirección IP que tiene configurada el servidor principal desde el servidor (Windows Server 2022) y observamos que todos los paquetes fueron enviados sin ninguna pérdida. Como se puede observar en la siguiente imagen:

![](../media/66ab7d7da834a5c075da25e1b5d0fc53.png)

Una vez realizado lo anterior voy a proseguir con unir la nueva VM (Windows Server 2022) al dominio configurado en el AD del primer servidor (Windows Server 2019):

Primero voy a cambiar el nombre que tiene asociado el equipo a uno que sea más fácil de recordar. También voy a modificar el nombre de dominio ¿Por cual? Por el que cree anteriormente. Por lo tanto:

![](../media/6d9ca04c3600c273964d9881356950d3.png)

Observamos que nos pide para realizar dicha acción: el nombre y la contraseña de una cuenta que posea estos permisos para unir al dominio. Por lo tanto, aquí vamos a usar las credenciales del administrador (cuenta principal) :

usuario: admin1

pass: Firefox_15

![](../media/5fdeb9dd8779433df82ecb5b04904fe9.png)

![](../media/ecb14535f6a15f1b11d981f5245f7633.png)

De esta manera el equipo WS2022 se ha unido correctamente al dominio EmpresaDev.local. Ahora lo que queda es reiniciar el equipo y volver a ingresar con las credenciales correspondientes.

Ahora si ingresamos \\\\192.168.0.2 (ip del servidor) podemos observar las siguientes carpetas compartidas que hacen parte del dominio:

![](../media/457efaeac4341bf9fb902ca7be39fa6f.png)

Observamos que nos pide para realizar dicha acción: el nombre y la contraseña de una cuenta que posea estos permisos, hay que recordar que inicie sesión con la cuenta local configurada por default en Windows Server 2022 y NO con una de las cuentas del dominio en cuestión previamente configurados en el Windows Server 2019, es por ello que aparece tal advertencia. Por lo tanto, aquí vamos a usar las credenciales del administrador (cuenta principal):

![](../media/a28058309759a08decd1260aa7536d6f.png)

![](../media/b3de5cb3a7ce14f26b76b63b23a93415.png)

Desde el servidor principal (Windows Server 2019) podemos chequear el servidor que se ha configurado en este apartado (Windows Server 2022) y que ya forma parte del dominio:

![](../media/10d16347aaef7e3727af05a130089142.png)

## Enunciado 2:

- Acceso al sitio web:

    - Desde la VM con Windows Server 2022, acceder al sitio estático "Hola Mundo" alojado en la VM con Windows Server 2019.

## Procedimiento 2:

Situados en la máquina virtual con Windows Server 2022 nos dirigimos al navegador web e ingresamos la dirección IP del servidor principal (Windows Server 2019) donde podemos observar dicho sitio web alojado en el mismo:

![](../media/ed09ea086faaf8df43f4ecc164e39d77.png)

Ahora si ingresamos directamente el dominio (el cual fue creado previamente) en el navegador desde la misma máquina virtual con Windows Server 2022 ¿Que pasa? Aparece también dicho sitio web ¿Por qué? Porque el servidor principal (Windows Server 2019) realiza la traducción o resolución del nombre de dominio a dirección IP.

![](../media/88cee528daa37e2a85d4a700de3513af.png)

## Enunciado 3:

- Carpeta compartida y permisos:

    - Crear una carpeta compartida en la VM con Windows Server 2022.

    - Configurar permisos diferenciados para los tres usuarios creados en el AD:

        - Administrador: Permiso total (lectura, escritura y eliminación).

        - Técnico: Permiso de lectura y escritura, sin posibilidad de eliminar archivos.

        - Estándar: Permiso de solo lectura.

## Procedimiento 3:

Lo primero que se hará es crear una nueva carpeta en la ubicación en el disco local C e ir a la opción de “uso compartido avanzado”.

![](../media/7ba2e60d63c97866be15c1c689555997.png)

En los permisos del recurso compartido en este caso “Carpeta Compartida” se elimina el grupo “Todos”:

![](../media/f9afe926d311be828949e9038654e785.png)

Ahora si se agregarán los tres usuarios que han sido creados previamente desde el AD en el Windows Server 2019 con sus permisos correspondientes para tal carpeta compartida:

Usuario administrador cuya información era:

![](../media/fb54b44d0a47382e3785c424e6ad1357.png)

![](../media/59f5fcd079384f83e64d0e668983d68a.png)

Con los siguientes permisos para tal usuario:

![](../media/b724d444acc6921126b4deb661a04cc4.png)

Usuario técnico cuya información era:

![](../media/a18e0ad47fff9ea0534c79adba1955f1.png)

![](../media/c82b7427a782cb1c0f81c96a6398f051.png)

Con los siguientes permisos para tal usuario:

![](../media/5392cb160cb8f637ce688c8a36153c8a.png)

Usuario Estándar cuya información era:

![](../media/408c82710fb495fab91eef3ba5585a04.png)

![](../media/8fc2a133731fb2438aee1e9b1d57d93c.png)

Con los siguientes permisos para tal usuario:

![](../media/91262b533af15dde03c63d74212f4b9b.png)

Ahora hay que configurar los permisos en la pestaña “seguridad” para tal carpeta compartida y agregar los 3 usuarios previamente mencionados siguiendo la siguiente lógica:

Agregamos el usuario administrador (Tomás Liendo)

![](../media/da2b924260c63e80c382c3cbfcd29a61.png)

Con los siguientes permisos:

![](../media/c232ccc9f875df482897613ab6934503.png)![](../media/43ea21fb0ab6922e1145bf418a605829.png)

Se emplea la misma lógica mencionada antes para agregar el usuario técnico (Juan Liendo) y el usuario estándar (Arturo Liendo). Donde el resultado final es el siguiente:

![](../media/b2479cc939e2655d58c5b0e4398c0c00.png)![](../media/d530cd6f8da83f688761a578b513ea82.png)

![](../media/844436be53f0776c41e69d35eb2f8b4b.png)![](../media/1c36d4e1a47d3d34434b8fabd87090bc.png)

## Enunciado 4:

- Simulación de permisos:

    - Desde la VM con Windows Server 2019, conectarse a la carpeta compartida utilizando los tres usuarios y simular sus permisos sobre un archivo.

    - Documentar el comportamiento esperado de cada usuario según sus permisos.

## Procedimiento 4:

Con el usuario administrador agregamos dicha carpeta compartida:

![](../media/866e43491b13bc5f0e3103b905900f3a.png)

Especificando la ruta correspondiente para acceder a dicha carpeta compartida:

![](../media/44763f74568a39007e3fa14f9cc089eb.png)

Finalmente desde el usuario administrador accedimos a tal carpeta compartida:

![](../media/05fd7191c163d928f133dd666b8cc1d2.png)

Ahora realizo las siguientes acciones:

1\_ Creo una carpeta y un archivo de texto con el usuario admin1

![](../media/b0e111b9c7115ac91f95fc3b5ba19c27.png)

2\_ Escribo algún tipo de texto en tal archivo de “códigos” y guardo tal información:

![](../media/57de20704fe7a102b1426e7aef3f746a.png)

3\_ Por último borro un archivo de texto, el cual fue previamente creado desde Windows Server 2022:

![](../media/47d51882e92b8c750c28a12ae33b2a5a.png)

![](../media/d7f8373d7b7ccfa469dac860afc6496f.png)

![](../media/c4e3e197cd726fdc542189873d6e1838.png)

Teniendo como resultado dicho archivo eliminado:

![](../media/736cd9be04f921cff31c210233e27c0a.png)

Ahora voy a ingresar con el usuario técnico al Windows Server 2019, donde debido a que iniciamos sesión por primera vez con tal usuario se va actualizar la contraseña para tal usuario. Quedando como credenciales actualizadas para el mismo:

usuario: tecnico1

pass: Firefox_16

![](../media/a428e8a2a86df88916c9487a85282406.png)

Pero con el usuario técnico ya logueado agregamos dicha carpeta compartida:

![](../media/f3aef013b21fb8c926bb7b946ac58a30.png)

Y de esta manera pudimos acceder a la carpeta compartida:

![](../media/33866069ad51155787b5bda7053f5bc6.png)

Ahora realizo las siguientes acciones:

1\_ Creo un archivo de texto “Informe para técnicos” con el usuario tecnico1:

![](../media/70f1957bb1e63bb8718de76fb509e3ff.png)

2\_ Escribo algún tipo de texto en tal archivo de “códigos” y guardo tal información:

![](../media/74c4d4cdb29bff16edb802f47e65d20a.png)

3\_ Por último borro un archivo de texto, el cual fue previamente creado por el usuario admin1 “Tomas Liendo” que posee todos los privilegios para esta carpeta compartida:

![](../media/e136925eaf19c0ef3b8b980abe3f1d4b.png)

¿Qué sucede? Lo que ya veníamos esperando, a este usuario “tecnico1” como previamente le configuramos para esta carpeta compartida los permisos de lectura y escritura, sin posibilidad de eliminar archivos. Ahora no lo está dejando eliminar tales archivos lo cual es correcto y que dichos permisos están actuando de forma correcta:

![](../media/d29dba3b1e500b69e8372fa7f33f87f7.png)

Ahora voy a ingresar con el usuario estándar al Windows Server 2019 donde las credenciales del mismo son:

usuario: estandar1

pass: Firefox_17

Recodar que el usuario administrador principal de todos es:

usuario:administrador

pass: Tomy@dev10

Por lo tanto con el usuario estandar1 agregamos dicha carpeta compartida:

![](../media/7aed6659261b089e5b4511572c308b5b.png)

Y de esta manera pudimos acceder a la carpeta compartida:

![](../media/c4edb6ce2bca68276075d1dc8eeed127.png)

Ahora realizo las siguientes acciones:

Intento crear un archivo de texto llamado “Informe para usuarios estándares” con el usuario estandar1 pero no puedo hacerlo debido a que este usuario “estandar1” como previamente le configuramos para esta carpeta compartida solo los permisos de lectura y sin posibilidad de escritura ni tampoco de eliminar archivos. Ahora no lo está dejando crear y tampoco eliminar archivos lo cual es correcto y refleja que dichos permisos están actuando de forma correcta:

![](../media/2c9eff08d79753f115e0c3a3a2468b4f.png)

![](../media/286655f7dc3014141b3c84eaba2b3d74.png)
