/* 
 * Document    : controlador_catalogo_cita_excluir_fecha.js
 * Description : Controlador de la Interfaz Grafica del catalogo para la exclusion de fechas para citas
 * Copyright   : Copyright (c) 2017
 * Company     : Universidad Tecnológica de León
 * Version     : 1.0
 * Author      : Oscar Farés García Rodríguez
 * Created on  : 07/04/2017 (2017-04-07)
 */

// Variable que contrendra la instancia
let catalogoCitaExcluirFecha;

function CatalogoCitaExcluirFecha() {
    this.txtFecha = "#txtFecha";
    this.controladorJsp = "controlador/controlador_catalogo_cita_excluir_fecha.jsp";
    this.cmbProceso = "#cmbProceso";
    this.tblCitas = "#tblFechas";
    this.formulario = "#formulario";
}

CatalogoCitaExcluirFecha.prototype.preLoader = function () {
    swal({
        title: "",
        imageUrl: "../../images/Logo_utl_animado.gif",
        showConfirmButton: false
    });
};

CatalogoCitaExcluirFecha.prototype.ajustarRangoDatePiker = function (element) {
    console.log(element.options[element.selectedIndex]);
    $(catalogoCitaExcluirFecha.txtFecha).val("");
    let fechaPicker = $(catalogoCitaExcluirFecha.txtFecha);
    let fecha_inicio = element.options[element.selectedIndex].getAttribute("data-fecha-inicio"),
            fecha_fin = element.options[element.selectedIndex].getAttribute("data-fecha-termino");
    
    if (parseInt(fecha_inicio.replace("-", "")) > parseInt(fechaPicker.attr("placeholder").replace("-", ""))) {
        fechaPicker.datepicker("setStartDate", fecha_inicio);
    } else {
        fechaPicker.datepicker("setStartDate", catalogoCitaExcluirFecha.fechaActual());
    }

    fechaPicker.datepicker("setEndDate", fecha_fin);
};

CatalogoCitaExcluirFecha.prototype.fechaActual = function () {
    let fechaActual = new Date(),
            dia = (fechaActual.getDate().toString().length === 1 ? "0" + fechaActual.getDate() : fechaActual.getDate()),
            mes = ((fechaActual.getMonth() + 1).toString().length === 1 ? "0" + (fechaActual.getMonth() + 1) : (fechaActual.getMonth() + 1)),
            anio = fechaActual.getFullYear();
    
    return anio + "-" + mes + "-" + dia;
};

CatalogoCitaExcluirFecha.prototype.initDataPiker = function () {
    let fechaPicker = $(catalogoCitaExcluirFecha.txtFecha);
    
    fechaPicker.attr("placeholder", catalogoCitaExcluirFecha.fechaActual());
    fechaPicker.datepicker({
        format: "yyyy-mm-dd",
        todayBtn: "true",
        todayHighlight: true,
        autoclose: true,
        language: "es",
        daysOfWeekDisabled: [0],
        startDate: "today"
    });
};

