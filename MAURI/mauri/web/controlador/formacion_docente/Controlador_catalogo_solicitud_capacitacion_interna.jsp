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
    String xml= String.valueOf(request.getRealPath(""))+"\\model\\formacion_docente\\CatalogoSolicitudCapacitacionInterna.xml";
    GeneralDAO datos = new GeneralDAO(xml);

    // JsonArray parametros = new JsonArray();
    JsonArray parametros = new JsonArray();
    JsonObject resultados = new JsonObject();
    JsonObject temp_obj;
    Gson gson = new Gson();

    int accion = request.getParameter("accion") != null && !request.getParameter("accion").equals("") ? Integer.parseInt(request.getParameter("accion")) : 0;
    int idAreaF = request.getParameter("idAreaF") != null && !request.getParameter("idAreaF").equals("") ? Integer.parseInt(request.getParameter("idAreaF")) : 0;
    int idAreaS = request.getParameter("idAreaS") != null && !request.getParameter("idAreaS").equals("") ? Integer.parseInt(request.getParameter("idAreaS")) : 0;
    String nombreCurso = request.getParameter("nombreCurso") != null && !request.getParameter("nombreCurso").equals("") ? request.getParameter("nombreCurso") : "-";
    String fechaCurso = request.getParameter("fechaCurso") != null && !request.getParameter("fechaCurso").equals("") ? request.getParameter("fechaCurso") : "-";
    String horaCurso = request.getParameter("horaCurso") != null && !request.getParameter("horaCurso").equals("") ? request.getParameter("horaCurso") : "-";
    String lugar = request.getParameter("lugar") != null && !request.getParameter("lugar").equals("") ? request.getParameter("lugar") : "-";
    String nombreFacilitador = request.getParameter("nombreFacilitador") != null && !request.getParameter("nombreFacilitador").equals("") ? request.getParameter("nombreFacilitador") : "-";
    String programaEducativoS = request.getParameter("programaEducativoS") != null && !request.getParameter("programaEducativoS").equals("") ? request.getParameter("programaEducativoS") : "-";
    String programaEducativoF = request.getParameter("programaEducativoF") != null && !request.getParameter("programaEducativoF").equals("") ? request.getParameter("programaEducativoF") : "-";
    String nombreSolicitante = request.getParameter("nombreSolicitante") != null && !request.getParameter("nombreSolicitante").equals("") ? request.getParameter("nombreSolicitante") : "-";
    String tipoCurso = request.getParameter("tipoCurso") != null && !request.getParameter("tipoCurso").equals("") ? request.getParameter("tipoCurso") : "-";
    String puesto = request.getParameter("puesto") != null && !request.getParameter("puesto").equals("") ? request.getParameter("puesto") : "-";
    String tipoCompetencias = request.getParameter("tipoCompetencias") != null && !request.getParameter("tipoCompetencias").equals("") ? request.getParameter("tipoCompetencias") : "-";
    int totalDias = request.getParameter("totalDias") != null && !request.getParameter("totalDias").equals("") ? Integer.parseInt(request.getParameter("totalDias")) : 0;
    int totalHoras = request.getParameter("totalHoras") != null && !request.getParameter("totalHoras").equals("") ? Integer.parseInt(request.getParameter("totalHoras")) : 0;
    int numeroParticipantes = request.getParameter("numeroParticipantes") != null && !request.getParameter("numeroParticipantes").equals("") ? Integer.parseInt(request.getParameter("numeroParticipantes")) : 0;
    String objetivo = request.getParameter("objetivo") != null && !request.getParameter("objetivo").equals("") ? request.getParameter("objetivo") : "-";
    String alcance = request.getParameter("alcance") != null && !request.getParameter("alcance").equals("") ? request.getParameter("alcance") : "-";
    String metodologia = request.getParameter("metodologia") != null && !request.getParameter("metodologia").equals("") ? request.getParameter("metodologia") : "-";
    String programaDelCurso = request.getParameter("programaDelCurso") != null && !request.getParameter("programaDelCurso").equals("") ? request.getParameter("programaDelCurso") : "-";
    int horasPorTema = request.getParameter("horasPorTema") != null && !request.getParameter("horasPorTema").equals("") ? Integer.parseInt(request.getParameter("horasPorTema")) : 0;
    String resultadoDeAprendizaje = request.getParameter("resultadoDeAprendizaje") != null && !request.getParameter("resultadoDeAprendizaje").equals("") ? request.getParameter("resultadoDeAprendizaje") : "-";
    String perfilDeParticipante = request.getParameter("perfilDeParticipante") != null && !request.getParameter("perfilDeParticipante").equals("") ? request.getParameter("perfilDeParticipante") : "-";

    switch(accion){
        case 1:
            temp_obj = new JsonObject();
            temp_obj.addProperty("idAreaF", idAreaF);
            temp_obj.addProperty("idAreaS", idAreaS);
            temp_obj.addProperty("nombreCurso", nombreCurso);
            temp_obj.addProperty("fechaCurso", fechaCurso);
            temp_obj.addProperty("horaCurso", horaCurso);
            temp_obj.addProperty("lugar", lugar);
            temp_obj.addProperty("nombreFacilitador", nombreFacilitador);
            temp_obj.addProperty("programaEducativoS", programaEducativoS);
            temp_obj.addProperty("programaEducativoF", programaEducativoF);
            temp_obj.addProperty("nombreSolicitante", nombreSolicitante);
            temp_obj.addProperty("tipoCurso", tipoCurso);
            temp_obj.addProperty("puesto", puesto);
            temp_obj.addProperty("tipoCompetencias", tipoCompetencias);
            temp_obj.addProperty("totalDias", totalDias);
            temp_obj.addProperty("totalHoras", totalHoras);
            temp_obj.addProperty("numeroParticipantes", numeroParticipantes);
            temp_obj.addProperty("objetivo", objetivo);
            temp_obj.addProperty("alcance", alcance);
            temp_obj.addProperty("metodologia", metodologia);
            temp_obj.addProperty("programaDelCurso", programaDelCurso);
            temp_obj.addProperty("horasPorTema", horasPorTema);
            temp_obj.addProperty("resultadoDeAprendizaje", resultadoDeAprendizaje);
            temp_obj.addProperty("perfilDeParticipante", perfilDeParticipante);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "insertarSolicitud"));
            break;
        case 2:
        out.println(datos.Consultas(parametros, "tablaSolicitud"));
            break;

        case 3:
            out.println(datos.Consultas(parametros, "area"));
            break;

        case 4:

            break;

        case 5:

            break;

        case 6:

            break;
    }


%>