/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function(){
    CrearCalendario();
    setTimeout(function(){
        $("#xSolicitud").html($("#yCveSolicitud").val());
        cargar_referencia();
    },1000);
    $("button").button();
    
    $("#xBtnGenerar").click(function(e){
        e.preventDefault();
        Guardar();
    });
});

function CrearCalendario(){
    var opt={
        dayNamesMin: [ "Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sa" ],
        monthNames:["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"],
        monthNamesShort: ["Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"],
        changeMonth:true,
        changeYear:false,
        dateFormat: 'yy-mm-dd',
        
    }
    $(".datepicker").datepicker(opt);
}

$( "#xMonto" ).spinner({
      step: 0.01,
      numberFormat: "n",
      min: 0
    });



function cargar_referencia(){
    $.ajax({
        type:"POST" ,
        dataType:"JSON",
        url:"Controller/referenciaPagoAdmisionController.jsp",
        data:$("form").serialize(),
        beforeSend:function(){
            $("#xReferenciaAdmision").html("<i class='fa fa-spinner fa-pulse'></i>");
        },success:function(data){
            $("#xReferenciaAdmision").empty();
            if(!$.isEmptyObject(data)){
                $(data).each(function (index, o) {    
                    $("#xConcepto").val(o.concepto);
                    $("#xMonto").val(o.monto);
                    $("#xLimite").val(o.limite);
                    $("#xReferenciaAdmision").html(o.referencia);
                    $("#yAccionReferencia").val(4);
                });
            }else{
                $("#yAccionReferencia").val(1);
            }
        },error:function(){
            alert("Hubo un error al guardar");
        }
    });
}

function Guardar(){
    $.ajax({
        type:"POST" ,
        dataType:"JSON",
        url:"Controller/referenciaPagoAdmisionController.jsp",
        data:$("form").serialize(),
        beforeSend:function(){
            
        },success:function(data){
            
            if(!$.isEmptyObject(data)){
                $(data).each(function (index, o) {
                    $("#yAccionReferencia").val(5);
                    alert(o.Mensaje);
                    cargar_referencia();
                });
            }
        },error:function(){
            alert("Hubo un error al guardar");
        }
    });
}