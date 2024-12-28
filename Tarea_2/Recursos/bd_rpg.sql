USE master;
GO

-- Desconectar todas las conexiones activas en la base de datos RPG
ALTER DATABASE RPG SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

-- Eliminar la base de datos RPG
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'RPG')
BEGIN
    DROP DATABASE RPG;
END;
GO

-- Crear la base de datos RPG
CREATE DATABASE RPG;

GO

-- Seleccionar la base de datos RPG
USE RPG;


CREATE TABLE Jugadores (
    ID INT PRIMARY KEY IDENTITY(1,1),  -- ID auto incrementable
    Nombre NVARCHAR(100) NOT NULL,
    Nivel INT NOT NULL
);


CREATE TABLE Personajes (
    ID INT PRIMARY KEY IDENTITY(1,1),  -- ID auto incrementable
    Nombre NVARCHAR(100) NOT NULL,
    Clase NVARCHAR(50) NOT NULL,
    Nivel INT NOT NULL,
    ID_Jugador INT NOT NULL,
    FOREIGN KEY (ID_Jugador) REFERENCES Jugadores(ID)  -- Relación con Jugadores
);


CREATE TABLE Habilidades (
    ID INT PRIMARY KEY IDENTITY(1,1),  -- ID auto incrementable
    Nombre NVARCHAR(100) NOT NULL,
    Tipo NVARCHAR(50) NOT NULL,
    Nivel_requerido INT NOT NULL
);



CREATE TABLE Equipamientos (
    ID INT PRIMARY KEY IDENTITY(1,1),  -- ID auto incrementable
    Tipo NVARCHAR(50) NOT NULL,
    Bonificación NVARCHAR(100) NOT NULL,
    Nivel_requerido INT NOT NULL
);

--Tabla intermedia para la relación muchos a muchos entre Personajes y Equipamientos
CREATE TABLE Personajes_Equipamientos (
    ID_Personaje INT NOT NULL,
    ID_Equipamiento INT NOT NULL,
    Nivel INT DEFAULT 1,  -- Nivel actual del equipamiento
    PRIMARY KEY (ID_Personaje, ID_Equipamiento),  -- Llave compuesta
    FOREIGN KEY (ID_Personaje) REFERENCES Personajes(ID),
    FOREIGN KEY (ID_Equipamiento) REFERENCES Equipamientos(ID)
);


--Tabla intermedia para la relación muchos a muchos entre Personajes y Habilidades
CREATE TABLE Personajes_Habilidades (
    ID_Personaje INT NOT NULL,
    ID_Habilidad INT NOT NULL,
    Nivel INT NOT NULL,  -- Nivel de la habilidad para el personaje
    PRIMARY KEY (ID_Personaje, ID_Habilidad),  -- Llave compuesta
    FOREIGN KEY (ID_Personaje) REFERENCES Personajes(ID),
    FOREIGN KEY (ID_Habilidad) REFERENCES Habilidades(ID)
);

GO
-- Verificar si el procedimiento almacenado ya existe
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'InsertarPersonajeHabilidad')
BEGIN
    -- Si existe, eliminar el procedimiento almacenado
    DROP PROCEDURE InsertarPersonajeHabilidad;
END
GO

CREATE PROCEDURE InsertarPersonajeHabilidad
    @ID_Personaje INT,
    @ID_Habilidad INT,
    @Nivel INT
AS
BEGIN
    -- Declarar variables para almacenar los niveles
    DECLARE @NivelRequerido INT;
    DECLARE @NivelPersonaje INT;

    -- Obtener el nivel requerido para la habilidad
    SELECT @NivelRequerido = Nivel_requerido
    FROM Habilidades
    WHERE ID = @ID_Habilidad;

    -- Obtener el nivel actual del personaje
    SELECT @NivelPersonaje = Nivel
    FROM Personajes
    WHERE ID = @ID_Personaje;

    -- Verificar si el nivel del personaje es suficiente para la habilidad
    IF @NivelPersonaje >= @NivelRequerido
    BEGIN
        -- Realizar la inserción
        INSERT INTO Personajes_Habilidades (ID_Personaje, ID_Habilidad, Nivel)
        VALUES (@ID_Personaje, @ID_Habilidad, @Nivel);
        
        PRINT 'Habilidad asociada correctamente.';
    END
    ELSE
    BEGIN
        PRINT 'El nivel del personaje es insuficiente para desbloquear esta habilidad.';
    END
END;

GO

-- Verificar si el procedimiento almacenado ya existe
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SubirNivelPersonaje_habilidad')
BEGIN
    -- Si existe, eliminar el procedimiento almacenado
    DROP PROCEDURE SubirNivelPersonaje_habilidad;
END
GO

