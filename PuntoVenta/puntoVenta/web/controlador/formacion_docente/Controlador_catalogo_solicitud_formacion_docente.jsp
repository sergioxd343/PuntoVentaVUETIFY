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
    String lugar = request.getParameter("lugar") != null && !request.getParameter("lugar").equals("") ? request.getParameter("lugar") : "-";
    String fecha = request.getParameter("fecha") != null && !request.getParameter("fecha").equals("") ? request.getParameter("fecha") : "-";
    String horario = request.getParameter("horario") != null && !request.getParameter("horario").equals("") ? request.getParameter("horario") : "-";
    String centroGestor = request.getParameter("centro_gestor") != null && !request.getParameter("centro_gestor").equals("") ? request.getParameter("centro_gestor") : "-";
    String costototal = request.getParameter("horario") != null && !request.getParameter("horario").equals("") ? request.getParameter("horario") : "-";
    String transferenciaNombre = request.getParameter("transferencia_nombre") != null && !request.getParameter("transferencia_nombre").equals("") ? request.getParameter("transferencia_nombre") : "-";
    String transferenciaCuenta = request.getParameter("transferencia_cuenta") != null && !request.getParameter("transferencia_cuenta").equals("") ? request.getParameter("transferencia_cuenta") : "-";
    String transferenciaPlaza = request.getParameter("transferencia_plaza") != null && !request.getParameter("transferencia_plaza").equals("") ? request.getParameter("transferencia_plaza") : "-";
    String transferenciaBanco = request.getParameter("transferencia_banco") != null && !request.getParameter("transferencia_banco").equals("") ? request.getParameter("transferencia_banco") : "-";
    String transferenciaClave = request.getParameter("transferencia_clave") != null && !request.getParameter("transferencia_clave").equals("") ? request.getParameter("transferencia_clave") : "-";
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
    String observaciones = request.getParameter("observaciones") != null && !request.getParameter("observaciones").equals("") ? request.getParameter("observaciones") : "-";
    
    int cve_empleado_anotado = request.getParameter("cve_empleado_anotado") != null && !request.getParameter("cve_empleado_anotado").equals("") ? Integer.parseInt(request.getParameter("cve_empleado_anotado")) : 0;
    int cve_unidad_academica = request.getParameter("cve_unidad_academica") != null && !request.getParameter("cve_unidad_academica").equals("") ? Integer.parseInt(request.getParameter("cve_unidad_academica")) : 0;
    int cve_area = request.getParameter("cve_area") != null && !request.getParameter("cve_area").equals("") ? Integer.parseInt(request.getParameter("cve_area")) : 0;
    int cve_departamento = request.getParameter("cve_departamento") != null && !request.getParameter("cve_departamento").equals("") ? Integer.parseInt(request.getParameter("cve_departamento")) : 0;
    int cve_ugac = request.getParameter("cve_ugac") != null && !request.getParameter("cve_ugac").equals("") ? Integer.parseInt(request.getParameter("cve_ugac")) : 0;
    int cve_tipo_evento = request.getParameter("cve_tipo_evento") != null && !request.getParameter("cve_tipo_evento").equals("") ? Integer.parseInt(request.getParameter("cve_tipo_evento")) : 0;
    int cve_tipo_orientacion = request.getParameter("cve_tipo_orientacion") != null && !request.getParameter("cve_tipo_orientacion").equals("") ? Integer.parseInt(request.getParameter("cve_tipo_orientacion")) : 0;
    int cve_empleado_valida = request.getParameter("cve_empleado_valida") != null && !request.getParameter("cve_empleado_valida").equals("") ? Integer.parseInt(request.getParameter("cve_empleado_valida")) : 0;
    int cve_empleado_responsable = request.getParameter("cve_empleado_responsable") != null && !request.getParameter("cve_empleado_responsable").equals("") ? Integer.parseInt(request.getParameter("cve_empleado_responsable")) : 0;
    int cve_empleado_autoriza = request.getParameter("cve_empleado_autoriza") != null && !request.getParameter("cve_empleado_autoriza").equals("") ? Integer.parseInt(request.getParameter("cve_empleado_autoriza")) : 0;
    int proyecto_presupuesto = request.getParameter("proyectoPresupuesto") != null && !request.getParameter("proyectoPresupuesto").equals("") ? Integer.parseInt(request.getParameter("proyectoPresupuesto")) : 0;
    int costoTotal = request.getParameter("costo_total") != null && !request.getParameter("costo_total").equals("") ? Integer.parseInt(request.getParameter("costo_total")) : 0;
    int numeroHoras = request.getParameter("numeroHoras") != null && !request.getParameter("numeroHoras").equals("") ? Integer.parseInt(request.getParameter("numeroHoras")) : 0;
    int cve_persona = request.getParameter("cve_persona") != null && !request.getParameter("cve_persona").equals("") ? Integer.parseInt(request.getParameter("cve_persona")) : 0;
   
    switch(accion){
        case 1:
            out.println(datos.Registro(parametros, "insertarSolicitud"));
            break;
        case 2:
            out.println(datos.Registro(parametros, "insertarSolicitud"));
            break;
        case 3:
            out.println(datos.Registro(parametros, "insertarSolicitud"));
            break;
        case 4: 
            out.println(datos.Registro(parametros, "insertarSolicitud"));
            break;
        case 5:
            out.println(datos.Consultas(parametros, "areas"));
            break;
        case 6:
            out.println(datos.Consultas(parametros, "tipoEvento"));
            break;
        case 7:
            out.println(datos.Consultas(parametros, "tipoModalidad"));
            break;
        case 8:
            out.println(datos.Consultas(parametros, "unidadAcademica"));
            break;
        case 9:
            out.println(datos.Consultas(parametros, "participantes"));
            break;
            case 10:
            out.println(datos.Consultas(parametros, "participantes"));
            break;
        default:
           out.print("ENTRO A CONTROLADOR"+ accion);
           break;
    }


%>