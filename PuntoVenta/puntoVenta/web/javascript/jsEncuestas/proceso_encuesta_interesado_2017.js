$(document).ready(function(){
    $("#xEnviar").click(function(e){
        e.preventDefault();
		
        var folioadmision = $("#xFolio").val();
		
        if(folioadmision.match(/^\d+$/)){//AAAA######AAAAAA##
		
            if($("#xFolio").val()!="" && eval($("#xFolio").val())>4){
				
                $.ajax({
                    type:"POST" ,
                    dataType:"json",
                    data: {yFolio:$("#xFolio").val(),yAccion:1,yEncuesta:84,yUnidadAcademica:1},
                    url:"../../../EInteresado",
                    beforeSend:function(){
                        //Antes de la enviar ajax
                        mensaje.preloader('../../../');
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
                                      }).then(function (){
											$("#xBusqueda").show(600);
											$("#xBtnBusqueda").show(800);
											$('#xForma')[0].reset();
											mensaje.cerrar();
									  });
                                    
                                }else if(o.existe==0){
                                    $("#xFolioInt").html($("#xFolio").val());
                                    $("#xNombreCompleto").html(o.nombre);
                                    $("#xCarrera").html(o.carrera);
                                    $("#xPanelInfo").show(1000);
                                    CargarEncuesta(o.interesado);
                                }
                            });
                        }else{
                            swal({
                                title: 'Error!',
                                text: 'El folio no contiene datos relacionados',
                                type: 'warning',
                                confirmButtonText: 'Aceptar'
                              }).then(function (){
									$("#xBusqueda").show(600);
									$("#xBtnBusqueda").show(800);
									$('#xForma')[0].reset();
									mensaje.cerrar();
							  });
                            
                            
                        }
                    },error:function(xhr, status, error){
                        swal({
                                title: 'Lo sentimos!',
                                text: 'Lo sentimos intente de nuevo más tarde',
                                type: 'warning',
                                confirmButtonText: 'Aceptar'
                              }).then(function (){
									$("#xBusqueda").show(600);
									$("#xBtnBusqueda").show(800);
									$('#xForma')[0].reset();
									mensaje.cerrar();
							  });
                        
                        
                }
                 });

            }else{
                swal({
                    title: 'Error!',
                    text: 'Debé capturar su folio de admisión',
                    type: 'error',
                    confirmButtonText: 'Aceptar'
                  }).then(function (){
					  $("#xBusqueda").show(600);
					$("#xBtnBusqueda").show(800);
					$('#xForma')[0].reset();
					mensaje.cerrar();
				  });
                
            }
        }else{
            swal({
                title: 'Error!',
                text: 'Debé capturar su folio de admisión.',
                type: 'error',
                confirmButtonText: 'Aceptar'
              }).then(function (){
				  $("#xBusqueda").show(600);
					$("#xBtnBusqueda").show(800);
					$('#xForma')[0].reset();
			  });
            
			
        }
        
        
    });
});




//Carga la pantalla de encuesta del sito
function CargarEncuesta(interesado){
    $("#xContenedor").load("proceso_encuestas_interesados.jsp",{},function(){
		$("#xContenedor").data("interesado",interesado);
		$("#xContenedor").data("encuesta",84);
        mensaje.cerrar();
		
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