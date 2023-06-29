USE mauri;
GO

IF OBJECT_ID('InsertarAsesoria', 'P') IS NOT NULL
    DROP PROCEDURE InsertarAsesoria
GO
CREATE PROCEDURE InsertarAsesoria (
	@cve_empleado INT,
	@cve_academia INT,
	@materia VARCHAR(50),
	@fecha DATE,
	@motivo_solicitud TEXT,
	@sugerencias TEXT,
	@entrevista TEXT,
	@cve_responsable INT,
	@compromiso TEXT,
	@fecha_seguimiento DATE,
	@usuario_registro INT
)
AS
BEGIN
	DECLARE @nuevo_cve_asesoria INT

	INSERT INTO asesoria (cve_empleado, cve_academia, materia, fecha, motivo_solicitud, sugerencias, entrevista, usuario_registro)
	VALUES (@cve_empleado, @cve_academia, @materia, @fecha, @motivo_solicitud, @sugerencias, @entrevista, @usuario_registro)

	SET @nuevo_cve_asesoria = SCOPE_IDENTITY()

	-- Insertar en la tabla asesoria_d utilizando el valor de cve_asesoria generado
	INSERT INTO asesoria_d (cve_asesoria, cve_responsable, compromiso, fecha_seguimiento, usuario_registro)
	VALUES (@nuevo_cve_asesoria, @cve_responsable, @compromiso, @fecha_seguimiento, @usuario_registro)
END
GO