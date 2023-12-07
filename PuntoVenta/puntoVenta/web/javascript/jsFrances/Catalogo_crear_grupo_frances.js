/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function(){
    /** Calendario **/
    CrearCalendario();
    
    /*
     * Acciones por botón
    */
    $("#xNuevo").click(function(){
        Alerta('visible', '#008000','Nuevo registro');
        Limpiar();
    });
	
    $("#xGuardar").click(function()
	{
        Alerta('visible', '#008000','Guardar nuevo registro');
		
		if(parseInt($("#Guardar").attr("data-type")) == 0){
			Guardar();
		}else{
			Modificar();
		}
		
		
		
    });
    $("#xEliminar").click(function(){
        Alerta('visible', '#FF0000','Eliminar registro');
    });
    $("#xBuscar").click(function(){
        Alerta('visible', '#008000', 'Buscar registro');
    });
	$("#xCargar").click(function(){
        Alerta('visible', '#008000', 'Cargar registro');
		Cargar();
    });
    $("#xClave").click(function(){
        
    });
});

function CrearCalendario(){
    $(".datepicker").datepicker({
        dayNamesMin: [ "Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sa" ],
        monthNames:["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"],
        monthNamesShort: ["Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"],
        changeMonth:false,
        changeYear:false,
        dateFormat: 'dd-mm-yy',
        onSelect: function(dateText, inst) {
            var lockDate = new Date($('#xFechaInicio').datepicker('getDate'));
            $('#xFechaFin').datepicker('option', 'minDate', lockDate);
        }
    });
}

function Alerta(visible, color,mensaje){
    $("#Alerta").text(mensaje);
    $("#Alerta").css({'display':visible,'color':color});
    
    setTimeout(function(){
        $("#Alerta").hide();
    },15000)
}

function Limpiar(){
	$("#yCve_periodo").val(0);
	$("#xFechaInicio").val("");
	$("#xFechaFin").val("");
	$("#xParcial").val(0);
	$("#yAccion").val(""); 
}

function Guardar()
{
	$("#yAccion").val("1");
	
	$("form").submit();
}

function Cargar(Scve_periodo_captura_frances)
{
	$("#yCve_periodo_captura_frances").val(Scve_periodo_captura_frances);
	$("#yAccion").val("2");
	
	$("form").submit();
}
        
function Modificar()
{
	$("#yAccion").val("3");
	
	$("form").submit();
}

function Activar(Scve_periodo_captura_frances, activo)
{
	$("#yCve_periodo_captura_frances").val(Scve_periodo_captura_frances);
	$("#yActivo").val(activo);
	
	$("#yAccion").val("5");
	
	$("form").submit();
}