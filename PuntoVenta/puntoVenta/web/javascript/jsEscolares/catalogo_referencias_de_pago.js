var table;
var yAccion=0
function proceso_referencia_de_pago(){

   this.crt = "controlador/Controlador_catalogo_referencias_de_pago.jsp";
   //this.fnTabla();
   this.table = null;
   this.id=0;
   this.Nombre = $('#xNombre');
   this.activo=0;
   this.Cve_cita_persona_atencion=0;
   
   this.CveEmpleado='';
 
   this.post = null;
   this.fnUnidadAcademica();
   this.fnTipoReferencia();
   this.fnAnticipo();
   this.fnTipoPersona();
  //this.fnMaterias();
  // this.fnGuardar();
  // this.fnModificar();
  // this.fnCargarRegistro();
}

proceso_referencia_de_pago.prototype.fnBuscarAlumno=function(){
	$('#myModalAlumnos').modal();
	$('#myModalAlumnos .modal-body').empty();
	//$('#myModalEmpresa').removeAttr('style');
	$('#myModalAlumnos .modal-body').load('muestra_alumnoB.jsp');
}

function CargarMaterias()
{
	if($('#xTxtMatricula').val().length != 8)
	{
		swal({
		title: 'Información',
		type: 'info',
		text: 'Debe capturar una matricula',
		allowOutsideClick: false
		});
	}
	var o = objProcesoReferencia;
	o.fnMaterias();
}

