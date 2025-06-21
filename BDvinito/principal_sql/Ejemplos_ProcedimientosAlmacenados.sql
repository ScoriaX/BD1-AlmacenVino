USE Vinito;
GO

-- INSERTAR DOCUMENTO
EXEC InsertarDocumentoIdentidad 
    @id_documento = 1, 
    @tipo_documento = 'DNI', 
    @longitud = 8;

-- MODIFICAR DOCUMENTO
EXEC ModificarDocumentoIdentidad 
    @id_documento = 1, 
    @tipo_documento = 'Documento Nacional de Identidad', 
    @longitud = 8;

-- ELIMINAR DOCUMENTO
EXEC EliminarDocumentoIdentidad 
    @id_documento = 1;

-- INSERTAR PERSONA
EXEC InsertarPersona 
    @nombre = 'Piero', 
    @apellido_paterno = 'Poblete', 
    @apellido_materno = 'Andia', 
    @id_documento = 1, 
    @numero_documento = '72439496', 
    @tipo_persona = 'Cliente', 
    @correo = 'ppobletea@gmail.com', 
    @telefono = '965117966', 
    @direccion = 'Guardia Civil';

-- MODIFICAR PERSONA
EXEC ModificarPersona 
    @id_persona = 1,
    @nombre = 'Luis Alberto', 
    @apellido_paterno = 'Ramírez', 
    @apellido_materno = 'Soto', 
    @correo = 'luis_actualizado@gmail.com', 
    @telefono = '999888777', 
    @direccion = 'Av. Actualizada 456';

-- ELIMINAR PERSONA
EXEC EliminarPersona 
    @id_persona = 1;

-- INSERTAR CATEGORÍA
EXEC InsertarCategoria 
    @nombre_categoria = 'Bebidas Alcohólicas', 
    @descripcion = 'Todo tipo de bebidas con contenido alcohólico.';

-- MODIFICAR CATEGORÍA
EXEC ModificarCategoria 
    @id_categoria = 1,
    @nombre_categoria = 'Bebidas Premium',
    @descripcion = 'Bebidas alcohólicas de alta gama.';

-- ELIMINAR CATEGORÍA
EXEC EliminarCategoria 
    @id_categoria = 1;

-- INSERTAR BEBIDA ALCOHÓLICA
EXEC InsertarBebidaAlcoholica
    @nombre = 'Pisco Acholado',
    @descripcion = 'Bebida alcohólica destilada de uvas, típica del Perú.',
    @precio_compra = 18.50,
    @precio_venta = 30.00,
    @stock_actual = 100,
    @id_categoria = 1, 
    @tipo_bebida = 'Pisco',
    @fecha_elaboracion = '2023-08-15',
    @pais_origen = 'Perú',
    @productor = 'Bodega San Isidro',
    @grado_alcohol = 42.0;

-- INSERTAR ACCESORIO
EXEC InsertarAccesorio
    @nombre = 'Copa de Vino Tinto',
    @descripcion = 'Copa diseñada para resaltar los aromas del vino tinto.',
    @precio_compra = 3.50,
    @precio_venta = 6.90,
    @stock_actual = 50,
    @id_categoria = 2,
    @material = 'Cristal',
    @color = 'Transparente',
    @dimensiones = '22cm x 8cm',
    @tipo_accesorio = 'Copa';


-- MODIFICAR PRODUCTO
EXEC ModificarProducto
    @id_producto = 1,
    @nombre = 'Pisco Italia',
    @descripcion = 'Pisco aromático de uva Italia',
    @precio_compra = 14.00,
    @precio_venta = 22.00,
    @stock_actual = 80,
    @id_categoria = 1,
    @tipo_producto = 'Bebida';

-- ELIMINAR PRODUCTO
EXEC EliminarProducto 
    @id_producto = 1;

-- REGISTRAR ENTRADA
EXEC RegistrarEntradaProducto 
    @id_proveedor = 2, 
    @fecha = '2025-06-21', 
    @tipo_entrada = 'Compra', 
    @id_producto = 1, 
    @cantidad = 30, 
    @precio_unitario = 12.50;

-- ELIMINAR ENTRADA
EXEC EliminarEntradaProducto 
    @id_entrada = 1;

-- REGISTRAR VENTA
EXEC RegistrarVenta 
    @id_cliente = 1,
    @fecha = '2025-06-21',
    @metodo_pago = 'Efectivo',
    @id_producto = 1,
    @cantidad = 2,
    @precio_unitario = 20.00;

-- ELIMINAR VENTA
EXEC EliminarVenta 
    @id_venta = 1;

-- REPORTE CLIENTES
EXEC ReporteClientes;

-- REPORTE PRODUCTOS EN STOCK
EXEC ReporteProductosEnStock;

-- REPORTE VENTAS
EXEC ReporteVentas;

-- REPORTE ENTRADAS
EXEC ReporteEntradas;
