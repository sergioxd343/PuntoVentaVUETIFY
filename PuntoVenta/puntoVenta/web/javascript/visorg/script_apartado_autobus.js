
//Mensaje del sistema al usuario
function Alerta(visible,color)
{
    document.getElementById("Alerta").visibility = visible;
    document.getElementById("Alerta").style.color = color;
}

//Función para cargar los autobuses disponibles
function Cargar_Autobuses(cve)
{        
    //Validar fechas       
    var fecha_salida = "";
    var fecha_regreso = "";
            
    //Validar la selección de fechas        
    if (document.getElementById("xFechaSalida").value == "")
    {        
        document.getElementById("xFechaSalida").focus();
        return;
    }
    if (document.getElementById("xFechaRegreso").value == "")
    {        
        document.getElementById("xFechaRegreso").focus();
        return;
    }    
    fecha_salida = document.getElementById("xFechaSalida").value;
    fecha_regreso = document.getElementById("xFechaRegreso").value;
    
    if (CompararFechas(fecha_salida, document.getElementById("FechaRegistro").value) == false)
    {
        document.getElementById("xFechaSalida").focus();
        alert("La fecha de salida debe ser mayor a la fecha actual");        
    }
    
    //Validar la selección del tipo de autobus
    if (document.getElementById("ySeleccionAutobus").value == 1)
    {
        $("#Autobuses").css("display", "block");                        
        if (CompararFechas(fecha_salida, fecha_regreso) == false)
        {
            Recargar_Autobuses(cve);
        }
        else
        {
            alert("La fecha de regreso debe ser mayor que la fecha de salida");
            Recargar_AutobusesM();
        }
    }
    else
    {
        $("#Autobuses").css("display", "none");
    }
}

//Función que crea el listado de autobuses
function Recargar_Autobuses(cve)
{                                                    
    //Recarga de la JSP
    $.post("../solicitud_visita/listado_autobus.jsp",
    { 
        vista: 1,
        cve: cve,
        fecha_salida: document.getElementById("xFechaSalida").value,
        fecha_regreso: document.getElementById("xFechaRegreso").value,
        numero_personas: document.getElementById("xNumPersonas").value                
    },
    function(data){
    //Recarga de la JSP al div asignado
    $("#Autobuses").html(data);
        //eventos a ejecutar despues de la recarga                            
    });
}

//Función que crea el mensaje
function Recargar_AutobusesM()
{                                                    
    //Recarga de la JSP
    $.post("listado_autobus.jsp",
    { 
        vista: 0,
        cve: 0,
        fecha_salida: document.getElementById("xFechaSalida").value,
        fecha_regreso: document.getElementById("xFechaRegreso").value,
        numero_personas: 0                
    },
    function(data){
    //Recarga de la JSP al div asignado
    $("#Autobuses").html(data);
        //eventos a ejecutar despues de la recarga                            
    });
}

//Agregar actividad del itinerario
function AgregarActividad()
{
    try
    {         
        var id = 0;
        var fecha = "";
        var horario = "";
        var descripcion = "";
        
        //Validar datos
        if (document.getElementById("xFechaVisitaItinerario").value == "")
        {
            alert("Debes selecionar la fecha de la actividad");
            document.getElementById("xFechaVisitaItinerario").focus();
            return;
        }        
        if (document.getElementById("xHoraItinerario").value == "")
        {
            alert("Debes selecionar la hora de la actividad");
            document.getElementById("xHoraItinerario").focus();
            return;
        }        
        if (document.getElementById("xMinutoItinerario").value == "")
        {
            alert("Debes selecionar el minuto de la actividad");
            document.getElementById("xMinutoItinerario").focus();
            return;
        }        
        if (document.getElementById("xTurnoItinerario").value == "")
        {
            alert("Debes selecionar el turno dela actividad");
            document.getElementById("xTurnoItinerario").focus();
            return;
        }
        if (document.getElementById("xDescripcionActividad").value == "")
        {
            alert("Debes escribir la descripción de la actividad");
            document.getElementById("xDescripcionActividad").focus();
            return;
        }
        
        //Obtener datos
        fecha = document.getElementById("xFechaVisitaItinerario").value;
        horario = document.getElementById("xHoraItinerario").value+":"+document.getElementById("xMinutoItinerario").value+" "+document.getElementById("xTurnoItinerario").value;
        descripcion = document.getElementById("xDescripcionActividad").value;
        
        //Agregar fila en la tabla
        //Se agrega la nueva fila a la tabla de profesores de la interfaz sin tener que recargarla por completo.
        $( "#tbodyActividades" ).append( "<tr id=\""+id+"\" >"+
            "<td align=\"center\" class=\"rCelda\"><span class=\"CeldaMenuOpcion  Estilo2\" onClick=\"$(this).closest('tr').remove();\"><img src=\"../../../images/trash_16.gif\" alt=\"Borrar\" /></span></td>"+ 
            "<td align=\"center\" class=\"rCelda\">"+fecha+" <input type=\"hidden\" id=\"yActividadesF\" name=\"yActividadesF\" value=\""+fecha+"\"> </td>" +       
            "<td align=\"center\" class=\"rCelda\">"+horario+" <input type=\"hidden\" id=\"yActividadesH\" name=\"yActividadesH\" value=\""+horario+"\"> "+
                    "<input type=\"hidden\" id=\"yActividadesHr\" name=\"yActividadesHr\" value=\""+document.getElementById("xHoraItinerario").value+"\"> "+
                    "<input type=\"hidden\" id=\"yActividadesMin\" name=\"yActividadesMin\" value=\""+document.getElementById("xMinutoItinerario").value+"\"> "+
                    "<input type=\"hidden\" id=\"yActividadesT\" name=\"yActividadesT\" value=\""+document.getElementById("xTurnoItinerario").value+"\"> "+
            "</td>" + 
            "<td align=\"center\" class=\"rCelda\">"+descripcion+"<input type=\"hidden\" id=\"yActividadesD\" name=\"yActividadesD\" value=\""+descripcion+"\"> </td>" +                                                         
        "</tr>" );      
    
        document.getElementById("xDescripcionActividad").value == "";
    }
    catch(err)
    {
        txt="Ocurrio un error.\n\n";
        txt+="Mensaje: " + err.message + "\n\n";
        txt+="Presiona ACEPTAR para continuar.\n\n";
        alert(txt);
    }
}

