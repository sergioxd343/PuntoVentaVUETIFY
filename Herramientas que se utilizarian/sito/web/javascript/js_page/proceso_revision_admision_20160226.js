/* 
 
 
 
 */
var modalDialog,modalObservacion;
$(document).ready(function(){
    $("button").button();
    
    checks();
    
    cargarUnidad();
    
    CrearCalendario();
    
    $("#xbtnBuscar").click(function(){
        cargarListaInteresados(); 
    });
    
    $("#xUnidadAcademica").change(function(){
        
        if(parseInt($("#xUnidadAcademica").find('option:selected').val())>0){
            cargarConvocatoria(parseInt($("#xUnidadAcademica").find('option:selected').val()));
        }
    });
});

function cargarUnidad(){
    $.ajax({
        type:"POST" ,
        dataType:"json",
        url:"Controller/procesoRevisionAdmisionController.jsp",
        data:{yAccion:1},
        beforeSend:function(){

        },success:function(data){
            var $select = $('#xUnidadAcademica');
            if(!$.isEmptyObject(data)){
                $(data).each(function (index, o) {    
                    var $option = $("<option/>").attr("value", o.cve_unidad_academica).text(o.nombre);
                    $select.append($option);
                });
            }
        },error:function(){
            alert("Hubo un error al guardar");
        }
    });
}



function cargarConvocatoria(cve){
        $.ajax({
            type:"POST" ,
            dataType:"json",
            url:"Controller/procesoRevisionAdmisionController.jsp",
            data:{yAccion:4,xUnidad:cve},
            beforeSend:function(){

            },success:function(data){
                var $select = $('#xConvocatoria');
                if(!$.isEmptyObject(data)){
                    $(data).each(function (index, o) {    
                        var $option = $("<option/>").attr("value", o.cve_convocatoria_admision).text(o.descripcion);
                        $select.append($option);
                    });
                }else{
                    alert("No existen convocatorias");
                }
            },error:function(){
                alert("Hubo un error al guardar");
            }
        });
    
}


function checks(){
    $("input[data-id='xValidacion']").each(function(){
        
        $(this).click(function(){            
            if($(this).is(':checked')){
                $("label[for='"+$(this).attr("id")+"']").text("Si");
            }else if(!$(this).is(':checked')){                
                $("label[for='"+$(this).attr("id")+"']").text("No");    
            }
        });
    });
}

function Observaciones(url,id){
   var opt;
   
   $("#yModalObservaciones").load(url,function(){
       
    var titulo="Universidad Tecnológica de León";
     opt={
            dialogClass:'no-close',
            modal:false,
            resizable:true,
            autoOpen:false,
            width:"auto",
            title: titulo,
            closeOnEscape:false,
            position: [300,28],
        create: function (event) { 
            $(event.target).parent().css('position', 'absolute');
                //setTimeout(function(){
                    $("#yCveSolicitud").val(id);
                    
               // },1200);
        },
        close: function (event) { if(event.originalEvent){$("#yModalObservaciones").empty();$(this).dialog('destroy');}},
        
            show: {
            effect: "blind",
            duration: 500
            },
            hide: {
            effect: "blind",
            duration: 500
            },
            buttons:
             {
            "Cerrar": function() {
                $(this).dialog('destroy');
                $(this).empty();
                return false;
            },"Guardar":function(){
                //Funcion para guardar la observación
                alta_observacion();
                $(this).dialog('destroy');
                $(this).empty();
                return false;
            }
           }
        }
       modalObservacion=$("#yModalObservaciones").dialog(opt).dialog("open");
       
       
    });
   
    $("#yCveSolicitud").val(id);
    
    url="";
}

