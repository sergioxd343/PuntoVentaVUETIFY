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

     
     String xml= String.valueOf(request.getRealPath(""))+"\\model\\catalogos_pequenios\\instructor.xml";
     GeneralDAO datos = new GeneralDAO(xml);
//
     //JsonArray parametros = new JsonArray();
     JsonArray parametros = new JsonArray();
     JsonObject resultados = new JsonObject();
     JsonObject temp_obj;
     Gson gson = new Gson();
     
     int accion = request.getParameter("accion") != null && !request.getParameter("accion").equals("") ? Integer.parseInt(request.getParameter("accion")) : 0;
     String nombreInstructor = request.getParameter("nombre_instructor") != null && !request.getParameter("nombre_instructor").equals("") ? request.getParameter("nombre_instructor") : "-";
     String areaAcademica = request.getParameter("area_academica") != null && !request.getParameter("area_academica").equals("") ? request.getParameter("area_academica") : "-";
     int tipoInstructor = request.getParameter("cve_tipo_instructor") != null && !request.getParameter("cve_tipo_instructor").equals("") ? Integer.parseInt(request.getParameter("cve_tipo_instructor")) : 0;
     String activo = request.getParameter("activo") != null && !request.getParameter("activo").equals("") ? request.getParameter("activo") : "-";
     String pass = request.getParameter("pass") != null && !request.getParameter("pass").equals("") ? request.getParameter("pass") : "-";
     int cve_persona = request.getParameter("cve_persona") != null && !request.getParameter("cve_persona").equals("") ? Integer.parseInt(request.getParameter("cve_persona")) : 0;
     int cve_instructor = request.getParameter("cve_instructor") != null && !request.getParameter("cve_instructor").equals("") ? Integer.parseInt(request.getParameter("cve_instructor")) : 0;
     switch (accion) {
        case 1:
          out.println(datos.Consultas(parametros, "tablaInstructor"));
          break;
        case 2:
            temp_obj = new JsonObject();
            temp_obj.addProperty("cve_tipo_instructor", tipoInstructor);
            temp_obj.addProperty("nombre_instructor", nombreInstructor);
            temp_obj.addProperty("area_academica", areaAcademica);
            temp_obj.addProperty("usuario_registro", cve_persona);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "guardarInstructor"));
            break;
        case 3:
            temp_obj =new JsonObject();
            temp_obj.addProperty("activo", activo);
            temp_obj.addProperty("cve_instructor", cve_instructor);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "cambiarEstatus"));
           break; 
        case 4:
          out.println(datos.Consultas(parametros, "tipoInstructor"));
          break;  
        case 5:
          out.println(datos.Consultas(parametros, "areaAcademica"));
          break;
        case 6:
          out.println(datos.Consultas(parametros, "empleado"));
          break;
        case 7:
          out.println(datos.Consultas(parametros, "nombreEmpleado"));
          break;
       default:
           out.print("ENTRO A CONTROLADOR"+ accion);
           break;
       
     }
%>