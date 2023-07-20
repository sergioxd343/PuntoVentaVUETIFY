
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
    String xml= String.valueOf(request.getRealPath(""))+"\\model\\eventos\\EventoProgramado.xml";
    GeneralDAO datos = new GeneralDAO(xml);
    
    // JsonArray parametros = new JsonArray();
    JsonArray parametros = new JsonArray();
    JsonObject resultados = new JsonObject();
    JsonObject temp_obj;
    Gson gson = new Gson();
    
    int accion = request.getParameter("accion") != null && !request.getParameter("accion").equals("") ? Integer.parseInt(request.getParameter("accion")) : 0;
    
    int cve_origen_evento = request.getParameter("cve_origen_evento") != null && !request.getParameter("cve_origen_evento").equals("") ? Integer.parseInt(request.getParameter("cve_origen_evento")) : 0;
    int cve_espacio = request.getParameter("cve_espacio") != null && !request.getParameter("cve_espacio").equals("") ? Integer.parseInt(request.getParameter("cve_espacio")) : 0;
    int cve_modalidad = request.getParameter("cve_modalidad") != null && !request.getParameter("cve_modalidad").equals("") ? Integer.parseInt(request.getParameter("cve_modalidad")) : 0;
    boolean sin_horario = request.getParameter("sin_horario") != null && !request.getParameter("sin_horario").equals("");

    String nombre_evento = request.getParameter("nombre_evento") != null && !request.getParameter("nombre_evento").equals("") ? request.getParameter("nombre_evento") : "-";
    String nombre_origen = request.getParameter("nombre_origen") != null && !request.getParameter("nombre_origen").equals("") ? request.getParameter("nombre_origen") : "-";
    String horario_inicio = request.getParameter("horario_inicio") != null && !request.getParameter("horario_inicio").equals("") ? request.getParameter("horario_inicio") : "-";
     String horario_fin = request.getParameter("horario_fin") != null && !request.getParameter("horario_fin").equals("") ? request.getParameter("horario_fin") : "-";
     String fecha_inicio = request.getParameter("fecha_inicio") != null && !request.getParameter("fecha_inicio").equals("") ? request.getParameter("fecha_inicio") : "-";
     String fecha_fin = request.getParameter("fecha_fin") != null && !request.getParameter("fecha_fin").equals("") ? request.getParameter("fecha_fin") : "-";
    

    switch (accion) {
        case 1:
            out.println(datos.Consultas(parametros, "tablaProgramaDesarrollo"));
            break;
        case 2:
            out.println(datos.Consultas(parametros, "selectEspacios"));
            break;
        case 3:
            out.println(datos.Consultas(parametros, "selectModalidad"));
            break;
        case 4:
            temp_obj = new JsonObject();
            temp_obj.addProperty("cve_origen_evento", cve_origen_evento);
            temp_obj.addProperty("cve_espacio", cve_espacio);
            temp_obj.addProperty("cve_modalidad", cve_modalidad);
            temp_obj.addProperty("nombre_evento", nombre_evento);
            temp_obj.addProperty("nombre_origen", nombre_origen);
            temp_obj.addProperty("sin_horario", sin_horario);
            temp_obj.addProperty("horario_inicio", horario_inicio);
            temp_obj.addProperty("horario_fin", horario_inicio);
            temp_obj.addProperty("fecha_inicio", horario_inicio);
            temp_obj.addProperty("fecha_fin", horario_inicio);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "guardarEventoProgramado"));
            break;
        case 5:
            out.println(datos.Consultas(parametros, "tablaSolicitudProyecto"));
            break;
        default:
            out.print("ENTRO A CONTROLADOR"+ accion);
            break;
        
    }
%>