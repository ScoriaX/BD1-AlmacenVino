USE Vinito;
GO

-- Insertar cliente
EXEC InsertarCliente 
    @nombre = 'Juan',
    @apellido_paterno = 'Perez',
    @apellido_materno = 'Gonzalez',
    @id_documento = 1,
    @numero_documento = '72439496',
    @correo = 'a@gmail.com',
    @telefono = '965117966',
    @direccion = 'Calle la Alegría';

-- Verificar
SELECT * FROM Persona;

-- Registrar entrada de producto
EXEC RegistrarEntradaProducto 
    @id_proveedor = 3,
    @fecha = '2025-05-30',
    @tipo_entrada = 'Compra',
    @id_producto = 1,
    @cantidad = 50,
    @precio_unitario = 15.50;

-- Verificar
SELECT * FROM Entrada;
SELECT * FROM DetalleEntrada;

-- Registrar vino
EXEC RegistrarVino
    @nombre = 'Vino Cabernet Sauvignon',
    @descripcion = 'Vino tinto seco con notas a frutos rojos.',
    @precio_compra = 9.00,
    @precio_venta = 15.00,
    @stock_actual = 100,
    @id_categoria = 1,
    @cepa = 'Cabernet Sauvignon',
    @anio_cosecha = '2021-01-01',
    @pais_origen = 'Chile',
    @bodega = 'Viña Concha y Toro',
    @grado_alcohol = 13.5;

-- Verificar
SELECT * FROM Vino;