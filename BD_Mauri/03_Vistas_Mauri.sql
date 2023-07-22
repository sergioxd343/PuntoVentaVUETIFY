USE mauri;
GO

IF OBJECT_ID('v_menu', 'V') IS NOT NULL
    DROP VIEW v_menu;
GO
CREATE VIEW v_menu AS
SELECT			menu.cve_menu, 
				menu.cve_padre, 
				menu.nombre AS menu_nivel_1, 
				menu.ruta, 
				menu.orden, 
				menu.activo, 
				submenu.cve_menu AS cve_menu_2, 
				submenu.cve_padre AS cve_padre_2, 
				submenu.activo AS activo_2, 
                submenu.orden AS orden_2, 
				submenu.ruta AS ruta_2, 
				submenu.nombre AS menu_nivel_2, 
				grupo_seguridad.nombre AS rol, 
				usuario.nombre_usuario, 
				usuario.contrasenia
FROM            
				menu INNER JOIN
                submenu ON menu.cve_menu = submenu.cve_padre INNER JOIN
                menu_permisos ON submenu.cve_menu = menu_permisos.cve_menu INNER JOIN
                grupo_seguridad ON menu_permisos.cve_grupo_seguridad = grupo_seguridad.cve_grupo_seguridad INNER JOIN
                usuario_grupo_seguridad ON grupo_seguridad.cve_grupo_seguridad = usuario_grupo_seguridad.cve_grupo_seguridad INNER JOIN
                usuario ON usuario_grupo_seguridad.cve_usuario = usuario.cve_usuario
GO

IF OBJECT_ID('v_usuario_persona', 'V') IS NOT NULL
    DROP VIEW v_usuario_persona;
GO
CREATE VIEW v_usuario_persona AS
SELECT			
				ROW_NUMBER() OVER (ORDER BY usuario.cve_persona) AS numero_fila,
				usuario.cve_persona,
				usuario.cve_usuario, 
				usuario.nombre_usuario, 
				usuario.contrasenia, 
				usuario.activo, 
				persona.nombre, 
				persona.apellido_paterno, 
				persona.apellido_materno, 
				persona.email, 
				persona.movil, 
				persona.rfc,
				persona.curp, 
                persona.sexo, 
				persona.fecha_nacimiento
FROM            
				usuario INNER JOIN
                persona ON usuario.cve_persona = persona.cve_persona
GO

IF OBJECT_ID('v_empleado', 'V') IS NOT NULL
    DROP VIEW v_empleado;
GO
CREATE VIEW v_empleado AS
SELECT			
				ROW_NUMBER() OVER (ORDER BY persona.cve_persona) AS numero_fila,
				persona.cve_persona, 
				persona.nombre, 
				persona.apellido_paterno, 
				persona.apellido_materno,
				persona.email, 
				persona.movil, 
				persona.curp, 
				persona.rfc, 
				persona.sexo, 
				persona.fecha_nacimiento, 
				persona.activo,
                empleado.cve_empleado, 
				empleado.fecha_ingreso, 
				empleado.titulo_recibido, 
				empleado.grado_estudio, 
				puesto.cve_puesto, 
				puesto.nombre_puesto, 
				puesto.nivel_tabulador_puesto, 
				tipo_puesto.cve_tipo_puesto, 
                tipo_puesto.nombre_tipo_puesto, 
				departamento.cve_departamento, 
				departamento.nombre_departamento, 
				area.cve_area,
				area.nombre_area, 
				ugac.cve_ugac, 
				ugac.nombre_ugac, 
				unidad_academica.cve_unidad_academica,
				unidad_academica.nombre_unidad_academica, 
				usuario.cve_usuario, 
				usuario.nombre_usuario, 
				usuario.contrasenia
FROM            
				persona INNER JOIN
                empleado ON persona.cve_persona = empleado.cve_persona INNER JOIN
                puesto ON empleado.cve_puesto = puesto.cve_puesto INNER JOIN
                tipo_puesto ON empleado.cve_tipo_puesto = tipo_puesto.cve_tipo_puesto INNER JOIN
                departamento ON empleado.cve_departamento = departamento.cve_departamento INNER JOIN
                area ON empleado.cve_area = area.cve_area INNER JOIN
                ugac ON empleado.cve_ugac = ugac.cve_ugac INNER JOIN
                unidad_academica ON empleado.cve_unidad_academica = unidad_academica.cve_unidad_academica INNER JOIN
                usuario ON persona.cve_persona = usuario.cve_persona
GO

IF OBJECT_ID('solicitud_cursos', 'V') IS NOT NULL
    DROP VIEW solicitud_cursos;
