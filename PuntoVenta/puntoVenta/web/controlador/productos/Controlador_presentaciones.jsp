
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
    String xml= String.valueOf(request.getRealPath(""))+"\\model\\productos\\Presentaciones.xml";
    GeneralDAO datos = new GeneralDAO(xml);
    
    // JsonArray parametros = new JsonArray();
    JsonArray parametros = new JsonArray();
    JsonObject resultados = new JsonObject();
    JsonObject temp_obj;
    Gson gson = new Gson();
    
    int accion = request.getParameter("accion") != null && !request.getParameter("accion").equals("") ? Integer.parseInt(request.getParameter("accion")) : 0;
    
    int IDPresentacion = request.getParameter("IDPresentacion") != null && !request.getParameter("IDPresentacion").equals("") ? Integer.parseInt(request.getParameter("IDPresentacion")) : 0;
    int IDProducto = request.getParameter("IDProducto") != null && !request.getParameter("IDProducto").equals("") ? Integer.parseInt(request.getParameter("IDProducto")) : 0;
    int Activo = request.getParameter("Activo")!=null && !request.getParameter("Activo").equals("")?Integer.parseInt(request.getParameter("Activo")):0;
	
    String NombrePresentacion = request.getParameter("NombrePresentacion") != null && !request.getParameter("NombrePresentacion").equals("") ? request.getParameter("NombrePresentacion") : "-";
    String Descripcion = request.getParameter("Descripcion") != null && !request.getParameter("Descripcion").equals("") ? request.getParameter("Descripcion") : "-";
    
    float PrecioPresentacion = request.getParameter("PrecioPresentacion") != null && !request.getParameter("PrecioPresentacion").equals("") ? Float.parseFloat(request.getParameter("PrecioPresentacion")) : 0.0f;


    switch (accion) {
        case 1:
            out.println(datos.Consultas(parametros, "tablaPresentacion"));
            break;
            
        case 2:
            temp_obj = new JsonObject();
            temp_obj.addProperty("IDProducto", IDProducto);
            temp_obj.addProperty("NombrePresentacion", NombrePresentacion);
            temp_obj.addProperty("PrecioPresentacion", PrecioPresentacion);
            temp_obj.addProperty("Descripcion", Descripcion);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "guardarPresentacion"));
            break;
        case 3:
            temp_obj = new JsonObject();
            temp_obj.addProperty("Activo", Activo);
            temp_obj.addProperty("IDPresentacion",IDPresentacion);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "desactivarPresentacion"));
           break;
        case 4:
            temp_obj = new JsonObject();
            temp_obj.addProperty("IDProducto", IDProducto);
            temp_obj.addProperty("NombrePresentacion", NombrePresentacion);
            temp_obj.addProperty("PrecioPresentacion", PrecioPresentacion);
            temp_obj.addProperty("Descripcion", Descripcion);
            temp_obj.addProperty("IDPresentacion",IDPresentacion);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "editarPresentacion"));
           break;
        case 5:
            out.println(datos.Consultas(parametros, "selectProducto"));
            break;
            
        default:
            out.print("ENTRO A CONTROLADOR"+ accion);
            break;
        
    }
%>