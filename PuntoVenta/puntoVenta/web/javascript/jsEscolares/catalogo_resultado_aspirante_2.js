
function CatalogoResultadoAspirante(){

	this.cve_interesado = 0;
	this.monto = 0;
	this.fechaInscripcion = "";
	this.fechaLimite = "";
	this.turno = "";
	
   this.crt = "controlador/Controlador_catalogo_resultado_aspirante.jsp";
 
   this.post = null;
   
}



CatalogoResultadoAspirante.prototype.fnBuscar = function()
{
	var o = this;
	var cadena = '';
	var btnString = '';
	
	if($('#xTxtFolio').val() == "")
	{
	swal({
		allowOutsideClick: false,
		title: 'Información!',
		text: 'Debe proporcionar el folio asignado',
		type: 'info',
		confirmButtonText: 'Aceptar'
		}).then(function(){
           $('#xTxtFolio').focus();
        });
	return;
	}
	$.ajax({
        type:"POST" ,
        dataType:"json",
        url:o.crt,
        data:{yAccion:1,folio:$('#xTxtFolio').val()},
        beforeSend:function(){
 
        },success:function(data){
			//alert(data.length);
			
			if(data.length > 0)
			{
			$('#gControlFolio').hide();
			o.cve_interesado = data[0].cve_interesado;
			o.monto = data[0].monto;
			o.fechaInscripcion = data[0].fechaInscripcion;
			o.fechaLimite = data[0].fechaLimite;
			o.turno = data[0].turno;
			//data = JSON.parse(data);
			console.log(data);
			//alert(data[0].estatus);
			if(data[0].estatus === "ACEPTADO")
			{
				cadena = '<p><strong>DATOS GENERALES</strong><br>'+
                        'Folio de Admisión: &nbsp;<strong>'+data[0].folio+'</strong><br>'+
                        'Nombre: &nbsp;<b>'+data[0].aspirante.trim()+'</b><br>'+
                        'Carrera: &nbsp;<strong>'+data[0].carrera.trim()+'</strong><br>'+
                        'Turno: &nbsp;<strong>'+data[0].turno.trim()+'</strong></p>';
				$('#gNombreAceptado').append(cadena);
				$('#xDivAceptado').show();
				$('#xDivBtnDoc').show();
				//alert(data[0].encuestado);
				if(data[0].encuestado == 0)
				{

				  btnString = '<a class="btn btn-primary" onclick="Encuesta()"><span class="glyphicon glyphicon-folder-open"></span>&nbsp;&nbsp;Referencia</a>';
				  btnString = '<a class="btn btn-primary" onclick="referencia()"><span class="glyphicon glyphicon-folder-open"></span>&nbsp;&nbsp;Referencia</a>';
				  $('#gReferencia').append(btnString);
				  $('#gReferencia').show();
				  
				  //$('#gEncuesta').load('proceso_admision/proceso_encuesta_interesado.jsp',{xEncuesta:81,xPersona:data[0].cve_interesado});
				}
				else
				{
				  btnString = '<a class="btn btn-primary" onclick="referencia()"><span class="glyphicon glyphicon-folder-open"></span>&nbsp;&nbsp;Referencia</a>';
				  $('#gReferencia').append(btnString);
				  $('#gReferencia').show();
				  
				}
				
				
				
				
			}
			if(data[0].estatus === "RECHAZADO")
			{
				cadena = '<p><strong>DATOS GENERALES</strong><br>'+
                        'Folio de Admisión: &nbsp;<strong>'+data[0].folio+'</strong><br>'+
                        'Nombre: &nbsp;<b>'+data[0].aspirante.trim()+'</b><br>'+
                        'Carrera: &nbsp;<strong>'+data[0].carrera.trim()+'</strong><br>'+
                        'Turno: &nbsp;<strong>'+data[0].turno.trim()+'</strong></p>';
				$('#gNombreRechazado').append(cadena);
				$('#xDivRechazado').show();
				
			}
			if(data[0].estatus === "RECHAZADOS")
			{
				cadena = '<p><strong>DATOS GENERALES</strong><br>'+
                        'Folio de Admisión: &nbsp;<strong>'+data[0].folio+'</strong><br>'+
                        'Nombre: &nbsp;<b>'+data[0].aspirante.trim()+'</b><br>'+
                        'Carrera: &nbsp;<strong>'+data[0].carrera.trim()+'</strong><br>'+
                        'Turno: &nbsp;<strong>'+data[0].turno.trim()+'</strong></p>';
				$('#gNombreRechazado').append(cadena);
				$('#xDivRechazado').show();
				
			}
			if(data[0].estatus === "LISTA" || data[0].estatus === "EN LISTA DE ESPERA ")
			{
				cadena = '<p><strong>DATOS GENERALES</strong><br>'+
                        'Folio de Admisión: &nbsp;<strong>'+data[0].folio+'</strong><br>'+
                        'Nombre: &nbsp;<b>'+data[0].aspirante.trim()+'</b><br>'+
                        'Carrera: &nbsp;<strong>'+data[0].carrera.trim()+'</strong><br>'+
                        'Turno: &nbsp;<strong>'+data[0].turno.trim()+'</strong></p>';
				$('#gNombreLista').append(cadena);
				$('#xDivListaEspera').show();
				
			}
			}
			else
			{
				swal({
                title: 'Información!',
                text: 'No existe información, con el folio proporcionado',
                type: 'info',
                confirmButtonText: 'Aceptar'
             	 });
			}
			
        },error:function(){
            /*swal({
                title: 'Error!',
                text: 'Hubo un error, intentar más tarde',
                type: 'error',
                confirmButtonText: 'Aceptar'
              });
			  */
        }
    });
	
	
	
}


function Encuesta()
{
	$('#xDivAceptado').hide();
	$('#xDivBtnDoc').hide();
	$('#gEncuesta').load('proceso_admision/proceso_encuesta_interesado.jsp',{xEncuesta:84,xPersona:objProcesoResultadoAspirante.cve_interesado});
	
}



function referencia()
{	$('#xDivAceptado').hide();
	$('#xDivBtnDoc').hide();
	$('#gEncuesta').empty();
	$('#gEncuesta').load('catalogo_referencia_pago_nuevo_ingreso.jsp',{xMatricula:$('#xTxtFolio').val(),xTurno:objProcesoResultadoAspirante.turno,xMonto:objProcesoResultadoAspirante.monto,xFechaLimite:objProcesoResultadoAspirante.fechaLimite,xFechaInscripcion:objProcesoResultadoAspirante.fechaInscripcion});
	
}


$(document).ready(function(){
    objProcesoResultadoAspirante=new CatalogoResultadoAspirante();
	 $("#xBtnBuscar").click(function(event){
        event.preventDefault();
        
        objProcesoResultadoAspirante.fnBuscar();
        
    });
  
});
