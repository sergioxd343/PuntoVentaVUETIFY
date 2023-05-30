/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
$dl.vPi = "../../../images/dload_estilo_1.gif";
	var dialogF;
	 $jq(document).ready(function(){

		 dialogF =  $jq('#mensajePagina').dialog({
				closeOnEscape: false,
				autoOpen: false,
				modal: true,
				draggable: false,
				resizable: false,
				width: 1000,
				height: 550,
				show: 'blind',
				hide: 'clip',
				closeText: 'Cerrar Muestra'
			});

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

			$jq("*[BuscarAlumno]").each(function(){
				$jq(this).click(function(){
					dialogF.dialog("open");
					$jq("#o_ImgCarga").show();//xFechaIni xFechaFin  xTiempo xUnidad xPeriodo
					$jq("#contenido_pagina").attr('src', 'muestra_lista_grupo_frances.jsp?xU='+$jq(this).attr("CveUnidad")+'&xP='+$jq(this).attr("CvePeriodo")+'&xPeriodo='+$jq(this).attr("Nperiodo")+'&xT='+$jq(this).attr("TurnoL")+'&xG='+$jq(this).attr("cve_grupo_frances")+'&xB=1').load(function(){$jq("#o_ImgCarga").hide();});
				});
			});
			
			
			
			

	 });


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
	function Alumno_Recargar()
	{
		var matricula=document.getElementById("xClaveAlumno");
		if(matricula.value.length <= 7)
				{
					alert("Debes Proporcionar una matricula");
					matricula.focus();
					return;
				}
		document.forma.yAccion.value = "Recargar_Datos";
		document.forma.submit();
	}
	function Guardar()
	{
		var matricula=document.getElementById("xClaveAlumno");
		var cedula = document.getElementById("xCedula");
		if(matricula.value.length <= 7)
				{
					alert("Debes Proporcionar una matricula");
					matricula.focus();
					return;
				}
		if(cedula.value.length <= 6)
		{
			alert("Debe Proporcionar una cedula valida");
			cedula.focus();
			return;
		}
		document.forma.yAccion.value = "Guardar";
		document.forma.submit();
	}
	function Actualizar()
	{

		document.forma.yAccion.value = "Actualizar";
		document.forma.submit();
	}
	function Alerta(info)
	{
		  $jq.dMsgUp({mensaje: info});
			$jq.dMsgUp("open");
			setTimeout(function(){$jq.dMsgUp("close");}, 3000);
	}
	
	function GuardarM(contador, persona, nivel)
			{
				
				//alert("Hi: " + contador + " - " + persona);
				
				var cedula=document.getElementById("xCedula"+contador);
				if(cedula.value=="-" || cedula.length == 1)
				{
				//alert("Debe Proporcionar informacion para la cedula");
				//cedula.focus();
				return;
				}
				
				//alert("nuevo grupo: " + grupo + " grupo actual " + grupo_a)
				
				$jq.ajax({
				url: "ajax/dao_cedula.jsp?yPersona="+persona+"&yNivel="+nivel+"&yCeneval="+cedula.value,
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
				//alert(data);
				if(data == "Guardado" || data == "Actualizado")
				{
					$jq("#xIcono" + contador).removeClass("fa fa-toggle-off fa-2x bottonG").addClass("fa fa-toggle-on fa-2x bottonV");//.attr("fa fa-toggle-off fa-2x bottonG","fa fa-toggle-on fa-2x bottonV");//
				}
				//$jq.dMsgUp({mensaje: data });
				//$jq.dMsgUp("open");
				}
				},
				error: function(request, error){
				$jq.dMsgUp({mensaje: "upss! se ha producido un error al procesar la petici&oacute;n."+error});
				$jq.dMsgUp("open");
				$jq.dMsgUp({mensaje: request.responseText});
				},
				complete: function(){
				//setTimeout(function(){$jq.dMsgUp("close");}, 3000);
				//setTimeout(function(){document.forma.submit();},4000);
				}
				});
			}