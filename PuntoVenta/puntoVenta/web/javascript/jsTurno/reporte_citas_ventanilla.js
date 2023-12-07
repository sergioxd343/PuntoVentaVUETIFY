/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
        var table;
function reporte_citas_ventanilla() {
    this.crt = "controlador/Controlador_reporte_asistencia.jsp";


    this.table = null;
    this.id = 0;
    this.Matricula = $("#xMatricula");
    this.Proceso = $("#xProceso");
    this.activo = 0;
    this.yAccion = 0;
    this.post = null;
    this.fnSelectProcesos();

}

reporte_citas_ventanilla.prototype.fnSelectProcesos=function()
{
    
    
     var o = this;
     o.fnLoading()
        this.post = $.post(o.crt, {yAccion: 3}, 'json');
        this.post.done(function (data) {
            data = JSON.parse(data);
            o.Proceso.find('option').remove();  
            o.Proceso.append('<option value=0>Selecciona una opción</option>'); 
            $(data).each(function(index, value) 
            {
                o.Proceso.append('<option value=' + value.cve_cita_proceso_escolar + '>' + value.nombre + '</option>');
            });
            o.fnReady();
        });
    
}

reporte_citas_ventanilla.prototype.fnTabla = function ()
{
    //   objConfiguracion.fnLoading();
    var o = this;
    o.fnLoading()
    table = $('#tableVentanilla').DataTable({
        "initComplete": function (settings, json) {
            o.fnReady();
			
        },
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
        "ajax": {
            url: o.crt,
            type: "POST",
            data: function (d) {
                d.yAccion = 2;
                d.xMatricula = o.Matricula.val();
                d.xProceso = o.Proceso.val();
            }
        },
        "bDestroy": true,
        "bSortable": false,
        "fnCreatedRow": function (row, data, index) {


            $(row).find(".inactive").click(function () {
                objCitasVentanilla.fnAsistencia(data["id"], 1)
            });
            $(row).find(".active").click(function () {
                objCitasVentanilla.fnAsistencia(data["id"], 0)
            });
			
			$(row).find(".survey").click(function () {
                $(".modal-body").load("proceso_encuesta_ventanilla_escolares.jsp",{xEvaluado:data["id"],xPersona:data["id_alumno"],xEncuesta:83},function(){
                    $("#myModal").modal("show");
                });
            });
        },
        "aoColumns": [
            {"mData": "id", "visible": false, },
			{"mData": "id_alumno", "visible": false, },
            {"mData": "fecha"},
            {"mData": "horario"},
            {"mData": "matricula"},
            {"mData": "nombre_alumno"},
            {"mData": "proceso"},
            {"mData": "persona_ventanilla"},
            {"mData": null,
                "className": "text-center",
                "mRender": function (data, type, row) {
				
                    if (data["asistencia"] == 1 && data["existe"] == 0) {
                        strButton = "<center> "
                                + "<button class='btn btn-success active'  ><span class='fa fa-check-circle' aria-hidden='true'></span></button "
                                + "</center>";
                        return strButton;
                        //return "Activo"
                    } else if ((data["asistencia"] == 1 && data["existe"] == 1) ){
                        strButton = "<center> "
                                + "<button class='btn btn-success active' disabled='disabled'  ><span class='fa fa-check-circle' aria-hidden='true'></span></button "
                                + "</center>";
                        return strButton;
                        //return "Inactivo"
                    }else if((data["asistencia"] == 0 && data["existe"] == 1)){
						strButton = "<center> "
                                + "<button class='btn btn-danger inactive' disabled='disabled'  ><span class='fa fa-ban' aria-hidden='true'></span></button "
                                + "</center>";
                        return  strButton;
					}else{
						strButton = "<center> "
                                + "<button class='btn btn-danger inactive'   ><span class='fa fa-ban' aria-hidden='true'></span></button "
                                + "</center>";
                        return  strButton;
					}
                }
            },
        {"mData": null,
                "className": "text-center",
                "mRender": function (data, type, row) {
                    if (data["existe"] == 0 && data["asistencia"] == 1) {
                        strButton = "<center> "
                                + "<button class='btn btn-warning survey'  ><span class='fa fa-comment-o' aria-hidden='true'></span></button "
                                + "</center>";
                        return strButton;
                        //return "Activo"
                    } else if(data["existe"] == 1) {
						strButton = "<center> "
                                + "<button class='btn btn-success' disabled='disabled'  >Encuesta contestada!</button "
                                + "</center>";
                        return strButton;
                    }else{
						return "-";
					}
                }
            }]
    });

}

/**               
 * Metodo      : "fnActivar"
 * Descripcion: "cambia de estatus activo al especialidad seleccionado."
 */
reporte_citas_ventanilla.prototype.fnAsistencia = function (id, activo)
{
    this.id = id;

    if (this.id > 0)
    {
        var o = this;
        this.post = $.post(o.crt, {yAccion: 1, yId: o.id, yActivo: activo}, 'json');
        this.post.done(function (data) {
            data = JSON.parse(data);
            swal({
                title: data.title,
                text: data.text,
                type: data.type,
                confirmButtonText: data.confirmButtonText,
                closeOnConfirm: false,

            }).then(function () {
                $('#tableVentanilla').DataTable().ajax.reload(null, false);
                o.yAccion = 1;
                o.id = 0;
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


//Bloquear pantalla mientras carga datos
reporte_citas_ventanilla.prototype.fnLoading = function () {
    swal({
        allowOutsideClick: false,
        imageUrl: "../../images/Logo_utl_animado.gif",
        showCancelButton: false, // There won't be any cancel button
        showConfirmButton: false // There won't be any confirm button
    });
}

//Función para quitar bloqueo de Loading
reporte_citas_ventanilla.prototype.fnReady = function () {
    swal.close();
}


$(document).ready(function () {
    objCitasVentanilla = new reporte_citas_ventanilla();

    $("#xProceso").change(function () {
        if (parseInt($(this).val()) > 0) {
            $("#xdvBusqueda").show();
			$("#xdvCancelar").show();
        } else {
            $("#xdvBusqueda").hide();
			$("#xdvCancelar").hide();
        }
    });

    $("#xBuscarMatricula").click(function (e) {
        e.preventDefault();
        if (objCitasVentanilla.Matricula.val().length > 7) {
            objCitasVentanilla.fnTabla()
        } else {
            swal({
                title: "Error!",
                text: "No tecleó una matrícula valida",
                type: "error",
                confirmButtonText: "Aceptar"
            })
        }

    });
	
	$("#xMatricula").keydown(function (e) {
        if (e.which == 13) {
            if (objCitasVentanilla.Matricula.val().length > 7) {
                objCitasVentanilla.fnTabla()
            } else {
                swal({
                    title: "Error!",
                    text: "No tecleó una matrícula valida",
                    type: "error",
                    confirmButtonText: "Aceptar"
                })
            }

        }
    });
	
	$("#xLimpiar").click(function (e) {
        e.preventDefault();
        objCitasVentanilla.Matricula.val("")
        $('#tableVentanilla').DataTable().clear().draw();
        objCitasVentanilla.Proceso.val(0);
		$("#xdvBusqueda").hide();
        $("#xdvCancelar").hide();
		
    });
});

