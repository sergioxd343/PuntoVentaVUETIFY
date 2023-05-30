var table;
function catalogo_citas_configuracion(){

   this.crt = "controlador/Controlador_catalogo_citas_configuracion_turno.jsp";
   
   this.fnTabla();
   this.table = null;
   this.cve_cita_configuracion=0;
   this.Inicio=$("#xHoraInicio");
   this.Termino=$("#xHoraFin");
   this.Minutos=$("#xMinutos");
   this.activo=0;
   this.yAccion=1;
   this.post = null;

} 

catalogo_citas_configuracion.prototype.fnTabla=function()
{
  //   objConfiguracion.fnLoading();
  var o = this;
  o.fnLoading()
  table =  $('#tableConfiguracion').DataTable({
    "initComplete": function(settings, json) {
        o.fnReady();
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
     "ajax": o.crt+"?yAccion=5",
     "bDestroy": true,
     "bSortable": false,
     "fnCreatedRow": function (row, data, index) {

        if (parseInt(data["activo"]) === 0)
            $(row).addClass('danger');

        $(row).find(".inactive").click(function () {
            objConfiguracion.fnActivar(data["cve_cita_configuracion_turno"])
        });
        $(row).find(".active").click(function () {
            objConfiguracion.fnEliminar(data["cve_cita_configuracion_turno"])
        });
        $(row).find(".edit").click(function () {
			window.scrollTo(0, 0);
            objConfiguracion.Inicio.val(data["hora_inicio_atencion"]);
            objConfiguracion.Termino.val(data["hora_termino_atencion"]);
            objConfiguracion.Minutos.val(data["rango_hora_atencion"]);
            objConfiguracion.cve_cita_configuracion=data["cve_cita_configuracion_turno"];
            objConfiguracion.yAccion=2;

        });
    },
     "aoColumns": [
        { "mData": "cve_cita_configuracion_turno", },
        { "mData": "hora_inicio_atencion"},
        { "mData": "hora_termino_atencion"},
        { "mData": "rango_hora_atencion"},
        { "mData": "activo",
          "className":"text-center",
          "mRender": function(data, type, row) {
              if (data == 1) {
                    strButton = "<center> "
                            + "<button class='btn btn-success active'  ><span class='fa fa-check-circle' aria-hidden='true'></span></button "
                            + "</center>";
                    return strButton;
                    //return "Activo"
                } else {
                    strButton = "<center> "
                            + "<button class='btn btn-danger inactive'  ><span class='fa fa-ban' aria-hidden='true'></span></button "
                            + "</center>";
                    return  strButton;
                    //return "Inactivo"
                }
        }
    },
        {"mData": null,
                "mRender": function (data, type, full) {

                    strButton = "<center> "
                            + "<button class='btn btn-primary  edit'  ><span class='fa fa-pencil-square' aria-hidden='true'></span></button "
                            + "</center>";
                    return  strButton;
                    //return "Inactivo"

                },
                "sClass": "text-center", "bSortable": true}]
   });
   
}

/**
 * 
 * @returns {undefined}
 */
catalogo_citas_configuracion.prototype.fnGuardar=function()
{
    var o=this;
        if(o.Minutos.val().match(/^\d+$/) && o.Minutos.val()!="" && parseInt(o.Minutos.val())>0 ){//AAAA######AAAAAA##
        
        $.ajax({
        type:"POST" ,
        dataType:"json",
        url:o.crt,
        data:{ yAccion: this.yAccion,yId:this.cve_cita_configuracion,xHoraInicio:this.Inicio.val(),xHoraFin:this.Termino.val(),xMinutos:this.Minutos.val(),yActivo:1},
        beforeSend:function(){
 
        },success:function(data){
            swal({
                title: data.title,
                text: data.text,
                type: data.type,
                confirmButtonText: data.confirmButtonText
              }).then(function(){
                  $('#tableConfiguracion').DataTable().ajax.reload(null,false);
                  o.yAccion=1;
                  o.cve_cita_configuracion=0;
                  objConfiguracion.fnCancelar();
                  
              });
              
              
        },error:function(){
            swal({
                title: 'Error!',
                text: 'Hubo un error, intentar más tarde guardar',
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

catalogo_citas_configuracion.prototype.fnEliminar = function (id)
{
    this.cve_cita_configuracion = id;

    if (this.cve_cita_configuracion > 0)
    {
        var o = this;
        this.post = $.post(o.crt, {yAccion: 6, yId: o.cve_cita_configuracion,yActivo:0}, 'json');
        this.post.done(function (data) {
            data = JSON.parse(data);
            swal({
                title: data.title,
                text: data.text,
                type: data.type,
                confirmButtonText: data.confirmButtonText,
                closeOnConfirm: false,
            }).then(function () {
                $('#tableConfiguracion').DataTable().ajax.reload(null,false);
                o.cve_cita_configuracion = 0;
                o.yAccion = 0;
                
            });


        });
    } else {
        swal({
            title: "Upss",
            text: "Ha ocurrido un error",
            type: "error",
            confirmButtonText: "Aceptar",
            closeOnConfirm: false,

        })
    }
}

/**               
 * Metodo      : "fnActivar"
 * Descripcion: "cambia de estatus activo al especialidad seleccionado."
 */
catalogo_citas_configuracion.prototype.fnActivar = function (id)
{
    this.cve_cita_configuracion = id;

    if (this.cve_cita_configuracion > 0)
    {
        var o = this;
        this.post = $.post(o.crt, {yAccion: 3, yId: o.cve_cita_configuracion,yActivo:1}, 'json');
        this.post.done(function (data) {
            data = JSON.parse(data);
            swal({
                title: data.title,
                text: data.text,
                type: data.type,
                confirmButtonText: data.confirmButtonText,
                closeOnConfirm: false,

            }).then(function () {
                $('#tableConfiguracion').DataTable().ajax.reload(null,false);
                o.yAccion=1;
                o.cve_cita_configuracion=0;
                
            });
        });
    } else {
        swal({
            title: "Upss",
            text: "Ha ocurrido un error Activar",
            type: "error",
            confirmButtonText: "Aceptar",
            closeOnConfirm: false,

        })
    }
}


catalogo_citas_configuracion.prototype.fnCancelar=function(){
    $('#forma')[0].reset();
}

//Bloquear pantalla mientras carga datos
catalogo_citas_configuracion.prototype.fnLoading = function (){		
     swal({
        allowOutsideClick: false,
        imageUrl: "../../images/Logo_utl_animado.gif",
        showCancelButton: false, // There won't be any cancel button
        showConfirmButton: false // There won't be any confirm button
    });
}

//Función para quitar bloqueo de Loading
catalogo_citas_configuracion.prototype.fnReady=function(){
    swal.close();
}

$(document).ready(function(){
    
    objConfiguracion= new catalogo_citas_configuracion();
    
    $('.clockpicker').clockpicker({
        twelvehour: false
    });
    
     $("#xGuardar").click(function(event){
        event.preventDefault();
        objConfiguracion.fnGuardar();
    });
    
    $('#xCancelar').click(function(event){
        event.preventDefault();
        objConfiguracion.fnCancelar();
    });
});


