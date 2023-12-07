/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
$dl.vPi = "../../../images/dload_estilo_1.gif";

	 $jq(document).ready(function(){

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
				closeText: 'Cerrar Imprimir'
			});

			$jq("*[Alumnos_f]").each(function(){
				$jq(this).click(function(){
					CambiarPorLista();
				});
			});

			$jq("*[Lista_a]").each(function(){
				$jq(this).click(function(){
					alert(document.forma.xFiltro.value);
					if(document.forma.xFiltro.value == "")
					{
						alert("Debe proporcionar un valor");
						return;
					}
					document.forma.submit();
					//alert("Juan" + $jq(this).attr("CveUnidad"));
					//$jq("#mensajePagina2").dialog("open");
					//$jq("#o_ImgCarga").show();//xFechaIni xFechaFin  xTiempo xUnidad
					//$jq("#contenido_pagina2").attr('src', 'muestra_alumno_frances.jsp?xU='+$jq(this).attr("CveUnidad")+'&xP='+$jq(this).attr("CvePeriodo")+'&nP='+$jq(this).attr("Nperiodo")+'&xT='+$jq(this).attr("TurnoL")).load(function(){$jq("#o_ImgCarga").hide();});
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


		function Recargar()
		{
			window.opener.document.forma.submit();
		}

	function Alerta(visible, color)
		{
			document.getElementById("Alerta").style.visibility = visible;
			document.getElementById("Alerta").style.color = color;
		}
	function CambiarPorLista()
		{
			var guardar = 0;
			for(var c = 1; c <= eval(document.forma.yContador.value);c++)
				{
					var grupo = document.getElementById("xGrupo"+c);
					if(grupo!= null && grupo.value != "0" )
						{
							guardar = 1;
							break;
						}
				}
			if(guardar == 1)
				{
					if(confirm("¿Realmente deseas cambiar (al / los) alumno(s) de grupo?   "))
						{
							document.forma.yAccion.value = "Cambiar";
							document.forma.submit();
						}
				}
			else
				{
					alert("Debe seleccionar almenos un grupo para cambiar al alumno de la lista");
				}
		}

	function Cambiar(fila)
		{
			var grupo=document.getElementById("xGrupo"+fila);
			if(grupo.value==0)
				{
					alert("Debes seleccionar el grupo ");
					grupo.focus();
					return;
				}
			if(confirm("¿Realmente deseas cambiar al alumno de grupo?   "))
				{
					document.forma.yFila.value = fila;
					document.forma.yAccion.value = "Cambiar";
					document.forma.submit();
				}
		}

	function Cambiar_Texto()
		{
			if( document.forma.xFiltro != null)
			{
			var filtro = document.forma.xFiltro;
			filtro.value = "";
		  }

			document.forma.yPagina.value = "1";
			document.forma.submit();
		}

	function Muestra_Recargar()
		{
			//document.forma.yOrden.value = orden;
			document.forma.yPagina.value = "1";
			document.forma.submit();
		}

	function Muestra_Pagina(pagina)
		{
			document.forma.yPagina.value = pagina;
			document.forma.submit();
		}

	function Muestra_Orden(orden)
		{
			if (document.forma.yOrden.value == orden)
				document.forma.yTipoOrden.value = (document.forma.yTipoOrden.value=="ASC"?"DESC":"ASC");

			document.forma.yOrden.value = orden;
			document.forma.submit();
		}
	function ocultar(chk, fila)
		{
			if (chk == false)
				{
					document.getElementById("xGrupo"+fila).style.display = "none";
					document.getElementById("Grupo"+fila).style.display = "";
				}
			else
				{
					document.getElementById("xGrupo"+fila).style.display = "";
					document.getElementById("Grupo"+fila).style.display = "none";
				}

		}
	function Agregar(contador, matricula, grupo_a)
		{
			var grupo=document.getElementById("xGrupo"+contador).value;
			if(grupo=="0")
			{
				alert("Debe seleccionar un grupo");
				document.getElementById("xGrupo"+contador).focus();
				return;
			}

			//alert("nuevo grupo: " + grupo + " grupo actual " + grupo_a)

			$jq.ajax({
			url: "ajax/proceso_asignar_alumno.jsp?yCve_grupo="+grupo+"&yMatricula="+matricula+"&yGrupoA="+grupo_a,
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
		}
