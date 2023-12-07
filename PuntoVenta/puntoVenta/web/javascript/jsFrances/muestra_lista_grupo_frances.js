/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
$dl.vPi = "../../../images/dload_estilo_1.gif";
var tip;	 
	 $jq(document).ready(function(){
		 
		 function title()
			{
				$jq("*[botonAgregar]").each(function(){
				 tip=$jq(this).qtip({
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
			document.forma.xFiltro.value = "";
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

	function Actualizar(grupo, cve_grupo_materia_frances)
		{
			var docente=document.getElementById("xEmpleado").value;
			var materia=document.getElementById("xMateria").value;
			var aula=document.getElementById("xAula").value;
			var horario=document.getElementById("xHorario").value;
			
			$jq.ajax({
			url: "ajax/proceso_datos_grupo_frances.jsp?yAccion=Actualizar&yDocente="+docente+"&yMateria="+materia+"&yAula="+aula+"&yHorario="+horario+"&yGrupo="+grupo+"&yCve_grupo_materia_frances="+cve_grupo_materia_frances,
			type: "post",
			dataType: "html",
			cache: false,
			contentType: false,
			processData: false,
			success: function(data){
				data = $jq.trim(data);
				if(data.substr(0,5)=="ERROR")
				{
					$jq.dMsgUp({mensaje: "upss! algo sali&oacute; mal al Actualizar."});
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
	
	function Guardar(grupo)
		{
			var docente=document.getElementById("xEmpleado").value;
			var materia=document.getElementById("xMateria").value;
			var aula=document.getElementById("xAula").value;
			var horario=document.getElementById("xHorario").value;
			
			
			if(docente=="0")
			{
				alert("Debe seleccionar un docente");
				document.getElementById("xEmpleado").focus();
				return;
			}
			
			if(materia=="0")
			{
				alert("Debe seleccionar una materia");
				document.getElementById("xMateria").focus();
				return;
			}
			
			if(aula=="0")
			{
				alert("Debe seleccionar una aula");
				document.getElementById("xAula").focus();
				return;
			}
			
			if(horario=="0")
			{
				alert("Debe seleccionar un horario");
				document.getElementById("xHorario").focus();
				return;
			}
			
			$jq.ajax({
			url: "ajax/proceso_datos_grupo_frances.jsp?yAccion=Guardar&yDocente="+docente+"&yMateria="+materia+"&yAula="+aula+"&yHorario="+horario+"&yGrupo="+grupo,
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
		
		function Imprimir()
		{
			var cont=document.forma.yContador.value;
			$jq("*[botonAgregar]").hide();
			$jq(".ui-tooltip-blue").hide();
			$jq(".Botton_Grupo").hide();
			//Ocultar(cont);
			window.print();
			//setTimeout("Mostrar("+cont+")",1000);
			
		}