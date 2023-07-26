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
    @instructores VARCHAR(MAX), 
    @areas VARCHAR(MAX), 
    @ugacs VARCHAR(MAX) 
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
    SET @cve_sol_cap_int = SCOPE_IDENTITY(); -- �ltimo cve insertado

    -- Tabla temporal para almacenar los datos de instructores, �reas y ugacs
    DECLARE @instructorData TABLE (
        InstructorId INT,
        AreaId INT,
        UgacId INT,
        RowNumber INT
    );
    
    -- Obtener instructores, Areas y ugacs en filas separadas
    WITH InstructorsCTE AS (
        SELECT value, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS RowNumber
        FROM STRING_SPLIT(@instructores, ',')
    ),
    AreasCTE AS (
        SELECT value, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS RowNumber
        FROM STRING_SPLIT(@areas, ',')
    ),
    UgacsCTE AS (
        SELECT value, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS RowNumber
        FROM STRING_SPLIT(@ugacs, ',')
    )
    INSERT INTO @instructorData (InstructorId, AreaId, UgacId, RowNumber)
    SELECT
        CONVERT(INT, i.value) AS InstructorId,
        CONVERT(INT, a.value) AS AreaId,
        CONVERT(INT, u.value) AS UgacId,
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS RowNumber
    FROM InstructorsCTE i
    INNER JOIN AreasCTE a ON i.RowNumber = a.RowNumber
    INNER JOIN UgacsCTE u ON i.RowNumber = u.RowNumber;

    -- Insertar registros en la tabla solicitud_instructor
    INSERT INTO solicitud_instructor (cve_sol_cap_int, cve_instructor, cve_area, cve_ugac)
    SELECT
        @cve_sol_cap_int,
        InstructorId,
        AreaId,
        UgacId
    FROM @instructorData;
    
END
GO

IF OBJECT_ID('InsertarEmpleado', 'P') IS NOT NULL
    DROP PROCEDURE InsertarEmpleado
GO
CREATE PROCEDURE InsertarEmpleado(
    -- Datos de Persona
    @nombre						VARCHAR(50),
	@apellido_paterno			VARCHAR(50),
	@apellido_materno			VARCHAR(50),
	@email               		VARCHAR(129),
	@movil            			VARCHAR(20),
	@curp 						VARCHAR(18),
	@rfc 						VARCHAR(13),
	@sexo              			VARCHAR(20),
	@fecha_nacimiento 			DATE,
    -- Datos de Empleado
	@cve_puesto					INT,
	@cve_tipo_puesto			INT,
	@cve_departamento			INT,
	@cve_area					INT,
	@cve_ugac					INT,
	@cve_unidad_academica 		INT,
	@fecha_ingreso				DATE,
	@titulo_recibido			VARCHAR(50),
	@grado_estudio				VARCHAR(25),
	-- Datos de usuario
	@nombre_usuario 				VARCHAR(50),
	@contrasenia 				VARCHAR(50)
)
AS
BEGIN

    INSERT INTO persona (nombre, apellido_paterno, apellido_materno, email, movil, curp, rfc, sexo, fecha_nacimiento) 
    VALUES (@nombre, @apellido_paterno, @apellido_materno, @email, @movil, @curp, @rfc, @sexo, @fecha_nacimiento);

    DECLARE @var_cve_persona INT;
    SET @var_cve_persona = SCOPE_IDENTITY();

    INSERT INTO empleado (cve_persona, cve_puesto, cve_tipo_puesto, cve_departamento, cve_area, cve_ugac, cve_unidad_academica, fecha_ingreso, titulo_recibido, grado_estudio) 
    VALUES (@var_cve_persona, @cve_puesto, @cve_tipo_puesto, @cve_departamento, @cve_area, @cve_ugac, @cve_unidad_academica, @fecha_ingreso, @titulo_recibido, @grado_estudio);

	INSERT INTO usuario (cve_persona, nombre_usuario, contrasenia) VALUES (@var_cve_persona, @nombre_usuario, @contrasenia);
END;