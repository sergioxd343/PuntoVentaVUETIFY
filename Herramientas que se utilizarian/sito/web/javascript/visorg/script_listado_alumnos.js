//Mensaje del sistema al usuario
function Alerta(visible,color)
{
    document.getElementById("Alerta").visibility = visible;
    document.getElementById("Alerta").style.color = color;
}

//Función para guardar la información en la bd
function Guardar()
{    
    document.getElementById("yAccion").value = "Guardar";
    document.forma.submit();    
}   

//Función para seleccionar todos los checkBox de agregar
function SeleccionarTodos()
{	
    var cant = document.getElementById("yTotalAlumnos").value;

    if(document.getElementById("xSeleccionarTodo").checked == true)
    {//Validar si el checkbox esta seleccionado
        for(var i=1; i<=cant; i++){// Ciclo para seleccionar todos los checkbox		 
            document.getElementById("xCheckAgregar"+i).checked=true; // Seleccionar todos los checkbox              
        }
    }
    else
    {		
        for(var x=1; x<=cant; x++){
            document.getElementById("xCheckAgregar"+x).checked=false;              
        }
    }
}    

//
function RecargaNueva(cant)
{
    window.opener.NumeroPersonas(cant);
    window.close();
}