USE mauri;
GO

-- ------------- INSERTS DE PERSONA -------------- --
INSERT INTO persona (nombre, apellido_peterno, apellido_materno, email, movil, curp, rfc, sexo, fecha_nacimiento, usuario_registro) 
            VALUES	('Simón Jonathan', 'Zendejas', 'Gutiérrez', '21000165@alumnos.utleon.edu.mx', '477 907 4784', 'ZEGS021226HGTNTMA0', 'ZEGS1234DFXXX', 'Masculino', '2002-12-26', 1),
					('Carlos Rene','Andrade','De Pro','20002741@alumnos.utleon.edu.mx','477 860 9622','ANDC021226HGTNTMA0','ANDC1234DFXXX','Masculino','2001-09-12',1),
					('Maria Guadalupe','Gutiérrez','Alcantar','21000035@alumnos.utleon.edu.mx','477 847 9181','GUAM021226HGTNTMA0','GUAM1234DFXXX','Femenino','2003-11-12',1),
					('Sergio','Hernandez','Tavarez','21000302@alumnos.utleon.edu.mx','477 200 6766','HETS021226HGTNTMA0','HETS1234DFXXX','Masculino','2002-05-21',1),
					('Brenda Esmeralda','Gutiérrez','Pérez','21000026@alumnos.utleon.edu.mx','472 184 6581','GUPB021226HGTNTMA0','GUPB1234DFXXX','Femenino','2003-04-12',1),
                    ('Luisa', 'López', 'Gómez', 'luisa@gmail.com', '1111111111', 'CURPLUISA123', 'RFCLUISA123', 'Femenino', '1992-02-20',  1),
                    ('Carlos', 'Hernández', 'García', 'carlos@gmail.com', '2222222222', 'CURPCARLOS456', 'RFCCARLOS456', 'Masculino', '1985-08-05',  1),
                    ('Ana', 'Martínez', 'Pérez', 'ana@gmail.com', '3333333333', 'CURPANA789', 'RFCANA789', 'Femenino', '1990-12-15',  1),
                    ('Jorge', 'Ramírez', 'Sánchez', 'jorge@gmail.com', '4444444444', 'CURPJORGE123', 'RFCJORGE123', 'Masculino', '1987-06-30', 1),
                    ('Laura', 'Gómez', 'Fernández', 'laura@gmail.com', '5555555555', 'CURPLAURA456', 'RFCLAURA456', 'Femenino', '1994-04-10',  1),
                    ('Miguel', 'Sánchez', 'González', 'miguel@gmail.com', '6666666666', 'CURPMIGUEL789', 'RFCMIGUEL789', 'Masculino', '1989-11-25',  1),
                    ('Isabel', 'Fernández', 'López', 'isabel@gmail.com', '7777777777', 'CURPISABEL123', 'RFCISABEL123', 'Femenino', '1996-03-05',  1),
                    ('Juan', 'Pérez', 'Gómez', 'juan@gmail.com', '1234567890', 'CURPJUAN123', 'RFCJUAN123', 'Masculino', '2000-01-01', 1),
                    ('María', 'García', 'López', 'maria@gmail.com', '0987654321', 'CURPMARIA456', 'RFCMARIA456', 'Femenino', '1995-05-15', 1),
                    ('Pedro', 'Rodríguez', 'Hernández', 'pedro@gmail.com', '5555555555', 'CURPPEDRO789', 'RFCPEDRO789', 'Masculino', '1988-10-10',  1);


-- ------------- INSERTS DE EMPLEADOS -------------- --
INSERT INTO empleado (cve_persona, cve_puesto, cve_tipo_puesto, cve_departamento, cve_area, cve_ugac, cve_unidad_academica, fecha_ingreso, titulo_recibido, grado_estudio, usuario_registro)
			VALUES (1, 3, 53, 1, 7, 1, 1, '2002', 'Técnico Superior', 'Educación Superior', 1),
                   (2, 1, 3, 1, 7, 1, 2, '2000', 'Ingeniería en Sistemas', 'Ingeniería',  1),
                   (3, 1, 3, 3, 3, 4, 1, '2001', 'Maestría en Administración', 'Maestría',  1),
                   (4, 1, 5, 3, 3, 3, 1, '2000', 'Licenciatura en contaduria', 'Licenciatura',  1),
                   (5, 2, 5, 4, 8, 4, 2, '1999', 'Doctorado en desechos', 'Doctorado',  1),
                   (6, 5, 5, 4, 8, 4, 2, '1998', 'Licenciatura en quimica', 'Licenciatura',  1),
                   (7, 4, 5, 5, 11, 5, 1, '2000', 'Licenciatura arte culinario', 'Licenciatura',  1),
                   (8, 3, 5, 5, 11, 6, 1, '2000', 'Técnico en bebidas', 'Técnico',  1),
                   (9, 5, 5, 1, 7, 1, 2, '2000', 'Ingenieria en Informática', 'Ingenieria',  1),
                   (10, 4, 5, 2, 18, 2, 1, '2000', 'Técnico en turismo', 'Técnico',  1),
                   (11, 3, 5, 3, 3, 3, 2, '2000', 'Licenciatura en economía', 'Licenciatura',  1),
                   (12, 2, 2, 1, 1, 1, 1, '2000', 'Licenciatura en Informática', 'Licenciatura', 1);

