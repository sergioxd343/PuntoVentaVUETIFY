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
	 
	 function Cargar(cve_grupo, cve_periodo, grupo, carrera, especialidad, unidad_academica, cve_docente, nombre_docente, periodo, tipo_encuesta, encuesta)
{
	//alert(grupo);
	dialogF.dialog("open");
	$jq("#o_ImgCarga").show();//xFechaIni xFechaFin  xTiempo xUnidad xPeriodo
	$jq("#contenido_pagina").attr('src', 'muestra_alumnos_reporte.jsp?xControl=' + cve_grupo + '&Cve_periodo=' + cve_periodo + '&Grupo=' + grupo + '&Carrera=' + carrera + '&Especialidad=' + especialidad + '&Unidad_academica=' + unidad_academica + '&Cve_docente=' + cve_docente + '&Nombre_docente=' + nombre_docente + '&Periodo=' + periodo + '&Cve_tipo_encuesta=' + tipo_encuesta + '&Encuesta=' + encuesta).load(function(){$jq("#o_ImgCarga").hide();});
}
function Imprimir_Listado()
{
	document.getElementById("gControles_B").style.display="none";
			$jq(".ui-tooltip-blue").hide();
	window.print();
	document.forma.submit();
}
function Imprimir()
{
	//document.forma.gControles.style.display = "none";
	//document.forma.gControles_I.style.display = "none";
	document.getElementById("gControl_L").style.display="none";
	//document.getElementById("gControles").style.display="none";
	document.getElementById("gControles_I").style.display="none";
			$jq(".ui-tooltip-blue").hide();
	window.print();
	document.forma.submit();
	
}


var id_reloj = null;
	var minutos, segundos, plus;
	//Inicializar relog
	function InicializarReloj(){minutos = 0;segundos = 0;plus = " . ";}
	//Mostrar el reloj
	function MostrarReloj()
	{
		
		segundos++;if(segundos>59){segundos = 0;minutos++;}
		plus += " . ";if(segundos%5 == 0){plus = " . ";}
		
		var mostrar = (minutos < 10) ? "0"+ minutos : minutos;
		mostrar += (segundos < 10) ? ":0"+ segundos : ":"+ segundos;
		$jq.dMsgUp({mensaje: "( "+ mostrar +" ) Se est&aacute; generando su archivo"+ plus});
		$jq.dMsgUp("open");
		id_reloj = setTimeout("MostrarReloj()", 100);
	}
	//Detener  reloj
	function DetenerReloj(){clearTimeout(id_reloj);}
	

/*** ----------INICIO Exportar---------- ***/
	function ExportarGrupos(cve_persona, cve_periodo, unidad_academica, cve_docente, nombre_docente, periodo, unidad, cve_tipo_encuesta)
	{
		//alert("Unidad_academica: " + unidad);
		InicializarReloj();
		MostrarReloj();
		$jq.ajax({
			type: "GET",
			url: "../encuestas/ajax/reporte_grupos_ajax.jsp?yAccion=Imprimir&Cve_persona=" + cve_persona + "&Cve_periodo=" + cve_periodo + "&Unidad_academica=" + unidad_academica + "&Cve_docente=" + cve_docente + "&Nombre_docente=" + nombre_docente + "&Periodo=" + periodo + "&Cve_tipo_encuesta=" + cve_tipo_encuesta,
			async: true,
			cache: false,
			success: function(data){
				data = $jq.trim(data);
				if(data.substr(0,5)=="ERROR")
				{
					$jq.dMsgUp({mensaje: "upss! algo sali&oacute; mal no se pudo generar el archivo."});
					$jq.dMsgUp("open");
				}
				else
				{
					$jq.dMsgUp({mensaje: "Se ha generado su archivo."}); Abrir_Datos(data, unidad);
					$jq.dMsgUp("open");
				}
			},
			error: function(request, error){
				$jq.dMsgUp({mensaje: "upss! se ha producido un error al procesar la petici&oacute;n."+error});
				$jq.dMsgUp("open");
				$jq.dMsgUp({mensaje: request.responseText});
			},
			complete: function(){
				DetenerReloj(); 
				setTimeout(function(){$jq.dMsgUp("close");}, 10000);
			}
		});
	}
	//Exportar Listado de Alumnos
	function ExportarListado(cve_grupo, cve_periodo, grupo, carrera, especialidad, unidad_academica, cve_docente, nombre_docente, periodo, unidad)
	{
		//alert("Unidad_academica: " + unidad);
		InicializarReloj();
		MostrarReloj();
		$jq.ajax({
			type: "GET",
			url: "../encuestas/ajax/reporte_alumnos_encuesta_ajax.jsp?yAccion=Imprimir&Cve_grupo=" + cve_grupo + "&Cve_periodo=" + cve_periodo + "&Unidad_academica=" + unidad_academica + "&Cve_docente=" + cve_docente + "&Nombre_docente=" + nombre_docente + "&Periodo=" + periodo + "&Grupo=" + grupo,
			async: true,
			cache: false,
			success: function(data){
				data = $jq.trim(data);
				if(data.substr(0,5)=="ERROR")
				{
					$jq.dMsgUp({mensaje: "upss! algo sali&oacute; mal no se pudo generar el archivo."});
					$jq.dMsgUp("open");
				}
				else
				{
					$jq.dMsgUp({mensaje: "Se ha generado su archivo."}); Abrir_Datos(data, unidad);
					$jq.dMsgUp("open");
				}
			},
			error: function(request, error){
				$jq.dMsgUp({mensaje: "upss! se ha producido un error al procesar la petici&oacute;n."+error});
				$jq.dMsgUp("open");
				$jq.dMsgUp({mensaje: request.responseText});
			},
			complete: function(){
				DetenerReloj(); 
				setTimeout(function(){$jq.dMsgUp("close");}, 10000);
			}
		});
	}
	
	function Abrir_Datos(path, unidad)
	{
		
		var pagina = "../proceso_exportacion_excel.jsp?xParametro1=" + unidad + ":\\ReportesExcel\\"+path;
		//alert(pagina);
		var vWinPres = window.open(pagina, "Ver", "width=500, height=100, statusbar=yes, directories=no, scrollbars=yes, resizable=no, top=300, left=300");
	}

	function Alerta_No_Registros()
	{
		$jq.dMsgUp({mensaje: "No se contienen datos en el periodo seleccionado."});
		$jq.dMsgUp("open");
		setTimeout(function(){$jq.dMsgUp("close");}, 10000);
	}