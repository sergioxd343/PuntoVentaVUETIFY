
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonElement"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonPrimitive"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.JsonParser"%>

<%@page import="okhttp3.Response"%>
<%@page import="okhttp3.Request"%>
<%@page import="okhttp3.RequestBody"%>
<%@page import="okhttp3.OkHttpClient"%>
<%@page import="okhttp3.MediaType"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>

<%@page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@page import="javax.servlet.http.*" %>

<%@page import="sistema.DAO.GeneralDAO"%>


<%
    String xml= String.valueOf(request.getRealPath(""))+"\\model\\innovacion_educativa\\GeneracionRubrica.xml";
    GeneralDAO datos = new GeneralDAO(xml);
    
    // JsonArray parametros = new JsonArray();
    JsonArray parametros = new JsonArray();
    JsonObject resultados = new JsonObject();
    JsonObject temp_obj;
    Gson gson = new Gson();
    
    int accion = request.getParameter("accion") != null && !request.getParameter("accion").equals("") ? Integer.parseInt(request.getParameter("accion")) : 0;
    
    int cve_rubrica = request.getParameter("cve_rubrica") != null && !request.getParameter("cve_rubrica").equals("") ? Integer.parseInt(request.getParameter("cve_rubrica")) : 0;
    int cve_empleado = request.getParameter("cve_empleado") != null && !request.getParameter("cve_empleado").equals("") ? Integer.parseInt(request.getParameter("cve_empleado")) : 0;
    int usuario_registro = request.getParameter("usuario_registro") != null && !request.getParameter("usuario_registro").equals("") ? Integer.parseInt(request.getParameter("usuario_registro")) : 0;
    int filas = request.getParameter("filas") != null && !request.getParameter("filas").equals("") ? Integer.parseInt(request.getParameter("filas")) : 0;
    int columnas = request.getParameter("columnas") != null && !request.getParameter("columnas").equals("") ? Integer.parseInt(request.getParameter("columnas")) : 0;

    boolean activo = request.getParameter("activo") != null && !request.getParameter("activo").equals("") ? Boolean.parseBoolean(request.getParameter("activo")) : false;

    String nombre_rubica = request.getParameter("nombre_rubica") != null && !request.getParameter("nombre_rubica").equals("") ? request.getParameter("nombre_rubica") : "-";
    String secciones = request.getParameter("secciones") != null && !request.getParameter("secciones").equals("") ? request.getParameter("secciones") : "-";
    String headers = request.getParameter("headers") != null && !request.getParameter("headers").equals("") ? request.getParameter("headers") : "-";
    String criterios_por_celda = request.getParameter("criterios_por_celda") != null && !request.getParameter("criterios_por_celda").equals("") ? request.getParameter("criterios_por_celda") : "-";
    String fecha_registro = request.getParameter("fecha_registro") != null && !request.getParameter("fecha_registro").equals("") ? request.getParameter("fecha_registro") : "-";
    
    switch (accion) {
        case 1:
            out.println(datos.Consultas(parametros, "tablaRubrica"));
            break;
        case 2:
            temp_obj = new JsonObject();
            temp_obj.addProperty("cve_empleado", cve_empleado);
            temp_obj.addProperty("nombre_rubica", nombre_rubica);
            temp_obj.addProperty("filas", filas);
            temp_obj.addProperty("columnas", columnas);
            temp_obj.addProperty("secciones", secciones);
            temp_obj.addProperty("headers", headers);
            temp_obj.addProperty("criterios_por_celda", criterios_por_celda);

            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "guardarRubrica"));
            break;
        case 3:
            temp_obj = new JsonObject();
            
            temp_obj.addProperty("cve_empleado", cve_empleado);
            temp_obj.addProperty("nombre_rubica", nombre_rubica);
            temp_obj.addProperty("filas", filas);
            temp_obj.addProperty("columnas", columnas);
            temp_obj.addProperty("secciones", secciones);
            temp_obj.addProperty("headers", headers);
            temp_obj.addProperty("criterios_por_celda", criterios_por_celda);
            
            temp_obj.addProperty("cve_rubrica", cve_rubrica);

            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "editarRubrica"));
            break;
        case 4:
            out.println(datos.Consultas(parametros, "consultarEmpleado"));
            break;
        default:
            out.print("ENTRO A CONTROLADOR"+ accion);
            break;
        
    }
%>