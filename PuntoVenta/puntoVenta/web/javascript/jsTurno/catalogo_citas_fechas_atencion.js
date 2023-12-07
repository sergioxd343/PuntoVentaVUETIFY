/*
 * 
 * Actualizacion: Oscar
 * Descripcion  : Se agrego combo para seleccionar los dias a posponer, ademas de la columna para mostrarlos
 * Fecha        : 2017-08-16
 * 
 */


var table;
function catalogo_citas_fechas_atencion() {

    this.crt = "controlador/Controlador_catalogo_citas_fechas_atencion.jsp";

    this.fnTabla();
    this.table = null;
    this.id = 0;
    this.cve_cita_fecha_atencion = 0;
    this.cve_cita_proceso_escolares = 0;
    this.Proceso = $("#xProcesoEscolar");
    this.Inicio = $("#xFechaInicio")
    this.Termino = $("#xFechaTermino")
    this.xDiasPosponer = $("#xDiasPosponer");
    this.activo = 0;
    this.yAccion = 1;
    this.post = null;
    this.fnCalendario();
    this.fnSelectProcesos();
    $('[data-toggle="tooltip"]').tooltip();
}


catalogo_citas_fechas_atencion.prototype.fnCalendario = function ()
{
    $.fn.datepicker.dates['en'] = {
        days: ["Domingo", "Lunes", "Martes", "Miercoles", "Jueves", "Vierdes", "Sabado"],
        daysShort: ["Dom", "Lun", "Mar", "Mie", "Jue", "Vie", "Sab"],
        daysMin: ["Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sa"],
        months: ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"],
        monthsShort: ["Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"],
        today: "Hoy",
        clear: "Limpiar",
        format: "mm/dd/yyyy",
        titleFormat: "MM yyyy", /* Leverages same syntax as 'format' */
        weekStart: 0
    };
    $('.datepicker').datepicker({
        format: 'yyyy-mm-dd',
        startDate: '+0d',
        autoclose: 'true'
    });

}

catalogo_citas_fechas_atencion.prototype.fnSelectProcesos = function ()
{
    swal({
        allowOutsideClick: false,
        imageUrl: "../../images/Logo_utl_animado.gif",
        showCancelButton: false, // There won't be any cancel button
        showConfirmButton: false // There won't be any confirm button
    });

    var o = this;
    this.post = $.post(o.crt, {yAccion: 4}, 'json');
    this.post.done(function (data) {
        data = JSON.parse(data);
        o.Proceso.find('option').remove();
        o.Proceso.append('<option value=0>Selecciona un opción</option>');
        $(data).each(function (index, value)
        {
            o.Proceso.append('<option value=' + value.cve_cita_proceso_escolar + '>' + value.nombre + '</option>');
        });
        swal.close();
    });

}


catalogo_citas_fechas_atencion.prototype.fnTabla = function ()
{
    var o = this;
    table = $('#tableProcesos').DataTable({

        "oLanguage": {

            "sLoadingRecords": "Espere un momento - cargando...",
            "sLengthMenu": "Mostrar _MENU_ registros",
            "sEmptyTable": "No hay registros para mostrar",
            "sInfo": "Mostrando registros de _START_ a _END_ de un total de _TOTAL_ registros",
            "oPaginate": {
                "sPrevious": "Página anterior",
                "sNext": "Siguiente página",
                "sLast": "Última página",
                "sFirst": "Primer página"
            },
            "sSearch": "Buscar:"

        },
        "ajax": o.crt + "?yAccion=5",
        "bDestroy": true,
        "bSortable": false,
        "fnCreatedRow": function (row, data, index) {

            if (parseInt(data["activo"]) === 0)
                $(row).addClass('danger');

            $(row).find(".inactive").click(function () {
                objCitasFechas.fnActivar(data["id"])
            });
            $(row).find(".active").click(function () {
                objCitasFechas.fnEliminar(data["id"])
            });
            $(row).find(".edit").click(function () {
                window.scrollTo(0, 0);
                $("#xDvProceso").hide();
                $("#xDvProcesoInfo").show();
                $("#lblProcesoInfo").html(data["nombre"]);
                objCitasFechas.cve_cita_proceso_escolares = data["id_proceso"];
                objCitasFechas.Inicio.val(data["inicio"]);
                objCitasFechas.Termino.val(data["termino"]);
                objCitasFechas.cve_cita_fecha_atencion = data["id"];
                objCitasFechas.xDiasPosponer.val(data["numero_dias_posponer"]);
                objCitasFechas.yAccion = 2;

            });
        },
        "aoColumns": [
            {"mData": "id", },
            {"mData": "nombre"},
            {"mData": "inicio"},
            {"mData": "termino"},
            {"mData": "numero_dias_posponer"},
            {"mData": "activo",
                "className": "text-center",
                "mRender": function (data, type, row) {
                    if (data == 1) {

                        strButton = "<center> "
                                + "<button class='btn btn-success active' data-toggle='tooltip' data-placement='top' title='Desactivar registro'  ><span class='fa fa-check-circle' aria-hidden='true'></span></button "
                                + "</center>";
                        return strButton;
                        //return "Activo"
                    } else {
                        strButton = "<center> "
                                + "<button class='btn btn-danger inactive' data-toggle='tooltip' data-placement='top' title='Activar registro'  ><span class='fa fa-ban' aria-hidden='true'></span></button "
                                + "</center>";
                        return  strButton;
                        //return "Inactivo"
                    }
                }
            },
            {"mData": null,
                "mRender": function (data, type, full) {

                    strButton = "<center> "
                            + "<button class='btn btn-primary  edit' data-toggle='tooltip' data-placement='top' title='Editar registro' ><span class='fa fa-pencil-square' aria-hidden='true'></span></button "
                            + "</center>";
                    return  strButton;
                    //return "Inactivo"

                },
                "sClass": "text-center", "bSortable": true}]
    });

}

