-- =============================================
-- Author:	Simón Zendejas, Maria Gutiérrez, 
--			Sergio Hernandez, Carlos De Pro, 
--			Brenda Gutiérrez
-- Create date: 22-03-2023
-- Description:	Son los Scripts DDL para la base 
--				del datos del proyecto Mauri
-- =============================================

USE master;
GO

IF DB_ID('mauri') IS NOT NULL
DROP DATABASE mauri;
GO

CREATE DATABASE mauri;
GO

USE mauri;
GO
-- ------------- TABLA PERSONA -------------- --
CREATE TABLE persona(
	cve_persona			INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre				VARCHAR(50),
	apellido_peterno	VARCHAR(50) NOT NULL,
	apellido_materno	VARCHAR(50),
	email               VARCHAR(129) NOT NULL DEFAULT '',
	movil            	VARCHAR(20) NOT NULL DEFAULT '',
	curp 				VARCHAR(18) NOT NULL DEFAULT '',
	rfc 				VARCHAR(13) NOT NULL DEFAULT '',
	sexo              	VARCHAR(20) NOT NULL, -- Genero: M; F; O;
	fecha_nacimiento 	DATE NOT NULL,	        
	activo 				BIT,
	fecha_registro 		DATETIME,
	usuario_registro 	INT
);

-- ------------- TABLA UNIDAD ACADEMICA ------------- --
CREATE TABLE unidad_academica(
	cve_unidad_academica INT  NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre_unidad_academica VARCHAR(50),
	activo 				BIT,
	fecha_registro 		DATETIME,
	usuario_registro 	INT	
);

-- ------------- TABLA ACADEMIA -------------- --
-- Modificacion: 21/04/23 por Carlos René Andrade
CREATE TABLE academia(
	idAcademia INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	idUnidadAcademica INT,
	nombreAcademia VARCHAR(50),
	CONSTRAINT fk_academia_unidadAcademica FOREIGN KEY (idUnidadAcademica) REFERENCES unidadAcademica(idUnidadAcademica)
);

-- ------------- TABLA AREA -------------- --
CREATE TABLE area(
	cve_area				INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre_area			VARCHAR(100),
	activo 				BIT,
	fecha_registro 		DATETIME,
	usuario_registro 	INT
);

-- ----------------- TABLA UGAC ------------------- --
CREATE TABLE ugac(
	cve_ugac INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre_ugac VARCHAR(50),
	activo 				BIT,
	fecha_registro 		DATETIME,
	usuario_registro 	INT
);



-- ------------- TABLA CURSO -------------- --
CREATE TABLE curso(
	idCurso INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	nombreCurso VARCHAR(50)
);

-- ----------------- TABLA PUESTO ------------------- --
CREATE TABLE puesto(
	cve_puesto INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre_puesto VARCHAR(50),
	nivel_tabulador_puesto VARCHAR(25),
	activo 				BIT,
	fecha_registro 		DATETIME,
	usuario_registro 	INT
);

-- ----------------- TABLA TIPO PUESTO ------------------- --
CREATE TABLE tipo_puesto(
	cve_tipo_pesto INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre_tipo_puesto VARCHAR(50),
	activo 				BIT,
	fecha_registro 		DATETIME,
	usuario_registro 	INT
);

-- ----------------- TABLA DEPARTAMENTO ------------------- --
CREATE TABLE departamento(
	cve_departamento INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre_departamento VARCHAR(50),
	activo 				BIT,
	fecha_registro 		DATETIME,
	usuario_registro 	INT
);


-- ------------- TABLA CATEGORIA EVENTO -------------- --
CREATE TABLE categoriaEvento(
	idCategoriaEvento INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	nombreCategoria VARCHAR(50), -- Diplomado, Competencias digitales, Tecnicos,Estrategicos, Institucionales, Certificaciones
);

-- ------------- TABLA EMPLEADO -------------- --
CREATE TABLE empleado(
	cve_empleado		INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cve_persona			INT NOT NULL,
	cve_puesto			INT NOT NULL,
	cve_tipo_pesto		INT NOT NULL,
	cve_departamento	INT NOT NULL,
	cve_area			INT NOT NULL,
	cve_ugac			INT NOT NULL,
	cve_unidad_academica 	INT NOT NULL,
	fecha_ingreso		DATE,
	titulo_recibido		VARCHAR(50),
	grado_estudio		VARCHAR(25),
    activo 				BIT,
	fecha_registro 		DATETIME,
	usuario_registro 	INT
	CONSTRAINT fk_empleado_persona FOREIGN KEY (idPersona) REFERENCES persona(idPersona),
	CONSTRAINT fk_empleado_area FOREIGN KEY (idArea) REFERENCES area(idArea)
);