-- ------------- INSERTS DE USUARIOS -------------- --
INSERT INTO usuario (cve_persona, nombre_usuario, contrasenia, usuario_registro) 
			VALUES	(1, 'sjonathan', '56964', 1),
					(2, 'crene', '1234', 1),
					(3, 'gmaria', '4321', 1),
					(4, 'sergio', '7890', 1),
					(5, 'ebrenda', '7890', 1);


-- ------------- INSERTS DE MENU -------------- --
INSERT INTO menu (cve_padre, nombre, ruta, orden, usuario_registro) 
            VALUES  (0, 'Formación Docente', '-', 1, 1),
                    (0, 'Innovación Educativa', '-', 9, 1),
                    (0, 'Eventos', '-', 15, 1),
                    (0, 'Catalogos Pequeños', '-', 19, 1),
                    (0, 'Programas', '-', 31, 1),
					(0, 'Sistema', '-', 34, 1);

-- ------------- INSERTS DE  SUBMENU -------------- --
INSERT INTO submenu (cve_menu, cve_padre, nombre, ruta, orden, usuario_registro) 
            VALUES  (1, 1, 'Autoevaluación de Eficacia de Capacitación Docente', '../formacion_docente/autoevaluacion_capacitacion_docente.jsp', 2, 1),
                    (1, 1, 'Evaluación de Capacitación', '../formacion_docente/evaluacion_capacitacion.jsp', 3, 1),
                    (1, 1, 'Cuestionario de Evaluación de Cursos', '../formacion_docente/cuestionario_evaluacion_cursos.jsp', 4, 1),
                    (1, 1, 'Necesidad Capacitacion Anual(DANC)', '../formacion_docente/necesidad_capacitacion_anual.jsp', 5, 1),
                    (1, 1, 'Lista de Asistencia de Capacitación', '../formacion_docente/lista_asistencia_capacitacion.jsp', 6, 1),
                    (1, 1, 'Solicitud de Apoyo para la formación docente', '../formacion_docente/solicitud_formacion_docente.jsp', 7, 1),
                    (1, 1, 'Solicitud de Registro de Capacitación Interna', '../formacion_docente/solicitud_capacitacion_interna.jsp', 8, 1),
                    (2, 2, 'Encuesta de Satisfacción y Evaluación de Resultado', '../innovacion_educativa/evaluacion_resultado.jsp', 10, 1),
                    (2, 2, 'Detacción de necesidad para Asesoramiento', '../innovacion_educativa/asesoria.jsp', 11, 1),
                    (2, 2, 'Rúbrica de Observación de Clase', '../innovacion_educativa/rubrica_observacion_clase.jsp', 12, 1),
                    (2, 2, 'Analisis Situacional Docente', '../innovacion_educativa/analisis_situacional_docente.jsp', 13, 1),
                    (2, 2, 'Solicitud de Proyecto', '../innovacion_educativa/solicitud_proyecto.jsp', 14, 1),
                    (3, 3, 'Evento Programado', '../eventos/evento_programado.jsp', 16, 1),
                    (3, 3, 'Evento Programado Grupo', '../eventos/evento_programado_grupo.jsp', 17, 1),
                    (3, 3, 'Cumple programa de Desarrollo', '../eventos/cumple_programa_desarrollo.jsp', 18, 1),
                    (4, 4, 'Tipo Capacitación', '../catalogos_pequenios/tipo_capacitacion.jsp', 20, 1),
                    (4, 4, 'Tipo Espacio', '../catalogos_pequenios/tipo_espacio.jsp', 21, 1),
                    (4, 4, 'Tipo Evento', '../catalogos_pequenios/tipo_evento.jsp', 22, 1),
                    (4, 4, 'Tipo Instructor', '../catalogos_pequenios/tipo_instructor.jsp', 23, 1),
                    (4, 4, 'Tipo Modalidad', '../catalogos_pequenios/tipo_modalidad.jsp', 24, 1),
                    (4, 4, 'Tipo Orientación', '../catalogos_pequenios/tipo_orientacion.jsp',25, 1),
                    (4, 4, 'Tipo Origen', '../catalogos_pequenios/tipo_origen.jsp', 26, 1),
                    (4, 4, 'Tipo Servicio', '../catalogos_pequenios/tipo_servicio.jsp', 27, 1),
                    (4, 4, 'Periodo', '../catalogos_pequenios/periodo.jsp', 28, 1),
                    (4, 4, 'Horario', '../catalogos_pequenios/horario.jsp', 29, 1),
                    (4, 4, 'Instructor', '../catalogos_pequenios/instructor.jsp', 30, 1),
                    (5, 5, 'Programa de Desarrollo', '../programas/programa_desarrollo.jsp', 32, 1),
                    (5, 5, 'Programa de Desarrollo de Módulos', '../programas/programa_desarrollo_modulo.jsp', 33, 1),
                    (5, 5, 'Programa de Desarrollo de Materia', '../programas/programa_desarrollo_materia.jsp', 34, 1),
					(6, 6, 'Perfil de usuario', 'perfil_usuario.jsp', 36, 1);

-- ------------- INSERTS DE MENU_PERMISOS -------------- --
INSERT INTO menu_permisos (cve_grupo_seguridad, cve_menu, usuario_registro) 
            VALUES  (1, 1, 1),
                    (1, 2, 1),
                    (1, 3, 1),
                    (1, 4, 1),
                    (1, 5, 1),
					(1, 6, 1),
					(2, 1, 1),
					(2, 2, 1),
					(2, 3, 1),
					(3, 1, 1),
					(3, 2, 1),
					(3, 3, 1);