catalogo_citas_fechas_atencion.prototype.fnCancelar = function () {
    $('#forma')[0].reset();
    $("#xDvProceso").show();
    $("#xDvProcesoInfo").hide();
    $("#lblProcesoInfo").html("");
    objCitasFechas.cve_cita_proceso_escolares = 0;
}

/**
 * 
 * @returns {undefined}
 */
catalogo_citas_fechas_atencion.prototype.fnGuardar = function ()
{
    var o = this;
    if (o.xDiasPosponer.val() !== "") {
        if (this.Inicio.size() > 0 && this.Termino.size() > 0 && (this.Proceso.val() > 0 || objCitasFechas.cve_cita_proceso_escolares > 0)) {
            o.cve_cita_proceso_escolares = this.Proceso.val()

            $.ajax({
                type: "POST",
                dataType: "json",
                url: o.crt,
                data: {yAccion: this.yAccion, yId: this.cve_cita_fecha_atencion, xProcesoEscolar: this.cve_cita_proceso_escolares, xFechaInicio: this.Inicio.val(), xFechaTermino: this.Termino.val(), yActivo: 1, xDiasPosponer : o.xDiasPosponer.val()},
                beforeSend: function () {

                }, success: function (data) {
                    swal({
                        title: data.title,
                        text: data.text,
                        type: data.type,
                        confirmButtonText: data.confirmButtonText
                    }).then(function () {
                        $('#tableProcesos').DataTable().ajax.reload();
                        o.yAccion = 1;
                        o.cve_cita_proceso_escolares = 0;
                        objCitasFechas.fnCancelar();
                        $("#xDvProceso").show();
                        $("#xDvProcesoInfo").hide();
                        $("#lblProcesoInfo").html("");
                        objCitasFechas.cve_cita_proceso_escolares = 0;
                    });


                }, error: function () {
                    swal({
                        title: 'Error!',
                        text: 'Hubo un error, intentar más tarde guardar',
                        type: 'error',
                        confirmButtonText: 'Aceptar'
                    });
                }
            });
        } else {
            swal({
                title: 'Error!',
                text: 'El nombre del proceso no debe estár vacío',
                type: 'error',
                confirmButtonText: 'Aceptar'
            });
        }
    } else {
        swal({
            title: '¡Alerta!',
            text: 'Debe seleccionar los días a posponer',
            type: 'warning',
            confirmButtonText: 'Aceptar'
        });
    }




}

catalogo_citas_fechas_atencion.prototype.fnEliminar = function (id)
{
    this.cve_cita_fecha_atencion = id;

    if (this.cve_cita_fecha_atencion > 0)
    {
        var o = this;
        this.post = $.post(o.crt, {yAccion: 6, yId: o.cve_cita_fecha_atencion, yActivo: 0}, 'json');
        this.post.done(function (data) {
            data = JSON.parse(data);
            swal({
                title: data.title,
                text: data.text,
                type: data.type,
                confirmButtonText: data.confirmButtonText,
                closeOnConfirm: false,
            }).then(function () {
                $('#tableProcesos').DataTable().ajax.reload();
                o.cve_cita_fecha_atencion = 0;
                o.yAccion = 0;
                objCitasFechas.fnSelectProcesos();
            });


        });
    } else {
        swal({
            title: "Upss",
            text: "Ha ocurrido un error",
            type: "error",
            confirmButtonText: "Aceptar",
            closeOnConfirm: false,

        })
    }
}

/**               
 * Metodo      : "fnActivar"
 * Descripcion: "cambia de estatus activo al especialidad seleccionado."
 */
catalogo_citas_fechas_atencion.prototype.fnActivar = function (id)
{
    this.cve_cita_fecha_atencion = id;

    if (this.cve_cita_fecha_atencion > 0)
    {
        var o = this;
        this.post = $.post(o.crt, {yAccion: 3, yId: o.cve_cita_fecha_atencion, yActivo: 1}, 'json');
        this.post.done(function (data) {
            data = JSON.parse(data);
            swal({
                title: data.title,
                text: data.text,
                type: data.type,
                confirmButtonText: data.confirmButtonText,
                closeOnConfirm: false,

            }).then(function () {
                $('#tableProcesos').DataTable().ajax.reload();
                o.yAccion = 1;
                o.cve_cita_fecha_atencion = 0;
                objCitasFechas.fnSelectProcesos();
            });
        });
    } else {
        swal({
            title: "Upss",
            text: "Ha ocurrido un error Activar",
            type: "error",
            confirmButtonText: "Aceptar",
            closeOnConfirm: false,

        })
    }
}


$(document).ready(function () {
    objCitasFechas = new catalogo_citas_fechas_atencion();

    $("#xGuardar").click(function (event) {
        event.preventDefault();

        objCitasFechas.fnGuardar();

    });

    $('#xCancelar').click(function (event) {
        event.preventDefault();
        objCitasFechas.fnCancelar();
    });

});
