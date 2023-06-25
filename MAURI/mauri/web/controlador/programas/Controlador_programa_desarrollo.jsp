
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
    String xml= String.valueOf(request.getRealPath(""))+"\\model\\programas\\ProgramaDesarrollo.xml";
    GeneralDAO datos = new GeneralDAO(xml);
    
    // JsonArray parametros = new JsonArray();
    JsonArray parametros = new JsonArray();
    JsonObject resultados = new JsonObject();
    JsonObject temp_obj;
    Gson gson = new Gson();
    
    int accion = request.getParameter("accion") != null && !request.getParameter("accion").equals("") ? Integer.parseInt(request.getParameter("accion")) : 0;
    
    int cve_prog_des = request.getParameter("cve_prog_des") != null && !request.getParameter("cve_prog_des").equals("") ? Integer.parseInt(request.getParameter("cve_prog_des")) : 0;
    int numero_modulos = request.getParameter("numero_modulos") != null && !request.getParameter("numero_modulos").equals("") ? Integer.parseInt(request.getParameter("numero_modulos")) : 0;

    String nombre_programa = request.getParameter("nombre_programa") != null && !request.getParameter("nombre_programa").equals("") ? request.getParameter("nombre_programa") : "-";
    String fecha = request.getParameter("fecha") != null && !request.getParameter("fecha").equals("") ? request.getParameter("fecha") : "-";
    String descripcion_programa = request.getParameter("descripcion_programa") != null && !request.getParameter("descripcion_programa").equals("") ? request.getParameter("descripcion_programa") : "-";

    boolean activo = request.getParameter("activo") != null && !request.getParameter("activo").equals("") ? Boolean.parseBoolean(request.getParameter("activo")) : false;
    
    switch (accion) {
        case 1:
            out.println(datos.Consultas(parametros, "tablaProgramaDesarrollo"));
            break;
            
        case 2:
            temp_obj = new JsonObject();
            temp_obj.addProperty("nombre_programa", nombre_programa);
            temp_obj.addProperty("descripcion_programa", descripcion_programa);
            temp_obj.addProperty("numero_modulos", numero_modulos);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "guardarProgramaDesarrollo"));
            break;
        case 3:
            temp_obj = new JsonObject();
            temp_obj.addProperty("cve_prog_des",cve_prog_des);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "desactivarProgramaDesarrollo"));
           break;
        default:
            out.print("ENTRO A CONTROLADOR"+ accion);
            break;
        
    }
%>