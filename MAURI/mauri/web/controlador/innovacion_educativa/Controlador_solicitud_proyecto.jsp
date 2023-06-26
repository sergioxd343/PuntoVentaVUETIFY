
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
    String xml= String.valueOf(request.getRealPath(""))+"\\model\\innovacion_educativa\\SolicitudProyecto.xml";
    GeneralDAO datos = new GeneralDAO(xml);
    
    // JsonArray parametros = new JsonArray();
    JsonArray parametros = new JsonArray();
    JsonObject resultados = new JsonObject();
    JsonObject temp_obj;
    Gson gson = new Gson();
    
    int accion = request.getParameter("accion") != null && !request.getParameter("accion").equals("") ? Integer.parseInt(request.getParameter("accion")) : 0;

    int cve_solicitud_proyecto = request.getParameter("cve_solicitud_proyecto") != null && !request.getParameter("cve_solicitud_proyecto").equals("") ? Integer.parseInt(request.getParameter("cve_solicitud_proyecto")) : 0;
    int cve_area = request.getParameter("cve_area") != null && !request.getParameter("cve_area").equals("") ? Integer.parseInt(request.getParameter("cve_area")) : 0;
	String nombre_proyecto = request.getParameter("nombre_proyecto") != null && !request.getParameter("nombre_proyecto").equals("") ? request.getParameter("nombre_proyecto") : "-";
	String objetivo_proyecto = request.getParameter("objetivo_proyecto") != null && !request.getParameter("objetivo_proyecto").equals("") ? request.getParameter("objetivo_proyecto") : "-";
	String descripcion_proyecto = request.getParameter("descripcion_proyecto") != null && !request.getParameter("descripcion_proyecto").equals("") ? request.getParameter("descripcion_proyecto") : "-";
	String recursos_necesarios = request.getParameter("recursos_necesarios") != null && !request.getParameter("recursos_necesarios").equals("") ? request.getParameter("recursos_necesarios") : "-";
	String acuerdos_establecidos = request.getParameter("acuerdos_establecidos") != null && !request.getParameter("acuerdos_establecidos").equals("") ? request.getParameter("acuerdos_establecidos") : "-";
	boolean estatus = request.getParameter("estatus") != null && !request.getParameter("estatus").equals("") ? Boolean.parseBoolean(request.getParameter("estatus")) : true;
	String cuatrimestre = request.getParameter("cuatrimestre") != null && !request.getParameter("cuatrimestre").equals("") ? request.getParameter("cuatrimestre") : "-";
	boolean activo = request.getParameter("activo") != null && !request.getParameter("activo").equals("") ? Boolean.parseBoolean(request.getParameter("activo")) : true;
	String fecha_registro = request.getParameter("fecha_registro") != null && !request.getParameter("fecha_registro").equals("") ? request.getParameter("fecha_registro") : "-";
	int usuario_registro = request.getParameter("usuario_registro") != null && !request.getParameter("usuario_registro").equals("") ? Integer.parseInt(request.getParameter("usuario_registro")) : 0;

    switch (accion) {
        case 1:
            out.println(datos.Consultas(parametros, "tablaSolicitud"));
            break;
        case 2:
            temp_obj = new JsonObject();
            temp_obj.addProperty("cve_area", cve_area);
            temp_obj.addProperty("nombre_proyecto", nombre_proyecto);
            temp_obj.addProperty("cuatrimestre", cuatrimestre);
            temp_obj.addProperty("objetivo_proyecto", objetivo_proyecto);
            temp_obj.addProperty("descripcion_proyecto", descripcion_proyecto);
            temp_obj.addProperty("recursos_necesarios", recursos_necesarios);
            temp_obj.addProperty("acuerdos_establecidos", acuerdos_establecidos);
            temp_obj.addProperty("usuario_registro", usuario_registro);

            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "guardarSolicitud"));
            break;
        case 3:
            out.println(datos.Consultas(parametros, "consultarArea"));
            break;
        case 4:
            temp_obj = new JsonObject();

            temp_obj.addProperty("estatus", estatus);
            temp_obj.addProperty("cve_solicitud_proyecto", cve_solicitud_proyecto);

            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "editarSolicitud"));
            break;
        case 5:
            out.println(datos.Consultas(parametros, "consultarCuatrimestre"));
            break;
        case 6:
            out.println(datos.Consultas(parametros, "consultarUsuario"));
            break;
        default:
            out.print("ENTRO A CONTROLADOR"+ accion);
            break;
        
    }
%>