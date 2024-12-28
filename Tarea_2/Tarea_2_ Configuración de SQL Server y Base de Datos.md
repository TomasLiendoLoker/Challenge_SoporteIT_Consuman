# Tarea 2: Configuración de SQL Server y Base de Datos

## Enunciado 1:

**Instalar SQL Server :** 

- Instalar y configurar SQL Server en la VM con Windows Server 2019.
- Habilitar el inicio de sesión con el usuario: sa.

## Procedimiento 1:

Primero descargo desde el sitio oficial de windows el motor de base de datos SQL Server Developer Edition 2022 el cual se adapta para realizar pruebas con Windows Server 2019.

LINK:

<https://www.microsoft.com/en-us/sql-server/sql-server-downloads>

Luego descargo también desde el sitio oficial de Windows el SQL Server Management Studio (SSMS) teniendo en cuenta que: es una herramienta gráfica que se utiliza para administrar instancias de SQL Server, ejecutar consultas y realizar tareas administrativas.

LINK: <https://learn.microsoft.com/es-es/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16>

Realizadas las descargas anteriores desde la máquina anfitriona, se trasladan los archivos a la máquina virtual (Windows Server 2019) arrastrando dichos instaladores usando los beneficios que brinda la sesión mejorada.

A continuación se observa el proceso de instalación respecto al SQL server 2022:

![](../media/fcd95d2256b2ad78d76ae61b6de248a1.png)

![](../media/9b5963a1ea6ede7aa0f909c2c3e08d59.png)

**![](../media/8fc4236dcc67329ce8dbe3d355eec721.png)**

Ahora se prosigue con la instalación del SQL Server Management Studio:

![](../media/72f285187eedc47fee81eb22ee3d3c6c.png)

![](../media/53a75727c350b8c74098e468d1800c35.png)

![](../media/382f7541d44bc09cc6a12fc2779f79fb.png)

Una vez instalado accedemos al SQL Server Management Studio lo que voy a hacer a continuación es habilitar el inicio de sesión con el usuario “sa”. Por ende en primera instancia voy a emplear la Autenticación de Windows para conectarse a la BD:

![](../media/e84f568a07b39c5ee234a0c3a0e1d542.png)

Y observamos que por defecto tal usuario “sa” se encuentra inhabilitado:

![](../media/997b25c8b9d51deb6b188ab952b49b0f.png)

Por ende se ingresa en las propiedades para tal usuario “sa” con el objetivo de configurar una determinada contraseña:  
![](../media/a780f1671c80b0054e4f6118dbdaf382.png)

Luego en la sección de estado, habilitamos el inicio de sesión empleado dicho usuario “sa”:

![](../media/39f1f79910f1c46bd1621a110669c5a4.png)

Ahora ya se puede ver el usuario habilitado:

![](../media/f33d3ffe828f56a05f905895451d0716.png)

Posteriormente se accede a las propiedades del servidor AD1 y activamos el modo de autenticación mixto:

![](../media/47e31d8d4b56cac5df334b2e180140fa.png)

Por último vamos a reiniciar el servicio de SQL Server:

![](../media/a874e11f57d0afd8358c77c32b7d1648.png)

Credenciales:

usuario: sa

pass: 123456

Ahora pruebo conectarme al servidor de SQL con el usuario “sa” (el cual ya fue habilitado previamente):

![](../media/a2f7f96fae7afe935416deb8724832dc.png)

Y de esta manera, ahora podemos iniciar sesión dicho usuario:

![](../media/4150c6d4771f9d13245b9a46e647f3b4.png)

## Enunciado 2:

**Crear una base de datos con relaciones:**

- Diseñar una base de datos que represente un pequeño videojuego de rol (RPG). Las tablas deben incluir datos ficticios, relaciones lógicas, y pueden ser las siguientes:

    - Jugadores: Información básica de los jugadores (ID, Nombre, Nivel).

    - Personajes: Detalles de los personajes (ID, Nombre, Clase, Nivel, ID del jugador).

    - Habilidades: Habilidades disponibles en el juego (ID, Nombre, Tipo, Nivel requerido).

    - Equipamiento: Equipamiento que pueden usar los personajes (ID, Tipo, Bonificación, Nivel requerido, ID del personaje).

## Procedimiento 2:

Lo que se realiza a continuación es abrir el script con extensión .sql que previamente fue trasladado desde la máquina anfitriona hacia el servidor (Windows Server 2019) en el SQL server management:

![](../media/7344ae789765244fab900a1560af4036.png)