-- ------------- INSERTS DE GRUPO_SEGURIDAD -------------- --
INSERT INTO grupo_seguridad (nombre, tiempo_sesion, usuario_registro) 
			VALUES  ('Administrador', 5000, 1),
					('Innovación Educativa', 5000, 1),
					('Formación Docente', 5000, 1),
					('Docente', 5000, 1),
                    ('Director', 5000, 1),
                    ('Subdirector', 5000, 1),
                    ('Gestor', 5000, 1),
                    ('DAyD', 5000, 1),
                    ('Instructor', 5000, 1),
                    ('Gestorias', 5000, 1);

-- ------------- INSERTS DE USUARIO_GRUPO_SEGURIDAD -------------- --
INSERT INTO usuario_grupo_seguridad (cve_grupo_seguridad, cve_persona, usuario_registro) VALUES (1, 1, 1);

-- ------------- INSERTS DE TIPO_ORIENTACION -------------- --
INSERT INTO tipo_orientacion (nombre_tipo_orientacion, usuario_registro) 
            VALUES  ('Desarrollo de Habilidades', 1),
                    ('Digitales', 1),
                    ('Investigación', 1),
                    ('Pedagógicas', 1),
                    ('Técnicas', 1),
                    ('Transversales', 1),
                    ('Tutoreo', 1);

-- ------------- INSERTS DE TIPO_EVENTO -------------- --
INSERT INTO tipo_evento (nombre_tipo_evento, usuario_registro)
            VALUES  ('Asistencia a congreso (3830)', 1),
                    ('Capacitación (3340)', 1),
                    ('Certificación (3920)', 1),
                    ('Convocatoria', 1),
                    ('Estancia de investigación', 1),
                    ('Ponencia en congreso (3830)', 1);

-- ------------- INSERTS DE TIPO_MODALIDAD -------------- --
INSERT INTO tipo_modalidad (nombre_tipo_modalidad, usuario_registro)
            VALUES  ('Horario trabajo', 1),
                    ('Fuera de Horario', 1);

-- ------------- INSERTS DE TIPO_INSTRUCTOR -------------- --
INSERT INTO tipo_instructor (nombre_tipo_instructor, usuario_registro)
            VALUES  ('Interno', 1),
                    ('Externo', 1);

-- ------------- INSERTS DE TIPO_ORIGEN -------------- --
INSERT INTO tipo_origen (nombre_tipo_origen, usuario_registro)
            VALUES  ('PFCE', 1),
                    ('Formación Docente', 1),
                    ('Dirección Académica', 1);

-- ------------- INSERTS DE TIPO_CAPACITACION -------------- --
INSERT INTO tipo_capacitacion (nombre_tipo_capacitacion, usuario_registro)
            VALUES  ('Interno', 1),
                    ('Externo', 1);

-- ------------- INSERTS DE TIPO_SERVICIO -------------- --
INSERT INTO tipo_servicio (nombre_tipo_servicio, usuario_registro)
            VALUES  ('Asesoría pedagógica', 1),
                    ('Desarrollo de proyecto', 1);

-- ------------- INSERTS DE TIPO_ESPACIO -------------- --
INSERT INTO tipo_espacio (nombre_tipo_espacio, usuario_registro)
            VALUES      ('Auditorio', 1),
                        ('Sala', 1),
                        ('Centros de computo', 1);

INSERT INTO instructor_evento_programado VALUES (1,1,1,1,GETDATE(),1),
                                                (2,1,2,1,GETDATE(),1);

-- ------------- INSERTS DE AREA -------------- --
INSERT INTO area (nombre_area, usuario_registro)
            VALUES  ('Dirección de Servicios Informáticos', 1),
                    ('Secretaría de Vinculación', 1),
                    ('Dirección de Administración y Finanzas', 1),
                    ('Dirección de Desarrollo Académico y Docente', 1),
                    ('Dirección de servicios de Atención al Estudiante', 1),
                    ('Dirección de Sustentabilidad para el Desarrollo', 1),
                    ('Dirección de Tecnologías de la Información y Comunicación', 1),
                    ('Dirección de Electromecánica Industrial', 1),
                    ('Dirección de Económico Administrativo', 1),
                    ('Dirección de Asuntos Jurídicos', 1),
                    ('Rectoría', 1),
                    ('Secretaria Académica', 1),
                    ('Contraloría Interna', 1),
                    ('Dirección de Planeación, Evaluación y Servicios Escolares', 1),
                    ('Unidad Académica de Acámbaro', 1),
                    ('Subdirección de Servicios Administrativos', 1),
                    ('Unidad Académica de Guanajuato', 1),
                    ('Licenciaturas UTL', 1),
                    ('Órgano Interno de Control', 1),
                    ('Dirección Académica de Tecnologías Emergentes Industriales e Informática', 1);



INSERT INTO programa_desarrollo (nombre_prog_des,descripcion,numero_modulos,usuario_registro) 
VALUES ('Inducción','Enseñanza',2,1),
		('Diplomado Innovación educativa','Tecnicas de enseñanza',15,1),
		('CURSOS COMPLEMENTARIOS','Competencias profesionales',7,1);

