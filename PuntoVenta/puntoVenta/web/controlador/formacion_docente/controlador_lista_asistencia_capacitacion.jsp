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
    
    String nombreEvento = request.getParameter("nombreEvento") != null && ! request.getParameter("nombreEvento").equals("") ? request.getParameter("nombreEvento") : "-";
    String sesiones = request.getParameter("sesiones") != null && !request.getParameter("sesiones").equals("") ? request.getParameter("sesiones") : "-";
    String horas = request.getParameter("horas") != null && !request.getParameter("horas").equals("") ? request.getParameter("horas") : "-";
    String fecha = request.getParameter("fecha") != null && !request.getParameter("fecha").equals("") ? request.getParameter("fecha") : "-";
    String fecha1 = request.getParameter("fecha1") != null && !request.getParameter("fecha1").equals("") ? request.getParameter("fecha1") : "-";
    String nombreInstructor = request.getParameter("nombreInstructor") != null && !request.getParameter("nombreInstructor").equals("") ? request.getParameter("nombreInstructor") : "-";
    String horario = request.getParameter("horario") != null && !request.getParameter("horario").equals("") ? request.getParameter("horario") : "-";
    String lugar = request.getParameter("lugar") != null && !request.getParameter("lugar").equals("") ? request.getParameter("lugar") : "-";
    String tipoActividad = request.getParameter("tipoActividad") != null && !request.getParameter("tipoActividad").equals("") ? request.getParameter("tipoActividad") : "-";
    String otraAct = request.getParameter("otraAct") != null && !request.getParameter("otraAct").equals("") ? request.getParameter("otraAct") : "-";
    String numeroControl = request.getParameter("numeroControl") != null && !request.getParameter("numeroControl").equals("") ? request.getParameter("numeroControl") : "-";
    String nombreAsistente = request.getParameter("nombreAsistente") != null && !request.getParameter("nombreAsistente").equals("") ? request.getParameter("nombreAsistente") : "-";
    String primerApellidoA = request.getParameter("primerApellidoA") != null && !request.getParameter("primerApellidoA").equals("") ? request.getParameter("primerApellidoA") : "-";
    String segundoApellidoA = request.getParameter("segundoApellidoA") != null && !request.getParameter("segundoApellidoA").equals("") ? request.getParameter("segundoApellidoA") : "-";
    String sexo = request.getParameter("sexo") != null && !request.getParameter("sexo").equals("") ? request.getParameter("sexo") : "-";
    String discapacidad = request.getParameter("discapacidad") != null && !request.getParameter("discapacidad").equals("") ? request.getParameter("discapacidad") : "-";
    String tipoDiscapacidad = request.getParameter("tipoDiscapacidad") != null && !request.getParameter("tipoDiscapacidad").equals("") ? request.getParameter("tipoDiscapacidad") : "-";
    String direccion = request.getParameter("direccion") != null && !request.getParameter("direccion").equals("") ? request.getParameter("direccion") : "-";
    String puesto = request.getParameter("puesto") != null && !request.getParameter("puesto").equals("") ? request.getParameter("puesto") : "-";
    String informacionAdicional = request.getParameter("informacionAdicional") != null && !request.getParameter("informacionAdicional").equals("") ? request.getParameter("informacionAdicional") : "-";





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
            //temp_obj.addProperty("nombreUsuario", nombreUsuario);
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
            //temp_obj.addProperty("nombreUsuario", nombreUsuario);
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