Una vez abierto el archivo, se procede a ejecutar tal script:

![](../media/ae110b13189932d28dc26109f9c94f82.png)

Una vez ejecutado tal script, aparece la nueva base de datos creada llamada “RPG” donde se pueden observar un subconjunto de las tablas con los datos correspondientes como se puede ver a continuación:

![](../media/a836f45bf7cedf64d3643975ff4ad30c.png)

Haciendo un resumen de las estructuras de las tablas y los datos que contienen en base al script anterior, tenemos:

1\. Tabla Jugadores

Representa a los jugadores del juego RPG.

Estructura:

ID: Identificador único (clave primaria).

Nombre: Nombre del jugador.

Nivel: Nivel del jugador.

Relación:

1:N con Personajes (un jugador puede tener múltiples personajes).

Jugadores en la BD RPG:

![](../media/e826e82b838e8276389b999c288a59b2.png)

2\. Tabla Personajes

Representa los personajes pertenecientes a los jugadores del juego RPG.

Estructura:

ID: Identificador único (clave primaria).

Nombre: Nombre del personaje.

Clase: Tipo de personaje (guerrero, mago, etc.).

Nivel: Nivel del personaje.

ID_Jugador: Relación con el jugador propietario.

Relaciones:

1:N con Jugadores (cada personaje pertenece a un jugador).

N:M con Habilidades (un personaje puede tener muchas habilidades y viceversa).

N:M con Equipamientos (un personaje puede tener muchos equipamientos y viceversa).

Personajes en la BD RPG:

![](../media/ab6d9f2416600a2c519ea30f38ee9f58.png)

3\. Tabla Habilidades

Define las habilidades que los personajes pueden aprender.

Estructura:

ID: Identificador único (clave primaria).

Nombre: Nombre de la habilidad.

Tipo: Tipo de habilidad.

Nivel_requerido: Nivel mínimo necesario para adquirir la habilidad.

Relación:

N:M con Personajes ../mediante la tabla inter../media Personajes_Habilidades.

Habilidades en la BD RPG:

![](../media/04c041c2e1ab582b4671edf7632fadf1.png)

4\. Tabla Equipamientos

Define los equipamientos disponibles en el juego y que los personajes pueden adquirir.

Estructura:

ID: Identificador único (clave primaria).

Tipo: Tipo de equipamiento.

Bonificación: Efectos o beneficios del equipamiento.

Nivel_requerido: Nivel mínimo necesario para usar el equipamiento.

Relación:

N:M con Personajes ../mediante la tabla inter../media Personajes_Equipamientos.

Equipamientos en la BD RPG:

![](../media/7e2abd4f1cb15b28092e38528e106b0f.png)

5\. Tabla Personajes_Habilidades (tabla inter../media)

Relaciona personajes con habilidades.

Estructura:

ID_Personaje: Identificador del personaje.

ID_Habilidad: Identificador de la habilidad.

Nivel: Nivel actual de la habilidad para el personaje.

Relación:

N:M entre Personajes y Habilidades.

Un personaje puede tener 0 o muchas habilidades.

Una habilidad puede no estar asignada o estar asociada a múltiples personajes.

Personajes_Habilidades en la BD RPG:

![](../media/01b38b96d70648dbf241c25982206138.png)

6\. Tabla Personajes_Equipamientos (tabla inter../media)

Relaciona personajes con equipamientos.

Estructura:

ID_Personaje: Identificador del personaje.

ID_Equipamiento: Identificador del equipamiento.

Nivel: Nivel actual del equipamiento.

Relación:

N:M entre Personajes y Equipamientos.

Un personaje puede tener 0 o muchos equipamientos.

Un equipamiento puede no estar asignado o estar asociado a múltiples personajes.

Personajes_Equipamientos en la BD RPG:

![](../media/f3fcd6d65b3cdff3db9423d34b1982fb.png)

Donde el diagrama de entidad - relación es el siguiente:

![](../media/301ce7be172b39cb4dbf5c6c2d61b944.png)

## Enunciado 3:

**Crear un Stored Procedure (SP)**
- Desarrollar un SP para realizar una acción sobre las tablas. Por ejemplo:

    - Subir de nivel a un personaje, incrementando su nivel y actualizando el nivel de las habilidades o equipamiento asociado.

    - Validar los cambios en las tablas ../mediante el SP.

## Procedimiento 3:

En la siguiente imagen, se puede observar los procedimientos almacenados que fueron creados en este script:

![](../media/9e8ac2ca862fee1e349d39bd5ec84fa6.png)

