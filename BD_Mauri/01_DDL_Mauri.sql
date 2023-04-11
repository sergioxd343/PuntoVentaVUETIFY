-- =============================================
-- Author:	Simón Zendejas, Maria Gutiérrez, 
--			Sergio Hernandez, Carlos De Pro, 
--			Brenda Gutiérrez
-- Create date: 22-03-2023
-- Description:	Son los Scripts DDL para la base 
--				del datos del proyecto Mauri
-- =============================================

DROP DATABASE IF EXISTS mauri;

CREATE DATABASE mauri;

-- ------------- TABLA AREA -------------- --
CREATE TABLE area(
	idArea INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombreArea VARCHAR(100)
);

-- ------------- TABLA PROYECTO -------------- --
CREATE TABLE proyecto(
	idProyecto INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	idArea INT NOT NULL,
	nombreProyecto VARCHAR(100),
	fechaRegistro DATE,
	ObjetivoProyecto VARCHAR(150),
	DescripcionProyecto VARCHAR(250),
	RecursosNecesarios VARCHAR(100),
	AcuerdosEstablecidos VARCHAR(100),
	estatus BIT
);

-- ------------- TABLA ACADEMIA -------------- --
CREATE TABLE academia(
	idAcademia INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	unidadAcademica VARCHAR(50),
	nivelEducativo VARCHAR(50),
	direccionArea VARCHAR(50),
	programaEducativo VARCHAR(50),
	nombreGestorResponsable VARCHAR(50)
);

-- ------------- TABLA ASESORADO -------------- --
CREATE TABLE asesorado (
	idAsesorado INT IDENTITY (1,1) PRIMARY KEY,
	nombreDocente VARCHAR(50),
	materia VARCHAR(50),
	solicitante VARCHAR(50),
	fecha DATE,
	practicaDocente BIT,
	explicacionPractica VARCHAR(255) 
);

-- ------------- TABLA ASESORIA -------------- --
CREATE TABLE asesoria (
	idAsesoria INT IDENTITY (1,1) PRIMARY KEY,
	suferenciaPractica TEXT,
	descripcionSugerencia VARCHAR(255),
	descripcionEnttevista VARCHAR(255),
	compromisos VARCHAR(255),
	fechaSegumiento DATE,
	responsable VARCHAR(50)
);	

-- ------------- TABLA ASESORAMIENTO -------------- --
CREATE TABLE asesoramiento(
	idAsesoramiento INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	idAsesorado INT NOT NULL,
	idAsesoria INT NOT NULL,
	idAcademia INT NOT NULL,
	nombreDocente VARCHAR(50),
	solicitante VARCHAR(50),
	fecha DATETIME,
	motivoSolicitud VARCHAR(50),
	sugerenciaPracticas BIT,
	descripcionSugerencias VARCHAR(100),
	descripcionEntrevista VARCHAR(100),
	compromisos VARCHAR(100),
	fechaSeguimiento DATETIME,
	responsable VARCHAR(50),
	CONSTRAINT fk_asesoramiento_asesorado FOREIGN KEY (idAsesorado) REFERENCES asesorado(idAsesorado),
	CONSTRAINT fk_asesoramiento_asesoria FOREIGN KEY (idAsesoria) REFERENCES asesoria(idAsesoria),
	CONSTRAINT fk_asesoramiento_academia FOREIGN KEY (idAcademia) REFERENCES academia(idAcademia)
);

-- ------------- TABLA ANALISIS SITUACIONAL DOCENTE -------------- --
CREATE TABLE asd(
	idASD INT IDENTITY (1,1) PRIMARY KEY,
	idUnidadAcademica INT NOT NULL,
	idProgramaEducativo INT NOT NULL,
	idTipoEvento INT NOT NULL,
	numPTC INT,
	fechaElaboración DATETIME,
	añoAplicacion INT,
	mediaEvaluaciónDocente FLOAT,
	mediaEvaluaciónTutoreo  FLOAT,	
	promedioEvaluaciónTutoreo FLOAT,
	promedioEvaluaciónDocente FLOAT,
	porcentajeDocentesAcreditados FLOAT,
	fortalezas VARCHAR(255),
	debilidades VARCHAR(255),
	necesidades VARCHAR(255),
	prioridadCapacitación VARCHAR(255),
	estrategiasIntervención VARCHAR(255)
);

