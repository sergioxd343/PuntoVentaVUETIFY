//Función para recargar dinamicamente los filtros de la solicitud        
function Recargar_Filtros(tipo, vista)
{             
    var cve_unidad_academica = 0;   
    var cve_periodo = 0;  
    var cve_carrera = 0;
    var cve_area_academica = 0;
    
    if (tipo >= 1)
    {
        cve_unidad_academica = eval(document.getElementById("xUnidadAcademica").value);       
        cve_periodo = eval(document.getElementById("xPeriodo").value);    
        cve_area_academica = 0;  
        cve_carrera = 0;  
    }
    else
    {
        cve_unidad_academica = 0;       
        cve_periodo = 0;
        cve_carrera = 0;
        cve_area_academica = 0;
    }

    //Recarga de la JSP
    $.post("filtros_indicadores.jsp",
    {               
        vista: vista,
        tipo: tipo,
        cve_unidad_academica: cve_unidad_academica,
        cve_area_academica: cve_area_academica,
        cve_carrera: cve_carrera,
        cve_periodo: cve_periodo
    },
    function(data){
    //Recarga de la JSP al div asignado
    $("#filtros").html(data);
        //eventos a ejecutar despues de la recarga   
        if (cve_unidad_academica > 0 && cve_periodo >0)
        {
            Recargar_Datos(cve_unidad_academica, cve_periodo);
        }
        
    });
}

//Recargar los indicadores
function Recargar_Datos(cve_unidad_academica, cve_periodo)
{                 
    //Recarga de la JSP
    $.post("datos_catalogo_indicadores.jsp",
    {               
        vista: 1,        
        cve_unidad_academica: cve_unidad_academica,        
        cve_periodo: cve_periodo
    },
    function(data){
    //Recarga de la JSP al div asignado
    $("#datos").html(data);
        //eventos a ejecutar despues de la recarga                          
    });
}


function Abrir_Datos(url)
{    
    var vWinPres = window.open(url, "Excel", "width=790, height=590, statusbar=yes, directories=no, scrollbars=yes, resizable=no, top=0, left=0, menubar=yes");
}


function Reporte_Exportar(val)
{
    if(document.forma.xUnidadAcademica.value <= 0)
    {
        alert("Debe seleccionar una Unidad");
        document.forma.xUnidadAcademica.focus();
        return;
    }
    if(document.forma.xPeriodo.value <= 0)
    {
        alert("Debe seleccionar un Periodo");
        document.forma.xPeriodo.focus();
        return;
    }
    if(document.forma.xArea.value <= -1)
    {
        alert("Debe seleccionar un Area");
        document.forma.xArea.focus();
        return;
    }
    if(val)
    {
        if(document.forma.xCarrera.value <= 0)
        {
            alert("Debe seleccionar un Carrera");
            document.forma.xCarrera.focus();
            return;
        }
    }
    document.forma.yUnidad.value = document.forma.xUnidadAcademica.options[document.forma.xUnidadAcademica.selectedIndex ].text;
    document.forma.yArea.value = document.forma.xArea.options[document.forma.xArea.selectedIndex ].text;
    document.forma.yPeriodo.value = document.forma.xPeriodo.options[document.forma.xPeriodo.selectedIndex ].text;


    document.forma.yAccion.value = "Reporte_Exportar";
    document.forma.submit();
}

function Mostrar_Empresas(Empresas)
{    
    var pagina = "ver_empresas.jsp?yRecarga=1&yEmpresas="+Empresas;
    var vWinPres = window.open(pagina , "Empresas del indicador", "width=300, height=500, status=yes, directories=no, scrollbars=yes, resizable=no");		
    vWinPres.opener = self;
}

