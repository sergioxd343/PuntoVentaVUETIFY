-- =============================================
-- Author:	Simón Zendejas, Maria Gutiérrez, 
--			Sergio Hernandez, Carlos De Pro, 
--			Brenda Gutiérrez
-- Create date: 22-03-2023
-- Description:	Son los Scripts DDL para la base 
--				del datos del proyecto Mauri
-- =============================================

-- ------------- TABLA PERSONA -------------- --
CREATE TABLE persona(
	idPersona			INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre				VARCHAR(50),
	primerApellido		VARCHAR(50) NOT NULL,
	segundoApellido		VARCHAR(50),
	genero              CHAR(1) NOT NULL DEFAULT 'O', -- Genero: M; F; O;
	fechaNacimiento 	DATE NOT NULL,
	calle 				VARCHAR(129) NOT NULL DEFAULT '',
	numero 				VARCHAR(20)  NOT NULL DEFAULT '',
	colonia 			VARCHAR(40) NOT NULL DEFAULT '',
	cp 					VARCHAR(25) NOT NULL DEFAULT '', -- Aunque el CP es un numero, se maneja como cadena por la internacionalización
	ciudad 				VARCHAR(40) NOT NULL DEFAULT '',
	estado 				VARCHAR(40) NOT NULL DEFAULT '',
	telcasa             VARCHAR(20) NOT NULL DEFAULT '',
	telmovil            VARCHAR(20) NOT NULL DEFAULT '',
    email               VARCHAR(129) NOT NULL DEFAULT '',
    rfc 				VARCHAR(13) NOT NULL DEFAULT ''
);

-- ------------- TABLA UNIDAD ACADEMICA ------------- --
-- Creacion: 21/04/23 por Carlos René Andrade
CREATE TABLE unidadAcademica(
	idUnidadAcademica INT  NOT NULL IDENTITY(1,1) PRIMARY KEY,
	direccionArea VARCHAR(50),
	programaEducativo VARCHAR(50),
	nombreGestorResponsable VARCHAR(50),	
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
	idArea				INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombreArea			VARCHAR(100)
);

-- ------------- TABLA CURSO -------------- --
CREATE TABLE curso(
	idCurso INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	nombreCurso VARCHAR(50)
);

-- ----------------- TABLA PUESTO ------------------- --
-- CREACION: 21/04/23 por Carlos René Andrade
CREATE TABLE puesto(
	idPuesto INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	tipoPuesto VARCHAR(50)
);

-- ------------- TABLA CATEGORIA EVENTO -------------- --
CREATE TABLE categoriaEvento(
	idCategoriaEvento INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	nombreCategoria VARCHAR(50), -- Diplomado, Competencias digitales, Tecnicos,Estrategicos, Institucionales, Certificaciones
);

-- ------------- TABLA EVENTO -------------- --
CREATE TABLE evento(
	idEvento INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	idCategoriaEvento INT NOT NULL,
	idModalidad INT NOT NULL,
	idDanc INT NOT NULL,
	CONSTRAINT fk_evento_categoriaEvento FOREIGN KEY (idCategoriaEvento) REFERENCES categoriaEvento(idCategoriaEvento)
);

-- ------------- TABLA EMPLEADO -------------- --
CREATE TABLE empleado(
	idEmpleado			INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	idPersona			INT NOT NULL,
	idArea				INT NOT NULL,
	idCarrera			INT NOT NULL,
	numeroUnico         VARCHAR(65) NOT NULL DEFAULT '',
    estatus             INT NOT NULL DEFAULT 1,
	CONSTRAINT fk_empleado_persona FOREIGN KEY (idPersona) REFERENCES persona(idPersona),
	CONSTRAINT fk_empleado_area FOREIGN KEY (idArea) REFERENCES area(idArea)
);

-- ------------- TABLA SOLICITUD PROYECTO -------------- --
CREATE TABLE solicitudProyecto(
	idSolicitudProyecto INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	idEmpleado			INT NOT NULL,
	idArea				INT NOT NULL,
	nombreProyecto		VARCHAR(100),
	fechaRegistro		DATE,
	ObjetivoProyecto	TEXT,
	DescripcionProyecto TEXT,
	RecursosNecesarios	TEXT,
	AcuerdosEstablecidos TEXT,
	estatus				BIT DEFAULT 1, -- El estatus puede tener 2 valores, (0-Cancelado, 1-Revisado)
	CONSTRAINT fk_solicitudProyecto_empleado FOREIGN KEY (idEmpleado) REFERENCES empleado(idEmpleado),
	CONSTRAINT fk_solicitudProyecto_area FOREIGN KEY (idArea) REFERENCES area(idArea)
);

