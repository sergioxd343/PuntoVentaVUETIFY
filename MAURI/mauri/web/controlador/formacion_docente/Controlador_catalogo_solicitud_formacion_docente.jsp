<%-- 
    /*
     * <p>Title        : 
     * <p>Description  : 
     * @author         : Maria Guadalupe Gutiérrez Alcantar
     * @version        : 2
     * @date           :  17 - 06 -23
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
    String xml= String.valueOf(request.getRealPath(""))+"\\model\\formacion_docente\\CatalogoSolicitudFormacionDocente.xml";
    GeneralDAO datos = new GeneralDAO(xml);

    // JsonArray parametros = new JsonArray();
    JsonArray parametros = new JsonArray();
    JsonObject resultados = new JsonObject();
    JsonObject temp_obj;
    Gson gson = new Gson();

    int accion = request.getParameter("accion") != null && !request.getParameter("accion").equals("") ? Integer.parseInt(request.getParameter("accion")) : 0;
    

    String numeroControl = request.getParameter("numeroControl") != null && !request.getParameter("numeroControl").equals("") ? request.getParameter("numeroControl") : "-";
    String direccion = request.getParameter("direccion") != null && !request.getParameter("direccion").equals("") ? request.getParameter("direccion") : "-";
    String programa = request.getParameter("programa") != null && !request.getParameter("programa").equals("") ? request.getParameter("programa") : "-";
    String puesto = request.getParameter("puesto") != null && !request.getParameter("puesto").equals("") ? request.getParameter("puesto") : "-";
    String nombre = request.getParameter("nombre") != null && !request.getParameter("nombre").equals("") ? request.getParameter("nombre") : "-";
    String tipoCompetencia = request.getParameter("tipoCompetencia") != null && !request.getParameter("tipoCompetencia").equals("") ? request.getParameter("tipoCompetencia") : "-";
    String nombreCurso = request.getParameter("nombreCurso") != null && !request.getParameter("nombreCurso").equals("") ? request.getParameter("nombreCurso") : "-";
    String fechaInicio = request.getParameter("fechaInicio") != null && !request.getParameter("fechaInicio").equals("") ? request.getParameter("fechaInicio") : "-";
    String fechaFin = request.getParameter("fechaFin") != null && !request.getParameter("fechaFin").equals("") ? request.getParameter("fechaFin") : "-";
    String horario = request.getParameter("horario") != null && !request.getParameter("horario").equals("") ? request.getParameter("horario") : "-";
    String lugar = request.getParameter("lugar") != null && !request.getParameter("lugar").equals("") ? request.getParameter("lugar") : "-";
    String tipoCurso = request.getParameter("tipoCurso") != null && !request.getParameter("tipoCurso").equals("") ? request.getParameter("tipoCurso") : "-";
    String dias = request.getParameter("dias") != null && !request.getParameter("dias").equals("") ? request.getParameter("dias") : "-";
    String horas = request.getParameter("horas") != null && !request.getParameter("horas").equals("") ? request.getParameter("horas") : "-";
    String numeroParticipantes = request.getParameter("numeroParticipantes") != null && !request.getParameter("numeroParticipantes").equals("") ? request.getParameter("numeroParticipantes") : "-";
    String objetivo = request.getParameter("objetivo") != null && !request.getParameter("objetivo").equals("") ? request.getParameter("objetivo") : "-";
    String alcance = request.getParameter("alcance") != null && !request.getParameter("alcance").equals("") ? request.getParameter("alcance") : "-";
    String metodologia = request.getParameter("metodologia") != null && !request.getParameter("metodologia").equals("") ? request.getParameter("metodologia") : "-";
    String programaCurso = request.getParameter("programaCurso") != null && !request.getParameter("programaCurso").equals("") ? request.getParameter("programaCurso") : "-";
    String horasPorTema = request.getParameter("horasPorTema") != null && !request.getParameter("horasPorTema").equals("") ? request.getParameter("horasPorTema") : "-";
    String resultadoAprendizaje = request.getParameter("resultadoAprendizaje") != null && !request.getParameter("resultadoAprendizaje").equals("") ? request.getParameter("resultadoAprendizaje") : "-";
    String perfil = request.getParameter("perfil") != null && !request.getParameter("perfil").equals("") ? request.getParameter("perfil") : "-";
    String tipoFacilitador = request.getParameter("tipoFacilitador") != null && !request.getParameter("tipoFacilitador").equals("") ? request.getParameter("tipoFacilitador") : "-";
    String nombreFacilitador = request.getParameter("nombreFacilitador") != null && !request.getParameter("nombreFacilitador").equals("") ? request.getParameter("nombreFacilitador") : "-";
    String areaPertenece = request.getParameter("areaPertenece") != null && !request.getParameter("areaPertenece").equals("") ? request.getParameter("areaPertenece") : "-";
    String programaEducativo = request.getParameter("programaEducativo") != null && !request.getParameter("programaEducativo").equals("") ? request.getParameter("programaEducativo") : "-";
   
    switch(accion){
        case 1:
            temp_obj = new JsonObject();
            temp_obj.addProperty("nombreFacilitador", nombreFacilitador);
            temp_obj.addProperty("nombreCurso", nombreCurso);
            temp_obj.addProperty("dias", dias);
            temp_obj.addProperty("horas", horas);
            temp_obj.addProperty("numeroParticipantes", numeroParticipantes);
            temp_obj.addProperty("objetivo", objetivo);
            temp_obj.addProperty("alcance", alcance);
            temp_obj.addProperty("metodologia", metodologia);
            temp_obj.addProperty("programaCurso", programaCurso);
            temp_obj.addProperty("horasPorTema", horasPorTema);
            temp_obj.addProperty("resultadoAprendizaje", resultadoAprendizaje);
            temp_obj.addProperty("perfil", perfil);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "insertarSolicitud"));
            break;
        case 2:
        out.println(datos.Consultas(parametros, "tablaSolicitud"));
            break;

        case 3:
            out.println(datos.Consultas(parametros, "cursos"));
            break;

        case 4: 
            out.println(datos.Consultas(parametros, "buscar_cve_docente"));
            break;

        case 5:
            out.println(datos.Consultas(parametros, "tipoInstructor"));
            break;

        case 6:
            out.println(datos.Consultas(parametros, "facilitadores"));
            break;
        
            case 7:
            out.println(datos.Consultas(parametros, "areas"));
            break;
    }


%>