INSERT INTO programa_desarrollo_modulo(cve_prog_des,cve_modulo,nombre_modulo,num_materias,color,usuario_registro)
VALUES	(1,1,'Inducción',1,'gray',1),
		(1,2,'Inducción',1,'gray',1),
		(2,1,'Módulo 1 Modelos educativos Innovadores',1,'green',1),
		(2,2,'Módulo 1 Modelos educativos Innovadores',1,'green',1),
		(2,3,'Módulo 1 Modelos educativos Innovadores',1,'green',1),
		(2,4,'LA ORIENTACIÓN Y CONSEJERÍA EN LA NUEVA EDUCACIÓN',1,'yelow',1),
		(2,5,'LA ORIENTACIÓN Y CONSEJERÍA EN LA NUEVA EDUCACIÓN',1,'yelow',1),
		(2,6,'LA ORIENTACIÓN Y CONSEJERÍA EN LA NUEVA EDUCACIÓN',1,'yelow',1),
		(2,7,'DISEÑO DE UN CURSO CENTRADO EN EL APRENDIZAJE',1,'green',1),
		(2,8,'DISEÑO DE UN CURSO CENTRADO EN EL APRENDIZAJE',1,'geeen',1),
		(2,9,'DISEÑO DE UN CURSO CENTRADO EN EL APRENDIZAJE',1,'geeen',1),
		(2,10,'DISEÑO DE UN CURSO CENTRADO EN EL APRENDIZAJE',1,'geeen',1),
		(2,11,'EL ALUMNO Y SU APRENDIZAJE',1,'yelow',1),
		(2,12,'EL ALUMNO Y SU APRENDIZAJE',1,'yelow',1),
		(2,13,'EL ALUMNO Y SU APRENDIZAJE',1,'yelow',1),
		(2,14,'VALORES EN LA NUEVA EDUCACIÓN',1,'red',1),
		(2,15,'VALORES EN LA NUEVA EDUCACIÓN',1,'red',1),
		(3,1,'Módulo INVESTIGACIÓN',1,'blue',1),
		(3,2,'Módulo INVESTIGACIÓN',1,'blue',1),
		(3,3,'Módulo INVESTIGACIÓN',1,'blue',1),
		(3,4,'Módulo COMPETENCIAS',1,'red',1),
		(3,5,'Módulo COMPETENCIAS',1,'red',1),
		(3,6,'Módulo COMPETENCIAS',1,'red',1),
		(3,7,'Módulo ESCUELA INCLUYENTE',1,'pink',1);

