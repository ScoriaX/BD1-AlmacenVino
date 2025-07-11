USE [Vinito]
GO
/****** Object:  StoredProcedure [dbo].[VerPermisosEmpleado]    Script Date: 28/06/2025 09:14:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- MOSTRAR PERMISOS x EMPLEADO
ALTER PROCEDURE [dbo].[VerPermisosEmpleado]
    @id_persona INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT pe.id_persona, pe.nombre + ' ' + pe.apellido_paterno + ' ' + pe.apellido_materno AS nombre_completo, p.id_permiso, p.nombre_permiso, p.descripcion
    FROM Permiso p
    JOIN Rol_Permiso rp ON p.id_permiso = rp.id_permiso
    JOIN Empleado_Rol er ON rp.id_rol = er.id_rol
	JOIN Persona pe ON pe.id_persona = pe.id_persona
    WHERE er.id_persona = @id_persona;
END;
