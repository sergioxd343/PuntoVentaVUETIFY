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
	String xml= String.valueOf(request.getRealPath(""))+"\\model\\sistema\\Loggin.xml";
	GeneralDAO datos = new GeneralDAO(xml);

// JsonArray parametros = new JsonArray();
	JsonArray parametros = new JsonArray();
	JsonArray results = null;
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
			try {
			if(request.getMethod().equals("POST"))
			{
			JSONObject jsonObject = new JSONObject();

			MediaType JSON = MediaType.parse("application/json; charset=utf-8");
			OkHttpClient client = new OkHttpClient();
			RequestBody body = RequestBody.create(JSON, jsonObject.toString());

			Request peticion = new Request.Builder().url("https://sito.utleon.edu.mx/controlador/sistema/Acceso.jsp?accion=1&usuario="+usuario+"&password="+password).post(body).build();
			Response respuesta = client.newCall(peticion).execute();
			if(!respuesta.body().string().trim().equals("{}"))
				{
			HttpSession sesion = request.getSession(true);
			sesion.setAttribute( "usuario", usuario);
			sesion.setMaxInactiveInterval( 48000 );
			sesion.setAttribute( "num_empleado", "Código de Registro");	
			out.println(respuesta.body().string());
				}
				else
				{
			out.print("");
				}
			
			
			}
			else
			{
				out.println("No existe el metodo indicado");
			}
            }
            catch (Exception e) {
				    Logger.getLogger(this.getClass().getName()).log(Level.SEVERE, null, e);
				    //out.println("{\"err\":\"no_connect_to_ws (01)\"}");
				    System.out.println("Error -- : " + e.getMessage());
				}
		break;
		case 2:
			try {
				Map<String, String> map = new HashMap<String, String>();

				Enumeration headerNames = request.getHeaderNames();
				while (headerNames.hasMoreElements()) {
				String key = (String) headerNames.nextElement();
				String value = request.getHeader(key);
				map.put(key, value);
				}
				
				

				//out.println(map.get("referer"));
				origen_peticion = map.get("referer") != null ? map.get("referer") : "";
				//out.println(map);
			if(request.getMethod().equals("POST") && origen_peticion.equals("https://sito.utleon.edu.mx/logeado_prueba.jsp"))
			{
			JSONObject jsonObject = new JSONObject();

			MediaType JSON = MediaType.parse("application/json; charset=utf-8");
			OkHttpClient client = new OkHttpClient();
			RequestBody body = RequestBody.create(JSON, jsonObject.toString());

			Request peticion = new Request.Builder().url("https://sito.utleon.edu.mx/controlador/sistema/Acceso.jsp?accion=2").post(body).addHeader("ORIGEN", map.get("referer")).build();
			Response respuesta = client.newCall(peticion).execute();
			out.println(respuesta.body().string());
			}
			else
			{
				out.println("No existe el metodo indicado");
			}
            }
            catch (Exception e) {
				    Logger.getLogger(this.getClass().getName()).log(Level.SEVERE, null, e);
				    //out.println("{\"err\":\"no_connect_to_ws (01)\"}");
				    System.out.println("Error -- : " + e.getMessage());
				}
		break;
		case 3:
			parametros.add(usuario);
			parametros.add(password);
			results = datos.Consultas(parametros, "menu");
			out.print(results);		
		break;
		case 4:
			parametros.add(usuario);
			parametros.add(password);
			results = datos.Consultas(parametros, "LogIn");
			out.print(results);		
		break;
		
		
	}
%>
