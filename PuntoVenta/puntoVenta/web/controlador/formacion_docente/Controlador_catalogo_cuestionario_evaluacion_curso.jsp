<%-- 
    /*
     * <p>Title        : 
     * <p>Description  : 
     * @author         : Maria Guadalupe Gutiérrez Alcantar
     * @version        : 3
     * @date           :  7 - 07 -23
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
    String xml= String.valueOf(request.getRealPath(""))+"\\model\\formacion_docente\\CatalogoCuestionarioEvaluacionCurso.xml";
    GeneralDAO datos = new GeneralDAO(xml);

    // JsonArray parametros = new JsonArray();
    JsonArray parametros = new JsonArray();
    JsonObject resultados = new JsonObject();
    JsonObject temp_obj;
    Gson gson = new Gson();

    int accion = request.getParameter("accion") != null && !request.getParameter("accion").equals("") ? Integer.parseInt(request.getParameter("accion")) : 0;
    
    int cve_jornada = request.getParameter("cve_jornada") != null && !request.getParameter("cve_jornada").equals("") ? Integer.parseInt(request.getParameter("cve_jornada")) : 0;
    int cve_curso = request.getParameter("cve_curso") != null && !request.getParameter("cve_curso").equals("") ? Integer.parseInt(request.getParameter("cve_curso")) : 0;
    int cve_usuario = request.getParameter("cve_usuario") != null && !request.getParameter("cve_usuario").equals("") ? Integer.parseInt(request.getParameter("cve_usuario")) : 0;
    int cve_cuest_eval_curso = request.getParameter("cve_cuest_eval_curso") != null && !request.getParameter("cve_cuest_eval_curso").equals("") ? Integer.parseInt(request.getParameter("cve_cuest_eval_curso")) : 0;
    int activo = request.getParameter("activo") != null && !request.getParameter("activo").equals("") ? Integer.parseInt(request.getParameter("activo")) : 0;
    float cali_curso_contenido = request.getParameter("cali_curso_contenido") != null && !request.getParameter("cali_curso_contenido").equals("") ? Float.parseFloat(request.getParameter("cali_curso_contenido")) : 0.0f;
    float cali_facilitador = request.getParameter("cali_facilitador") != null && !request.getParameter("cali_facilitador").equals("") ? Float.parseFloat(request.getParameter("cali_facilitador")) : 0.0f;
    float cali_organizacion = request.getParameter("cali_organizacion") != null && !request.getParameter("cali_organizacion").equals("") ? Float.parseFloat(request.getParameter("cali_organizacion")) : 0.0f;
    float cali_impacto_aplicacion = request.getParameter("cali_impacto_aplicacion") != null && !request.getParameter("cali_impacto_aplicacion").equals("") ? Float.parseFloat(request.getParameter("cali_impacto_aplicacion")) : 0.0f;
    
    String fecha = request.getParameter("fecha") != null && !request.getParameter("fecha").equals("") ? request.getParameter("fecha") : "-";
    String principal_aprendizaje = request.getParameter("principal_aprendizaje") != null && !request.getParameter("principal_aprendizaje").equals("") ? request.getParameter("principal_aprendizaje") : "-";
    String comentarios = request.getParameter("comentarios") != null && !request.getParameter("comentarios").equals("") ? request.getParameter("comentarios") : "-";
    String nombre_instructor = request.getParameter("nombre_instructor") != null && !request.getParameter("nombre_instructor").equals("") ? request.getParameter("nombre_instructor") : "-";
   
    switch(accion){
        case 1:
            temp_obj = new JsonObject();
            temp_obj.addProperty("cve_jornada", cve_jornada);
            temp_obj.addProperty("cve_curso", cve_curso);
            temp_obj.addProperty("nombre_instructor", nombre_instructor);
            temp_obj.addProperty("fecha", fecha);
            temp_obj.addProperty("cali_curso_contenido", cali_curso_contenido);
            temp_obj.addProperty("cali_facilitador", cali_facilitador);
            temp_obj.addProperty("cali_organizacion", cali_organizacion);
            temp_obj.addProperty("cali_impacto_aplicacion", cali_impacto_aplicacion);
            temp_obj.addProperty("principal_aprendizaje", principal_aprendizaje);
            temp_obj.addProperty("comentarios", comentarios);
            temp_obj.addProperty("cve_usuario", cve_usuario);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "insertarCuestionario"));
        break;
        case 2:
            out.println(datos.Consultas(parametros, "consultarCuestionarios"));
        break;
        case 3:
            temp_obj = new JsonObject();
            temp_obj.addProperty("activo", activo);
            temp_obj.addProperty("cve_cuest_eval_curso", cve_cuest_eval_curso);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "cambiarEstatus"));
        break;
        case 4:
            out.println(datos.Consultas(parametros, "obtenerCursos"));
        break;
    }
    


%>