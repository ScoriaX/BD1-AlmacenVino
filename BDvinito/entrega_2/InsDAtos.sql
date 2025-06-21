-- Tipos de documentos
INSERT INTO DocumentoIdentidad (id_documento, tipo_documento, longitud) VALUES 
(1, 'DNI', 8),
(2, 'RUC', 11);

-- Personas (Cliente y Proveedor)
INSERT INTO Persona (
    nombre, apellido_paterno, apellido_materno, 
    id_documento, numero_documento, tipo_persona, 
    correo, telefono, direccion
)
VALUES 
('Carlos', 'Gómez', 'Ramírez', 1, '12345678', 'Cliente', 'carlos@gmail.com', '999888777', 'Av. Lima 123'),
('Lucía', 'Torres', 'Vega', 2, '20481234567', 'Proveedor', 'contacto@vinotorres.com', '989898989', 'Jr. Comercio 456');

-- Cliente y Proveedor
INSERT INTO Cliente (id_persona) VALUES (1);
INSERT INTO Proveedor (id_persona, empresa) VALUES (2, 'Vinos Torres SAC');

-- Categorías
INSERT INTO Categoria (nombre_categoria, descripcion) VALUES 
('Vino Tinto', 'Vinos elaborados con uvas tintas.'),
('Accesorios', 'Accesorios como copas, llaveros, etc.');

-- Productos
INSERT INTO Producto (
    nombre, descripcion, precio_compra, precio_venta, stock_actual, id_categoria, tipo_producto
)
VALUES 
('Cabernet Sauvignon Reserva', 'Vino tinto seco de reserva', 20.00, 35.00, 50, 1, 'Vino'),
('Llavero de Corcho', 'Llavero artesanal hecho de corcho reciclado', 2.00, 5.00, 100, 2, 'Accesorio');

-- Detalles del vino
INSERT INTO Vino (
    id_producto, cepa, año_cosecha, pais_origen, bodega, grado_alcohol
)
VALUES (
    1, 'Cabernet Sauvignon', '2020-01-01', 'Chile', 'Concha y Toro', 13.5
);

-- Detalles del accesorio
INSERT INTO Accesorio (
    id_producto, material, color, dimensiones, tipo_accesorio
)
VALUES (
    2, 'Corcho', 'Marrón', '5x3 cm', 'Llavero'
);

-- Venta
INSERT INTO Venta (id_persona, fecha, total, metodo_pago)
VALUES (1, '2024-06-01', 70.00, 'Tarjeta');

-- Detalle de venta
INSERT INTO DetalleVenta (id_venta, id_producto, cantidad, precio_unitario, subtotal)
VALUES 
(1, 1, 2, 35.00, 70.00);

-- Entrada (compra a proveedor)
INSERT INTO Entrada (id_persona, fecha, tipo_entrada, total)
VALUES (2, '2024-05-30', 'Compra', 100.00);

-- Detalle de entrada
INSERT INTO DetalleEntrada (id_entrada, id_producto, cantidad, precio_unitario, subtotal)
VALUES 
(1, 1, 5, 20.00, 100.00);

-- Histórico (ejemplo)
INSERT INTO Historico (tabla_afectada, id_registro, accion, usuario, descripcion)
VALUES ('Producto', 1, 'INSERT', 'admin', 'Se insertó el producto Cabernet Sauvignon Reserva');