![](../media/4ba2a9a8bd5b291ffeebfe03b86832dd.png)

**Procedimiento Almacenado 1: InsertarPersonajeHabilidad**

Este procedimiento consiste en asegurar que una habilidad solo pueda ser asociada o asignarse a un personaje si se cumple que el nivel del personaje actual sea igual o superior al nivel requerido por la habilidad. Si se cumple la condición, la habilidad se registra en la tabla Personajes_Habilidades con un nivel inicial especificado y si el nivel del personaje es insuficiente no se realiza la inserción y se muestra un mensaje indicando que el personaje no cumple con los requisitos.

El objetivo de este SP es evitar asignaciones inconsistentes y asegurar que los personajes solo puedan desbloquear habilidades o equipamientos apropiados para su nivel.

**Ejemplo**:

1º Recordando la tabla de Personajes:

![](../media/c080e731fa259dd7e8ed424ab6036f27.png)

2º Recordando la tabla de Habilidades:

![](../media/3ded980a7b23f23f30fd963f34bdf262.png)

3º Ahora comenzaremos a insertar registros en la tabla Personajes_Habilidades:

Caso 1: se asignan las habilidades “Golpe Aplastante” y “Mano Sanadora” al personaje “Ardan el Guerrero” con un nivel de 1 para ambas habilidades. En este caso se cumple la condición especificada anteriormente, es decir, el nivel actual del personaje es igual o superior al nivel mínimo requerido por la habilidad que es de 1. Por lo tanto, la inserción se realiza de manera correcta como podemos ver a continuación:

![](../media/a6a5209f4d8f69c6399bcaf103b1c8aa.png)

![](../media/889794723cd838f3e2588ae8ff6e960c.png)

Caso 2: se intenta asignar la habilidad “Tajo Mortal” al personaje “Ardan el Guerrero” con un nivel de 2 para dicha habilidad. En este caso NO se cumple la condición especificada anteriormente, es decir, el nivel actual del personaje (1) es inferior al nivel mínimo requerido por la habilidad que es de 6. Por lo tanto, la inserción NO se realiza y se notifica como podemos ver a continuación:

![](../media/cab1551d07df6c000aff389a8d2d2744.png)

![](../media/889794723cd838f3e2588ae8ff6e960c.png)

**Procedimiento Almacenado 2: InsertarPersonajeEquipamiento**

Emplea la misma lógica explicada anteriormente pero adaptada para asociar/asignar equipamiento a un personaje en la tabla Personajes_Equipamientos.

**Procedimiento Almacenado 3: SubirNivelPersonaje_habilidad**

Este procedimiento permite realizar el aumento de nivel de un personaje así como la actualización de nivel para habilidades que ya posee como también el desbloqueo de nuevas habilidades. Es decir, si el personaje ya tiene la habilidad, su nivel se incrementa; si no la tiene y alcanza el nivel requerido, se le asigna/desbloquea la nueva habilidad deseada. Si el personaje no alcanza el nivel requerido para desbloquear una habilidad, se le notifica.

**Ejemplo:**

1º Recordemos los datos que posee la tabla de Habilidades:

![](../media/4470f6d00bc7970ea0f03060159e3a2b.png)

2º Teniendo en cuenta el nivel requerido para las diferentes habilidades, vamos a plantear 3 casos:

Caso 1: Subir 2 niveles al personaje con ID=1, es decir, al personaje “Ardan el Guerrero” e incrementar esos 2 niveles a la habilidad con ID=1, es decir, “Golpe Aplastante” (la cual ya posee).

Por lo tanto ejecutamos el SP correspondiente:

![](../media/c6b547e8e96e4a1a861e4ee5707fd2dd.png)

Donde el reflejo de los cambios de las tablas se puede ver a continuación:

![](../media/b6b52124603fc8ae4c1002ced86ff2a1.png)

Caso 2: Subir 1 nivel al personaje con ID=1, es decir, al personaje “Ardan el Guerrero” y desbloquear la habilidad con ID=6, es decir, “Tajo Mortal” buscando a su vez incrementar en uno a esa nueva habilidad ¿Pero qué ocurrirá? Lo que ocurrirá es que el personaje “Ardan el Guerrero” aumentará en uno su nivel actual pero NO podrá desbloquear la habilidad indicada “Tajo Mortal” ya que el nivel del personaje no cumple aún con el nivel mínimo requerido para acceder a la misma. Por lo tanto, aparecerá un mensaje indicando lo siguiente: “El personaje no tiene el nivel suficiente para desbloquear esta habilidad”.

