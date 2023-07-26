<%@page contentType="text/html; charset=UTF-8" language="java" errorPage="" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900" rel="stylesheet" />
        <link href="../../styles/icon_material_design_4495/css/materialdesignicons.min.css" rel="stylesheet" />
        <link href="../../javascript/VueJs/sweetalert2/sweetalert2.css" />
        <link href="../../javascript/VueJs/vuetify/vuetify.min.css" rel="stylesheet" />
        <link rel="shortcut icon" href="../../images/favicon.ico" type="image/x-icon">
        <meta name="viewport"
            content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui" />
        <script src="../../javascript/VueJs/vue/vue.js"></script>
        <script type="" src="../../javascript/VueJs/vue/vue-composition-api.prod.js"></script>
        <title>Solicitud De registro de capacitacíon interna</title>
    </head>
    <style>
        body {
            font-family: "Roboto";
        }

        .direccion {
            width: 100%;
        }


        .th,
        .td {
            border: 1px solid black;
            padding: 10px;
        }

        .th {
            background-color: #41da9f;
        }

        .tituloTh {
            font-weight: bold;
            margin-left: 39px;
            margin-right: 39px;
            text-align: center;
        }

        #tabla {
            border-collapse: collapse;
            margin: auto;
        }

        .align-center {
            align-items: center;
        }

        .fixed-width {
            width: 80px;
        }
    </style>

    <body>
        <div id="app">
            <v-app>
                <v-container fluid>
                    <v-card>
                        <v-card-title style="background-color: #00b293; color:#ffffff;">
                            Cuestionario de evaluación de cursos
                        </v-card-title>
                        <v-container fluid>
                            <v-row justify="center" dense>
                                <v-col md="12">
                                    <template>
                                        <v-file-input id="archivoInput" accept=".xlsx" v-model="files" counter
                                            label="Importar" multiple placeholder="Seleccione los archivos"
                                            prepend-icon="mdi-paperclip" persistent-hint outlined :show-size="1000"
                                            v-validate="'required'" data-vv-name="Importar"
                                            :error="errors.has('Importar')" :error-messages="errors.first('Importar')">
                                            <template v-slot:selection="{ index, text }">
                                                <v-chip v-if="index < 2" color="deep-purple accent-4" dark label small>
                                                    {{ text }}
                                                </v-chip>

                                                <span v-else-if="index === 2"
                                                    class="text-overline grey--text text--darken-3 mx-2">
                                                    +{{ files.length - 2 }} File(s)
                                                </span>
                                            </template>
                                        </v-file-input>
                                    </template>
                                </v-col>
                            </v-row>
                            <%-- <v-row justfy="center" dense> </v-row> --%>
                                <v-row justify="center">
                                    <v-btn color="primary"
                                        @click="fnGuardar()"><v-icon>mdi-content-save</v-icon>Guardar</v-btn>
                                    &nbsp;
                                    <v-btn color="error"
                                        @click="fnLimpiarCampos()"><v-icon>mdi-cancel</v-icon>Cancelar</v-btn>
                                </v-row>
                                <v-row justify="center">
                                    <v-col>
                                        <v-data-table :headers="headerCuestionario" :items="dataCuestionario"
                                            class="elevation-2" no-data-text="No se encontro ningun registro"
                                            :hide-default-header="dataCuestionario.length < 1"
                                            :hide-default-footer="dataCuestionario.length < 1" locale="es-ES"
                                            :mobile-breakpoint="NaN" items-per-page="10">
                                            <template v-slot:item.status="{item}">
                                                <v-chip link @click="fnCambiarEstatus(item)"
                                                    style="width: 110px; display: flex; justify-content: center; align-items: center;"
                                                    class="ma-2" :color="item.activo ? 'indigo' : 'grey'" outlined pill>
                                                    {{ item.activo ?
                                                    "Abierto" : "Cerrado" }}
                                                    <v-icon right>
                                                        {{ item.activo ? 'mdi-lock-open' : 'mdi-lock' }}
                                                    </v-icon>
                                                </v-chip>
                                            </template>
                                            <template v-slot:item.estatus="{item}">
                                                <v-chip link @click="fnCambiarEstatus(item)"
                                                    style="width: 110px; display: flex; justify-content: center; align-items: center;"
                                                    class="ma-2" :color="item.activo ? 'green' : 'error'" outlined pill>
                                                    {{ item.activo ?
                                                    "Validado" : "Cancelado" }}
                                                    <v-icon right>
                                                        {{ item.activo ? 'mdi-check' : 'mdi-close' }}
                                                    </v-icon>
                                                </v-chip>
                                            </template>
                                            <template v-slot:item.comentario="{item}">
                                                <v-tooltip bottom>
                                                    <template v-slot:activator="{ on, attrs }">
                                                        <v-icon color="grey" dark v-bind="attrs" v-on="on">
                                                            mdi-comment
                                                        </v-icon>
                                                    </template>
                                                    <span>Esta es una nota</span>
                                                </v-tooltip>
                                            </template>
                                        </v-data-table>
                                    </v-col>
                                </v-row>
                        </v-container>
                    </v-card>
                </v-container>
                <!-- TODO: ALERTAS DE SISTEMA-->
                <v-snackbar v-model=" snackbar" top="top" :bottom="true" :multi-line="true" :color="color_snackbar">
                    {{ mensaje_snackbar }}
                    <%-- <v-icon color="white" @click="snackbar = false">mdi-close-circle</v-icon>
                        --%>
                </v-snackbar>
                <v-overlay :value="loader" z-index="1000">
                    <v-img aspect-ratio="2" class="white--text align-end" height="212px" width="292px"
                        src="../images/Logo_utl_animado.gif">
                    </v-img>
                </v-overlay>
            </v-app>
        </div>
    </body>
    <script src="../../javascript/axios/axios.js"></script>
    <script src="../../javascript/VueJs/vuetify/vuetify.min.js"></script>
    <script src="../../javascript/VueJs/vee-validate/vee-validate.js"></script>
    <script src="../../javascript/VueJs/vee-validate/es.js"></script>
    <script src="../../javascript/VueJs/sweetalert2/sweetalert2.all.js"></script>
    <script src="../../javascript/unpkg.com_xlsx@0.18.5_dist_xlsx.full.min.js"></script>


    <%--Desarrollo--%>
        <script type="module">
            import {
                preloader,
                guardar,
                errorGuardar,
                actualizar,
                errorActualizar,
                eliminar,
                errorEliminar,
                cerrar,
                confirmarE,
                aviso,
                confirmar,
            } from "../../javascript/mensajeSistema/mensajes_sweetalert_vue.js";
            Vue.use(VeeValidate, {
                classes: true,
            });

            //Lenguaje de VeeValidate
            VeeValidate.Validator.localize("es");

            new Vue({
                el: "#app",
                vuetify: new Vuetify(),
                setup() {
                    const { ref, onMounted, watch } = VueCompositionAPI;
                    const ctr =
                        "../../controlador/formacion_docente/Controlador_catalogo_cuestionario_evaluacion_curso.jsp";
                    //Variables POST
                    const currentUser = localStorage.getItem('currentUser');
                    const user = JSON.parse(currentUser);
                    const cve_usuario = user[0].cve_usuario;
                    const dataCuestionario = ref([]);


                    //Otras variables
                    const flagEditar = ref(false);
                    const itemEditar = ref({});
                    const files = ref([]);
                    //Combo


                    //SNACKBAR
                    const loader = ref(false);
                    const snackbar = ref(false);
                    const mensaje_snackbar = ref("");
                    const color_snackbar = ref("");
                    //Loaders
                    //Dialogs
                    //DataTable
                    const headerCuestionario = ref([
                        { text: "No.", align: "left", sortable: true, value: "numero_fila" },
                        { text: "Nombre instructor", align: "left", sortable: true, value: "nombre_instructor" },
                        { text: "Jornada", align: "left", sortable: true, value: "nombre_jornada" },
                        { text: "Fecha", align: "left", sortable: true, value: "fecha" },
                        { text: "Calificación Curso y contenido", align: "center", sortable: true, value: "cali_curso_contenido" },
                        { text: "Calificación Facilitador(a)", align: "center", sortable: true, value: "cali_facilitador" },
                        { text: "Calificación Organización", align: "center", sortable: true, value: "cali_organizacion" },
                        { text: "Calificación Impacto y aplicación", align: "center", sortable: true, value: "cali_impacto_aplicacion" },
                        { text: "Aprendizaje", align: "left", sortable: true, value: "principal_aprendizaje" },
                        { text: "Comentarios", align: "left", sortable: true, value: "comentarios" },
                        { text: "Estatus", align: "left", sortable: true, value: "estatus" },
                        { text: "Status", align: "left", sortable: true, value: "status" },
                        { text: "Nota", align: "left", sortable: true, value: "comentario" },
                    ]);

                    onMounted(() => {
                        fnCargarTabla();
                    });

                    async function fnGuardar() {
                        this.$validator.validate().then(async (esValido) => {
                            try {
                                // Llamar a la función fnLeerArchivo para obtener los datos
                                const datos = await fnLeerArchivo();
                                datos.shift();
                                preloader("../../");
                                // Recorrer los datos y realizar las operaciones necesarias
                                for (const element of datos) {
                                    // Crear los parámetros para la solicitud POST
                                    let parametros = new URLSearchParams();
                                    parametros.append("accion", 1);
                                    let cve_jornada = 0;
                                    switch (element.jornada) {
                                        case 'Matutino 8:00 a 12:00 horas;':
                                            cve_jornada = 1;
                                            break;
                                        case 'Diurno 12:00 a 16:00 horas;':
                                            cve_jornada = 2;
                                            break;
                                        case 'Vespertino 15:00 a 20:00 horas;':
                                            cve_jornada = 3;
                                            break;
                                        case 'Vespertino-Nocturno 16:00 a 21:00 horas;':
                                            cve_jornada = 4;
                                            break;
                                    }
                                    parametros.append("cve_jornada", cve_jornada);
                                    parametros.append("nombre_instructor", element.nombre);
                                    const numeroSerie = element.hora_fin;
                                    const fechaConvertida = new Date((numeroSerie - 25569) * 86400 * 1000);
                                    const fechaFormateada = fechaConvertida.toLocaleDateString();
                                    parametros.append("fecha", fechaFormateada.split("/").reverse().join("-"));
                                    parametros.append("cali_curso_contenido", (parseInt(element.pregunta_uno) + parseInt(element.pregunta_dos) + parseInt(element.pregunta_tres) + parseInt(element.pregunta_cuatro) + parseInt(element.pregunta_cinco)) / 5);
                                    parametros.append("cali_facilitador", (parseInt(element.pregunta_seis) + parseInt(element.pregunta_siete) + parseInt(element.pregunta_ocho) + parseInt(element.pregunta_nueve)) / 4);
                                    parametros.append("cali_organizacion", (parseInt(element.pregunta_diez) + parseInt(element.pregunta_once) + parseInt(element.pregunta_doce) + parseInt(element.pregunta_trece)) / 4);
                                    parametros.append("cali_impacto_aplicacion", (parseInt(element.pregunta_catorce) + parseInt(element.pregunta_quince) + parseInt(element.pregunta_dieciseis)) / 3);
                                    parametros.append("principal_aprendizaje", element.aprendizaje);
                                    parametros.append("comentarios", element.comentario);
                                    parametros.append("cve_usuario", cve_usuario);// Realizar la solicitud POST utilizando axios
                                    let { data, status } = await axios.post(ctr, parametros);

                                    if (status == 200) {
                                        if (data == "1") {
                                            mostrarSnackbar(
                                                "success",
                                                "Registro actualizado correctamente."
                                            );
                                            fnCargarTabla();
                                            //fnConsultarTabla();
                                            // this.$validator.pause();
                                            // Vue.nextTick(() => {
                                            //     this.$validator.errors.clear();
                                            //     this.$validator.resume();
                                            // });
                                        }
                                    }
                                }
                            } catch (error) {
                                mostrarSnackbar("error");
                                console.error(error);
                            } finally {
                                swal.close();
                            }
                        });
                    }

                    async function fnCambiarEstatus(item) {
                        try {
                            preloader("../");
                            let parametros = new URLSearchParams();
                            parametros.append("accion", 3);
                            parametros.append("cve_cuest_eval_curso", item.cve_cuest_eval_curso);
                            parametros.append("activo", (item.activo == true ? 0 : 1)); console.log("🚀 ~ file: perfil_usuario.jsp:283 ~ fnCambiarEstatus ~ parametros:", parametros)
                            let { data, status } = await axios.post(ctr, parametros);
                            if (status == 200) {
                                if (data == "1") {
                                    mostrarSnackbar(
                                        "success",
                                        "Registro actualizado correctamente."
                                    );
                                    fnCargarTabla();
                                    // this.$validator.pause();
                                    // Vue.nextTick(() => {
                                    //     this.$validator.errors.clear();
                                    //     this.$validator.resume();
                                    // });
                                }
                            }
                        } catch (error) {
                            mostrarSnackbar("error");
                            console.error(error);
                        } finally {
                            swal.close();
                        }
                    }

                    async function fnCargarTabla() {
                        try {
                            preloader("../../");
                            let parametros = new URLSearchParams();
                            parametros.append("accion", 2);
                            let { data, status } = await axios.post(ctr, parametros);
                            if (status == 200) {
                                if (data.length > 0) {
                                    dataCuestionario.value = data;
                                }
                            }
                        } catch (error) {
                            mostrarSnackbar("error");
                            console.error(error);
                        } finally {
                            swal.close();
                        }
                    }

                    function fnLeerArchivo() {
                        return new Promise(function (resolve, reject) {
                            const fileInput = document.getElementById('archivoInput');
                            const files = fileInput.files;

                            if (files.length === 0) {
                                mostrarSnackbar('warning', 'No se seleccionaron archivos');
                                return;
                            }
                            console.log("🚀 ~ file: cuestionario_evaluacion_cursos.jsp:368 ~ files.length:", files.length)


                            for (var i = 0; i < files.length; i++) {
                                const file = files[i];
                                const reader = new FileReader();

                                reader.onload = function (e) {
                                    const data = new Uint8Array(e.target.result);
                                    const workbook = XLSX.read(data, { type: 'array' });

                                    // Leer la primera hoja del archivo
                                    const worksheet = workbook.Sheets[workbook.SheetNames[0]];

                                    // Obtener los datos en formato JSON
                                    const jsonData = XLSX.utils.sheet_to_json(worksheet, {
                                        header: [
                                            "cve",
                                            "hora_inicio",
                                            "hora_fin",
                                            "correo",
                                            "nombre",
                                            "pregunta_uno",
                                            "pregunta_dos",
                                            "pregunta_tres",
                                            "pregunta_cuatro",
                                            "pregunta_cinco",
                                            "pregunta_seis",
                                            "pregunta_siete",
                                            "pregunta_ocho",
                                            "pregunta_nueve",
                                            "pregunta_diez",
                                            "pregunta_once",
                                            "pregunta_doce",
                                            "pregunta_trece",
                                            "pregunta_catorce",
                                            "pregunta_quince",
                                            "pregunta_dieciseis",
                                            "aprendizaje",
                                            "comentario",
                                            "jornada",
                                        ],
                                    });
                                    // Transformar los datos al formato deseado
                                    resolve(jsonData);
                                };

                                reader.readAsArrayBuffer(file);
                            }
                        });
                    }


                    function fnLimpiarCampos(cx) {
                        //cx = contexto
                        nombre.value = "";
                        primer_apellido.value = "";
                        segundo_apellido.value = "";
                        nombre_usuario.value = "";
                        rfc.value = "";
                        genero.value = "";
                        email.value = "";
                        movil.value = "";
                        perfil.value = "";

                        flagEditar.value = false;
                        itemEditar.value = {};

                        if (this == undefined) cx.$validator.reset();
                        else this.$validator.reset();
                    }

                    function mostrarSnackbar(color, texto) {
                        snackbar.value = true;
                        color_snackbar.value = color;
                        if (color == "error")
                            mensaje_snackbar.value =
                                "Ocurrió un error. Intentalo de nuevo más tarde.";
                        else mensaje_snackbar.value = texto;
                    }

                    return {
                        color_snackbar,
                        snackbar,
                        mensaje_snackbar,
                        loader,
                        files,
                        currentUser,
                        dataCuestionario,
                        headerCuestionario,
                        user,
                        cve_usuario,
                        mostrarSnackbar,
                        fnLeerArchivo,
                        fnCambiarEstatus,
                        flagEditar,
                        fnGuardar,
                        fnLimpiarCampos,
                        fnCargarTabla,
                        itemEditar,
                    };
                },
            });

            Vue.config.devtools = true;
        </script>

    </html>