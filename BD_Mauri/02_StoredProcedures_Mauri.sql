CREATE PROCEDURE InsertarEvaluacionResultado
	@cve_t_servicio 			INT,
	@cve_asesoria_proyecto	INT,
	@suma					INT,
	@porcentaje 			FLOAT,
	@cuatrimestre			VARCHAR(8),
	@comentarios 			TEXT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @nuevaClave INT;

	-- Obtener el máximo valor actual de cve_eval_resul
	SELECT @nuevaClave = ISNULL(MAX(cve_eval_resul), 0) + 1
	FROM evaluacion_resultado;

	-- Insertar el nuevo registro con la clave autoincremental
	INSERT INTO evaluacion_resultado (cve_eval_resul, cve_t_servicio, cve_asesoria_proyecto, suma, porcentaje, cuatrimestre, comentarios, activo, fecha_registro)
	VALUES (@nuevaClave, @cve_t_servicio, @cve_asesoria_proyecto, @suma, @porcentaje, @cuatrimestre, @comentarios, 1, GETDATE());
END;

CREATE PROCEDURE InsertarSolicitudProyecto
	@cve_area INT,
	@nombre_proyecto VARCHAR(100),
	@objetivo_proyecto TEXT,
	@descripcion_proyecto TEXT,
	@recursos_necesarios TEXT,
	@acuerdos_establecidos TEXT,
	@estatus VARCHAR(20),
	@sexo VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @fecha_registro DATETIME = GETDATE();
	DECLARE @activo BIT = 1;

	INSERT INTO solicitud_proyecto (cve_area, nombre_proyecto, objetivo_proyecto, descripcion_proyecto, recursos_necesarios, acuerdos_establecidos, estatus, sexo, activo, fecha_registro)
	VALUES (@cve_area, @nombre_proyecto, @objetivo_proyecto, @descripcion_proyecto, @recursos_necesarios, @acuerdos_establecidos, @estatus, @sexo, @activo, @fecha_registro);
END

CREATE PROCEDURE InsertarAsesoria
	@cve_empleado INT,
	@materia VARCHAR(50),
	@fecha DATE,
	@motivo_solicitud VARCHAR(50),
	@sugerencias TEXT,
	@entrevista TEXT,
	@firma BIT
AS
BEGIN
	DECLARE @activo BIT
	DECLARE @fecha_registro DATETIME
	
	SET @activo = 1
	SET @fecha_registro = GETDATE()
	
	INSERT INTO asesoria (cve_empleado, materia, fecha, motivo_solicitud, sugerencias, entrevista, firma, activo, fecha_registro)
	VALUES (@cve_empleado, @materia, @fecha, @motivo_solicitud, @sugerencias, @entrevista, @firma, @activo, @fecha_registro)
END

CREATE PROCEDURE InsertarRubricaObservacionClase
    @cve_empleado_docente INT,
    @seccion VARCHAR(45),
    @calificacion_seccion INT,
    @calificacion_total INT,
    @cometario TEXT
AS
BEGIN
    SET NOCOUNT ON;

    -- Declarar variable para almacenar el nuevo valor de cve_rubrica
    DECLARE @nuevo_cve_rubrica INT;

    -- Obtener el máximo valor actual de cve_rubrica y aumentarlo en 1
    SELECT @nuevo_cve_rubrica = ISNULL(MAX(cve_rubrica), 0) + 1
    FROM rubrica_observacion_clase;

    -- Insertar el nuevo registro con el valor de cve_rubrica incrementado
    INSERT INTO rubrica_observacion_clase (cve_empleado_docente, cve_rubrica, seccion, calificacion_seccion, calificacion_total, cometario)
    VALUES (@cve_empleado_docente, @nuevo_cve_rubrica, @seccion, @calificacion_seccion, @calificacion_total, @cometario);
END

CREATE PROCEDURE InsertarAnalisisDocente
	@cve_unidad_academica INT,
	@cve_departamento INT,
	@cve_tipo_evento INT,
	@cve_ugac INT,
	@numero_ptc INT,
	@anio_aplicacion INT,
	@media_evaluacion_docente FLOAT,
	@media_evaluacion_tutoreo FLOAT,
	@promedio_evaluacion_tutoreo FLOAT,
	@promedio_evaluacion_docente FLOAT,
	@porcentaje_docentes_acreditados FLOAT,
	@fortalezas TEXT,
	@debilidades TEXT,
	@necesidades TEXT,
	@prioridad_capacitacion TEXT,
	@estrategias_intervencion TEXT
AS
BEGIN
	INSERT INTO analisis_docente (cve_unidad_academica, cve_departamento, cve_tipo_evento, cve_ugac, numero_ptc, anio_aplicacion, media_evaluacion_docente, media_evaluacion_tutoreo, promedio_evaluacion_tutoreo, promedio_evaluacion_docente, porcentaje_docentes_acreditados, fortalezas, debilidades, necesidades, prioridad_capacitacion, estrategias_intervencion)
	VALUES (@cve_unidad_academica, @cve_departamento, @cve_tipo_evento, @cve_ugac, @numero_ptc, @anio_aplicacion, @media_evaluacion_docente, @media_evaluacion_tutoreo, @promedio_evaluacion_tutoreo, @promedio_evaluacion_docente, @porcentaje_docentes_acreditados, @fortalezas, @debilidades, @necesidades, @prioridad_capacitacion, @estrategias_intervencion);
END;