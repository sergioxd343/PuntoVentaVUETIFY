
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
    String xml= String.valueOf(request.getRealPath(""))+"\\model\\innovacion_educativa\\RubricaObservacionClase.xml";
    GeneralDAO datos = new GeneralDAO(xml);
    
    // JsonArray parametros = new JsonArray();
    JsonArray parametros = new JsonArray();
    JsonObject resultados = new JsonObject();
    JsonObject temp_obj;
    Gson gson = new Gson();
    
    int accion = request.getParameter("accion") != null && !request.getParameter("accion").equals("") ? Integer.parseInt(request.getParameter("accion")) : 0;
    
    int cve_empleado_docente = request.getParameter("cve_empleado_docente") != null && !request.getParameter("cve_empleado_docente").equals("") ? Integer.parseInt(request.getParameter("cve_empleado_docente")) : 0;
    int cve_rubrica = request.getParameter("cve_rubrica") != null && !request.getParameter("cve_rubrica").equals("") ? Integer.parseInt(request.getParameter("cve_rubrica")) : 0;
    int calificacion_seccion = request.getParameter("calificacion_seccion") != null && !request.getParameter("calificacion_seccion").equals("") ? Integer.parseInt(request.getParameter("calificacion_seccion")) : 0;
    int calificacion_total = request.getParameter("calificacion_total") != null && !request.getParameter("calificacion_total").equals("") ? Integer.parseInt(request.getParameter("calificacion_total")) : 0;
    int usuario_registro = request.getParameter("usuario_registro") != null && !request.getParameter("usuario_registro").equals("") ? Integer.parseInt(request.getParameter("usuario_registro")) : 0;
    
    String seccion = request.getParameter("seccion") != null && !request.getParameter("seccion").equals("") ? request.getParameter("seccion") : "-";
    String comentario = request.getParameter("comentario") != null && !request.getParameter("comentario").equals("") ? request.getParameter("comentario") : "-";
    String fecha_registro = request.getParameter("fecha_registro") != null && !request.getParameter("fecha_registro").equals("") ? request.getParameter("fecha_registro") : "-";

    boolean activo = request.getParameter("activo") != null && !request.getParameter("activo").equals("") ? Boolean.parseBoolean(request.getParameter("activo")) : false;

    switch (accion) {
        case 1:
            out.println(datos.Consultas(parametros, "tablaRubrica"));
            break;
        case 2:
            temp_obj = new JsonObject();
            temp_obj.addProperty("cve_empleado_docente", cve_empleado_docente);
            temp_obj.addProperty("seccion", seccion);
            temp_obj.addProperty("calificacion_seccion", calificacion_seccion);
            temp_obj.addProperty("calificacion_total", calificacion_total);
            temp_obj.addProperty("comentario", comentario);

            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "guardarRubrica"));
            break;
        case 3:
            out.println(datos.Consultas(parametros, "consultarEmpleado"));
            break;
        case 4:
            temp_obj = new JsonObject();
            temp_obj.addProperty("cve_empleado_docente", cve_empleado_docente);
            temp_obj.addProperty("seccion", seccion);
            temp_obj.addProperty("calificacion_seccion", calificacion_seccion);
            temp_obj.addProperty("calificacion_total", calificacion_total);
            temp_obj.addProperty("comentario", comentario);
            temp_obj.addProperty("activo", activo);
            temp_obj.addProperty("cve_rubrica", cve_rubrica);

            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "editarRubrica"));
            break;
        case 5:
            out.println(datos.Consultas(parametros, "consultarCuatrimestre"));
            break;
        case 6:
            out.println(datos.Consultas(parametros, "consultarRubricas"));
            break;
        default:
            out.print("ENTRO A CONTROLADOR"+ accion);
            break;
        
    }
%>