function enlaces(url,id){
var opt;
   $("#yModal").load(url,function(){
       
    var titulo="Universidad Tecnológica de León";
     opt={
            dialogClass:'no-close',
            modal:false,
            resizable:true,
            autoOpen:false,
            width:"auto",
            title: titulo,
            closeOnEscape:false,
            position: [300,28],
        create: function (event) { 
            $(event.target).parent().css('position', 'absolute');
                //setTimeout(function(){
                    $("#yCveSolicitud").val(id);
                    $("#yCveUnidad").val(parseInt($("#xUnidadAcademica").find('option:selected').val()));
               // },1200);
        },
        close: function (event) { if(event.originalEvent){$("#yModal").empty();$(this).dialog('destroy');}},
        
            show: {
            effect: "blind",
            duration: 500
            },
            hide: {
            effect: "blind",
            duration: 500
            },
            buttons:
             {
            "Cerrar": function() {
                $(this).dialog('destroy');
                $(this).empty();
                
                return false;
            }
           }
        }
       modalDialog=$("#yModal").dialog(opt).dialog("open");
       
       
    });
   
    $("#yCveSolicitud").val(id);
    $("#yCveUnidad").val(parseInt($("#xUnidadAcademica").find('option:selected').val()));
    url="";
}


function DatosInteresado(){
    var titulo="Universidad Tecnológica de León";
    $("#yDatosInteresado").dialog({
            dialogClass:'no-close',
            modal:false,
            resizable:true,
            autoOpen:false,
            width:"auto",
            title: titulo,
            closeOnEscape:false,
            position: [300,28],
        create: function (event) { $(event.target).parent().css('position', 'absolute');},
        close: function (event) { if(event.originalEvent){}},
            show: {
            effect: "blind",
            duration: 500
            },
            hide: {
            effect: "blind",
            duration: 500
            }
        });
        $("#yDatosInteresado").dialog('open');
}

function CrearCalendario(){
    $(".datepicker").datepicker({
        dayNamesMin: [ "Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sa" ],
        monthNames:["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"],
        monthNamesShort: ["Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"],
        changeMonth:false,
        changeYear:false,
        dateFormat: 'yy-mm-dd',
        onSelect: function(dateText, inst) {
            var lockDate = new Date($('#xFechaInicio').datepicker('getDate'));
            $('#xFechaFin').datepicker('option', 'minDate', lockDate);
        }
    });
}



function cargarListaInteresados(){
    
    if(parseInt($("#xUnidadAcademica").find('option:selected').val())>0 && parseInt($("#xUnidadAcademica").find('option:selected').val())>0 && $("#xFolioInteresado").val()!="" ){
        
        $.ajax({
            type:"POST" ,
            dataType:"JSON",
            url:"Controller/procesoRevisionAdmisionController.jsp",
            data:{yAccion:3,xUnidad:$("#xUnidadAcademica").val(),xConvocatoria:$("#xConvocatoria").val(),xFolio:$("#xFolioInteresado").val()},
            beforeSend:function(){ 
				$("#loader").show();
            },success:function(data){
				
                if(!$.isEmptyObject(data)){
                    var tr_table="";
                    $(data).each(function (index, o) {
                 console.log(data)
                   // for(var i=0;i<100;i++){
                    tr_table+='<tr>'+
                        "<td style='text-align: center'>"+o.cve_solicitud_admision+"</td>"+
                        "<td style='text-align: center'><button id='xbtnRegistro"+o.cve_solicitud_admision+"' data-id='"+o.cve_solicitud_admision+"' name='xbtnInteresado'   role='button'>Enlace</td>"+
                        "<td style='text-align: center'><button data-id='"+o.cve_solicitud_admision+"' id='xbtnDocumentos"+o.cve_solicitud_admision+"' data-href='muestra_recepcion_documentos.jsp' name='xbtnDocumentos'  >Enlace</button></td>"+
                        "<td style='text-align: center; display:none'><button data-id='"+o.cve_solicitud_admision+"' id='xbtnReferencia"+o.cve_solicitud_admision+"' data-href='proceso_referencia_admision.jsp' name='xbtnReferencia'  >Enlace</button></td>"+
                        "<td style='text-align: center; display:none'><button data-id='"+o.cve_solicitud_admision+"' id='xbtnBoucher"+o.cve_solicitud_admision+"' data-href='muestra_referencia_boucher.jsp' name='xbtnBoucher'  >Enlace</button></td>"+
                        "<td style='text-align: center; display:none'><button data-id='"+o.cve_solicitud_admision+"' id='xbtnBoucher"+o.cve_solicitud_admision+"' data-href='proceso_turno_atencion.jsp' name='xbtnBoucher'  >Enlace</button></td>"+
                        "<td style='text-align: center'><button data-id='"+o.cve_solicitud_admision+"' id='xbtnObservacion"+o.cve_solicitud_admision+"' data-href='proceso_observaciones_admision.jsp'  name='xbtnObservacion' >Agregar observación</button></td>"+
                        "<td style='display: none'>" + o.nombre + "</td>" + 
                        ""+
                        "</tr>"
                    
                   // }
                    
                    
                    });
                    $("#xTablaDatos tbody tr").remove();
                    $('#xTablaDatos tbody').append(tr_table).addClass("CeldaDatos");
					
                }else{
                    $("#xTablaDatos tbody tr").remove();

                }
                $("button").button();
               $("#loader").hide();
                informacionInteresado();
                botones_documentos();
                botones_referencia();
                botones_boucher();
                btnObservaciones();
            },error:function(){
                alert("Hubo un error al guardar");
            }
        });
    }else{
        alert("Todos los campos son requeridos");
    }
}