-- ------------- TABLA ASESORAMIENTO -------------- --
CREATE TABLE asesoramiento(
	idAsesoaramiento	INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	idEmpleado			INT NOT NULL,
	nombreSolicitante	VARCHAR(50),
	fecha				DATE,
	motivoSolicitud		VARCHAR(50),
	compromisos			VARCHAR(100),
	fechaSeguimiento	DATE,
	responsable			VARCHAR(50),
	CONSTRAINT fk_asesoramiento_empleado FOREIGN KEY (idEmpleado) REFERENCES empleado(idEmpleado)
);

-- ------------- TABLA RUBRICA -------------- --
CREATE TABLE rubrica(
	idRubrica			INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	idEmpleado			INT NOT NULL,
	nombreRubica		Varchar(45),
	filas				VARCHAR(25),
	columnas			VARCHAR(25),
	nombreSeccion		VARCHAR(45),
	seccionaFilaInicio	VARCHAR(25),
	seccionFilaFin		VARCHAR(25),
	nombreColumna		VARCHAR(45),
	criteriosPorCelda	TEXT,
	CONSTRAINT fk_rubrica_empleado FOREIGN KEY (idEmpleado) REFERENCES empleado(idEmpleado)
);

-- ------------- TABLA OBSERVACIÓN DE CLASE -------------- --
CREATE TABLE observacionClase(
	idEmpleado			INT NOT NULL,
	idEmpleadoDocente	INT NOT NULL,
	idMateria			INT NOT NULL,
	idRubrica			INT NOT NULL,
	seccion				VARCHAR(45),
	calificacionSeccion INT,
	calificacionTotal	INT,
	CONSTRAINT fk_observacionClase_empleado FOREIGN KEY (idEmpleado) REFERENCES empleado(idEmpleado),
	CONSTRAINT fk_observacionClase_rubrica FOREIGN KEY (idRubrica) REFERENCES rubrica(idRubrica)
);

