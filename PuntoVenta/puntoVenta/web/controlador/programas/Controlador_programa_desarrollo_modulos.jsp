
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
    String xml= String.valueOf(request.getRealPath(""))+"\\model\\programas\\ProgramaDesarrolloModulo.xml";
    GeneralDAO datos = new GeneralDAO(xml);
    
    // JsonArray parametros = new JsonArray();
    JsonArray parametros = new JsonArray();
    JsonObject resultados = new JsonObject();
    JsonObject temp_obj;    
    Gson gson = new Gson();
    
    int accion = request.getParameter("accion") != null && !request.getParameter("accion").equals("") ? Integer.parseInt(request.getParameter("accion")) : 0;
    int cve_modulo = request.getParameter("cve_modulo") != null && !request.getParameter("cve_modulo").equals("") ? Integer.parseInt(request.getParameter("cve_modulo")) : 0;
    
    int cve_prog_des = request.getParameter("cve_prog_des") != null && !request.getParameter("cve_prog_des").equals("") ? Integer.parseInt(request.getParameter("cve_prog_des")) : 0;
    int num_materias = request.getParameter("num_materias") != null && !request.getParameter("num_materias").equals("") ? Integer.parseInt(request.getParameter("num_materias")) : 0;
    

    String nombre_modulo = request.getParameter("nombre_modulo") != null && !request.getParameter("nombre_modulo").equals("") ? request.getParameter("nombre_modulo") : "-";
    String color = request.getParameter("color") != null && !request.getParameter("color").equals("") ? request.getParameter("color") : "-";
    
    int activo = request.getParameter("activo")!=null && !request.getParameter("activo").equals("")?Integer.parseInt(request.getParameter("activo")):0;
	
    switch (accion) {
        case 1:
            out.println(datos.Consultas(parametros, "tablaProgramaDesarrollo"));
            break;
            
        case 2:
            temp_obj = new JsonObject();
            temp_obj.addProperty("cve_prog_des", cve_prog_des);
            temp_obj.addProperty("nombre_modulo", nombre_modulo);
            temp_obj.addProperty("num_materias", num_materias);
            temp_obj.addProperty("color", color);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "guardarProgramaDesarrolloModulo"));
            break;
        case 3:
            out.println(datos.Consultas(parametros, "selectProgramaDesarollo"));
            break;
        case 4: 
            temp_obj = new JsonObject();
            temp_obj.addProperty("activo", activo);
            temp_obj.addProperty("cve_prog_des", cve_prog_des);
            temp_obj.addProperty("cve_modulo", cve_modulo);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "desactivarProgramaDesarrolloModulos"));
            break;
            case 5:
                temp_obj = new JsonObject();
                temp_obj.addProperty("cve_prog_des", cve_prog_des);
                parametros.add(temp_obj);
            out.println(datos.Consultas(parametros, "consultaModulos"));
            break;
        default:
            out.print("ENTRO A CONTROLADOR"+ accion);
            break;
        
    }
%>