-- ------------- TABLA DANC -------------- --
CREATE TABLE necesidad_capacitacion_anual (
	cve_nec_cap_anual INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cve_area_registro INT NOT NULL,
	cve_unidad_academica INT NOT NULL,
	cve_nivel_academico INT NOT NULL,
	cve_area INT NOT NULL,
	cve_departamento INT NOT NULL,
	cve_empleado_responsable INT NOT NULL,
	cve_orientacion_evento INT NOT NULL,
	cve_tipo_evento INT NOT NULL,
	cve_tipo_capacitacion INT NOT NULL,
	cve_origen_evento INT NOT NULL,
	anio_ejercicio DATETIME,
	necesidades_detectadas TEXT,
	nombre_evento VARCHAR(50),
	objetivo_evento TEXT,
	justificacion TEXT,
	otro_tipo_evento VARCHAR(50),
	proveedor VARCHAR(50),
	costo_capacitacion FLOAT,
	mes VARCHAR(15),
	fecha_inicio DATETIME,
	fecha_temino DATETIME,
	num_dias INT,
	num_horas_efectivas INT,
	participantes_ptc INT,
	participantes_laboratoristas INT,
	participantes_administrativo INT,
	otros_participantes INT,
	total_participantes INT,
	total_hombres INT,
	total_mujeres INT,
	activo 				BIT,
	fecha_registro 		DATETIME,
	usuario_registro 	INT,	
	CONSTRAINT fk_danc_empleado FOREIGN KEY (idEmpleado) REFERENCES empleado(idEmpleado)
);

-- ------------- TABLA MODALIDAD EVENTO -------------- --
CREATE TABLE modalidadEvento(
	idModalidad INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	nombreModalidad VARCHAR(50), -- Presencial, Virtual sincronica, Vitual asincronica
);

-- ------------- TABLA ASESORIA PEDAGOGICA -------------- --
CREATE TABLE asesoriaPedagogica(
	idAsesoriaPedagogica INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	nombreAsasoriaPedagogica VARCHAR(50)
);

-- ------------- TABLA DESARROLLO DE PROYECTOS -------------- --
CREATE TABLE desarrolloProyecto(
	idDesarrolloProyecto INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	nombreDesarrolloProyecto VARCHAR(50)
);

-- ------------- TABLA MATERIAS DIPLOMADO -------------- --
CREATE TABLE materiasDiplomado(
	idMateriaDiplomado INT NOT NULL PRIMARY KEY,
	nombreMateriaDiplomado VARCHAR(50),
	grado INT
);

-- ------------- TABLA CUMPLE PROGRAMA OBLIGATORIO -------------- --
CREATE TABLE cumpleProgramaObligatorio(
	idCumpleProgramaObligatorio INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	idMateriaDiplomado INT NOT NULL,
	CONSTRAINT fk_cumpleProgramaObligatorio_materiasDiplomado FOREIGN KEY (idMateriaDiplomado) REFERENCES materiasDiplomado(idMateriaDiplomado),
);


-- ------------- TABLA OTROS EVENTOS -------------- --
CREATE TABLE otroEvento(
	idOtroEvento INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	nombreOtroEvento VARCHAR(50)
);

-- ------------- TABLA EVENTO -------------- --
CREATE TABLE evento(
	idEvento INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	idCategoriaEvento INT NOT NULL,
	idModalidad INT NOT NULL,
	idAsesoriaPedagogica INT NOT NULL,
	idDesarrolloProyecto INT NOT NULL,
	idMateriaDiplomado INT NOT NULL,
	idOtroEvento INT NOT NULL,
	idDanc INT NOT NULL,
	CONSTRAINT fk_evento_categoriaEvento FOREIGN KEY (idCategoriaEvento) REFERENCES categoriaEvento(idCategoriaEvento),
	CONSTRAINT fk_evento_modalidadEvento FOREIGN KEY (idModalidad) REFERENCES modalidadEvento(idModalidad),
	CONSTRAINT fk_evento_asesoriaPedagogica FOREIGN KEY (idAsesoriaPedagogica) REFERENCES asesoriaPedagogica(idAsesoriaPedagogica),
	CONSTRAINT fk_evento_desarrolloProyecto FOREIGN KEY (idDesarrolloProyecto) REFERENCES desarrolloProyecto(idDesarrolloProyecto),
	CONSTRAINT fk_evento_materiasDiplomado FOREIGN KEY (idMateriaDiplomado) REFERENCES materiasDiplomado(idMateriaDiplomado),
	CONSTRAINT fk_evento_otroEvento FOREIGN KEY (idOtroEvento) REFERENCES otroEvento(idOtroEvento),
	CONSTRAINT fk_evento_danc FOREIGN KEY (idDanc) REFERENCES danc(idDanc)
);

