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
    int cali_duracion = request.getParameter("cali_duracion") != null && !request.getParameter("cali_duracion").equals("") ? Integer.parseInt(request.getParameter("cali_duracion")) : 0;
    int cali_cumplimiento_o = request.getParameter("cali_cumplimiento_o") != null && !request.getParameter("cali_cumplimiento_o").equals("") ? Integer.parseInt(request.getParameter("cali_cumplimiento_o")) : 0;
    int cali_apli_contenido = request.getParameter("cali_apli_contenido") != null && !request.getParameter("cali_apli_contenido").equals("") ? Integer.parseInt(request.getParameter("cali_apli_contenido")) : 0;
    int cali_contenido = request.getParameter("cali_contenido") != null && !request.getParameter("cali_contenido").equals("") ? Integer.parseInt(request.getParameter("cali_contenido")) : 0;
    int cali_aprendizaje = request.getParameter("cali_aprendizaje") != null && !request.getParameter("cali_aprendizaje").equals("") ? Integer.parseInt(request.getParameter("cali_aprendizaje")) : 0;
    int cali_habil_acti_facilitador = request.getParameter("cali_habil_acti_facilitador") != null && !request.getParameter("cali_habil_acti_facilitador").equals("") ? Integer.parseInt(request.getParameter("cali_habil_acti_facilitador")) : 0;
    int cali_con_dom_facilitador = request.getParameter("cali_con_dom_facilitador") != null && !request.getParameter("cali_con_dom_facilitador").equals("") ? Integer.parseInt(request.getParameter("cali_con_dom_facilitador")) : 0;
    int cali_retroalimentacion_f = request.getParameter("cali_retroalimentacion_f") != null && !request.getParameter("cali_retroalimentacion_f").equals("") ? Integer.parseInt(request.getParameter("cali_retroalimentacion_f")) : 0;
    int cali_motivacion_f = request.getParameter("cali_motivacion_f") != null && !request.getParameter("cali_motivacion_f").equals("") ? Integer.parseInt(request.getParameter("cali_motivacion_f")) : 0;
    int cali_oferta_curso = request.getParameter("cali_oferta_curso") != null && !request.getParameter("cali_oferta_curso").equals("") ? Integer.parseInt(request.getParameter("cali_oferta_curso")) : 0;
    int cali_proceso_inscripcion = request.getParameter("cali_proceso_inscripcion") != null && !request.getParameter("cali_proceso_inscripcion").equals("") ? Integer.parseInt(request.getParameter("cali_proceso_inscripcion")) : 0;
    int cali_comite_organizador = request.getParameter("cali_comite_organizador") != null && !request.getParameter("cali_comite_organizador").equals("") ? Integer.parseInt(request.getParameter("cali_comite_organizador")) : 0;
    int cali_actitud_atencion_comite = request.getParameter("cali_actitud_atencion_comite") != null && !request.getParameter("cali_actitud_atencion_comite").equals("") ? Integer.parseInt(request.getParameter("cali_actitud_atencion_comite")) : 0;
    int cali_herramientas_curso = request.getParameter("cali_herramientas_curso") != null && !request.getParameter("cali_herramientas_curso").equals("") ? Integer.parseInt(request.getParameter("cali_herramientas_curso")) : 0;
    int cali_actividades_desa = request.getParameter("cali_actividades_desa") != null && !request.getParameter("cali_actividades_desa").equals("") ? Integer.parseInt(request.getParameter("cali_actividades_desa")) : 0;
    int cali_objetivo_curso = request.getParameter("cali_objetivo_curso") != null && !request.getParameter("cali_objetivo_curso").equals("") ? Integer.parseInt(request.getParameter("cali_objetivo_curso")) : 0;
    int cve_usuario = request.getParameter("cve_usuario") != null && !request.getParameter("cve_usuario").equals("") ? Integer.parseInt(request.getParameter("cve_usuario")) : 0;
    
    String fecha = request.getParameter("fecha") != null && !request.getParameter("fecha").equals("") ? request.getParameter("fecha") : "-";
    String principal_aprendizaje = request.getParameter("principal_aprendizaje") != null && !request.getParameter("principal_aprendizaje").equals("") ? request.getParameter("principal_aprendizaje") : "-";
    String comentarios = request.getParameter("comentarios") != null && !request.getParameter("comentarios").equals("") ? request.getParameter("comentarios") : "-";
    String nombre_instructor = request.getParameter("nombre_instructor") != null && !request.getParameter("nombre_instructor").equals("") ? request.getParameter("nombre_instructor") : "-";
   
    switch(accion){
        case 1:
            temp_obj = new JsonObject();
            temp_obj.addProperty("cve_jornada", cve_jornada);
            temp_obj.addProperty("nombre_instructor", nombre_instructor);
            temp_obj.addProperty("fecha", fecha);
            temp_obj.addProperty("cali_duracion", cali_duracion);
            temp_obj.addProperty("cali_cumplimiento_o", cali_cumplimiento_o);
            temp_obj.addProperty("cali_apli_contenido", cali_apli_contenido);
            temp_obj.addProperty("cali_contenido", cali_contenido);
            temp_obj.addProperty("cali_aprendizaje", cali_aprendizaje);
            temp_obj.addProperty("cali_habil_acti_facilitador", cali_habil_acti_facilitador);
            temp_obj.addProperty("cali_con_dom_facilitador", cali_con_dom_facilitador);
            temp_obj.addProperty("cali_retroalimentacion_f", cali_retroalimentacion_f);
            temp_obj.addProperty("cali_motivacion_f", cali_motivacion_f);
            temp_obj.addProperty("cali_oferta_curso", cali_oferta_curso);
            temp_obj.addProperty("cali_proceso_inscripcion", cali_proceso_inscripcion);
            temp_obj.addProperty("cali_comite_organizador", cali_comite_organizador);
            temp_obj.addProperty("cali_actitud_atencion_comite", cali_actitud_atencion_comite);
            temp_obj.addProperty("cali_herramientas_curso", cali_herramientas_curso);
            temp_obj.addProperty("cali_actividades_desa", cali_actividades_desa);
            temp_obj.addProperty("cali_objetivo_curso", cali_objetivo_curso);
            temp_obj.addProperty("principal_aprendizaje", principal_aprendizaje);
            temp_obj.addProperty("comentarios", comentarios);
            temp_obj.addProperty("cve_usuario", cve_usuario);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "insertarCuestionario"));
        break;
        case 2:
            out.println(datos.Consultas(parametros, "consultarCuestionarios"));
        break;
    }
    


%>