-- ------------- TABLA ENCUESTA DE SATISFACCIÓN Y EVALUACION DE RESULTADOS -------------- --
CREATE TABLE encuestaSatisfaccionEvaluacio(
	idEmpleado			INT NOT NULL,
	idEvaluacionServicios INT NOT NULL,
	idArea				INT NOT NULL,
	nombreEvaluador		VARCHAR(50),
	cuatrimestre		VARCHAR(8),
	fecha				DATETIME,
	comentariosSegerencias TEXT
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

-- ------------- TABLA DANC -------------- --
CREATE TABLE danc (
	idDanc INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	idEmpleado INT NOT NULL,
	anioEjercicio DATETIME,
	direccionSubdireccion VARCHAR(140),
	fechaElaboracion DATETIME,
	unidadAcademica VARCHAR(45),
	nivelEducativo VARCHAR(45),
	direccionArea VARCHAR(140),
	programaEducativo VARCHAR(50),
	responsable VARCHAR(50),
	necesidadesDetectadas TEXT,
	nombreEvento VARCHAR(50),
	objetivoEvento TEXT,
	orientacionEvento TEXT,
	justificacion TEXT,
	tipoEvento VARCHAR(50),
	otroTipoEvento VARCHAR(50),
	tipoPrograma VARCHAR(50),
	proveedor VARCHAR(50),
	costoCapacitacion FLOAT,
	origenCurso VARCHAR(50),
	mes VARCHAR(15),
	fechaInicio DATETIME,
	fechaTemino DATETIME,
	numDias INT,
	numHorasEfectivas INT,
	CONSTRAINT fk_danc_empleado FOREIGN KEY (idEmpleado) REFERENCES empleado(idEmpleado)
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
	Direccion VARCHAR(50),
	programaEducativo VARCHAR(50),
	CONSTRAINT fk_lac_evento FOREIGN KEY (idEvento) REFERENCES evento(idEvento),
	CONSTRAINT fk_lac_puesto FOREIGN KEY (idPuesto) REFERENCES puesto(idPuesto),
	CONSTRAINT fk_lac_persona FOREIGN KEY (idPersona) REFERENCES persona(idPersona)
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
	CONSTRAINT fk_solicitudCapacitacion_puesto FOREIGN KEY (idArea) REFERENCES area(idArea)
);

-- ------------- TABLA EVALUACION -------------- --
CREATE TABLE evaluacion (
    idEvaluacion		INT IDENTITY(1,1)NOT NULL PRIMARY KEY,
    numeroEmpleado		VARCHAR(50),
    eaEvaluacion		VARCHAR(50),
    nivel				FLOAT,
    descripcionNivelRetroalimentacion TEXT
);

-- ------------- TABLA RESULTADO -------------- --
CREATE TABLE resultado (
    idresultado			INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    cuatrimestre		VARCHAR(50),
    promedioEvaluacion	FLOAT,
    mediaInstitucional	FLOAT,
    retroalimentacionDesempenio TEXT
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
CREATE TABLE srci(
	idSolicitante 		INT NOT NULL,
	idFacilitador 		INT NOT NULL,
	idCurso 			INT NOT NULL,
	tipoCurso 			VARCHAR(45),
	totalDias 			INT,
	totalHoras 			INT,
	numeroParticipantes INT,
	objetivo 			TEXT,
	alcance 			TEXT,
	metodologia 		VARCHAR(50),
	programaDelCurso 	VARCHAR(50),
	horasPorTema 		INT,
	resultadoDeAprendizaje TEXT,
	perfilDeParticipante TEXT,
	CONSTRAINT fk_solicitud_facilitador FOREIGN KEY (idFacilitador)REFERENCES facilitador(idFacilitador),
	CONSTRAINT fk_solicitud_curso FOREIGN KEY (idCurso)REFERENCES curso(idCurso),
	CONSTRAINT fk_solicitud_solicitante FOREIGN KEY (idSolicitante)REFERENCES solicitante(idSolicitante)
);

-- ------------- CUESTIONARIO DE EVALUCACION DE CURSOS -------------- --
CREATE TABLE cuestionarioEvalucionCursos(
	idSolicitante INT NOT NULL IDENTITY(1,1),
	idAcademia INT NOT NULL,
	idCurso INT NOT NULL,
	nombreSolicitante VARCHAR(50),
	noParticipantes INT, 
	nombreCurso VARCHAR(50),
	fechaEvaluacion DATE,
	cumplimientoProgramaC BIT,
	contenidoCurso VARCHAR(10),
	aprendizajeObtenido BIT, 
	expliacacionAprendizajeObtenido VARCHAR(50),
	recomendarCurso BIT, 
	explicacionRecomeendacion VARCHAR(50)
);

-- ------------- TABLA MODALIDAD EVENTO -------------- --
CREATE TABLE modalidadEvento(
	idModalidad INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	nombreModalidad VARCHAR(50), -- Presencial, Virtual sincronica, Vitual asincronica
);

-- ------------- TABLA ASESORIA PEDAGOGICA -------------- --
CREATE TABLE asesoriaPedagogica(
	idAsesoriaPedagogica INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	nombreAsosoriaPedagogica VARCHAR(50)
);

-- ------------- TABLA DESARROLLO DE PROYECTOS -------------- --
CREATE TABLE desarrolloProyecto(
	idDesarrolloProyecto INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	nombreDesarrolloProyecto VARCHAR(50)
);

-- ------------- TABLA MATERIAS DIPLOMADO -------------- --
CREATE TABLE materiasDiplomado(
	idMateriaDiplomado INT NOT NULL,
	nombreMateriaDiplomado VARCHAR(50),
	grado INT
);

-- ------------- TABLA CUMPLE PROGRAMA OBLIGATORIO -------------- --
CREATE TABLE cumpleProgramaObligatorio(
	idCumpleProgramaObligatorio INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	idProgramaObligatorio INT NOT NULL
);

-- ------------- TABLA OTROS EVENTOS -------------- --
CREATE TABLE otroEvento(
	idOtroEvento INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	nombreOtroEvento VARCHAR(50)
);

-- ------------- TABLA ESPACIOS -------------- --
CREATE TABLE espacio(
	idEpacio INT NOT NULL PRIMARY KEY IDENTITY(1,1),
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
	idTipoInstructor INT NOT NULL IDENTITY(1,1),
	nombreTipoInstructor VARCHAR(50)
);

-- ------------- TABLA INSTRUCTORES -------------- --
CREATE TABLE instructor(
	idInstructor INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	idTipoInstructor INT NOT NULL,
	nombreInstructor VARCHAR(50),
);

-- ------------- TABLA GRUPO EVENTOS -------------- --
CREATE TABLE grupoEvento(
	idGrupoEvento INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	idEvento INT NOT NULL,
	idInstructor INT NOT NULL,
	idEspacio INT NOT NULL,
	idHorario INT NOT NULL,
	fechaInicio DATE,
	fechaFin DATE
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
	fechaAutoevaluacio DATE
);