USE mauri;
GO

-- ------------- INSERTS DE PERSONA -------------- --
INSERT INTO persona (nombre, apellido_peterno, apellido_materno, email, movil, curp, rfc, sexo, fecha_nacimiento, usuario_registro) 
            VALUES	('Simón Jonathan', 'Zendejas', 'Gutiérrez', '21000165@alumnos.utleon.edu.mx', '477 907 4784', 'ZEGS021226HGTNTMA0', 'ZEGS1234DFXXX', 'Masculino', '2002-12-26', 1),
					('Carlos Rene','Andrade','De Pro','20002741@alumnos.utleon.edu.mx','477 860 9622','ANDC021226HGTNTMA0','ANDC1234DFXXX','Masculino','2001-09-12',1),
					('Maria Guadalupe','Gutiérrez','Alcantar','21000035@alumnos.utleon.edu.mx','477 847 9181','GUAM021226HGTNTMA0','GUAM1234DFXXX','Femenino','2003-11-12',1),
					('Sergio','Hernandez','Tavarez','21000302@alumnos.utleon.edu.mx','477 200 6766','HETS021226HGTNTMA0','HETS1234DFXXX','Masculino','2002-05-21',1),
					('Brenda Esmeralda','Gutiérrez','Pérez','21000026@alumnos.utleon.edu.mx','472 184 6581','GUPB021226HGTNTMA0','GUPB1234DFXXX','Femenino','2003-04-12',1);


-- ------------- INSERTS DE EMPLEADOS -------------- --
INSERT INTO empleado (cve_persona, cve_puesto, cve_tipo_puesto, cve_departamento, cve_area, cve_ugac, cve_unidad_academica, fecha_ingreso, titulo_recibido, grado_estudio, usuario_registro)
			VALUES (1, 3, 53, 1, 7, 1, 1, '2002', 'Técnico Superior', 'Educación Superior', 1);

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
                    (0, 'Programas', '-', 28, 1),
					(0, 'Sistema', '-', 32, 1);

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
                    (2, 2, 'Solicitu de Proyecto', '../innovacion_educativa/solicitud_proyecto.jsp', 14, 1),
                    (3, 3, 'Evento Programado', '../eventos/evento_programado.jsp', 16, 1),
                    (3, 3, 'Evento Programado Grupo', '../eventos/evento_programado_grupo.jsp', 17, 1),
                    (3, 3, 'Cumple programa de Desarrollo', '../eventos/cumple_programa_desarrollo.jsp', 18, 1),
                    (4, 4, 'Tipo Orientación', '../catalogos_pequenios/tipo_orientacion.jsp',20, 1),
                    (4, 4, 'Tipo Evento', '../catalogos_pequenios/tipo_evento.jsp', 21, 1),
                    (4, 4, 'Tipo Modalidad', '../catalogos_pequenios/tipo_modalidad.jsp', 22, 1),
                    (4, 4, 'Tipo Instructor', '../catalogos_pequenios/tipo_instructor.jsp', 23, 1),
                    (4, 4, 'Tipo Origen', '../catalogos_pequenios/tipo_origen.jsp', 24, 1),
                    (4, 4, 'Tipo Capacitación', '../catalogos_pequenios/tipo_capacitacion.jsp', 25, 1),
                    (4, 4, 'Tipo Servicio', '../catalogos_pequenios/tipo_servicio.jsp', 26, 1),
                    (4, 4, 'Tipo Espacio', '../catalogos_pequenios/tipo_espacio.jsp', 27, 1),
                    (5, 5, 'Programa de Desarrollo', '../programas/programa_desarrollo.jsp', 29, 1),
                    (5, 5, 'Programa de Desarrollo de Módulos', '../programas/programa_desarrollo_modulo.jsp', 30, 1),
                    (5, 5, 'Programa de Desarrollo de Materia', '../programas/programa_desarrollo_materia.jsp', 31, 1),
					(6, 6, 'Perfil de usuario', 'perfil_usuario.jsp', 33, 1);

-- ------------- INSERTS DE MENU_PERMISOS -------------- --
INSERT INTO menu_permisos (cve_grupo_seguridad, cve_menu, usuario_registro) 
            VALUES  (1, 1, 1),
                    (1, 2, 1),
                    (1, 3, 1),
                    (1, 4, 1),
                    (1, 5, 1),
					(1, 6, 1);

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
            VALUES  ('Instructor', 1),
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


