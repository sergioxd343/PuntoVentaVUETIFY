
function CatalogoResultadoAspirante(){

	this.cve_interesado = 0;
	this.monto = 0;
	this.fechaInscripcion = "";
	this.fechaLimite = "";
	this.turno = "";

   this.crt = "controlador/Controlador_catalogo_resultado_aspirante.jsp";
    this.ctrGto = "../../controlador/referencias/ControladorGenerarReferenciaGTO_new.jsp";
	 this.xBtnReferenciaGto = $('.xBtnReferenciaGto');

   this.post = null;

}

CatalogoResultadoAspirante.prototype.fnReferenciaGto = function (btn, pestana) {
	$.ajax({
		type: "POST",
		dataType: "json",
		url: objProcesoResultadoAspirante.ctrGto,
		data: {
			'accion': 3,
			'folio': $("#xTxtFolio").val(),
			'cve_unidad_academica':1,
			'boton': btn.id
			},
		beforeSend: function (xhr) {
			mensaje.preloader("../../");
		},
		success: function (data, textStatus, jqXHR) {
			// console.log(data);
				swal.close();

			if (data.msg) {
				pestana.close();
				mensaje.avisoBloqueoC(data.msg);
			} else if (data.err) {
				pestana.close();
				mensaje.errorGuardar();
			} else {
				if (data.msgB) {
					mensaje.avisoBloqueoC(data.msgB);
				}
				if (data && data.pdf) {
					pestana.document.write(data.pdf);
					pestana.document.close();
				} else if (data && data.url) {
					pestana.location.href = data.url;
				} else {
					pestana.close();
					mensaje.errorGuardar();
				}
			}
			console.log(data);
		},
		error: function (jqXHR, textStatus, errorThrown) {
			pestana.close();
			mensaje.errorGuardar();
		}
	});
};


CatalogoResultadoAspirante.prototype.fnBuscar = function()
{
	var o = this;
	var cadena = '';
	var btnString = '';

	if($('#xTxtFolio').val().trim() == "")
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
        data:{yAccion:1,folio:$('#xTxtFolio').val().trim()},
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
				$('#gNombreAceptado').empty();
				$('#gNombreAceptado').append(cadena);
				
				cadena ="";
				$('#xDivAceptado').show();
				$('#xDivBtnDoc').show();
				//alert(data[0].encuestado);
				if(data[0].encuestado == 0 &&  1==0)
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

					btnString = '';

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
			if(data[0].estatus === "LISTA")
			{
				cadena = '<p><strong>DATOS GENERALES</strong><br>'+
                        'Folio de Admisión: &nbsp;<strong>'+data[0].folio+'</strong><br>'+
                        'Nombre: &nbsp;<b>'+data[0].aspirante.trim()+'</b><br>'+
                        'Carrera: &nbsp;<strong>'+data[0].carrera.trim()+'</strong><br>'+
                        'Turno: &nbsp;<strong>'+data[0].turno.trim()+'</strong></p>';
				$('#gNombreLista').append(cadena);
				$('#xDivListaEspera').show();

			}
			if(data[0].estatus === "EN LISTA DE ESPERA " || data[0].estatus === "LISTA DE ESPERA")
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
	$('#gEncuesta').load('../referencias/proceso_generar_referencia_ingreso.jsp',{xMatricula:$('#xTxtFolio').val().trim(),xTurno:objProcesoResultadoAspirante.turno,xMonto:objProcesoResultadoAspirante.monto,xFechaLimite:objProcesoResultadoAspirante.fechaLimite,xFechaInscripcion:objProcesoResultadoAspirante.fechaInscripcion,xTurnoImpresion:objProcesoResultadoAspirante.turno});
	//$('#gEncuesta').load('catalogo_referencia_pago_nuevo_ingreso.jsp',{xMatricula:$('#xTxtFolio').val().trim(),xTurno:objProcesoResultadoAspirante.turno,xMonto:objProcesoResultadoAspirante.monto,xFechaLimite:objProcesoResultadoAspirante.fechaLimite,xFechaInscripcion:objProcesoResultadoAspirante.fechaInscripcion});

}


$(document).ready(function(){
    objProcesoResultadoAspirante=new CatalogoResultadoAspirante();
	 $("#xBtnBuscar").click(function(event){
        event.preventDefault();

        objProcesoResultadoAspirante.fnBuscar();

    });
	
	objProcesoResultadoAspirante.xBtnReferenciaGto.on('click', function (e) {
        e.preventDefault();
		let btn = this;
					swal({
                            title: 'Aviso!',
                            text: '<b style="color: red;">Nota:<b> La referencia puede tardar algo de tiempo en visualizarse, ya que ésta es generada desde el sistema de GTO, en caso de mostrar algún mensaje de error favor de intentar al menos un par de veces antes de solicitar apoyo.',
                            type: 'info'
                        }).then(
                                function () {
                                    let pestana = window.open('', '');
									pestana.document.write("<center><h1 style=\"margin-top: 5%; font-family: Arial, Helvetica, sans-serif;\">Generando referencia, espere un momento...</h1></center>");
									objProcesoResultadoAspirante.fnReferenciaGto(btn, pestana);
                                },
                                function (dismiss) {

                                }
                        );
    });

});
