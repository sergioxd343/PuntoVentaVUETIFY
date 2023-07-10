-- =============================================
-- Author:	Simón Zendejas
-- Create date: 31-05-2023
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

-- ------------- TABLA MENU -------------- --
CREATE TABLE menu(
    cve_menu 					INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    cve_padre 					INT NOT NULL,
    nombre	 					VARCHAR(50),
    ruta 						VARCHAR(120),
    orden 						INT,
    activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA SUBMENU -------------- --
CREATE TABLE submenu(
    cve_menu 					INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    cve_padre 					INT NOT NULL,
    nombre 						VARCHAR(70),
    ruta 						VARCHAR(120),
    orden 						INT,
    activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA SUBMENU -------------- --
CREATE TABLE submenu_2(
    cve_menu 					INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    cve_padre 					INT NOT NULL,
    nombre 						VARCHAR(70),
    ruta 						VARCHAR(120),
    orden 						INT,
    activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA GRUPO_SEGURIDAD -------------- --
CREATE TABLE grupo_seguridad(
    cve_grupo_seguridad 		INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    nombre 						VARCHAR(50),
    tiempo_sesion 				INT,
    activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA MENU_PERMISOS -------------- --
CREATE TABLE menu_permisos(
    cve_grupo_seguridad 		INT NOT NULL,
    cve_menu 					INT NOT NULL,
	activo						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA USUARIO_GRUPO_SEGURIDAD -------------- --
CREATE TABLE usuario_grupo_seguridad(
    cve_grupo_seguridad 		INT NOT NULL,
    cve_persona 				INT NOT NULL,
	activo						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA PERSONA -------------- --
CREATE TABLE persona(
	cve_persona					INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre						VARCHAR(50),
	apellido_paterno			VARCHAR(50) NOT NULL,
	apellido_materno			VARCHAR(50),
	email               		VARCHAR(129) NOT NULL DEFAULT '',
	movil            			VARCHAR(20) NOT NULL DEFAULT '',
	curp 						VARCHAR(18) NOT NULL DEFAULT '',
	rfc 						VARCHAR(13) NOT NULL DEFAULT '',
	sexo              			VARCHAR(20) NOT NULL, -- Genero: M; F; O;
	fecha_nacimiento 			DATE NOT NULL,	        
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA USUARIO_GRUPO_SEGURIDAD -------------- --
CREATE TABLE usuario(
	cve_usuario					INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cve_persona 				INT NOT NULL,
	nombre_usuario 				VARCHAR(50),
	contrasenia 				VARCHAR(50),
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT,
	CONSTRAINT fk_usuario_persona FOREIGN KEY (cve_persona)
	REFERENCES persona(cve_persona)
);

-- ------------- TABLA UNIDAD ACADEMICA ------------- --
CREATE TABLE unidad_academica(
	cve_unidad_academica 		INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre_unidad_academica 	VARCHAR(50),
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT	
);

-- ------------- TABLA ACADEMIA -------------- --
CREATE TABLE academia(
	cve_academia 				INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cve_unidad_academica 		INT,
	nombre_academia 			VARCHAR(50),
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT,
	CONSTRAINT fk_academia_unidad_academica FOREIGN KEY (cve_unidad_academica)
	REFERENCES unidad_academica(cve_unidad_academica)
);

-- ------------- TABLA PERIODO -------------- --
CREATE TABLE periodo(
	cve_periodo 				INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	fecha_inicio 				DATE,
	fecha_fin 					DATE,
	numero_periodo 				INT,
	descripcion 				VARCHAR(30),
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA AREA -------------- --
CREATE TABLE area(
	cve_area					INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre_area					VARCHAR(100),
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ----------------- TABLA UGAC ------------------- --
CREATE TABLE ugac(
	cve_ugac 					INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre_ugac 				VARCHAR(75),
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA CURSO -------------- --
CREATE TABLE curso(
	cve_curso 					INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	cve_periodo					INT NOT NULL,
	nombre_curso 				VARCHAR(50),
	tema						VARCHAR(70),
	objetivo					TEXT,
	alcance						TEXT,	
	fecha_autoevaluacion		DATE,
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT,
	CONSTRAINT fk_curso_periodo FOREIGN KEY (cve_periodo)
	REFERENCES periodo(cve_periodo)
);

-- ----------------- TABLA PUESTO ------------------- --
CREATE TABLE puesto(
	cve_puesto 					INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre_puesto 				VARCHAR(50),
	nivel_tabulador_puesto 		VARCHAR(25),
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ----------------- TABLA TIPO PUESTO ------------------- --
CREATE TABLE tipo_puesto(
	cve_tipo_puesto 				INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre_tipo_puesto 			VARCHAR(50),
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ----------------- TABLA DEPARTAMENTO ------------------- --
CREATE TABLE departamento(
	cve_departamento 			INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre_departamento 		VARCHAR(50),
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);


-- ------------- TABLA CATEGORIA EVENTO -------------- --
CREATE TABLE categoria_evento(
	cve_categoria_evento 		INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	nombre_categoria 			VARCHAR(50), -- Diplomado, Competencias digitales, Tecnicos,Estrategicos, Institucionales, Certificaciones
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA EMPLEADO -------------- --
CREATE TABLE empleado(
	cve_empleado				INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cve_persona					INT NOT NULL,
	cve_puesto					INT NOT NULL,
	cve_tipo_puesto				INT NOT NULL,
	cve_departamento			INT NOT NULL,
	cve_area					INT NOT NULL,
	cve_ugac					INT NOT NULL,
	cve_unidad_academica 		INT NOT NULL,
	fecha_ingreso				DATE,
	titulo_recibido				VARCHAR(50),
	grado_estudio				VARCHAR(25),
    activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT,
	CONSTRAINT fk_empleado_persona FOREIGN KEY (cve_persona) REFERENCES persona(cve_persona),
	CONSTRAINT fk_empleado_puesto FOREIGN KEY (cve_puesto) REFERENCES puesto(cve_puesto),
	CONSTRAINT fk_empleado_tipo_puesto FOREIGN KEY (cve_tipo_puesto) REFERENCES tipo_puesto(cve_tipo_puesto),
	CONSTRAINT fk_empleado_departamento FOREIGN KEY (cve_departamento) REFERENCES departamento(cve_departamento),
	CONSTRAINT fk_empleado_area FOREIGN KEY (cve_area) REFERENCES area(cve_area),
	CONSTRAINT fk_empleado_ugac FOREIGN KEY (cve_ugac) REFERENCES ugac(cve_ugac),
	CONSTRAINT fk_empleado_unidad_academica FOREIGN KEY (cve_unidad_academica) REFERENCES unidad_academica(cve_unidad_academica)
);

-- ------------- TABLA ORIGEN -------------- --
CREATE TABLE origen(
	cve_origen 					INT NOT NULL,
	nombre_origen				VARCHAR(100)
)

-- ------------- TABLA TIPO_ORIENTACION -------------- --
CREATE TABLE tipo_orientacion(
	cve_tipo_orientacion 		INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre_tipo_orientacion 	VARCHAR(50),
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA TIPO_EVENTO -------------- --
CREATE TABLE tipo_evento(
	cve_tipo_evento 			INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre_tipo_evento 			VARCHAR(50),
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA TIPO_MODALIDAD -------------- --
CREATE TABLE tipo_modalidad(
	cve_tipo_modalidad 			INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre_tipo_modalidad 		VARCHAR(50),
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA TIPO_INSTRUCTOR -------------- --
CREATE TABLE tipo_instructor(
	cve_tipo_instructor 		INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre_tipo_instructor 		VARCHAR(50),
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA TIPO_ORIGEN -------------- --
CREATE TABLE tipo_origen(
	cve_tipo_origen 			INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre_tipo_origen 			VARCHAR(50),
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA TIPO_CAPACITACION -------------- --
CREATE TABLE tipo_capacitacion(
	cve_tipo_capacitacion 		INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre_tipo_capacitacion 	VARCHAR(50),
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA TIPO_SERVICIO -------------- --
CREATE TABLE tipo_servicio(
	cve_tipo_servicio 			INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre_tipo_servicio 		VARCHAR(50),
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA TIPO_ESPACIO -------------- --
CREATE TABLE tipo_espacio(
	cve_tipo_espacio 			INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre_tipo_espacio 		VARCHAR(50),
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA SOLICITUD PROYECTO -------------- --
CREATE TABLE solicitud_proyecto(
	cve_solicitud_proyecto 		INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cve_area					INT NOT NULL,
	cve_periodo					INT NOT NULL,
	nombre_proyecto				VARCHAR(100),
	objetivo_proyecto			TEXT,
	descripcion_proyecto 		TEXT,
	recursos_necesarios			TEXT,
	acuerdos_establecidos 		TEXT,
	estatus						BIT DEFAULT 1, -- El estatus puede tener 2 valores, (0-Cancelado, 1-Revisado)
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT,
	CONSTRAINT fk_solicitud_proyecto_area FOREIGN KEY (cve_area) REFERENCES area(cve_area),
	CONSTRAINT fk_solicitud_proyecto_periodo FOREIGN KEY (cve_periodo) REFERENCES periodo(cve_periodo)
);

-- ------------- TABLA ASESORIA -------------- --
CREATE TABLE asesoria(
	cve_asesoria				INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	cve_empleado				INT NOT NULL,
	cve_academia				INT NOT NULL,
	materia						VARCHAR(50),
	fecha						DATE,
	motivo_solicitud			TEXT,
	sugerencias					TEXT,
	entrevista					TEXT,
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT,
	CONSTRAINT fk_asesoria_empleado FOREIGN KEY (cve_empleado) REFERENCES empleado(cve_empleado),
	CONSTRAINT fk_asesoria_academia FOREIGN KEY (cve_academia) REFERENCES academia(cve_academia)
);

-- ----------------- TABLA ASESORIA_D ------------------- --
CREATE TABLE asesoria_d(
	cve_asesoria 				INT NOT NULL,
	cve_responsable 			INT NOT NULL,
	compromiso 					TEXT,
	fecha_seguimiento 			DATE,
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT,
	CONSTRAINT fk_asesoria_d_asesoria FOREIGN KEY (cve_asesoria) REFERENCES asesoria(cve_asesoria),
	CONSTRAINT fk_asesoria_d_empleado_responsable FOREIGN KEY (cve_responsable) REFERENCES empleado(cve_empleado)
);

-- ------------- TABLA RUBRICA -------------- --
CREATE TABLE rubrica(
	cve_rubrica					INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cve_empleado				INT NOT NULL,
	nombre_rubica				VARCHAR(45),
	filas						VARCHAR(25),
	columnas					VARCHAR(25),
	nombre_seccion				VARCHAR(45),
	secciona_fila_inicio		VARCHAR(25),
	seccion_fila_fin			VARCHAR(25),
	nombre_columna				VARCHAR(45),
	criterios_por_celda			TEXT,
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT,
	CONSTRAINT fk_rubrica_empleado FOREIGN KEY (cve_empleado) REFERENCES empleado(cve_empleado)
);

-- ------------- TABLA RUBRICA OBSERVACIÓN DE CLASE -------------- --
CREATE TABLE rubrica_observacion_clase(
	cve_empleado_docente		INT NOT NULL,
	cve_rubrica					INT NOT NULL,
	seccion						VARCHAR(45),
	calificacion_seccion 		INT,
	calificacion_total			INT,
	cometario 					TEXT,
	estatus						BIT, -- Cancelado/Activo
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT,
	CONSTRAINT fk_rubrica_obs_clase_emp_doc FOREIGN KEY (cve_empleado_docente) REFERENCES empleado(cve_empleado),
	CONSTRAINT fk_rubrica_obs_clase_rubrica FOREIGN KEY (cve_rubrica) REFERENCES rubrica(cve_rubrica)
);

-- ------------- TABLA ENCUESTA DE SATISFACCIÓN Y EVALUACION DE RESULTADOS -------------- --
CREATE TABLE evaluacion_resultado(
	cve_eval_resul				INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cve_t_servicio 				INT NOT NULL,
	cve_asesoria_proyecto		INT,
	cve_area					INT NOT NULL,
	cve_solicitud_proyecto		INT,
	cve_periodo					INT NOT NULL,
	suma						INT,
	porcentaje 					FLOAT,
	comentarios 				TEXT,
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT,
	CONSTRAINT fk_evaluacion_resultado_t_servicio FOREIGN KEY (cve_t_servicio) REFERENCES tipo_servicio(cve_tipo_servicio),
	CONSTRAINT fk_evaluacion_resultado_area FOREIGN KEY (cve_area) REFERENCES area(cve_area),
	CONSTRAINT fk_evaluacion_resultado_periodo FOREIGN KEY (cve_periodo) REFERENCES periodo(cve_periodo)
);

-- ----------------- TABLA SOLICITUD FORMACION DOCENTE ------------------- --
CREATE TABLE solicitud_formacion_docente(
	cve_sol_form_doc 			INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cve_unidad_academica 		INT NOT NULL,
	cve_area 					INT NOT NULL,
	cve_departamento 			INT NOT NULL,
	cve_ugac 					INT NOT NULL,
	cve_tipo_evento 			INT NOT NULL,
	cve_tipo_orientacion 		INT NOT NULL,
	cve_empleado_valida			INT NOT NULL,
	cve_empleado_responsable 	INT NOT NULL,
	cve_empleado_autoriza 		INT NOT NULL,
	lugar 						VARCHAR(129),
	fecha 						DATE,
	horario 					DATETIME,
	numero_horas 				INT,
	centro_gestor 				VARCHAR(50),
	proyecto_presupuesto 		FLOAT,
	costo_total 				FLOAT,
	transferencia_nombre 		VARCHAR(50),
	transferencia_cuenta 		VARCHAR(25),
	transferencia_plaza 		VARCHAR(20),
	transferencia_banco 		VARCHAR(20),
	transferencia_clave 		VARCHAR(25),
	observaciones 				TEXT,
	estatus						INT, -- 1.- validado, 2.- con observaciones, 3.- autorizado
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT,
	CONSTRAINT fk_sol_form_doc_unidad_academica FOREIGN KEY (cve_unidad_academica) REFERENCES unidad_academica(cve_unidad_academica),
	CONSTRAINT fk_sol_form_doc_area FOREIGN KEY (cve_area) REFERENCES area(cve_area),
	CONSTRAINT fk_sol_form_doc_departamento FOREIGN KEY (cve_departamento) REFERENCES departamento(cve_departamento),
	CONSTRAINT fk_sol_form_doc_ugac FOREIGN KEY (cve_ugac) REFERENCES ugac(cve_ugac),
	CONSTRAINT fk_sol_form_doc_tipo_evento FOREIGN KEY (cve_tipo_evento) REFERENCES tipo_evento(cve_tipo_evento),
	CONSTRAINT fk_sol_form_doc_tipo_orientacion FOREIGN KEY (cve_tipo_orientacion) REFERENCES tipo_orientacion(cve_tipo_orientacion),
	CONSTRAINT fk_sol_form_doc_empleado_valida FOREIGN KEY (cve_empleado_valida) REFERENCES empleado(cve_empleado),
	CONSTRAINT fk_sol_form_doc_empleado_responsable FOREIGN KEY (cve_empleado_responsable) REFERENCES empleado(cve_empleado),
	CONSTRAINT fk_sol_form_doc_empleado_autoriza FOREIGN KEY (cve_empleado_autoriza) REFERENCES empleado(cve_empleado)
);

-- ----------------- TABLA SOLICITUD FORMACION DOCENTE_D ------------------- --
CREATE TABLE solicitud_formacion_docente_d(
	cve_sol_form_doc 			INT NOT NULL,
	cve_empleado_anotado 		INT NOT NULL,
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT,
	CONSTRAINT fk_sol_form_doc_d_empleado_anotado FOREIGN KEY (cve_empleado_anotado) REFERENCES empleado(cve_empleado),
);

-- ------------- TABLA DANC -------------- --
CREATE TABLE necesidad_capacitacion_anual (
	cve_nec_cap_anual 			INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cve_area_registro 			INT NOT NULL,
	cve_unidad_academica 		INT NOT NULL,
	cve_area 					INT NOT NULL,
	cve_departamento 			INT NOT NULL,
	cve_empleado_responsable 	INT NOT NULL,
	cve_orientacion_evento 		INT NOT NULL,
	cve_tipo_evento 			INT NOT NULL,
	cve_tipo_capacitacion 		INT NOT NULL,
	cve_origen_evento 			INT NOT NULL,
	nivel_academico				VARCHAR(15),
	direccion_subdireccion		VARCHAR(50),
	programa_academico			VARCHAR(100),
	anio_ejercicio 				VARCHAR(50),
	necesidades_detectadas 		TEXT,
	nombre_evento 				VARCHAR(50),
	objetivo_evento 			TEXT,
	justificacion 				TEXT,
	otro_tipo_evento 			VARCHAR(50),
	proveedor 					VARCHAR(50),
	costo_capacitacion 			FLOAT,
	mes 						VARCHAR(15),
	fecha_inicio 				DATE,
	fecha_temino 				DATE,
	num_dias 					INT,
	num_horas_efectivas 		INT,
	participantes_ptc 			INT,
	participantes_laboratoristas INT,
	participantes_administrativo INT,
	otros_participantes 		INT,
	total_participantes 		INT,
	total_hombres 				INT,
	total_mujeres 				INT,
	estatus						INT, -- 1.- permiso de ediciión, 2.- no autorizado, 3.- autorizado
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA SOLICITUD DE REGISTRO DE CAPACITACION INTERNA -------------- --
CREATE TABLE solicitud_capacitacion_interna(
	cve_sol_cap_int 			INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	cve_horario					INT NOT NULL,
	tipo_competencia			VARCHAR(15),
	nombre						VARCHAR(50),
	total_dias 					INT,
	total_horas 				INT,
	fecha_inicio				DATE,
	fecha_fin					DATE,
	lugar						VARCHAR(100),
	curso						VARCHAR(30), -- abierto a la comunidad utl, grupo cerrado
	numero_participantes 		INT,
	objetivo 					TEXT,
	alcance 					TEXT,
	metodologia 				VARCHAR(50),
	programa_evento 			VARCHAR(50),
	resultado_aprendizaje 		TEXT,
	perfil_participante 		TEXT,
	estatus						INT, -- 1.- permiso de edición, 2.- no autorizado, 3.- autorizado
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA ANALISIS SITUACIONAL DOCENTE -------------- --
CREATE TABLE analisis_docente(
	cve_analisis_docente 		INT IDENTITY (1,1) PRIMARY KEY,
	cve_unidad_academica		INT NOT NULL,
	cve_academia				INT NOT NULL,
	programa_educativo			VARCHAR(100),
	numero_ptc					INT,
	anio_aplicacion				INT,
	media_evaluacion_docente 	FLOAT,
	media_evaluacion_tutoreo  	FLOAT,	
	promedio_evaluacion_tutoreo FLOAT,
	promedio_evaluacion_docente FLOAT,
	porcentaje_docentes_acreditados FLOAT,
	fortalezas					TEXT,
	debilidades					TEXT,
	necesidades					TEXT,
	prioridad_capacitacion 		TEXT,
	estrategias_intervencion 	TEXT,
	estatus						BIT,
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA PROGRAMA DESARROLLO MATERIA -------------- --
CREATE TABLE programa_desarrollo_materia(
	cve_prog_des_mat			INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cve_prog_des 				INT NOT NULL,
	cve_modulo					INT NOT NULL,
	cve_materia 				INT NOT NULL,
	nombre_materia				VARCHAR(70),
	duracion 					VARCHAR(20),
	objetivo 					TEXT,
	resultado_aprendizaje 		TEXT,
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA PROGRAMA_DESARROLLO_CUMPLIMIENTO -------------- --
CREATE TABLE programa_desarrollo_cumplimento(
	cve_prog_des 				INT NOT NULL,
	cve_modulo 					INT NOT NULL,
	cve_materia 				INT NOT NULL,
	cve_empleado 				INT NOT NULL,
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA PROGRAMA_DESARROLLO_MODULO -------------- --
CREATE TABLE programa_desarrollo_modulo(
	cve_prog_des 				INT NOT NULL,
	cve_modulo 					INT NOT NULL,
	nombre_modulo 				VARCHAR(50),
	num_materias 				INT,
	color 						VARCHAR(20),
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA PROGRAMA_DESARROLLO -------------- --
CREATE TABLE programa_desarrollo(
	cve_prog_des 				INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre_prog_des 			VARCHAR(50),
	descripcion 				TEXT,
	numero_modulos 				INT,
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA INSTRUCTOR_EXTERNO -------------- --
CREATE TABLE instructor_externo(
	cve_instructor_e 			INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre_instructor 			VARCHAR(50),
	apellido_paterno 			VARCHAR(50),
	apellido_materno			VARCHAR(50),
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA INSTRUCTOR_EVENTO_PROGRAMADO -------------- --
CREATE TABLE instructor_evento_programado(
	cve_evento_programado 		INT NOT NULL,
	cve_tipo_instructor 		INT NOT NULL,
	cve_instructor 				INT NOT NULL,
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA EVENTO_PROGRAMADO -------------- --
CREATE TABLE evento_programado(
	cve_even_prog 				INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cve_origen_evento 			INT NOT NULL,
	cve_espacio 				INT NOT NULL,
	cve_modalidad 				INT NOT NULL,
	nombre_evento 				VARCHAR(50),
	nombre_origen 				VARCHAR(50),
	sin_horario 				BIT,
	horario_inicio 				TIME,
	horario_fin 				TIME,
	fecha_inicio 				DATE,
	fecha_fin 					DATE,
	estatus						INT, -- Cancelado, Cerrado, Programado y en Proceso
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA EVENTO_PROGRAMADO_GRUPO -------------- --
CREATE TABLE evento_programado_grupo(
	cve_even_prog_grupo 		INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cve_even_prog 				INT NOT NULL,
	cve_empleado 				INT NOT NULL,
	calificacion_empleado 		FLOAT,
	aprobado_empleado		 	BIT, 
	faltas_empleado 			INT,
	fecha_calificacion_empleado DATE,
	calificacion_curso 			INT,
	observacion_curso 			TEXT,
	calificacion_instructor 	INT,
	calificacion_organizacion 	INT,
	impacto 					TEXT,
	curso_recomendable 			BIT,
	fecha_calificacion_curso 	DATE,
	calificacion_autoevaluacion INT,
	evidencia_aplicacion_curso 	TEXT,
	fecha_autoevaluacion 		DATE,
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA EVALUCIÓN DE CAPACITACIÓN -------------- --
CREATE TABLE evaluacion_capacitacion(
	cve_eval_capa				INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cve_empleado_docente 		INT NOT NULL,
	cve_curso 					INT NOT NULL,
	nombre_facilitador 			VARCHAR(50),
	calificacion_final 			INT,
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA CALIFICACION -------------- --
CREATE TABLE calificacion(
	cve_calificacion 			INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	calificacion_diagnositca 	INT,
	examen_final 				INT,
	asistencia 					INT,
	participacion 				INT,
	desempenio_actividades 		INT,
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA MODALIDAD EVENTO -------------- --
CREATE TABLE modalidad_evento(
	cve_modalidad 				INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	nombre_modalidad 			VARCHAR(50), -- Presencial, Virtual sincronica, Vitual asincronica
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA ASESORIA PEDAGOGICA -------------- --
CREATE TABLE asesoria_pedagogica(
	cve_sesoria_pedagogica 		INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	nombre_asasoria_pedagogica 	VARCHAR(50),
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA REPORTE ACTP -------------- --
CREATE TABLE reporte_actp(
	cve_atcp 					INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cve_empleado				INT NOT NULL,
	cve_evaluacion_docente 		INT NOT NULL,
	cuatrimestre				VARCHAR(20),
	fecha						DATETIME,
	accion						VARCHAR(45),
	sintesis					VARCHAR(45),
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA LISTA DE ASISTENCIA DE CAPACITACION -------------- --
CREATE TABLE lista_asistencia_capacitacion(
	cve_asis_cap 				INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cve_asistencia	 			INT NOT NULL,
	cve_espacio 				INT NOT NULL,
	cve_horario 				INT NOT NULL,
    nombre_evento 				VARCHAR(50),
    fecha_evento 				DATE,
    num_sesiones 				SMALLINT,
    total_horas 				FLOAT,
    horario 					VARCHAR(50),
    nombre_instructor 			VARCHAR(50),
    lugar 						VARCHAR(50),
    tipo_actividad 				VARCHAR(50),
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA MODALIDAD EVENTO -------------- --
CREATE TABLE asistencia(
	cve_asistencia 				INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cve_puesto 					INT NOT NULL,
	nombre_empleado 			VARCHAR(50),
	num_control 				INT NOT NULL,
	discapacidad 				VARCHAR(50),
	direccion 					VARCHAR(50),
	programa_educativo 			VARCHAR(5), -- Si el capacitado es PTC o PA
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA SOLICIANTE -------------- --
CREATE TABLE solicitante(
	cve_solicitante 			INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cve_area 					INT NOT NULL,
	cve_persona 					INT NOT NULL,
	nombre_solicitante 			VARCHAR(50),
	programa_educativo 			VARCHAR(50),
	puesto 						VARCHAR(45),
	tipo_competencias 			VARCHAR(25),
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);


-- ------------- CUESTIONARIO DE EVALUCACION DE CURSOS -------------- --
CREATE TABLE cuestionario_evalucion_curso(
	cve_cuest_eval_curso 		INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	cve_tipo_curso 				INT NOT NULL,
	cve_jornada 				INT NOT NULL,
	nombre_instructor		 	VARCHAR(50),
	fecha 						DATE,
	cali_duracion 				INT,
	cali_cumplimiento_o 		INT,
	cali_contenido 				INT,
	cali_aprendizaje 			INT,
	cali_habil_acti_facilitador INT,
	cali_retroalimentacion_f 	INT,
	cali_motivacion_f 			INT,
	cali_oferta_curso 			INT,
	cali_proceso_inscripcion 	INT,
	cali_comite_organizador 	INT,
	cali_actitud_atencion_comite INT,
	cali_herramientas_curso 	INT,
	cali_actividacdes_desa 		INT,
	cali_objetivo_curso 		INT,
	principal_aprendizaje 		TEXT,
	comentarios 				TEXT,
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA TIPO_CURSO -------------- --
CREATE TABLE tipo_curso(
	cve_tipo_curso 				INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre_tipo_curso			VARCHAR(15), -- Presencial, Virtual o Mixto
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA JORNADA -------------- --
CREATE TABLE jornada(
	cve_jornada 				INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre_jornada 				VARCHAR(50), -- Matutino 8:00 a 12:00 horas, Duino  12:00 a 16:00 horas, Vespertino 16:00 a 20:00 horas o Vespertino-Nocturno 16:00 a 21:00 horas 
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA ESPACIOS -------------- --
CREATE TABLE espacio(
	cve_espacio 				INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	nombre_espacio 				VARCHAR(25), -- Aula, Auditorio, Sala
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA HORARIO -------------- --
CREATE TABLE horario(
	cve_horario 				INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	hora_inicio 				TIME,
	hora_fin 					TIME,
	descripcion					VARCHAR(30),
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA INSTRUCTORES -------------- --
CREATE TABLE instructor(
	cve_instructor 				INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	cve_tipo_instructor 		INT NOT NULL,
	nombre_instructor 			VARCHAR(50),
	area_academica				VARCHAR(50),
	programa_educativo 			VARCHAR(50),
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA SOLICITUD_INSTRUCTOR -------------- --
CREATE TABLE solicitud_instructor(
	cve_sol_cap_int 			INT NOT NULL,
	cve_instructor 				INT NOT NULL,
	cve_area 					INT NOT NULL,
	cve_ugac					INT NOT NULL,
	FOREIGN KEY (cve_sol_cap_int) REFERENCES solicitud_capacitacion_interna(cve_sol_cap_int),
	FOREIGN KEY (cve_instructor) REFERENCES instructor(cve_instructor),
	FOREIGN KEY (cve_area) REFERENCES area(cve_area),
	FOREIGN KEY (cve_ugac) REFERENCES ugac(cve_ugac)
);

-- ------------- TABLA GRUPO EVENTOS -------------- --
CREATE TABLE grupo_evento(
	cve_grupo_evento 			INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	cve_evento 					INT NOT NULL,
	cve_instructor 				INT NOT NULL,
	cve_espacio 				INT NOT NULL,
	cve_eorario 				INT NOT NULL,
	fecha_inicio 				DATE,
	fecha_fin			 		DATE,
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);

-- ------------- TABLA AUTOEVALUACION CAPACITACION DOCENTE -------------- --
CREATE TABLE autoevaluacion_capacitacion_docente(
	cve_autoe_cap_doc 			INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cve_empleado 				INT NOT NULL,
	evidencias					VARCHAR(35), -- calificaciones de estudiantes, encuestas a estudiantes, resultados de evaluación docente, entrevistas a estudiantes, ninguno, otro
	factores_identificacion		TEXT,
	factores_aplicacion			TEXT,
	promedio					FLOAT,
	estatus						INT, -- 1.- Cancelado, 2.- Proceso, 3.- Cerrado
	activo 						BIT DEFAULT 1,
	fecha_registro 				DATETIME DEFAULT GETDATE(),
	usuario_registro 			INT
);