-- ------------- TABLA CURSO -------------- --	
CREATE TABLE curso(
	idCurso INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombreCurso VARCHAR(50),
	fechaCurso DATE,
	horaCurso TIME,
	lugar VARCHAR(150)
);

-- ------------- TABLA DOCENTE -------------- --
CREATE TABLE docente(
	idDocente INT NOT NULL IDENTITY (1,1) PRIMARY KEY,
	nombreDocente VARCHAR(50),
	puesto VARCHAR(15),
	apellidosDocente VARCHAR(50),
	sexo CHAR(1),
	ptc_pa VARCHAR(50),
	area VARCHAR(50),
	carrera VARCHAR(50)
);

-- ------------- TABLA CALIFICACION -------------- --
CREATE TABLE calificacion(
	idCalificacion INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	calificacionDiagnostico FLOAT,
	calificacionFinal FLOAT,
	examenFinal FLOAT,
	asistencia FLOAT,
	participacion FLOAT, 
	desempenioActividades FLOAT
);

-- ------------- TABLA EVALUACION DE CAPACITACION DOCENTE -------------- --
CREATE TABLE ecd(  
	idECD INT IDENTITY (1,1) PRIMARY KEY,
	idCurso INT NOT NULL,
	idDocente INT NOT NULL,
	idCalificacion INT NOT NULL,
	nombreCurso VARCHAR(50),
	nombreFacilitador VARCHAR(50),
	constancia BIT,
	examenFinal SMALLINT,
	asistencia SMALLINT,
	participacion SMALLINT,
	desempenioActividades SMALLINT,
	CONSTRAINT fk_ecd_curso FOREIGN KEY (idCurso) REFERENCES curso(idCurso),
	CONSTRAINT fk_ecd_docente FOREIGN KEY (idDocente) REFERENCES docente(idDocente),
	CONSTRAINT fk_ecd_calificacion FOREIGN KEY (idCalificacion) REFERENCES calificacion(idCalificacion)
);

-- ------------- TABLA EVENTO -------------- --
CREATE TABLE evento (
   idEvento INT PRIMARY KEY,
   idAcademia INT FOREIGN KEY REFERENCES academia(idAcademia),
   nombreEventoCapacitacion VARCHAR(50),
   objetivoEvento VARCHAR(100),
   orientacionEvento VARCHAR(50),
   justificacionEvento VARCHAR(100),
   tipoEvento VARCHAR(50),
   otroTipoEvento VARCHAR(50),
   tipoPrograma VARCHAR(50),
   proveedorSugerido VARCHAR(50),
   costoCapacitacionSugerido DECIMAL(10,2),
   origenRecursoEvento VARCHAR(50)
);

-- ------------- TABLA LISTA DE ASISTENCIA DE CAPACITACION -------------- --
CREATE TABLE lac(
	idAsistencia INT IDENTITY (1,1) PRIMARY KEY,
	idEvento INT NOT NULL,
    nombreEvento VARCHAR(50),
    fechaEvento DATETIME,
    numSesiones SMALLINT,
    totalHoras FLOAT,
    horario VARCHAR(50),
    nombreInstructor VARCHAR(50),
    lugar VARCHAR(50),
    tipoActividad VARCHAR(50),
	numControl INT NOT NULL,
	nombre VARCHAR(50),
	sexo VARCHAR(50),
	discapacidad VARCHAR(50),
	Puesto VARCHAR(50),
	Direccion VARCHAR(50),
	programaEducativo VARCHAR(50),
	CONSTRAINT fk_lac_evento FOREIGN KEY (idEvento) REFERENCES evento(idEvento),
);

-- ------------- TABLA PERIODO -------------- --
CREATE TABLE periodo (
   idPeriodo INT PRIMARY KEY,
   idEvento INT FOREIGN KEY REFERENCES evento(idEvento),
   mes VARCHAR(50),
   fechaInicio DATE,
   fechaTermino DATE,
   numDias INT,
   numHorasEfectivas INT
);

