USE [Vinito]
GO
/****** Object:  StoredProcedure [dbo].[VerRolesEmpleado]    Script Date: 28/06/2025 09:13:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- MOSTRAR ROLES x EMPLEADO
ALTER PROCEDURE [dbo].[VerRolesEmpleado]
    @id_persona INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT pe.id_persona, pe.nombre + ' ' + pe.apellido_paterno + ' ' + pe.apellido_materno AS nombre_completo, r.id_rol, r.nombre_rol, r.descripcion
	
    FROM Rol r
    JOIN Empleado_Rol er ON r.id_rol = er.id_rol
	JOIN Persona pe ON pe.id_persona = pe.id_persona
    WHERE er.id_persona = @id_persona;
END;
