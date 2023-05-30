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
    String xml= String.valueOf(request.getRealPath(""))+"\\model\\innovacion_educativa\\CatalogoSolicitudProyecto.xml";
    GeneralDAO datos = new GeneralDAO(xml);

    // JsonArray parametros = new JsonArray();
    JsonArray parametros = new JsonArray();
    JsonObject resultados = new JsonObject();
    JsonObject temp_obj;
    Gson gson = new Gson();
    
    int accion = request.getParameter("accion") != null && !request.getParameter("accion").equals("") ? Integer.parseInt(request.getParameter("accion")) : 0;

    int idArea = request.getParameter("idArea") != null && !request.getParameter("idArea").equals("") ? Integer.parseInt(request.getParameter("idArea")) : 0;
    int idProyecto = request.getParameter("idProyecto") != null && !request.getParameter("idProyecto").equals("") ? Integer.parseInt(request.getParameter("idProyecto")) : 0;
    String nombreProyecto = request.getParameter("nombreProyecto") != null && !request.getParameter("nombreProyecto").equals("") ? request.getParameter("nombreProyecto") : "-";
    String objetivos = request.getParameter("objetivos") != null && !request.getParameter("objetivos").equals("") ? request.getParameter("objetivos") : "-";
    String descripcion = request.getParameter("descripcion") != null && !request.getParameter("descripcion").equals("") ? request.getParameter("descripcion") : "-";
    String fecha = request.getParameter("fecha") != null && !request.getParameter("fecha").equals("") ? request.getParameter("fecha") : "-";
    String recursos = request.getParameter("recursos") != null && !request.getParameter("recursos").equals("") ? request.getParameter("recursos") : "-";
    String acuerdos = request.getParameter("acuerdos") != null && !request.getParameter("acuerdos").equals("") ? request.getParameter("acuerdos") : "-";
    String estatus = request.getParameter("estatus") != null && !request.getParameter("estatus").equals("") ? request.getParameter("estatus") : "-";
    
    switch (accion) {
        case 1:
            out.println(datos.Consultas(parametros, "tablaProyecto"));
            break;     
        case 2:
            temp_obj = new JsonObject();
            temp_obj.addProperty("idArea", idArea);
            temp_obj.addProperty("nombreProyecto", nombreProyecto);
            temp_obj.addProperty("fecha", fecha);
            temp_obj.addProperty("objetivos", objetivos);
            temp_obj.addProperty("descripcion", descripcion);
            temp_obj.addProperty("recursos", recursos);
            temp_obj.addProperty("acuerdos", acuerdos);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "guardarProyecto"));
            break;
        case 3:
            out.println(datos.Consultas(parametros, "tipoProyecto"));
            break;
        case 4:
            temp_obj = new JsonObject();
            temp_obj.addProperty("idArea", idArea);
            temp_obj.addProperty("nombreProyecto", nombreProyecto);
            temp_obj.addProperty("fecha", fecha);
            temp_obj.addProperty("objetivos", objetivos);
            temp_obj.addProperty("descripcion", descripcion);
            temp_obj.addProperty("recursos", recursos);
            temp_obj.addProperty("acuerdos", acuerdos);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "editarUsuario"));
            break;
        case 5:
            temp_obj = new JsonObject();
            temp_obj.addProperty("estatus", estatus);
            temp_obj.addProperty("idProyecto", idProyecto);            
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "cambiarEstatus"));
            break;
        default:
            out.print("ENTRO A CONTROLADOR "+ accion);
            break;   
    }
%>