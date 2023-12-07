
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
    String xml= String.valueOf(request.getRealPath(""))+"\\model\\innovacion_educativa\\AnalisisSituacionalDocente.xml";
    GeneralDAO datos = new GeneralDAO(xml);
    
    // JsonArray parametros = new JsonArray();
    JsonArray parametros = new JsonArray();
    JsonObject resultados = new JsonObject();
    JsonObject temp_obj;
    Gson gson = new Gson();
    
    int accion = request.getParameter("accion") != null && !request.getParameter("accion").equals("") ? Integer.parseInt(request.getParameter("accion")) : 0;
    
    int cve_analisis_docente = request.getParameter("cve_analisis_docente") != null && !request.getParameter("cve_analisis_docente").equals("") ? Integer.parseInt(request.getParameter("cve_analisis_docente")) : 0;
    int cve_academia = request.getParameter("cve_academia") != null && !request.getParameter("cve_academia").equals("") ? Integer.parseInt(request.getParameter("cve_academia")) : 0;
    int cve_unidad_academica = request.getParameter("cve_unidad_academica") != null && !request.getParameter("cve_unidad_academica").equals("") ? Integer.parseInt(request.getParameter("cve_unidad_academica")) : 0;
    int anio_aplicacion = request.getParameter("anio_aplicacion") != null && !request.getParameter("anio_aplicacion").equals("") ? Integer.parseInt(request.getParameter("anio_aplicacion")) : 0;
    int cve_ugac = request.getParameter("cve_ugac") != null && !request.getParameter("cve_ugac").equals("") ? Integer.parseInt(request.getParameter("cve_ugac")) : 0;
    int numero_ptc = request.getParameter("numero_ptc") != null && !request.getParameter("numero_ptc").equals("") ? Integer.parseInt(request.getParameter("numero_ptc")) : 0;
    int usuario_registro = request.getParameter("usuario_registro") != null && !request.getParameter("usuario_registro").equals("") ? Integer.parseInt(request.getParameter("usuario_registro")) : 0;

    float media_evaluacion_docente = request.getParameter("media_evaluacion_docente") != null && !request.getParameter("media_evaluacion_docente").equals("") ? Float.parseFloat(request.getParameter("media_evaluacion_docente")) : 0.0f;
    float media_evaluacion_tutoreo = request.getParameter("media_evaluacion_tutoreo") != null && !request.getParameter("media_evaluacion_tutoreo").equals("") ? Float.parseFloat(request.getParameter("media_evaluacion_tutoreo")) : 0.0f;
    float promedio_evaluacion_tutoreo = request.getParameter("promedio_evaluacion_tutoreo") != null && !request.getParameter("promedio_evaluacion_tutoreo").equals("") ? Float.parseFloat(request.getParameter("promedio_evaluacion_tutoreo")) : 0.0f;
    float promedio_evaluacion_docente = request.getParameter("promedio_evaluacion_docente") != null && !request.getParameter("promedio_evaluacion_docente").equals("") ? Float.parseFloat(request.getParameter("promedio_evaluacion_docente")) : 0.0f;
    float porcentaje_docentes_acreditados = request.getParameter("porcentaje_docentes_acreditados") != null && !request.getParameter("porcentaje_docentes_acreditados").equals("") ? Float.parseFloat(request.getParameter("porcentaje_docentes_acreditados")) : 0.0f;

    String programa_educativo = request.getParameter("programa_educativo") != null && !request.getParameter("programa_educativo").equals("") ? request.getParameter("programa_educativo") : "-";
    String fortalezas = request.getParameter("fortalezas") != null && !request.getParameter("fortalezas").equals("") ? request.getParameter("fortalezas") : "-";
    String debilidades = request.getParameter("debilidades") != null && !request.getParameter("debilidades").equals("") ? request.getParameter("debilidades") : "-";
    String necesidades = request.getParameter("necesidades") != null && !request.getParameter("necesidades").equals("") ? request.getParameter("necesidades") : "-";
    String prioridad_capacitacion = request.getParameter("prioridad_capacitacion") != null && !request.getParameter("prioridad_capacitacion").equals("") ? request.getParameter("prioridad_capacitacion") : "-";
    String estrategias_intervencion = request.getParameter("estrategias_intervencion") != null && !request.getParameter("estrategias_intervencion").equals("") ? request.getParameter("estrategias_intervencion") : "-";
    String fecha_registro = request.getParameter("fecha_registro") != null && !request.getParameter("fecha_registro").equals("") ? request.getParameter("fecha_registro") : "-";

    int activo = request.getParameter("activo") != null && !request.getParameter("activo").equals("") ? Integer.parseInt(request.getParameter("activo")) : 0;
    int estatus = request.getParameter("estatus") != null && !request.getParameter("estatus").equals("") ? Integer.parseInt(request.getParameter("estatus")) : 0;
    
    switch (accion) {
        case 1:
            out.println(datos.Consultas(parametros, "tablaAnalisis"));
            break;
        case 2:
            temp_obj = new JsonObject();
            temp_obj.addProperty("cve_unidad_academica", cve_unidad_academica);
            temp_obj.addProperty("cve_academia", cve_academia);
            temp_obj.addProperty("programa_educativo", programa_educativo);
            temp_obj.addProperty("numero_ptc", numero_ptc);
            temp_obj.addProperty("anio_aplicacion", anio_aplicacion);
            temp_obj.addProperty("media_evaluacion_docente", media_evaluacion_docente);
            temp_obj.addProperty("media_evaluacion_tutoreo", media_evaluacion_tutoreo);
            temp_obj.addProperty("promedio_evaluacion_tutoreo", promedio_evaluacion_tutoreo);
            temp_obj.addProperty("promedio_evaluacion_docente", promedio_evaluacion_docente);
            temp_obj.addProperty("porcentaje_docentes_acreditados", porcentaje_docentes_acreditados);
            temp_obj.addProperty("fortalezas", fortalezas);
            temp_obj.addProperty("debilidades", debilidades);
            temp_obj.addProperty("necesidades", necesidades);
            temp_obj.addProperty("prioridad_capacitacion", prioridad_capacitacion);
            temp_obj.addProperty("estrategias_intervencion", estrategias_intervencion);
            temp_obj.addProperty("fecha_registro", fecha_registro);
            temp_obj.addProperty("estatus", estatus);
            temp_obj.addProperty("usuario_registro", usuario_registro);

            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "guardarAnalisis"));
            break;
        case 3:
            temp_obj = new JsonObject();

            temp_obj.addProperty("estatus", estatus);
            temp_obj.addProperty("cve_analisis_docente", cve_analisis_docente);

            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "editarEstatus"));
            break;
        case 4:
            out.println(datos.Consultas(parametros, "consultarUnidadAcademica"));
            break;
        case 5:
            out.println(datos.Consultas(parametros, "consultarDepartamento"));
            break;
        case 6:
            out.println(datos.Consultas(parametros, "consultarTipoEvento"));
            break;
        case 7:
            out.println(datos.Consultas(parametros, "consultarUGAC"));
            break;
        case 8:
            out.println(datos.Consultas(parametros, "consultarAcademia"));
            break;
        case 9:
            temp_obj = new JsonObject();

            temp_obj.addProperty("cve_unidad_academica", cve_unidad_academica);
            temp_obj.addProperty("cve_academia", cve_academia);
            temp_obj.addProperty("programa_educativo", programa_educativo);
            temp_obj.addProperty("numero_ptc", numero_ptc);
            temp_obj.addProperty("anio_aplicacion", anio_aplicacion);
            temp_obj.addProperty("media_evaluacion_docente", media_evaluacion_docente);
            temp_obj.addProperty("media_evaluacion_tutoreo", media_evaluacion_tutoreo);
            temp_obj.addProperty("promedio_evaluacion_tutoreo", promedio_evaluacion_tutoreo);
            temp_obj.addProperty("promedio_evaluacion_docente", promedio_evaluacion_docente);
            temp_obj.addProperty("porcentaje_docentes_acreditados", porcentaje_docentes_acreditados);
            temp_obj.addProperty("fortalezas", fortalezas);
            temp_obj.addProperty("debilidades", debilidades);
            temp_obj.addProperty("necesidades", necesidades);
            temp_obj.addProperty("prioridad_capacitacion", prioridad_capacitacion);
            temp_obj.addProperty("estrategias_intervencion", estrategias_intervencion);
            temp_obj.addProperty("fecha_registro", fecha_registro);
            temp_obj.addProperty("activo", activo);
            temp_obj.addProperty("usuario_registro", usuario_registro);

            temp_obj.addProperty("cve_analisis_docente", cve_analisis_docente);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "editarAnalisis"));
            break;
        case 10:
            out.println(datos.Consultas(parametros, "consultarCarrera"));
            break;
        default:
            out.print("ENTRO A CONTROLADOR"+ accion);
            break;
        
    }
%>