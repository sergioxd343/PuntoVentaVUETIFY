//Función para buscar información (Grupos, Profesores y Organizaciones)
function Buscar(pagina)
{			            
    var vWinPres = window.open(pagina , "Busqueda", "width=880, height=700, status=yes, directories=no, scrollbars=yes, resizable=no");		
    vWinPres.opener = self;
}

//Función para recargar dinamicamente los filtros de la solicitud        
function Recargar_Filtros(op, t, cve_periodo, rcve_unidad_academica, rcve_area_academica, rcve_carrera, clave_empleado)
{             
    var cve_unidad_academica = 0;
    var cve_area_academica = 0;
    var cve_carrera = 0;
    var cuatrimestre = 0;            

    op = eval(op);
    t  = eval(t);

    if (op == 1)
    {
        cve_unidad_academica = eval(document.getElementById("xUnidadAcademica").value);
        cve_area_academica = eval(document.getElementById("xArea").value);
        cve_carrera = eval(document.getElementById("xCarrera").value);
        cuatrimestre = eval(document.getElementById("xCuatrimestre").value);
    }            
    if (t == 2)
    {
        cve_unidad_academica = rcve_unidad_academica;
        cve_area_academica = rcve_area_academica;
        cve_carrera = rcve_carrera;
        cuatrimestre = 0;
    }

    //Recarga de la JSP
    $.post("filtros_solicitud.jsp",
    {                 
        tipo: t,
        cve_unidad_academica: cve_unidad_academica,
        cve_area_academica: cve_area_academica,
        cve_carrera: cve_carrera,
        cuatrimestre: cuatrimestre,
        clave_empleado: clave_empleado
    },
    function(data){
    //Recarga de la JSP al div asignado
    $("#filtros").html(data);
        //eventos a ejecutar despues de la recarga                   
        if (t != 2)
        {
            if (cve_carrera > 0 && cuatrimestre > 0 && cve_periodo > 0)
            {
                Recargar_Grupos(1, cve_periodo);
            }
            else
            {
                Recargar_Grupos(0, cve_periodo);
            }                    
        }
        else
        {                    
            Recargar_Grupos(2, cve_periodo);
        }
    });
}

//Función para recargar los grupos disponibles del filtro
function Recargar_Grupos(accion, cve_periodo)
{                
    var nCuatrimestre = 0;

    if (accion != 2)
    {
        nCuatrimestre = document.getElementById("xCuatrimestre").value;
    }
    else
    {
        nCuatrimestre = 0;
    }

    //Recarga de la JSP
    $.post("listado_grupos.jsp",
    {
        accion: accion,    
        cve_periodo: cve_periodo,
        cve_carrera: document.getElementById("xCarrera").value,                
        numero_cuatrimestre: nCuatrimestre
    },
    function(data){
    //Recarga de la JSP al div asignado
    $("#grupos").html(data);
        //eventos a ejecutar despues de la recarga                            
    });
}

