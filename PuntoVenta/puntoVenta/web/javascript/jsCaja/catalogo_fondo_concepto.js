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
	function Buscar_solicitud()
	{
		var control = "xMateria";
		var control2 = "yCve_materia_frances";
		dialogF.dialog("open");
		$jq("#o_ImgCarga").show();//xFechaIni xFechaFin  xTiempo xUnidad xPeriodo
		$jq("#contenido_pagina").attr('src', 'muestra_materia_frances.jsp?xControl=' + control + '&xControl2=' + control2 ).load(function(){$jq("#o_ImgCarga").hide();});

		/*var pagina = "muestra_cambio_calificacion.jsp?xControl=" + control;
		var vWinPres = window.open(pagina, "Muestra", "width=700, height=450, status=yes, directories=no, scrollbars=yes, resizable=no, top=0, left=0");
		vWinPres.opener = self;*/
	}
	function Guardar(cve_concepto, contador, existe)
	{
		var cuentaBancaria=document.getElementById("xCuentaB"+contador);
		var fondo=document.getElementById("xFondo"+contador);
		var accion = "";
		//alert("Hola" + existe)
		if(existe === 0)
		{
			accion = "Guardar"
		}
		else {
			accion = "Actualizar";
		}
		if(cuentaBancaria.value == "")
		{
			$jq.dMsgUp({mensaje: "Debe proporcionar cuenta bancaria"});
			$jq.dMsgUp("open");
			setTimeout(function(){$jq.dMsgUp("close");}, 3000);

			cuentaBancaria.focus();
			return;
		}
		if(fondo.value == "")
		{
			$jq.dMsgUp({mensaje: "Debe proporcionar el fondo"});
			$jq.dMsgUp("open");
			setTimeout(function(){$jq.dMsgUp("close");}, 3000);

			fondo.focus();
			return;
		}
		//calificacion, docente, cve_grupo_materia_frances, periodo, coordinador, parcial, matricula, motivo, nueva_calificacion, fecha
		var direccion = "ajax/dao_fondo_concepto.jsp?yCve_concepto="+cve_concepto+"&yCuenta_bancaria="+cuentaBancaria.value+"&yFondo="+fondo.value+"&yAccion="+accion;
		//alert("Liga: " + direccion);
		$jq.ajax({
			url: direccion,
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
	}

	function Eliminar(cve_materia_plan_estudio_frances)
	{

		//calificacion, docente, cve_grupo_materia_frances, periodo, coordinador, parcial, matricula, motivo, nueva_calificacion, fecha
		var direccion = "ajax/proceso_materia_plan_estudio.jsp?yCve_materia_plan="+cve_materia_plan_estudio_frances+"&yAccion=Eliminar";
		//alert("Liga: " + direccion);
		$jq.ajax({
			url: direccion,
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
	}

	function Actualizar(solicitud, calificacion, docente, cve_grupo_materia_frances, periodo, coordinador, parcial, matricula, cve_alumno_grupo_frances)
	{
		var motivo=document.getElementById("xMotivo").value;
		var nueva_calificacion=document.getElementById("xNuevaCalficacion").value;
		var fecha = document.getElementById("xFechaCambio").value;
		if(motivo == "")
		{
			$jq.dMsgUp({mensaje: "Debe proporcionar un motivo"});
			$jq.dMsgUp("open");
			setTimeout(function(){$jq.dMsgUp("close");}, 3000);

			document.forma.xMotivo.focus();
			return;
		}
		if(nueva_calificacion <= 0.0)
		{
			$jq.dMsgUp({mensaje: "La Calificacion debe ser mayor a 0"});
			$jq.dMsgUp("open");
			setTimeout(function(){$jq.dMsgUp("close");}, 3000);

			document.forma.xNuevaCalficacion.focus();
			return;
		}
		//calificacion, docente, cve_grupo_materia_frances, periodo, coordinador, parcial, matricula, motivo, nueva_calificacion, fecha
		var direccion = "ajax/proceso_cambio_calificacion.jsp?yCve_alumno_grupo_frances="+cve_alumno_grupo_frances+"&yCve_cambio_calificacion_frances="+solicitud+"&yDocente="+docente+"&yCve_grupo_materia_frances="+cve_grupo_materia_frances+"&yMotivo="+motivo+"&yFecha="+fecha+"&yCalificacion="+calificacion+"&yNuevaCalificacion="+nueva_calificacion+"&yPeriodo="+periodo+"&yCoordinador="+coordinador+"&yNumeroParcial="+parcial+"&yMatricula="+matricula+"&yAccion=Actualizar";
		//alert("Liga: " + direccion);
		$jq.ajax({
			url: direccion,
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
				setTimeout(function(){$jq.dMsgUp("close");}, 10000);
				setTimeout(function(){document.forma.submit();},4000);
			}

		});
	}

	function Nuevo()
	{
		document.forma.yAccion.value = "Nuevo";
		document.forma.submit();
	}
	function Recargar_Materia()
	  {
		  document.forma.yAccion.value = "Recargar_Materia";
		  document.forma.submit();
	  }

	function Docente_Recargar()
	  {
	  	  if ((Trim(document.forma.xDocente.value)) == "-" || Trim(document.forma.xDocente.value).length <= 0)
		    {
				alert("La clave del profesor es necesaria");
				document.forma.xDocente.focus();
				return;
			}
	  	  document.forma.xCargadoP.value = "1";
		  document.forma.yAccion.value = "Recargar_Profesor";
		  document.forma.submit();
	  }
	function CalificacionAnterior()
	{
		document.forma.yAccion.value = "CalificacionAnterior";
		  document.forma.submit();
	}

	function Recargar_Solicitud()
	  {
	  	  document.forma.yAccion.value = "Solicitud_Recargar";
		  document.forma.submit();
	  }

	function Buscar_Alumno(control)
	{
		dialogF.dialog("open");
		$jq("#o_ImgCarga").show();//xFechaIni xFechaFin  xTiempo xUnidad xPeriodo
		$jq("#contenido_pagina").attr('src', 'muestra_alumnos_frances.jsp?xControl=' + control + '&yBanderaF=1').load(function(){$jq("#o_ImgCarga").hide();});
	}

	function Captura_Tardia_Buscar(control, docente, control2, fecha){
		//var pagina = "muestra_captura_tardia.jsp?xControl=" + control +"&xDocente=" + docente +"&xControl2=" + control2 +"&xFecha=" + fecha;

		dialogF.dialog("open");
		$jq("#o_ImgCarga").show();//xFechaIni xFechaFin  xTiempo xUnidad xPeriodo
		$jq("#contenido_pagina").attr('src', 'muestra_captura_tardia.jsp?xControl=' + control +'&xDocente=' + docente +'&xControl2=' + control2 +'&xFecha=' + fecha).load(function(){$jq("#o_ImgCarga").hide();});

		//var vWinPres = window.open(pagina, "Muestra", "width=700, height=450, status=yes, directories=no, scrollbars=yes, resizable=no, top=0, left=0");
		//vWinPres.opener = self;
		}

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