INSERT INTO programa_desarrollo_materia (cve_prog_des,cve_modulo,cve_materia,nombre_materia,duracion,objetivo,resultado_aprendizaje,usuario_registro)
VALUES	(1,1,1,'INDUCCIÓN A LA UTL', '10', 'Proveer al nuevo profesor de información básica para el desarrollo de sus actividades académicas y administrativas, el aprovechamiento de los beneficios y la observación de las responsabilidades que obtiene como profesor de la Universidad.','El participante obtiene resultado aprobatorio en la evaluación final del curso comprobando que conoce los aspectos necesarios para el desarrollo de sus actividades y ejercicio de sus beneficios y responsabilidades como profesor UTL',1),
		(1,2,1,'MICROENSEÑANZA','20','Ofrecer a los maestros competencias docentes en la educación que junto a su experiencia y práctica en el uso y manejo de herramientas educativas propias, incremente su efectividad en el proceso enseñanza aprendizaje en el salón de clases','Contar con guía de retroinformación para mejoramiento de la impartición de clase',1),
		(2,1,1,'NUEVAS TENDENCIAS EN EDUCACIÓN SUPERIOR','12','·  Proveer a los profesores de una visión panorámica acerca de las tendencias y retos que enfrenta la educación superior. ·  Generar un ambiente de aprendizaje experiencial que permita a los profesores una reflexión sobre la práctica docente orientada hacia el futuro. ·  Identificar el comportamiento del docente dentro de cada unos de los paradigmas para direccionar su labor docente.','Mediante un trabajo escrito el participante relaciona su actividad docente con cada uno de los paradigmas educativos, para el logro del aprendizaje. Además hace una reflexión de la educación en un mundo globalizado.',1),
		(2,2,1,'UN MODELO EDUCATIVO CENTRADO EN EL APRENDIZAJE','12','Diseñar  recursos didácticos basados en el modelo centrado en el aprendizaje de las UTL','Generar una carpeta de evidencias de estrategias y recursos centrados en el aprendizaje aplicables a la planeación de cursos',1),
		(2,3,1,'EL PROFESIONAL EN LA ECONOMÍA DEL CONOCIMIENTO','16', '·  Conocer los elementos básicos de la Economía Basada en el Conocimiento (EBC). ·  Analizar cuáles son las habilidades, actitudes, aptitudes y valores que requiere el profesionista para insertarse exitosamente en la EBC. ·  Reflexionar sobre el papel del docente en la formación del egresado que exige el siglo XXI.','Mediante diferentes ejercicios el participante identifica las características del docente en la economía basada en el conocimiento y las exigencias de la educación siglo XXI.',1),
		(2,4,1,'INTERVENCIÓN TUTORIAL  EN LA EDUCACIÓN DE VANGUARDIA','16','·      Conocer aspectos generales de los programas de tutorías. ·      Identificar el rol de los participantes en el programa de tutoreo de la UTL. ·      Identificar herramientas básicas para el ejercicio tutorial.','Identificar el rol del tutor dentro del programa institucional,  las herramientas de intervención tutorial y su ejecución  en casos prácticos reales.',1),
		(2,5,1,'MANEJO TEÓRICO Y TÉCNICO DE LA ENTREVISTA','8', '·      Conocer los elementos básicos del proceso de la entrevista focalizada al trabajo tutorial de los estudiantes.', 'El participante aplica las técnicas de la entrevista para el seguimiento tutorial con sus estudiantes.',1),
		(2,6,1,'DETECCIÓN DE CONDUCTAS DE RIESGO EN JÓVENES UNIVERSITARIOS','16','·      Conocer los factores y conductas de riesgo que pueden manifestarse en los estudiantes, para lograr identificarlos y que se dé el seguimiento que corresponda. ','Mediante un estudio de casos, el participante integra a su rol  de profesor acciones de intervención ante la observación de conductas de riesgo.',1),
		(2,7,1,'APRENDIZAJE COLABORATIVO','20','·      Lograr que los integrantes conozcan las herramientas básicas del Aprendizaje Colaborativo, para el diseño de actividades de aprendizaje.','Competencia: Incorporar herramientas que proporciona el Aprendizaje Colaborativo en la planeación de la materia que el docente imparte.',1),
		(2,8,1,'APRENDIZAJE BASADO EN PROBLEMAS','20','·      Proporcionar a los participantes del curso herramientas básicas del Aprendizaje basado en Problemas, para el diseño de actividades de aprendizaje.','Incorporar herramientas que proporciona el Aprendizaje Basado en Problemas en la planeación de la materia que el docente imparte.',1),
		(2,9,1,'MÉTODO DE CASOS','20','·      Ofrecer a los participantes del curso las herramientas básicas de la Técnica Didáctica Método de Casos, para el diseño de actividades de aprendizaje.','Incorporar herramientas que proporciona el Método de Casos en la planeación de la materia que el docente imparte.',1),
		(2,10,1,'APRENDIZAJE ORIENTADO A PROYECTOS','20','·      Proveer a los integrantes del curso de herramientas básicas del Aprendizaje Orientado a Proyectos, para el diseño de actividades de aprendizaje.','Incorporar herramientas que proporciona el Aprendizaje Orientado a Proyectos en la planeación de la materia que el docente imparte.',1),
		(2,11,1,'PERFIL PSICOSOCIAL DEL ALUMNO UTL','8','·      Identificar las características del alumno de la Universidad Tecnológica de León tomando en cuenta las esferas psicológicas, familiares, escolares y sociales en que se desenvuelven.','Elaboración de un perfil del estudiante de la UTL  contemplando características del estudiante en las diferentes esferas en las que éste se desenvuelve',1),
		(2,12,1,'ESTILOS DE APRENDIZAJE Y SU BASE NEUROBIOLÓGICA','16','·      Identificar los diferentes estilos que existen para el  aprendizaje y la base neurobiológica  de ellos para la selección de técnicas adecuadas de acuerdo al estilo de los estudiantes.','El participante identifica mediante actividades el propio estilo de aprendizaje y lo relaciona con su rol docente.',1),
		(2,13,1,'TÉCNICAS DE APRENDIZAJE','16','·      Ofrecer diferentes alternativas sobre técnicas de estudio que puede utilizar el estudiante.','El participante seleccionará técnicas útiles que le apoyen en la impartición de su materia y con base en las características de sus alumnos.',1),
		(2,14,1,'ÉTICA FUNDAMENTAL Y ÉTICA DE LAS PROFESIONES','20', '·      Dotar a los maestros de un marco teórico holístico que relacione la ética con la educación para llevar a cabo el proceso de formación del alumno y de sí mismo.','Incluir elementos que teoriza la ética en la práctica docente que permitan mejorar y hacer significativa la labor docente.',1),
		(2,15,1,'RESPONSABILIDAD SOCIAL UNIVERSITARIA','20','·      Entablar una reflexión participativa sobre la responsabilidad social de la universidad, para que los diversos actores de la comunidad académica puedan comprender, convencerse, comprometerse con la RSU y contestar a la pregunta: ¿qué universidad queremos ser?','Incorporar medidas en la práctica docente que permitan mejorar y hacer significativas las contribuciones para una sociedad más justa y sostenible.',1),
		(3,1,1,'INTRODUCCIÓN A LA INVESTIGACIÓN','8','·       Conocer el método científico y los requerimientos a reunir para la realización de un proyecto de investigación.','Incorporar herramientas de investigación al trabajo de desarrollo docente y académico.',1),
		(3,2,1,'METODOLOGÍA DE LA INVESTIGACIÓN CUALITATIVA','16','·       Trabajar los conceptos nociones e instrumentos relacionados con la investigación cualitativa, revisar algunos de los instrumentos y técnicas en investigaciones sociales  y reconocer problemas de investigación considerando los aspectos más humanos, propios de la cotidianidad, en un ambiente de reflexión y colaboración grupal.','Generar un anteproyecto de investigación que lleve a incorporar herramientas de investigación al trabajo de desarrollo docente y académico.',1),
		(3,3,1,'METODOLOGÍA DE LA INVESTIGACIÓN CUANTITATIVA','16','·       Trabajar los conceptos nociones e instrumentos relacionados con la investigación cuantitativa, revisar los instrumentos y técnicas que se utilizan y sus ventajas e inconvenientes.','Generar un anteproyecto de investigación que lleve a incorporar herramientas de investigación al trabajo de desarrollo docente y académico.',1),
		(3,4,1,'INTRODUCCIÓN A LAS COMPETENCIAS','16','Vincular las competencias profesionales con los elementos de la hoja de asignatura para la creación de escenarios de aprendizaje que incluyan conocimientos específicos o técnicos, destrezas o procedimientos y actitudes congruentes con la propuesta de desarrollo del SER UTL','El participante revisa su metodología para el logro de los objetivos de aprendizaje de sus estudiantes y propone nuevos esquemas de trabajo y evaluación mediante el desarrollo de un escenario de aprendizaje y al menos un instrumento de evaluación del desempeño del estudiante conforme a la competencia establecida',1),
		(3,5,1,'COMPETENCIAS DEL SER','12','• Identificar un concepto compartido de las competencias genéricas institucionales. • Identificar las dimensiones que intervienen en el trabajo de competencias en el salón de clases. • Conocer la macro-rúbrica institucional de competencias genéricas institucionales. • Integrar las competencias del ser en la construcción de escenarios de aprendizaje, de forma que, el desempeño del alumno refleje de manera integrada los conocimientos, destrezas y actitudes propios de un profesionista de acuerdo con la currícula, el plan de la materia y la propuesta de  desarrollo de las competencias genéricas que caracterizan el SER UTL ', 'El participante revisa su propia metodología para alcanzar los objetivos de aprendizaje de sus estudiantes y propone nuevos esquemas de trabajo y evaluación para alcanzarlos mediante el desarrollo de un escenario de aprendizaje y un instrumento de evaluación que incluya conocimientos específicos o técnicos, destrezas y actitudes congruente con la propuesta de desarrollo del SER UTL',1),
		(3,6,1,'EVALUACIÓN POR COMPETENCIAS','12',' El profesor identifica y construye los instrumentos de evaluación de acuerdo a los aprendizajes que desea generar en el alumno','• Técnica de Octágonos para la Evaluación • Desarrollo de instrumentos  de evaluación de acuerdo a las evidencias.',1),
		(3,7,1,'SENSIBILIZACIÓN ANTE LA DISCAPACIDAD AUDITIVA EN EL AULA. ','12','Sensibilizar al participante sobre la importancia de ejercer una educación incluyente cuando se presenta un alumno con discapacidad auditiva. ','El profesor ajusta las estrategias de enseñanza aprendizaje para un caso de discapacidad auditiva.',1);

