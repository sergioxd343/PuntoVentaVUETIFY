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
                            Importar Empleados
                        </v-card-title>
                        <v-container fluid>
                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                <!--OBJETIVO-->
                                <v-col md="12">
                                    <template>
                                        <v-file-input id="archivoInput" accept=".json" v-model="files" counter label="Importar"
                                            multiple placeholder="Seleccione los archivos" prepend-icon="mdi-paperclip"
                                            persistent-hint outlined :show-size="1000" v-validate="'required'"
                                            data-vv-name="Importar" :error="errors.has('Importar')"
                                            :error-messages="errors.first('Importar')">
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
                            <!--BOTONES CRUD-->
                            <v-row justify="center">
                                <v-btn color="primary" @click="flagEditar ? fnEditar() : fnGuardar()">
                                    <v-icon>{{ flagEditar ? 'mdi-download' : 'mdi-content-save' }}</v-icon>
                                    {{ flagEditar ? 'Editar' : 'Guardar' }}
                                </v-btn>
                                &nbsp;
                                <v-btn color="error" @click="fnLimpiarCampos()">
                                    <v-icon>mdi-cancel</v-icon>Cancelar
                                </v-btn>
                            </v-row>
                            <v-row justify="center">
                                <v-col>
                                    <v-data-table :headers="headerEmpleado" :items="dataEmpleado" class="elevation-2"
                                        no-data-text="No se encontro ningun registro" :hide-default-header="dataEmpleado.length < 1"
                                        :hide-default-footer="dataEmpleado.length < 1" locale="es-ES" :mobile-breakpoint="NaN" items-per-page="10">
                                        <template v-slot:item.estatus="{item}">
                                            <v-chip class="ma-2" style="width: 80px; display: flex; justify-content: center; align-items: center;"
                                                link @click="fnCambiarEstatus(item)" :color="item.activo ? 'success' : 'grey'" outlined>
                                                {{ item.activo ?
                                                "Activo" : "Inactivo" }}
                                            </v-chip>
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
                        "../../controlador/sistema/Controlador_empleados.jsp";
                    //Variables POST
                    const empleados = ref([]);
                    const dataEmpleado = ref([]);

                    //Otras variables
                    const flagEditar = ref(false);
                    const itemEditar = ref({});

                    const headerEmpleado = ref([
                        { text: "No.", align: "left", sortable: true, value: "numero_fila" },
                        { text: "Nombre", align: "left", sortable: true, value: "nombre" },
                        { text: "Primer Apellido", align: "left", sortable: true, value: "apellido_paterno" },
                        { text: "Segundo Apellido", align: "left", sortable: true, value: "apellido_materno" },
                        { text: "Nombre Usuario", align: "left", sortable: true, value: "nombre_usuario" },
                        { text: "RFC", align: "left", sortable: true, value: "rfc" },
                        { text: "Estatus", align: "center", sortable: false, value: "estatus" }
                    ]);
                    //Files
                    const files = ref([]);


                    //SNACKBAR
                    const loader = ref(false);
                    const snackbar = ref(false);
                    const mensaje_snackbar = ref("");
                    const color_snackbar = ref("");
                    //Loaders
                    //Dialogs
                    //DataTable


                    onMounted(() => {
                        fnConsultarTabla();
                    });

                    async function fnConsultarTabla() {
                        try {
                            preloader("../../");
                            let parametros = new URLSearchParams();
                            parametros.append("accion", 2);
                            let { data, status } = await axios.post(ctr, parametros);
                            if (status == 200) {
                                if (data.length > 0) {
                                    dataEmpleado.value = data;
                                }
                            }
                        } catch (error) {
                            mostrarSnackbar("error");
                            console.error(error);
                        } finally {
                            swal.close();
                        }
                    }

                    async function fnGuardar() {
                        this.$validator.validate().then(async (esValido) => {
                        try {
                            // Llamar a la función fnLeerArchivo para obtener los datos
                            const datos = await fnLeerArchivo();
                            console.log("🚀 ~ file: empleados.jsp:184 ~ this.$validator.validate ~ datos:", datos)

                            // Recorrer los datos y realizar las operaciones necesarias
                            for (const element of datos) {
                                console.log("🚀 ~ file: empleados.jsp:187 ~ empleados.value.forEach ~ element:", element)
                                preloader("../../");

                                // Crear los parámetros para la solicitud POST
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 1);
                                parametros.append("nombre", element.nombre);
                                parametros.append("apellido_paterno", element.apellido_paterno);
                                parametros.append("apellido_materno", element.apellido_materno);
                                parametros.append("email", element.email);
                                parametros.append("movil", element.movil);
                                parametros.append("curp", element.curp);
                                parametros.append("rfc", element.rfc);
                                parametros.append("sexo", element.sexo);
                                parametros.append("fecha_nacimiento", element.fecha_nacimiento.split("-").reverse().join("-"));
                                parametros.append("cve_puesto", element.cve_puesto); 
                                parametros.append("cve_tipo_puesto", element.cve_tipo_puesto);
                                parametros.append("cve_departamento", element.cve_departamento);
                                parametros.append("cve_area", element.cve_area);
                                parametros.append("cve_ugac", element.cve_ugac);
                                parametros.append("cve_unidad_academica", element.cve_unidad_academica);
                                parametros.append("fecha_ingreso", element.fecha_ingreso.split("-").reverse().join("-"));
                                parametros.append("titulo_recibido", element.titulo_recibido);
                                parametros.append("grado_estudio", element.grado_estudio);
                                parametros.append("nombre_usuario", element.nombre_usuario);
                                parametros.append("contrasenia", element.contrasenia);
                                console.log("🚀 ~ file: empleados.jsp:212 ~ datos.forEach ~ parametros:", parametros)
                                // Realizar la solicitud POST utilizando axios
                                let { data, status } = await axios.post(ctr, parametros);

                                if (status == 200) {
                                    if (data == "1") {
                                        mostrarSnackbar(
                                            "success",
                                            "Registro actualizado correctamente."
                                        );
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

                    function fnLeerArchivo() {
                        return new Promise(function (resolve, reject) {
                            // Obtener el array de archivos seleccionados
                            var archivosSeleccionados = document.getElementById("archivoInput").files;

                            // Recorrer cada archivo
                            for (var i = 0; i < archivosSeleccionados.length; i++) {
                                var archivo = archivosSeleccionados[i];

                                // Crear un objeto FileReader
                                var lector = new FileReader();

                                // Definir la función que se ejecutará cuando se complete la lectura del archivo
                                lector.onload = function (evento) {
                                    var contenidoArchivo = evento.target.result;
                                    empleados.value = JSON.parse(contenidoArchivo);
                                    resolve(empleados.value);
                                    console.log("🚀 ~ file: empleados.jsp:255 ~ fnLeerArchivo ~ empleados:", empleados)
                                };
                                // Leer el archivo como texto
                                lector.readAsText(archivo);
                            }
                        });
                    
                    }


                    function fnLimpiarCampos(cx) {

                        files.value = [];
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
                        empleados,
                        dataEmpleado,
                        headerEmpleado,
                        files,
                        mostrarSnackbar,
                        fnGuardar,
                        fnLeerArchivo,
                        fnConsultarTabla,
                        fnLimpiarCampos,
                        flagEditar,
                        itemEditar,
                    };
                },
            });

            Vue.config.devtools = true;
        </script>

    </html>