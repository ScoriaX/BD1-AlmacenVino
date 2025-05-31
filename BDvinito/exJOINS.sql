USE Vinito;
GO

/* JOINS */

/*INNER JOIN
 ver solo los datos que tienen relación en ambas tablas*/

-- Productos con su categoria 
SELECT 
    P.nombre AS Producto,
    C.nombre_categoria AS Categoria,
    P.precio_venta
FROM Producto P
INNER JOIN Categoria C ON P.id_categoria = C.id_categoria;

-- Venta relizadas con el nombre del cliente 
SELECT 
    V.id_venta,
    P.nombre AS Cliente,
    V.fecha,
    V.total
FROM Venta V
INNER JOIN Persona P ON V.id_persona = P.id_persona;

-- Visualizar el detalle de  venta con el nombre del producto 
SELECT 
    DV.id_venta,
    PR.nombre AS Producto,
    DV.cantidad,
    DV.precio_unitario,
    DV.subtotal
FROM DetalleVenta DV
INNER JOIN Producto PR ON DV.id_producto = PR.id_producto;

-- Ver productos con detalle de vino 
SELECT 
    P.nombre AS NombreProducto,
    V.cepa,
    V.año_cosecha,
    V.pais_origen,
    V.grado_alcohol
FROM Producto P
INNER JOIN Vino V ON P.id_producto = V.id_producto;

-- Visualisar todo producto , inclusi si no cuenta con detalle 
SELECT 
    P.nombre,
    V.cepa,
    V.pais_origen
FROM Producto P
LEFT JOIN Vino V ON P.id_producto = V.id_producto;