CREATE PROCEDURE SubirNivelPersonaje_habilidad
    @ID_Personaje INT,         -- ID del personaje
    @IncrementoNivel INT,      -- Incremento del nivel del personaje
    @ID_Habilidad INT          -- ID de la habilidad que se va a incrementar (o desbloquear)
AS
BEGIN
    -- Declarar variables locales para el nivel actual del personaje
    DECLARE @NivelActual INT;
    DECLARE @NivelRequerido INT;

    -- Obtener el nivel actual del personaje
    SELECT @NivelActual = Nivel
    FROM Personajes
    WHERE ID = @ID_Personaje;
    
    -- Verificamos si el personaje existe y si el incremento es positivo
    IF @NivelActual IS NOT NULL AND @IncrementoNivel > 0
    BEGIN
        -- Actualizar el nivel del personaje
        UPDATE Personajes
        SET Nivel = @NivelActual + @IncrementoNivel
        WHERE ID = @ID_Personaje;
        
        PRINT 'Nivel del personaje actualizado correctamente.';

        -- Obtener el nivel requerido para la habilidad
        SELECT @NivelRequerido = Nivel_Requerido
        FROM Habilidades
        WHERE ID = @ID_Habilidad;

        -- Verificar si el personaje tiene la habilidad especificada y si ya tiene acceso a esa habilidad
        IF EXISTS (SELECT 1 FROM Personajes_Habilidades WHERE ID_Personaje = @ID_Personaje AND ID_Habilidad = @ID_Habilidad)
        BEGIN
            -- Si el personaje ya tiene la habilidad, actualizar su nivel
            UPDATE Personajes_Habilidades
            SET Nivel = Nivel + @IncrementoNivel
            WHERE ID_Personaje = @ID_Personaje AND ID_Habilidad = @ID_Habilidad;
            
            PRINT 'Habilidad seleccionada actualizada correctamente.';
        END
        ELSE
        BEGIN
           -- Si el personaje no tiene la habilidad, verificamos si con el nuevo nivel puede desbloquearla
			IF (@NivelActual + @IncrementoNivel) >= @NivelRequerido
				BEGIN
				-- Si el personaje alcanza el nivel requerido, insertar la habilidad con el incremento aplicado
					INSERT INTO Personajes_Habilidades (ID_Personaje, ID_Habilidad, Nivel)
					VALUES (@ID_Personaje, @ID_Habilidad, @IncrementoNivel);
					PRINT 'Habilidad desbloqueada y asignada al personaje con el nivel correspondiente.';
				END
				ELSE
				BEGIN
					PRINT 'El personaje no tiene el nivel suficiente para desbloquear esta habilidad.';
				END

			END
		END
		ELSE
	    BEGIN
			 PRINT 'No se pudo actualizar el nivel del personaje.';
		 END
END;


GO

-- Verificar si el procedimiento almacenado ya existe
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'InsertarPersonajeEquipamiento')
BEGIN
    -- Si existe, eliminar el procedimiento almacenado
    DROP PROCEDURE InsertarPersonajeEquipamiento;
END

GO

CREATE PROCEDURE InsertarPersonajeEquipamiento
    @ID_Personaje INT,         -- ID del personaje
    @ID_Equipamiento INT,      -- ID del equipamiento a asignar
    @Nivel INT                 -- Nivel inicial del equipamiento
AS
BEGIN
    DECLARE @NivelRequerido INT;
    DECLARE @NivelPersonaje INT;

    -- Obtener el nivel requerido del equipamiento
    SELECT @NivelRequerido = Nivel_requerido
    FROM Equipamientos
    WHERE ID = @ID_Equipamiento;

    -- Obtener el nivel actual del personaje
    SELECT @NivelPersonaje = Nivel
    FROM Personajes
    WHERE ID = @ID_Personaje;

    -- Verificar si el nivel del personaje cumple con el nivel requerido
    IF @NivelPersonaje >= @NivelRequerido
    BEGIN
        -- Realiza la inserción en la tabla Personajes_Equipamientos
        INSERT INTO Personajes_Equipamientos (ID_Personaje, ID_Equipamiento, Nivel)
        VALUES (@ID_Personaje, @ID_Equipamiento, @Nivel);
        
        PRINT 'Equipamiento asignado correctamente.';
    END
    ELSE
    BEGIN
        PRINT 'El nivel del personaje es insuficiente para desbloquear este equipamiento.';
    END
END;



GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SubirNivelPersonaje_equipamiento')
BEGIN
    -- Si existe, eliminar el procedimiento almacenado
    DROP PROCEDURE SubirNivelPersonaje_equipamiento;
END

