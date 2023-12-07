var table;
function catalogo_citas_hora(){

   this.crt = "controlador/Controlador_catalogo_citas_hora.jsp";
   
   this.fnTabla();
   this.table = null;
   this.cve_cita_hora=0;
   this.Hora=$("#xHora");
   this.Semana=$("#xSemana");
   this.Sabado=$("#xSabado");
   this.activo=0;
   this.yAccion=1;
   this.post = null;

} 

catalogo_citas_hora.prototype.fnTabla=function()
{
     
  var o = this;
  o.fnLoading()
  table =  $('#tableCitasHora').DataTable({
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

        $(row).find(".edit").click(function () {
            window.scrollTo(0, 0);
            objCitas_hora.Hora.val(data["hora"]);
            objCitas_hora.Semana.val(data["turnos_semana"]);
            objCitas_hora.Sabado.val(data["turnos_sabado"]);
            objCitas_hora.cve_cita_hora=data["cve_cita_hora"];
            objCitas_hora.yAccion=2;

        });
    },
     "aoColumns": [
        { "mData": "cve_cita_hora", },
        { "mData": "hora"},
        { "mData": "turnos_semana"},
        { "mData": "turnos_sabado"},
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
catalogo_citas_hora.prototype.fnGuardar=function()
{
    var o=this;
        if(o.Semana.val().match(/^\d+$/) && o.Sabado.val().match(/^\d+$/) && o.Semana.val()!=""  && o.Sabado.val()!="" ){//AAAA######AAAAAA##
            
                $.ajax({
                    type:"POST" ,
                    dataType:"json",
                    url:o.crt,
                    data:{ yAccion: this.yAccion,yId:this.cve_cita_hora,xHora:this.Hora.val(),xSemana:this.Semana.val(),xSabado:this.Sabado.val(),yActivo:1},
                    beforeSend:function(){

                    },success:function(data){
                        swal({
                            title: data.title,
                            text: data.text,
                            type: data.type,
                            confirmButtonText: data.confirmButtonText
                          }).then(function(){
                              $('#tableCitasHora').DataTable().ajax.reload(null,false);
                              o.yAccion=1;
                              o.cve_cita_hora=0;
                              objCitas_hora.fnCancelar();

                          });


                    },error:function(){
                        swal({
                            title: 'Error!',
                            text: 'Hubo un error, intentar más tarde guardar',
                            type: 'error',
                            confirmButtonText: 'Aceptar'
                          });
                          objCitas_hora.fnCancelar();
                    }
                });
            
    }else{
         swal({
                title: 'Error!',
                text: 'El nombre del proceso no debe estár vacío',
                type: 'error',
                confirmButtonText: 'Aceptar'
              });
              objCitas_hora.fnCancelar();
    }
    
  
    
} 


catalogo_citas_hora.prototype.fnCancelar=function(){
    $('#forma')[0].reset();
}

//Bloquear pantalla mientras carga datos
catalogo_citas_hora.prototype.fnLoading = function (){		
     swal({
        allowOutsideClick: false,
        imageUrl: "../../images/Logo_utl_animado.gif",
        showCancelButton: false, // There won't be any cancel button
        showConfirmButton: false // There won't be any confirm button
    });
}

//Función para quitar bloqueo de Loading
catalogo_citas_hora.prototype.fnReady=function(){
    swal.close();
}

$(document).ready(function(){
    
    objCitas_hora= new catalogo_citas_hora();
    
    $('.clockpicker').clockpicker({
        twelvehour: false
    });
    
     $("#xGuardar").click(function(event){
        event.preventDefault();
        objCitas_hora.fnGuardar();
    });
    
    $('#xCancelar').click(function(event){
        event.preventDefault();
        objCitas_hora.fnCancelar();
    });
});


