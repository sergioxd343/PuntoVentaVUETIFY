<%-- 
    /*
     * <p>Title        :  
     * <p>Description  : 
     * @author         : Maria Guadalupe Gutiérrez Alcantar
     * @version        : 3
     * @date           : 23 - 06 - 2023
     */

--%>


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
    
    //VARIABLES DE PLANTILLA
    String xml= String.valueOf(request.getRealPath(""))+"\\model\\formacion_docente\\catalogo_evaluacion_capacitacion.xml";
    GeneralDAO datos = new GeneralDAO(xml);

    // JsonArray parametros = new JsonArray();
    JsonArray parametros = new JsonArray();
    JsonObject resultados = new JsonObject();
    JsonObject temp_obj;
    Gson gson = new Gson();
    
    int accion = request.getParameter("accion") != null && !request.getParameter("accion").equals("") ? Integer.parseInt(request.getParameter("accion")) : 0;
    
    String tipo = request.getParameter("tipo") != null && !request.getParameter("tipo").equals("") ? request.getParameter("tipo") : "-";
    String nombreCorto = request.getParameter("nombreCorto") != null && !request.getParameter("nombreCorto").equals("") ? request.getParameter("nombreCorto") : "-";
    String razonSocial = request.getParameter("razonSocial") != null && !request.getParameter("razonSocial").equals("") ? request.getParameter("razonSocial") : "-";
    String rfc = request.getParameter("rfc") != null && !request.getParameter("rfc").equals("") ? request.getParameter("rfc") : "-";
    String padron = request.getParameter("padron") != null && !request.getParameter("padron").equals("") ? request.getParameter("padron") : "-";
    String nombreContacto = request.getParameter("nombreContacto") != null && !request.getParameter("nombreContacto").equals("") ? request.getParameter("nombreContacto") : "-";
    String correoContacto = request.getParameter("correoContacto") != null && !request.getParameter("correoContacto").equals("") ? request.getParameter("correoContacto") : "-";
    String telefonoContacto = request.getParameter("telefonoContacto") != null && !request.getParameter("telefonoContacto").equals("") ? request.getParameter("telefonoContacto") : "-";
    String pass = request.getParameter("pass") != null && !request.getParameter("pass").equals("") ? request.getParameter("pass") : "-";
    String tipoPersona = request.getParameter("tipoPersona") != null && !request.getParameter("tipoPersona").equals("") ? request.getParameter("tipoPersona") : "-";
    int cve_proveedor = request.getParameter("cve_proveedor") != null && !request.getParameter("cve_proveedor").equals("") ? Integer.parseInt(request.getParameter("cve_proveedor")) : 0;


    
    String cve_empleado = request.getParameter("cve_empleado") != null && !request.getParameter("cve_empleado").equals("") ? request.getParameter("cve_empleado") : "-";
    String cve_curso = request.getParameter("cve_curso") != null && !request.getParameter("cve_curso").equals("") ? request.getParameter("cve_curso") : "-";
    String cve_calificacion = request.getParameter("cve_calificacion") != null && !request.getParameter("cve_calificacion").equals("") ? request.getParameter("cve_calificacion") : "-";
    String nombreInstructor = request.getParameter("nombreInstructor") != null && !request.getParameter("nombreInstructor").equals("") ? request.getParameter("nombreInstructor") : "-";
    String calificacion = request.getParameter("calificacion") != null && !request.getParameter("calificacion").equals("") ? request.getParameter("calificacion") : "-";
    String cve = request.getParameter("cve") != null && !request.getParameter("cve").equals("") ? request.getParameter("cve") : "-";
    String idUsuario = request.getParameter("idUsuario") != null && !request.getParameter("idUsuario").equals("") ? request.getParameter("idUsuario") : "-";

    switch (accion) {
        case 1:
            out.println(datos.Consultas(parametros, "tablaPrincipal"));
            break;
        case 2:
            //temp_obj = new JsonObject();
            //temp_obj.addProperty("cve", cve);
            parametros.add(cve);
            out.println(datos.Consultas(parametros, "tablaParticipantes"));
            break;
        case 3:
            temp_obj = new JsonObject();
            temp_obj.addProperty("cve_empleado", cve_empleado); 
            temp_obj.addProperty("cve_curso", cve_curso); 
            
            temp_obj.addProperty("nombreInstructor", nombreInstructor); 
            temp_obj.addProperty("calificacion", calificacion);
            temp_obj.addProperty("idUsuario", idUsuario);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "guardarEvaluacion"));
            break;
        case 4:
            out.println(datos.Consultas(parametros, "tablaEvaluacion"));
            break;
        default:
            out.print("ENTRO A CONTROLADOR"+ accion);
            break;
        
    }
%>