GO
CREATE PROCEDURE SubirNivelPersonaje_equipamiento
    @ID_Personaje INT,         -- ID del personaje
    @IncrementoNivel INT,      -- Incremento del nivel del personaje
    @ID_Equipamiento INT       -- ID del equipamiento que se va a incrementar (o desbloquear)
AS
BEGIN
    -- Declarar variables locales para el nivel actual del personaje
    DECLARE @NivelActual INT;
    DECLARE @NivelRequerido INT;

    -- Obtener el nivel actual del personaje
    SELECT @NivelActual = Nivel
    FROM Personajes
    WHERE ID = @ID_Personaje;
    
    -- Verificamos si el personaje existe y si el incremento es positivo
    IF @NivelActual IS NOT NULL AND @IncrementoNivel > 0
    BEGIN
        -- Actualizar el nivel del personaje
        UPDATE Personajes
        SET Nivel = @NivelActual + @IncrementoNivel
        WHERE ID = @ID_Personaje;
        
        PRINT 'Nivel del personaje actualizado correctamente.';

        -- Obtener el nivel requerido para el equipamiento
        SELECT @NivelRequerido = Nivel_Requerido
        FROM Equipamientos
        WHERE ID = @ID_Equipamiento;

        -- Verificar si el personaje tiene el equipamiento especificado y si ya tiene acceso a ese equipamiento
        IF EXISTS (SELECT 1 FROM Personajes_Equipamientos WHERE ID_Personaje = @ID_Personaje AND ID_Equipamiento = @ID_Equipamiento)
        BEGIN
            -- Si el personaje ya tiene el equipamiento, actualizar su nivel
            UPDATE Personajes_Equipamientos
            SET Nivel = Nivel + @IncrementoNivel
            WHERE ID_Personaje = @ID_Personaje AND ID_Equipamiento = @ID_Equipamiento;
            
            PRINT 'Equipamiento seleccionado y actualizado correctamente.';
        END
        ELSE
        BEGIN
           -- Si el personaje no tiene el equipamiento, verificamos si con el nuevo nivel puede desbloquearlo
			IF (@NivelActual + @IncrementoNivel) >= @NivelRequerido
				BEGIN
				-- Si el personaje alcanza el nivel requerido, insertar el equipamiento con el incremento aplicado
					INSERT INTO Personajes_Equipamientos (ID_Personaje, ID_Equipamiento, Nivel)
					VALUES (@ID_Personaje, @ID_Equipamiento, @IncrementoNivel);
					PRINT 'Equipamiento desbloqueado y asignado al personaje con el nivel correspondiente.';
				END
				ELSE
				BEGIN
					PRINT 'El personaje no tiene el nivel suficiente para desbloquear este equipamiento.';
				END

			END
		END
		ELSE
	    BEGIN
			 PRINT 'No se pudo actualizar el nivel del personaje.';
		 END
END;

GO
-- Insertar datos ficticios en las tablas


INSERT INTO Jugadores (Nombre, Nivel)
VALUES 
('Marcos', 1),
('Lucas', 5),
('Tadeo', 3),
('Sofia', 4),
('Andrea', 6);

INSERT INTO Personajes (Nombre, Clase, Nivel, ID_Jugador)
VALUES 
('Ardan el Guerrero', 'Guerrero', 1, 1),  
('Eryndor el Hechicero', 'Mago', 5, 2),      
('Kael el Arquero', 'Arquero', 3, 3),    
('Thalion el Druida', 'Druida', 4, 4),     
('Astrid la Hechicera', 'Mago', 6, 5);   


INSERT INTO Habilidades (Nombre, Tipo, Nivel_requerido)
VALUES 
('Golpe Aplastante', 'Ataque', 1),
('Rayo Arcano', 'Hechizo', 2),
('Flecha Explosiva', 'Ataque', 3),
('Mano Sanadora', 'Hechizo', 1),
('Lluvia Ácida', 'Hechizo', 4),
('Tajo Mortal', 'Ataque', 6);


INSERT INTO Equipamientos(Tipo, Bonificación, Nivel_requerido)
VALUES
-- Equipamientos Nivel 1 (default)
('Daga de Hierro', 'Aumenta ataque en 10', 1),
('Escudo de Roble', 'Aumenta defensa en 5', 1),
('Capa de Algodón', 'Aumenta evasión en 3', 1),

-- Equipamientos para desbloquear a niveles superiores
('Espada de Plata', 'Aumenta ataque en 25', 2),
('Báculo de Roble', 'Aumenta daño mágico en 15', 2),
('Armadura de Cuero', 'Aumenta defensa en 10', 2),
('Arco Largo', 'Aumenta precisión en 18', 3),
('Cloak of Flames', 'Aumenta evasión en 15', 4),
('Anillo de Sabiduría', 'Aumenta regeneración de mana', 5),
('Hacha del Berserker', 'Aumenta ataque en 35', 6);


