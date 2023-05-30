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

			function title_red()
					{
						$jq("*[botonEliminar]").each(function(){
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
								classes: 'ui-tooltip-red ui-tooltip-shadow ui-tooltip-rounded'
							}
						});
					});
					}
					title_red();

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

			$jq("*[Alumnos_f]").each(function(){
				$jq(this).click(function(){
					$jq("#mensajePagina").dialog("open");
					$jq("#o_ImgCarga").show();//xFechaIni xFechaFin  xTiempo xUnidad xPeriodo
					$jq("#contenido_pagina").attr('src', 'muestra_alumnos_frances.jsp?xU='+$jq(this).attr("CveUnidad")+'&xP='+$jq(this).attr("CvePeriodo")+'&xPeriodo='+$jq(this).attr("Nperiodo")+'&xT='+$jq(this).attr("TurnoL")+'&xG='+$jq(this).attr("cve_grupo_frances")+'&xB=1').load(function(){$jq("#o_ImgCarga").hide();});
				});
			});

			$jq("*[Lista_a]").each(function(){
				$jq(this).click(function(){
					//alert("Juan" + $jq(this).attr("CveUnidad"));
					$jq("#mensajePagina2").dialog("open");
					$jq("#o_ImgCarga").show();//xFechaIni xFechaFin  xTiempo xUnidad
					$jq("#contenido_pagina2").attr('src', 'muestra_alumno_frances.jsp?xU='+$jq(this).attr("CveUnidad")+'&xP='+$jq(this).attr("CvePeriodo")+'&nP='+$jq(this).attr("Nperiodo")+'&xT='+$jq(this).attr("TurnoL")).load(function(){$jq("#o_ImgCarga").hide();});
				});
			});

	 });