Por lo tanto ejecutamos el SP correspondiente:

![](../media/ac9c536104b42705a7b16cff29810883.png)

Donde el reflejo de los cambios de las tablas se puede ver a continuación:

![](../media/5e5a6fe46a3b960c2667827846083c6f.png)

Caso 3: Subir 2 niveles al personaje con ID=1, es decir, al personaje “Ardan el Guerrero” y desbloquear la habilidad con ID=6, es decir, “Tajo Mortal” buscando a su vez incrementar en 2 a esa nueva habilidad ¿Pero qué ocurrirá? Lo que ocurrirá es que el personaje “Ardan el Guerrero” aumentará en dos su nivel actual, es decir, ahora pasará a ser un personaje de nivel 6 además ahora SÍ podrá desbloquear la habilidad indicada “Tajo Mortal” ya que el nivel del personaje ahora SI cumple con el nivel mínimo requerido para acceder a la misma. Por lo tanto, aparecerá un mensaje indicando lo siguiente: “Habilidad desbloqueada y asignada al personaje con el nivel correspondiente.”

Por lo tanto ejecutamos el SP correspondiente:

![](../media/63111573ecc8396a7050c17907512eaa.png)

Donde el reflejo de los cambios de las tablas se puede ver a continuación:

![](../media/436ddd3a02316bbbcefa5f42d80fea25.png)

**Procedimiento Almacenado 4: SubirNivelPersonaje_equipamiento**

Emplea la misma lógica explicada anteriormente, es decir, permite realizar el aumento de nivel de un personaje así como la actualización de nivel para equipamientos que ya posee como también el desbloqueo de nuevos equipamientos.

**Ejemplo:**

1º Recordemos los datos que posee la tabla de Equipamientos:

![](../media/5052c4b8416123ea8bfd2e7fc5fbac9b.png)

2º Teniendo en cuenta el nivel requerido para los diferentes equipamientos, vamos a plantear 3 casos:

Caso 1: Subir un nivel al personaje con ID=3, es decir, al personaje “Kael el Arquero” e incrementar en uno al equipamiento con ID=1, es decir, “Daga de Hierro” (la cual ya posee).

Por lo tanto ejecutamos el SP correspondiente:

![](../media/a210b10768109f9a0fe01a4fd7fad626.png)

Donde el reflejo de los cambios de las tablas se puede ver a continuación:

![](../media/0d8a36cdd6be60948866a547735134df.png)

Caso 2: Subir un nivel al personaje con ID=3, es decir, al personaje “Kael el Arquero” y desbloquear el equipamiento con ID=10, es decir, “Hacha del Berserker” buscando a su vez incrementar en uno a ese nuevo equipamiento ¿Pero qué ocurrirá? Lo que ocurrirá es que el personaje “Kael el Arquero” aumentará en uno su nivel actual pero NO podrá desbloquear el equipamiento indicado “Hacha del Berserker” ya que el nivel del personaje no cumple aún con el nivel mínimo requerido para acceder a tal equipamiento. Por lo tanto, aparecerá un mensaje indicando lo siguiente: “ El personaje no tiene el nivel suficiente para desbloquear este equipamiento”.

Por lo tanto ejecutamos el SP correspondiente:

![](../media/c5bebb3ca6effe6de691e8541b62e184.png)

Donde el reflejo de los cambios de las tablas se puede ver a continuación:

![](../media/9b61662d5c29b9e2393417caae43d1d7.png)

Caso 3: Subir un nivel al personaje con ID=3, es decir, al personaje “Kael el Arquero” y desbloquear el equipamiento con ID=10, es decir, “Hacha del Berserker” buscando a su vez incrementar en uno a ese nueva equipamiento ¿Pero qué ocurrirá? Lo que ocurrirá es que el personaje “Kael el Arquero” aumentará en uno su nivel actual, es decir, ahora pasará a ser un personaje de nivel 6 además ahora SÍ podrá desbloquear el equipamiento indicado “Hacha del Berserker” ya que el nivel del personaje ahora SI cumple con el nivel mínimo requerido para acceder al mismo. Por lo tanto, aparecerá un mensaje indicando lo siguiente: “Equipamiento desbloqueado y asignado al personaje con el nivel correspondiente.”

Por lo tanto ejecutamos el SP correspondiente:

![](../media/8a8ec97246f514de99f4117aa2ad624c.png)

Donde el reflejo de los cambios de las tablas se puede ver a continuación:

![](../media/2b3ce90f6ab59e1b66aac7e14719007e.png)
