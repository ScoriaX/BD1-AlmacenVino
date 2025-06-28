USE Vinito;
GO

-- INSERTAR DOCUMENTO
CREATE PROCEDURE InsertarDocumentoIdentidad
    @id_documento INT,
    @tipo_documento VARCHAR(30),
    @longitud INT
AS
BEGIN
    SET NOCOUNT ON;

-- VALIDAR EXISTENCIA
    IF EXISTS (SELECT 1 FROM DocumentoIdentidad WHERE id_documento = @id_documento)
    BEGIN
        RAISERROR('El ID del documento ya existe.', 16, 1);
        RETURN;
    END;

-- INSERTAR DOCUMENTO
    INSERT INTO DocumentoIdentidad (id_documento, tipo_documento, longitud)
    VALUES (@id_documento, @tipo_documento, @longitud);
END;
GO

-- MODIFICAR DOCUMENTO
CREATE PROCEDURE ModificarDocumentoIdentidad
    @id_documento INT,
    @tipo_documento VARCHAR(30),
    @longitud INT
AS
BEGIN
    SET NOCOUNT ON;

-- VALIDAR EXISTENCIA
    IF NOT EXISTS (SELECT 1 FROM DocumentoIdentidad WHERE id_documento = @id_documento)
    BEGIN
        RAISERROR('El documento no existe.', 16, 1);
        RETURN;
    END;

-- MODIFICAR DOCUMENTO
    UPDATE DocumentoIdentidad
    SET tipo_documento = @tipo_documento,
        longitud = @longitud
    WHERE id_documento = @id_documento;
END;
GO

-- ELIMINAR DOCUMENTO
CREATE PROCEDURE EliminarDocumentoIdentidad
    @id_documento INT
AS
BEGIN
    SET NOCOUNT ON;

-- VALIDAR USO EN PERSONA
    IF EXISTS (
        SELECT 1 FROM Persona WHERE id_documento = @id_documento
    )
    BEGIN
        RAISERROR('No se puede eliminar: el documento está en uso por alguna persona.', 16, 1);
        RETURN;
    END;

-- ELIMINAR DOCUMENTO
    DELETE FROM DocumentoIdentidad WHERE id_documento = @id_documento;
END;
GO

-- INSERTAR PERSONA
CREATE PROCEDURE InsertarPersona
    @nombre VARCHAR(50),
    @apellido_paterno VARCHAR(50),
    @apellido_materno VARCHAR(50),
    @id_documento INT,
    @numero_documento VARCHAR(15),
    @tipo_persona VARCHAR(20),
    @correo VARCHAR(50),
    @telefono VARCHAR(15),
    @direccion VARCHAR(100),
    @empresa VARCHAR(100) = NULL,
	@fecha_contratacion DATE = NULL,
    @puesto VARCHAR(50) = NULL,
    @salario MONEY = NULL
AS
BEGIN
    SET NOCOUNT ON;

-- VALIDAR
    IF EXISTS (
        SELECT 1 
        FROM Persona 
        WHERE id_documento = @id_documento AND numero_documento = @numero_documento
    )
    BEGIN
        RAISERROR('Ya existe una persona con ese documento.', 16, 1);
        RETURN;
    END;

-- INSERTAR EN PERSONA
    INSERT INTO Persona (
        nombre, apellido_paterno, apellido_materno,
        id_documento, numero_documento, tipo_persona,
        correo, telefono, direccion
    )
    VALUES (
        @nombre, @apellido_paterno, @apellido_materno,
        @id_documento, @numero_documento, @tipo_persona,
        @correo, @telefono, @direccion
    );

    DECLARE @id_persona INT = SCOPE_IDENTITY();

-- INSERTAR EN CLIENTE O PROVEEDOR
    IF @tipo_persona = 'Cliente'
    BEGIN
        INSERT INTO Cliente (id_persona, fecha_registro)
        VALUES (@id_persona, GETDATE());
    END
    ELSE IF @tipo_persona = 'Proveedor'
    BEGIN
        INSERT INTO Proveedor (id_persona, empresa)
        VALUES (@id_persona, @empresa);
    END
	ELSE IF @tipo_persona = 'Empleado'
    BEGIN
        INSERT INTO Empleado (id_persona, fecha_contratacion, puesto, salario)
        VALUES (@id_persona, @fecha_contratacion, @puesto, @salario);
    END
END;
GO

