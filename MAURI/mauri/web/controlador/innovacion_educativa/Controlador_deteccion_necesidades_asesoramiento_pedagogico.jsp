
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
    String xml= String.valueOf(request.getRealPath(""))+"\\model\\innovacion_educativa\\DeteccionNecesidadesAsesoramientoPedagogico.xml";
    GeneralDAO datos = new GeneralDAO(xml);
    
    // JsonArray parametros = new JsonArray();
    JsonArray parametros = new JsonArray();
    JsonObject resultados = new JsonObject();
    JsonObject temp_obj;
    Gson gson = new Gson();
    
    int accion = request.getParameter("accion") != null && !request.getParameter("accion").equals("") ? Integer.parseInt(request.getParameter("accion")) : 0;
    
    int cve_asesoria = request.getParameter("cve_asesoria") != null && !request.getParameter("cve_asesoria").equals("") ? Integer.parseInt(request.getParameter("cve_asesoria")) : 0;
    int cve_empleado = request.getParameter("cve_empleado") != null && !request.getParameter("cve_empleado").equals("") ? Integer.parseInt(request.getParameter("cve_empleado")) : 0;
    int cve_academia = request.getParameter("cve_academia") != null && !request.getParameter("cve_academia").equals("") ? Integer.parseInt(request.getParameter("cve_academia")) : 0;
    int usuario_registro = request.getParameter("usuario_registro") != null && !request.getParameter("usuario_registro").equals("") ? Integer.parseInt(request.getParameter("usuario_registro")) : 0;

    boolean activo = request.getParameter("activo") != null && !request.getParameter("activo").equals("") ? Boolean.parseBoolean(request.getParameter("activo")) : false;
    
    String materia = request.getParameter("materia") != null && !request.getParameter("materia").equals("") ? request.getParameter("materia").replace("+", " ") : "-";
    String fecha = request.getParameter("fecha") != null && !request.getParameter("fecha").equals("") ? request.getParameter("fecha").replace("+", " ") : "-";
    String motivo_solicitud = request.getParameter("motivo_solicitud") != null && !request.getParameter("motivo_solicitud").equals("") ? request.getParameter("motivo_solicitud").replace("+", " ") : "-";
    String sugerencias = request.getParameter("sugerencias") != null && !request.getParameter("sugerencias").equals("") ? request.getParameter("sugerencias").replace("+", " ") : "-";
    String entrevista = request.getParameter("entrevista") != null && !request.getParameter("entrevista").equals("") ? request.getParameter("entrevista").replace("+", " ") : "-";
   
    switch (accion) {
        case 1:
            out.println(datos.Consultas(parametros, "tablaDNAP"));
            break;
        case 2:
            temp_obj = new JsonObject();
            temp_obj.addProperty("cve_empleado", cve_empleado);
            temp_obj.addProperty("cve_academia", cve_academia);
            temp_obj.addProperty("materia", materia);
            temp_obj.addProperty("fecha", fecha);
            temp_obj.addProperty("motivo_solicitud", motivo_solicitud);
            temp_obj.addProperty("sugerencias", sugerencias);
            temp_obj.addProperty("entrevista", entrevista);
            temp_obj.addProperty("usuario_registro", usuario_registro);

            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "guardarDNAP"));
            break;
        case 3:
            temp_obj = new JsonObject();
           
            temp_obj.addProperty("cve_empleado", cve_empleado);
            temp_obj.addProperty("cve_academia", cve_academia);
            temp_obj.addProperty("materia", materia);
            temp_obj.addProperty("fecha", fecha);
            temp_obj.addProperty("motivo_solicitud", motivo_solicitud);
            temp_obj.addProperty("sugerencias", sugerencias);
            temp_obj.addProperty("entrevista", entrevista);

            temp_obj.addProperty("activo", activo);
            temp_obj.addProperty("cve_asesoria", cve_asesoria);

            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "editarDNAP"));
            break;
        case 4:
            out.println(datos.Consultas(parametros, "consultarEmpleado"));
            break;
        case 5:
            out.println(datos.Consultas(parametros, "consultarAcademia"));
            break;
        case 6:
            out.println(datos.Consultas(parametros, "consultarUsuario"));
            break;
        default:
            out.print("ENTRO A CONTROLADOR"+ accion);
            break;
        
    }
%>