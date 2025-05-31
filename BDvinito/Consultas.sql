USE Vinito;
GO

-- Clientes registrados
SELECT 
    p.nombre + ' ' + p.apellido_paterno + ' ' + p.apellido_materno AS nombre_completo, 
    p.numero_documento, 
    p.correo, 
    c.fecha_registro
FROM Cliente c
JOIN Persona p ON c.id_persona = p.id_persona;

-- Productos en stock
SELECT 
    p.id_producto, 
    p.nombre, 
    p.tipo_producto, 
    p.stock_actual, 
    p.precio_venta
FROM Producto p
WHERE p.stock_actual > 0;

-- Detalles de todos los vinos
SELECT 
    pr.nombre AS nombre_producto, 
    v.cepa, 
    v.año_cosecha, 
    v.pais_origen, 
    v.bodega, 
    v.grado_alcohol
FROM Vino v
JOIN Producto pr ON v.id_producto = pr.id_producto;

-- Detalles de los accesorios
SELECT 
    pr.nombre AS nombre_producto, 
    a.tipo_accesorio, 
    a.material, 
    a.color, 
    a.dimensiones
FROM Accesorio a
JOIN Producto pr ON a.id_producto = pr.id_producto;

-- Ventas con sus productos
SELECT 
    v.id_venta, 
    v.fecha, 
    p.nombre + ' ' + p.apellido_paterno + ' ' + p.apellido_materno AS cliente, 
    pr.nombre AS producto, 
    dv.cantidad, 
    dv.precio_unitario, 
    dv.subtotal
FROM Venta v
JOIN Persona p ON v.id_persona = p.id_persona
JOIN DetalleVenta dv ON v.id_venta = dv.id_venta
JOIN Producto pr ON dv.id_producto = pr.id_producto;

-- Entradas al almacén
SELECT 
    e.id_entrada, 
    e.fecha, 
    pe.nombre + ' ' + pe.apellido_paterno + ' ' + pe.apellido_materno AS proveedor, 
    pr.nombre AS producto, 
    de.cantidad, 
    de.precio_unitario
FROM Entrada e
JOIN Persona pe ON e.id_persona = pe.id_persona
JOIN DetalleEntrada de ON e.id_entrada = de.id_entrada
JOIN Producto pr ON de.id_producto = pr.id_producto;
