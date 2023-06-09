<%-- 
    /*
     * <p>Title        : 
     * <p>Description  : 
     * @author         : 
     * @version        : 
     * @date           : 
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
    String xml= String.valueOf(request.getRealPath(""))+"\\model\\formacion_docente\\catalogo_autoevaluacion_capacitacion_docente.xml";
    GeneralDAO datos = new GeneralDAO(xml);

    // JsonArray parametros = new JsonArray();
    JsonArray parametros = new JsonArray();
    JsonObject resultados = new JsonObject();
    JsonObject temp_obj;
    Gson gson = new Gson();
    
    int accion = request.getParameter("accion") != null && !request.getParameter("accion").equals("") ? Integer.parseInt(request.getParameter("accion")) : 0;
    
    String areaCapacitacion = request.getParameter("areaCapacitacion") != null && !request.getParameter("areaCapacitacion").equals("") ? request.getParameter("areaCapacitacion") : "-";
    String escala = request.getParameter("escala") != null && !request.getParameter("escala").equals("") ? request.getParameter("escala") : "-";
    

    int idUsuario = request.getParameter("idUsuario") != null && !request.getParameter("idUsuario").equals("") ? Integer.parseInt(request.getParameter("idUsuario")) : 0;


    String nombreBuscar = request.getParameter("nombreBuscar") != null && !request.getParameter("nombreBuscar").equals("") ? request.getParameter("nombreBuscar") : "-";
    
    switch (accion) {
        case 1:
            out.println(datos.Consultas(parametros, "areasCapacitacion"));
            break;
        case 2:
            out.println(datos.Consultas(parametros, "escalas"));
            break;
    }
%>