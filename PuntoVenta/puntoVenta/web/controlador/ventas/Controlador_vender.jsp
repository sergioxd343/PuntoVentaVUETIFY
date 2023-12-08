
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
    String xml= String.valueOf(request.getRealPath(""))+"\\model\\ventas\\Vender.xml";
    GeneralDAO datos = new GeneralDAO(xml);
    
    // JsonArray parametros = new JsonArray();
    JsonArray parametros = new JsonArray();
    JsonObject resultados = new JsonObject();
    JsonObject temp_obj;
    Gson gson = new Gson();
    
    int accion = request.getParameter("accion") != null && !request.getParameter("accion").equals("") ? Integer.parseInt(request.getParameter("accion")) : 0;
    int CantidadProductos = request.getParameter("CantidadProductos") != null && !request.getParameter("CantidadProductos").equals("") ? Integer.parseInt(request.getParameter("CantidadProductos")) : 0;
    

    float CostoTotal = request.getParameter("CostoTotal") != null && !request.getParameter("CostoTotal").equals("") ? Float.parseFloat(request.getParameter("CostoTotal")) : 0.0f;

    
    switch (accion) {
        case 1:
            out.println(datos.Consultas(parametros, "tablaProductos"));
         break;

        case 2:
            temp_obj = new JsonObject();
            temp_obj.addProperty("CantidadProductos", CantidadProductos);
            temp_obj.addProperty("CostoTotal", CostoTotal);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "guardarVenta"));
        break;
            
            /*
        case 2:
            temp_obj = new JsonObject();
            temp_obj.addProperty("nombre_programa", nombre_programa);
            temp_obj.addProperty("descripcion_programa", descripcion_programa);
            temp_obj.addProperty("numero_modulos", numero_modulos);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "guardarProgramaDesarrollo"));
            break;
        case 3:
            temp_obj = new JsonObject();
            temp_obj.addProperty("activo", activo);
            temp_obj.addProperty("IDProducto",IDProducto);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "desactivarProgramaDesarrollo"));
           break;
        case 4:
            temp_obj = new JsonObject();
            temp_obj.addProperty("IDProducto",IDProducto);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "activarProgramaDesarrollo"));
           break;*/
        default:
            out.print("ENTRO A CONTROLADOR"+ accion);
            break;
        
    }
%>