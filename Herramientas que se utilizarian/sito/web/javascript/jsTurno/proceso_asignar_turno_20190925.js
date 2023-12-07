/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function(){
    CargarProcesos();
    
});

function calendario_turno(){
    $('#xCalendario').fullCalendar({
        locale: 'es-do',
        editable: false,
        selectable: false,
        eventLimit: true, // allow "more" link when too many events
        timeFormat: 'h(:mm)t',
        hiddenDays: [0],
        allDaySlot: true,
        
            eventColor: '#fff',
        businessHours: {
            
            dow: [ 1, 2, 3, 4, 5,6 ] // dias de semana, 0=Domingo
      },
        eventClick: function(calEvent, jsEvent, view) {
            objRegistrarCita.fnCargarDatos(calEvent.dia);
            var today=new Date();
            var year=today.getFullYear().toString();
            var month=today.getMonth()+1;
            if (month < 10) {
                 year+="0"+month;
            }else{
                year+=month;
            }
            year+=today.getDate().toString();
            
            if(calEvent.color=='green'){
                
                //if(parseInt(calEvent.start.format("YYYYMMDD"))>=parseInt(year)){
                   var editUrl =  "?action=edit_entry&id=" + calEvent.idf;
				   //alert(calEvent.start.format("YYYYMMDD"));
                    
                    $('#yFechaSeleccionada').val(calEvent.start.format("DD/MM/YYYY"));
                    setTimeout(function(){
                        objRegistrarCita.fnHorarios(calEvent.dia);
				   
                        Modal(editUrl, 'Editar sesión', "900", "");
                    },800);
                    
               // }
            }else{
                
				swal({
                title: 'Error!',
                text: 'No disponible',
                type: 'error',
                confirmButtonText: 'Aceptar'
              });
            }
			
			
			
        }, events: function(start, end, timezone, callback) {
        $.ajax({
            url: 'controlador/Controlador_proceso_citas_fecha_atencion.jsp',
            type:"POST" ,
            dataType: 'json',
            data: {
                proceso:parseInt($("#xProcesoEscolares").find('option:selected').val()),
                yAccion:2
            },
			beforeSend:function(){
				Loading();
            },
            success: function(doc) {
                var events = [];
                if(!$.isEmptyObject(doc)){
                    $(doc).each(function (index, o) { 

                        events.push({
                        id: o.id,
                        title: o.title,
                        start: o.start, // will be parsed
                        color: o.color,
                        dia:o.numero_dia
                    });
                    });
                
                }
             /*   $(doc).find('event').each(function() {
                    events.push({
                        title: $(this).attr('title'),
                        start: $(this).attr('start') // will be parsed
                    });
                });*/
                callback(events);
				Ready();
            }
        });
    }
    });
	
    $('#xCalendario').fullCalendar('gotoDate',$("#xProcesoEscolares").find('option:selected').data('fecha'));
}

function Modal(url, title, width, fn){
    $('#myModal').on('show.bs.modal', function (e) {
        $('.modal-body').css({'visibility': 'hidden'});
    });
    $('#myModal').on('shown.bs.modal', function (e) {
        //Ready();
        $('.modal-body').css({'visibility': 'visible'});
    });
    $('#myModal').on('hidden.bs.modal', function (e) {
        if($('.summernote').length > 0) $('.summernote').destroy();
    });
    $('#myModalLabel').text(title);
    $('.modal-dialog').animate({'width': width}, 500);
    
    if($('#myModal').is(':visible')){
        $('.modal-body').html("<i class = 'fa fa-cog fa-spin' style = 'font-size: 20pt'></i>");
     /*   $('.modal-body').load(url, function(){
            if(fn) fn();
        });*/
    }else{
       /*$('.modal-body').load(url, function(){
            if(fn) fn();
            
        });*/
        $('#myModal').modal('show');
    }    
}

function CargarProcesos(){
    Loading();
    $.ajax({
        type:"POST" ,
        dataType:"json",
        url:"controlador/Controlador_proceso_citas_fecha_atencion.jsp",
        data:{yAccion:1},
        beforeSend:function(){
 
        },success:function(data){
            var $select = $('#xProcesoEscolares');
            if(!$.isEmptyObject(data)){
                $(data).each(function (index, o) { 
                    //alert(o.fecha_inicio);
                    var $option = $("<option/>").attr("value", o.cve_cita_proceso_escolar).text(o.nombre);
					 $($option).data('fecha',o.fecha_inicio);
					$select.append($option);
					if(o.comentario!=""){
                        $($option).data('comentario',o.comentario);
                    }else{
                        $($option).data('comentario',o.comentario);
                    }
                });
                SelectedProceso();
            }
            Ready();
        },error:function(){
            swal({
                title: 'No se encuentra disponible!',
                text: 'No existen procesos disponibles',
                type: 'warning',
                confirmButtonText: 'Aceptar'
              });
        }
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

function SelectedProceso(){
	$('#xProcesoEscolares').change(function(){
		objRegistrarCita=new RegistrarCita();
		$("#xPanelCalendario").show();
		if(parseInt($(this).val())>0){
                    
                    $('#xCalendario').fullCalendar('destroy');
                    
                    calendario_turno();
                    $('#myModal').on('hidden.bs.modal', function (e) {

                    
                    });
					
		}else{
			$("#xPanelCalendario").hide(900);
		}
	});
}