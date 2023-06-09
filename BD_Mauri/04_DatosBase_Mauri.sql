USE mauri;
GO

-- ------------- INSERTS DE PERSONA -------------- --
INSERT INTO persona (nombre, apellido_peterno, apellido_materno, email, movil, curp, rfc, sexo, fecha_nacimiento, activo, fecha_registro, usuario_registro) 
            VALUES ('Simón Jonathan', 'Zendejas', 'Gutiérrez', 'simonzdjgtz@gmail.com', '4779074784', 'ZEGS021226HGTNTMA0', 'ZEGS1234DFXXX', 'Masculino', '2002-12-26', 1, GETDATE(), 1);

-- ------------- INSERTS DE USUARIOS -------------- --
INSERT INTO usuario (cve_persona, nombre_usuario, contrasenia, activo, fecha_registro, usuario_registro) VALUES (1, 'sjonathan', '56964', 1, GETDATE(), 1);

-- ------------- INSERTS DE MENU -------------- --
INSERT INTO menu (cve_padre, nombre, ruta, orden, activo, fecha_registro, usuario_registro) 
            VALUES  (0, 'Formación Docente', '-', 1, 1, GETDATE(), 1),
                    (0, 'Innovación Educativa', '-', 9, 1, GETDATE(), 1),
                    (0, 'Eventos', '-', 15, 1, GETDATE(), 1),
                    (0, 'Catalogos Pequeños', '-', 19, 1, GETDATE(), 1),
                    (0, 'Programas', '-', 28, 1, GETDATE(), 1);

-- ------------- INSERTS DE  SUBMENU -------------- --
INSERT INTO submenu (cve_menu, cve_padre, nombre, ruta, orden, activo, fecha_registro, usuario_registro) 
            VALUES  (1, 1, 'Autoevaluación de Eficacia de Capacitación Docente', '../formacion_docente/autoevaluacion_capacitacion_docente.jsp', 2, 1, GETDATE(), 1),
                    (1, 1, 'Evaluación de Capacitación', '../formacion_docente/evaluacion_capacitacion.jsp', 3, 1, GETDATE(), 1),
                    (1, 1, 'Cuestionario de Evaluación de Cursos', '../formacion_docente/cuestionario_evaluacion_cursos.jsp', 4, 1, GETDATE(), 1),
                    (1, 1, 'Necesidad Capacitacion Anual(DANC)', '../formacion_docente/necesidad_capacitacion_anual.jsp', 5, 1, GETDATE(), 1),
                    (1, 1, 'Lista de Asistencia de Capacitación', '../formacion_docente/lista_asistencia_capacitacion.jsp', 6, 1, GETDATE(), 1),
                    (1, 1, 'Solicitud de Apoyo para la formación docente', '../formacion_docente/solicitud_formacion_docente.jsp', 7, 1, GETDATE(), 1),
                    (1, 1, 'Solicitud de Registro de Capacitación Interna', '../formacion_docente/solicitud_capacitacion_interna.jsp', 8, 1, GETDATE(), 1),
                    (2, 2, 'Encuesta de Satisfacción y Evaluación de Resultado', '../innovacion_educativa/evaluacion_resultado.jsp', 10, 1, GETDATE(), 1),
                    (2, 2, 'Detacción de necesidad para Asesoramiento', '../innovacion_educativa/asesoria.jsp', 11, 1, GETDATE(), 1),
                    (2, 2, 'Rúbrica de Observación de Clase', '../innvacion_educativa/rubrica_observacion_clase.jsp', 12, 1, GETDATE(), 1),
                    (2, 2, 'Analisis Situacional Docente', '../innovacion_educativa/analisis_situacional_docente.jsp', 13, 1, GETDATE(), 1),
                    (2, 2, 'Solicitu de Proyecto', '../innovacion_educativa/solicitud_proyecto.jsp', 14, 1, GETDATE(), 1),
                    (3, 3, 'Evento Programado', '../eventos/evento_programado.jsp', 16, 1, GETDATE(), 1),
                    (3, 3, 'Evento Programado Grupo', '../eventos/evento_programado_grupo.jsp', 17, 1, GETDATE(), 1),
                    (3, 3, 'Cumple programa de Desarrollo', '../eventos/cumple_programa_desarrollo.jsp', 18, 1, GETDATE(), 1),
                    (4, 4, 'Tipo Orientación', '../catalogos_pequenios_tipo_orientacion.jsp',20, 1, GETDATE(), 1),
                    (4, 4, 'Tipo Evento', '../catalogos_pequenios/tipo_evento.jsp', 21, 1, GETDATE(), 1),
                    (4, 4, 'Tipo Modalidad', '../catalogos_pequenios/tipo_modalidad.jsp', 22, 1, GETDATE(), 1),
                    (4, 4, 'Tipo Instructor', '../catalogos_pequnios/tipo_insatructor.jsp', 23, 1, GETDATE(), 1),
                    (4, 4, 'Tipo Origen', '../catalogos_pequenios/tipo_origen.jsp', 24, 1, GETDATE(), 1),
                    (4, 4, 'Tipo Capacitación', '../catalogos_pequenios/tipo_capacitacion.jsp', 25, 1, GETDATE(), 1),
                    (4, 4, 'Tipo Servicio', '../catalogos_pequenios/tipo_servicio.jsp', 26, 1, GETDATE(), 1),
                    (4, 4, 'Tipo Espacio', '../catalogos_pequenios/tipo_espacio.jsp', 27, 1, GETDATE(), 1),
                    (5, 5, 'Programa de Desarrollo', '../programas/programa_desarrollo.jsp', 29, 1, GETDATE(), 1),
                    (5, 5, 'Programa de Desarrollo de Módulos', '../programas/programa_desarrollo_modulo.jsp', 30, 1, GETDATE(), 1),
                    (5, 5, 'Programa de Desarrollo de Materia', '../programas/programa_desarrollo_materia.jsp', 31, 1, GETDATE(), 1);

-- ------------- INSERTS DE MENU_PERMISOS -------------- --
INSERT INTO menu_permisos (cve_grupo_seguridad, cve_menu, activo, fecha_registro, usuario_registro) 
            VALUES  (1, 1, 1, GETDATE(), 1),
                    (1, 2, 1, GETDATE(), 1),
                    (1, 3, 1, GETDATE(), 1),
                    (1, 4, 1, GETDATE(), 1),
                    (1, 5, 1, GETDATE(), 1);

-- ------------- INSERTS DE GRUPO_SEGURIDAD -------------- --
INSERT INTO grupo_seguridad (nombre, tiempo_sesion, activo, fecha_registro, usuario_registro) VALUES  ('Administrador', 5000, 1, GETDATE(), 1);

-- ------------- INSERTS DE USUARIO_GRUPO_SEGURIDAD -------------- --
INSERT INTO usuario_grupo_seguridad (cve_grupo_seguridad, cve_persona, activo, fecha_registro, usuario_registro) VALUES (1, 1, 1, GETDATE(), 1);

