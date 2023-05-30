/* 
 * Document    : controlador_reporte_turno.js
 * Description : Controlador de la Interfaz Grafica del reporte de turno para el alumno
 * Copyright   : Copyright (c) 2017
 * Company     : Universidad Tecnológica de León
 * Version     : 1.0
 * Author      : Oscar Farés García Rodríguez
 * Created on  : 27-mar-2017, 15:36:43
 */

// Variable que contrendra la instancia
let reporteTurnoAlumno;

function ReporteTurnoAlumno() {
    this.controladorJsp = "controlador/controlador_reporte_turno_alumno.jsp";
    this.tblCitas = "#tblCitas";
}

ReporteTurnoAlumno.prototype.preLoader = function () {
    swal({
        title: "",
        imageUrl: "../../images/Logo_utl_animado.gif",
        showConfirmButton: false
    });
};


ReporteTurnoAlumno.prototype.inicializarTabla = function () {
    let fechaActual = new Date(),
        dia = (fechaActual.getDate().toString().length === 1 ? "0" + fechaActual.getDate() : fechaActual.getDate()),
        mes = ((fechaActual.getMonth() + 1).toString().length === 1 ? "0" + (fechaActual.getMonth() + 1) : (fechaActual.getMonth() + 1)),
        anio = fechaActual.getFullYear();

    $(reporteTurnoAlumno.tblCitas + ' tfoot th').each(function () {
        let title = $(this).text();
        if (title !== "") {
            $(this).html('<input type="text" class="form-control input-sm" style="width: 100%;" placeholder="' + title + '" />');
        }
    });
    let table = $(reporteTurnoAlumno.tblCitas).DataTable({
        "responsive": true,
        "lengthMenu": [
            [10, 25, -1],
            [10, 25, "Todos"]
        ],
//        "buttons": ["excel"],
//                    "buttons": ["colvis", "excel"],
        "columnDefs": [
            {
                "searchable": false,
                "targets": 0,
                "width": "0%"
            },
            {
                "targets": 1,
                "width": "20%"
            },
            {
                "targets": 2,
                "width": "30%"
            },
            {
                "targets": 3,
                "width": "20%"
            },
            {
                "targets": 4,
                "width": "15%"
            },
            {
                "targets": 5,
                "width": "35%"
            },
            
        // ],
        // "aoColumns": [
            // {"mData": "id", "visible": false, },
            // {"mData": "nombre"},
            // {"mData": "fecha_atencion"},
            // {"mData": "horario"},
            // {"mData": "asistente"},
            {
                "targets": 6,
                "mData": null,
                "className": "text-center",
                "mRender": function (data, type, row) 
                {
                    //existe = 5 --- asistencia = 6, 
                    if(eval(data[6]) == 0 && eval(data[7]) == 1) 
                    {
                        let fechaAtencion = new Date(data[3]);
                        let fechaHoy = new Date();
                        if(fechaAtencion >= fechaHoy)
                        {
                            return '<div class="alert alert-warning" role="alert">Disponible después de tu cita</div>';
                        }
                        else
                        {
                            strButton = "<center> "
                            + "<button class='btn btn-warning survey'  ><span class='fa fa-comment-o' aria-hidden='true'></span></button "
                            + "</center>";
                            return strButton;
                        }
                        //return "Activo"
                    }
                    else if(eval(data[6]) == 1) 
                    {
						strButton = "<center> "
                                + "<div class='alert alert-success' role='alert'>Encuesta contestada!</div>"
                                + "</center>";
                        return strButton;
                    }else{
						return "-";
					}
                }
            }
        ],
        "fnCreatedRow": function (row, data, index) {;     
			$(row).find(".survey").click(function () {
                $(".modal-body").load("proceso_encuesta_ventanilla_escolares.jsp",{xEvaluado:data[8],xPersona:data[9],xEncuesta:83},function(){
                    $("#myModal").modal("show");
                });
            });
        },
        "fnRowCallback": function (nRow, aData, iDisplayIndex, iDisplayIndexFull) {
            //console.log((anio + "-" + mes + "-" + dia) +" = "+aData[2]);
            if ((anio + "-" + mes + "-" + dia) === (aData[2])) {
                $("td", nRow).css("color", "#0091EA");
//                $("td", nRow).css("background-color", "#0091EA");
//                $("td", nRow).css("color", "#FAFAFA");
                $("td", nRow).parent().attr("title", "Cita para el día de hoy");
            }
        },
        "language": {
            "lengthMenu": "Mostrar&nbsp;&nbsp;_MENU_&nbsp;&nbsp;registros por página",
            "zeroRecords": "No tienes citas registradas",
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
    table.buttons().container().appendTo(reporteTurnoAlumno.tblCitas + '_wrapper .col-sm-6:eq(0)');
    table.columns().every(function () {
        let that = this;
        $('input', this.footer()).on('keyup change', function () {
            if (that.search() !== this.value) {
                that.search(this.value).draw();
            }
        });
    });
};

ReporteTurnoAlumno.prototype.listarCitas = function () {
    let tblCitas = $(reporteTurnoAlumno.tblCitas).DataTable();
    tblCitas.clear().draw();
    $.ajax({
        type: "POST",
        dataType: "json",
        url: reporteTurnoAlumno.controladorJsp,
        data: {"accion": 1},
        beforeSend: function (xhr) {
//                    console.log("xhr: " + xhr);
            reporteTurnoAlumno.preLoader();
        },
        success: function (data, textStatus, jqXHR) {
//                    console.log("data: " + data + " | textStatus: " + textStatus + " | jqXHR: " + jqXHR);
//                    console.log(data);
            if (data.length > 0) {
                for (let i = 0; i < data.length; i++) {
                    tblCitas.row.add([
                        i+1,
                        data[i].area_atencion,
                        data[i].nombre,
                        data[i].fecha_atencion,
                        data[i].horario,
//                        data[i].fecha_registro,
//                        data[i].matricula,
//                        data[i].alumno,
//                        data[i].mail,
//                        data[i].movil,
//                        data[i].cve_empleado,
                        data[i].asistente,
                        data[i].existe,
                        data[i].asistencia,
                        data[i].cve_cita_alumno_escolar,
                        data[i].cve_alumno,
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

$("#myModal").on("hidden.bs.modal", function () {
    reporteTurnoAlumno.listarCitas();
});

/****** Inicializacion *******/

//Creacion del objeto
reporteTurnoAlumno = new ReporteTurnoAlumno();

//Mostrar Preloader
reporteTurnoAlumno.preLoader();

//Creacion de la tabla
reporteTurnoAlumno.inicializarTabla();

//Listar citas en la tabla
reporteTurnoAlumno.listarCitas();

//Cerrar Preloader
swal.close();