-- ------------- INSERTS DE PUESTO -------------- --
INSERT INTO puesto (nombre_puesto, nivel_tabulador_puesto, usuario_registro)
                VALUES  ('PTC', 'D', 1),
                        ('PA', 'HP', 1),
                        ('Técnico académico', 'PTC', 1),
                        ('Administrativo de área académica', 'HV3', 1),
                        ('Administrativo', 'HA', 1);


-- ------------- INSERTS DE CURSO -------------- --
INSERT INTO curso (cve_periodo, nombre_curso, tema, objetivo, alcance, fecha_autoevaluacion, usuario_registro)
VALUES
(1, 'Metodologías de Enseñanza Innovadoras', 'Diseño de estrategias pedagógicas creativas', 'Explorar diferentes enfoques y técnicas de enseñanza para fomentar la participación y el aprendizaje activo de los estudiantes.', 'El curso abarcará metodologías como el aprendizaje basado en proyectos, el aprendizaje invertido y el uso de la tecnología en el aula.', '2023-08-15', 1),
(1, 'Evaluación Formativa y Retroalimentación', 'Prácticas efectivas de evaluación educativa', 'Desarrollar habilidades en la planificación y aplicación de estrategias de evaluación formativa para mejorar el proceso de enseñanza y aprendizaje.', 'El curso abarcará técnicas como la rúbrica, la autoevaluación y la retroalimentación efectiva.', '2023-07-30', 1),
(2, 'Liderazgo Educativo', 'Gestión y liderazgo en entornos educativos', 'Examinar los conceptos y habilidades necesarios para ejercer un liderazgo efectivo en instituciones educativas y promover una cultura de mejora continua.', 'El curso abarcará temas como el liderazgo transformacional, la gestión del cambio y la toma de decisiones estratégicas.', '2023-09-10', 1),
(2, 'Diseño de Programas de Formación Docente', 'Desarrollo de planes de capacitación para profesores', 'Aprender a diseñar programas de formación docente que promuevan el crecimiento profesional y la actualización de conocimientos y habilidades de los profesores.', 'El curso abarcará la identificación de necesidades de capacitación, el diseño de contenidos y la evaluación de programas.', '2023-09-05', 1),
(3, 'Tecnología Educativa Aplicada', 'Integración de herramientas tecnológicas en la enseñanza', 'Explorar las posibilidades que ofrecen las tecnologías educativas para mejorar la enseñanza y el aprendizaje en el aula.', 'El curso abarcará el uso de plataformas digitales, aplicaciones móviles y recursos multimedia en la práctica docente.', '2023-10-15', 1);

