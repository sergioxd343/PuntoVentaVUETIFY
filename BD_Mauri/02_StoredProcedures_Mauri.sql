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

IF OBJECT_ID('InsertarSolicitudConInstructores', 'P') IS NOT NULL
    DROP PROCEDURE InsertarSolicitudConInstructores
GO
CREATE PROCEDURE InsertarSolicitudConInstructores
(
    @cve_horario INT,
    @tipo_competencia VARCHAR(15),
    @nombre VARCHAR(50),
    @total_dias INT,
    @total_horas INT,
    @fecha_inicio DATE,
    @fecha_fin DATE,
    @lugar VARCHAR(100),
    @curso VARCHAR(30),
    @numero_participantes INT,
    @objetivo TEXT,
    @alcance TEXT,
    @metodologia VARCHAR(50),
    @programa_evento VARCHAR(50),
    @resultado_aprendizaje TEXT,
    @perfil_participante TEXT,
    @estatus INT,
    @usuario_registro INT,
    @instructores VARCHAR(MAX) -- Aqui mando array
)
AS
BEGIN
    
    INSERT INTO solicitud_capacitacion_interna (
        cve_horario, tipo_competencia, nombre, total_dias, total_horas,
        fecha_inicio, fecha_fin, lugar, curso, numero_participantes,
        objetivo, alcance, metodologia, programa_evento, resultado_aprendizaje,
        perfil_participante, estatus, usuario_registro
    )
    VALUES (
        @cve_horario, @tipo_competencia, @nombre, @total_dias, @total_horas,
        @fecha_inicio, @fecha_fin, @lugar, @curso, @numero_participantes,
        @objetivo, @alcance, @metodologia, @programa_evento, @resultado_aprendizaje,
        @perfil_participante, @estatus, @usuario_registro
    );

   
    DECLARE @cve_sol_cap_int INT;
    SET @cve_sol_cap_int = SCOPE_IDENTITY(); -- ultimo cve insertado

    
    DECLARE @instructorId INT;
	-- tabla para guardar los id de instructor
    DECLARE @instructorList TABLE (Id INT);
    
   
    DECLARE @pos INT; -- posicion 
    DECLARE @piece VARCHAR(MAX); -- cve
    SET @instructores = @instructores + ',';
    SET @pos = CHARINDEX(',', @instructores, 1); -- charindex encuentra la primera coma en los instructores 
    
    WHILE @pos > 0
    BEGIN
        SET @piece = SUBSTRING(@instructores, 1, @pos - 1); -- id de instructores que está antes de la primera coma
        
        IF @piece <> '' -- si el cve no esta vacio
        BEGIN
            INSERT INTO @instructorList (Id) VALUES (CONVERT(INT, @piece)); -- guarda el cve convertido a int 
        END;
        
        SET @instructores = STUFF(@instructores, 1, @pos, ''); -- limpia instructores y posicion
        SET @pos = CHARINDEX(',', @instructores, 1); -- la posicion de la siguiente coma
    END;

    -- Insertar cada Id instructor en solicitud_instructor de la lista de intructores generada
    INSERT INTO solicitud_instructor (cve_sol_cap_int, cve_instructor)
    SELECT @cve_sol_cap_int, Id
    FROM @instructorList;
END;
GO