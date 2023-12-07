/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function(){
    setTimeout(function(){
        
        Consulta_observacion();
    
    },600);
});

function Consulta_observacion(){
    $.ajax({
        type:"POST" ,
        dataType:"json",
        url:"Controller/procesoObservacionesAdmisionController.jsp",
        data:{yAccion_observacion:3,yCveSolicitud:$("#yCveSolicitud").val(),yCveUnidadAcademica:$("#xUnidadAcademica").val()},
        beforeSend:function(){
            $("#xObservacion").attr("disabled",true);
        },success:function(data){
            
            
                
            if(!$.isEmptyObject(data)){
                $(data).each(function (index, o) { 
                    if(parseInt( o.existe)==1){
                        $("#xObservacion").val(o.observacion);
                        $("#yAccion_observacion").val(2);
                    }else{
                        
                        $("#yAccion_observacion").val(1);
                        
                    }
                });
            }
            
        
            
        },error:function(){
            alert("Hubo un error al guardar Listado");
        },complete:function() {
            
            $("#xObservacion").attr("disabled",false);
                
            
        }
    });
}

function alta_observacion(){
//1. Guardar observación, 2. Modificar observación
    $.ajax({
        type:"POST" ,
        dataType:"json",
        url:"Controller/procesoObservacionesAdmisionController.jsp",
        data:{yAccion_observacion:$("#yAccion_observacion").val(),yCveSolicitud:$("#yCveSolicitud").val(),yCveUnidadAcademica:$("#xUnidadAcademica").val(),xObservacion:$("#xObservacion").val()},
        beforeSend:function(){
            
        },success:function(data){
            
            if(!$.isEmptyObject(data)){
                $(data).each(function (index, o) { 
                    if(parseInt( o.existe)===1){
                        $("#xObservacion").val(o.observacion);
                        $("#yAccion_observacion").val(2);
                    }else{
                        
                        $("#yAccion_observacion").val(1);
                        
                    }
                });
            }
            
        },error:function(){
            alert("Hubo un error al guardar Listado");
        }
    });
}