-- ------------- TABLA PARTICIPANTES -------------- --
CREATE TABLE participantes (
   idParticipante INT PRIMARY KEY,
   idEvento INT FOREIGN KEY REFERENCES evento(idEvento),
   numPTC INT,
   numLaboratorista INT,
   numAdministrativo INT,
   numOtros INT,
   totalHombres INT,
   totalMujeres INT,
   lugarEvento VARCHAR(50)
);

-- ------------- TABLA VIATICOS -------------- --
CREATE TABLE viaticos (
	idViatico INT PRIMARY KEY,
	idParticipante INT FOREIGN KEY REFERENCES participantes(idParticipante),
	transporte_autobus DECIMAL(10,2),
	casetas DECIMAL(10,2),
	alimentacion DECIMAL(10,2),
	hospedaje DECIMAL(10,2),
	taxis DECIMAL(10,2),
	otroViatico DECIMAL(10,2),
	origenRecursoViaticos VARCHAR(50)
);

-- ------------- TABLA FACILITADOR -------------- --
CREATE TABLE facilitador(
	idFacilitador INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	IdArea INT NOT NULL,
	nombreFacilitador VARCHAR(50),
	programaEducativo VARCHAR(50),
	CONSTRAINT fk_facilitador_area FOREIGN KEY (idArea)REFERENCES area(idArea),
);

-- ------------- TABLA SOLICIANTE -------------- --
CREATE TABLE solicitante(
	idSolicitante INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	idArea INT NOT NULL,
	nombreSolicitante VARCHAR(50),
	programaEducativo VARCHAR(50),
	puesto VARCHAR(45),
	tipoCompetencias VARCHAR(25)
	CONSTRAINT fk_solicitante_area FOREIGN KEY (idArea)REFERENCES area(idArea)
);

-- ------------- TABLA SOLICITUD DE REGISTRO DE CAPACITACIÓN INTERNA -------------- --
CREATE TABLE srci(
	idSolicitante INT NOT NULL,
	idFacilitador INT NOT NULL,
	idCurso INT NOT NULL,
	tipoCurso VARCHAR(45),
	totalDias INT,
	totalHoras INT,
	numeroParticipantes INT,
	objetivo TEXT,
	alcance TEXT,
	metodologia VARCHAR(50),
	programaDelCurso VARCHAR(50),
	horasPorTema INT,
	resultadoDeAprendizaje TEXT,
	perfilDeParticipante TEXT,
	CONSTRAINT fk_solicitud_facilitador FOREIGN KEY (idFacilitador)REFERENCES facilitador(idFacilitador),
	CONSTRAINT fk_solicitud_curso FOREIGN KEY (idCurso)REFERENCES curso(idCurso),
	CONSTRAINT fk_solicitud_solicitante FOREIGN KEY (idSolicitante)REFERENCES solicitante(idSolicitante)
);

-- ------------- TABLA SOLICITUD CAPACITACION -------------- --
CREATE TABLE solicitudCapacitacion (
	idSolicitudCapacitacion INT PRIMARY KEY,
	fechaSolicitud DATE,
	folioAutorizacion INT,
	unidadAcademica VARCHAR(50),
	direccionAcademica VARCHAR(50),
	area VARCHAR(50),
	programaEducativo VARCHAR(50),
	numeroEmpleado INT,
	justificacion VARCHAR(255),
	modalidad VARCHAR(50),
	tipoCapacitacionProgramada BIT,
	costoCurso FLOAT,
	costoTotal FLOAT
);

-- ------------- TABLA DETALLE PARTICIPANTE -------------- --
CREATE TABLE detalleParticipante (
	idDetalleParticipante INT PRIMARY KEY,
	nombreParticipante VARCHAR(50),
	apellidosParticipante VARCHAR(50),
	sexo CHAR(1),
	puesto VARCHAR(50),
	tipoParticipante VARCHAR(50)
);