-- Insertar múltiples registros con el procedimiento almacenado
EXEC InsertarPersonajeHabilidad @ID_Personaje = 1, @ID_Habilidad = 1, @Nivel = 1;  -- "Ardan el Guerrero" tiene la habilidad "Golpe Aplastante"
EXEC InsertarPersonajeHabilidad @ID_Personaje = 1, @ID_Habilidad = 4, @Nivel = 1;  -- "Ardan el Guerrero" tiene la habilidad "Mano Sanadora"
EXEC InsertarPersonajeHabilidad @ID_Personaje = 1, @ID_Habilidad = 6, @Nivel = 2;  -- Caso especial donde no  "Ardan el Guerrero" no puede adquirir dicha habilidad
EXEC InsertarPersonajeHabilidad @ID_Personaje = 2, @ID_Habilidad = 2, @Nivel = 3;  -- "Eryndor el Hechicero" tiene la habilidad "Rayo Arcano"
EXEC InsertarPersonajeHabilidad @ID_Personaje = 2, @ID_Habilidad = 4, @Nivel = 3;  -- "Eryndor el Hechicero" tiene la habilidad "Mano Sanadora" 
EXEC InsertarPersonajeHabilidad @ID_Personaje = 3, @ID_Habilidad = 3, @Nivel = 3;  -- "Kael el Arquero" tiene la habilidad "Flecha Explosiva" 
EXEC InsertarPersonajeHabilidad @ID_Personaje = 4, @ID_Habilidad = 5, @Nivel = 4;  -- "Thalion el Druida" tiene la habilidad "Lluvia Ácida"
EXEC InsertarPersonajeHabilidad @ID_Personaje = 5, @ID_Habilidad = 6, @Nivel = 6;  -- "Astrid la Hechicera" tiene la habilidad "Tajo Mortal"

-- Aumentar nivel de jugador y habilidad

EXEC SubirNivelPersonaje_habilidad 
    @ID_Personaje = 1, 
    @IncrementoNivel = 2, 
    @ID_Habilidad = 1;

EXEC SubirNivelPersonaje_habilidad 
    @ID_Personaje = 1, 
    @IncrementoNivel = 2, 
    @ID_Habilidad = 6; 


-- Asignar equipamiento a personajes
EXEC InsertarPersonajeEquipamiento @ID_Personaje = 1, @ID_Equipamiento = 1, @Nivel = 1;  
EXEC InsertarPersonajeEquipamiento @ID_Personaje = 1, @ID_Equipamiento = 2, @Nivel = 1;
EXEC InsertarPersonajeEquipamiento @ID_Personaje = 1, @ID_Equipamiento = 10, @Nivel = 1;-- [ERROR - Caso Especial]
EXEC InsertarPersonajeEquipamiento @ID_Personaje = 2, @ID_Equipamiento = 2, @Nivel = 1; 
EXEC InsertarPersonajeEquipamiento @ID_Personaje = 2, @ID_Equipamiento = 3, @Nivel = 1; 
EXEC InsertarPersonajeEquipamiento @ID_Personaje = 3, @ID_Equipamiento = 1, @Nivel = 1;  
EXEC InsertarPersonajeEquipamiento @ID_Personaje = 3, @ID_Equipamiento = 3, @Nivel = 1;  
EXEC InsertarPersonajeEquipamiento @ID_Personaje = 4, @ID_Equipamiento = 2, @Nivel = 1;  
EXEC InsertarPersonajeEquipamiento @ID_Personaje = 4, @ID_Equipamiento = 3, @Nivel = 1; 
EXEC InsertarPersonajeEquipamiento @ID_Personaje = 5, @ID_Equipamiento = 1, @Nivel = 1;  



-- Aumentar nivel de jugador y equipamiento
EXEC SubirNivelPersonaje_equipamiento 
    @ID_Personaje = 3, 
    @IncrementoNivel = 1, 
    @ID_Equipamiento = 1;

EXEC SubirNivelPersonaje_equipamiento 
    @ID_Personaje = 3, 
    @IncrementoNivel = 1, 
    @ID_Equipamiento = 10; 


--Salida

-- Ver los jugadores
SELECT * FROM Jugadores;

-- Ver los personajes
SELECT * FROM Personajes;

-- Ver las habilidades
SELECT * FROM Habilidades;

-- Ver el equipamiento
SELECT * FROM Equipamientos;

-- Ver el equipamiento asignado

SELECT * FROM Personajes_Equipamientos;

-- Ver las relaciones de habilidades con los personajes
SELECT * FROM Personajes_Habilidades;



