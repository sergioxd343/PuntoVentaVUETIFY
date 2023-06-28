
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
    String xml= String.valueOf(request.getRealPath(""))+"\\model\\programas\\ProgramaDesarrolloMateria.xml";
    GeneralDAO datos = new GeneralDAO(xml);
    
    // JsonArray parametros = new JsonArray();
    JsonArray parametros = new JsonArray();
    JsonObject resultados = new JsonObject();
    JsonObject temp_obj;
    Gson gson = new Gson();
    
    int accion = request.getParameter("accion") != null && !request.getParameter("accion").equals("") ? Integer.parseInt(request.getParameter("accion")) : 0;
    
    int cve_prog_des = request.getParameter("cve_prog_des") != null && !request.getParameter("cve_prog_des").equals("") ? Integer.parseInt(request.getParameter("cve_prog_des")) : 0;
    int numero_modulos = request.getParameter("numero_modulos") != null && !request.getParameter("numero_modulos").equals("") ? Integer.parseInt(request.getParameter("numero_modulos")) : 0;

    String duracion = request.getParameter("duracion") != null && !request.getParameter("duracion").equals("") ? request.getParameter("duracion") : "-";
    String nombre_materia = request.getParameter("nombre_materia") != null && !request.getParameter("nombre_materia").equals("") ? request.getParameter("nombre_materia") : "-";
    String objetivo = request.getParameter("objetivo") != null && !request.getParameter("objetivo").equals("") ? request.getParameter("objetivo") : "-";
    String resultado_aprendizaje = request.getParameter("resultado_aprendizaje") != null && !request.getParameter("resultado_aprendizaje").equals("") ? request.getParameter("resultado_aprendizaje") : "-";

    switch (accion) {
        case 1:
            out.println(datos.Consultas(parametros, "tablaProgramaDesarrolloMaterias"));
            break;
            
        case 2:
            temp_obj = new JsonObject();
            temp_obj.addProperty("cve_prog_des",cve_prog_des);
            temp_obj.addProperty("nombre_materia",nombre_materia);
            temp_obj.addProperty("duracion", duracion);
            temp_obj.addProperty("objetivo",objetivo);
            temp_obj.addProperty("resultado_aprendizaje", resultado_aprendizaje);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "guardarProgramaDesarrolloMateria"));
            break;            
        case 3:
            out.println(datos.Consultas(parametros, "SelectProgramaDesarrollo"));
            break;
        case 4:
            temp_obj = new JsonObject();
            temp_obj.addProperty("cve_prog_des",cve_prog_des);
            temp_obj.addProperty("duracion", duracion);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "desactivarProgramaDesarrolloMateria"));
            break;  
        default:
            out.print("ENTRO A CONTROLADOR"+ accion);
            break;
        
    }
%>