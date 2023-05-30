/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function(){
    setTimeout(function(){
        cargarBoucher();
        CambiarEstatusBoucher();
    },600);
    
});


function cargarBoucher(){
    $.ajax({
        type:"POST" ,
        dataType:"json",
        url:"Controller/referenciaPagoAdmisionController.jsp",
        data:{yAccionReferencia:2,yCveSolicitud:$("#yCveSolicitud").val(),yCveUnidad:$("#xUnidadAcademica").val()},
        beforeSend:function(){
            
        },success:function(data){
            
            if(!$.isEmptyObject(data)){
                $(data).each(function (index, o) { 
                    $("#xFrontal").attr("href",data.frontal);
                    $("#xPosterior").attr("href",data.posterior);
                    
                    if(data.estatus_pago==1){ $('#xAceptarBoucher').attr('checked', true) }else{ $('#xAceptarBoucher').attr('checked', false)}
                });
            }else{
                $("#xFrontal").hide();
                $("#xPosterior").hide();
            }
            
        },error:function(){
            alert("Hubo un error al guardar Listado");
        }
    });
}

function CambiarEstatusBoucher(){
$('#xAceptarBoucher').change(function() {
    var estatus=2;
    
        if($(this).is(":checked")) {
            estatus=1;
        }else{
            estatus=0;
        }
        
         $.ajax({
            type:"POST" ,
            dataType:"json",
            url:"Controller/referenciaPagoAdmisionController.jsp",
            data:{yAccionReferencia:3,xAceptar:estatus,yCveSolicitud:$("#yCveSolicitud").val(),yCveUnidad:$("#xUnidadAcademica").val()},
            beforeSend:function(){

            },success:function(data){
                if(!$.isEmptyObject(data)){
                    $(data).each(function (index, o) { 
                        alert(data.Mensaje);
                    });
                }

            },error:function(XMLHttpRequest, textStatus, errorThrown){
                alert(textStatus);
            }
        });
        
    });
}