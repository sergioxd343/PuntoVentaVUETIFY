/* 
 * Document    : controlador_reporte_encuesta_ventanilla.js
 * Description : Controlador de la Interfaz Grafica del reporte de turno
 * Copyright   : Copyright (c) 2017
 * Company     : Universidad Tecnológica de León
 * Version     : 1.0
 * Author      : Oscar Farés García Rodríguez
 * Created on  : 08-05-2017, 13:36:43
 */

// Variable que contrendra la instancia
let reporteEncuestaVentanilla;

function ReporteEncuestaVentanilla() {
    this.controladorJsp = "controlador/controlador_reporte_encuesta_ventanilla.jsp";
    this.cmbConvocatoria = "#cmbConvocatoria";
    this.cmbProceso = "#cmbProceso";
    this.tblRespuestas = "#tblRespuestas";
}

/**
 * Metodo      : "fnValidar"
 * Descripcion: "valida los campos del form."
 */
ReporteEncuestaVentanilla.prototype.fnValidar = function () {
    $.v_valid_start();
    $(reporteEncuestaVentanilla.cmbConvocatoria).v_valid("select");
    $(reporteEncuestaVentanilla.cmbProceso).v_valid("select");
    
    $("#xInicio").v_valid("length", {min: 10, max: 10});
    $("#xFin").v_valid("length", {min: 10, max: 10});

    return $.v_valid_end();
}

ReporteEncuestaVentanilla.prototype.preLoader = function () {
    swal({
        title: "",
        imageUrl: "../../images/Logo_utl_animado.gif",
        showConfirmButton: false
    });
};

/*
 * Metodo que por medio de una peticion ajax consulta los datos solicitados,
 * y los agrega a la lista desplegable de convocatorias
 */
