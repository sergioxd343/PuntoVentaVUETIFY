/* 
 * Document    : controlador_catalogo_cita_configuracion_turno.js
 * Description : Controlador de la Interfaz Grafica del catalogo para la configuracion de turnos
 * Copyright   : Copyright (c) 2017
 * Company     : Universidad Tecnológica de León
 * Version     : 1.0
 * Author      : Oscar Farés García Rodríguez
 * Created on  : 18/08/2017 (2017-08-18)
 */

// Variable que contrendra la instancia
let catalogoCitaConfiguracionTurno;
function CatalogoCitaConfiguracionTurno() {
    this.controladorJsp = "controlador/controlador_catalogo_cita_configuracion_turno.jsp";
    this.cmbProceso = $("#cmbProceso");
    this.cmbDia = $("#cmbDia");
    this.txtHoraInicioAtencion = $("#txtHoraInicioAtencion");
    this.txtHoraTerminoAtencion = $("#txtHoraTerminoAtencion");
    this.cmbTurnoHora = $("#cmbTurnoHora");
    this.cveCitaConfiguracionTurno = 0;
    this.tblConfiguracioTurnos = "#tblConfiguracioTurnos";
    this.formulario = $("#formulario");
    this.btnCancelar = $("#btnCancelar");
    this.diasSemana = ["Domingo", "Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado"];
}

/*
 * Metodo que muestra un modal como preloader
 */
CatalogoCitaConfiguracionTurno.prototype.preLoader = function () {
    swal({
        title: "",
        imageUrl: "../../images/Logo_utl_animado.gif",
        showConfirmButton: false
    });
};
/*
 * Metodo que devuelve la fecha actual del dispositivo
 * @returns {String} Fecha actual
 */
CatalogoCitaConfiguracionTurno.prototype.fechaActual = function () {
    let fechaActual = new Date(),
            dia = (fechaActual.getDate().toString().length === 1 ? "0" + fechaActual.getDate() : fechaActual.getDate()),
            mes = ((fechaActual.getMonth() + 1).toString().length === 1 ? "0" + (fechaActual.getMonth() + 1) : (fechaActual.getMonth() + 1)),
            anio = fechaActual.getFullYear();
    return anio + "-" + mes + "-" + dia;
};
/*
 * Metodo que por medio de una peticion ajax consulta los datos solicitados,
 * y los agrega a la lista desplegable de procesos
 */