-- ------------- TABLA SOLICITUD PROYECTO -------------- --
CREATE TABLE solicitud_proyecto(
	cve_solicitud_proyecto INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cve_area				INT NOT NULL,
	nombre_proyecto		VARCHAR(100),
	objetivo_proyecto	TEXT,
	descripcion_proyecto TEXT,
	recursos_necesarios	TEXT,
	acuerdos_establecidos TEXT,
	estatus				BIT DEFAULT 1, -- El estatus puede tener 2 valores, (0-Cancelado, 1-Revisado)
	sexo				VARCHAR(20),
	activo 				BIT,
	fecha_registro 		DATETIME,
	usuario_registro 	INT
	CONSTRAINT fk_solicitudProyecto_empleado FOREIGN KEY (idEmpleado) REFERENCES empleado(idEmpleado),
	CONSTRAINT fk_solicitudProyecto_area FOREIGN KEY (idArea) REFERENCES area(idArea)
);

-- ------------- TABLA ASESORIA -------------- --
CREATE TABLE asesoria(
	cve_asesoria	INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	cve_empleado			INT NOT NULL,
	materia	VARCHAR(50),
	fecha				DATE,
	motivo_solicitud		VARCHAR(50),
	sugerencias			TEXT,
	entrevista	TEXT,
	activo 				BIT,
	fecha_registro 		DATETIME,
	usuario_registro 	INT
	CONSTRAINT fk_asesoramiento_empleado FOREIGN KEY (idEmpleado) REFERENCES empleado(idEmpleado)
);

-- ----------------- TABLA ASESORIA_D ------------------- --
CREATE TABLE asesoria_d(
	cve_asesoria INT NOT NULL,
	cve_compromiso INT NOT NULL,
	cve_responsable INT NOT NULL,
	compromiso TEXT,
	fecha_seguimiento DATE,
	activo 				BIT,
	fecha_registro 		DATETIME,
	usuario_registro 	INT
);

-- ------------- TABLA RUBRICA -------------- --
CREATE TABLE rubrica(
	cve_rubrica			INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cve_empleado			INT NOT NULL,
	nombre_rubica		Varchar(45),
	filas				VARCHAR(25),
	columnas			VARCHAR(25),
	nombre_seccion		VARCHAR(45),
	secciona_fila_inicio	VARCHAR(25),
	seccion_fila_fin		VARCHAR(25),
	nombre_columna		VARCHAR(45),
	criterios_por_celda	TEXT,
	activo 				BIT,
	fecha_registro 		DATETIME,
	usuario_registro 	INT
	CONSTRAINT fk_rubrica_empleado FOREIGN KEY (idEmpleado) REFERENCES empleado(idEmpleado)
);

-- ------------- TABLA RUBRICA OBSERVACIÓN DE CLASE -------------- --
CREATE TABLE rubrica_observacion_clase(
	cve_empleado_docente	INT NOT NULL,
	cve_rubrica			INT NOT NULL,
	seccion				VARCHAR(45),
	calificacion_seccion INT,
	calificacion_total	INT,
	cometario 			TEXT,
	activo 				BIT,
	fecha_registro 		DATETIME,
	usuario_registro 	INT
	CONSTRAINT fk_observacionClase_empleado FOREIGN KEY (idEmpleado) REFERENCES empleado(idEmpleado),
	CONSTRAINT fk_observacionClase_rubrica FOREIGN KEY (idRubrica) REFERENCES rubrica(idRubrica)
);

