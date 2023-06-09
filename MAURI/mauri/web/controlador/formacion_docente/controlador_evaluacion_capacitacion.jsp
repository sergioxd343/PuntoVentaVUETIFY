<%-- 
    /*
     * <p>Title        : 
     * <p>Description  : 
     * @author         : 
     * @version        : 
     * @date           : 
     */

--%>


<%@page import="sistema.AccesoSistema"%>
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


    String nombreBuscar = request.getParameter("nombreBuscar") != null && !request.getParameter("nombreBuscar").equals("") ? request.getParameter("nombreBuscar") : "-";
    String cve_empleado = request.getParameter("cve_empleado") != null && !request.getParameter("cve_empleado").equals("") ? request.getParameter("cve_empleado") : "-";
    String cve_persona = request.getParameter("cve_persona") != null && !request.getParameter("cve_persona").equals("") ? request.getParameter("cve_persona") : "-";
    String cve_permiso = request.getParameter("cve_permiso") != null && !request.getParameter("cve_permiso").equals("") ? request.getParameter("cve_permiso") : "-";

    switch (accion) {
        case 1:
            out.println(datos.Consultas(parametros, "tablaCatalogo"));
            break;
        case 2:
           out.println(datos.Consultas(parametros, "tipoPuesto"));
            break;
        
        default:
            out.print("ENTRO A CONTROLADOR"+ accion);
            break;
        
    }
%>