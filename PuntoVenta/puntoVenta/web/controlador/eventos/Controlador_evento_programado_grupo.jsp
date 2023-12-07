
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
    String xml= String.valueOf(request.getRealPath(""))+"\\model\\eventos\\EventoProgramadoGrupo.xml";
    GeneralDAO datos = new GeneralDAO(xml);
    
    // JsonArray parametros = new JsonArray();
    JsonArray parametros = new JsonArray();
    JsonObject resultados = new JsonObject();
    JsonObject temp_obj;
    Gson gson = new Gson();
    
    int accion = request.getParameter("accion") != null && !request.getParameter("accion").equals("") ? Integer.parseInt(request.getParameter("accion")) : 0;
    
    int cve_even_prog = request.getParameter("cve_even_prog") != null && !request.getParameter("cve_even_prog").equals("") ? Integer.parseInt(request.getParameter("cve_even_prog")) : 0;
    int cve_even_prog_grupo = request.getParameter("cve_even_prog_grupo") != null && !request.getParameter("cve_even_prog_grupo").equals("") ? Integer.parseInt(request.getParameter("cve_even_prog_grupo")) : 0;
    
    int cve_empleado = 1;
    switch (accion) {
        case 1:
            out.println(datos.Consultas(parametros, "tablaEventoProgramado"));
            break;

        case 2:
            temp_obj = new JsonObject();
            temp_obj.addProperty("cve_even_prog", cve_even_prog);
            temp_obj.addProperty("cve_empleado", cve_empleado);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "guardarEventoProgramadoGrupo"));
            break;
        case 3:
            out.println(datos.Consultas(parametros, "tablaAsistencia"));
            break;
        case 4:
            temp_obj = new JsonObject();
            temp_obj.addProperty("cve_even_prog_grupo", cve_even_prog_grupo);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "desactivarProgramaDesarrollo"));
            break;
    
        default:
            out.print("ENTRO A CONTROLADOR"+ accion);
            break;
        
    }
%>