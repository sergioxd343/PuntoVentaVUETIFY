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
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonElement"%>
<%@page import="com.google.gson.JsonPrimitive"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.JsonParser"%>
<%@page import="okhttp3.Response"%>
<%@page import="okhttp3.Request"%>
<%@page import="okhttp3.RequestBody"%>
<%@page import="okhttp3.OkHttpClient"%>
<%@page import="okhttp3.MediaType"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="sistema.DAO.GeneralDAO"%>



<%
	String xml= String.valueOf(request.getRealPath(""))+"\\model\\sistema\\CatalogoEmpleados.xml";
    GeneralDAO datos = new GeneralDAO(xml);

	JsonArray parametros = new JsonArray();
    JsonObject resultados = new JsonObject();
    JsonObject temp_obj;
    Gson gson = new Gson();

	int accion = request.getParameter("accion")!=null && !request.getParameter("accion").equals("")?Integer.parseInt(request.getParameter("accion")):0;
	
	
	int cve_persona = request.getParameter("cve_persona")!=null && !request.getParameter("cve_persona").equals("")?Integer.parseInt(request.getParameter("cve_persona")):0;
	String nombre = request.getParameter("nombre")!=null && !request.getParameter("nombre").equals("")?request.getParameter("nombre"): "";
	String apellido_paterno = request.getParameter("apellido_paterno")!=null && !request.getParameter("apellido_paterno").equals("")?request.getParameter("apellido_paterno"): "";
	String apellido_materno = request.getParameter("apellido_materno")!=null && !request.getParameter("apellido_materno").equals("")?request.getParameter("apellido_materno"): "";
	String email = request.getParameter("email")!=null && !request.getParameter("email").equals("")?request.getParameter("email"): "";
	String movil = request.getParameter("movil")!=null && !request.getParameter("movil").equals("")?request.getParameter("movil"): "";
	String curp = request.getParameter("curp")!=null && !request.getParameter("curp").equals("")?request.getParameter("curp"): "";
	String rfc = request.getParameter("rfc")!=null && !request.getParameter("rfc").equals("")?request.getParameter("rfc"): "";
	String sexo = request.getParameter("sexo")!=null && !request.getParameter("sexo").equals("")?request.getParameter("sexo"): "";
	String fecha_nacimiento = request.getParameter("fecha_nacimiento")!=null && !request.getParameter("fecha_nacimiento").equals("")?request.getParameter("fecha_nacimiento"): "";
	int cve_empleado = request.getParameter("cve_empleado")!=null && !request.getParameter("cve_empleado").equals("")?Integer.parseInt(request.getParameter("cve_empleado")):0;
	String grado_estudio = request.getParameter("grado_estudio")!=null && !request.getParameter("grado_estudio").equals("")?request.getParameter("grado_estudio"): "";
	String titulo_recibido = request.getParameter("titulo_recibido")!=null && !request.getParameter("titulo_recibido").equals("")?request.getParameter("titulo_recibido"): "";
	String fecha_ingreso = request.getParameter("fecha_ingreso")!=null && !request.getParameter("fecha_ingreso").equals("")?request.getParameter("fecha_ingreso"): "";
	int cve_puesto = request.getParameter("cve_puesto")!=null && !request.getParameter("cve_puesto").equals("")?Integer.parseInt(request.getParameter("cve_puesto")):0;
	int cve_departemento = request.getParameter("cve_departemento")!=null && !request.getParameter("cve_departemento").equals("")?Integer.parseInt(request.getParameter("cve_departemento")):0;
	String nombre_puesto = request.getParameter("nombre_puesto")!=null && !request.getParameter("nombre_puesto").equals("")?request.getParameter("nombre_puesto"): "";
	String nivel_tabulador = request.getParameter("nivel_tabulador")!=null && !request.getParameter("nivel_tabulador").equals("")?request.getParameter("nivel_tabulador"): "";
	String nombre_tipo_puesto = request.getParameter("nombre_tipo_puesto")!=null && !request.getParameter("nombre_tipo_puesto").equals("")?request.getParameter("nombre_tipo_puesto"): "";
	int cve_tipo_puesto = request.getParameter("cve_tipo_puesto")!=null && !request.getParameter("cve_tipo_puesto").equals("")?Integer.parseInt(request.getParameter("cve_tipo_puesto")):0;
	int cve_area = request.getParameter("cve_area")!=null && !request.getParameter("cve_area").equals("")?Integer.parseInt(request.getParameter("cve_area")):0;
	String nombre_area = request.getParameter("nombre_area")!=null && !request.getParameter("nombre_area").equals("")?request.getParameter("nombre_area"): "";
	int cve_ugac = request.getParameter("cve_ugac")!=null && !request.getParameter("cve_ugac").equals("")?Integer.parseInt(request.getParameter("cve_ugac")):0;
	int cve_unidad_academica = request.getParameter("cve_unidad_academica")!=null && !request.getParameter("cve_unidad_academica").equals("")?Integer.parseInt(request.getParameter("cve_unidad_academica")):0;
	String nombre_usuario = request.getParameter("nombre_usuario")!=null && !request.getParameter("nombre_usuario").equals("")?request.getParameter("nombre_usuario"): "";
	String contrasenia = request.getParameter("contrasenia")!=null && !request.getParameter("contrasenia").equals("")?request.getParameter("contrasenia"): "";
	
	String origen_peticion = "";
	
	switch(accion)
    {
		case 1:
			temp_obj = new JsonObject();
            temp_obj.addProperty("nombre", nombre); 
            temp_obj.addProperty("apellido_paterno", apellido_paterno); 
            temp_obj.addProperty("apellido_materno", apellido_materno); 
            temp_obj.addProperty("email", email); 
            temp_obj.addProperty("movil", movil);
            temp_obj.addProperty("curp", curp);
            temp_obj.addProperty("rfc", rfc);
            temp_obj.addProperty("sexo", sexo);
            temp_obj.addProperty("fecha_nacimiento", fecha_nacimiento);
            temp_obj.addProperty("cve_puesto", cve_puesto);
            temp_obj.addProperty("cve_tipo_puesto", cve_tipo_puesto);
            temp_obj.addProperty("cve_departemento", cve_departemento);
            temp_obj.addProperty("cve_area", cve_area);
            temp_obj.addProperty("cve_ugac", cve_ugac);
            temp_obj.addProperty("cve_unidad_academica", cve_unidad_academica);
            temp_obj.addProperty("fecha_ingreso", fecha_ingreso);
            temp_obj.addProperty("titulo_recibido", titulo_recibido);
            temp_obj.addProperty("grado_estudio", grado_estudio);
            parametros.add(temp_obj);
            out.println(datos.Registro(parametros, "ImportarEmpleados"));
		break;
	}
%>