-- MODIFICAR PERSONA
CREATE PROCEDURE ModificarPersona
    @id_persona INT,
    @nombre VARCHAR(50),
    @apellido_paterno VARCHAR(50),
    @apellido_materno VARCHAR(50),
    @correo VARCHAR(50),
    @telefono VARCHAR(15),
    @direccion VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    -- VALIDAR
    IF NOT EXISTS (SELECT 1 FROM Persona WHERE id_persona = @id_persona)
    BEGIN
        RAISERROR('La persona no existe.', 16, 1);
        RETURN;
    END;

    -- ACTUALIZAR
    UPDATE Persona
    SET nombre = @nombre,
        apellido_paterno = @apellido_paterno,
        apellido_materno = @apellido_materno,
        correo = @correo,
        telefono = @telefono,
        direccion = @direccion
    WHERE id_persona = @id_persona;
END;
GO

-- ELIMINAR PERSONA
CREATE PROCEDURE EliminarPersona
    @id_persona INT
AS
BEGIN
    SET NOCOUNT ON;

-- VALIDAR
    IF NOT EXISTS (SELECT 1 FROM Persona WHERE id_persona = @id_persona)
    BEGIN
        RAISERROR('La persona no existe.', 16, 1);
        RETURN;
    END;

-- ELIMINAR DE CLIENTE SI EXISTE
    IF EXISTS (SELECT 1 FROM Cliente WHERE id_persona = @id_persona)
    BEGIN
        DELETE FROM Cliente WHERE id_persona = @id_persona;
    END;

-- ELIMINAR DE PROVEEDOR SI EXISTE
    IF EXISTS (SELECT 1 FROM Proveedor WHERE id_persona = @id_persona)
    BEGIN
        DELETE FROM Proveedor WHERE id_persona = @id_persona;
    END;

-- ELIMINAR DE PERSONA
    DELETE FROM Persona WHERE id_persona = @id_persona;
END;
GO

-- INSERTAR CATEGORIA
CREATE PROCEDURE InsertarCategoria
    @nombre_categoria VARCHAR(30),
    @descripcion TEXT
AS
BEGIN
    SET NOCOUNT ON;

-- VALIDAR
    IF EXISTS (SELECT 1 FROM Categoria WHERE nombre_categoria = @nombre_categoria)
    BEGIN
        RAISERROR('Ya existe una categoría con ese nombre.', 16, 1);
        RETURN;
    END

-- INSERTAR
    INSERT INTO Categoria (nombre_categoria, descripcion)
    VALUES (@nombre_categoria, @descripcion);
END;
GO

-- MODIIFCAR CATEGORIA
CREATE PROCEDURE ModificarCategoria
    @id_categoria INT,
    @nuevo_nombre VARCHAR(30),
    @nueva_descripcion TEXT
AS
BEGIN
    SET NOCOUNT ON;

-- VALIDAR
    IF NOT EXISTS (SELECT 1 FROM Categoria WHERE id_categoria = @id_categoria)
    BEGIN
        RAISERROR('Categoría no encontrada.', 16, 1);
        RETURN;
    END

-- MODIFICAR
    UPDATE Categoria
    SET nombre_categoria = @nuevo_nombre,
        descripcion = @nueva_descripcion
    WHERE id_categoria = @id_categoria;
END;
GO

-- ELIMINAR CATEGORIA
CREATE PROCEDURE EliminarCategoria
    @id_categoria INT
AS
BEGIN
    SET NOCOUNT ON;

-- VALIDAR CATEGORIA
    IF NOT EXISTS (SELECT 1 FROM Categoria WHERE id_categoria = @id_categoria)
    BEGIN
        RAISERROR('La categoría no existe.', 16, 1);
        RETURN;
    END

-- VALIDAR PRODUCTOS RELACIONADOS
    IF EXISTS (SELECT 1 FROM Producto WHERE id_categoria = @id_categoria)
    BEGIN
        RAISERROR('No se puede eliminar: hay productos asociados a esta categoría.', 16, 1);
        RETURN;
    END

-- ELIMINAR
    DELETE FROM Categoria WHERE id_categoria = @id_categoria;
END;
GO

--INSERTAR BEBIDA
CREATE PROCEDURE InsertarBebidaAlcoholica
    @nombre VARCHAR(50),
    @descripcion TEXT,
    @precio_compra MONEY,
    @precio_venta MONEY,
    @stock_actual INT,
    @id_categoria INT,
    @tipo_bebida VARCHAR(30),
    @fecha_elaboracion DATE,
    @pais_origen VARCHAR(30),
    @productor VARCHAR(50),
    @grado_alcohol DECIMAL(4,2)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @id_producto INT;

