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
    String xml= String.valueOf(request.getRealPath(""))+"\\model\\eventos\\CatalogoEventos.xml";
    //String xml= String.valueOf("C:\\Capacitacion\\sito\\web\\model\\compras_requisiciones\\CatalogoUsuario.xml");
    GeneralDAO datos = new GeneralDAO(xml);
    
    // JsonArray parametros = new JsonArray();
    JsonArray parametros = new JsonArray();
    JsonObject resultados = new JsonObject();
    JsonObject temp_obj;
    Gson gson = new Gson();
    
    int accion = request.getParameter("accion") != null && !request.getParameter("accion").equals("") ? Integer.parseInt(request.getParameter("accion")) : 0;
    
    int idEvento = request.getParameter("idEvento") != null && !request.getParameter("idEvento").equals("") ? Integer.parseInt(request.getParameter("idEvento")) : 0;
    int idAcademia = request.getParameter("idAcademia") != null && !request.getParameter("idAcademia").equals("") ? Integer.parseInt(request.getParameter("idAcademia")) : 0;
    String nombreEventoCapacitacion = request.getParameter("nombreEventoCapacitacion") != null && !request.getParameter("nombreEventoCapacitacion").equals("") ? request.getParameter("nombreEventoCapacitacion") : "-";
    String objetivoEvento = request.getParameter("objetivoEvento") != null && !request.getParameter("objetivoEvento").equals("") ? request.getParameter("objetivoEvento") : "-";
    String orientacionEvento = request.getParameter("orientacionEvento") != null && !request.getParameter("orientacionEvento").equals("") ? request.getParameter("orientacionEvento") : "-";
    String justificacionEvento = request.getParameter("justificacionEvento") != null && !request.getParameter("justificacionEvento").equals("") ? request.getParameter("justificacionEvento") : "-";
    String tipoEvento = request.getParameter("tipoEvento") != null && !request.getParameter("tipoEvento").equals("") ? request.getParameter("tipoEvento") : "-";
    String otroTipoEvento = request.getParameter("otroTipoEvento") != null && !request.getParameter("otroTipoEvento").equals("") ? request.getParameter("otroTipoEvento") : "-";
    String tipoPrograma = request.getParameter("tipoPrograma") != null && !request.getParameter("tipoPrograma").equals("") ? request.getParameter("tipoPrograma") : "-";
    String proveedorSugerido = request.getParameter("proveedorSugerido") != null && !request.getParameter("proveedorSugerido").equals("") ? request.getParameter("proveedorSugerido") : "-";
    double costoCapacitacionSugerido = request.getParameter("costoCapacitacionSugerido") != null && !request.getParameter("costoCapacitacionSugerido").equals("") ? Double.parseDouble(request.getParameter("costoCapacitacionSugerido")) : 0.0;
    String origenRecursoEvento = request.getParameter("origenRecursoEvento") != null && !request.getParameter("origenRecursoEvento").equals("") ? request.getParameter("origenRecursoEvento") : "-";
    
    int idPeriodo = request.getParameter("idPeriodo") != null && !request.getParameter("idPeriodo").equals("") ? Integer.parseInt(request.getParameter("idPeriodo")) : 0;
    String mes = request.getParameter("mes") != null && !request.getParameter("mes").equals("") ? request.getParameter("mes") : "-";
    String fechaInicio = request.getParameter("fechaInicio") != null && !request.getParameter("fechaInicio").equals("") ? request.getParameter("fechaInicio") : "-";
    String fechaTermino = request.getParameter("fechaTermino") != null && !request.getParameter("fechaTermino").equals("") ? request.getParameter("fechaTermino") : "-";
    int numDias = request.getParameter("numDias") != null && !request.getParameter("numDias").equals("") ? Integer.parseInt(request.getParameter("numDias")) : 0;
    int numHorasEfectivas = request.getParameter("numHorasEfectivas") != null && !request.getParameter("numHorasEfectivas").equals("") ? Integer.parseInt(request.getParameter("numHorasEfectivas")) : 0;



    String nombreBuscar = request.getParameter("nombreBuscar") != null && !request.getParameter("nombreBuscar").equals("") ? request.getParameter("nombreBuscar") : "-";
    String cve_empleado = request.getParameter("cve_empleado") != null && !request.getParameter("cve_empleado").equals("") ? request.getParameter("cve_empleado") : "-";
    String cve_persona = request.getParameter("cve_persona") != null && !request.getParameter("cve_persona").equals("") ? request.getParameter("cve_persona") : "-";
    String cve_permiso = request.getParameter("cve_permiso") != null && !request.getParameter("cve_permiso").equals("") ? request.getParameter("cve_permiso") : "-";

    switch (accion) {
        case 1:
            out.println(datos.Consultas(parametros, "tablaEventos"));
            break;
        case 2:
            temp_obj = new JsonObject();
            temp_obj.addProperty("idAcademia", idAcademia);
            temp_obj.addProperty("nombreEventoCapacitacion", nombreEventoCapacitacion);
            temp_obj.addProperty("objetivoEvento", objetivoEvento);
            temp_obj.addProperty("orientacionEvento", orientacionEvento);
            temp_obj.addProperty("justificacionEvento", justificacionEvento);
            temp_obj.addProperty("tipoEvento", tipoEvento);
            temp_obj.addProperty("otroTipoEvento", otroTipoEvento);
            temp_obj.addProperty("tipoPrograma", tipoPrograma);
            temp_obj.addProperty("proveedorSugerido", proveedorSugerido);
            temp_obj.addProperty("costoCapacitacionSugerido", costoCapacitacionSugerido);
            temp_obj.addProperty("origenRecursoEvento", origenRecursoEvento);

            temp_obj.addProperty("mes", mes);
            temp_obj.addProperty("fechaInicio", fechaInicio);
            temp_obj.addProperty("fechaTermino", fechaTermino);
            temp_obj.addProperty("numDias", numDias);
            temp_obj.addProperty("numHorasEfectivas", numHorasEfectivas);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "guardarEvento"));
            break;
        case 3:
            out.println(datos.Consultas(parametros, "academia"));
            break;
        case 4:
            temp_obj = new JsonObject();
            temp_obj.addProperty("idPeriodo", idPeriodo);
            temp_obj.addProperty("idEvento", idEvento);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "eliminarEvento"));
            break;
        case 5:
            temp_obj = new JsonObject();
            temp_obj.addProperty("idAcademia", idAcademia);
            temp_obj.addProperty("nombreEventoCapacitacion", nombreEventoCapacitacion);
            temp_obj.addProperty("objetivoEvento", objetivoEvento);
            temp_obj.addProperty("orientacionEvento", orientacionEvento);
            temp_obj.addProperty("justificacionEvento", justificacionEvento);
            temp_obj.addProperty("tipoEvento", tipoEvento);
            temp_obj.addProperty("otroTipoEvento", otroTipoEvento);
            temp_obj.addProperty("tipoPrograma", tipoPrograma);
            temp_obj.addProperty("proveedorSugerido", proveedorSugerido);
            temp_obj.addProperty("costoCapacitacionSugerido", costoCapacitacionSugerido);
            temp_obj.addProperty("origenRecursoEvento", origenRecursoEvento);

            temp_obj.addProperty("idEvento", idEvento);

            temp_obj.addProperty("mes", mes);
            temp_obj.addProperty("fechaInicio", fechaInicio);
            temp_obj.addProperty("fechaTermino", fechaTermino);
            temp_obj.addProperty("numDias", numDias);
            temp_obj.addProperty("numHorasEfectivas", numHorasEfectivas);
            temp_obj.addProperty("idPeriodo", idPeriodo);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "ActualizarEvento"));
            break;
            
        default:
            out.print("ENTRO A CONTROLADOR"+ accion);
            break;
        
    }
%>