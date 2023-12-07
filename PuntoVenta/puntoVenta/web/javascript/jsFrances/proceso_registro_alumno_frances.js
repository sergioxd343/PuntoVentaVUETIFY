/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
$dl.vPi = "../../../images/dload_estilo_1.gif";

	 var tip;
     var dialogF;
	 $jq(document).ready(function(){

		 CrearCalendario();

		dialogF =  $jq('#mensajePagina').dialog({
				closeOnEscape: false,
				autoOpen: false,
				modal: true,
				draggable: false,
				resizable: false,
				width: 1000,
				height: 550,
				show: 'blind',
				closeText: 'Cerrar Muestra'
			});

		 $jq(".btnFlotantes").removeClass("btnFlotantes-show").addClass("btnFlotantes-show");

		 function CrearCalendario(){
			$jq(".datepicker").datepicker({
				dayNamesMin: [ "Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sa" ],
				monthNames:["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"],
				monthNamesShort: ["Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"],
				changeMonth:false,
				changeYear:false,
				dateFormat: 'dd-mm-yy',
				onSelect: function(dateText, inst) {
					var lockDate = new Date($jq('#xFechaInicio').datepicker('getDate'));
					$jq('#xFechaFin').datepicker('option', 'minDate', lockDate);
				}
			});
			}

		 function title()
			{
				$jq("*[botonAgregar]").each(function(){
				$jq(this).qtip({
					position: {
						my: 'top center',
						at: 'bottom center',
						adjust: {
							x: 2
						},
						viewport: $jq(window)
					},
					show: {
						effect: function(offset) {
							$jq(this).slideDown(100);
						}
					},
					hide: {
						effect: function(offset) {
							$jq(this).slideUp(100);
						}
					},
					style: {
						classes: 'ui-tooltip-blue ui-tooltip-shadow ui-tooltip-rounded'
					}
				});
			});
			}
			title();

		 $jq('#mensajePagina').dialog({
				closeOnEscape: false,
				autoOpen: false,
				modal: true,
				draggable: false,
				resizable: false,
				width: 1000,
				height: 550,
				show: 'blind',
				hide: 'clip',
				closeText: 'Cerrar Imprimir'
			});

			$jq('#mensajePagina2').dialog({
				closeOnEscape: false,
				autoOpen: false,
				modal: true,
				draggable: false,
				resizable: false,
				width: 1000,
				height: 550,
				show: 'blind',
				hide: 'clip',
				closeText: 'Cerrar Asignar Alumnos'
			});


			$jq("*[AsignarF]").each(function(){
				$jq(this).click(function(){

				var materia=document.getElementById("xMateria");

				if(materia.value=="0")
				{
					$jq.dMsgUp({mensaje: "Debe seleccionar una materia" });
					$jq.dMsgUp("open");
					setTimeout(function(){$jq.dMsgUp("close");}, 3000);
					materia.focus();
					return;
				}

				var liga = "ajax/proceso_registrar_alumno_convocatoria.jsp?yMateria="+materia.value+"&yNivel="+$jq(this).attr("Cve_nivel_frances")+"&yMatricula="+$jq(this).attr("UsuarioC")+"&yCve_convocatoria="+$jq(this).attr("Cve_Convocatoria");
				//alert("Liga: " + liga);
				$jq.ajax({
				url: liga,
				type: "post",
				dataType: "html",
				cache: false,
				contentType: false,
				processData: false,
				success: function(data){
					data = $jq.trim(data);
					if(data.substr(0,5)=="ERROR")
					{
						$jq.dMsgUp({mensaje: "upss! algo sali&oacute; mal al guardar."});
						$jq.dMsgUp("open");
					}
					else
					{
						$jq.dMsgUp({mensaje: data });
						$jq.dMsgUp("open");
					}
				},
				error: function(request, error){
					$jq.dMsgUp({mensaje: "upss! se ha producido un error al procesar la petici&oacute;n."+error});
					$jq.dMsgUp("open");
					$jq.dMsgUp({mensaje: request.responseText});
				},
				complete: function(){
					setTimeout(function(){$jq.dMsgUp("close");}, 3000);
					setTimeout(function(){document.forma.submit();},4000);
				}
			});
				//alert("El contador es: " + contador + " y la matricula: " + matricula);
			});
			});

	 });

	function Existe()
	{
		$jq.dMsgUp({mensaje: "Ya se registro en una convocatoria" });
		$jq.dMsgUp("open");
		//setTimeout(function(){$jq.dMsgUp("close");}, 5000);
	}
	function Bloquear()
	{
		$jq.dMsgUp({mensaje: "No pudes visualizar esta informacion, puesto no tienes grupo de frances" });
		$jq.dMsgUp("open");
		//setTimeout(function(){$jq.dMsgUp("close");}, 5000);
	}