-- ------------- TABLA DOCENTE CAPACITACION -------------- --
CREATE TABLE docenteCapacitado (
	idDocenteCapacitado INT PRIMARY KEY,
	nombreCompleto VARCHAR(50) NOT NULL,
	apellidosNombre VARCHAR(50) NOT NULL,
	genero CHAR(1) NOT NULL, -- Genero: M; F; O;
	ptcPa VARCHAR(50) NOT NULL,
	area VARCHAR(50) NOT NULL,
	carrera VARCHAR(50) NOT NULL
);

-- ------------- TABLA CURSO CAPACITACION -------------- --
CREATE TABLE cursoCapacitacion (
	idCursoCapacitacion INT PRIMARY KEY,
	tema VARCHAR(50) NOT NULL,
	objetivo VARCHAR(200) NOT NULL,
	alcance VARCHAR(200) NOT NULL,
	periodoCurso VARCHAR(50) NOT NULL,
	fechaAutoevaluacion DATE NOT NULL,
	areaCapacitacion VARCHAR(50) NOT NULL,
	idDocenteCapacitado INT NOT NULL,
	CONSTRAINT fk_docente_capacitado FOREIGN KEY (idDocenteCapacitado) REFERENCES docenteCapacitado(idDocenteCapacitado)
);

-- ------------- CUESTIONARIO DE EVALUCACION DE CURSOS -------------- --
CREATE TABLE cuestionarioEvalucionCursos(
	idSolicitante INT NOT NULL IDENTITY(1,1),
	idAcademia INT NOT NULL,
	idCurso INT NOT NULL,
	nombreSolicitante VARCHAR(50),
	noParticipantes SMALLINT, 
	nombreCurso VARCHAR(50),
	fechaEvaluacion DATE,
	cumplimientoProgramaC BIT,
	contenidoCurso VARCHAR(10),
	aprendizajeObtenido BIT, 
	expliacacionAprendizajeObtenido VARCHAR(50),
	recomendarCurso BIT, 
	explicacionRecomeendacion VARCHAR(50)
);

-- ------------- TABLA ACADEMICO -------------- --
CREATE TABLE academico (
	numeroEmpleado VARCHAR(50) PRIMARY KEY,
	direccionAcademica VARCHAR(50),
	nombreDocente VARCHAR(120),
	academia VARCHAR(50)
);

-- ------------- TABLA INTERVENCION -------------- --
CREATE TABLE intervencion (
    idIntervencion INT PRIMARY KEY,
    numeroEmpleado VARCHAR(50),
    cuatrimestre VARCHAR(50),
    fecha DATETIME,
    accion TEXT,
    sintesis TEXT,
    FOREIGN KEY (numeroEmpleado) REFERENCES academico(numeroEmpleado)
);

-- ------------- TABLA EVALUACION -------------- --
CREATE TABLE evaluacion (
    idEvaluacion INT PRIMARY KEY,
    numeroEmpleado VARCHAR(50),
    eaEvaluacion VARCHAR(50),
    nivel FLOAT,
    descripcionNivelRetroalimentacion TEXT,
    FOREIGN KEY (numeroEmpleado) REFERENCES academico(numeroEmpleado)
);

-- ------------- TABLA RESULTADO -------------- --
CREATE TABLE resultado (
    idresultado int PRIMARY KEY,
    numeroEmpleado VARCHAR(50),
    cuatrimestre VARCHAR(50),
    promedioEvaluacion FLOAT,
    mediaInstitucional FLOAT,
    retroalimentacionDesempeno TEXT,
    FOREIGN KEY (numeroEmpleado) REFERENCES academico(numeroEmpleado)
);

-- ------------- TABLA ENCUESTA DE SATISFACCION Y EVALUCION -------------- --
CREATE TABLE ecuestaSatisfaccionEvaluacion(
	idEncuestaSatisfaccionEvaluacio INT NOT NULL IDENTITY(1,1),
	nombreEvaluador VARCHAR(80),
	cuatrimestre INT,
	areaAcademica VARCHAR(50),
	fecha DATE,
	servicioRecibido VARCHAR(50),
	nombreProyecto VARCHAR(50),
	calificacion INT
);