-- ------------- TABLA ENCUESTA DE SATISFACCIÓN Y EVALUACION DE RESULTADOS -------------- --
CREATE TABLE evaluacion_resultado(
	cve_eval_resul			INT NOT NULL,
	cve_t_servicio INT NOT NULL,
	cve_asesoria_proyecto				INT NOT NULL,
	suma		INT,
	porcentaje FLOAT,
	cuatrimestre		VARCHAR(8),
	comentarios TEXT,
	activo 				BIT,
	fecha_registro 		DATETIME,
	usuario_registro 	INT
	CONSTRAINT fk_encuestaSatisfaccionEvaluacio_area FOREIGN KEY (idArea) REFERENCES area(idArea),
	CONSTRAINT fk_encuestaSatisfaccionEvaluacio_empleado FOREIGN KEY (idEmpleado) REFERENCES empleado(idEmpleado)
);

-- ------------- TABLA ANALISIS SITUACIONAL DOCENTE -------------- --
CREATE TABLE asd(
	idASD				INT IDENTITY (1,1) PRIMARY KEY,
	idEmpleado			INT NOT NULL,
	idUnidadAcademica	INT NOT NULL,
	idProgramaEducativo INT NOT NULL,
	idTipoEvento		INT NOT NULL,
	nombreAcademia		INT NOT NULL,
	numPTC				INT,
	fechaElaboracion	DATETIME,
	anioAplicacion		INT,
	mediaEvaluacionDocente FLOAT,
	mediaEvaluacionTutoreo  FLOAT,	
	promedioEvaluacionTutoreo FLOAT,
	promedioEvaluacionDocente FLOAT,
	porcentajeDocentesAcreditados FLOAT,
	fortalezas			TEXT,
	debilidades			TEXT,
	necesidades			TEXT,
	prioridadCapacitacion TEXT,
	estrategiasIntervencion TEXT,
	CONSTRAINT fk_asd_empleado FOREIGN KEY (idEmpleado) REFERENCES empleado(idEmpleado),
	CONSTRAINT fk_asd_unidadAcademica FOREIGN KEY (idUnidadAcademica) REFERENCES unidadAcademica(idUnidadAcademica)
);

-- ------------- TABLA REPORTE ACTP -------------- --
CREATE TABLE reporteActp(
	idAtcp 				INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	idEmpleado			INT NOT NULL,
	idEvaluacionDocente INT NOT NULL,
	cuatrimestre		VARCHAR(20),
	fecha				DATETIME,
	accion				VARCHAR(45),
	sintesis			VARCHAR(45),
	CONSTRAINT fk_reporteActp_empleado FOREIGN KEY (idEmpleado) REFERENCES empleado(idEmpleado)
);

-- ------------- TABLA EVALUCIÓN DE CAPACITACIÓN -------------- --
CREATE TABLE evalucionCapacitacion(
	idEmpleado INT NOT NULL,
	idCurso INT NOT NULL,
	idDocente INT NOT NULL,
	idCalificacion INT NOT NULL,
	nombreCurso VARCHAR(50),
	nombreFacilitador VARCHAR(50),
	calificacionFinal INT,
	CONSTRAINT fk_evaluacionCapacitacion_empleado FOREIGN KEY (idEmpleado) REFERENCES empleado(idEmpleado)
);

-- ------------- TABLA LISTA DE ASISTENCIA DE CAPACITACION -------------- --
CREATE TABLE lac(
	idAsistencia INT IDENTITY (1,1) PRIMARY KEY,
	idEvento INT NOT NULL,
	idPuesto INT NOT NULL,
	idPersona INT NOT NULL,
    nombreEvento VARCHAR(50),
    fechaEvento DATE,
    numSesiones SMALLINT,
    totalHoras FLOAT,
    horario VARCHAR(50),
    nombreInstructor VARCHAR(50),
    lugar VARCHAR(50),
    tipoActividad VARCHAR(50),
	numControl INT NOT NULL,
	discapacidad VARCHAR(50),
	direccion VARCHAR(50),
	programaEducativo VARCHAR(50),
	CONSTRAINT fk_lac_evento FOREIGN KEY (idEvento) REFERENCES evento(idEvento),
	CONSTRAINT fk_lac_puesto FOREIGN KEY (idPuesto) REFERENCES puesto(idPuesto),
	CONSTRAINT fk_lac_persona FOREIGN KEY (idPersona) REFERENCES persona(idPersona)
);

