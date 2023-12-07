/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function catalogo_citas_personas_configuracion(){
    this.crt = "controlador/Controlador_catalogo_citas_personas_configuracion.jsp";
}

/**
 * 
 * @returns {undefined}
 */
catalogo_citas_personas_configuracion.prototype.fnGuardar=function()
{
        if($("#xPersonal").val()>0) {//AAAA######AAAAAA##
            
        
        $.ajax({
        type:"POST" ,
        dataType:"json",
        url:persona_conf.crt,
        data:{ yAccion: 5,yConfiguracion:$("#xDiaLaboral").val(),yPersonal:$("#xPersonal").val()},
        beforeSend:function(){
                Loading();
        },success:function(data){
            if(data==1){
                swal({
                title: "Registro guardado",
                text: "El registro se ha guardado con exito",
                type: "success",
                confirmButtonText: "Aceptar"
              }).then(function(){
                  
                  $('#tablePersonal').DataTable().ajax.reload();
              });
            }else{
                swal({
                title: 'Error!',
                text: 'Hubo un error, intentar más tarde',
                type: 'error',
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
    }else{
         swal({
                title: 'Error!',
                text: 'El nombre del proceso no debe estár vacío',
                type: 'error',
                confirmButtonText: 'Aceptar'
              });
    }
    
  
    
} 

catalogo_citas_personas_configuracion.prototype.fnEliminar=function(conf,per)
{

        $.ajax({
        type:"POST" ,
        dataType:"json",
        url:persona_conf.crt,
        data:{ yAccion: 6,yConfiguracion:conf,yPersonal:per},
        beforeSend:function(){
                Loading();
        },success:function(data){
            if(data==1){
                swal({
                title: "Registro eliminado",
                text: "El registro se ha eliminado con exito",
                type: "success",
                confirmButtonText: "Aceptar"
              }).then(function(){
                  $('#tablePersonal').DataTable().ajax.reload();
              });
            }else{
                swal({
                title: 'Error!',
                text: 'Hubo un error, intentar más tarde',
                type: 'error',
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

catalogo_citas_personas_configuracion.prototype.fnCargarProcesos=function(){
   
    $.ajax({
        type:"POST" ,
        dataType:"json",
        url:persona_conf.crt,
        data:{yAccion:1},
        beforeSend:function(){
            Loading();
        },success:function(data){
            var $select = $('#xProceso');
            $select.empty();
            var $option = $("<option/>").attr("value", 0).text("Selecciona el proceso");
            $select.append($option);
            if(!$.isEmptyObject(data)){        
                $(data).each(function (index, o) { 
                    console.log(o);
                    $option = $("<option/>").attr("value", o.cve_cita_proceso_escolar).text(o.nombre);
                    $select.append($option);
                });
                
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

catalogo_citas_personas_configuracion.prototype.fnCargarDias=function(proceso){
   
    $.ajax({
        type:"POST" ,
        dataType:"json",
        url:persona_conf.crt,
        data:{yAccion:2,xProceso:proceso},
        beforeSend:function(){
            Loading();
        },success:function(data){
            var $select = $('#xDiaLaboral');
           $select.empty();
           var  $option = $("<option/>").attr("value", 0).text("Selecciona día laboral");
           $select.append($option);
            if(!$.isEmptyObject(data)){        
                $(data).each(function (index, o) {
                    var dia="";
                    var num_dia=0;
                    switch(parseInt(o.dia)){
                        case 2:
                            dia="Lunes";
                            num_dia=2;
                            break;
                        case 3:
                            dia="Martes";
                            num_dia=3;
                            break;
                        case 4:
                            dia="Miércoles";
                            num_dia=4;
                            break;
                        case 5:
                            dia="Jueves";
                            num_dia=5;
                            break;
                        case 6:
                            dia="Viernes";
                            num_dia=6;
                            break;
                        case 7:
                            dia="Sábado";
                            num_dia=7;
                            break;
                    }
                    $option = $("<option/>").attr("value", o.id).text(dia);
                    $($option).data('num_dia',num_dia);  
                    
                    $select.append($option);
                    
                });
                
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

catalogo_citas_personas_configuracion.prototype.fnCargarPersonal=function(){
   
    $.ajax({
        type:"POST" ,
        dataType:"json",
        url:persona_conf.crt,
        data:{yAccion:3,xProceso:$('#xProceso').val(),yDia:$("#xDiaLaboral").find('option:selected').data("num_dia")},
        beforeSend:function(){
            Loading();
        },success:function(data){
            var $select = $('#xPersonal');
            $select.empty();
           var  $option = $("<option/>").attr("value", 0).text("Selecciona el personal");
           $select.append($option);
            if(!$.isEmptyObject(data)){        
                $(data).each(function (index, o) { 
                    console.log(o);
                    $option = $("<option/>").attr("value", o.id).text(o.nombre);
                    $select.append($option);
                });
                Ready();
            }
            
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

catalogo_citas_personas_configuracion.prototype.fnTabla = function ()
{
    //   objConfiguracion.fnLoading();
    var o = this;
    Loading();
    table = $('#tablePersonal').DataTable({
        "initComplete": function (settings, json) {
            Ready();
			
        },
        "oLanguage": {
            "sLoadingRecords": "Espere un momento - cargando...",
            "sLengthMenu": "Mostrar _MENU_ registros",
            "sEmptyTable": "No hay registros para mostrar",
            "sInfo": "Mostrando registros de _START_ a _END_ de un total de _TOTAL_ registros",
            "oPaginate": {
                "sPrevious": "Página anterior",
                "sNext": "Siguiente página",
                "sLast": "Última página",
                "sFirst": "Primer página"
            },
            "sSearch": "Buscar:"
        },
        "ajax": {
            url: o.crt,
            type: "POST",
            data: function (d) {
                d.yAccion = 4;
                d.xProceso = $("#xProceso").val();
                d.yDia=$("#xDiaLaboral").find('option:selected').data("num_dia");
            }
        },
        "bDestroy": true,
        "bSortable": false,
        "fnCreatedRow": function (row, data, index) {


            $(row).find(".Eliminar").click(function () {
                persona_conf.fnEliminar(data["id_configuracion"],data["id_persona_atencion"])
                //objCitasVentanilla.fnAsistencia(data["id"], 1)
            });
           
        },
        "aoColumns": [
            {"mData": "proceso"},
            {"mData": "id_empleado"},
            {"mData": "nombre_completo"},
            {"mData": null,
                "className": "text-left",
                "mRender": function (data, type, row) {
                    
                var dia="";
                    switch(parseInt(data["dia"])){
                        case 2:
                            dia="Lunes";
                            break;
                        case 3:
                            dia="Martes";
                            break;
                        case 4:
                            dia="Miércoles";
                            break;
                        case 5:
                            dia="Jueves";
                            break;
                        case 6:
                            dia="Viernes";
                            break;
                        case 7:
                            dia="Sábado";
                            break;
                    }
                return dia;
                        //return "Activo"

                }
            },
            {"mData": null,
                    "className": "text-center",
                    "mRender": function (data, type, row) {
                        
                    strButton = "<center> "
                            + "<button class='btn btn-danger Eliminar'  ><span class='fa fa-trash' aria-hidden='true'></span> Eliminar</button "
                            + "</center>";
                    return strButton;
                            //return "Activo"
                        
                    }
                }]
    });

}

catalogo_citas_personas_configuracion.prototype.fnCancelar=function(){
    $('#forma')[0].reset();
    $('#tablePersonal').DataTable().clear().draw();
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
    persona_conf=new catalogo_citas_personas_configuracion();
    persona_conf.fnCargarProcesos();
    
    $("#xProceso").change(function(){
        if($(this).val()>0){
            persona_conf.fnCargarDias($(this).val());
            
        }
    });
    
    $("#xDiaLaboral").change(function(){
        if($(this).val()>0){
            persona_conf.fnCargarPersonal();
            persona_conf.fnTabla();
        }
    });
    
    $("#xGuardar").click(function (e) {
        e.preventDefault();
        
        persona_conf.fnGuardar();
		
    });
    
    $("#xCancelar").click(function (e) {
        e.preventDefault();
        
        persona_conf.fnCancelar();
		
    });
});