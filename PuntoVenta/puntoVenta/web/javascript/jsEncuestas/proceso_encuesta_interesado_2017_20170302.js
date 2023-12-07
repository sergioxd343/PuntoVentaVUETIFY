$(document).ready(function(){
    $("#xEnviar").click(function(e){
        e.preventDefault();
        var folioadmision = $("#xFolio").val();
        if(folioadmision.match(/^\d+$/)){//AAAA######AAAAAA##
            if($("#xFolio").val()!="" && eval($("#xFolio").val())>4){
                $.ajax({
                    type:"POST" ,
                    dataType:"json",
                    data: {yFolio:$("#xFolio").val(),yAccion:1,yEncuesta:82,yUnidadAcademica:1},
                    url:"../../../EInteresado",
                    beforeSend:function(){
                        //Antes de la enviar ajax
                        Loading();
                        $("#xBusqueda").hide(600);
                        $("#xBtnBusqueda").hide(800);
                    },success:function(data){                
                        //Despues de cargar la información y validar

                        if(!$.isEmptyObject(data)){
                            $(data).each(function (index, o) { 

                                if(o.existe==1){
                                    swal({
                                        title: 'Terminada!',
                                        text: 'La encuesta ya fue constestada.',
                                        type: 'success',
                                        confirmButtonText: 'Aceptar'
                                      });
                                    $("#xBusqueda").show(600);
                                    $("#xBtnBusqueda").show(800);
                                    $('#xForma')[0].reset();
									Ready();
                                }else if(o.existe==0){
                                    $("#xFolioInt").html($("#xFolio").val());
                                    $("#xNombreCompleto").html(o.nombre);
                                    $("#xCarrera").html(o.carrera);
                                    $("#xPanelInfo").show(1000);
                                    CargarEncuesta();
                                }
                            });
                        }else{
                            swal({
                                title: 'Error!',
                                text: 'El folio no contiene datos relacionados',
                                type: 'warning',
                                confirmButtonText: 'Aceptar'
                              });
                            
                            $("#xBusqueda").show(600);
                            $("#xBtnBusqueda").show(800);
                            $('#xForma')[0].reset();
							Ready();
                        }
                    },error:function(xhr, status, error){
                        swal({
                                title: 'Lo sentimos!',
                                text: 'Lo sentimos intente de nuevo más tarde',
                                type: 'warning',
                                confirmButtonText: 'Aceptar'
                              });
                        Ready();
                        $("#xBusqueda").show(600);
                        $("#xBtnBusqueda").show(800);
                        $('#xForma')[0].reset();
                }
                 });

            }else{
                swal({
                    title: 'Error!',
                    text: 'Debé capturar su folio de admisión',
                    type: 'error',
                    confirmButtonText: 'Aceptar'
                  });
                $("#xBusqueda").show(600);
                $("#xBtnBusqueda").show(800);
                $('#xForma')[0].reset();
				Ready();
            }
        }else{
            swal({
                title: 'Error!',
                text: 'Debé capturar su folio de admisión.',
                type: 'error',
                confirmButtonText: 'Aceptar'
              });
            $("#xBusqueda").show(600);
            $("#xBtnBusqueda").show(800);
            $('#xForma')[0].reset();
			Ready();
        }
        
        
    });
});

//Div para bloquear pantalla mientras se ejecuta el loading
function Mask(){
    $(document.body).append("<div class = 'mask'></div>");
    $('.mask').css({
            'width': $(document).width(), 
            'height': $(document).height(), 
            'position': 'absolute', 
            'top': 0,  
            'left': 0, 
            'background-color': 'black', 
            'opacity': 0.2, 
            'z-index': 99999
    });
}

//Bloquear pantalla mientras carga datos
function Loading(){		
    Mask();
    $(document.body).append("<div class = 'loading'><i class = 'fa fa-cog fa-spin'></i></div>");
    $('.loading').css({
        'position': 'absolute', 
        'top': 200,
        'left': $(document).width() / 2 - 50, 
        'z-index': 99999, 
        'font-size': '72pt', 
        'color': 'white'
    });
}

//Función para quitar bloqueo de Loading
function Ready(){
    var icon = $('.fa-spin').attr('action');
    $('.fa-spin').parents('a').removeAttr('disabled');
    if(icon)
        $('.fa-spin').parent().html("<i class = '" + icon + "'></i> " + $('.fa-spin').parent().text());
    $('.miniloading').parent().children().show();
    $('.mask, .loading, .miniloading, .fa-spin').remove();
}


//Carga la pantalla de encuesta del sito
function CargarEncuesta(){
    $("#xContenedor").load("proceso_encuesta_interesado.jsp",{xEncuesta:82},function(){
        Ready();
    });
}

/**
 * Regresa a la pantalla de busqueda de folio
 * @returns {undefined}
 */
function regresarForm(){
    $('#xForma')[0].reset();
    $("#xForma").submit();
}