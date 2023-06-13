USE mauri;
GO

-- ------------- INSERTS DE PERSONA -------------- --
INSERT INTO persona (nombre, apellido_peterno, apellido_materno, email, movil, curp, rfc, sexo, fecha_nacimiento, usuario_registro) 
            VALUES	('Simón Jonathan', 'Zendejas', 'Gutiérrez', '21000165@alumnos.utleon.edu.mx', '477 907 4784', 'ZEGS021226HGTNTMA0', 'ZEGS1234DFXXX', 'Masculino', '2002-12-26', 1),
					('Carlos Rene','Andrade','De Pro','20002741@alumnos.utleon.edu.mx','477 860 9622','ANDC021226HGTNTMA0','ANDC1234DFXXX','Masculino','2001-09-12',1),
					('Maria Guadalupe','Gutiérrez','Alcantar','21000035@alumnos.utleon.edu.mx','477 847 9181','GUAM021226HGTNTMA0','GUAM1234DFXXX','Femenino','2003-11-12',1),
					('Sergio','Hernandez','Tavarez','21000302@alumnos.utleon.edu.mx','477 200 6766','HETS021226HGTNTMA0','HETS1234DFXXX','Masculino','2002-05-21',1),
					('Brenda Esmeralda','Gutiérrez','Pérez','21000026@alumnos.utleon.edu.mx','472 184 6581','GUPB021226HGTNTMA0','GUPB1234DFXXX','Femenino','2003-04-12',1);

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
                    (2, 2, 'Rúbrica de Observación de Clase', '../innvacion_educativa/rubrica_observacion_clase.jsp', 12, 1),
                    (2, 2, 'Analisis Situacional Docente', '../innovacion_educativa/analisis_situacional_docente.jsp', 13, 1),
                    (2, 2, 'Solicitu de Proyecto', '../innovacion_educativa/solicitud_proyecto.jsp', 14, 1),
                    (3, 3, 'Evento Programado', '../eventos/evento_programado.jsp', 16, 1),
                    (3, 3, 'Evento Programado Grupo', '../eventos/evento_programado_grupo.jsp', 17, 1),
                    (3, 3, 'Cumple programa de Desarrollo', '../eventos/cumple_programa_desarrollo.jsp', 18, 1),
                    (4, 4, 'Tipo Orientación', '../catalogos_pequenios_tipo_orientacion.jsp',20, 1),
                    (4, 4, 'Tipo Evento', '../catalogos_pequenios/tipo_evento.jsp', 21, 1),
                    (4, 4, 'Tipo Modalidad', '../catalogos_pequenios/tipo_modalidad.jsp', 22, 1),
                    (4, 4, 'Tipo Instructor', '../catalogos_pequnios/tipo_insatructor.jsp', 23, 1),
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
					('Docente', 5000, 1);

-- ------------- INSERTS DE USUARIO_GRUPO_SEGURIDAD -------------- --
INSERT INTO usuario_grupo_seguridad (cve_grupo_seguridad, cve_persona, usuario_registro) VALUES (1, 1, 1);

