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
    String xml= String.valueOf(request.getRealPath(""))+"\\model\\formacion_docente\\catalogo_necesidad_capacitacion_anual.xml";
    
    GeneralDAO datos = new GeneralDAO(xml);
    
    // JsonArray parametros = new JsonArray();
    JsonArray parametros = new JsonArray();
    JsonObject resultados = new JsonObject();
    JsonObject temp_obj;
    Gson gson = new Gson();
    
    int accion = request.getParameter("accion") != null && !request.getParameter("accion").equals("") ? Integer.parseInt(request.getParameter("accion")) : 0;

    int idEvento = request.getParameter("idEvento") != null && !request.getParameter("idEvento").equals("") ? Integer.parseInt(request.getParameter("idEvento")) : 0;
    
    String annio = request.getParameter("annio") != null && !request.getParameter("annio").equals("") ? request.getParameter("annio") : "-";
    String direccion = request.getParameter("direccion") != null && !request.getParameter("direccion").equals("") ? request.getParameter("direccion") : "-";
    String fechaElavoracion = request.getParameter("fechaElavoracion") != null && !request.getParameter("fechaElavoracion").equals("") ? request.getParameter("fechaElavoracion") : "-";
    String unidadAcademica = request.getParameter("unidadAcademica") != null && !request.getParameter("unidadAcademica").equals("") ? request.getParameter("unidadAcademica") : "-";
    String nivelEducativo = request.getParameter("nivelEducativo") != null && !request.getParameter("nivelEducativo").equals("") ? request.getParameter("nivelEducativo") : "-";
    String direccionArea = request.getParameter("direccionArea") != null && !request.getParameter("direccionArea").equals("") ? request.getParameter("direccionArea") : "-";
    String programaEducativo = request.getParameter("programaEducativo") != null && !request.getParameter("programaEducativo").equals("") ? request.getParameter("programaEducativo") : "-";
    String nombreGestor = request.getParameter("nombreGestor") != null && !request.getParameter("nombreGestor").equals("") ? request.getParameter("nombreGestor") : "-";
    String necesidadesDetectadas = request.getParameter("necesidadesDetectadas") != null && !request.getParameter("necesidadesDetectadas").equals("") ? request.getParameter("necesidadesDetectadas") : "-";
    String nombreEventoCapacitacion = request.getParameter("nombreEventoCapacitacion") != null && !request.getParameter("nombreEventoCapacitacion").equals("") ? request.getParameter("nombreEventoCapacitacion") : "-";
    String objetivoEvento = request.getParameter("objetivoEvento") != null && !request.getParameter("objetivoEvento").equals("") ? request.getParameter("objetivoEvento") : "-";
    String orientacionEvento = request.getParameter("orientacionEvento") != null && !request.getParameter("orientacionEvento").equals("") ? request.getParameter("orientacionEvento") : "-";
    String justificacionEvento = request.getParameter("justificacionEvento") != null && !request.getParameter("justificacionEvento").equals("") ? request.getParameter("justificacionEvento") : "-";
    String tipoEvento = request.getParameter("tipoEvento") != null && !request.getParameter("tipoEvento").equals("") ? request.getParameter("tipoEvento") : "-";
    String otroEvento = request.getParameter("otroEvento") != null && !request.getParameter("otroEvento").equals("") ? request.getParameter("otroEvento") : "-";
    String tipoPrograma = request.getParameter("tipoPrograma") != null && !request.getParameter("tipoPrograma").equals("") ? request.getParameter("tipoPrograma") : "-";
    String proveedorSugerido = request.getParameter("proveedorSugerido") != null && !request.getParameter("proveedorSugerido").equals("") ? request.getParameter("proveedorSugerido") : "-";
    String ptc = request.getParameter("ptc") != null && !request.getParameter("ptc").equals("") ? request.getParameter("ptc") : "-";
    String laboratoristas = request.getParameter("laboratoristas") != null && !request.getParameter("laboratoristas").equals("") ? request.getParameter("laboratoristas") : "-";
    String administrativo = request.getParameter("administrativo") != null && !request.getParameter("administrativo").equals("") ? request.getParameter("administrativo") : "-";
    String otros = request.getParameter("otros") != null && !request.getParameter("otros").equals("") ? request.getParameter("otros") : "-";
    String total = request.getParameter("total") != null && !request.getParameter("total").equals("") ? request.getParameter("total") : "-";
    String totalH = request.getParameter("totalH") != null && !request.getParameter("totalH").equals("") ? request.getParameter("totalH") : "-";
    String totalM = request.getParameter("totalM") != null && !request.getParameter("totalM").equals("") ? request.getParameter("totalM") : "-";
    String lugar = request.getParameter("lugar") != null && !request.getParameter("lugar").equals("") ? request.getParameter("lugar") : "-";
    String costoCapacitacionSugerido = request.getParameter("costoCapacitacionSugerido") != null && !request.getParameter("costoCapacitacionSugerido").equals("") ? request.getParameter("costoCapacitacionSugerido") : "-";
    String transporte = request.getParameter("transporte") != null && !request.getParameter("transporte").equals("") ? request.getParameter("transporte") : "-";
    String casetas = request.getParameter("casetas") != null && !request.getParameter("casetas").equals("") ? request.getParameter("casetas") : "-";
    String alimentacion = request.getParameter("alimentacion") != null && !request.getParameter("alimentacion").equals("") ? request.getParameter("alimentacion") : "-";
    String hospedaje = request.getParameter("hospedaje") != null && !request.getParameter("hospedaje").equals("") ? request.getParameter("hospedaje") : "-";
    String taxis = request.getParameter("taxis") != null && !request.getParameter("taxis").equals("") ? request.getParameter("taxis") : "-";
    String otrosGastos = request.getParameter("otrosGastos") != null && !request.getParameter("otrosGastos").equals("") ? request.getParameter("otrosGastos") : "-";
    String oficial = request.getParameter("oficial") != null && !request.getParameter("oficial").equals("") ? request.getParameter("oficial") : "-";
    String particular = request.getParameter("particular") != null && !request.getParameter("particular").equals("") ? request.getParameter("particular") : "-";
    String otrosO = request.getParameter("otrosO") != null && !request.getParameter("otrosO").equals("") ? request.getParameter("otrosO") : "-";
    String origen = request.getParameter("origen") != null && !request.getParameter("origen").equals("") ? request.getParameter("origen") : "-";
    String mes = request.getParameter("mes") != null && !request.getParameter("mes").equals("") ? request.getParameter("mes") : "-";
    String fechaInicio = request.getParameter("fechaInicio") != null && !request.getParameter("fechaInicio").equals("") ? request.getParameter("fechaInicio") : "-";
    String fechaTermino = request.getParameter("fechaTermino") != null && !request.getParameter("fechaTermino").equals("") ? request.getParameter("fechaTermino") : "-";
    String numDias = request.getParameter("numDias") != null && !request.getParameter("numDias").equals("") ? request.getParameter("numDias") : "-";
    String numHorasEfectivas = request.getParameter("numHorasEfectivas") != null && !request.getParameter("numHorasEfectivas").equals("") ? request.getParameter("numHorasEfectivas") : "-";

    

    switch (accion) {
        case 1:
            out.println(datos.Consultas(parametros, "tablaEventos"));
            break;
        case 2:
            out.println(datos.Consultas(parametros, "unidadAcademica"));
            break;
        case 3:
            out.println(datos.Consultas(parametros, "tipoEvento"));
            break;
        case 4:
            temp_obj = new JsonObject();
           
            temp_obj.addProperty("unidadAcademica", unidadAcademica);
            temp_obj.addProperty("direccionArea", direccionArea);
            temp_obj.addProperty("tipoEvento", tipoEvento);
            temp_obj.addProperty("nivelEducativo", nivelEducativo);
            temp_obj.addProperty("direccion", direccion);
            temp_obj.addProperty("programaEducativo", programaEducativo);
            temp_obj.addProperty("annio", annio);
            temp_obj.addProperty("necesidadesDetectadas", necesidadesDetectadas);
            temp_obj.addProperty("nombreEventoCapacitacion", nombreEventoCapacitacion);
            temp_obj.addProperty("objetivoEvento", objetivoEvento);
            temp_obj.addProperty("justificacionEvento", justificacionEvento);
            temp_obj.addProperty("otroEvento", otroEvento);
            temp_obj.addProperty("proveedorSugerido", proveedorSugerido);
            temp_obj.addProperty("costoCapacitacionSugerido", costoCapacitacionSugerido);
            temp_obj.addProperty("mes", mes);
            temp_obj.addProperty("fechaInicio", fechaInicio);
            temp_obj.addProperty("fechaTermino", fechaTermino);
            temp_obj.addProperty("numDias", numDias);
            temp_obj.addProperty("numHorasEfectivas", numHorasEfectivas);
            temp_obj.addProperty("ptc", ptc);
            temp_obj.addProperty("laboratoristas", laboratoristas);
            temp_obj.addProperty("administrativo", administrativo);
            temp_obj.addProperty("otros", otros);
            temp_obj.addProperty("total", total);
            temp_obj.addProperty("totalH", totalH);
            temp_obj.addProperty("totalM", totalM);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "guardarEvento"));
            break;
        case 5:
            out.println(datos.Consultas(parametros, "area"));
            break;
        
        
    }
%>