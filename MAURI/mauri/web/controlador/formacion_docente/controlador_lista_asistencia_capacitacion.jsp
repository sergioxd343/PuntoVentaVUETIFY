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
    String xml= String.valueOf(request.getRealPath(""))+"\\model\\formacion_docente\\catalogo_lista_asistencia_capacitacion.xml";
    GeneralDAO datos = new GeneralDAO(xml);

    // JsonArray parametros = new JsonArray();
    JsonArray parametros = new JsonArray();
    JsonObject resultados = new JsonObject();
    JsonObject temp_obj;
    Gson gson = new Gson();
    
    int accion = request.getParameter("accion") != null && !request.getParameter("accion").equals("") ? Integer.parseInt(request.getParameter("accion")) : 0;
    
    String tipoActividad = request.getParameter("tipoActividad") != null && !request.getParameter("tipoActividad").equals("") ? request.getParameter("tipoActividad") : "-";
    String horario = request.getParameter("horario") != null && !request.getParameter("horario").equals("") ? request.getParameter("horario") : "-";
    String nombreUsuario = request.getParameter("nombreUsuario") != null && !request.getParameter("nombreUsuario").equals("") ? request.getParameter("nombreUsuario") : "-";
    String fecha = request.getParameter("fecha") != null && !request.getParameter("fecha").equals("") ? request.getParameter("fecha") : "-";
    String activo = request.getParameter("activo") != null && !request.getParameter("activo").equals("") ? request.getParameter("activo") : "-";
   
    int idUsuario = request.getParameter("idUsuario") != null && !request.getParameter("idUsuario").equals("") ? Integer.parseInt(request.getParameter("idUsuario")) : 0;


    String nombreBuscar = request.getParameter("nombreBuscar") != null && !request.getParameter("nombreBuscar").equals("") ? request.getParameter("nombreBuscar") : "-";
    
    switch (accion) {
        case 1:
            out.println(datos.Consultas(parametros, "tipoActividad"));
            break;
        case 7:
            out.println(datos.Consultas(parametros, "horarios"));
            break;
        case 8:
            out.println(datos.Consultas(parametros, "puesto"));
            break;
        case 9:
            out.println(datos.Consultas(parametros, "instructores"));
            break;
        case 10:
            out.println(datos.Consultas(parametros, "lugar"));
            break;
        case 2:
            temp_obj = new JsonObject();
            temp_obj.addProperty("tipoActividad", tipoActividad);
            temp_obj.addProperty("nombreUsuario", nombreUsuario);
            temp_obj.addProperty("fecha", fecha);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "guardarUsuario"));
            break;
        case 3:
            out.println(datos.Consultas(parametros, "tipoUsuario"));
            break;
        case 4:
            temp_obj = new JsonObject();
            temp_obj.addProperty("idUsuario", idUsuario);
            temp_obj.addProperty("tipoActividad", tipoActividad);
            temp_obj.addProperty("nombreUsuario", nombreUsuario);
            temp_obj.addProperty("fecha", fecha);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "editarUsuario"));
            break;
        case 5:
            temp_obj = new JsonObject();
            temp_obj.addProperty("idUsuario", idUsuario);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "eliminarUsuario"));
            break;
        case 6:
            temp_obj =new JsonObject();
            temp_obj.addProperty("activo", activo);
            temp_obj.addProperty("idUsuario", idUsuario);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "cambiarEstatus"));
            break;
        default:
            out.print("ENTRO A CONTROLADOR"+ accion);
            break;
        
    }
%>