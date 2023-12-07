
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
    String xml= String.valueOf(request.getRealPath(""))+"\\model\\productos\\Productos.xml";
    GeneralDAO datos = new GeneralDAO(xml);
    
    // JsonArray parametros = new JsonArray();
    JsonArray parametros = new JsonArray();
    JsonObject resultados = new JsonObject();
    JsonObject temp_obj;
    Gson gson = new Gson();
    
    int accion = request.getParameter("accion") != null && !request.getParameter("accion").equals("") ? Integer.parseInt(request.getParameter("accion")) : 0;
    int Activo = request.getParameter("Activo") != null && !request.getParameter("Activo").equals("") ? Integer.parseInt(request.getParameter("Activo")) : 0;
    int IDProducto = request.getParameter("IDProducto") != null && !request.getParameter("IDProducto").equals("") ? Integer.parseInt(request.getParameter("IDProducto")) : 0;
    


    String NombreProducto = request.getParameter("NombreProducto") != null && !request.getParameter("NombreProducto").equals("") ? request.getParameter("NombreProducto") : "-";
    String Descripcion = request.getParameter("Descripcion") != null && !request.getParameter("Descripcion").equals("") ? request.getParameter("Descripcion") : "-";
    String Foto = request.getParameter("Foto") != null && !request.getParameter("Foto").equals("") ? request.getParameter("Foto") : "-";

    float PesoAproximado = request.getParameter("PesoAproximado") != null && !request.getParameter("PesoAproximado").equals("") ? Float.parseFloat(request.getParameter("PesoAproximado")) : 0.0f;

    
    switch (accion) {
        case 1:
            out.println(datos.Consultas(parametros, "tablaProductos"));
            break;
         case 2:
            temp_obj = new JsonObject();
            temp_obj.addProperty("NombreProducto", NombreProducto);
            temp_obj.addProperty("PesoAproximado", PesoAproximado);
            temp_obj.addProperty("Descripcion", Descripcion);
            temp_obj.addProperty("Foto", Foto);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "guardarProducto"));
            break;

        case 3:
            temp_obj = new JsonObject();
            temp_obj.addProperty("Activo", Activo);
            temp_obj.addProperty("IDProducto",IDProducto);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "desactivarProducto"));
           break;
        
        case 4:
            temp_obj = new JsonObject();
            temp_obj.addProperty("NombreProducto", NombreProducto);
            temp_obj.addProperty("PesoAproximado", PesoAproximado);
            temp_obj.addProperty("Descripcion", Descripcion);
            temp_obj.addProperty("Foto", Foto);
            temp_obj.addProperty("IDProducto", IDProducto);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "editarProducto"));
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