function informacionInteresado(){
    $("button[name=xbtnInteresado]").click(function(){
          var id=$(this).attr("data-id");
             if(id>0){
                $.ajax({
                    type:"POST" ,
                    dataType:"JSON",
                    url:"Controller/procesoRevisionAdmisionController.jsp",
                    data:{yAccion:2,yCve_solicitud_admision:id},
                    beforeSend:function(){
						$("#loader").show();
                    },success:function(data){
                        var mes,anio;
                        if(!$.isEmptyObject(data)){
							
                            $(data).each(function (index, o) {    
                                $("#xNombre").html("<b>"+o.nombre+"</b>");
                                $("#xPaterno").html("<b>"+o.apellido_paterno+"</b>");
                                $("#xMaterno").html("<b>"+o.apellido_materno+"</b>");
                                $("#xCURP").html("<b>"+o.curp+"</b>");
                                $("#xNacimiento").html("<b>"+o.Ciudad+"</b>");
                                $("#xBachillerato").html("<b>"+o.Bachillerato+"</b>");
                                $("#xEspecialidad").html("<b>"+o.especialidad_bachillerato+"</b>");
                                mes=o.anio_inicio.substring(0,2);
                                anio=o.anio_inicio.substring(2,4);
                                $("#xMes").html("<b>"+mes+"</b>");
                                $("#xAnio").html("<b>"+anio+"</b>");
                                mes=o.anio_fin.substring(0,2);
                                anio=o.anio_fin.substring(2,4);
                                $("#xMes2").html("<b>"+mes+"</b>");
                                $("#xAnio2").html("<b>"+anio+"</b>");
                                $("#xPlantel").html("<b>"+o.unidad_academica+"</b>");
                                $("#xCarreraUni").html("<b>"+o.carrera+"</b>");
                                $("#xEspecialidadUni").html("<b>"+o.especialidad_carrera+"</b>");
                                var turno=(o.turno=="P"?"Matutino":"Despertino")
                                $("#xTurno").html("<b>"+turno+"</b>");
                                
                            });
                            DatosInteresado();
							
                        }
						$("#loader").hide();
                    },error:function(){
                        alert("Hubo un error al guardar");
                    }
                });
            }
    });
}

function botones_documentos(){
    $("button[name=xbtnDocumentos]").click(function(){
        url=$(this).attr("data-href");
        id=$(this).attr("data-id");
        enlaces(url,id);
        
    });
}

function botones_referencia(){
    $("button[name=xbtnReferencia]").click(function(){
        url=$(this).attr("data-href");
        id=$(this).attr("data-id");
        
        enlaces(url,id);
        
    });
}

function botones_boucher(){
    $("button[name=xbtnBoucher]").click(function(){
        url=$(this).attr("data-href");
        id=$(this).attr("data-id");
        
        enlaces(url,id);
        
    });
}

function btnObservaciones(){
    $("button[name=xbtnObservacion]").click(function(){
        url=$(this).attr("data-href");
        id=$(this).attr("data-id");
        
        Observaciones(url,id);
    });
}
