/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var modalDocumentos;
$(document).ready(function(){
    setTimeout(function(){
        Listado();
    },800);
});

function checksDocumentos(){
    var estatus=0;
    $("input[name='xDocumentos']").click(function(){
        
        if($(this).is(':checked')){
            $("label[for='"+$(this).val()+"']").text("aceptado");
            //Aceptado
            estatus=2;
            
        }else if(!$(this).is(':checked')){               
            $("label[for='"+$(this).val()+"']").text("No aceptado");
            //Rechazado
            estatus=1;
        }
        
        $.ajax({
            type:"POST" ,
            dataType:"json",
            url:"Controller/muestraRecepcionDocumentosController.jsp",
            data:{yAccion:2,yCveEntregados:$(this).val(),yEstatus:estatus},
            beforeSend:function(){

            },success:function(data){
                if(!$.isEmptyObject(data)){
                    $(data).each(function (index, o) { 
                        alert(o.Mensaje);
                    });

                }

            },error:function(){
                alert("estatus 1");
                alert("Hubo un error al guardar-");
            }
        });
        
    });
    
    
}

function EliminarDocumentos(){
    var cve_documento_entregado=0;
    var estatus=0;
    
    
    $("button[name='xEliminar']").click(function(){
        
        if( confirm("Se eliminara el documento, ¿Está seguro de continuar?")){
            cve_documento_entregado=$(this).val();
            
            $.ajax({
            type:"POST" ,
            dataType:"json",
            url:"Controller/muestraRecepcionDocumentosController.jsp",
            data:{yAccion:2,yCveEntregados:cve_documento_entregado,yEstatus:estatus},
            beforeSend:function(){

            },success:function(data){
                if(!$.isEmptyObject(data)){
                    $(data).each(function (index, o) { 
                        alert(o.Mensaje);
                        $('#xTablaDocs tbody tr').remove();
                        Listado();
                    });
                    
                }

            },error:function(){
                alert("estatus 1");
                alert("Hubo un error al guardar-");
            }
        });
            
        }else{               
            
        }
        
        
        
    });
    
    
}

function Listado(){
    
    $.ajax({
        type:"POST" ,
        dataType:"json",
        url:"Controller/muestraRecepcionDocumentosController.jsp",
        data:{yAccion:1,yCveSolicitud:$("#yCveSolicitud").val(),yProceso:$("#xbtnDocumentos"+$("#yCveSolicitud").val()).data("proceso")},
        beforeSend:function(){
            $("#loader").show();
        },success:function(data){
            
            if(!$.isEmptyObject(data)){
                $(data).each(function (index, o) { 
                    
                    $('<tr>').html(
                        "<td >"+o.documento+"</td>"+
                        (o.estatus===0?"<td style='text-align: center'>Sin documento</td>"+
                        "<td style='text-align: center'><label for='"+o.cveEntregado+"' id='xlbDocumento_2' >Sin documento</label></td>":"<td style='text-align: center'><a target='__blank' href='http://digitalizacion.utleon.edu.mx/Documentos/"+o.ruta+"'>Ver documento</a></td>"+
                        "<td style='text-align: center'><input name='xDocumentos' type='checkbox' value='"+o.cveEntregado+"' data_id='xDocumentos' id='xDocumento_"+o.cveEntregado+"' ><label for='"+o.cveEntregado+"' id='xlbDocumento_2' >No aceptado</label></td>" +
                        "<td style='text-align: center'><button name='xEliminar' type='button' value='"+o.cveEntregado+"' data_id='xEliminar' id='xEliminar_"+o.cveEntregado+"' >Eliminar documento</button></td>" ) +
                        
                        "</tr>"
                    ).appendTo('#xTablaDocs tbody').addClass("CeldaDatos");
                            if(o.estatus==2){
                                $("#xDocumento_"+o.cveEntregado).prop( "checked", true );
                                $("label[for='"+o.cveEntregado+"']").text("aceptado");
                                $("#xEliminar_"+o.cveEntregado+"").hide();
                            }
                });
				
            }
            checksDocumentos();
            EliminarDocumentos();
            $("#loader").hide();
        },error:function(){
            alert("Hubo un error al guardar Listado");
        }
    });
}