CatalogoCitaExcluirFecha.prototype.listarProcesos = function () {
    $.ajax({
        type: "POST",
        dataType: "json",
        url: catalogoCitaExcluirFecha.controladorJsp,
        data: {"accion": 1},
        beforeSend: function (xhr) {
//                    console.log("xhr: " + xhr);
        },
        success: function (data, textStatus, jqXHR) {
//                    console.log("data: " + data + " | textStatus: " + textStatus + " | jqXHR: " + jqXHR);
            console.log(data);
            for (let i = 0; i < data.length; i++) {
                $(catalogoCitaExcluirFecha.cmbProceso).append('<option value="' + data[i].cve_cita_proceso_escolar + '"  data-fecha-inicio="' + data[i].fecha_inicio + '" data-fecha-termino="' + data[i].fecha_termino + '">' + data[i].nombre + '</option>');
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log("jqXHR: " + jqXHR + " | textStatus: " + textStatus + " | errorThrown: " + errorThrown);
        },
        complete: function (jqXHR, textStatus) {

        }
    });
};

CatalogoCitaExcluirFecha.prototype.inicializarTabla = function () {

    $(catalogoCitaExcluirFecha.tblCitas + ' tfoot th').each(function () {
        let title = $(this).text();
        if (title !== "") {
            $(this).html('<input type="text" class="form-control input-sm" style="width: 100%;" placeholder="' + title + '" />');
        }
    });
    let table = $(catalogoCitaExcluirFecha.tblCitas).DataTable({
        "responsive": true,
        "lengthMenu": [
            [10, 25, -1],
            [10, 25, "Todos"]
        ],
        "buttons": ["excel"],
//                    "buttons": ["colvis", "excel"],
        "columnDefs": [
            {
                "searchable": false,
                "targets": 0,
                "width": "5%"
            },
            {
                "targets": 1,
                "width": "40%"
            },
            {
                "targets": 2,
                "width": "40%"
            },
            {
                "searchable": false,
                "orderable": false,
                "targets": 3,
                "width": "0%"
            }
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
    table.buttons().container().appendTo(catalogoCitaExcluirFecha.tblCitas + '_wrapper .col-sm-6:eq(0)');
    table.columns().every(function () {
        let that = this;
        $('input', this.footer()).on('keyup change', function () {
            if (that.search() !== this.value) {
                that.search(this.value).draw();
            }
        });
    });
};

CatalogoCitaExcluirFecha.prototype.listarFechasExcluidas = function () {
    let tblCitas = $(catalogoCitaExcluirFecha.tblCitas).DataTable();
    tblCitas.clear().draw();
    $.ajax({
        type: "POST",
        dataType: "json",
        url: catalogoCitaExcluirFecha.controladorJsp,
        data: {"accion": 2},
        beforeSend: function (xhr) {
//                    console.log("xhr: " + xhr);
//            catalogoCitaExcluirFecha.preLoader();
        },
        success: function (data, textStatus, jqXHR) {
//                    console.log("data: " + data + " | textStatus: " + textStatus + " | jqXHR: " + jqXHR);
            console.log(data);
//            data = [];
            if (data.length > 0) {
                for (let i = 0; i < data.length; i++) {
                    tblCitas.row.add([
                        i+1,
                        data[i].proceso,
                        data[i].fecha,
                        '<center>'
                                + '<button type="button" class="btn btn-danger" title="Eliminar fecha excluida" onclick="catalogoCitaExcluirFecha.eliminar(' + data[i].cve_cita_excluir_fecha + ')">'
                                + '<i class="glyphicon glyphicon-trash"></i>'
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
//            swal.close();
        }
    });

};

CatalogoCitaExcluirFecha.prototype.guardar = function () {
    $(catalogoCitaExcluirFecha.formulario).on("submit", function (event) {
        event.preventDefault();
        $.ajax({
            type: "POST",
            dataType: "json",
            url: catalogoCitaExcluirFecha.controladorJsp,
            data: $(catalogoCitaExcluirFecha.formulario).serialize() + "&accion=3",
            beforeSend: function (xhr) {
//                    console.log("xhr: " + xhr);
                catalogoCitaExcluirFecha.preLoader();
            },
            success: function (data, textStatus, jqXHR) {
//                    console.log("data: " + data + " | textStatus: " + textStatus + " | jqXHR: " + jqXHR);
                console.log(data);
                if (data > 0) {
                    catalogoCitaExcluirFecha.listarFechasExcluidas();
                    swal("¡Registro exitoso!", "La fecha a excluir se ha guardado correctamente", "success");
                    $(catalogoCitaExcluirFecha.formulario)[0].reset();
                } else if (data === -2) {
                    swal("¡Registro duplicado!", "La fecha a excluir para ese proceso ya se encuentra registrado", "warning");
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
    });
};

CatalogoCitaExcluirFecha.prototype.modificar = function () {
//    swal({
//        title: 'Submit email to run ajax request',
//        input: 'text',
//        showCancelButton: true,
//        confirmButtonText: 'Submit',
//        showLoaderOnConfirm: true,
//        preConfirm: function (text) {
//            return new Promise(function (resolve, reject) {
//                setTimeout(function () {
//                    if (text === 'taken@example.com') {
//                        reject('This email is already taken.');
//                    } else {
//                        resolve();
//                    }
//                }, 2000);
//            });
//        },
//        allowOutsideClick: false
//    }).then(function (email) {
//        swal({
//            type: 'success',
//            title: 'Ajax request finished!',
//            html: 'Submitted email: ' + email
//        });
//    });
};

CatalogoCitaExcluirFecha.prototype.eliminar = function (id) {
    swal({
        title: "Confirmar acción",
        text: "Desea eliminar la fecha seleccionada",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: '¡Si, borrar!',
        cancelButtonText: 'Cancelar'
    }).then(function () {
        $.ajax({
            type: "POST",
            dataType: "json",
            url: catalogoCitaExcluirFecha.controladorJsp,
            data: {accion: 4, cve_cita_excluir_fecha: id},
            beforeSend: function (xhr) {
//                    console.log("xhr: " + xhr);
                catalogoCitaExcluirFecha.preLoader();
            },
            success: function (data, textStatus, jqXHR) {
//                    console.log("data: " + data + " | textStatus: " + textStatus + " | jqXHR: " + jqXHR);
                console.log(data);

                if (data === 0) {
                    swal("¡Ups!", "No se ha podido eliminar vuelva a intentar", "warning");
                } else if (data === -1) {
                    swal("¡Ups!", "No se ha podido eliminar vuelva a intentar", "error");
                } else if (data > 0) {
                    catalogoCitaExcluirFecha.listarFechasExcluidas();
                    swal("Borrada!", "La fecha seleccionada ha sido borrada.", "success");
                } else {
                    swal("¡Ups!", "No se ha podido eliminar vuelva a intentar", "error");
                }

            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log("jqXHR: " + jqXHR + " | textStatus: " + textStatus + " | errorThrown: " + errorThrown);
            }
        });
    });
};


/****** Inicializacion *******/

//Creacion del objeto
catalogoCitaExcluirFecha = new CatalogoCitaExcluirFecha();

//Mostrar Preloader
catalogoCitaExcluirFecha.preLoader();

//Listar procesos en la lista desplegable
catalogoCitaExcluirFecha.listarProcesos();

//Creacion de la tabla
catalogoCitaExcluirFecha.inicializarTabla();

//Creacion del datapiker
catalogoCitaExcluirFecha.initDataPiker();

//Listar procesos en la tabla
catalogoCitaExcluirFecha.listarFechasExcluidas();


catalogoCitaExcluirFecha.guardar();

//Cerrar Preloader
swal.close();