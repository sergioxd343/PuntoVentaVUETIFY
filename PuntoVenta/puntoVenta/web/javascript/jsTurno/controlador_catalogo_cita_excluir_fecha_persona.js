/* 
 * Document    : controlador_catalogo_cita_excluir_fecha_persona.js
 * Description : Controlador de la Interfaz Grafica del catalogo para la exclusion de fechas para citas por persona
 * Copyright   : Copyright (c) 2017
 * Company     : Universidad Tecnológica de León
 * Version     : 1.0
 * Author      : Oscar Farés García Rodríguez
 * Created on  : 17/05/2017 (2017-05-17)
 */

// Variable que contrendra la instancia
let citaExcluirFechaPersona;

function CitaExcluirFechaPersona() {
    this.txtFecha = "#txtFecha";
    this.controladorJsp = "controlador/controlador_catalogo_cita_excluir_fecha_persona.jsp";
    this.cmbEmpleado = "#cmbEmpleado";
    this.tblFechas = "#tblFechas";
    this.formulario = "#formulario";
}

/*
 * Metodo que muestra un modal como preloader
 */
CitaExcluirFechaPersona.prototype.preLoader = function () {
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
CitaExcluirFechaPersona.prototype.fechaActual = function () {
    let fechaActual = new Date(),
            dia = (fechaActual.getDate().toString().length === 1 ? "0" + fechaActual.getDate() : fechaActual.getDate()),
            mes = ((fechaActual.getMonth() + 1).toString().length === 1 ? "0" + (fechaActual.getMonth() + 1) : (fechaActual.getMonth() + 1)),
            anio = fechaActual.getFullYear();

    return anio + "-" + mes + "-" + dia;
};

/*
 * Metodo que crea el datePicker
 */
CitaExcluirFechaPersona.prototype.initDataPiker = function () {
    let fechaPicker = $(citaExcluirFechaPersona.txtFecha);

    fechaPicker.attr("placeholder", citaExcluirFechaPersona.fechaActual());
    fechaPicker.datepicker({
        format: "yyyy-mm-dd",
        todayBtn: "linked",
        todayHighlight: true,
        autoclose: true,
        language: "es",
        daysOfWeekDisabled: [0],
        startDate: "today"
    });
};

/*
 * Metodo que por medio de una peticion ajax consulta los datos solicitados,
 * y los agrega a la lista desplegable de procesos
 */
CitaExcluirFechaPersona.prototype.listarEmpleados = function () {
    $.ajax({
        type: "POST",
        dataType: "json",
        url: citaExcluirFechaPersona.controladorJsp,
        data: {"accion": 1},
        beforeSend: function (xhr) {
//                    console.log("xhr: " + xhr);
        },
        success: function (data, textStatus, jqXHR) {
//                    console.log("data: " + data + " | textStatus: " + textStatus + " | jqXHR: " + jqXHR);
            for (let i = 0; i < data.length; i++) {
                $(citaExcluirFechaPersona.cmbEmpleado).append('<option value="' + data[i].cve_empleado + '">' + data[i].nombre + ' ' + data[i].apellido_paterno + ' ' + data[i].apellido_materno + '</option>');
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
CitaExcluirFechaPersona.prototype.inicializarTabla = function () {

    $(citaExcluirFechaPersona.tblFechas + ' tfoot th').each(function () {
        let title = $(this).text();
        if (title !== "") {
            $(this).html('<input type="text" class="form-control input-sm" style="width: 100%;" placeholder="' + title + '" />');
        }
    });
    let table = $(citaExcluirFechaPersona.tblFechas).DataTable({
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
                "width": "85%"
            },
            {
                "searchable": false,
                "orderable": false,
                "targets": 2,
                "width": "10%"
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
    table.buttons().container().appendTo(citaExcluirFechaPersona.tblFechas + '_wrapper .col-sm-6:eq(0)');
    table.columns().every(function () {
        let that = this;
        $('input', this.footer()).on('keyup change', function () {
            if (that.search() !== this.value) {
                that.search(this.value).draw();
            }
        });
    });
};


CitaExcluirFechaPersona.prototype.listarFechasExcluidas = function (cve) {
    citaExcluirFechaPersona.preLoader();
    citaExcluirFechaPersona.listarFechasExcluidasIn(cve);
    swal.close();
};

/*
 * Metodo que por medio de una peticion ajax consulta los datos solicitados,
 * y los agrega a el dataTable de fechas excluidas
 */
CitaExcluirFechaPersona.prototype.listarFechasExcluidasIn = function (cve) {
    let tblCitas = $(citaExcluirFechaPersona.tblFechas).DataTable();
    tblCitas.clear().draw();
    $.ajax({
        type: "POST",
        dataType: "json",
        url: citaExcluirFechaPersona.controladorJsp,
        data: {"accion": 2, "cmbEmpleado": cve},
        beforeSend: function (xhr) {
//                    console.log("xhr: " + xhr);

        },
        success: function (data, textStatus, jqXHR) {
//                    console.log("data: " + data + " | textStatus: " + textStatus + " | jqXHR: " + jqXHR);
            console.log(data);
//            data = [];
            if (data.length > 0) {
                for (let i = 0; i < data.length; i++) {
                    tblCitas.row.add([
                        i + 1,
                        data[i].fecha_excluir,
                        '<center>'
                                + '<button type="button" class="btn btn-danger" title="Eliminar fecha excluida" onclick="citaExcluirFechaPersona.eliminar(' + data[i].cve_cita_excluir_fecha_empleado + ')">'
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

        }
    });

};

/*
 * Metodo que por medio de una peticion ajax envia los datos a ser almacenados
 */
CitaExcluirFechaPersona.prototype.guardar = function () {
    $(citaExcluirFechaPersona.formulario).on("submit", function (event) {
        event.preventDefault();
        $.ajax({
            type: "POST",
            dataType: "json",
            url: citaExcluirFechaPersona.controladorJsp,
            data: $(citaExcluirFechaPersona.formulario).serialize() + "&accion=3",
            beforeSend: function (xhr) {
//                    console.log("xhr: " + xhr);
                citaExcluirFechaPersona.preLoader();
            },
            success: function (data, textStatus, jqXHR) {
//                    console.log("data: " + data + " | textStatus: " + textStatus + " | jqXHR: " + jqXHR);
                console.log(data);
                if (data > 0) {
                    citaExcluirFechaPersona.listarFechasExcluidasIn($(citaExcluirFechaPersona.cmbEmpleado).val());
                    swal("¡Registro exitoso!", "La fecha a excluir se ha guardado correctamente", "success");
//                    $(citaExcluirFechaPersona.formulario)[0].reset();
                    $(citaExcluirFechaPersona.txtFecha).val("");
                } else if (data === -2) {
                    swal("¡Registro duplicado!", "La fecha a excluir para la persona seleccionada ya se encuentra registrada", "warning");
                } else {
                    swal("¡Aviso!", "No se ha podido registrar vuelva a intentar", "error");
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

/*
 * Metodo que por medio de una peticion ajax elimina la fecha seleccionada
 * @param {type} id de la fecha a eliminar
 */
CitaExcluirFechaPersona.prototype.eliminar = function (id) {
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
            url: citaExcluirFechaPersona.controladorJsp,
            data: {accion: 4, cve_cita_excluir_fecha: id},
            beforeSend: function (xhr) {
//                    console.log("xhr: " + xhr);
                citaExcluirFechaPersona.preLoader();
            },
            success: function (data, textStatus, jqXHR) {
//                    console.log("data: " + data + " | textStatus: " + textStatus + " | jqXHR: " + jqXHR);
                console.log(data);

                if (data === 0) {
                    swal("¡Aviso!", "No se ha podido eliminar vuelva a intentar", "warning");
                } else if (data === -1) {
                    swal("¡Aviso!", "No se ha podido eliminar vuelva a intentar", "error");
                } else if (data > 0) {
                    citaExcluirFechaPersona.listarFechasExcluidasIn($(citaExcluirFechaPersona.cmbEmpleado).val());
                    swal("!Borrada!", "La fecha seleccionada ha sido borrada.", "success");
                } else {
                    swal("¡Aviso!", "No se ha podido eliminar vuelva a intentar", "error");
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
citaExcluirFechaPersona = new CitaExcluirFechaPersona();

//Mostrar Preloader
citaExcluirFechaPersona.preLoader();

//Listar procesos en la lista desplegable
citaExcluirFechaPersona.listarEmpleados();

//Creacion de la tabla
citaExcluirFechaPersona.inicializarTabla();

//Creacion del datapiker
citaExcluirFechaPersona.initDataPiker();


citaExcluirFechaPersona.guardar();

//Cerrar Preloader
swal.close();