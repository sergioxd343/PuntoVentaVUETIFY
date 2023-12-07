/****
	*
	* @ Crear el objeto Ajax.
	* @ Jose Antonio Garcia Jaramillo
	* @ 02 de marzo del 2009
	*
	****/

//Instancia del objeto Ajax
var ajax = CrearObjetoAjax();

//Crear objeto Ajax
function CrearObjetoAjax()
{
	//Variable que guardara el objeto creado
	var objetoAjax;
	
/** Crear objeto - Inicio **/
	try
	{
		//Si el explorador es diferente de IE asi se crea el objeto
		objetoAjax = new XMLHttpRequest();
	}
	catch(e)
	{
		//Si el explorador es IE, para todas sus versiones
		var XmlHttpVersions = new Array("MSXML2.XMLHTTP.6.0",
										"MSXML2.XMLHTTP.5.0",
										"MSXML2.XMLHTTP.4.0",
										"MSXML2.XMLHTTP.3.0",
										"MSXML2.XMLHTTP",
										"Microsoft.XMLHTTP");
		
		for(var i=0; i<XmlHttpVersions.length && !objetoAjax; i++)
		{
			try
			{
			//Crear objeto de acuerdo a la version del IE
			objetoAjax = new ActiveXObject(XmlHttpVersions[i]);
			}
			catch(e) 
			{
				objetoAjax = false;
			}
		}
	}
/** Crear objeto - Fin **/

	if(!objetoAjax)
	{
		//Si no se puede crear el objeto se manda un menjase al usuario
		alert("Este navegador no soporta la tecnologia Ajax");
	}
	else
	{
		//Mandamos el objeto creado
		return objetoAjax;
	}
}