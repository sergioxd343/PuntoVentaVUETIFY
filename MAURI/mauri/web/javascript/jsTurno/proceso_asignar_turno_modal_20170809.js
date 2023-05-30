function RegistrarCita(){

   this.ctr = "controlador/controlCita.jsp";
   this.configuracion = null;
   //this.fnCargarDatos();
}


RegistrarCita.prototype.fnCargarDatos = function()
{
    var o = this;
	
    o.post=$.post(this.ctr,{
        accion:1,
    })
    o.post.done(function(data){
			//data = JSON.parse(data);
			console.log(data);
			$('#xNombreAlumno').text(data);
                        
			o.fnConfiguracion();
    })
    o.post.fail(function(error){
		
    });
    //fin
    
    
      
}

RegistrarCita.prototype.fnConfiguracion = function ()
{
	var o = this;
	 o.post=$.post(this.ctr,{
        accion:2,proceso:$("#xProcesoEscolares").find('option:selected').val()
    })
    o.post.done(function(data){
			data = JSON.parse(data);
			o.configuracion = data;
			
			//o.fnHorarios();
			
			
    })
    o.post.fail(function(error){
		
    });
}

function Guardar()
{
	objRegistrarCita.fnGuardar();
}

RegistrarCita.prototype.fnGuardar = function ()
{
	var o = this;
	swal({
		showConfirmButton: false,
        allowOutsideClick: false,
        imageUrl: "../../images/Logo_utl_animado.gif"
    });
	 o.post=$.post(this.ctr,{
        accion:4,
		horario:$('#xHorario').val(),
		proceso:$('#xProcesoEscolares').val(),
		fecha_seleccionada:$('#yFechaSeleccionada').val()
    })
    o.post.done(function(data){
		console.log(data);
		if(data.trim() != "existe" && data.trim() != "" && data.trim() != "sin persona para el horario")
		{
		swal({
		  allowOutsideClick: false,
		  title: 'Guardado',
		  text: "Se ha guardado tu cita, te atendera : <b>"+data.trim()+"<b>",
		  type: 'success',
		  confirmButtonText: 'Aceptar'
		}).then(function () {
			 $('#myModal').modal('hide');
		})
		}
		else if(data.trim() == "existe")
		{
			swal({
		  allowOutsideClick: false,
		  title: 'Informacion',
		  text: "Ya cuentas con una cita para el horario seleccionado",
		  type: 'warning',
		  confirmButtonText: 'Aceptar'
		}).then(function () {
			 $('#myModal').modal('hide');
		})
		}
		else if(data.trim() == "sin persona para el horario")
		{
			swal({
		  allowOutsideClick: false,
		  title: 'Informacion',
		  text: "No se cuenta con empleado para atender en el horario seleccionado",
		  type: 'warning',
		  confirmButtonText: 'Aceptar'
		}).then(function () {
			 $('#myModal').modal('hide');
		})
		}
		
    })
    o.post.fail(function(error){
		
    });
}

RegistrarCita.prototype.fnHorarios = function ()
{
	var o = this;
	var cadena =''; 
	cadena+='<Select class="form-control" id="xHorario">';
	cadena+='<option value="">Selecciona</option>';
	$('#xHorarios').empty();
	
	console.log(cadena)
	
	
	o.post=$.post(this.ctr,{
        accion:3,
		fecha_seleccionada:$('#yFechaSeleccionada').val(),
		rango_hora_atencion:o.configuracion.aaData[0].rango_hora_atencion,
		hora_inicio_atencion:o.configuracion.aaData[0].hora_inicio_atencion,
		hora_termino_atencion:o.configuracion.aaData[0].hora_termino_atencion,
                proceso:$("#xProcesoEscolares").find('option:selected').val()
    })
    o.post.done(function(data){
			data = JSON.parse(data);
			//console.log(o.configuracion.aaData[0].citas_horas);
			for(var h = 0; h < data.aaData.length; h++)
			{
				cadena+='<option value="'+data.aaData[h].hora+'">'+data.aaData[h].hora+' - '+data.aaData[h].hora_fin+'</option>'
			}
			cadena+='</select>';
			
			console.log(cadena);
			$('#xHorarios').append(cadena);
			
    })
    o.post.fail(function(error){
		
    });
	
}

$(document).ready(function(){
 $(function(){
    $(document).bind("contextmenu",function(e){
        return false;
    });
});

 $(function(){
    $(document).on("cut copy paste","#txtInput",function(e) {
        e.preventDefault();
    });
});
    objRegistrarCita=new RegistrarCita();
	
	//alert("Hello");
	
		/*swal({
		allowOutsideClick: false,
		title: 'Guardado',
		text: 'Alerta',
		type: 'success',
		showConfirmButton: false,
		timer: 3000
		})
	*/		
	
})

$(document).ajaxStart(function() {
   
});

// evento ajax stop
$(document).ajaxStop(function() {
   
});
