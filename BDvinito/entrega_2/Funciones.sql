USE Vinito;
GO

-- Calcular Subtotal
CREATE FUNCTION fn_CalcularSubtotal(
    @cantidad INT,
    @precio_unitario MONEY
)
RETURNS MONEY
AS
BEGIN
    RETURN @cantidad * @precio_unitario
END

-- Ejemplo
SELECT dbo.fn_CalcularSubtotal(5, 12.50) AS Subtotal;


-- Obtener el nombre de un cliente por ID
CREATE FUNCTION fn_ObtenerNombreCliente(@id_persona INT)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @nombre VARCHAR(100)
    SELECT @nombre = nombre FROM Persona WHERE id_persona = @id_persona AND tipo_persona = 'Cliente'
    RETURN @nombre
END

-- Ejemplo
SELECT dbo.fn_ObtenerNombreCliente(1) AS NombreCliente;
