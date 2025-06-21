USE Vinito;
GO

-- Insertar documentos
EXEC InsertarDocumentoIdentidad 1, 'DNI', 8;
EXEC InsertarDocumentoIdentidad 2, 'RUC', 11;

-- Insertar clientes
EXEC InsertarPersona 'Luis', 'Ramírez', 'Soto', 1, '12345678', 'Cliente', 'luis@gmail.com', '987654321', 'Av. Los Olivos', NULL;
EXEC InsertarPersona 'Ana', 'Torres', 'Flores', 1, '87654321', 'Cliente', 'ana@gmail.com', '912345678', 'Jr. Lima', NULL;

-- Insertar proveedores
EXEC InsertarPersona 'Carlos', 'Gutiérrez', 'Mendoza', 2, '20123456789', 'Proveedor', 'carlos@proveedores.com', '913456789', 'Av. Proveedores 123', 'Distribuciones SAC';
EXEC InsertarPersona 'Lucía', 'Reyes', 'Salas', 2, '20456789123', 'Proveedor', 'lucia@proveedores.com', '914567890', 'Calle Comercio 456', 'Importadora Lucía';

-- Insertar categorías
EXEC InsertarCategoria 'Bebidas Alcohólicas', 'Licores, vinos, y más';
EXEC InsertarCategoria 'Accesorios', 'Copas, sacacorchos, etc.';

-- Insertar productos
EXEC InsertarBebidaAlcoholica 'Pisco Quebranta', 'Pisco elaborado con uva quebranta', 15.00, 25.00, 50, 1, 'Pisco', '2023-01-15', 'Perú', 'Bodega La Caravedo', 43.0;
EXEC InsertarBebidaAlcoholica 'Vino Tinto Reserva', 'Vino tinto con cuerpo y aroma intenso', 20.00, 35.00, 40, 1, 'Vino', '2022-11-10', 'Chile', 'Concha y Toro', 13.5;

EXEC InsertarAccesorio 'Copa de Champán', 'Copa estrecha para espumantes', 2.50, 5.00, 60, 2, 'Cristal', 'Transparente', '20cm x 6cm', 'Copa';
EXEC InsertarAccesorio 'Sacacorchos Clásico', 'Herramienta para destapar botellas de vino', 3.00, 6.00, 30, 2, 'Acero Inoxidable', 'Plateado', '10cm x 3cm', 'Sacacorchos';

-- Registrar entradas
EXEC RegistrarEntrada 3, '2025-06-21', 'Compra', 1, 20, 15.00;
EXEC RegistrarEntrada 4, '2025-06-21', 'Compra', 3, 10, 20.00;
EXEC RegistrarEntrada 3, '2025-06-21', 'Compra', 3, 30, 2.50;

-- Registrar ventas
EXEC RegistrarVenta 1, '2025-06-21', 'Efectivo', 1, 3, 25.00;
EXEC RegistrarVenta 2, '2025-06-21', 'Tarjeta', 2, 2, 35.00;
EXEC RegistrarVenta 1, '2025-06-21', 'Yape', 3, 4, 5.00;

-- Reportes
EXEC ReporteClientes;
EXEC ReporteProveedores;
EXEC ReporteProductosEnStock;
EXEC ReporteVentas;
EXEC ReporteEntradas;