CatalogoCitaConfiguracionTurno.prototype.listarProcesos = function () {
    $.ajax({
        type: "POST",
        dataType: "json",
        url: catalogoCitaConfiguracionTurno.controladorJsp,
        data: {"accion": 1},
        beforeSend: function (xhr) {
//                    console.log("xhr: " + xhr);
        },
        success: function (data, textStatus, jqXHR) {
//                    console.log("data: " + data + " | textStatus: " + textStatus + " | jqXHR: " + jqXHR);
            console.log(data);
            for (let i = 0; i < data.length; i++) {
                catalogoCitaConfiguracionTurno.cmbProceso.append('<option value="' + data[i].cve_cita_proceso_escolar + '">' + data[i].nombre + '</option>');
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log("jqXHR: " + jqXHR + " | textStatus: " + textStatus + " | errorThrown: " + errorThrown);
        },
        complete: function (jqXHR, textStatus) {

        }
    });
};
/*
 * Metodo que crea el dataTable que contendra las citas programadas
 */
CatalogoCitaConfiguracionTurno.prototype.inicializarTabla = function () {

    $(catalogoCitaConfiguracionTurno.tblConfiguracioTurnos + ' tfoot th').each(function () {
        let title = $(this).text();
        if (title !== "") {
            $(this).html('<input type="text" class="form-control input-sm" style="width: 100%;" placeholder="' + title + '" />');
        }
    });
    let table = $(catalogoCitaConfiguracionTurno.tblConfiguracioTurnos).DataTable({
        "responsive": true,
        "lengthMenu": [
            [10, 25, -1],
            [10, 25, "Todos"]
        ],
        "buttons": [{
                extend: "excel",
                exportOptions: {
                    columns: ":visible"
                }}],
        "columnDefs": [
            {
                "targets": 0,
                "visible": false
            },
            {
                "targets": 1,
                "searchable": false,
                "width": "5%"
            },
            {
                "targets": 2,
                "width": "10%"
            },
            {
                "targets": 3,
                "width": "10%"
            },
            {
                "targets": 4,
                "width": "10%"
            },
            {
                "targets": 5,
                "width": "10%"
            },
            {
                "targets": 6,
                "width": "30%"
            },
            {
                "targets": 7,
                "searchable": false,
                "orderable": false,
                "width": "5%"
            },
            {
                "targets": 8,
                "searchable": false,
                "orderable": false,
                "width": "5%"
            }
//            {
//                "searchable": false,
//                "targets": 0,
//                "width": "5%"
//            },
//            {
//                "targets": 1,
//                "width": "40%"
//            },
//            {
//                "targets": 2,
//                "width": "40%"
//            },
//            {
//                "searchable": false,
//                "orderable": false,
//                "targets": 3,
//                "width": "0%"
//            }
        ],
        "language": {
            "lengthMenu": "Mostrar&nbsp;&nbsp;_MENU_&nbsp;&nbsp;registros por página",
            "zeroRecords": "No hay registros que mostrar",
            "info": "Mostrando _START_ a _END_ de _TOTAL_ registros",
            "infoEmpty": "No hay registros disponibles",
            "infoFiltered": "(Filtrada de _MAX_ entradas totales)",
            "loadingRecords": "Cargando...",
            "processing": "Procesando...",
            "search": "",
            "searchPlaceholder": "Buscar...",
            "paginate": {
                "first": "Primera",
                "last": "Última",
                "next": "Siguiente",
                "previous": "Anterior"
            },
            "buttons": {
                "colvis": 'Columnas',
                "print": "Imprimir"
            }
        }
    });
    table.buttons().container().appendTo(catalogoCitaConfiguracionTurno.tblConfiguracioTurnos + '_wrapper .col-sm-6:eq(0)');
    table.columns().every(function () {
        let that = this;
        $('input', this.footer()).on('keyup change', function () {
            if (that.search() !== this.value) {
                that.search(this.value).draw();
            }
        });
    });
};
CatalogoCitaConfiguracionTurno.prototype.listarConfiguracionTurnos = function (cve) {
    catalogoCitaConfiguracionTurno.preLoader();
    catalogoCitaConfiguracionTurno.listarConfiguracionTurnosIn(cve, function () {
        swal.close();
    });
};
/*
 * Metodo que por medio de una peticion ajax consulta los datos solicitados,
 * y los agrega a el dataTable de fechas excluidas
 */
CatalogoCitaConfiguracionTurno.prototype.listarConfiguracionTurnosIn = function (cve, callback) {
    catalogoCitaConfiguracionTurno.cveCitaConfiguracionTurno = 0;
    let tblCitas = $(catalogoCitaConfiguracionTurno.tblConfiguracioTurnos).DataTable();
    tblCitas.clear().draw();
    $.ajax({
        type: "POST",
        dataType: "json",
        url: catalogoCitaConfiguracionTurno.controladorJsp,
        data: {"accion": 2, "cmbProceso": cve},
        beforeSend: function (xhr) {
//                    console.log("xhr: " + xhr);
        },
        success: function (data, textStatus, jqXHR) {
//                    console.log("data: " + data + " | textStatus: " + textStatus + " | jqXHR: " + jqXHR);
            console.log(data);
            if (data.length > 0) {
                for (let i = 0; i < data.length; i++) {
                    tblCitas.row.add([
                        data[i],
                        i + 1,
                        catalogoCitaConfiguracionTurno.diasSemana[data[i].dia - 1],
                        data[i].hora_inicio_atencion,
                        data[i].hora_termino_atencion,
                        data[i].turnos_atencion_hora,
                        data[i].nombre,
                        '<center>'
                                + '<button type="button" class="btn ' + (data[i].activo === '1' ? 'btn-success' : 'btn-default') + ' " title="' + (data[i].activo === '1' ? 'Desactivar' : 'Activar') + '" onclick="catalogoCitaConfiguracionTurno.activar(' + data[i].cve_cita_configuracion_turno + ',' + data[i].activo + ')">'
                                + '<i class="fa fa-check-circle"></i>'
                                + '</button>'
                                + '</center>'+'<p style="display: none;">'+data[i].activo+'</p>',
                        '<center>'
                                + '<button type="button" class="btn btn-primary" title="Editar" onclick="catalogoCitaConfiguracionTurno.editar(this)">'
                                + '<i class="fa fa-pencil-square"></i>'
                                + '</button>'
                                + '</center>'
                    ]).draw();
                }
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log("jqXHR: " + jqXHR + " | textStatus: " + textStatus + " | errorThrown: " + errorThrown);
        },
        complete: function (jqXHR, textStatus) {
            if (callback) {
                callback();
            }
        }
    });
};
/*
 * Metodo que por medio de una peticion ajax envia los datos a ser almacenados
 */
CatalogoCitaConfiguracionTurno.prototype.guardar = function () {
    catalogoCitaConfiguracionTurno.formulario.on("submit", function (event) {
        event.preventDefault();
        if (catalogoCitaConfiguracionTurno.esHoraValida(catalogoCitaConfiguracionTurno.txtHoraInicioAtencion.val())
                && catalogoCitaConfiguracionTurno.esHoraValida(catalogoCitaConfiguracionTurno.txtHoraTerminoAtencion.val())) {
            if (catalogoCitaConfiguracionTurno.cveCitaConfiguracionTurno === 0) {
                $.ajax({
                    type: "POST",
                    dataType: "json",
                    url: catalogoCitaConfiguracionTurno.controladorJsp,
                    data: catalogoCitaConfiguracionTurno.formulario.serialize() + "&accion=3",
                    beforeSend: function (xhr) {
//                    console.log("xhr: " + xhr);
                        catalogoCitaConfiguracionTurno.preLoader();
                    },
                    success: function (data, textStatus, jqXHR) {
//                    console.log("data: " + data + " | textStatus: " + textStatus + " | jqXHR: " + jqXHR);
//                    console.log(data);
                        if (data > 0) {
                            catalogoCitaConfiguracionTurno.listarConfiguracionTurnosIn(0);
                            swal("¡Registro exitoso!", "La configuración de turno se ha guardado correctamente", "success");
                            catalogoCitaConfiguracionTurno.formulario[0].reset();
                            catalogoCitaConfiguracionTurno.cmbProceso.attr("disabled", false);
                            catalogoCitaConfiguracionTurno.cmbDia.attr("disabled", false);
                        } else if (data === -2) {
                            swal("¡Registro duplicado!", "La configuración de turno para ese proceso en ese día ya se encuentra registrado", "warning");
                        } else {
                            swal("¡Ups!", "No se ha podido registrar vuelva a intentar", "error");
                        }

                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log("jqXHR: " + jqXHR + " | textStatus: " + textStatus + " | errorThrown: " + errorThrown);
                    },
                    complete: function (jqXHR, textStatus) {
                    }
                });
            } else {
                let cveProceso = catalogoCitaConfiguracionTurno.cmbProceso.val();
                $.ajax({
                    type: "POST",
                    dataType: "json",
                    url: catalogoCitaConfiguracionTurno.controladorJsp,
                    data: catalogoCitaConfiguracionTurno.formulario.serialize() + "&cve_cita_configuracion_turno=" + catalogoCitaConfiguracionTurno.cveCitaConfiguracionTurno + "&accion=5",
                    beforeSend: function (xhr) {
//                    console.log("xhr: " + xhr);
                        catalogoCitaConfiguracionTurno.preLoader();
                    },
                    success: function (data, textStatus, jqXHR) {
//                    console.log("data: " + data + " | textStatus: " + textStatus + " | jqXHR: " + jqXHR);
                        console.log(data);
                        if (data === 0) {
                            swal("¡Alerta!", "No se ha podido modificar vuelva a intentar", "warning");
                        } else if (data === -1) {
                            swal("¡Alerta!", "No se ha podido modificar vuelva a intentar", "error");
                        } else if (data > 0) {
                            catalogoCitaConfiguracionTurno.formulario[0].reset();
                            catalogoCitaConfiguracionTurno.listarConfiguracionTurnosIn(cveProceso);
                            catalogoCitaConfiguracionTurno.cmbProceso.val(cveProceso);
                            catalogoCitaConfiguracionTurno.cveCitaConfiguracionTurno = 0;
                            catalogoCitaConfiguracionTurno.cmbProceso.attr("disabled", false);
                            catalogoCitaConfiguracionTurno.cmbDia.attr("disabled", false);
                            swal("¡Operación exitosa!", "La configuración seleccionada ha sido actualizada.", "success");
                        } else {
                            swal("¡Alerta!", "No se ha podido modificar vuelva a intentar", "error");
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log("jqXHR: " + jqXHR + " | textStatus: " + textStatus + " | errorThrown: " + errorThrown);
                    },
                    complete: function (jqXHR, textStatus) {

                    }
                });
            }
        } else {
            swal("¡Alerta!", "Favor de ingresar una hora valida", "warning");
        }
    });
};
/*
 * Metodo que por medio de una peticion ajax elimina la fecha seleccionada
 * @param {type} id de la fecha a eliminar
 */
CatalogoCitaConfiguracionTurno.prototype.activar = function (id, estado) {
    let textEstado = estado === "1" ? "desactivar" : "activar";
    $.ajax({
        type: "POST",
        dataType: "json",
        url: catalogoCitaConfiguracionTurno.controladorJsp,
        data: {accion: 4, cve_cita_configuracion_turno: id},
        beforeSend: function (xhr) {
//                    console.log("xhr: " + xhr);
            catalogoCitaConfiguracionTurno.preLoader();
        },
        success: function (data, textStatus, jqXHR) {
//                    console.log("data: " + data + " | textStatus: " + textStatus + " | jqXHR: " + jqXHR);
            console.log(data);
            if (data === 0) {
                swal("¡Alerta!", "No se ha podido " + textEstado + " vuelva a intentar", "warning");
            } else if (data === -1) {
                swal("¡Alerta!", "No se ha podido " + textEstado + " vuelva a intentar", "error");
            } else if (data > 0) {
                catalogoCitaConfiguracionTurno.listarConfiguracionTurnosIn(catalogoCitaConfiguracionTurno.cmbProceso.val());
                swal("¡Operación exitosa!", "La configuración seleccionada ha sido actualizada.", "success");
            } else {
                swal("¡Alerta!", "No se ha podido " + textEstado + " vuelva a intentar", "error");
            }

        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log("jqXHR: " + jqXHR + " | textStatus: " + textStatus + " | errorThrown: " + errorThrown);
        }
    });
};
CatalogoCitaConfiguracionTurno.prototype.editar = function (elem) {
    let dataTable = $(catalogoCitaConfiguracionTurno.tblConfiguracioTurnos).DataTable();
    let rowElement = $(elem).parent().parent().parent();
    let rowData = dataTable.row(rowElement).data()[0];
    catalogoCitaConfiguracionTurno.cmbProceso.attr("disabled", true);
    catalogoCitaConfiguracionTurno.cmbDia.attr("disabled", true);
    window.scrollTo(0, 0);
    catalogoCitaConfiguracionTurno.cveCitaConfiguracionTurno = rowData.cve_cita_configuracion_turno;
    catalogoCitaConfiguracionTurno.cmbProceso.val(rowData.cve_cita_proceso_escolar);
    catalogoCitaConfiguracionTurno.cmbDia.val(rowData.dia);
    catalogoCitaConfiguracionTurno.txtHoraInicioAtencion.val(rowData.hora_inicio_atencion);
    catalogoCitaConfiguracionTurno.txtHoraTerminoAtencion.val(rowData.hora_termino_atencion);
    catalogoCitaConfiguracionTurno.cmbTurnoHora.val(rowData.turnos_atencion_hora);
};
CatalogoCitaConfiguracionTurno.prototype.mediaCero = function (tiempo) {
    if (tiempo.length === 5) {
        let horas = tiempo.substring(0, 2);
        let minutos = tiempo.substring(3, 5);
        return horas + ":" + (minutos >= 30 ? "30" : "00");
    }
};
CatalogoCitaConfiguracionTurno.prototype.esHoraValida = function (tiempo) {
    if (tiempo.length === 5) {
        let horas = tiempo.substring(0, 2);
        if (horas >= 8 && 21 > horas) {
            return true;
        } else {
            return false;
        }
    } else {
        return false;
    }
};
/****** Inicializacion *******/

//Creacion del objeto
catalogoCitaConfiguracionTurno = new CatalogoCitaConfiguracionTurno();
//Mostrar Preloader
catalogoCitaConfiguracionTurno.preLoader();
//inicializar clockpickers
$(".txtHoraInicioAtencion").clockpicker({
    afterDone: function () {
        let horaInicio = catalogoCitaConfiguracionTurno.txtHoraInicioAtencion;
        let horaTermino = catalogoCitaConfiguracionTurno.txtHoraTerminoAtencion;
        horaTermino.val("00:00");
        if (catalogoCitaConfiguracionTurno.esHoraValida(horaInicio.val())) {
            horaInicio.val(catalogoCitaConfiguracionTurno.mediaCero(horaInicio.val()));
        } else {
            horaInicio.val("00:00");
            swal("¡Alerta!", "Favor de ingresar una hora valida", "warning");
        }
    }
});
$(".txtHoraTerminoAtencion").clockpicker({
    afterDone: function () {
        let horaTermino = catalogoCitaConfiguracionTurno.txtHoraTerminoAtencion;
        let horaInicio = catalogoCitaConfiguracionTurno.txtHoraInicioAtencion;
        if (catalogoCitaConfiguracionTurno.esHoraValida(horaTermino.val())) {
            if (horaInicio.val().replace(":", "") < horaTermino.val().replace(":", "")) {
                horaTermino.val(catalogoCitaConfiguracionTurno.mediaCero(horaTermino.val()));
            } else {
                horaTermino.val("00:00");
                swal("¡Alerta!", "Favor de ingresar una hora posterior a la de inicio", "warning");
            }

        } else {
            horaTermino.val("00:00");
            swal("¡Alerta!", "Favor de ingresar una hora valida", "warning");
        }
    }
});
//Listar procesos en la lista desplegable
catalogoCitaConfiguracionTurno.listarProcesos();
//Creacion de la tabla
catalogoCitaConfiguracionTurno.inicializarTabla();
//Listar procesos en la tabla
catalogoCitaConfiguracionTurno.listarConfiguracionTurnos(0);
catalogoCitaConfiguracionTurno.guardar();
catalogoCitaConfiguracionTurno.btnCancelar.on("click", function () {
    catalogoCitaConfiguracionTurno.formulario[0].reset();
    catalogoCitaConfiguracionTurno.cveCitaConfiguracionTurno = 0;
    catalogoCitaConfiguracionTurno.cmbProceso.change();
    catalogoCitaConfiguracionTurno.cmbProceso.attr("disabled", false);
    catalogoCitaConfiguracionTurno.cmbDia.attr("disabled", false);
});
//Cerrar Preloader
swal.close();