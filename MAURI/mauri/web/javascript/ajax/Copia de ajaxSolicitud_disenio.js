
/*
	* <p>Title          : Javascript implementando AJAX para el proyecto ContactosIXAYA</p>
	* <p>Company      	: IXAYA</p>
	* @author           : Mauro de Jes�s Pe�a L�pez
	* @version          : 1.0
	* @date				: 01-05-09
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

function agregarServicio(cve_solicitud, cve_descripcion, cantidad, descripcion, subtotal, cve_empleado, cve_area, cve_tipo, cve_medida, costo, produccion, varPag, div)
{
	//VALIDACIONES
	if(descripcion != '' )
	{
        if(cantidad != '' && cantidad >0)
        {
		// creamos un nuevo objeto ajax
		ajax=null;
		ajax=crearAjax();
	   
		//cargar el archivo html, php, jsp, jsf, asp por el m�todo Post
		ajax.open("POST", varPag, true);
	   
		ajax.onreadystatechange=function()
		{
			if (ajax.readyState==4) // Readystate 4 significa que ya acab� de cargarlo
			{	
				(div).innerHTML= ajax.responseText;
			}
		}
		ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		ajax.send("agregar=1&cve_solicitud="+cve_solicitud+"&cve_descripcion="+cve_descripcion+"&cantidad="+cantidad+"&descripcion="+descripcion+"&subtotal="+subtotal+"&cve_empleado="+cve_empleado+"&cve_area="+cve_area+"&cve_tipo="+cve_tipo+"&cve_medida="+cve_medida+"&costo="+costo+"&produccion="+produccion);
	}else{alert("Introducce una cantidad");}
    }else{alert("Introducce una descripcion");}
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
            (div).innerHTML= ajax.responseText;
        }
    }
	ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    ajax.send("cve_solicitud=" + cve_solicitud);
}

function cargarServicio(cve_solicitud, cve_tipo, descripcion, varPag, div)
{
    // creamos un nuevo objeto ajax
    ajax=crearAjax();
   
    //cargar el archivo html, php, jsp, jsf, asp por el m�todo GET
    ajax.open("POST", varPag , true);
	
    ajax.onreadystatechange=function()
    {
        if (ajax.readyState==4) // Readystate 4 significa que ya acab� de cargarlo
        {
				(div).innerHTML= ajax.responseText;
        }
    }
	ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    ajax.send("cve_solicitud="+ cve_solicitud+"&cve_tipo=" + cve_tipo + "&descripcion=" + descripcion );
}

function cargarMedida(cve_solicitud, cve_tipo, cve_medida, descripcion, varPag, div)
{
    // creamos un nuevo objeto ajax
    ajax=crearAjax();
   
    //cargar el archivo html, php, jsp, jsf, asp por el m�todo GET
    ajax.open("POST", varPag , true);
	
    ajax.onreadystatechange=function()
    {
        if (ajax.readyState==4) // Readystate 4 significa que ya acab� de cargarlo
        {
				(div).innerHTML= ajax.responseText;
        }
    }
	ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    ajax.send("cve_solicitud=" + cve_solicitud + "&cve_tipo="+ cve_tipo +"&cve_medida=" + cve_medida + "&descripcion=" + descripcion);
}

function cargar(varId, varPag, div)
{
    // creamos un nuevo objeto ajax
    ajax=crearAjax();
   
    //cargar el archivo html, php, jsp, jsf, asp por el m�todo GET
    ajax.open("POST", varPag , true);
	
    ajax.onreadystatechange=function()
    {
        if (ajax.readyState==4) // Readystate 4 significa que ya acab� de cargarlo
        {
				(div).innerHTML= ajax.responseText;
        }
    }
	ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    ajax.send("id=" + varId);
}
function guardar(varId, varNombre, varTelefono, varEmail, varImagen, varPag, div)
{
    // creamos un nuevo objeto ajax
    ajax=crearAjax();
   
    //cargar el archivo html, php, jsp, jsf, asp por el m�todo GET
    ajax.open("POST", varPag , true);
	
    ajax.onreadystatechange=function()
    {
        if (ajax.readyState==4) // Readystate 4 significa que ya acab� de cargarlo
        {
				(div).innerHTML= ajax.responseText;
        }
    } 
	ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    ajax.send("id=" + varId + "&nombre=" + varNombre + "&telefono=" + varTelefono + "&email=" + varEmail + "&imagen=" + varImagen + "&guardar=" + 1);
}
function eliminar(varCve_servicio,varCve_descripcion,varCve_solicitud, varPag, div)
{
    // creamos un nuevo objeto ajax
    ajax=crearAjax();
   
    //cargar el archivo html, php, jsp, jsf, asp por el m�todo GET
    ajax.open("POST", varPag , true);
	
    ajax.onreadystatechange=function()
    {
        if (ajax.readyState==4) // Readystate 4 significa que ya acab� de cargarlo
        {
				(div).innerHTML= ajax.responseText;
        }
    }
	ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    ajax.send("servicio=" + varCve_servicio + "&descripcionServicio=" + varCve_descripcion+ "&cve_solicitud=" + varCve_solicitud);
}
