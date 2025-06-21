USE Vinito;
GO

/* Indices No Agruapdos : buscar columnas
que no son claves primarias */

-- Buscar por nombre de la tabla "Productos"
CREATE NONCLUSTERED INDEX idx_producto_nombre
ON Producto(nombre);
--Prueba 
SELECT * FROM Producto WHERE nombre = 'Malbec Reserva';


/* Indices Unicos : que no se repitan los
valores en una columna */

--Aseguramos que los documentos de identidad seasn unicos DNI
CREATE UNIQUE NONCLUSTERED INDEX idx_persona_documento_unico
ON Persona(id_documento, numero_documento);
-- Prueba con DNI duplicado 
INSERT INTO Persona (nombre, id_documento, numero_documento, tipo_persona, correo, telefono, direccion)
VALUES (' Duplicado', 1, '12345678', 'Cliente', 'duplicado@gmail.com', '999999999', 'Dirección X');
-- Prueba con DNI diferente 
INSERT INTO Persona (nombre, id_documento, numero_documento, tipo_persona, correo, telefono, direccion)
VALUES ('Nuevo', 1, '87654321', 'Cliente', 'nuevo_dni@gmail.com', '888888888', 'Dirección Y');



--Aseguramos que los correo de las personas sean unicos 
CREATE UNIQUE NONCLUSTERED INDEX idx_persona_correo_unico
ON Persona(correo);
--Prueba con correo duplicado 
INSERT INTO Persona (nombre, id_documento, numero_documento, tipo_persona, correo, telefono, direccion)
VALUES (' Duplicada', 1, '9', 'Cliente', 'carlos@gmail.com', '000000000', 'Calle Falsa 123');
--Prueba con otro correo 
INSERT INTO Persona (nombre, id_documento, numero_documento, tipo_persona, correo, telefono, direccion)
VALUES ('Nuevo', 1, '8', 'Cliente', 'nuevo@gmail.com', '111111111', 'Nueva Calle 456');

--Verificar si existe 
SELECT * FROM Persona
WHERE correo = 'nuevo@gmail.com'
   OR (id_documento = 1 AND numero_documento = '8');
--Eliminarlo 
DELETE FROM Persona
WHERE correo = 'nuevo@gmail.com'
   OR (id_documento = 1 AND numero_documento = '8');


/* Indice Compuestos : combina dos o mas columnas */

--Busqueda por "id_producto" y "tipo_producto"
CREATE NONCLUSTERED INDEX idx_producto_tipo
ON Producto(id_categoria, tipo_producto);
--Prueba 
SELECT * FROM Producto
WHERE id_categoria = 1 AND tipo_producto = 'Vino';

--Busqueda por "id_categoria" y "tipo_producto" 
CREATE NONCLUSTERED INDEX idx_producto_tipo
ON Producto(id_categoria, tipo_producto);
-- Prueba 
SELECT * FROM Producto
WHERE id_categoria = 1 AND tipo_producto = 'Vino';

--Verificar si existe
EXEC sp_helpindex 'Producto';
--Eliminar
DROP INDEX idx_producto_tipo ON Producto;



/*Verificamos indices creados */
-- Solo de la tabla Productos 
EXEC sp_helpindex 'Producto';
EXEC sp_helpindex 'Persona';


/* Eliminar Indices Creados :
solo borramos los que no son PK o FK */

--Eliminamos 
DROP INDEX idx_producto_nombre ON Producto;
DROP INDEX idx_persona_correo_unico ON Persona;
DROP INDEX idx_producto_tipo ON Producto;