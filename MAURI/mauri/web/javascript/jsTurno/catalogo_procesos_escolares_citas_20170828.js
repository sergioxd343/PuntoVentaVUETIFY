var table;
function catalogo_procesos_escolares_citas(){

   this.crt = "controlador/Controlador_catalogo_procesos_escolares_citas.jsp";
   this.fnTabla();
   this.table = null;
   this.id=0;
   this.cve_cita_proceso_escolares=0;    
   this.Nombre = $('#xNombre');
   this.activo=0;
   this.yAccion=1;
   this.post = null;
}



catalogo_procesos_escolares_citas.prototype.fnTabla=function()
{
     swal({
        allowOutsideClick: false,
        imageUrl: "../../images/Logo_utl_animado.gif",
        showCancelButton: false, // There won't be any cancel button
        showConfirmButton: false // There won't be any confirm button
    });
  var o = this;
  table =  $('#tableProcesos').DataTable({
    "initComplete": function(settings, json) {
    swal.close();
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
            objProcesoAsignar.fnActivar(data["cve_cita_proceso_escolar"])
        });
        $(row).find(".active").click(function () {
            objProcesoAsignar.fnEliminar(data["cve_cita_proceso_escolar"])
        });
        $(row).find(".edit").click(function () {
			window.scrollTo(0, 0);
            objProcesoAsignar.Nombre.val(data["nombre"]);
            objProcesoAsignar.cve_cita_proceso_escolares=data["cve_cita_proceso_escolar"];
            objProcesoAsignar.yAccion=2;

        });
    },
     "aoColumns": [
        { "mData": "cve_cita_proceso_escolar", },
        { "mData": "nombre"},
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

catalogo_procesos_escolares_citas.prototype.fnCancelar=function(){
    $('#forma')[0].reset();
}

/**
 * 
 * @returns {undefined}
 */
catalogo_procesos_escolares_citas.prototype.fnGuardar=function()
{
    var o=this;
    if( this.Nombre.size()>0 ){
        
        $.ajax({
        type:"POST" ,
        dataType:"json",
        url:o.crt,
        data:{ yAccion: this.yAccion,yId:this.cve_cita_proceso_escolares,xNombre:this.Nombre.val(),yActivo:1},
        beforeSend:function(){
 
        },success:function(data){
            swal({
                title: data.title,
                text: data.text,
                type: data.type,
                confirmButtonText: data.confirmButtonText
              }).then(function(){
                  $('#tableProcesos').DataTable().ajax.reload();
                  o.yAccion=1;
                  o.cve_cita_proceso_escolares=0;
                  objProcesoAsignar.fnCancelar();
                  
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

catalogo_procesos_escolares_citas.prototype.fnEliminar = function (id)
{
    this.cve_cita_proceso_escolares = id;

    if (this.cve_cita_proceso_escolares > 0)
    {
        var o = this;
        this.post = $.post(o.crt, {yAccion: 6, yId: o.cve_cita_proceso_escolares,yActivo:0}, 'json');
        this.post.done(function (data) {
            
            
            data = JSON.parse(data);
            
            swal({
                title: data.title,
                text: data.text,
                type: data.type,
                confirmButtonText: data.confirmButtonText,
                closeOnConfirm: false,
            }).then(function () {
                $('#tableProcesos').DataTable().ajax.reload();
                o.cve_cita_proceso_escolares = 0;
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
catalogo_procesos_escolares_citas.prototype.fnActivar = function (id)
{
    this.cve_cita_proceso_escolares = id;

    if (this.cve_cita_proceso_escolares > 0)
    {
        var o = this;
        this.post = $.post(o.crt, {yAccion: 3, yId: o.cve_cita_proceso_escolares,yActivo:1}, 'json');
        this.post.done(function (data) {
            data = JSON.parse(data);
            swal({
                title: data.title,
                text: data.text,
                type: data.type,
                confirmButtonText: data.confirmButtonText,
                closeOnConfirm: false,

            }).then(function () {
                $('#tableProcesos').DataTable().ajax.reload();
                o.yAccion=1;
                o.cve_cita_proceso_escolares=0;
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


$(document).ready(function(){
    objProcesoAsignar=new catalogo_procesos_escolares_citas();

    $("#xGuardar").click(function(event){
        event.preventDefault();
        
        objProcesoAsignar.fnGuardar();
        
    });
    
    $('#xCancelar').click(function(event){
        event.preventDefault();
        objProcesoAsignar.fnCancelar();
  });
    
});