-- ------------- INSERTS DE INSTRUCTOR -------------- --
INSERT INTO instructor (cve_tipo_instructor, nombre_instructor, area_academica, programa_educativo, usuario_registro)
                VALUES 
                        (1, 'Maria Guadalupe', 'Dirección de Servicios Informáticos', 'Desarrollo de software', 1),
                        (2, 'Simón Zendejas', 'Dirección de Servicios Informáticos', 'Desarrollo de software', 1),
                        (1, 'Sergio Tavarez', 'Secretaría de Vinculación', 'Academia de expreción oral y escrita', 1),
                        (2, 'Carlos Andrade', 'Dirección de Administración y Finanzas', 'Academia de matematicas', 1),
                        (1, 'Brenda Gutiérrez', 'Dirección de Desarrollo Académico y Docente', 'Academia de expreción oral y escrita', 1);


INSERT INTO espacio (nombre_espacio, usuario_registro) 
				VALUES
						('Aula magna',1),
						('CVD',1),
						('Auditorio D',1),
						('Auditorio f',1),
						('Auditorio A',1),
						('Patio civico',1);

INSERT INTO modalidad_evento (nombre_modalidad, usuario_registro) 
				VALUES
						('Virtual',1),
						('Presencial',1);

INSERT INTO evento_programado (cve_origen_evento, cve_espacio, cve_modalidad, nombre_evento, nombre_origen, sin_horario, horario_inicio, horario_fin, fecha_inicio, fecha_fin, usuario_registro)
				VALUES
						(1,2,2,'Estrategias pedagógicas','Pedagógia', '', '9:30', '11:00', '2023-05-10', '2023-05-18', 1),
						(1,1,2,'Comunicación','Comunicación', '', '2:00', '3:00', '2023-07-01', '2023-07-11', 1);



INSERT INTO unidad_academica (nombre_unidad_academica, usuario_registro) 
				VALUES
						('León',1),
						('Unidad Académica de Acambaro',1);


INSERT INTO academia (cve_unidad_academica, nombre_academia, usuario_registro)
VALUES  (1, 'Academia de Cálculo', 1),
        (1, 'Academia de Estadística', 1),
        (2, 'Academia de Sociología', 2),
        (2, 'Academia de Antropología', 2),
        (1, 'Academia de Ingeniería Eléctrica', 1);


INSERT INTO categoria_evento (nombre_categoria, usuario_registro) 
				VALUES
						('Estrategias pedagógicas', 1),
						('Comunicación', 1),
						('Herramientas digitales', 1),
						('Tutoreo', 1),
						('Investigación', 1);


INSERT INTO periodo (fecha_inicio, fecha_fin, numero_periodo, descripcion, usuario_registro) 
VALUES                          ('2023-01-09', '2023-04-29', 1, 'Enero - Abril 2023', 1),
                                ('2023-05-02', '2023-08-26', 2, 'Mayo - Agosto 2023', 1),
                                ('2023-09-05', '2023-12-17', 3, 'Septiembre - Diciembre 2023', 1),
                                ('2024-01-09', '2024-04-29', 1, 'Enero - Abril 2024', 1),
                                ('2024-05-02', '2024-08-26', 2, 'Mayo - Agosto 2024', 1),
                                ('2024-09-05', '2024-12-17', 3, 'Septiembre - Diciembre 2024', 1);

INSERT INTO horario (hora_inicio, hora_fin, descripcion, usuario_registro) 
VALUES                          ('07:00', '07:55', '07:00 - 07:55', 1),
                                ('08:00', '08:50', '08:00 - 08:50', 1),
                                ('08:55', '09:45', '08:55 - 09:45', 1),
                                ('09:50', '10:40', '09:50 - 10:40', 1),
                                ('10:45', '11:45', '10:45 - 11:45', 1),
                                ('11:40', '12:30', '11:40 - 12:30', 1),
                                ('12:35', '13:25', '12:35 - 13:25', 1),
                                ('13:30', '14:20', '13:30 - 14:20', 1),
                                ('14:00', '15:15', '14:25 - 15:15', 1);


INSERT INTO necesidad_capacitacion_anual   (cve_area_registro,
											cve_unidad_academica,
											cve_area,
											cve_departamento,
											cve_empleado_responsable,
											cve_orientacion_evento,
											cve_tipo_evento,
											cve_tipo_capacitacion,
											cve_origen_evento,
											nivel_academico,
											direccion_subdireccion,
											programa_academico,
											anio_ejercicio,
											necesidades_detectadas,
											nombre_evento,
											objetivo_evento,
											justificacion,
											otro_tipo_evento,
											proveedor,
											costo_capacitacion,
											mes,
											fecha_inicio,
											fecha_temino,
											num_dias,
											num_horas_efectivas,
											participantes_ptc,
											participantes_laboratoristas,
											participantes_administrativo,
											otros_participantes,
											total_participantes,
											total_hombres,
											total_mujeres)
				VALUES
						(1, 1, 2, 1, 1, 1, 1, 1, 1, 'T.S.U', 'Dirección de Sustentabilidad para el desarrollo', 'TSU en TI Área Entornos Virtuales y Negocios Digitales', --11
						'2022', 'Falta de eficiencia', 'Evento de comunicación', 'Mejorar', 'Quejas de alumnos', '', 'UTL', 234, 'Junio', '2023-06-07', '2023-06-13', 12, 2, 0, 8, 22, 10, 12, 1, 1)