-- ----------------- TABLA SOLICITUD FORMACION DOCENTE ------------------- --
CREATE TABLE solicitud_formacion_docente(
	cve_sol_form_doc 	INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cve_unidad_academica INT NOT NULL,
	cve_area 	INT NOT NULL,
	cve_departamento INT NOT NULL,
	cve_ugac INT NOT NULL,
	cve_tipo_evento INT NOT NULL,
	cve_tipo_orientacion INT NOT NULL,
	cve_empleado_valida	INT NOT NULL,
	cve_empleado_responsable INT NOT NULL,
	cve_empleado_autoriza INT NOT NULL,
	lugar VARCHAR(129),
	fecha DATE,
	horario DATETIME,
	numero_horas INT,
	centro_gestor VARCHAR(50),
	proyecto_presupuesto FLOAT,
	costo_total FLOAT,
	transferencia_nombre VARCHAR(50),
	transferencia_cuenta VARCHAR(25),
	transferencia_plaza VARCHAR(20),
	transferencia_banco VARCHAR(20),
	transferencia_clave VARCHAR(25),
	observaciones TEXT,
	activo 				BIT,
	fecha_registro 		DATETIME,
	usuario_registro 	INT
);

-- ----------------- TABLA SOLICITUD FORMACION DOCENTE_D ------------------- --
CREATE TABLE solicitud_formacion_docente_d(
	cve_sol_form_doc INT NOT NULL,
	cve_empleado_anotado INT NOT NULL,
	activo 				BIT,
	fecha_registro 		DATETIME,
	usuario_registro 	INT
);
-- ------------- TABLA SOLICITUD APOYO PARA LA FORMACION DOCENTE -------------- --
CREATE TABLE solicitudCapacitacion (
	idSolicitudCapacitacion INT PRIMARY KEY,
	idPersona INT NOT NULL,
	idPuesto INT NOT NULL,
	idArea INT NOT NULL,
	fechaSolicitud DATE,
	folioAutorizacion INT,
	unidadAcademica VARCHAR(50),
	direccionAcademica VARCHAR(50),
	programaEducativo VARCHAR(50),
	numeroEmpleado INT,
	justificacion VARCHAR(255),
	modalidad VARCHAR(50),
	tipoCapacitacionProgramada VARCHAR(45),
	costoCurso FLOAT,
	costoTotal FLOAT,
	CONSTRAINT fk_solicitudCapacitacion_puesto FOREIGN KEY (idPuesto) REFERENCES puesto(idPuesto),
	CONSTRAINT fk_solicitudCapacitacion_persona FOREIGN KEY (idPersona) REFERENCES persona(idPersona),
	CONSTRAINT fk_solicitudCapacitacion_area FOREIGN KEY (idArea) REFERENCES area(idArea)
);

-- ------------- TABLA SOLICIANTE -------------- --
CREATE TABLE solicitante(
	idSolicitante 		INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	idArea 				INT NOT NULL,
	idPersona 			INT NOT NULL,
	nombreSolicitante 	VARCHAR(50),
	programaEducativo 	VARCHAR(50),
	puesto 				VARCHAR(45),
	tipoCompetencias 	VARCHAR(25)
	CONSTRAINT fk_solicitante_area FOREIGN KEY (idArea)REFERENCES area(idArea),
	CONSTRAINT fk_solicitante_persona FOREIGN KEY (idPersona) REFERENCES persona(idPersona)
);

-- ------------- TABLA FACILITADOR -------------- --
CREATE TABLE facilitador(
	idFacilitador 		INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	IdArea 				INT NOT NULL,
	nombreFacilitador 	VARCHAR(50),
	programaEducativo 	VARCHAR(50),
	CONSTRAINT fk_facilitador_area FOREIGN KEY (idArea)REFERENCES area(idArea),
);

-- ------------- TABLA SOLICITUD DE REGISTRO DE CAPACITACI�N INTERNA -------------- --
CREATE TABLE solicitud_capacitacion_interna(
	cve_sol_cap_int 				INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	cve_instructor 		INT NOT NULL,
	cve_orientacion_evento 		INT NOT NULL,
	cve_curso 			INT NOT NULL,
	total_dias 			INT,
	total_horas 			INT,
	numero_participantes INT,
	objetivo 			TEXT,
	alcance 			TEXT,
	metodologia 		VARCHAR(50),
	programa_evento 	VARCHAR(50),
	horas_tema 		INT,
	resultado_aprendizaje TEXT,
	perfil_participante TEXT,
	activo 				BIT,
	fecha_registro 		DATETIME,
	usuario_registro 	INT
	CONSTRAINT fk_solicitud_facilitador FOREIGN KEY (idFacilitador)REFERENCES facilitador(idFacilitador),
	CONSTRAINT fk_solicitud_curso FOREIGN KEY (idCurso)REFERENCES curso(idCurso),
	CONSTRAINT fk_solicitud_solicitante FOREIGN KEY (idSolicitante)REFERENCES solicitante(idSolicitante)
);