-- INSERTAR EN PRODUCTO
    INSERT INTO Producto (
        nombre, descripcion, precio_compra, precio_venta,
        stock_actual, id_categoria, tipo_producto
    )
    VALUES (
        @nombre, @descripcion, @precio_compra, @precio_venta,
        @stock_actual, @id_categoria, 'Bebida Alcoholica'
    );

    SET @id_producto = SCOPE_IDENTITY();

-- INSERTAR EN BEBIDA
    INSERT INTO BebidaAlcoholica (
        id_producto, tipo_bebida, fecha_elaboracion, pais_origen, productor, grado_alcohol
    )
    VALUES (
        @id_producto, @tipo_bebida, @fecha_elaboracion, @pais_origen, @productor, @grado_alcohol
    );
END;
GO

-- INSERTAR ACCESORIO
CREATE PROCEDURE InsertarAccesorio
    @nombre VARCHAR(50),
    @descripcion TEXT,
    @precio_compra MONEY,
    @precio_venta MONEY,
    @stock_actual INT,
    @id_categoria INT,
    @material VARCHAR(50),
    @color VARCHAR(30),
    @dimensiones VARCHAR(50),
    @tipo_accesorio VARCHAR(30)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @id_producto INT;

-- INSERATR EN PRODUCTO
    INSERT INTO Producto (
        nombre, descripcion, precio_compra, precio_venta,
        stock_actual, id_categoria, tipo_producto
    )
    VALUES (
        @nombre, @descripcion, @precio_compra, @precio_venta,
        @stock_actual, @id_categoria, 'Accesorio'
    );

    SET @id_producto = SCOPE_IDENTITY();

-- INSERTAR EN ACCESORIO
    INSERT INTO Accesorio (
        id_producto, material, color, dimensiones, tipo_accesorio
    )
    VALUES (
        @id_producto, @material, @color, @dimensiones, @tipo_accesorio
    );
END;
GO

-- MODIFICAR PRODUCTO
CREATE PROCEDURE ModificarProducto
    @id_producto INT,
    @nombre VARCHAR(50),
    @descripcion TEXT,
    @precio_compra MONEY,
    @precio_venta MONEY,
    @stock_actual INT,
    @id_categoria INT,
    @tipo_producto VARCHAR(30)
AS
BEGIN
    SET NOCOUNT ON;

-- VALIDAR
    IF NOT EXISTS (SELECT 1 FROM Producto WHERE id_producto = @id_producto)
    BEGIN
        RAISERROR('El producto no existe.', 16, 1);
        RETURN;
    END

-- MODIFICAR
    UPDATE Producto
    SET nombre = @nombre,
        descripcion = @descripcion,
        precio_compra = @precio_compra,
        precio_venta = @precio_venta,
        stock_actual = @stock_actual,
        id_categoria = @id_categoria,
        tipo_producto = @tipo_producto
    WHERE id_producto = @id_producto;
END;
GO

-- ELIMINAR PRODUCTO
CREATE PROCEDURE EliminarProducto
    @id_producto INT
AS
BEGIN
    SET NOCOUNT ON;

-- VALIDAR
    IF NOT EXISTS (SELECT 1 FROM Producto WHERE id_producto = @id_producto)
    BEGIN
        RAISERROR('El producto no existe.', 16, 1);
        RETURN;
    END

-- MODIFICAR
    DELETE FROM Producto WHERE id_producto = @id_producto;
END;
GO

--REGISTRAR ENTRADA
CREATE PROCEDURE RegistrarEntrada
    @id_proveedor INT,
    @fecha DATE,
    @tipo_entrada VARCHAR(30),
    @id_producto INT,
    @cantidad INT,
    @precio_unitario MONEY
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @subtotal MONEY = @cantidad * @precio_unitario;
    DECLARE @id_entrada INT;

-- VALIDAR PROVEEDOR
    IF NOT EXISTS (
        SELECT 1 FROM Proveedor WHERE id_persona = @id_proveedor
    )
    BEGIN
        RAISERROR('Proveedor no registrado.', 16, 1);
        RETURN;
    END;

-- VALIDAR PRODUCTO
    IF NOT EXISTS (
        SELECT 1 FROM Producto WHERE id_producto = @id_producto
    )
    BEGIN
        RAISERROR('Producto no registrado.', 16, 1);
        RETURN;
    END;

-- INSERTAR ENTRADA
    INSERT INTO Entrada (id_persona, fecha, tipo_entrada, total)
    VALUES (@id_proveedor, @fecha, @tipo_entrada, 0);

    SET @id_entrada = SCOPE_IDENTITY();

-- INSERTAR DETALLE
    INSERT INTO DetalleEntrada (id_entrada, id_producto, cantidad, precio_unitario, subtotal)
    VALUES (@id_entrada, @id_producto, @cantidad, @precio_unitario, @subtotal);