function Recargar_Filtros_Encuesta(tipo, vista)
{             
    var cve_unidad_academica = 0;   
    var cve_periodo = 0;  
    var cve_carrera = 0;
    var cve_area_academica = 0;    
    
    if (tipo == 1)
    {
        cve_unidad_academica = eval(document.getElementById("xUnidadAcademica").value);       
        cve_periodo = eval(document.getElementById("xPeriodo").value);    
        cve_area_academica = eval(document.getElementById("xArea").value);  
        cve_carrera = eval(document.getElementById("xCarrera").value);          
    }
    else if (tipo == 2 || tipo == 3)
    {
        cve_unidad_academica = 0;       
        cve_periodo = eval(document.getElementById("xPeriodo").value); 
        cve_carrera = 0;
        cve_area_academica = 0;                
    }

    //Recarga de la JSP
    $.post("filtros_encuestas.jsp",
    {               
        vista: vista,
        tipo: tipo,
        cve_unidad_academica: cve_unidad_academica,
        cve_area_academica: cve_area_academica,
        cve_carrera: cve_carrera,
        cve_periodo: cve_periodo        
    },
    function(data){
    //Recarga de la JSP al div asignado
    $("#filtros").html(data);
        //eventos a ejecutar despues de la recarga   
//        if (tipo == 1 || tipo == 3)
//        {
//            //Indicadores conteo
//            if (cve_unidad_academica > 0)
//            {
//                RecargarConteoA(cve_unidad_academica, cve_area_academica, cve_carrera, cve_periodo);            
//            }            
//        }
        if (tipo == 2)
        {
            //Indicadores empresas           
            RecargarEmpresas(cve_periodo);
        }
        
    });
}

function TipoEncuestas()
{
    if (eval(document.getElementById("xPeriodo").value) <= 0)
    {
        alert("Debes seleccionar un periodo primero")
        return;
    }
    
    LimpiarE();
    if (document.getElementById("xEmpresaV").checked == true)
    {        
        OcultarSecciones();
    }
    else
    {        
        MostrarSecciones();
    }
    
    RecargarIndicadoresEncuestas();
}


function OcultarSecciones()
{
    $("#contA").css("display", "none");
    $("#IndicadoresA").css("display", "none");
    $("#contP").css("display", "none");
    $("#IndicadoresP").css("display", "none");  
    $("#filtros").css("display", "none"); 
}

function MostrarSecciones()
{    
    $("#contA").css("display", "block");
    $("#IndicadoresA").css("display", "block");
    $("#contP").css("display", "block");
    $("#IndicadoresP").css("display", "block");    
    $("#filtros").css("display", "block"); 
}

function RecargarConteoA(cve_unidad_academica, cve_area_academica, cve_carrera, cve_periodo)
{     
    mostrar_barra();
    //Recarga de la JSP
    $.post("exportacion_conteo.jsp",
    {               
        vista: 1,        
        cve_unidad_academica: cve_unidad_academica,
        cve_area_academica: cve_area_academica,
        cve_carrera: cve_carrera,
        cve_periodo: cve_periodo    
    },
    function(data){
    //Recarga de la JSP al div asignado
    $("#IndicadoresA").html(data);
        //eventos a ejecutar despues de la recarga    
        ocultar_barra();
        RecargarConteoP(cve_unidad_academica, cve_area_academica, cve_carrera, cve_periodo);
            //RecargarConteoE(cve_unidad_academica, cve_area_academica, cve_carrera, cve_periodo);            
    });
}

function RecargarConteoP(cve_unidad_academica, cve_area_academica, cve_carrera, cve_periodo)
{       
    mostrar_barra();
    //Recarga de la JSP
    $.post("exportacion_conteo.jsp",
    {               
        vista: 2,        
        cve_unidad_academica: cve_unidad_academica,
        cve_area_academica: cve_area_academica,
        cve_carrera: cve_carrera,
        cve_periodo: cve_periodo    
    },
    function(data){
    //Recarga de la JSP al div asignado
    $("#IndicadoresP").html(data);
        //eventos a ejecutar despues de la recarga       
        //RecargarConteoP(cve_unidad_academica, cve_area_academica, cve_carrera, cve_periodo);
        ocultar_barra();
        RecargarConteoE(cve_unidad_academica, cve_area_academica, cve_carrera, cve_periodo);        
    });
}

function RecargarConteoE(cve_unidad_academica, cve_area_academica, cve_carrera, cve_periodo)
{       
    mostrar_barra();
    //Recarga de la JSP
    $.post("exportacion_conteo.jsp",
    {               
        vista: 3,        
        cve_unidad_academica: cve_unidad_academica,
        cve_area_academica: cve_area_academica,
        cve_carrera: cve_carrera,
        cve_periodo: cve_periodo    
    },
    function(data){
    //Recarga de la JSP al div asignado
    $("#IndicadoresE").html(data);
        //eventos a ejecutar despues de la recarga     
        ocultar_barra();
    });
}

