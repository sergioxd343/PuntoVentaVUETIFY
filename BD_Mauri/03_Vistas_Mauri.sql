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