GO
CREATE VIEW solicitud_cursos AS
SELECT
    solicitud_capacitacion_interna.cve_sol_cap_int,
    solicitud_capacitacion_interna.tipo_competencia,
    solicitud_capacitacion_interna.nombre,
    solicitud_capacitacion_interna.total_dias,
    solicitud_capacitacion_interna.total_horas,
    solicitud_capacitacion_interna.fecha_inicio,
    solicitud_capacitacion_interna.fecha_fin,
    solicitud_capacitacion_interna.lugar,
    solicitud_capacitacion_interna.curso,
    solicitud_capacitacion_interna.numero_participantes,
    solicitud_capacitacion_interna.objetivo,
    solicitud_capacitacion_interna.alcance,
    solicitud_capacitacion_interna.metodologia,
    solicitud_capacitacion_interna.programa_evento,
    solicitud_capacitacion_interna.resultado_aprendizaje,
    solicitud_capacitacion_interna.perfil_participante,
    solicitud_instructor.cve_instructor,
    instructor.nombre_instructor,
    instructor.area_academica,
	instructor.programa_educativo
FROM
    solicitud_capacitacion_interna solicitud_capacitacion_interna
    INNER JOIN solicitud_instructor solicitud_instructor ON solicitud_capacitacion_interna.cve_sol_cap_int = solicitud_instructor.cve_sol_cap_int
    INNER JOIN instructor instructor ON solicitud_instructor.cve_instructor = instructor.cve_instructor;
GO 

IF OBJECT_ID('v_empleado_evento', 'V') IS NOT NULL
    DROP VIEW v_empleado_evento;
GO
CREATE VIEW v_empleado_evento AS
SELECT        evento_programado.cve_even_prog, empleado.cve_empleado, persona.nombre, persona.apellido_paterno, persona.apellido_materno, persona.sexo, tipo_puesto.nombre_tipo_puesto, puesto.nombre_puesto, 
                         area.nombre_area, ugac.nombre_ugac, espacio.nombre_espacio, modalidad_evento.nombre_modalidad, evento_programado.nombre_evento, evento_programado.nombre_origen, evento_programado.sin_horario, 
                         evento_programado.horario_inicio, evento_programado.horario_fin, evento_programado.fecha_inicio, evento_programado.fecha_fin, evento_programado.activo, evento_programado.fecha_registro, 
                         evento_programado.usuario_registro, evento_programado_grupo.cve_empleado AS Expr1
FROM            modalidad_evento INNER JOIN
                         espacio INNER JOIN
                         evento_programado INNER JOIN
                         evento_programado_grupo ON evento_programado.cve_even_prog = evento_programado_grupo.cve_even_prog ON espacio.cve_espacio = evento_programado.cve_espacio ON 
                         modalidad_evento.cve_modalidad = evento_programado.cve_modalidad CROSS JOIN
                         tipo_puesto INNER JOIN
                         persona INNER JOIN
                         empleado ON persona.cve_persona = empleado.cve_persona INNER JOIN
                         area ON empleado.cve_area = area.cve_area INNER JOIN
                         ugac ON empleado.cve_ugac = ugac.cve_ugac ON tipo_puesto.cve_tipo_puesto = empleado.cve_tipo_puesto INNER JOIN
                         puesto ON empleado.cve_puesto = puesto.cve_puesto
GO

IF OBJECT_ID('v_cuestionario_jornada', 'V') IS NOT NULL
    DROP VIEW v_cuestionario_jornada;
GO
CREATE VIEW v_cuestionario_jornada AS
SELECT					ROW_NUMBER() OVER (ORDER BY cuestionario_evalucion_curso.cve_cuest_eval_curso) AS numero_fila, 
						cuestionario_evalucion_curso.cve_cuest_eval_curso, 
						cuestionario_evalucion_curso.cve_jornada, 
						cuestionario_evalucion_curso.nombre_instructor, 
						cuestionario_evalucion_curso.fecha, 
                        cuestionario_evalucion_curso.cali_curso_contenido, 
						cuestionario_evalucion_curso.cali_facilitador, 
						cuestionario_evalucion_curso.cali_organizacion, 
						cuestionario_evalucion_curso.cali_impacto_aplicacion,
                        cuestionario_evalucion_curso.principal_aprendizaje, 
						cuestionario_evalucion_curso.comentarios, 
						jornada.nombre_jornada,
						cuestionario_evalucion_curso.activo
FROM            
						cuestionario_evalucion_curso INNER JOIN
                        jornada ON cuestionario_evalucion_curso.cve_jornada = jornada.cve_jornada
GO