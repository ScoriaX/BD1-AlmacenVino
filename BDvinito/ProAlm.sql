USE Vinito;
GO

-- Insertar Cliente
CREATE PROCEDURE InsertarCliente
    @nombre VARCHAR(50),
    @apellido_paterno VARCHAR(50),
    @apellido_materno VARCHAR(50),
    @id_documento INT,
    @numero_documento VARCHAR(15),
    @correo VARCHAR(50),
    @telefono VARCHAR(15),
    @direccion VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @id_persona INT;

    INSERT INTO Persona (
        nombre, 
        apellido_paterno, 
        apellido_materno,
        id_documento, 
        numero_documento, 
        tipo_persona, 
        correo, 
        telefono, 
        direccion
    )
    VALUES (
        @nombre, 
        @apellido_paterno, 
        @apellido_materno,
        @id_documento, 
        @numero_documento, 
        'Cliente', 
        @correo, 
        @telefono, 
        @direccion
    );

    SET @id_persona = SCOPE_IDENTITY();

    INSERT INTO Cliente (id_persona)
    VALUES (@id_persona);
END;
GO

-- Registrar entrada de producto al almacén
CREATE PROCEDURE RegistrarEntradaProducto
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

    -- Insertar Entrada (total inicial en 0)
    INSERT INTO Entrada (id_persona, fecha, tipo_entrada, total)
    VALUES (@id_proveedor, @fecha, @tipo_entrada, 0);

    SET @id_entrada = SCOPE_IDENTITY();

    -- Insertar DetalleEntrada
    INSERT INTO DetalleEntrada (
        id_entrada,
        id_producto,
        cantidad,
        precio_unitario,
        subtotal
    )
    VALUES (
        @id_entrada,
        @id_producto,
        @cantidad,
        @precio_unitario,
        @subtotal
    );

    -- Actualizar total en Entrada
    UPDATE Entrada
    SET total = total + @subtotal
    WHERE id_entrada = @id_entrada;

    -- Actualizar stock del producto
    UPDATE Producto
    SET stock_actual = stock_actual + @cantidad
    WHERE id_producto = @id_producto;
END;
GO

-- Registrar Vino
CREATE PROCEDURE RegistrarVino
    @nombre VARCHAR(50),
    @descripcion TEXT,
    @precio_compra MONEY,
    @precio_venta MONEY,
    @stock_actual INT,
    @id_categoria INT,
    @cepa VARCHAR(30),
    @anio_cosecha DATE,
    @pais_origen VARCHAR(30),
    @bodega VARCHAR(30),
    @grado_alcohol DECIMAL(4,2)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @id_producto INT;

    -- Insertar en Producto
    INSERT INTO Producto (
        nombre,
        descripcion,
        precio_compra,
        precio_venta,
        stock_actual,
        id_categoria,
        tipo_producto
    )
    VALUES (
        @nombre,
        @descripcion,
        @precio_compra,
        @precio_venta,
        @stock_actual,
        @id_categoria,
        'Vino'
    );

    SET @id_producto = SCOPE_IDENTITY();

    -- Insertar en Vino
    INSERT INTO Vino (
        id_producto,
        cepa,
        año_cosecha,
        pais_origen,
        bodega,
        grado_alcohol
    )
    VALUES (
        @id_producto,
        @cepa,
        @anio_cosecha,
        @pais_origen,
        @bodega,
        @grado_alcohol
    );
END;
GO
