
/*
 * Titulo                 : mensajes_sweetalert.js
 * Descripción            : para controlar los mensages de los nuevas plantillas
 * Compañía               :
 * Fecha de creación      : 22-06-2017
 * Desarrollador          : José Antonio García Jaramillo
 * Versión                : 1.0
 * ID Requerimiento       :
 */

/**********************************************
 * Metodos mensajes
 **********************************************/

function Mensaje() {
}

Mensaje.prototype.preloader = function (ruta) {
   swal({
        allowOutsideClick: false,
        imageUrl: ruta + 'images/Logo_utl_animado.gif',
        showConfirmButton: false
    });
};

Mensaje.prototype.guardar = function () {
   var obj = swal({
        type: 'success',
        title: 'Guardar',
        text: 'El registro se ha guardado correctamente',
        confirmButtonText: 'Aceptar',
        showLoaderOnConfirm: true,
        allowOutsideClick: false
    });
	return obj;
};

Mensaje.prototype.errorGuardar = function () {
    var obj = swal({
        type: 'error',
        title: 'Guardar',
        text: 'Error al guardar el registro',
        confirmButtonText: 'Aceptar',
        showLoaderOnConfirm: true,
        allowOutsideClick: false
    });
	return obj;
};

Mensaje.prototype.actualizar = function () {
   var obj =  swal({
        type: 'success',
        title: 'Actualizar',
        text: 'El registro se ha actualizado correctamente',
        confirmButtonText: 'Aceptar',
        showLoaderOnConfirm: true,
        allowOutsideClick: false
    });
	return obj;
};

Mensaje.prototype.errorActualizar = function () {
    var obj = swal({
        type: 'error',
        title: 'Actualizar',
        text: 'Error al actualizar el registro',
        confirmButtonText: 'Aceptar',
        showLoaderOnConfirm: true,
        allowOutsideClick: false
    });
	return obj;
};

Mensaje.prototype.eliminar = function () {
    var obj = swal({
        type: 'success',
        title: 'Eliminar',
        text: 'El registro se ha eliminado correctamente',
        confirmButtonText: 'Aceptar',
        showLoaderOnConfirm: true,
        allowOutsideClick: false
    });
	return obj;
};

Mensaje.prototype.errorEliminar = function () {
    var obj = swal({
        type: 'error',
        title: 'Eliminar',
        text: 'Error al eliminar el registro',
        confirmButtonText: 'Aceptar',
        showLoaderOnConfirm: true,
        allowOutsideClick: false
    });
	return obj;
};

Mensaje.prototype.aviso = function (texto) {
    var obj = swal({
        type: 'info',
        title: 'Aviso',
        text: texto,
        confirmButtonText: 'Aceptar',
        showLoaderOnConfirm: true,
        allowOutsideClick: false
    });
	return obj;
};

Mensaje.prototype.avisoBloqueo = function (texto) {
    var obj = swal({
        type: 'info',
        title: 'Aviso',
        text: texto,
		showConfirmButton: false,
        //confirmButtonText: 'Aceptar',
        //showLoaderOnConfirm: true,
        allowOutsideClick: false
    });
	return obj;
};

Mensaje.prototype.general = function (texto,title,tipo) {
    var obj = swal({
        type: tipo,
        title: title,
        text: texto,
        confirmButtonText: 'Aceptar',
        showLoaderOnConfirm: true,
        allowOutsideClick: false
    });
	return obj;
};

Mensaje.prototype.avisoW = function (texto) {
    var obj = swal({
        type: 'warning',
        title: 'Aviso',
        text: texto,
        confirmButtonText: 'Aceptar',
        showLoaderOnConfirm: true,
        allowOutsideClick: false
    });
	return obj;
};

Mensaje.prototype.confirmar = function (texto) {
    var obj = swal({
        type: "warning",

  		confirmButtonColor: '#5cb85c',
  		cancelButtonColor: '#d33',
        text: texto,
        confirmButtonText: 'Aceptar',
		cancelButtonText: "Cancelar",
        showLoaderOnConfirm: true,
		showCancelButton: true,
        allowOutsideClick: false
    });
	return obj;
};

Mensaje.prototype.aceptar = function (texto) {
    var obj = swal({
        type: "success",

  		confirmButtonColor: '#5cb85c',
  		cancelButtonColor: '#d33',
        text: texto,
        confirmButtonText: 'Aceptar',
        showLoaderOnConfirm: true,
        allowOutsideClick: false
    });
	return obj;
};

Mensaje.prototype.avisoBloqueoC = function (texto) {
    var obj = swal({
        type: 'info',
        title: 'Aviso',
        text: texto,
		showConfirmButton: true,
        confirmButtonText: 'Aceptar',
        //showLoaderOnConfirm: true,
        allowOutsideClick: false
    });
	return obj;
};

Mensaje.prototype.avisoBloqueoSB = function (texto) {
    var obj = swal({
        type: 'warning',
        title: 'Aviso',
        text: texto,
		showConfirmButton: false,
        confirmButtonText: 'Aceptar',
        //showLoaderOnConfirm: true,
        allowOutsideClick: false
    });
	return obj;
};

Mensaje.prototype.cerrar = function () {
    swal.close();
};

Mensaje.prototype.HTML_m = function(texto)
{
  var obj = swal({
  title: 'Información',
  type: 'info',
  html:texto,
  focusConfirm: false,
  allowOutsideClick: false,
  confirmButtonText: 'Aceptar',
})
return obj;
};

/**
 * 
 * @returns {Traducción de la tabla a español}
 */
Mensaje.prototype.tDataTable = function(){
      //Traducción de la tabla a español
    return {
        "sProcessing": "Procesando...",
        "sLengthMenu": "Mostrar _MENU_ registros",
        "sZeroRecords": "No se encontraron resultados",
        "sEmptyTable": "Ningún hay datos disponibles",
        "sInfo": "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
        "sInfoEmpty": "Mostrando registros del 0 al 0 de un total de 0 registros",
        "sInfoFiltered": "(filtrado de un total de _MAX_ registros)",
        "sInfoPostFix": "",
        "sSearch": "Buscar:",
        "sUrl": "",
        "sInfoThousands": ",",
        "sLoadingRecords": "Cargando...",
        "oPaginate": {
            "sFirst": "Primero",
            "sLast": "Último",
            "sNext": "Siguiente",
            "sPrevious": "Anterior"
        },
        "oAria": {
            "sSortAscending": ": Activar para ordenar la columna de manera ascendente",
            "sSortDescending": ": Activar para ordenar la columna de manera descendente"
        }
    };
};

var mensaje = new Mensaje();
