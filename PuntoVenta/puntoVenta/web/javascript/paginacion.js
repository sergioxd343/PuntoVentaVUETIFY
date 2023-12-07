	function Paginacion(pagina, paginacion)
		{
			if(document.getElementById("cargando")==null)
				{
						var div_cargando;
						
						 div_cargando=document.createElement('DIV');
						 div_cargando.className='cargandoDiv';
						 div_cargando.id='cargando';
						
						var ruta = document.forma.yRuta.value;
						
						div_cargando.innerHTML = "<img src='"+ruta+"images/ajax-loader.gif' /><br>Cargando.....";
						
						document.body.appendChild(div_cargando);
				}
			else
				{
					document.getElementById("cargando").style.display = '';
				}
			Paginacion2(pagina, paginacion);
		}
		
	function Paginacion2(pagina, paginacion)
		{
			
			if(pagina!="<" && pagina!=">")
				{
					document.forma.yPagSeleccionada.value=pagina;
				}

			if(pagina=="<" && parseInt(document.forma.yPagSeleccionada.value) > 1)
				{
					pagina =  parseInt(document.forma.yPagSeleccionada.value) - 1;
					document.forma.yPagSeleccionada.value=pagina;
				}
				
			else if(pagina=="<" && parseInt(document.forma.yPagSeleccionada.value) == 1)
				{
					pagina=1;
				}
				
			if(pagina==">" && parseInt(document.forma.yPagSeleccionada.value) < parseInt(document.forma.yNumPag.value))
				{
					pagina =  parseInt(document.forma.yPagSeleccionada.value) + 1;
					document.forma.yPagSeleccionada.value=pagina;
				}
				
			else if(pagina==">" && parseInt(document.forma.yPagSeleccionada.value) == parseInt(document.forma.yNumPag.value))
				{
					pagina=document.forma.yNumPag.value;
				}

			for(var p=1; p <= eval(document.forma.yNumPag.value);p++ )
				{
					var etiqueta = document.getElementById("xPag"+p);
					etiqueta.className="CeldaOpcion";
				}
			
			if(pagina > 1)
				{
					document.getElementById("FI").style.display="";
					document.getElementById("FI2").style.display="";
				}
			else
				{
					document.getElementById("FI").style.display="none";
					document.getElementById("FI2").style.display="none";
				}
			if(pagina >= document.forma.yNumPag.value)
				{
					document.getElementById("FD").style.display="none";
					document.getElementById("FD2").style.display="none";
				}
			else
				{
					document.getElementById("FD").style.display="";
					document.getElementById("FD2").style.display="";
				}
				
			var pD 	= parseInt(document.forma.yNumPag.value);
			var NI  = parseInt(pagina)-(parseInt(document.forma.yNumNumeración.value) / 2);
			var NF  = parseInt(pagina)+(parseInt(document.forma.yNumNumeración.value) / 2);
			
						
			if(parseInt(NI) < 1 )
				NF = parseInt(document.forma.yNumNumeración.value);//(NF - (NI)) + 1;
			
			if(parseInt(NF) > pD)
				NI = NI - ((NF-pD) - 1 );
			
			for(var c = 1; c <= eval(pD); c++ )
				{
					var fila = document.getElementById("Num"+c);
					if(eval(c) >= eval(NI) && eval(c) <= eval(NF))
						{
							fila.style.display="";
						}
					else
						{
							fila.style.display="none";
						}
				}
				
			var numero = document.getElementById("xPag"+pagina);
			numero.className="CeldaPagina";
			
			//movimiento de paginas
			var numeroIni = (parseInt(paginacion) * parseInt(pagina-1) ) + 1;
			//alert(numeroIni);
			var numeroFin = (parseInt(numeroIni) + parseInt(paginacion - 1));
			if(numeroFin > parseInt(document.forma.yNumRegistros.value))
				numeroFin=document.forma.yNumRegistros.value;
			
			for(var c=1 ; c <= parseInt(document.forma.yNumRegistros.value); c++)
				{
					var fila=document.getElementById("xFila"+c);
					fila.style.display="none";
				}
			
			for(var cont = numeroIni ; cont <= numeroFin ; cont++ )
				{
					var fila=document.getElementById("xFila"+cont);
					fila.style.display="";
				}			
				
			setTimeout("quitar()",1000);
				
		}	
	function quitar()
		{
			document.getElementById("cargando").style.display = 'none';			
		}
		//------------------------------------------------------------------------------------------