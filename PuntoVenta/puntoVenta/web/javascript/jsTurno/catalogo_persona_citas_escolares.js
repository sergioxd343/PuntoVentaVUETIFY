var table;
var yAccion=0
function proceso_asignar_turno(){

   this.crt = "controlador/Controlador_catalogo_persona_citas_escolares.jsp";
   this.fnTabla();
   this.table = null;
   this.id=0;
   this.Nombre = $('#xNombre');
   this.activo=0;
   this.Cve_cita_persona_atencion=0;
   
   this.CveEmpleado='';
 
   this.post = null;

  // this.fnGuardar();
  // this.fnModificar();
  // this.fnCargarRegistro();
}

function Buscar()
{
	var o = objProcesoAsignar;
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
            Loading();
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
                                Ready();
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
            Loading();
        },success:function(data){
            swal({
                title: data.title,
                text: data.text,
                type: data.type,
                confirmButtonText: data.confirmButtonText
              }).then(function(){
                  $('#tableProcesos').DataTable().ajax.reload(null,false);
                  
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
function cargar(id,nombre,cveEmpleado,inicio,fin,comida,dia){
	var o = objProcesoAsignar;
	var cadena = '';
	window.scrollTo(0, 0);
	o.Cve_cita_persona_atencion = id;
	
    $("#xGuardar").data("id",id);
	$('#xHoraInicio').val(inicio);
	$('#xHoraFin').val(fin);
        $('#xHoraComida').val(comida);
	o.CveEmpleado = $('#xCve_empleado').val();
	$('#gEmpleado').empty();
	cadena+='<label>'+nombre+'</label>&nbsp;';
	$('#gEmpleado').append(cadena);
        
        $("#xDiaLaboral").val(dia);
        
	$('#xGuardar').hide();
	$('#xActualizar').show();
}


proceso_asignar_turno.prototype.fnCancelar=function(){
    $('#forma')[0].reset();
	$('#xGuardar').show();
                    $('#xActualizar').hide();
	var cadena = '<input type="text" class="form-control" id="xCve_empleado" name="xCve_empleado" placeholder="Numero Empleado" size="10" maxlength="7" onkeypress="return Numeros(event)">'+
				'	<span class="input-group-btn">'+
				'	<button class="btn btn-default" type="button" onclick="Buscar()">Buscar</button>'+
				'	</span>';
	$('#gEmpleado').empty();
	
	$('#gEmpleado').append(cadena);
	
}

function Actualizar()
{
	var o = objProcesoAsignar;
	
	var sabado = false;
	
	if(!$('#xTipoHorario').is(':checked'))
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
	
	if($('#xHoraFin').val() == '00:00' || parseInt($('#xHoraFin').val().replace(':',''))<parseInt($('#xHoraInicio').val().replace(':','')))
	{
		swal({
                title: 'Información!',
                text: 'Debe seleccionar la hora fin del empleado',
                type: 'info',
                confirmButtonText: 'Aceptar'
              });
		return;
	}
        if($('#xHoraComida').val() == '00:00' || parseInt($('#xHoraFin').val().replace(':',''))<parseInt($('#xHoraComida').val().replace(':','')) || parseInt($('#xHoraComida').val().replace(':',''))<parseInt($('#xHoraInicio').val().replace(':','')))
	{
		swal({
                title: 'Información!',
                text: 'Debe seleccionar la hora de comida del empleado',
                type: 'info',
                confirmButtonText: 'Aceptar'
              });
		return;
	}
    
    var data = $('#forma').serializeArray();
        data.push({name:'yAccion',value:2});
        data.push({name:'yId',value:o.Cve_cita_persona_atencion});
  $.ajax({
        type:"POST" ,
        dataType:"json",
        url:"controlador/Controlador_catalogo_persona_citas_escolares.jsp",
        data:$.param(data),
        beforeSend:function(){
            Loading();
        },success:function(data){
            swal({
                title: data.title,
                text: data.text,
                type: data.type,
                confirmButtonText: data.confirmButtonText
              }).then(function(){
                  $('#tableProcesos').DataTable().ajax.reload(null,false);
                  $("#xGuardar").data("id",0);
                  objProcesoAsignar.fnCancelar();
                  $('#xGuardar').show();
                    $('#xActualizar').hide();
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

proceso_asignar_turno.prototype.fnGuardar=function()
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
	
	if($('#xHoraFin').val() == '00:00' || parseInt($('#xHoraFin').val().replace(':',''))<parseInt($('#xHoraInicio').val().replace(':','')))
	{
		swal({
                title: 'Información!',
                text: 'Debe seleccionar la hora fin del empleado',
                type: 'info',
                confirmButtonText: 'Aceptar'
              });
		return;
	}
        if($('#xHoraComida').val() == '00:00' || parseInt($('#xHoraFin').val().replace(':',''))<parseInt($('#xHoraComida').val().replace(':','')) || parseInt($('#xHoraComida').val().replace(':',''))<parseInt($('#xHoraInicio').val().replace(':','')))
	{
		swal({
                title: 'Información!',
                text: 'Debe seleccionar la hora de comida del empleado',
                type: 'info',
                confirmButtonText: 'Aceptar'
              });
		return;
	}
    var data = $('#forma').serializeArray();
        data.push({name:'yAccion',value:1});
        data.push({name:'Cve_empleado',value:o.CveEmpleado});
  $.ajax({
        type:"POST" ,
        dataType:"json",
        url:"controlador/Controlador_catalogo_persona_citas_escolares.jsp",
        data:$.param(data),
        beforeSend:function(){
            Loading();
        },success:function(data){
            swal({
                title: data.title,
                text: data.text,
                type: data.type,
                confirmButtonText: data.confirmButtonText
              }).then(function(){
                  $('#tableProcesos').DataTable().ajax.reload(null,false);
                  $("#xGuardar").data("id",0);
                  objProcesoAsignar.fnCancelar();
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

proceso_asignar_turno.prototype.fnTabla=function()
{
  var o = this;
  table =  $('#tableProcesos').DataTable({
    
    "language": {
                "url": "//cdn.datatables.net/plug-ins/1.10.11/i18n/Spanish.json"
                },
     "ajax": o.crt+"?yAccion=5",
     "fnCreatedRow": function (row, data, index) {
         $(row).find(".edit").click(function () {
			window.scrollTo(0, 0);
            cargar(data["cve_cita_persona_atencion"],
            data["empleado"],
            data["cveEmpleado"],
            data["hora_inicio"],
            data["hora_termino"],
            data["hora_comida"],
            data["dia"])            
            
        });
     },
     "aoColumns": [
        { "mData": "cve_cita_persona_atencion", },
        { "mData": "empleado"},
        { "mData": null,
          "bDestroy": true,
          "bSortable": false,
          
          "mRender": function(data, type, row) {
                var dias="";
                    switch(parseInt(row.dia)){
                        case 2:
                            dias= 'Lunes';
                            break;
                        case 3:
                            dias= 'Martes';
                            break;
                        case 4:
                            dias= 'Miércoles';
                            break;
                        case 5:
                            dias= 'Jueves';
                            break;
                        case 6:
                            dias= 'Viernes';
                            break;
                        case 7:
                            dias= 'Sábado';
                            break;
                    }
                return dias;
                    }
		},
		{ "mData": "hora_inicio"},
                { "mData": "hora_comida"},
                { "mData": "hora_termino"},
        { "mData": null,
          "bDestroy": true,
          "bSortable": false,
          "className":"text-center",
          "mRender": function(data, type, row) {
              if(row.activo==true){
                    return '<button class="btn btn-success " onclick="CambioEstatus('+row.cve_cita_persona_atencion+',0)" ><span class="fa fa-check-circle"></span>' + '' + '</button>';
                }else{
                    return '<button class="btn btn-danger " onclick="CambioEstatus('+row.cve_cita_persona_atencion+',1)" ><span class="fa fa-ban"></span>' + '' + '</button>';
                }
        }
    },
        { "mData": null,
          "bSortable": false,
          "className":"text-center",
          "mRender": function(data, type, row) {
              if(row.activo==true){
				return '<button class="btn btn-primary btn-sm edit" )"><span class="fa fa-pencil-square"></span>' + '' + '</button>';
			  }else{
				  return '<button class="btn btn-primary btn-sm" disabled="disabled" )"><span class="fa fa-pencil-square"></span>' + '' + '</button>';
			  }
			  
        }
    }]
   });
   
}

//Bloquear pantalla mientras carga datos
function Loading(){		
    swal({
        allowOutsideClick: false,
        imageUrl: "../../images/Logo_utl_animado.gif",
        showCancelButton: false, // There won't be any cancel button
        showConfirmButton: false // There won't be any confirm button
    });
}

//Función para quitar bloqueo de Loading
function Ready(){
    swal.close();
}



$(document).ready(function(){
    objProcesoAsignar=new proceso_asignar_turno();
    
    
    
    $("#xGuardar").click(function(event){
        event.preventDefault();
        
        objProcesoAsignar.fnGuardar();
        
    });
    
    $('#xCancelar').click(function(event){
        event.preventDefault();
        objProcesoAsignar.fnCancelar();
  });
  
   $('.clockpicker').clockpicker();
    
   
});
