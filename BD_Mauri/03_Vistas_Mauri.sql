USE mauri;
GO

CREATE VIEW v_menu AS
SELECT        
                menu.cve_menu, 
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
                submenu RIGHT OUTER JOIN
                menu INNER JOIN
                grupo_seguridad INNER JOIN
                menu_permisos ON grupo_seguridad.cve_grupo_seguridad = menu_permisos.cve_grupo_seguridad INNER JOIN
                usuario_grupo_seguridad ON grupo_seguridad.cve_grupo_seguridad = usuario_grupo_seguridad.cve_grupo_seguridad INNER JOIN
                usuario ON usuario_grupo_seguridad.cve_persona = usuario.cve_persona ON menu.cve_menu = menu_permisos.cve_menu ON submenu.cve_menu = menu.cve_menu 
GO

IF OBJECT_ID('v_usuario_persona', 'V') IS NOT NULL
    DROP VIEW v_usuario_persona;
GO
CREATE VIEW v_usuario_persona AS
SELECT			
				ROW_NUMBER() OVER (ORDER BY usuario.cve_persona) AS numero_fila,
				usuario.cve_persona, 
				usuario.nombre_usuario, 
				usuario.contrasenia, 
				usuario.activo, 
				persona.nombre, 
				persona.apellido_peterno, 
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
				persona.cve_persona, 
				persona.nombre, 
				persona.apellido_peterno, 
				persona.apellido_materno, 
				persona.email, 
				persona.movil, 
				persona.curp, 
				persona.rfc, 
				persona.sexo, 
				persona.fecha_nacimiento, 
                empleado.cve_empleado, 
				persona.activo, 
				empleado.grado_estudio, 
				empleado.titulo_recibido, 
				empleado.fecha_ingreso, 
				usuario.nombre_usuario, 
				usuario.contrasenia
FROM            
				persona INNER JOIN
                empleado ON persona.cve_persona = empleado.cve_persona INNER JOIN
                usuario ON persona.cve_persona = usuario.cve_persona
GO

IF OBJECT_ID('solicitud_cursos', 'V') IS NOT NULL
    DROP VIEW solicitud_cursos;
GO
CREATE VIEW solicitud_cursos AS
SELECT       	curso.nombre_curso, 
				solicitud_capacitacion_interna.total_dias, 
				solicitud_capacitacion_interna.total_horas, 
				solicitud_capacitacion_interna.objetivo, 
				solicitud_capacitacion_interna.alcance, 
                instructor.nombre_instructor, 
				tipo_instructor.nombre_tipo_instructor, 
				solicitud_capacitacion_interna.numero_participantes, 
				solicitud_capacitacion_interna.metodologia, 
                solicitud_capacitacion_interna.programa_evento, 
				solicitud_capacitacion_interna.horas_tema, 
				solicitud_capacitacion_interna.resultado_aprendizaje, 
				solicitud_capacitacion_interna.perfil_participante, 
                curso.cve_curso, instructor.cve_instructor, 
				instructor.cve_tipo_instructor
FROM 
				curso INNER JOIN
                solicitud_capacitacion_interna ON curso.cve_curso = solicitud_capacitacion_interna.cve_curso INNER JOIN
                instructor ON solicitud_capacitacion_interna.cve_instructor = instructor.cve_instructor INNER JOIN
                tipo_instructor ON instructor.cve_tipo_instructor = tipo_instructor.cve_tipo_instructor
GO 