//Metodo para seleccionar los alumnos que viajaran
function Grupos(cve_solicitud)
{
    var pagina = "listado_alumnos_grupo.jsp?yCve_solicitud_visita="+cve_solicitud;
    var vWinPres = window.open(pagina , "Grupos Elegidos en la Solicitud de Visita", "width=880, height=700, status=yes, directories=no, scrollbars=yes, resizable=no");		
    vWinPres.opener = self;
}

//Modifica la cantidad de personas que viajaran
function NumeroPersonas(cant)
{
    var total = 0;
    var cantP = 0;
    
    cantP = eval(document.getElementById("nEmpleados").value);
    total = cant + cantP;
    
    document.getElementById("xNumPersonas").value =  total;
    document.getElementById("nTotalAlumnos").innerHTML = cant;
}

//Función para guardar la información en la bd
function Guardar()
{
    if (ValidarDatos()==true)
    {
        document.getElementById("yAccion").value = "Guardar";
        document.forma.submit();
    }
}

//Función para validar los datos que se van a guardar en la BD
function ValidarDatos()
{
    var val = true;                                   
                   
    if (document.getElementById("xFechaSalida").value == "")
    {
        alert("Debes seleccionar la fecha de salida");
        document.getElementById("xFechaSalida").focus();
        val = false;
        return val;
    }   
    if (document.getElementById("xHoraSalida").value == "00")
    {
        alert("Debes seleccionar la hora de salida");
        document.getElementById("xHoraSalida").focus();
        val = false;
        return val;
    }     
    if (document.getElementById("xLugarSalida").value == "")
    {
        alert("Debes escribir el lugar de salida");
        document.getElementById("xMinutoSalida").focus();
        val = false;
        return val;
    } 
    
    if (document.getElementById("xFechaRegreso").value == "")
    {
        alert("Debes seleccionar la fecha de regreso");
        document.getElementById("xFechaRegreso").focus();
        val = false;
        return val;
    }         
    if (document.getElementById("xHoraRegreso").value == "00")
    {
        alert("Debes seleccionar la hora de regreso");
        document.getElementById("xHoraRegreso").focus();
        val = false;
        return val;
    }     
    if (document.getElementById("xLugarRegreso").value == "")
    {
        alert("Debes escribir el lugar de regreso");
        document.getElementById("xLugarRegreso").focus();
        val = false;
        return val;
    } 
    
    if (document.getElementById("xMotivo").value == "")
    {
        alert("Debes escribir el motivo");
        document.getElementById("xMotivo").focus();
        val = false;
        return val;
    }
    
    if (document.getElementById("xObservaciones").value == "")
    {
        alert("Debes escribir las observaciones");
        document.getElementById("xObservaciones").focus();
        val = false;
        return val;
    }
                   
    if (document.getElementById("yActividadesF") == null)
    {
        alert("Debes agregar actividades en el itinerario del viaje");
        val = false;
        return val;
    }            
                                          
    return val;
}

//Función para cancelar
function Cancelar()
{
    window.close();
}

//Envio de mail
function Mail_individual(para, asunto, mensaje)
{                          
    mail_str = "mailto:"+para+"?subject="+asunto;
    mail_str += "&body="+mensaje;
             
    location.href = mail_str       
}

//Comparar fechas
function CompararFechas(fecha, fecha2)  
{  
    var xMonth=fecha.substring(3, 5);  
    var xDay=fecha.substring(0, 2);  
    var xYear=fecha.substring(6,10);  
    var yMonth=fecha2.substring(3, 5);  
    var yDay=fecha2.substring(0, 2);  
    var yYear=fecha2.substring(6,10);  
    if (xYear> yYear)  
    {  
        return(true)  
    }  
    else  
    {  
        if (xYear == yYear)  
        {   
        if (xMonth> yMonth)  
        {  
            return(true)  
        }  
        else  
        {   
            if (xMonth == yMonth)  
            {  
            if (xDay> yDay)  
                return(true);  
            else  
                return(false);  
            }  
            else  
            return(false);  
        }  
        }  
        else  
        return(false);  
    }  
}

function Cargar_Autobuses_Consulta(cve)
{
    //Recarga de la JSP
    $.post("../solicitud_visita/listado_autobus.jsp",
    { 
        vista: 2,
        cve: cve,
        fecha_salida: "-",
        fecha_regreso: "-",
        numero_personas: 0                
    },
    function(data){
    //Recarga de la JSP al div asignado
    $("#Autobuses").html(data);
        //eventos a ejecutar despues de la recarga                            
    });
}

function Imprimir()
{
    document.getElementById("opciones").style.display = "none";
    window.print();
    document.forma.submit();  
}