-- ACTUALIZAR TOTAL
    UPDATE Entrada
    SET total = @subtotal
    WHERE id_entrada = @id_entrada;

-- ACTUALIZAR STOCK
    UPDATE Producto
    SET stock_actual = stock_actual + @cantidad
    WHERE id_producto = @id_producto;
END;
GO

-- ELIMINAR ENTRADA
CREATE PROCEDURE EliminarEntrada
    @id_entrada INT
AS
BEGIN
    SET NOCOUNT ON;

-- VALIDAR
    IF NOT EXISTS (SELECT 1 FROM Entrada WHERE id_entrada = @id_entrada)
    BEGIN
        RAISERROR('La entrada no existe.', 16, 1);
        RETURN;
    END;

-- REVERTIR STOCK
    UPDATE p
    SET p.stock_actual = p.stock_actual - de.cantidad
    FROM Producto p
    INNER JOIN DetalleEntrada de ON p.id_producto = de.id_producto
    WHERE de.id_entrada = @id_entrada;

-- ELIMINAR
    DELETE FROM DetalleEntrada WHERE id_entrada = @id_entrada;
    DELETE FROM Entrada WHERE id_entrada = @id_entrada;
END;
GO

-- REGISTRAR VENTA
CREATE PROCEDURE RegistrarVenta
    @id_cliente INT,
    @fecha DATE,
    @metodo_pago VARCHAR(30),
    @id_producto INT,
    @cantidad INT,
    @precio_unitario MONEY
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @subtotal MONEY = @cantidad * @precio_unitario;
    DECLARE @total MONEY = @subtotal;
    DECLARE @id_venta INT;

-- INSERTAR VENTA
    INSERT INTO Venta (id_persona, fecha, total, metodo_pago)
    VALUES (@id_cliente, @fecha, @total, @metodo_pago);

    SET @id_venta = SCOPE_IDENTITY();

-- INSERTAR DETALLE
    INSERT INTO DetalleVenta (id_venta, id_producto, cantidad, precio_unitario, subtotal)
    VALUES (@id_venta, @id_producto, @cantidad, @precio_unitario, @subtotal);

-- ACTUALIZAR STOCk
    UPDATE Producto
    SET stock_actual = stock_actual - @cantidad
    WHERE id_producto = @id_producto;
END;
GO

-- ELIMINAR VENTA
CREATE PROCEDURE EliminarVenta
    @id_venta INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @id_producto INT;
    DECLARE @cantidad INT;

-- OBTENER PRODUCTO Y CANTIDAD
    SELECT TOP 1
        @id_producto = id_producto,
        @cantidad = cantidad
    FROM DetalleVenta
    WHERE id_venta = @id_venta;

-- ACTUALIZAR STOCK
    UPDATE Producto
    SET stock_actual = stock_actual + @cantidad
    WHERE id_producto = @id_producto;

-- ELIMINAR DETALLE
    DELETE FROM DetalleVenta
    WHERE id_venta = @id_venta;

-- ELIMINAR VENTA
    DELETE FROM Venta
    WHERE id_venta = @id_venta;
END;
GO

-- REPORTE CLIENTES
CREATE PROCEDURE ReporteClientes
AS
BEGIN
    SELECT 
        p.id_persona,
        p.nombre + ' ' + p.apellido_paterno + ' ' + p.apellido_materno AS nombre_completo,
        p.numero_documento,
        p.correo,
        p.telefono,
        c.fecha_registro
    FROM Cliente c
    JOIN Persona p ON c.id_persona = p.id_persona;
END;
GO

-- REPORTE PROVEEDORES
CREATE PROCEDURE ReporteProveedores
AS
BEGIN
    SELECT 
        p.id_persona,
        p.nombre + ' ' + p.apellido_paterno + ' ' + p.apellido_materno AS nombre_completo,
        p.numero_documento,
        p.correo,
        p.telefono,
        pr.empresa
    FROM Proveedor pr
    JOIN Persona p ON pr.id_persona = p.id_persona;
END;
GO

-- REPORTE EMPLEADOS
CREATE PROCEDURE ReporteEmpleados
AS
BEGIN
    SELECT 
        p.id_persona,
        p.nombre + ' ' + p.apellido_paterno + ' ' + p.apellido_materno AS nombre_completo,
        p.numero_documento,
        p.correo,
        p.telefono,
        em.fecha_contratacion,
		em.puesto,
		em.salario
    FROM Empleado em
    JOIN Persona p ON em.id_persona = p.id_persona;
END;
GO

