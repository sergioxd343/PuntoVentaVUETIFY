
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
    String xml= String.valueOf(request.getRealPath(""))+"\\model\\compras_requisiciones\\CatalogoEncuesta.xml";
    //String xml= String.valueOf("C:\\Capacitacion\\sito\\web\\model\\compras_requisiciones\\CatalogoSolicitud.xml");
    GeneralDAO datos = new GeneralDAO(xml);
    
    // JsonArray parametros = new JsonArray();
    JsonArray parametros = new JsonArray();
    JsonObject resultados = new JsonObject();
    JsonObject temp_obj;
    Gson gson = new Gson();
    
    int accion = request.getParameter("accion") != null && !request.getParameter("accion").equals("") ? Integer.parseInt(request.getParameter("accion")) : 0;

    int cve_eval_resul = request.getParameter("cve_eval_resul") != null && !request.getParameter("cve_eval_resul").equals("") ? Integer.parseInt(request.getParameter("cve_eval_resul")) : 0;
    int cve_t_servicio = request.getParameter("cve_t_servicio") != null && !request.getParameter("cve_t_servicio").equals("") ? Integer.parseInt(request.getParameter("cve_t_servicio")) : 0;
    int cve_asesoria_proyecto = request.getParameter("cve_asesoria_proyecto") != null && !request.getParameter("cve_asesoria_proyecto").equals("") ? Integer.parseInt(request.getParameter("cve_asesoria_proyecto")) : 0;
    int suma = request.getParameter("suma") != null && !request.getParameter("suma").equals("") ? Integer.parseInt(request.getParameter("suma")) : 0;
    float porcentaje = request.getParameter("porcentaje") != null && !request.getParameter("porcentaje").equals("") ? Float.parseFloat(request.getParameter("porcentaje")) : 0;
    String cuatrimestre = request.getParameter("cuatrimestre") != null && !request.getParameter("cuatrimestre").equals("") ? request.getParameter("cuatrimestre").replace("+", " ") : "-";
    String comentarios = request.getParameter("comentarios") != null && !request.getParameter("comentarios").equals("") ? request.getParameter("comentarios").replace("+", " ") : "-";
    boolean activo = request.getParameter("activo") != null && !request.getParameter("activo").equals("") ? Boolean.parseBoolean(request.getParameter("activo")) : false;
    String fecha_registro = request.getParameter("fecha_registro") != null && !request.getParameter("fecha_registro").equals("") ? request.getParameter("fecha_registro") : "0";
    int usuario_registro = request.getParameter("usuario_registro") != null && !request.getParameter("usuario_registro").equals("") ? Integer.parseInt(request.getParameter("usuario_registro")) : 0;


    switch (accion) {
        case 1:
            out.println(datos.Consultas(parametros, "tablaEncuestaSatisfaccion"));
            break;
        case 2:
            temp_obj = new JsonObject();

            temp_obj.addProperty("cve_t_servicio", cve_t_servicio);
            temp_obj.addProperty("cve_asesoria_proyecto", cve_asesoria_proyecto);
            temp_obj.addProperty("suma", suma);
            temp_obj.addProperty("porcentaje", porcentaje);
            temp_obj.addProperty("cuatrimestre", cuatrimestre);
            temp_obj.addProperty("comentarios", comentarios);

            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "guardarEncuesta"));
            break;
        case 3:
            out.println(datos.Consultas(parametros, "consultarTipoServicio"));
            break;
        case 4:
            out.println(datos.Consultas(parametros, "constultarAsesoriaProyecto"));
            break;
        default:
            out.print("ENTRO A CONTROLADOR"+ accion);
            break;
        
    }
%>