function RecargarEmpresas(cve_periodo)
{           
    mostrar_barra();
    //Recarga de la JSP
    $.post("exportacion_empresas.jsp",
    {               
        vista: 1,                    
        cve_periodo: cve_periodo
    },
    function(data){
    //Recarga de la JSP al div asignado
    $("#IndicadoresE").html(data);
        //eventos a ejecutar despues de la recarga   
        ocultar_barra();
    });
}

function RecargarIndicadoresEncuestas()
{
    if (document.getElementById("xEmpresaV").checked == true)
    {
        Recargar_Filtros_Encuesta(2, 0);        
    }
    else
    {
        Recargar_Filtros_Encuesta(3, 1);        
    }
}


function LimpiarE()
{       
    //Recarga de la JSP
    $.post("exportacion_conteo.jsp",
    {               
        vista: 0,        
        cve_unidad_academica: 0,
        cve_area_academica: 0,
        cve_carrera: 0,
        cve_periodo: 0    
    },
    function(data){
    //Recarga de la JSP al div asignado
    $("#IndicadoresE").html(data);
        //eventos a ejecutar despues de la recarga                          
    });
}

function ExportarIndicadorEmpresa(cve_solicitud, cve_empresa)
{       
    $("#filtros").css("display", "none"); 
    mostrar_barra();
    //Recarga de la JSP
    $.post("exportar_excel.jsp",
    {               
        tipo: 2,        
        cve_solicitud: cve_solicitud,
        cve_empresa: cve_empresa        
    },
    function(data){
    //Recarga de la JSP al div asignado
    $("#divExportar").html(data);
        //eventos a ejecutar despues de la recarga    
        $("#filtros").css("display", "block"); 
        ocultar_barra();
    });
}

 function abrirLibroExcel(path)
{    
    var pagina = "../../proceso_exportacion_excel.jsp?xParametro1="+path;
    var vWinPres = window.open(pagina, "Excel", "width=790, height=590, statusbar=yes, directories=no, scrollbars=yes, resizable=no, top=0, left=0, menubar=yes");
}

function Vista_Previa()
{
    var cve_unidad_academica = 0;   
    var cve_periodo = 0;  
    var cve_carrera = 0;
    var cve_area_academica = 0; 
    
    if (eval(document.getElementById("xPeriodo").value) <= 0)
    {
        alert("Debes seleccionar un periodo");
        return;
    }
    
    if (eval(document.getElementById("xUnidadAcademica").value) <= 0)
    {
        alert("Debes seleccionar una unidad academica");
        return;
    }
    
    cve_unidad_academica = eval(document.getElementById("xUnidadAcademica").value);       
    cve_periodo = eval(document.getElementById("xPeriodo").value);    
    cve_area_academica = eval(document.getElementById("xArea").value);  
    cve_carrera = eval(document.getElementById("xCarrera").value);    
    
    if (cve_unidad_academica > 0)
    {
        RecargarConteoA(cve_unidad_academica, cve_area_academica, cve_carrera, cve_periodo);            
    }       
}

function Exportar_Conteo()
{               
    $("#filtros").css("display", "none"); 
    mostrar_barra();    
    if (eval(document.getElementById("xPeriodo").value) <= 0)
    {
        alert("Debes seleccionar un periodo");
        return;
    }
    
    if (eval(document.getElementById("xUnidadAcademica").value) <= 0)
    {
        alert("Debes seleccionar una unidad academica");
        return;
    }
    
    //Recarga de la JSP
    $.post("exportar_excel.jsp",
    {               
        tipo: 1,        
        cve_unidad_academica: document.getElementById("xUnidadAcademica").value,
        cve_area_academica: document.getElementById("xArea").value,
        cve_carrera: document.getElementById("xCarrera").value,
        cve_periodo: document.getElementById("xPeriodo").value 
    },
    function(data){
    //Recarga de la JSP al div asignado
    $("#divExportar").html(data);
        //eventos a ejecutar despues de la recarga    
        $("#filtros").css("display", "block"); 
        ocultar_barra();
    });
}

function mostrar_barra()
{
    document.getElementById("contenedorBarra3").style.display='';   
}

function ocultar_barra()
{
    document.getElementById("contenedorBarra3").style.display='none';    
}