-- REPORTE PRODUCTOS EN STOCK
CREATE PROCEDURE ReporteProductosEnStock
AS
BEGIN
    SELECT 
        id_producto,
        nombre,
        tipo_producto,
        stock_actual,
        precio_venta
    FROM Producto
    WHERE stock_actual > 0;
END;
GO

-- REPORTE VENTAS
CREATE PROCEDURE ReporteVentas
AS
BEGIN
    SELECT 
        v.id_venta,
        v.fecha,
        p.nombre + ' ' + p.apellido_paterno + ' ' + p.apellido_materno AS cliente,
        pr.nombre AS producto,
        dv.cantidad,
        dv.precio_unitario,
        dv.subtotal,
        v.total,
        v.metodo_pago
    FROM Venta v
    JOIN Persona p ON v.id_persona = p.id_persona
    JOIN DetalleVenta dv ON v.id_venta = dv.id_venta
    JOIN Producto pr ON dv.id_producto = pr.id_producto;
END;
GO

-- REPORTE ENTRADAS
CREATE PROCEDURE ReporteEntradas
AS
BEGIN
    SELECT 
        e.id_entrada,
        e.fecha,
        pe.nombre + ' ' + pe.apellido_paterno + ' ' + pe.apellido_materno AS proveedor,
        pr.nombre AS producto,
        de.cantidad,
        de.precio_unitario,
        de.subtotal,
        e.total
    FROM Entrada e
    JOIN Persona pe ON e.id_persona = pe.id_persona
    JOIN DetalleEntrada de ON e.id_entrada = de.id_entrada
    JOIN Producto pr ON de.id_producto = pr.id_producto;
END;
GO

-- INSERTAR ROL
CREATE PROCEDURE InsertarRol
    @nombre_rol VARCHAR(50),
    @descripcion TEXT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM Rol WHERE nombre_rol = @nombre_rol)
    BEGIN
        RAISERROR('El rol ya existe.', 16, 1);
        RETURN;
    END;

    INSERT INTO Rol (nombre_rol, descripcion)
    VALUES (@nombre_rol, @descripcion);
END;
GO

-- INSERTAR PERMISO
CREATE PROCEDURE InsertarPermiso
    @nombre_permiso VARCHAR(50),
    @descripcion TEXT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM Permiso WHERE nombre_permiso = @nombre_permiso)
    BEGIN
        RAISERROR('El permiso ya existe.', 16, 1);
        RETURN;
    END;

    INSERT INTO Permiso (nombre_permiso, descripcion)
    VALUES (@nombre_permiso, @descripcion);
END;
GO

-- ASIGNAR PERMISO x ROL
CREATE PROCEDURE AsignarPermisoARol
    @id_rol INT,
    @id_permiso INT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1 FROM Rol_Permiso WHERE id_rol = @id_rol AND id_permiso = @id_permiso
    )
    BEGIN
        RAISERROR('El permiso ya está asignado al rol.', 16, 1);
        RETURN;
    END;

    INSERT INTO Rol_Permiso (id_rol, id_permiso)
    VALUES (@id_rol, @id_permiso);
END;
GO

-- ASIGNAR ROL A EMPLEADO
CREATE PROCEDURE AsignarRolAEmpleado
    @id_persona INT,
    @id_rol INT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1 FROM Empleado_Rol WHERE id_persona = @id_persona AND id_rol = @id_rol
    )
    BEGIN
        RAISERROR('El rol ya está asignado al empleado.', 16, 1);
        RETURN;
    END;

    INSERT INTO Empleado_Rol (id_persona, id_rol)
    VALUES (@id_persona, @id_rol);
END;
GO

-- MOSTRAR ROLES x EMPLEADO
CREATE PROCEDURE VerRolesEmpleado
    @id_persona INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT pe.id_persona, pe.nombre, pe.apellido_paterno, pe.apellido_materno ,r.id_rol, r.nombre_rol, r.descripcion
    FROM Rol r
    JOIN Empleado_Rol er ON r.id_rol = er.id_rol
	JOIN Persona pe ON e.id_persona = pe.id_persona
    WHERE er.id_persona = @id_persona;
END;
GO

-- MOSTRAR PERMISOS x EMPLEADO
CREATE PROCEDURE VerPermisosEmpleado
    @id_persona INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT p.id_permiso, p.nombre_permiso, p.descripcion
    FROM Permiso p
    JOIN Rol_Permiso rp ON p.id_permiso = rp.id_permiso
    JOIN Empleado_Rol er ON rp.id_rol = er.id_rol
    WHERE er.id_persona = @id_persona;
END;
GO
