<%-- 
    /*
     * <p>Title        : 
     * <p>Description  : 
     * @author         :  Maria Guadalupe Gutiérrez Alcantar
     * @version        :  2
     * @date           :  18 - 06 - 2023
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
    
    String numeroControl = request.getParameter("numeroControl") != null && !request.getParameter("numeroControl").equals("") ? request.getParameter("numeroControl") : "-";
    String nombreDocente = request.getParameter("nombreDocente") != null && !request.getParameter("nombreDocente").equals("") ? request.getParameter("nombreDocente") : "-";
    String primerApellidoD = request.getParameter("primerApellidoD") != null && !request.getParameter("primerApellidoD").equals("") ? request.getParameter("primerApellidoD") : "-";
    String segundoApellidoD = request.getParameter("segundoApellidoD") != null && !request.getParameter("segundoApellidoD").equals("") ? request.getParameter("segundoApellidoD") : "-";
    String sexo = request.getParameter("sexo") != null && !request.getParameter("sexo").equals("") ? request.getParameter("sexo") : "-";
    String puesto = request.getParameter("puesto") != null && !request.getParameter("puesto").equals("") ? request.getParameter("puesto") : "-";
    String area = request.getParameter("area") != null && !request.getParameter("area").equals("") ? request.getParameter("area") : "-";
    String carrera = request.getParameter("carrera") != null && !request.getParameter("carrera").equals("") ? request.getParameter("carrera") : "-";
    String tema = request.getParameter("tema") != null && !request.getParameter("tema").equals("") ? request.getParameter("tema") : "-";
    
    String alcance = request.getParameter("alcance") != null && !request.getParameter("alcance").equals("") ? request.getParameter("alcance") : "-";
    String periodo = request.getParameter("periodo") != null && !request.getParameter("periodo").equals("") ? request.getParameter("periodo") : "-";
    String areaCapacitacion = request.getParameter("areaCapacitacion") != null && !request.getParameter("areaCapacitacion").equals("") ? request.getParameter("areaCapacitacion") : "-";
    String fecha = request.getParameter("fecha") != null && !request.getParameter("fecha").equals("") ? request.getParameter("fecha") : "-";
    String escala1 = request.getParameter("escala1") != null && !request.getParameter("escala1").equals("") ? request.getParameter("escala1") : "-";
    String escala2 = request.getParameter("escala2") != null && !request.getParameter("escala2").equals("") ? request.getParameter("escala2") : "-";
    String escala3 = request.getParameter("escala3") != null && !request.getParameter("escala3").equals("") ? request.getParameter("escala3") : "-";
    String escala4 = request.getParameter("escala4") != null && !request.getParameter("escala4").equals("") ? request.getParameter("escala4") : "-";
    String option = request.getParameter("option") != null && !request.getParameter("option").equals("") ? request.getParameter("option") : "-";
    String option1 = request.getParameter("option1") != null && !request.getParameter("option1").equals("") ? request.getParameter("option1") : "-";
    String option2 = request.getParameter("option2") != null && !request.getParameter("option2").equals("") ? request.getParameter("option2") : "-";
    String option3 = request.getParameter("option3") != null && !request.getParameter("option3").equals("") ? request.getParameter("option3") : "-";
    String option4 = request.getParameter("option4") != null && !request.getParameter("option4").equals("") ? request.getParameter("option4") : "-";
    String objetivo = request.getParameter("objetivo") != null && !request.getParameter("objetivo").equals("") ? request.getParameter("objetivo") : "-";
    String promedio = request.getParameter("promedio") != null && !request.getParameter("promedio").equals("") ? request.getParameter("promedio") : "-";
    String evidencias = request.getParameter("evidencias") != null && !request.getParameter("evidencias").equals("") ? request.getParameter("evidencias") : "-";
    String otraAct = request.getParameter("otraAct") != null && !request.getParameter("otraAct").equals("") ? request.getParameter("otraAct") : "-";
    String otraAct1 = request.getParameter("otraAct1") != null && !request.getParameter("otraAct1").equals("") ? request.getParameter("otraAct1") : "-";
    
    
    switch (accion) {
        case 1:
            out.println(datos.Consultas(parametros, "tablaAutoevaluacion"));
            break;
        case 2:
            temp_obj = new JsonObject();
            temp_obj.addProperty("numeroControl", numeroControl); 
            temp_obj.addProperty("evidencias", evidencias); 
            temp_obj.addProperty("otraAct", otraAct); 
            temp_obj.addProperty("otraAct1", otraAct1); 
            temp_obj.addProperty("promedio", promedio);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "guardarAutoevaluacion"));
            break;
        case 3: 
            
            break;
        case 4: 
            out.println(datos.Consultas(parametros, "periodo"));
            break;
    }
%>