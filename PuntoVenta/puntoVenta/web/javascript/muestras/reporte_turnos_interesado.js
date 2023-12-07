/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function(){
    $("#xTrGenerar").hide();
    CrearCalendario();
    $("#xReporte").click(function(){
        GenerarReporte();
    });
    seleccionar_unidad();
    seleccionar_convocatoria();
});

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

function GenerarReporte(){
    
    $("#yAccion").val(1);
    $("form#forma").submit();
}

function Abrir_Datos(path,nombre)
{
    
    $("#xTrGenerar").show();
    var pagina = "../../proceso_exportacion_excel.jsp?xParametro1="+nombre ;
    var vWinPres = window.open(pagina, "Excel", "width=790, height=590, status=yes, directories=no, scrollbars=yes, resizable=no, top=0, left=0 , menubar=yes");
    
}

//noty
function generate(type,info) {
        var n = noty({
            text        : info,
            type        : type,
            dismissQueue: true,
            modal       : true,
            layout      : 'top',
            theme       : 'defaultTheme',
            maxVisible  : 10,
			animation: {
			open: {height: 'toggle'},
			close: {height: 'toggle'},
			easing: 'swing',
			speed: 500 // opening & closing animation speed
			},
			buttons: [
			{
                            addClass: 'btn btn-primary', text: 'Continuar', onClick: function($noty) {
			
			// this = button element
			// $noty = $noty element
			
			$noty.close();
			//noty({text: 'You clicked "Ok" button', type: 'success'});
			}
			}
			]
        });
        console.log('html: ' + n.options.id);
		/*setTimeout(function () {
            n.close();
        }, 2000);*/
    }

function seleccionar_unidad(){
    $("#xUnidadAcademica").on("change",function(){
        
        $("#forma").submit();
    });
    
}

function seleccionar_convocatoria(){
    $("#xConvocatoria").on("change",function(){
        
        if(parseInt($("#xConvocatoria").find('option:selected').val())>0){
            $("#xTrGenerar").show();
        }else{
            $("#xTrGenerar").hide();
        }
        
    });
    
}