-- ------------- CUESTIONARIO DE EVALUCACION DE CURSOS -------------- --
CREATE TABLE cuestionarioEvalucionCurso(
	idCuestionarioEvalucionCurso INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	idSolicitante INT NOT NULL,
	idAcademia INT NOT NULL,
	idCurso INT NOT NULL,
	noParticipantes INT, 
	fechaEvaluacion DATE,
	cumplimientoProgramaC BIT,
	contenidoCurso TEXT,
	aprendizajeObtenido BIT, 
	expliacacionAprendizajeObtenido TEXT,
	recomendarCurso BIT, 
	explicacionRecomeendacion TEXT,
	CONSTRAINT fk_cuestionarioEvalucionCursos_solicitante FOREIGN KEY (idSolicitante)REFERENCES solicitante(idSolicitante),
	CONSTRAINT fk_cuestionarioEvalucionCursos_academia FOREIGN KEY (idAcademia)REFERENCES academia(idAcademia),
	CONSTRAINT fk_cuestionarioEvalucionCursos_curso FOREIGN KEY (idCurso)REFERENCES curso(idCurso)
);

-- ------------- TABLA ESPACIOS -------------- --
CREATE TABLE espacio(
	idEspacio INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	nombreEspacio VARCHAR(25) -- Aula, Auditorio, Sala
);

-- ------------- TABLA HORARIO -------------- --
CREATE TABLE horario(
	idHorario INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	horaInicio TIME,
	horaFin TIME
);

-- ------------- TABLA TIPO INSTRUCTOR -------------- --
CREATE TABLE tipoInstructor(
	idTipoInstructor INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombreTipoInstructor VARCHAR(50)
);

-- ------------- TABLA INSTRUCTORES -------------- --
CREATE TABLE instructor(
	idInstructor INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	idTipoInstructor INT NOT NULL,
	nombreInstructor VARCHAR(50),
	CONSTRAINT fk_instructor_tipoInstructor FOREIGN KEY (idTipoInstructor) REFERENCES tipoInstructor(idTipoInstructor),
);

-- ------------- TABLA GRUPO EVENTOS -------------- --
CREATE TABLE grupoEvento(
	idGrupoEvento INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	idEvento INT NOT NULL,
	idInstructor INT NOT NULL,
	idEspacio INT NOT NULL,
	idHorario INT NOT NULL,
	fechaInicio DATE,
	fechaFin DATE,
	CONSTRAINT fk_grupoEvento_evento FOREIGN KEY (idEvento) REFERENCES evento(idEvento),
	CONSTRAINT fk_grupoEvento_instructor FOREIGN KEY (idInstructor) REFERENCES instructor(idInstructor),
	CONSTRAINT fk_grupoEvento_espacio FOREIGN KEY (idEspacio) REFERENCES espacio(idEspacio),
	CONSTRAINT fk_grupoEvento_horario FOREIGN KEY (idHorario) REFERENCES horario(idHorario)
);

-- ------------- TABLA GRUPO EVENTOS INSCRITOS -------------- --
CREATE TABLE grupoEventosInscritos(
	idGrupoEvento INT NOT NULL,
	idEmpleado INT NOT NULL,
	calificacionEmpleado INT,
	aprobadoEmpleado BIT,
	faltasEmpleado INT,
	fechaCalificacionEmpleado DATE,
	calificacionCurso INT,
	observacionCurso TEXT,
	calificacionInstructor INT,
	calificacionOrganizacion INT,
	impacto TEXT,
	cursoRecomendable VARCHAR(129),
	fechaCalificacionCurso DATE,
	calificacionAutoevaluacion INT,
	evidenciaAplicacionCurso TEXT,
	fechaAutoevaluacio DATE,
	CONSTRAINT fk_agrupoEventosInscritos_empleado FOREIGN KEY (idEmpleado) REFERENCES empleado(idEmpleado)
);