//Función para cargar los autobuses disponibles
function Cargar_Autobuses(cve)
{
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
    
    document.getElementById("xFechaVisita").value = document.getElementById("xFechaSalida").value;
    
    if (CompararFechas(fecha_salida, document.getElementById("FechaRegistro").value) == false)
    {
        document.getElementById("xFechaSalida").focus();
        alert("La fecha de salida debe ser mayor a la fecha actual");
        return;
    }
    
    //Validar la selección del tipo de autobus
    if (document.getElementById("xSeleccionAutobus").value == 1)
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
    $.post("listado_autobus.jsp",
    { 
        vista: 1,
        cve: cve,
        fecha_salida: document.getElementById("xFechaSalida").value,
        fecha_regreso: document.getElementById("xFechaRegreso").value,
        numero_personas: document.getElementById("xNumeroAlumnos").value                
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

//Agregar el profesor en la tabla
function AgregarProfesores(id, n)
{
    try
    {                                                   
        //Se agrega la nueva fila a la tabla de profesores de la interfaz sin tener que recargarla por completo.
        $( "#tbodyProfesores" ).append( "<tr id=\""+id+"\" >"+
            "<td align=\"center\" class=\"rCelda\"><span class=\"CeldaMenuOpcion  Estilo2 delete3\"><img src=\"../../../images/trash_16.gif\" alt=\"Borrar\" /></span></td>"+ 
            "<td align=\"center\" class=\"rCelda\">"+n+"</td>" +                    
            "<td align=\"center\" class=\"rCelda\"> <input type=\"radio\" name=\"xResponsable\" id=\"xResponsable\" value=\""+id+"\"> <input type=\"hidden\" id=\"yProfesores\" name=\"yProfesores\" value=\""+id+"\"> </td>" +                                                         
        "</tr>" );       
        $(document).on('click', '.delete3', function(){
            $(this).closest('tr').remove();    
        });
    }
    catch(err)
    {
        txt="Ocurrio un error.\n\n";
        txt+="Mensaje: " + err.message + "\n\n";
        txt+="Presiona ACEPTAR para continuar.\n\n";
        alert(txt);
    }
}

//Función para validar si el profesor ya fue agregado en la tabla
function ValidarProfesor(id, n)
{
    document.getElementById("AlertaProfesor").innerHTML = ""; //Limpiar el mensaje

    //Declaración de una variable con el id del control a analizar           
    var elementos = document.getElementsByName("xResponsable"); 
    var lenght = elementos.length; //Numero total de elementos
    for(var index = 0; index < lenght ; index ++)
    {
        if (elementos[index].value == id) //Validar si el id ya se agrego a una fila
        { 
            index = index + 1;                    
            document.getElementById("AlertaProfesor").innerHTML = "El profesor ya fue seleccionado. \nDebes seleccionar otra persona";
            return;
        }       
    }

    //Si la validación paso correctamente se agrega la fila
    AgregarProfesores(id, n);
}               

//Cargar organizaciones
function CargarOrganizacion(id, n)
{
    document.getElementById("yIdOrganizacionSugerida").value = id;
    document.getElementById("xOrganizacionSugerida").value   = n;
}

//Agrega una fila en la sección Organizaciones Sugeridas
function AgregarOrganizacion(id, n, f)
{
    try
    {                                                   
        //Se agrega la nueva fila a la tabla de profesores de la interfaz sin tener que recargarla por completo.
        $( "#tbodyOrganizaciones" ).append( "<tr id=\""+id+"\" >"+
            "<td align=\"center\" class=\"rCelda\"><span class=\"CeldaMenuOpcion  Estilo2 delete2\" ><img src=\"../../../images/trash_16.gif\" alt=\"Borrar\" /></span></td>"+ 
            "<td align=\"center\" class=\"rCelda\">"+n+"<input type=\"hidden\" id=\"yOrganizaciones\" name=\"yOrganizaciones\" value=\""+id+"\"></td>" + 
            "<td align=\"center\" class=\"rCelda\">"+f+"<input type=\"hidden\" id=\"yFechasVisitas\" name=\"yFechasVisitas\" value=\""+f+"\"></td>" +                                        
        "</tr>" );     
        $(document).on('click', '.delete2', function(){
            $(this).closest('tr').remove();    
        });
    }
    catch(err)
    {
        txt="Ocurrio un error.\n\n";
        txt+="Mensaje: " + err.message + "\n\n";
        txt+="Presiona ACEPTAR para continuar.\n\n";
        alert(txt);
    }
}

//Función para validar si la organización esta en la tabla
function ValidarOrganizacion()
{
    var id = eval(document.getElementById("yIdOrganizacionSugerida").value);
    var n  = document.getElementById("xOrganizacionSugerida").value;
    var f  = document.getElementById("xFechaVisita").value;

    //alert(CompararFechas(f, document.getElementById("xFechaSalida").value));
    //alert(CompararFechas(f, document.getElementById("xFechaRegreso").value));

    //Validar la fecha de visita: la fecha de la visita a la organización debe estar entre la fecha de salida y regreso del viaje    
    if (CompararFechas(f, document.getElementById("xFechaSalida").value) == false && CompararFechas(f, document.getElementById("xFechaRegreso").value) == true)
    {
        document.getElementById("xFechaVisita").focus();
        alert("La fecha de la visita a la empresa debe estar entre la fecha de salida y regreso del viaje");
        return;
    }

    //Fecha valida
    f = f.replace(/-/g, '/');

    if (id > 0 && n != "")
    {
        document.getElementById("AlertaOrganizacion").innerHTML = ""; //Limpiar el mensaje

        //Declaración de una variable con el id del control a analizar           
        var elementos = document.getElementsByName("yOrganizaciones"); 
        var lenght = elementos.length; //Numero total de elementos
        for(var index = 0; index < lenght ; index ++)
        {
            if (elementos[index].value == id) //Validar si el id ya se agrego a una fila
            { 
                index = index + 1;                    
                document.getElementById("AlertaOrganizacion").innerHTML = "La organización ya fue seleccionado. \nDebes seleccionar otra";
                return;
            }       
        }

        //Si la validación paso correctamente se agrega la fila
        AgregarOrganizacion(id, n, f);
    }
    else
    {
        alert("Debes seleccionar una organización");
        document.getElementById("xOrganizacionSugerida").focus();
        return;
    }

    document.getElementById("yIdOrganizacionSugerida").value = 0;
    document.getElementById("xOrganizacionSugerida").value = "";
}

//Agrega una fila en la sección Grupos
function AgregarGrupo(id, n)
{
    try
    {  
        var html = '';                
        //Se agrega la nueva fila a la tabla de grupos de la interfaz sin tener que recargarla por completo.                        
        html = "<tr id=\""+id+"\" >"+
                    "<td align=\"center\" class=\"rCelda\" width=\"20%\"><span class=\"CeldaMenuOpcion  Estilo2 delete\" > <img src=\"../../../images/trash_16.gif\" alt=\"Borrar\"/></span></td>"+ 
                    "<td align=\"center\" class=\"rCelda\" width=\"80%\">"+n+"<input type=\"hidden\" id=\"yGrupos\" name=\"yGrupos\" value=\""+id+"\"></td>" +                                        
                "</tr>";                
        $('#xOtrosGrupos').append(html);                   
        $(document).on('click', '.delete', function(){
            $(this).closest('tr').remove();    
        });
        
    }
    catch(err)
    {
        txt="Ocurrio un error.\n\n";
        txt+="Mensaje: " + err.message + "\n\n";
        txt+="Presiona ACEPTAR para continuar.\n\n";
        alert(txt);
    }
}

//Función para validar si la organización y esta en la tabla
function ValidarGrupo(id, n)
{           
    //Validar que se envian datos validos
    if (id > 0 && n != "")
    {
        document.getElementById("AlertaGrupo").innerHTML = ""; //Limpiar el mensaje

        //Validar en los grupos del filtro
        var grupos = document.getElementById("yTotalGrupos").value;
        for (var g=1; g<=grupos; g++)
        {
            if (document.getElementById("xGrupo"+g).value == id) //Validar si el id ya se agrego a una fila
            {                                            
                document.getElementById("AlertaGrupo").innerHTML = "El grupo ya esta incluido en el listado para su selección.";
                return;
            }  
        }

        //Declaración de una variable con el id del control a analizar           
        var elementos = document.getElementsByName("yGrupos"); 
        var lenght = elementos.length; //Numero total de elementos
        for(var index = 0; index < lenght ; index ++)
        {
            if (elementos[index].value == id) //Validar si el id ya se agrego a una fila
            { 
                index = index + 1;                    
                document.getElementById("AlertaGrupo").innerHTML = "El grupo ya fue seleccionado. \nDebes seleccionar otro diferente.";
                return;
            }       
        }
        //Si la validación paso correctamente se agrega la fila
        AgregarGrupo(id, n);
    }            
}

//Función para guardar la información en la bd
function Guardar()
{
    if (ValidarDatos(1)==true)
    {
        document.getElementById("yAccion").value = "Guardar";
        document.forma.submit();
    }
}

//Función para validar los datos que se van a guardar en la BD
function ValidarDatos(t)
{
    var val = true;                                   

    if (document.getElementById("xUnidadAcademica").value <= 0 || document.getElementById("xUnidadAcademica").value == "")
    {
        alert("Debes seleccionar la unidad academica");
        document.getElementById("xUnidadAcademica").focus();
        val = false;
        return val;
    }            
    if (document.getElementById("xArea").value <= 0 || document.getElementById("xArea").value == "")
    {
        alert("Debes seleccionar una área");
        document.getElementById("xArea").focus();
        val = false;
        return val;
    }            
    if (document.getElementById("xCarrera").value <= 0 || document.getElementById("xCarrera").value == "")
    {
        alert("Debes seleccionar una carrera");
        document.getElementById("xCarrera").focus();
        val = false;
        return val;
    }                        
    if (t == 1)
    {
        if (document.getElementById("xCuatrimestre").value <= 0 || document.getElementById("xCuatrimestre").value == "")
        {
            alert("Debes seleccionar un cuatrimestre");
            document.getElementById("xCuatrimestre").focus();
            val = false;
            return val;
        }
    }
    
    if (ValidarGrupos() == false && document.getElementById("yGrupos") == null)
    {
        alert("Debes seleccionar los \"Grupos\" que viajaran");
        val = false;
        return val;
    }    
    
    if (document.getElementById("xNumeroAlumnos").value <= 0 || document.getElementById("xNumeroAlumnos").value == "")
    {
        alert("Debes escirbir el numero de alunmnos");
        document.getElementById("xNumeroAlumnos").focus();
        val = false;
        return val;
    }            
    
    if (document.getElementById("xFechaSalida").value == "")
    {
        alert("Debes seleccionar la fecha de salida");
        document.getElementById("xFechaSalida").focus();
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
    if (document.getElementById("yProfesores") == null)
    {
        alert("Debes seleccionar los \"Profesores\" que viajaran");
        val = false;
        return val;
    }            
    if (document.getElementById("xResponsable").value == null)
    {
        alert("Debes elegir al profesor responsable");
        val = false;
        return val;
    }           
    if (document.getElementById("xTipoViaje").value <= 0 || document.getElementById("xTipoViaje").value == "")
    {
        alert("Debes seleccionar el tipo de viaje");
        document.getElementById("xTipoViaje").focus();
        val = false;
        return val;
    }

    if (ValidarViajeLocal() == true)
    {
        alert("La fecha de salida y regreso deben ser el mismo día cuando el viaje es local");
        document.getElementById("xFechaRegreso").focus();
        val = false;
        return val;
    }

    if (document.getElementById("xSeleccionAutobus").value <= 0 || document.getElementById("xSeleccionAutobus").value == "")
    {
        alert("Debes seleccionar el tipo de autobus");
        document.getElementById("xSeleccionAutobus").focus();
        val = false;
        return val;
    }      
    
    if (document.getElementById("xSeleccionAutobus").value == 1)
    {
        if (document.getElementById("yAutobuses") == null)
        {
            alert("Debes seleccionar los \"Autobuses\" que viajaran");
            val = false;
            return val;
        }  
    }
    
    if (document.getElementById("xComentarios").value == "")
    {
        alert("Debes escribir los comentarios");
        document.getElementById("xComentarios").focus();
        val = false;
        return val;
    }           
    if (document.getElementById("xDescripcionObjetivo").value == "")
    {
        alert("Debes escribir el objetivo del viaje");
        document.getElementById("xDescripcionObjetivo").focus();
        val = false;
        return val;
    }                        
    
    if (document.getElementById("yOrganizaciones") == null)
    {
        if (confirm("Has registrado una empresa temporal ¿La solicitud se guardará con status ''Pendiente'' ?"))
        {
            //EnviarCorreo();            
        }
        else
        {
            alert("Debes seleccionar empresas");
            val = false;
            return val;
        }
    }

    return val;
}

//Mensaje del sistema al usuario
function Alerta(visible,color)
{
    document.getElementById("Alerta").visibility = visible;
    document.getElementById("Alerta").style.color = color;
}

//Función cancelar: reinicia todo el contenido
function Nuevo()
{
    document.forma.submit();
}	

//Función para quitar una orgnización registrada en la BD
function Remover_Organizacion()
{

}

//Función para actualizar los datos de la solicitud de visita
function Actualizar()
{
    if (ValidarDatos(2)==true)
    {
        document.getElementById("yAccion").value = "Actualizar";
        document.forma.submit();
    }
}   

//Función de carga de la solicitud
function CargarSolicitud()
{
    $("#mensaje").css("display", "none");
}

//Función para comparar dos fechas
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

//Función para almacenar temporalmente las empresas temporales registradas por el usuario
function RegistroEmpTemp(nombre)
{
    document.getElementById("yEmpTemp").value = nombre + "," + document.getElementById("yEmpTemp").value;
}

//Función para validar los grupos seleccionados
function ValidarGrupos()
{
    var seleccion = false;
    var totalG = 0;
    
    totalG = eval(document.getElementById("yTotalGrupos").value);
        
    for (var i=1; i<= totalG; i++)
    {
        if (document.getElementById("xGrupo"+i).checked == true)
        {
            seleccion = true;
            return seleccion;
        }
    }    
    return seleccion;
}

//Validar el tipo de viaje
function ValidarTipoViaje()
{    
    if (ValidarViajeLocal() == true)
    {
        alert("La fecha de salida y regreso deben ser el mismo dia cuando el viaje es local");
        document.getElementById("xFechaRegreso").focus();
    }    
}

//Validar que el viaje de tipo local sea el mismo dia de regreso y salida
function ValidarViajeLocal()
{
    if (document.getElementById("xTipoViaje").value == 2)
    {    
        if (document.getElementById("xFechaSalida").value != document.getElementById("xFechaRegreso").value)
        {
            return true;
        }    
    }
    return false;
}

//Envio de mail
function EnviarCorreo(para, cve_solicitud, empresas)
{                    
    document.getElementById("yEmpTemp").value = "Empresa 1,Empresa 2,Empresa 3";
    
    var asunto  = "";
    var mensaje = "";            
    //var empresas = document.getElementById("yEmpTemp").value;        
    var Empresa = empresas.split(",");
       
    asunto = "Solicitud de visita: Empresas temporales registradas";
    
    mensaje = "La solicitud de visita con clave "+cve_solicitud+" ha sido registrada con las siguientes empresas temporales: %0D%0A %0D%0A";        
    
    for (var i=0; i<Empresa.length; i++)
    {
        mensaje += "     - " + Empresa[i] + "%0D%0A";
    }        
                
    mail_str = "mailto:"+para+"?subject="+asunto;
    mail_str += "&body="+mensaje;
             
    location.href = mail_str;    
}

function Imprimir()
{
    document.getElementById("opciones").style.display = "none";
    window.print();
    document.forma.submit();
}