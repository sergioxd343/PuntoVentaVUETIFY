
function Cargado()
{
    document.getElementById("transparente").style.display = 'none';
    document.getElementById("cargando").style.display = 'none';
}

function Cargar_Solicitudes()
{
    var cve_periodo = 0;
    var cve_unidad_academica = 0;
    var cve_area_academica = 0;
    var cve_carrera = 0;
    var cve_empleado = "";

    //Validar que se hayan elegido datos
    if (document.getElementById("xPeriodo").value > 0)
    {
        cve_periodo = document.getElementById("xPeriodo").value;
    }
    else
    {
        return;
    }
    if (document.getElementById("xUnidadAcademica").value > 0)
    {
        cve_unidad_academica = document.getElementById("xUnidadAcademica").value;
    }
    if (document.getElementById("xArea").value > 0)
    {
        cve_area_academica = document.getElementById("xArea").value
    }
    if (document.getElementById("xCarrera").value > 0)
    {
        cve_carrera = document.getElementById("xCarrera").value
    }
    if (document.getElementById("yCve_Empleado").value != "")
    {
        cve_empleado = document.getElementById("yCve_Empleado").value;
    }

    // Recarga de la JSP
    $.post("listado_solicitudes.jsp",
    {
        accion: '0',
        cve_periodo: cve_periodo,
        cve_unidad_academica: cve_unidad_academica,
        cve_area_academica: cve_area_academica,
        cve_carrera: cve_carrera,
        cve_empleado: cve_empleado
    },
    function(data){
    // Recarga de la JSP al div asignado
    $("#solicitudes").html(data);
    });
}

function Status_Solicitud_Viaje(cve_solicitud, status)
{
    var cve_periodo = 0;
    var cve_unidad_academica = 0;
    var cve_area_academica = 0;
    var cve_carrera = 0;
    var accion = 0;
    var mensaje = "";
    
    accion = eval(status);
    
    if (accion == 7)
    {
        mensaje = "¿Realmente desea cancelar el viaje?";
    }
    if (accion == 2)
    {
        mensaje = "Al activiar el viaje se tendra que realizar la gestión nuevamente, ¿Realmente desea activar nuevamente el viaje? ";
    }

    if (confirm(mensaje))
    {
                
        //Validar que se hayan elegido datos
        if (document.getElementById("xPeriodo").value > 0)
        {
            cve_periodo = document.getElementById("xPeriodo").value;
        }
        else
        {
            return;
        }
        if (document.getElementById("xUnidadAcademica").value > 0)
        {
            cve_unidad_academica = document.getElementById("xUnidadAcademica").value;
        }
        if (document.getElementById("xArea").value > 0)
        {
            cve_area_academica = document.getElementById("xArea").value
        }
        if (document.getElementById("xCarrera").value > 0)
        {
            cve_carrera = document.getElementById("xCarrera").value
        }                                               

        // Recarga de la JSP
        $.post("listado_solicitudes.jsp",
        {
            accion: accion,
            cve_solicitud_status: cve_solicitud,
            cve_periodo: cve_periodo,
            cve_unidad_academica: cve_unidad_academica,
            cve_area_academica: cve_area_academica,
            cve_carrera: cve_carrera       
        },
        function(data){
        // Recarga de la JSP al div asignado
        $("#solicitudes").html(data);
            Cargar_Solicitudes();
        });
    }
}

function Cargar_Solicitud_Visita(cve_solicitud)
{
    var pagina = "../solicitud_visita/proceso_solicitud_visita.jsp?yRecarga=1&yCve_solicitud_visita="+cve_solicitud;
    var vWinPres = window.open(pagina , "Solicitud Visita", "width=880, height=700, status=yes, directories=no, scrollbars=yes, resizable=no");		
    vWinPres.opener = self;
}

