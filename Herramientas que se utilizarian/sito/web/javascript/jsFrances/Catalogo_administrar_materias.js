/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function(){
        
    /*
     * Acciones por botón
    */
    $("#xNuevo").click(function(){
        Limpiar();
    });
    $("#xGuardar").click(function(){
       Guardar();
    });

    $("#xEliminar").click(function(){
        Alerta('visible', '#FF0000','Eliminar registro');
    });
    $("#xBuscar").click(function(){
        Alerta('visible', '#008000', 'Buscar registro');
    });
    $("#xClave").click(function(){
        
    });
    $("img[data-id=activo]").click(function(){
       
        alert("hola");
    });
    $("img[data-id=desactivado]").click(function(){
        
        alert("hola inactivo");
    });
});


function Alerta(visible, color,mensaje){
    $("#Alerta").text(mensaje);
    $("#Alerta").css({'display':visible,'color':color});
    
    setTimeout(function(){
        $("#Alerta").hide();
    },15000)
}

function Limpiar(){
    $("form")[0].reset();
    
}

////////////////////////////////////////////////////////////////////////////////////////////////

window.history.go(1); 
		document.oncontextmenu = function() 
			{  
				return false; 
			}		 
		document.onkeydown = function() 
		{  
			if(window.event && window.event.keyCode == 116) 
				{ 
					window.event.keyCode = 505;  
				} 
			if(window.event && window.event.keyCode == 505) 
				{  
					return false;     
				}			  			 
		}   


function Alerta(visible, color) 
		{ 
			document.getElementById("Alerta").style.visibility = visible; 
			document.getElementById("Alerta").style.color = color;	 
			setTimeout("LimpiarMsg()",3000); 
		} 
	 
	function LimpiarMsg() 
		{ 
			document.getElementById("Alerta").style.visibility = "hidden"; 
		} 
		 
	function Recargar(cve_materia_frances) 
		{ 
			 
			document.forma.yCveMateriaFrances.value = cve_materia_frances; 

			document.forma.yAccion.value = "Recargar"; 
			document.forma.submit(); 
		} 
		
	function Activar(cve_materia_frances, activo) 
		{ 
			document.forma.yCveMateriaFrances.value = cve_materia_frances; 
			document.forma.yActivo.value = activo; 
			
			document.forma.yAccion.value = "Activar"; 
			document.forma.submit(); 
		} 
		 
	function Guardar() 
	  { 
		
		if(document.forma.xNombre.value=="-")
		   	{
				alert("debes proporcionar un nombre");
				document.forma.xNombre.focus();
				return;
			}
		
		document.forma.yAccion.value = "Guardar"; 
		document.forma.submit(); 
	  } 
	  
	function Limpiar() 
	  {
		document.forma.yAccion.value = "Nuevo"; 
		document.forma.submit(); 
	  }








        
