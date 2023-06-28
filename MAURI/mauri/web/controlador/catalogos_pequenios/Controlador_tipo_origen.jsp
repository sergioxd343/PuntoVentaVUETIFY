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

     
     String xml= String.valueOf(request.getRealPath(""))+"\\model\\catalogos_pequenios\\tipo_origen.xml";
     GeneralDAO datos = new GeneralDAO(xml);
//
     //JsonArray parametros = new JsonArray();
     JsonArray parametros = new JsonArray();
     JsonObject resultados = new JsonObject();
     JsonObject temp_obj;
     Gson gson = new Gson();
     
     int accion = request.getParameter("accion") != null && !request.getParameter("accion").equals("") ? Integer.parseInt(request.getParameter("accion")) : 0;
     String nombreOrigen = request.getParameter("nombre_tipo_origen") != null && !request.getParameter("nombre_tipo_origen").equals("") ? request.getParameter("nombre_tipo_origen") : "-";
     String activo = request.getParameter("activo") != null && !request.getParameter("activo").equals("") ? request.getParameter("activo") : "-";
     String pass = request.getParameter("pass") != null && !request.getParameter("pass").equals("") ? request.getParameter("pass") : "-";
     
     int cve_tipo_origen = request.getParameter("cve_tipo_origen") != null && !request.getParameter("cve_tipo_origen").equals("") ? Integer.parseInt(request.getParameter("cve_tipo_origen")) : 0;
     switch (accion) {
        case 1:
           out.println(datos.Consultas(parametros, "tablaTipoOrigen"));
           break;
        case 2:
            temp_obj = new JsonObject();
            temp_obj.addProperty("nombre_tipo_origen", nombreOrigen);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "guardarTipoOrigen"));
            break;   
        case 3:
            temp_obj =new JsonObject();
            temp_obj.addProperty("cve_tipo_origen", cve_tipo_origen);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "eliminar"));
           break;   
        case 4:
            temp_obj =new JsonObject();
            temp_obj.addProperty("cve_tipo_origen", cve_tipo_origen);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "activar"));
           break;   
       default:
           out.print("ENTRO A CONTROLADOR"+ accion);
           break;
       
     }
%>