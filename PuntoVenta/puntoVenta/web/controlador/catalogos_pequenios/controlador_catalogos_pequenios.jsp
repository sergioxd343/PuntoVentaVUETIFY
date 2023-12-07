<%-- 
    Document   : login
    Created on : 19/05/2023
    Author     : Juan Pablo Mendoza
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.*, java.io.*, java.text.*"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="okhttp3.Response"%>
<%@page import="okhttp3.Request"%>
<%@page import="okhttp3.RequestBody"%>
<%@page import="okhttp3.OkHttpClient"%>
<%@page import="okhttp3.MediaType"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonElement"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonPrimitive"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.JsonParser"%>
<%@page import="sistema.DAO.GeneralDAO"%>



<%
//VARIABLES DE PLANTILLA
	String xml= String.valueOf(request.getRealPath(""))+"\\model\\catalogos_pequenios\\CatalogosPequenios.xml";
	GeneralDAO datos = new GeneralDAO(xml);

// JsonArray parametros = new JsonArray();
	JsonArray parametros = new JsonArray();
	JsonObject resultados = new JsonObject();
	JsonObject temp_obj;
	Gson gson = new Gson();
	int accion = request.getParameter("accion")!=null && !request.getParameter("accion").equals("")?Integer.parseInt(request.getParameter("accion")):0;
	
	
	String usuario = request.getParameter("usuario")!=null && !request.getParameter("usuario").equals("")?request.getParameter("usuario"): "";
	String password = request.getParameter("password")!=null && !request.getParameter("password").equals("")?request.getParameter("password"): "";

	String origen_peticion = "";
	
	switch(accion)
    {
		case 1:
			out.println(datos.Consultas(parametros, "submenu"));
            break;	
	}
%>