INSERT INTO ugac (nombre_ugac, usuario_registro) 
				VALUES
						('Desarrollo de software', 1),
						('Academia de Programación',  1),
                        ('Academia de Ingles',  1),
                        ('Academia de Frances',  1),
                        ('Academia de Matemáticas',  1),
                        ('Academia de Expresión Oral y Escrita', 1);


INSERT INTO evento_programado_grupo VALUES
(1,1,10,1,0,'2023-06-10',10, '', 10,10,'Grande',1,'2023-06-11',10,'Entrevistas a estudiantes','2023-06-13', 1, '2023-06-13',1),
(1, 1, 8.5, 1, 0, '2023-06-25', 9,'Buena observación',9,8, 'Impacto positivo',1,'2023-06-25',9, 'Encuestas a estudiantes', '2023-06-25', 1, GETDATE(),1),
(2, 2, 9, 1, 0, '2023-06-25', 9,'Buena observación',9,8, 'Impacto positivo',1,'2023-06-25',9, 'Encuestas a estudiantes', '2023-06-25', 1, GETDATE(),1),
(1, 3, 9, 1, 0, '2023-06-25', 9,'Buena observación',9,8, 'Impacto positivo',1,'2023-06-25',9, 'Encuestas a estudiantes', '2023-06-25', 1, GETDATE(),1),
(2, 4, 10, 1, 0, '2023-06-25', 9,'Buena observación',9,8, 'Impacto positivo',1,'2023-06-25',9, 'Encuestas a estudiantes', '2023-06-25', 1, GETDATE(),1)

-- ------------- INSERTS DE TIPO_PUESTO -------------- --
INSERT INTO tipo_puesto (nombre_tipo_puesto, usuario_registro)
                VALUES  ('Director', 1),
                        ('Jefe de Departamento', 1),
                        ('Coordinador', 1),
                        ('Analista Administrativo', 1),
                        ('Profesor de Asignatura', 1),
                        ('Profesor de Tiempo Completo', 1),
                        ('Técnico en Contabilidad', 1),
                        ('Técnico Bibliotecario', 1),
                        ('Subdirector', 1),
                        ('Ingeniero en Sistemas', 1),
                        ('Secretaria de Subdirector', 1),
                        ('Técnico Especializado en Elect', 1),
                        ('Asistente Académico', 1),
                        ('Diseñador Web', 1),
                        ('Auxiliar de Laboratorio', 1),
                        ('Asistente de Centros de Computo', 1),
                        ('Asistente de Computo', 1),
                        ('Desarrollador de Sistemas', 1),
                        ('Diseñador Grafico', 1),
                        ('Técnico Docente A', 1),
                        ('Técnico Docente B', 1),
                        ('Técnico Docente C', 1),
                        ('Auxiliar de Laboratorio de Mantenimiento', 1),
                        ('Coordinador de Licenciaturas', 1),
                        ('Promotor de Carreras', 1),
                        ('Profesor de Música', 1),
                        ('Profesor de Escolta', 1),
                        ('Profesor de Atletismo', 1),
                        ('Técnico en Mantenimiento', 1),
                        ('Asistente de Contabilidad', 1),
                        ('Asistente Académico B', 1),
                        ('Profesor Hawaiano', 1),
                        ('Técnico Bibliotecario Honorarios', 1),
                        ('Profesor de Beisbol', 1),
                        ('Cultura y Deporte', 1),
                        ('Auxiliar de CIEM y Servicios Tecnológicos', 1),
                        ('Asistente de centro de atención', 1),
                        ('Coordinador Web', 1),
                        ('Auxiliar de Mantenimiento', 1),
                        ('Asistente de Control Escolar', 1),
                        ('Jefe de Oficina de Diseño', 1),
                        ('Auxiliar Laboratorio', 1),
                        ('Profesor de Baile', 1),
                        ('Profesor de Canto', 1),
                        ('Profesor de Artes Platicas', 1),
                        ('Profesor de Basquetbol', 1),
                        ('Profesor de Tiempo Completo', 1),
                        ('Psicologo', 1),
                        ('Desarrollador Web', 1),
                        ('Programador Web', 1),
                        ('Profesor de Tiempo Completo (Titular c)', 1),
                        ('Profesor de Teatro', 1),
                        ('Desarrallador de Software', 1),
                        ('Ejecutivo de Promoción', 1),
                        ('Técnico Laboratorista', 1),
                        ('Encargado de Laboratorio', 1),
                        ('Asistente de DAyD', 1),
                        ('Profesor de Activación Física', 1),
                        ('Profesor de Ajedrez', 1),
                        ('Profesor de Futbol', 1),
                        ('Boleibol', 1),
                        ('Profesor de Asignatura (Proyecto Especial)', 1),
                        ('Profesor de Natación', 1),
                        ('Profesor de Asignatura (autorizador a viaticar)', 1),
                        ('Profesor de Futbool Americano', 1),
                        ('Técnico Especializado en Mantenimiento', 1),
                        ('Técnico Docente A', 1),
                        ('Técnico Docente B', 1),
                        ('Técnico Docente C', 1),
                        ('Laboratorista', 1),
                        ('Profesor de Asignatura Viaticar', 1),
                        ('Técnico laboratorista C', 1),
                        ('Técnico laboratorista B', 1),
                        ('Ingeniero Data Center', 1),
                        ('Técnico Facilitador', 1),
                        ('Técnico Académico A', 1);