function Buscar()
{
	var o = objProcesoReferencia;
	var cadena = '';
	
	if($('#xCve_empleado').val() == "")
	{
	swal({
		allowOutsideClick: false,
		title: 'Información!',
		text: 'Debe proporcionar el numero de empleado',
		type: 'info',
		confirmButtonText: 'Aceptar'
		}).then(function(){
           $('#xCve_empleado').focus();
        });
	return;
	}
	if($('#xCve_empleado').val().length < 7)
	{
		swal({
		allowOutsideClick: false,
		title: 'Información!',
		text: 'Debe proporcionar un numero de empleado valido',
		type: 'info',
		confirmButtonText: 'Aceptar'
		}).then(function(){
           $('#xCve_empleado').focus();
        });
	return;
	}
	
	$.ajax({
        type:"POST" ,
        dataType:"json",
        url:o.crt,
        data:{yAccion:4,Cve_empleado:$('#xCve_empleado').val()},
        beforeSend:function(){
 
        },success:function(data){
			
			
			
			
			if(data.aaData.length > 0)
			{
				o.CveEmpleado = $('#xCve_empleado').val();
				$('#gEmpleado').empty();
				cadena+='<label>'+data.aaData[0].empleado+'</label>&nbsp;'+
						'<button type="button" id="xCancelarBusqueda" name="xCancelarBusqueda" onclick="Cancelar()" class="btn btn-danger">'+
						'	<span class="glyphicon glyphicon-ban-circle"></span>'+
						'</button>&nbsp;';
				$('#gEmpleado').append(cadena);
			}
			else
			{
				swal({
				allowOutsideClick: false,
				title: 'Información!',
				text: 'No existe información con el numero de empleado proporcionado',
				type: 'info',
				confirmButtonText: 'Aceptar'
				}).then(function(){
				$('#xCve_empleado').val("");
				$('#xCve_empleado').focus();
				});
				return;
			}
			
            /*swal({
                title: data.title,
                text: data.text,
                type: data.type,
                confirmButtonText: data.confirmButtonText
              }).then(function(){
                  $('#tableProcesos').DataTable().ajax.reload();
                  
              });*/
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

function Cancelar()
{
	var cadena = '<input type="text" class="form-control" id="xCve_empleado" name="xCve_empleado" placeholder="Numero Empleado" size="10" maxlength="7" onkeypress="return Numeros(event)">'+
				'	<span class="input-group-btn">'+
				'	<button class="btn btn-default" type="button" onclick="Buscar()">Buscar</button>'+
				'	</span>';
	$('#gEmpleado').empty();
	
	$('#gEmpleado').append(cadena);
	
}

function CambioEstatus(id,activo)
{

  $.ajax({
        type:"POST" ,
        dataType:"json",
        url:"controlador/Controlador_catalogo_persona_citas_escolares.jsp",
        data:{yAccion:3,yId:id,yActivo:activo},
        beforeSend:function(){
 
        },success:function(data){
            swal({
                title: data.title,
                text: data.text,
                type: data.type,
                confirmButtonText: data.confirmButtonText
              }).then(function(){
                  $('#tableProcesos').DataTable().ajax.reload();
                  
              });
        },error:function(){
            swal({
                title: 'Error!',
                text: 'Hubo un error, intentar más tarde',
                type: 'error',
                confirmButtonText: 'Aceptar'
              });
        }
    });
    
} 
function cargar(id,nombre,cveEmpleado){
	var o = objProcesoReferencia;
	var cadena = '';
	
	o.Cve_cita_persona_atencion = id;
	
    $("#xGuardar").data("id",id);
	$('#xHoraInicio').val('00:00');
	$('#xHoraFin').val('00:00');
	o.CveEmpleado = $('#xCve_empleado').val();
	$('#gEmpleado').empty();
	cadena+='<label>'+nombre+'</label>&nbsp;';
	$('#gEmpleado').append(cadena);
	$('#xGuardar').hide();
	$('#xActualizar').show();
}


proceso_referencia_de_pago.prototype.fnGenerar = function()
{	
	if($('#xListTipoPersona').val() == 0)
	{
		swal({
				allowOutsideClick: false,
				title: 'Información!',
				text: 'Debe seleccionar el tipo de persona',
				type: 'info',
				confirmButtonText: 'Aceptar'
				}).then(function(){
				});
				return;
	}
	else if($('#ListTipoPago').val() == 0)
	{
		swal({
				allowOutsideClick: false,
				title: 'Información!',
				text: 'Debe seleccionar tipo pago',
				type: 'info',
				confirmButtonText: 'Aceptar'
				}).then(function(){
				});
				return;
	}
	else if($('#xTxtMatricula').val().length == 0)
	{
		swal({
				allowOutsideClick: false,
				title: 'Información!',
				text: 'Debe proporcionar la matricula o folio',
				type: 'info',
				confirmButtonText: 'Aceptar'
				}).then(function(){
				});
				return;
	}
	else if($('#calendarFecha').val() == "")
	{
		swal({
				allowOutsideClick: false,
				title: 'Información!',
				text: 'Debe seleccionar la fecha',
				type: 'info',
				confirmButtonText: 'Aceptar'
				}).then(function(){
				});
				return;
	}
	else if($('#xTxtMonto').val() == "")
	{
		swal({
				allowOutsideClick: false,
				title: 'Información!',
				text: 'Debe proporcionar el monto',
				type: 'info',
				confirmButtonText: 'Aceptar'
				}).then(function(){
				});
				return;
	}
	else
	{
	$('#gPanelPrincipal').hide();
	if($('#ListTipoPago').val() == 4 || $('#ListTipoPago').val() == 5)
	{
	$('#xDivContenido').load("catalogo_referencia_pago_general_83000.jsp", {xMatricula:$('#xTxtMatricula').val(), xMonto:$('#xTxtMonto').val() + '.00', xFechaLimite:$('#calendarFecha').val(), xCve_concepto:$('#ListTipoPago').val(), xConcepto:$('#ListTipoPago option:selected').text(),xTipoPersona:$('#xListTipoPersona').val(),xMateria:$('#ListMateria').val(),xNombreMateria:$('#ListMateria option:selected').text()});
	}
	else
	{
	$('#xDivContenido').load("catalogo_referencia_pago_general_83000.jsp", {xMatricula:$('#xTxtMatricula').val(), xMonto:$('#xTxtMonto').val() + '.00', xFechaLimite:$('#calendarFecha').val(), xCve_concepto:$('#ListTipoPago').val(), xConcepto:$('#ListTipoPago option:selected').text(),xTipoPersona:$('#xListTipoPersona').val()});
	}
	$(".modal-fullscreen").on('show.bs.modal', function () {
	setTimeout( function() {
	$(".modal-backdrop").addClass("modal-backdrop-fullscreen");
	}, 0);
	});
	$('#myModalAlumnos').modal("show");
	}
}

function Cerrar()
{
	$('#myModalAlumnos').modal("hide");
	$('#gPanelPrincipal').show();
}

proceso_referencia_de_pago.prototype.fnTipoPersona = function()
{
	var o = this;
	$('#xListTipoPersona').change(function (){
		$('#gBtnBuscarAlumno').hide();
		if($('#xListTipoPersona').val() == 1)
		{
			$('#gBtnBuscarAlumno').show();
		}
	});
		
}

proceso_referencia_de_pago.prototype.fnAnticipo = function()
{
	$('#ListTipoPago').change(function (){
		
		$('#btnMaterias').hide();
		$('#xTxtMonto').val("");
		$('#xTxtMonto').attr("readonly", false);
		$('#gMateria').hide();
		
		if($('#ListTipoPago').val() == 9)
		{
			$('#xTxtMonto').val("410");
			$('#xTxtMonto').attr("readonly", true);
		}
		else if($('#ListTipoPago').val() == 1)
		{
			$('#xTxtMonto').val("390");
			$('#xTxtMonto').attr("readonly", true);
		}
		else if($('#ListTipoPago').val() == 4 || $('#ListTipoPago').val() == 5)
		{
			$('#btnMaterias').show();
		}
		else{
			$('#xTxtMonto').val("");
			$('#xTxtMonto').attr("readonly", false);
		}
		
		
		});
}

proceso_referencia_de_pago.prototype.fnUnidadAcademica = function()
{
var o = this;

 $.ajax({
        type:"POST" ,
        dataType:"json",
        url:"controlador/Controlador_catalogo_referencias_de_pago.jsp",
        data:{ yAccion: 1},
        beforeSend:function(){
 
        },success:function(data){
        $('#xListUnidadAcademica').empty();
		$('#xListUnidadAcademica').append('<option>-</option>');
		$(data).each( function(i, data) {
			$('#xListUnidadAcademica').append('<option value="'+data.cve_unidad_academica+'">'+data.nombre+'</option>');
		}); 
        },error:function(){
            swal({
                title: 'Error!',
                text: 'Hubo un error, intentar más tarde',
                type: 'error',
                confirmButtonText: 'Aceptar'
              });
        }
    });
	
}

proceso_referencia_de_pago.prototype.fnMaterias = function()
{
var o = this;
swal({
        //title: "Cargando...",
        /*text: '<div class="progress">'+
              '  <div class="indeterminate"></div>'+
               ' </div>',*/
        imageUrl: "../../images/Logo_utl_animado.gif",
        imageSize: '50X50', // add your dynamic height and width here
       // showCancelButton: true,
        /*cancelButtonText: "No",
        confirmButtonColor: "#ff0000",
        confirmButtonText: "Yes, I'am Over 18",*/
        showConfirmButton: false
    });
 $.ajax({
        type:"POST" ,
        dataType:"json",
        url:"controlador/Controlador_catalogo_referencias_de_pago.jsp",
        data:{ yAccion: 3,xMatricula:$('#xTxtMatricula').val()},
        beforeSend:function(){
 
        },success:function(data){
		swal.close();
		if(data.length > 0)
		{
        $('#ListMateria').empty();
		$('#ListMateria').append('<option>-</option>');
		$(data).each( function(i, data) {
			$('#ListMateria').append('<option value="'+data.cve_materia+'">'+data.materia+'</option>');
			$('#gMateria').show();
		});
		}
		else
		{
			swal({
                title: 'Información!',
                text: 'No existen materias reporbadas en el periodo activo',
                type: 'info',
                confirmButtonText: 'Aceptar'
              });
		}
        },error:function(){
            swal({
                title: 'Error!',
                text: 'Hubo un error, intentar más tarde',
                type: 'error',
                confirmButtonText: 'Aceptar'
              });
        }
		
    });
	
}


proceso_referencia_de_pago.prototype.fnTipoReferencia = function()
{
var o = this;

 $.ajax({
        type:"POST" ,
        dataType:"json",
        url:"controlador/Controlador_catalogo_referencias_de_pago.jsp",
        data:{ yAccion: 6},
        beforeSend:function(){
 
        },success:function(data){
        $('#ListTipoPago').empty();
		$('#ListTipoPago').append('<option value="0">-</option>');
		$(data).each( function(i, data) {
			$('#ListTipoPago').append('<option value="'+data.cve_concepto+'">'+data.nombre+'</option>');
		}); 
        },error:function(){
            swal({
                title: 'Error!',
                text: 'Hubo un error, intentar más tarde',
                type: 'error',
                confirmButtonText: 'Aceptar'
              });
        }
    });
	
}




proceso_referencia_de_pago.prototype.fnCancelar=function(){
    $('#forma')[0].reset();
	
	var cadena = '<input type="text" class="form-control" id="xCve_empleado" name="xCve_empleado" placeholder="Numero Empleado" size="10" maxlength="7" onkeypress="return Numeros(event)">'+
				'	<span class="input-group-btn">'+
				'	<button class="btn btn-default" type="button" onclick="Buscar()">Buscar</button>'+
				'	</span>';
	$('#gEmpleado').empty();
	
	$('#gEmpleado').append(cadena);
	
}

function Actualizar()
{
	var o = objProcesoReferencia;
	
	var sabado = false;
	
	if($('#xTipoHorario').is(':checked'))
	{
		sabado = true;
	}
	
	if($('#xHoraInicio').val() == '00:00')
	{
		swal({
                title: 'Información!',
                text: 'Debe seleccionar la hora inicio del empleado',
                type: 'info',
                confirmButtonText: 'Aceptar'
              });
		return;
	}
	
	if($('#xHoraFin').val() == '00:00')
	{
		swal({
                title: 'Información!',
                text: 'Debe seleccionar la hora fin del empleado',
                type: 'info',
                confirmButtonText: 'Aceptar'
              });
		return;
	}
    
  $.ajax({
        type:"POST" ,
        dataType:"json",
        url:"controlador/Controlador_catalogo_persona_citas_escolares.jsp",
        data:{ yAccion: 2,yId:o.Cve_cita_persona_atencion,Hora_inicio:$("#xHoraInicio").val(), Hora_fin:$("#xHoraFin").val(), ySabado:sabado },
        beforeSend:function(){
 
        },success:function(data){
            swal({
                title: data.title,
                text: data.text,
                type: data.type,
                confirmButtonText: data.confirmButtonText
              }).then(function(){
                  $('#tableProcesos').DataTable().ajax.reload();
                  $("#xGuardar").data("id",0);
                  objProcesoReferencia.fnCancelar();
              });
              
              
        },error:function(){
            swal({
                title: 'Error!',
                text: 'Hubo un error, intentar más tarde',
                type: 'error',
                confirmButtonText: 'Aceptar'
              });
        }
    });
    
} 

proceso_referencia_de_pago.prototype.fnGuardar=function()
{
	var o = this;
	
	var sabado = false;
	
	if($('#xTipoHorario').is(':checked'))
	{
		sabado = true;
	}
	
	if(o.CveEmpleado == '')
	{
		swal({
                title: 'Información!',
                text: 'Debe buscar un empleado',
                type: 'info',
                confirmButtonText: 'Aceptar'
              });
		return;
	}
	
	if($('#xHoraInicio').val() == '00:00')
	{
		swal({
                title: 'Información!',
                text: 'Debe seleccionar la hora inicio del empleado',
                type: 'info',
                confirmButtonText: 'Aceptar'
              });
		return;
	}
	
	if($('#xHoraFin').val() == '00:00')
	{
		swal({
                title: 'Información!',
                text: 'Debe seleccionar la hora fin del empleado',
                type: 'info',
                confirmButtonText: 'Aceptar'
              });
		return;
	}
    
  $.ajax({
        type:"POST" ,
        dataType:"json",
        url:"controlador/Controlador_catalogo_persona_citas_escolares.jsp",
        data:{ yAccion: 1,Cve_empleado:o.CveEmpleado,Hora_inicio:$("#xHoraInicio").val(), Hora_fin:$("#xHoraFin").val(), ySabado:sabado },
        beforeSend:function(){
 
        },success:function(data){
            swal({
                title: data.title,
                text: data.text,
                type: data.type,
                confirmButtonText: data.confirmButtonText
              }).then(function(){
                  $('#tableProcesos').DataTable().ajax.reload();
                  $("#xGuardar").data("id",0);
                  objProcesoReferencia.fnCancelar();
              });
              
              
        },error:function(){
            swal({
                title: 'Error!',
                text: 'Hubo un error, intentar más tarde',
                type: 'error',
                confirmButtonText: 'Aceptar'
              });
        }
    });
    
} 

proceso_referencia_de_pago.prototype.fnTabla=function()
{
  var o = this;
  table =  $('#tableProcesos').DataTable({
    
    "language": {
                "url": "//cdn.datatables.net/plug-ins/1.10.11/i18n/Spanish.json"
                },
     "ajax": o.crt+"?yAccion=5",
     "aoColumns": [
        { "mData": "cve_cita_persona_atencion", },
        { "mData": "empleado"},
		{ "mData": null,
          "bDestroy": true,
          "bSortable": false,
          "className":"text-center",
          "mRender": function(data, type, row) {  
		  if(row.sabado==true){
                    return 'Sabado';
                }else{
                    return 'Lunes - Viernes';
                }
			}
		},
		{ "mData": "hora_inicio"},
		{ "mData": "hora_termino"},
        { "mData": null,
          "bDestroy": true,
          "bSortable": false,
          "className":"text-center",
          "mRender": function(data, type, row) {
              if(row.activo==true){
                    return '<button class="btn btn-success btn-sm" onclick="CambioEstatus('+row.cve_cita_persona_atencion+',0)" ><span class="glyphicon glyphicon-ok-circle"></span>' + '' + '</button>';
                }else{
                    return '<button class="btn btn-danger btn-sm" onclick="CambioEstatus('+row.cve_cita_persona_atencion+',1)" ><span class="glyphicon glyphicon-ban-circle"></span>' + '' + '</button>';
                }
        }
    },
        { "mData": null,
          "bSortable": false,
          "className":"text-center",
          "mRender": function(data, type, row) {
              
              return '<button class="btn btn-info btn-sm" onclick="cargar('+row.cve_cita_persona_atencion+',\''+row.empleado+'\','+row.cve_empleado+')"><span class="glyphicon glyphicon-pencil"></span>' + '' + '</button>';
        }
    }]
   });
   
}





$(document).ready(function(){
    objProcesoReferencia=new proceso_referencia_de_pago();
    
	$.fn.datepicker.dates['en'] = {
    days: ["Domingo", "Lunes", "Martes", "Miercoles", "Jueves", "Vierdes", "Sabado"],
    daysShort: ["Dom", "Lun", "Mar", "Mie", "Jue", "Vie", "Sab"],
    daysMin: ["Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sa"],
    months: ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"],
    monthsShort: ["Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"],
    today: "Hoy",
    clear: "Limpiar",
    format: "dd/mm/yyyy",
    titleFormat: "MM yyyy", /* Leverages same syntax as 'format' */
    weekStart: 0
	};
	
	$('#calendarFecha').datepicker({todayBtn:true, autoclose:true});
    
	
	
	
    
    $("#xGuardar").click(function(event){
        event.preventDefault();
        
        objProcesoReferencia.fnGuardar();
        
    });
	
	
	 $("#xBtnGenerar").click(function(event){
        event.preventDefault();
        
        objProcesoReferencia.fnGenerar();
        
    });
	
	$("#xBtnBuscar").click(function(event){
        event.preventDefault();
        
        objProcesoReferencia.fnBuscarAlumno();
        
    });
    
    $('#xCancelar').click(function(event){
        event.preventDefault();
        objProcesoReferencia.fnCancelar();
  });
  
   $('.clockpicker').clockpicker();
    
   $('#xTipoHorario').bootstrapToggle({
      on: 'Lunes - Viernes',
      off: 'Sabado'
    });
	$('[data-toggle="tooltip"]').tooltip();
});
