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
    //HttpSession sesion = request.getSession(false);
    //AccesoSistema acceso = new AccesoSistema();
    //if (sesion.isNew() == true) {
        //response.sendRedirect(response.encodeRedirectURL("../../jsp/acceso_denegado.jsp"));
        //return;
    //}

    //VARIABLES DE PLANTILLA

     
     String xml= String.valueOf(request.getRealPath(""))+"\\model\\catalogos_pequenios\\tipo_modalidad.xml";
     GeneralDAO datos = new GeneralDAO(xml);
//
     //JsonArray parametros = new JsonArray();
     JsonArray parametros = new JsonArray();
     JsonObject resultados = new JsonObject();
     JsonObject temp_obj;
     Gson gson = new Gson();
     
     int accion = request.getParameter("accion") != null && !request.getParameter("accion").equals("") ? Integer.parseInt(request.getParameter("accion")) : 0;
     String nombreModalidad = request.getParameter("nombre_tipo_modalidad") != null && !request.getParameter("nombre_tipo_modalidad").equals("") ? request.getParameter("nombre_tipo_modalidad") : "-";
     
     String pass = request.getParameter("pass") != null && !request.getParameter("pass").equals("") ? request.getParameter("pass") : "-";
     
     int cve_tipo_modalidad = request.getParameter("cve_tipo_modalidad") != null && !request.getParameter("cve_tipo_modalidad").equals("") ? Integer.parseInt(request.getParameter("cve_tipo_modalidad")) : 0;
     switch (accion) {
        case 1:
           out.println(datos.Consultas(parametros, "tablaTipoModalidad"));
           break;
           /*
        case 4:
           out.println(datos.Consultas(parametros, "tablaTipoInstructor"));
           break;
        case 5:
           out.println(datos.Consultas(parametros, "tablaTipoOrigen"));
           break;
        case 6:
           out.println(datos.Consultas(parametros, "tablaTipoCapacitacion"));
           break;
        case 7:
           out.println(datos.Consultas(parametros, "tablaTipoServicio"));
           break;
        case 8:
           out.println(datos.Consultas(parametros, "tablaTipoEspacio"));
           break;
        case 2:
            temp_obj = new JsonObject();
            
            temp_obj.addProperty("nombre_tipo_orientacion", nombreOrientacion);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "guardarTipoOrientacion"));
            break;
        case 10:
            temp_obj = new JsonObject();
            temp_obj.addProperty("nombre_tipo_evento", nombreEvento);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "guardarTipoEvento"));
            break;*/
        case 2:
            temp_obj = new JsonObject();
            temp_obj.addProperty("nombre_tipo_modalidad", nombreModalidad);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "guardarTipoModalidad"));
            break;
            /*
        case 12:
            temp_obj = new JsonObject();
            temp_obj.addProperty("nombre_tipo_instructor", nombreInstructor);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "guardarTipoInstructor"));
            break;
        case 13:
            temp_obj = new JsonObject();
            temp_obj.addProperty("nombre_tipo_origen", nombreOrigen);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "guardarTipoOrigen"));
            break;   
        case 14:
            temp_obj = new JsonObject();
            temp_obj.addProperty("nombre_tipo_capacitacion", nombreCapacitacion);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "guardarTipoCapacitacion"));
            break;     
        case 15:
            temp_obj = new JsonObject();
            temp_obj.addProperty("nombre_tipo_servicio", nombreServicio);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "guardarTipoServicio"));
            break;  
        case 16:
            temp_obj = new JsonObject();
            temp_obj.addProperty("nombre_tipo_espacio", nombreEspacio);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "guardarTipoEspacio"));
            break;  
        case 18:
          out.println(datos.Consultas(parametros, "itemOrientacion"));
          break;*/
          case 3:
            temp_obj =new JsonObject();
            temp_obj.addProperty("cve_tipo_modalidad", cve_tipo_modalidad);
            parametros.add(temp_obj);
         out.println(datos.Registro(parametros, "eliminar"));
           break;   
       default:
           out.print("ENTRO A CONTROLADOR"+ accion);
           break;
       
     }
%>