function Cargar_Carpeta_Viaje(cve_solicitud)
{
    var pagina = "../carpeta_viaje/proceso_impresion_carpeta_viaje.jsp?yCve_solicitud_visita="+cve_solicitud;
    var vWinPres = window.open(pagina , "Carpeta Viaje", "width=950, height=700, status=yes, directories=no, scrollbars=yes, resizable=no");		
    vWinPres.opener = self;            
}                               

function Cargar_Autobus(cve_solicitud)
{
    var pagina = "../apartado_autobus/proceso_apartado_autobus.jsp?yRecarga=1&yCve_solicitud_visita="+cve_solicitud;
    var vWinPres = window.open(pagina , "Solicitud Visita", "width=950, height=700, status=yes, directories=no, scrollbars=yes, resizable=no");		
    vWinPres.opener = self;
}

function Cargar_Costos(cve_solicitud)
{
    var pagina = "../costos/vista_costos_visita.jsp?cve_solicitud_visita="+cve_solicitud;
    var vWinPres = window.open(pagina , "Solicitud Visita", "width=950, height=700, status=yes, directories=no, scrollbars=yes, resizable=no");		
    vWinPres.opener = self;
}

//CONSULTA
function Cargar_Solicitud_Visita_Consulta(cve_solicitud)
{
    var pagina = "../solicitud_visita/solicitud_visita_consulta.jsp?yCve_solicitud_visita="+cve_solicitud;
    var vWinPres = window.open(pagina , "Solicitud Visita", "width=880, height=700, status=yes, directories=no, scrollbars=yes, resizable=no");		
    vWinPres.opener = self;
}

function Cargar_Autobus_Consulta(cve_solicitud)
{
    var pagina = "../apartado_autobus/consulta_apartado_autobus.jsp?yCve_solicitud_visita="+cve_solicitud;
    var vWinPres = window.open(pagina , "Apartado Autobus", "width=950, height=700, status=yes, directories=no, scrollbars=yes, resizable=no");		
    vWinPres.opener = self;
}

function Cargar_Solicitudes_Consulta()
{
    var cve_periodo = 0;
    var cve_unidad_academica = 0;
    var cve_area_academica = 0;
    var cve_carrera = 0;
    var cve_empleado = "";

    //Validar que se hayan elegido datos
    if (document.getElementById("xPeriodo").value > 0)
    {
        cve_periodo = document.getElementById("xPeriodo").value;
    }
    else
    {
        return;
    }
    if (document.getElementById("xUnidadAcademica").value > 0)
    {
        cve_unidad_academica = document.getElementById("xUnidadAcademica").value;
    }
    if (document.getElementById("xArea").value > 0)
    {
        cve_area_academica = document.getElementById("xArea").value
    }
    if (document.getElementById("xCarrera").value > 0)
    {
        cve_carrera = document.getElementById("xCarrera").value
    }
    if (document.getElementById("yCve_Empleado").value != "")
    {
        cve_empleado = document.getElementById("yCve_Empleado").value;
    }

    // Recarga de la JSP
    $.post("listado_solicitudes_consulta.jsp",
    {
        accion: '0',
        cve_periodo: cve_periodo,
        cve_unidad_academica: cve_unidad_academica,
        cve_area_academica: cve_area_academica,
        cve_carrera: cve_carrera,
        cve_empleado: cve_empleado
    },
    function(data){
    // Recarga de la JSP al div asignado
    $("#solicitudes").html(data);
    });
}

function Cargar_Solicitud_Calendario(cve_solicitud)
{      
    var cve_empleado = "";
    if (document.getElementById("yCve_Empleado").value != "")
    {
        cve_empleado = document.getElementById("yCve_Empleado").value;
    } 
   
    // Recarga de la JSP
    $.post("listado_solicitudes.jsp",
    {
        accion: '5',        
        cve_solicitud: cve_solicitud,
        cve_empleado: cve_empleado
    },
    function(data){
    // Recarga de la JSP al div asignado
    $("#solicitudes").html(data);
    });
}