ReporteEncuestaVentanilla.prototype.listarConvocatorias = function (cve) {

    let tblCitas = $(reporteEncuestaVentanilla.tblRespuestas).DataTable();
    if (tblCitas.data().count()) {
        tblCitas.clear().draw();
        console.log("limpiado...");
    }

    $.ajax({
        type: "POST",
        dataType: "json",
        url: reporteEncuestaVentanilla.controladorJsp,
        data: {"accion": 1, "cve_cita_proceso_escolar": cve},
        beforeSend: function (xhr) {
//                    console.log("xhr: " + xhr);
            reporteEncuestaVentanilla.preLoader();
        },
        success: function (data, textStatus, jqXHR) {
//                    console.log("data: " + data + " | textStatus: " + textStatus + " | jqXHR: " + jqXHR);
            $(reporteEncuestaVentanilla.cmbConvocatoria).empty();
            $(reporteEncuestaVentanilla.cmbConvocatoria).append('<option value="">Selecciona</option>');
            for (let i = 0; i < data.length; i++) {
                $(reporteEncuestaVentanilla.cmbConvocatoria).append('<option value="' + data[i].cve_cita_proceso_escolar + '" data-fecha-i="' + data[i].fecha_inicio + '" data-fecha-t="' + data[i].fecha_termino + '">' + data[i].fecha_inicio_f + ' - ' + data[i].fecha_termino_f + '</option>');
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
ReporteEncuestaVentanilla.prototype.listarProcesos = function () {
    $.ajax({
        type: "POST",
        dataType: "json",
        url: reporteEncuestaVentanilla.controladorJsp,
        data: {"accion": 2},
        beforeSend: function (xhr) {
//                    console.log("xhr: " + xhr);
        },
        success: function (data, textStatus, jqXHR) {
//                    console.log("data: " + data + " | textStatus: " + textStatus + " | jqXHR: " + jqXHR);
            for (let i = 0; i < data.length; i++) {
                $(reporteEncuestaVentanilla.cmbProceso).append('<option value="' + data[i].cve_cita_proceso_escolar + '">' + data[i].nombre + '</option>');
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
ReporteEncuestaVentanilla.prototype.inicializarTabla = function () {

    $(reporteEncuestaVentanilla.tblRespuestas + ' tfoot th').each(function () {
        let title = $(this).text();
        if (title !== "") {
            $(this).html('<input type="text" class="form-control input-sm" style="width: 100%;" placeholder="' + title + '" />');
        }
    });
    let table = $(reporteEncuestaVentanilla.tblRespuestas).DataTable({
        "responsive": true,
        "lengthMenu": [
            [10, 25, -1],
            [10, 25, "Todos"]
        ],
        "buttons": ["excel"],
//        "buttons": ["colvis", "excel"],
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
    table.buttons().container().appendTo(reporteEncuestaVentanilla.tblRespuestas + '_wrapper .col-sm-6:eq(0)');
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
ReporteEncuestaVentanilla.prototype.listarRespuestas = function () {
    let cve_proceso = $(reporteEncuestaVentanilla.cmbProceso).val();
//    let cve_convocatoria = $(reporteEncuestaVentanilla.cmbConvocatoria).val();
//    let fecha_inicio = $(reporteEncuestaVentanilla.cmbConvocatoria).find(":selected").attr("data-fecha-i");
//    let fecha_termino = $(reporteEncuestaVentanilla.cmbConvocatoria).find(":selected").attr("data-fecha-t");
    let cve_convocatoria = $(reporteEncuestaVentanilla.cmbConvocatoria).val();
    let fecha_inicio = $("#xInicio").val();
    let fecha_termino = $("#xFin").val();
//    console.log(cve_convocatoria);
    let tblCitas = $(reporteEncuestaVentanilla.tblRespuestas).DataTable();
    tblCitas.clear().draw();
    $.ajax({
        type: "POST",
        dataType: "json",
        url: reporteEncuestaVentanilla.controladorJsp,
        data: {
            "accion": 3,
            "cve_convocatoria": cve_convocatoria,
            "fecha_inicio": fecha_inicio,
            "fecha_termino": fecha_termino,
            "cve_cita_proceso_escolar": cve_proceso
        },
        beforeSend: function (xhr) {
//                    console.log("xhr: " + xhr);
            reporteEncuestaVentanilla.preLoader();
        },
        success: function (data, textStatus, jqXHR) {
//                    console.log("data: " + data + " | textStatus: " + textStatus + " | jqXHR: " + jqXHR);
//                    console.log(data);
            if (data.length > 0) {
                for (let i = 0; i < data.length; i++) {
                    tblCitas.row.add([
                        i + 1,
                        data[i].matricula,
                        data[i].nombre_alumno,
                        data[i].pregunta,
                        data[i].respuesta,
                        data[i].comentario,
                        data[i].atendio
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

ReporteEncuestaVentanilla.prototype.fnCalendario=function(){
    
    $(".calendario").datepicker( {
        format: "yyyy-mm-dd",
        startView: "years", 
        minView: "months",
        language: "es",
        autoclose: true
    });
    
    $("#xIconInicio").click(function(){             
        $("#xInicio").datepicker("show");;
    });
    
    $("#xIconFin").click(function(){             
        $("#xFin").datepicker("show");;
    });
};


/****** Inicializacion *******/

//Creacion del objeto
reporteEncuestaVentanilla = new ReporteEncuestaVentanilla();

//Mostrar Preloader
reporteEncuestaVentanilla.preLoader();

//Listar convocatorias en la lista desplegable
//reporteEncuestaVentanilla.listarConvocatorias();

//Listar procesos en la lista desplegable
reporteEncuestaVentanilla.listarProcesos();

//Creacion de la tabla
reporteEncuestaVentanilla.inicializarTabla();

reporteEncuestaVentanilla.fnCalendario();
//Listar procesos en la tabla
$("#xBuscar").click(function(e){
    e.preventDefault();
    if(reporteEncuestaVentanilla.fnValidar()){
        reporteEncuestaVentanilla.listarRespuestas();
    }
    
});
//

//Cerrar Preloader
swal.close();