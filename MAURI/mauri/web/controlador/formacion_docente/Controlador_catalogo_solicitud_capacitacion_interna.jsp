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
    String xml= String.valueOf(request.getRealPath(""))+"\\model\\formacion_docente\\CatalogoSolicitudCapacitacionInterna.xml";
    GeneralDAO datos = new GeneralDAO(xml);

    // JsonArray parametros = new JsonArray();
    JsonArray parametros = new JsonArray();
    JsonObject resultados = new JsonObject();
    JsonObject temp_obj;
    Gson gson = new Gson();

    int accion = request.getParameter("accion") != null && !request.getParameter("accion").equals("") ? Integer.parseInt(request.getParameter("accion")) : 0;
    

    String tipoCompetencia = request.getParameter("tipoCompetencia") != null && !request.getParameter("tipoCompetencia").equals("") ? request.getParameter("tipoCompetencia") : "-";
    String nombreCurso = request.getParameter("nombreCurso") != null && !request.getParameter("nombreCurso").equals("") ? request.getParameter("nombreCurso") : "-";
    String fechaInicio = request.getParameter("fechaInicio") != null && !request.getParameter("fechaInicio").equals("") ? request.getParameter("fechaInicio") : "-";
    String fechaFin = request.getParameter("fechaFin") != null && !request.getParameter("fechaFin").equals("") ? request.getParameter("fechaFin") : "-";
    String horario_inicio = request.getParameter("horario_inicio") != null && !request.getParameter("horario_inicio").equals("") ? request.getParameter("horario_inicio") : "-";
    String horario_fin = request.getParameter("horario_fin") != null && !request.getParameter("horario_fin").equals("") ? request.getParameter("horario_fin") : "-";
    String lugar = request.getParameter("lugar") != null && !request.getParameter("lugar").equals("") ? request.getParameter("lugar") : "-";
    String tipoCurso = request.getParameter("tipoCurso") != null && !request.getParameter("tipoCurso").equals("") ? request.getParameter("tipoCurso") : "-";
    String dias = request.getParameter("dias") != null && !request.getParameter("dias").equals("") ? request.getParameter("dias") : "-";
    String horas = request.getParameter("horas") != null && !request.getParameter("horas").equals("") ? request.getParameter("horas") : "-";
    String numeroParticipantes = request.getParameter("numeroParticipantes") != null && !request.getParameter("numeroParticipantes").equals("") ? request.getParameter("numeroParticipantes") : "-";
    String objetivo = request.getParameter("objetivo") != null && !request.getParameter("objetivo").equals("") ? request.getParameter("objetivo") : "-";
    String alcance = request.getParameter("alcance") != null && !request.getParameter("alcance").equals("") ? request.getParameter("alcance") : "-";
    String metodologia = request.getParameter("metodologia") != null && !request.getParameter("metodologia").equals("") ? request.getParameter("metodologia") : "-";
    String programaCurso = request.getParameter("programaCurso") != null && !request.getParameter("programaCurso").equals("") ? request.getParameter("programaCurso") : "-";
    
    String resultadoAprendizaje = request.getParameter("resultadoAprendizaje") != null && !request.getParameter("resultadoAprendizaje").equals("") ? request.getParameter("resultadoAprendizaje") : "-";
    String perfil = request.getParameter("perfil") != null && !request.getParameter("perfil").equals("") ? request.getParameter("perfil") : "-";
   
    String nombreFacilitador = request.getParameter("nombreFacilitador") != null && !request.getParameter("nombreFacilitador").equals("") ? request.getParameter("nombreFacilitador") : "-";
    String areaPertenece = request.getParameter("areaPertenece") != null && !request.getParameter("areaPertenece").equals("") ? request.getParameter("areaPertenece") : "-";
    String programaEducativo = request.getParameter("programaEducativo") != null && !request.getParameter("programaEducativo").equals("") ? request.getParameter("programaEducativo") : "-";
    String id = request.getParameter("id") != null && !request.getParameter("id").equals("") ? request.getParameter("id") : "-";
    String cve_solicitud = request.getParameter("cve_solicitud") != null && !request.getParameter("cve_solicitud").equals("") ? request.getParameter("cve_solicitud") : "-";
   
    switch(accion){
        case 1:
            temp_obj = new JsonObject();
            temp_obj.addProperty("nombreFacilitador", nombreFacilitador);
            temp_obj.addProperty("areaPertenece", areaPertenece);
            temp_obj.addProperty("programaEducativo", programaEducativo);
            temp_obj.addProperty("horario_inicio", horario_inicio);
            temp_obj.addProperty("horario_fin", horario_fin);
            temp_obj.addProperty("tipoCompetencia", tipoCompetencia);
            temp_obj.addProperty("nombreCurso", nombreCurso);
            temp_obj.addProperty("dias", dias);
            temp_obj.addProperty("horas", horas);
            temp_obj.addProperty("fechaInicio", fechaInicio);
            temp_obj.addProperty("fechaFin", fechaFin);
            temp_obj.addProperty("lugar", lugar);
            temp_obj.addProperty("tipoCurso", tipoCurso);
            temp_obj.addProperty("numeroParticipantes", numeroParticipantes);
            temp_obj.addProperty("objetivo", objetivo);
            temp_obj.addProperty("alcance", alcance);
            temp_obj.addProperty("metodologia", metodologia);
            temp_obj.addProperty("programaCurso", programaCurso);
            temp_obj.addProperty("resultadoAprendizaje", resultadoAprendizaje);
            temp_obj.addProperty("perfil", perfil);
            temp_obj.addProperty("id", id);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "insertarSolicitud"));
            break;
        case 2:
        out.println(datos.Consultas(parametros, "tablaSolicitud"));
            break;
        case 3:
            out.println(datos.Consultas(parametros, "facilitadores"));
            break;
        case 4:
            out.println(datos.Consultas(parametros, "areas"));
            break;
        case 5:
            out.println(datos.Consultas(parametros, "programaEducativo"));
            break; 
        case 6:
            parametros.add(cve_solicitud);
            out.println(datos.Consultas(parametros, "verInstructores"));
            break;
        case 7:
            parametros.add(cve_solicitud);
            out.println(datos.Consultas(parametros, "verSolicitudes"));
            break;
            
    }
    


%>