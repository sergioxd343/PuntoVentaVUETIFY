
/*
	* <p>Title          : Javascript implementando AJAX para el proyecto difusion</p>
	* <p>Company      	: Universidad Tecnologica de Leon</p>
	* @author           : Mario Juan de Dios Gutierrez Gomez
	* @version          : 1.0
	* @date				: 11-06-09
*/

function pausar(millis) // www.sean.co.uk
{
	var date = new Date();
	var curDate = null;

	do { curDate = new Date(); }
	while(curDate-date < millis);
}

function crearAjax()
{
    var xmlhttp=false;
     try
    {
      xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
    }
    catch (e)
    {
        try
        {
               xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
          }
        catch (E)
        {
               xmlhttp = false;
          }
     }

    if (!xmlhttp && typeof XMLHttpRequest!='undefined')
    {
          xmlhttp = new XMLHttpRequest();
    }
    return xmlhttp;
}

// ________________ Cosigos para moverse entre los regisros ____________________

//Moverse al primero
function PrimerRegistro(cve_solicitud, varPag, div)
{
     // creamos un nuevo objeto ajax
    ajax=crearAjax();

    //cargar el archivo html, php, jsp, jsf, asp por el m�todo Post
    ajax.open("POST", varPag, true);

    ajax.onreadystatechange=function()
    {
        if (ajax.readyState==4) // Ready state 4 significa que ya acabo de cargarlo
        {
            document.getElementById(div).innerHTML= ajax.responseText;
        }
    }
   
        a = 0;

	ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    ajax.send("primero=1&cve_solicitud="+cve_solicitud+"&pos="+a);
}

//Moverse al siguiente
function SiguienteRegistro(cve_solicitud, numeroRegistro, ultimo, varPag, div)
{
     // creamos un nuevo objeto ajax
    ajax=crearAjax();

    //cargar el archivo html, php, jsp, jsf, asp por el m�todo Post
    ajax.open("POST", varPag, true);

    ajax.onreadystatechange=function()
    {
        if (ajax.readyState==4) // Ready state 4 significa que ya acabo de cargarlo
        {
            document.getElementById(div).innerHTML= ajax.responseText;
        }
    }

    
    b = parseInt(ultimo)-1;
    c = parseInt(numeroRegistro);
    
    if (c<b){
        a = parseInt(numeroRegistro) + 1;
    }
    else{
        a = b;
    }

	ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    ajax.send("siguiente=1&cve_solicitud="+cve_solicitud+"&numeroRegistro="+numeroRegistro+"&pos="+a);
}

//Anterior registro
function AnteriorRegistro(cve_solicitud, numeroRegistro, varPag, div)
{
     // creamos un nuevo objeto ajax
    ajax=crearAjax();

    //cargar el archivo html, php, jsp, jsf, asp por el m�todo Post
    ajax.open("POST", varPag, true);

    ajax.onreadystatechange=function()
    {
        if (ajax.readyState==4) // Ready state 4 significa que ya acabo de cargarlo
        {
            document.getElementById(div).innerHTML= ajax.responseText;
        }
    }

    c = parseInt(numeroRegistro);
    
    if (c>0){
        a = parseInt(numeroRegistro) - 1;
    }
    else{
        a = 0;
    }

	ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    ajax.send("anterior=1&cve_solicitud="+cve_solicitud+"&numeroRegistro="+numeroRegistro+"&pos="+a);
}

//Ultimo registro
function UltimoRegistro(cve_solicitud, ultimo, varPag, div)
{
     // creamos un nuevo objeto ajax
    ajax=crearAjax();

    //cargar el archivo html, php, jsp, jsf, asp por el m�todo Post
    ajax.open("POST", varPag, true);

    ajax.onreadystatechange=function()
    {
        if (ajax.readyState==4) // Ready state 4 significa que ya acabo de cargarlo
        {
            document.getElementById(div).innerHTML= ajax.responseText;
        }
    }

    a = parseInt(ultimo)-1;

	ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    ajax.send("ultimo=1&cve_solicitud="+cve_solicitud+"&pos="+a);
}


function recargarServicios(cve_solicitud, varPag, div)
{
    // creamos un nuevo objeto ajax
    ajax=crearAjax();

    //cargar el archivo html, php, jsp, jsf, asp por el m�todo Post
    ajax.open("POST", varPag, true);

    ajax.onreadystatechange=function()
    {
        if (ajax.readyState==4) // Readystate 4 significa que ya acab� de cargarlo
        {
            document.getElementById(div).innerHTML= ajax.responseText;
        }
    }
	ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    ajax.send("cve_solicitud=" + cve_solicitud);
}


function AgregarStatus(cve_solicitud, status, numeroRegistro, cve_servicio, varPag, div)
{
	 // creamos un nuevo objeto ajax
    ajax=crearAjax();

    //cargar el archivo html, php, jsp, jsf, asp por el m�todo Post
    ajax.open("POST", varPag, true);

    ajax.onreadystatechange=function()
    {
        if (ajax.readyState==4) // Ready state 4 significa que ya acabo de cargarlo
        {
            document.getElementById(div).innerHTML= ajax.responseText;
        }
    }

    ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    ajax.send("agregar_status=1&cve_solicitud="+cve_solicitud+"&status="+status+"&pos="+numeroRegistro+"&cve_servicio="+cve_servicio);
}

function Cancelar_servicio(activo, cve_servicio, cve_solicitud, pos, varPag, div)
{
    // creamos un nuevo objeto ajax
    ajax=crearAjax();

    //cargar el archivo html, php, jsp, jsf, asp por el m�todo Post
    ajax.open("POST", varPag, true);

    ajax.onreadystatechange=function()
    {
        if (ajax.readyState==4) // Readystate 4 significa que ya acab� de cargarlo
        {
            document.getElementById(div).innerHTML= ajax.responseText;
        }
    }
                ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    ajax.send("servicio=1&activo="+activo+"&cve_servicio="+cve_servicio+"&cve_solicitud="+cve_solicitud+"&siguiente=1&pos="+pos);
}

function AgregarObservaciones(cve_solicitud, observaciones, numeroRegistro, cve_servicio, autorizada, varPag, div)
{
	 // creamos un nuevo objeto ajax
    ajax=crearAjax();

    //cargar el archivo html, php, jsp, jsf, asp por el m�todo Post
    ajax.open("POST", varPag, true);

    ajax.onreadystatechange=function()
    {
        if (ajax.readyState==4) // Ready state 4 significa que ya acabo de cargarlo
        {
            document.getElementById(div).innerHTML= ajax.responseText;
			//alert(autorizada);
        }
    }

    ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    ajax.send("agregar_observaciones=1&cve_solicitud="+cve_solicitud+"&observaciones="+observaciones+"&pos="+numeroRegistro+"&autorizada="+autorizada+"&cve_servicio="+cve_servicio);
}

