/* 
 * Document    : controlador_reporte_turno.js
 * Description : Controlador de la Interfaz Grafica del reporte de turno
 * Copyright   : Copyright (c) 2017
 * Company     : Universidad Tecnológica de León
 * Version     : 1.0
 * Author      : Oscar Farés García Rodríguez
 * Created on  : 27-mar-2017, 15:36:43
 */

// Variable que contrendra la instancia
let reporteTurno;

function ReporteTurno() {
    this.datePiker = "#datepicker";
    this.controladorJsp = "controlador/controlador_reporte_turno.jsp";
    this.cmbEmpleado = "#cmbEmpleado";
    this.cmbProceso = "#cmbProceso";
    this.tblCitas = "#tblCitas";
}

ReporteTurno.prototype.preLoader = function () {
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
ReporteTurno.prototype.fechaActual = function () {
    let fechaActual = new Date(),
            dia = (fechaActual.getDate().toString().length === 1 ? "0" + fechaActual.getDate() : fechaActual.getDate()),
            mes = ((fechaActual.getMonth() + 1).toString().length === 1 ? "0" + (fechaActual.getMonth() + 1) : (fechaActual.getMonth() + 1)),
            anio = fechaActual.getFullYear();

    return anio + "-" + mes + "-" + dia;
};

/*
 * Metodo que crea el datePicker
 */
ReporteTurno.prototype.initDataPiker = function () {
    $(reporteTurno.datePiker).find("[name=start]").val(reporteTurno.fechaActual());
    $(reporteTurno.datePiker).find("[name=end]").val(reporteTurno.fechaActual());

    $(reporteTurno.datePiker).datepicker({
        format: "yyyy-mm-dd",
        todayBtn: "linked",
        todayHighlight: true,
        autoclose: true,
        language: "es"
    });
};

/*
 * 
 * @param {type} combojq
 * @returns {undefined}
 */
ReporteTurno.prototype.limpiarCombo = function (combojq) {
    combojq.empty();
    combojq.append('<option value="">Selecciona</option>');
};

/*
 * Metodo que por medio de una peticion ajax consulta los datos solicitados,
 * y los agrega a la lista desplegable de empleados
 */
ReporteTurno.prototype.listarEmpleados = function (cve) {
    reporteTurno.limpiarCombo($(reporteTurno.cmbEmpleado));
    $.ajax({
        type: "POST",
        dataType: "json",
        url: reporteTurno.controladorJsp,
        data: {"accion": 1, "cve_cita_proceso_escolar": cve},
        beforeSend: function (xhr) {
//                    console.log("xhr: " + xhr);
            reporteTurno.preLoader();
        },
        success: function (data, textStatus, jqXHR) {
//                    console.log("data: " + data + " | textStatus: " + textStatus + " | jqXHR: " + jqXHR);
            for (let i = 0; i < data.length; i++) {
                $(reporteTurno.cmbEmpleado).append('<option value="' + data[i].cve_empleado + '">' + data[i].nombre + ' ' + data[i].apellido_paterno + ' ' + data[i].apellido_materno + '</option>');
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log("jqXHR: " + jqXHR + " | textStatus: " + textStatus + " | errorThrown: " + errorThrown);
        },
        complete: function (jqXHR, textStatus) {
            swal.close();
        }
    });
};

/*
 * Metodo que por medio de una peticion ajax consulta los datos solicitados,
 * y los agrega a la lista desplegable de procesos
 */
ReporteTurno.prototype.listarProcesos = function () {
    $.ajax({
        type: "POST",
        dataType: "json",
        url: reporteTurno.controladorJsp,
        data: {"accion": 2},
        beforeSend: function (xhr) {
//                    console.log("xhr: " + xhr);
        },
        success: function (data, textStatus, jqXHR) {
//                    console.log("data: " + data + " | textStatus: " + textStatus + " | jqXHR: " + jqXHR);
            for (let i = 0; i < data.length; i++) {
                $(reporteTurno.cmbProceso).append('<option value="' + data[i].cve_cita_proceso_escolar + '">' + data[i].nombre + '</option>');
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
ReporteTurno.prototype.inicializarTabla = function () {

    $(reporteTurno.tblCitas + ' tfoot th').each(function () {
        let title = $(this).text();
        if (title !== "") {
            $(this).html('<input type="text" class="form-control input-sm" style="width: 100%;" placeholder="' + title + '" />');
        }
    });
    let table = $(reporteTurno.tblCitas).DataTable({
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
    table.buttons().container().appendTo(reporteTurno.tblCitas + '_wrapper .col-sm-6:eq(0)');
    table.columns().every(function () {
        let that = this;
        $('input', this.footer()).on('keyup change', function () {
            if (that.search() !== this.value) {
                that.search(this.value).draw();
            }
        });
    });
};

/*
 * Metodo que por medio de una peticion ajax consulta los datos solicitados, y los agrega a el dataTable
 */
ReporteTurno.prototype.listarCitas = function () {
    let cve_empleado = $(reporteTurno.cmbEmpleado).val();
    let cve_proceso = $(reporteTurno.cmbProceso).val();
    let fecha_i = $("#fecha_inicio").val();
    let fecha_f = $("#fecha_fin").val();
    let tblCitas = $(reporteTurno.tblCitas).DataTable();
    tblCitas.clear().draw();
    $.ajax({
        type: "POST",
        dataType: "json",
        url: reporteTurno.controladorJsp,
        data: {
            "accion": 3,
//            "cve_empleado": cve_emp,
            "cve_empleado": cve_empleado,
            "cve_cita_proceso_escolar": cve_proceso,
            "fecha_inicio": fecha_i,
            "fecha_fin": fecha_f
        },
        beforeSend: function (xhr) {
//                    console.log("xhr: " + xhr);
            reporteTurno.preLoader();
        },
        success: function (data, textStatus, jqXHR) {
//                    console.log("data: " + data + " | textStatus: " + textStatus + " | jqXHR: " + jqXHR);
//                    console.log(data);
            if (data.length > 0) {
                for (let i = 0; i < data.length; i++) {
                    tblCitas.row.add([
                        i + 1,
                        data[i].nombre,
                        data[i].fecha_atencion,
                        data[i].horario,
                        data[i].matricula,
                        '<center>' + (data[i].asistencia === "1" ? '<span class="label label-success">SI</span>' : '<span class="label label-warning">NO</span>') + '</center>',
                        data[i].alumno,
                        data[i].mail,
                        data[i].movil,
                        data[i].cve_empleado,
                        data[i].asistente
                    ]).draw();
                }
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log("jqXHR: " + jqXHR + " | textStatus: " + textStatus + " | errorThrown: " + errorThrown);
        },
        complete: function (jqXHR, textStatus) {
            swal.close();
        }
    });

};


/****** Inicializacion *******/

//Creacion del objeto
reporteTurno = new ReporteTurno();

//Mostrar Preloader
reporteTurno.preLoader();

//Listar empleados en la lista desplegable
//reporteTurno.listarEmpleados();

//Listar procesos en la lista desplegable
reporteTurno.listarProcesos();

//Creacion de la tabla
reporteTurno.inicializarTabla();

//Creacion del datapiker
reporteTurno.initDataPiker();

//Listar procesos en la tabla
reporteTurno.listarCitas();

//Cerrar Preloader
swal.close();