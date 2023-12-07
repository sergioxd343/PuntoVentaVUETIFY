
/*
 * Titulo                 : mensajes_sweetalert_vue.js
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


   export function preloader(ruta) {
       swal.fire({
            allowOutsideClick: false,
            imageUrl: ruta + 'images/Logo_utl_animado.gif',
            showConfirmButton: false
        });
    }

   export function guardar() {
       let obj = swal.fire({
            type: 'success',
            title: 'Guardar',
            text: 'El registro se ha guardado correctamente',
            confirmButtonText: 'Aceptar',
            showLoaderOnConfirm: true,
            allowOutsideClick: false
        });
            return obj;
    }

    export function errorGuardar() {
        let obj = swal.fire({
            type: 'error',
            title: 'Guardar',
            text: 'Error al guardar el registro',
            confirmButtonText: 'Aceptar',
            showLoaderOnConfirm: true,
            allowOutsideClick: false
        });
            return obj;
    }

   export function actualizar() {
       let obj =  swal.fire({
            type: 'success',
            title: 'Actualizar',
            text: 'El registro se ha actualizado correctamente',
            confirmButtonText: 'Aceptar',
            showLoaderOnConfirm: true,
            allowOutsideClick: false
        });
            return obj;
    }

   export function errorActualizar() {
        let obj = swal.fire({
            type: 'error',
            title: 'Actualizar',
            text: 'Error al actualizar el registro',
            confirmButtonText: 'Aceptar',
            showLoaderOnConfirm: true,
            allowOutsideClick: false
        });
            return obj;
    }

   export function eliminar() {
        let obj = swal.fire({
            type: 'success',
            title: 'Eliminar',
            text: 'El registro se ha eliminado correctamente',
            confirmButtonText: 'Aceptar',
            showLoaderOnConfirm: true,
            allowOutsideClick: false
        });
            return obj;
    }

  export  function errorEliminar() {
        let obj = swal.fire({
            type: 'error',
            title: 'Eliminar',
            text: 'Error al eliminar el registro',
            confirmButtonText: 'Aceptar',
            showLoaderOnConfirm: true,
            allowOutsideClick: false
        });
            return obj;
    }

   export function aviso(texto) {
        let obj = swal.fire({
            type: 'info',
            title: 'Aviso',
            text: texto,
            confirmButtonText: 'Aceptar',
            showLoaderOnConfirm: true,
            allowOutsideClick: false
        });
            return obj;
    }

   export function avisoBloqueo(texto) {
        let obj = swal.fire({
            type: 'info',
            title: 'Aviso',
            text: texto,
                    showConfirmButton: false,
            //confirmButtonText: 'Aceptar',
            //showLoaderOnConfirm: true,
            allowOutsideClick: false
        });
            return obj;
    }

   export function general(texto,title,tipo) {
        let obj = swal.fire|({
            type: tipo,
            title: title,
            text: texto,
            confirmButtonText: 'Aceptar',
            showLoaderOnConfirm: true,
            allowOutsideClick: false
        });
            return obj;
    }

  export  function avisoW(texto) {
        let obj = swal({
            type: 'warning',
            title: 'Aviso',
            text: texto,
            confirmButtonText: 'Aceptar',
            showLoaderOnConfirm: true,
            allowOutsideClick: false
        });
            return obj;
    }

   export function confirmar(texto) {
        let obj = swal({
            type: "warning",
            confirmButtonColor: '#00b293',
            cancelButtonColor: '#d33',
            text: texto,
            confirmButtonText: 'Aceptar',
                    cancelButtonText: "Cancelar",
            showLoaderOnConfirm: true,
                    showCancelButton: true,
            allowOutsideClick: false
        });
            return obj;
    }
    export function confirmarE(texto) {
        let obj = swal.fire({
            type: "warning",
            type: 'info',
            title: 'Aviso',

                    confirmButtonColor: '#00b293',
                    cancelButtonColor: '#d33',
            text: texto,
            confirmButtonText: 'Aceptar',
                    cancelButtonText: "Cancelar",
            showLoaderOnConfirm: true,
                    showCancelButton: true,
            allowOutsideClick: false
        });
            return obj;
    }

   export function aceptar(texto) {
        let obj = swal({
            type: "success",

                    confirmButtonColor: '#00b293',
                    cancelButtonColor: '#d33',
            text: texto,
            confirmButtonText: 'Aceptar',
            showLoaderOnConfirm: true,
            allowOutsideClick: false
        });
            return obj;
    }

   export function avisoBloqueoC(texto) {
        let obj = swal({
            type: 'info',
            title: 'Aviso',
            text: texto,
                    showConfirmButton: true,
            confirmButtonText: 'Aceptar',
            //showLoaderOnConfirm: true,
            allowOutsideClick: false
        });
            return obj;
    }

   export function avisoBloqueoSB(texto) {
        let obj = swal({
            type: 'warning',
            title: 'Aviso',
            text: texto,
                    showConfirmButton: false,
            confirmButtonText: 'Aceptar',
            //showLoaderOnConfirm: true,
            allowOutsideClick: false
        });
            return obj;
    }

   export function cerrar() {
        swal.close();
    }

   export function HTML_m(texto){
      let obj = swal({
        title: 'Información',
        type: 'info',
        html:texto,
        focusConfirm: false,
        allowOutsideClick: false,
        confirmButtonText: 'Aceptar',
      })
        return obj;
    }
    
	export var es = {
    "code": "es",
    "messages": {
        "alpha": "El campo {_field_} solo debe contener letras",
        "alpha_dash": "El campo {_field_} solo debe contener letras, números y guiones",
        "alpha_num": "El campo {_field_} solo debe contener letras y números",
        "alpha_spaces": "El campo {_field_} solo debe contener letras y espacios",
        "between": "El campo {_field_} debe estar entre {min} y {max}",
        "confirmed": "El campo {_field_} no coincide",
        "digits": "El campo {_field_} debe ser numérico y contener exactamente {length} dígitos",
        "dimensions": "El campo {_field_} debe ser de {width} píxeles por {height} píxeles",
        "email": "El campo {_field_} debe ser un correo electrónico válido",
        "excluded": "El campo {_field_} debe ser un valor válido",
        "ext": "El campo {_field_} debe ser un archivo válido",
        "image": "El campo {_field_} debe ser una imagen",
        "oneOf": "El campo {_field_} debe ser un valor válido",
        "integer": "El campo {_field_} debe ser un entero",
        "length": "El largo del campo {_field_} debe ser {length}",
        "max": "El campo {_field_} no debe ser mayor a {length} caracteres",
        "max_value": "El campo {_field_} debe de ser {max} o menor",
        "mimes": "El campo {_field_} debe ser un tipo de archivo válido",
        "min": "El campo {_field_} debe tener al menos {length} caracteres",
        "min_value": "El campo {_field_} debe ser {min} o superior",
        "numeric": "El campo {_field_} debe contener solo caracteres numéricos",
        "regex": "El formato del campo {_field_} no es válido",
        "required": "El campo {_field_} es obligatorio",
        "required_if": "El campo {_field_} es obligatorio",
        "size": "El campo {_field_} debe ser menor a {size}KB",
        "double": "El campo {_field_} debe ser un decimal válido",
        "is": "El campo {_field_} no coincide con {other}",
        "is_not": "El campo {_field_} debe ser diferente a {other}"
    }
}