-- ------------- INSERTS DE PUESTO -------------- --
INSERT INTO puesto (nombre_puesto, nivel_tabulador_puesto, usuario_registro)
                VALUES  ('PTC', 'D', 1),
                        ('PA', 'HP', 1),
                        ('Técnico académico', 'PTC', 1),
                        ('Administrativo de área académica', 'HV3', 1),
                        ('Administrativo', 'HA', 1);


-- ------------- INSERTS DE CURSO -------------- --
INSERT INTO curso (nombre_curso, usuario_registro)
                VALUES 
                        ('Programación Avanzada', 1),
                        ('Diseño Digital', 2),
                        ('Metodologías Ágiles', 3);


-- ------------- INSERTS DE SOLICITUD_CAPACITACION_INTERNA -------------- --
INSERT INTO solicitud_capacitacion_interna (cve_instructor, cve_orientacion_evento, cve_curso, total_dias, total_horas, numero_participantes, objetivo, alcance, metodologia, programa_evento, horas_tema, resultado_aprendizaje, perfil_participante, usuario_registro)
                VALUES 
                        (1, 1, 1, 5, 40, 20, 'Capacitación en programación', 'Departamento de Desarrollo', 'Taller práctico', 'Programación Avanzada', 4, 'Los participantes podrán desarrollar aplicaciones web modernas', 'Desarrolladores con conocimientos básicos en programación', 100),
                        (2, 1, 2, 3, 24, 15, 'Capacitación en diseño gráfico', 'Área de Diseño', 'Sesiones teóricas y prácticas', 'Diseño Digital', 2, 'Los participantes adquirirán habilidades en diseño de interfaces', 'Estudiantes de diseño gráfico', 200),
                        (3, 2, 3, 2, 16, 10, 'Capacitación en metodologías ágiles', 'Departamento de Desarrollo', 'Talleres interactivos', 'Agile Scrum', 1, 'Los participantes comprenderán los principios de las metodologías ágiles', 'Equipo de proyectos', 300);


-- ------------- INSERTS DE INSTRUCTOR -------------- --
INSERT INTO instructor (cve_tipo_instructor, nombre_instructor, usuario_registro)
                VALUES 
                        (1, 'Maria Guadalupe', 1),
                        (2, 'Simón Zendejas', 1);


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

INSERT INTO evento_programado 
				VALUES
						(1,2,2,'Estrategias pedagógicas','Pedagógia', '', '9:30', '11:00', '2023-05-10', '2023-05-18', 1, GETDATE(),1),
						(1,1,2,'Comunicación','Comunicación', '', '2:00', '3:00', '2023-07-01', '2023-07-11', 1, GETDATE(),1);



INSERT INTO unidad_academica (nombre_unidad_academica, usuario_registro) 
				VALUES
						('León',1),
						('Acambaro',1);

INSERT INTO categoria_evento (nombre_categoria, usuario_registro) 
				VALUES
						('Estrategias pedagógicas', 1),
						('Comunicación', 1),
						('Herramientas digitales', 1),
						('Tutoreo', 1),
						('Investigación', 1);

INSERT INTO curso (nombre_curso, usuario_registro) 
				VALUES
						('Comunicación asertiva', 1),
						('Técnicas de aprendizaje', 1);


INSERT INTO necesidad_capacitacion_anual 
				VALUES
						(1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 2022, 'Test', 'Evento de comunicación', 'Mejorar', 'Quejas de alumnos', 
'', 'UTL',234, 'Junio', '2023-06-07', '2023-06-13',8,24,12,2,0,8,22,10,12,1,GETDATE(),1)


INSERT INTO solicitud_capacitacion_interna 
				VALUES
						(2, 1, 2, 5, 20, 20, 'Conocer nuevas técnicas', 'Mejorar capacidad de enseñar', 'Taller', '5 temas', 4, 'Certificación',
'Docente UTL', 1,GETDATE(),1)

INSERT INTO ugac (nombre_ugac, usuario_registro) 
				VALUES
						('Desarrollo de software', 1);



INSERT INTO evento_programado_grupo VALUES
(1,1,10,1,0,'2023-06-10',10, '', 10,10,'Grande',1,'2023-06-11',10,'Entrevistas a estudiantes','2023-06-13', 1, '2023-06-13',1)

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


