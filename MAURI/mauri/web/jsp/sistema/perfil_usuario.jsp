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
    </style>

    <body>
        <div id="app">
            <v-app>
                <v-container fluid>
                    <v-card>
                        <v-card-title style="background-color: #00b293; color:#ffffff;">
                            Perfil De Usuario
                        </v-card-title>
                        <v-container fluid>
                            <v-row justify="center" dense>
                                <v-col md="4">
                                    <v-text-field disabled v-model="nombre" outlined label="Nombre"
                                        persistent-hint></v-text-field>
                                </v-col>
                                <v-col md="4">
                                    <v-text-field disabled v-model="primer_apellido" outlined label="Primer Apellido"
                                        persistent-hint></v-text-field>
                                </v-col>
                                <v-col md="4">
                                    <v-text-field disabled v-model="segundo_apellido" outlined label="Segundo Apellido"
                                        persistent-hint></v-text-field>
                                </v-col>
                                <v-col md="4">
                                    <v-text-field disabled v-model="nombre_usuario" outlined label="Nombre Usuario"
                                        persistent-hint></v-text-field>
                                </v-col>
                                <v-col md="4">
                                    <v-text-field disabled v-model="rfc" outlined label="RFC"
                                        persistent-hint></v-text-field>
                                </v-col>
                                <v-col md="4">
                                    <v-text-field disabled v-model="genero" outlined label="Genero"
                                        persistent-hint></v-text-field>
                                </v-col>
                                <v-col md="4">
                                    <v-text-field disabled v-model="email" outlined label="Email"
                                        persistent-hint></v-text-field>
                                </v-col>
                                <v-col md="4">
                                    <v-text-field disabled v-model="movil" outlined label="movil"
                                        persistent-hint></v-text-field>
                                </v-col>
                                <v-col md="4">
                                    <v-autocomplete v-model="perfil" outlined label="Perfil de Usuario"
                                        :disabled="!flagEditar" :items="usuarios" item-value="cve_grupo_seguridad"
                                        item-text="nombre"></v-autocomplete>
                                </v-col>
                            </v-row>
                            <%-- <v-row justfy="center" dense> </v-row> --%>
                                <v-row justify="center">
                                    <v-btn color="primary"
                                        @click="fnEditar()"><v-icon>mdi-content-save</v-icon>Guardar</v-btn>
                                    &nbsp;
                                    <v-btn color="error"
                                        @click="fnLimpiarCampos()"><v-icon>mdi-cancel</v-icon>Cancelar</v-btn>
                                </v-row>
                                <v-row justify="center">
                                    <v-col md="12">
                                        <v-data-table :headers="headerCapacitacion" :items="dataUsuario"
                                            class="elevation-2" no-data-text="No se encontro ningun registro"
                                            :hide-default-header="dataUsuario.length < 1"
                                            :hide-default-footer="dataUsuario.length < 1" locale="es-ES"
                                            :mobile-breakpoint="NaN" items-per-page="10">
                                            <template v-slot:item.editar="{item}">
                                                <v-btn fab small color="warning" @click="flagEditar = true; itemEditar = item;
                                                nombre = item.nombre;
                                                primer_apellido = item.apellido_peterno
                                                segundo_apellido = item.apellido_materno
                                                nombre_usuario = item.nombre_usuario
                                                rfc = item.rfc
                                                genero = item.sexo
                                                email = item.email
                                                movil = item.movil"><v-icon>mdi-card-plus</v-icon></v-btn>
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
                        "../../controlador/sistema/Controlador_perfil_usuario.jsp";
                    //Variables POST
                    const nombre = ref("");
                    const primer_apellido = ref("");
                    const segundo_apellido = ref("");
                    const nombre_usuario = ref("");
                    const rfc = ref("");
                    const genero = ref("");
                    const email = ref("");
                    const movil = ref("");
                    const perfil = ref("");
                    const items = ref([]);
                    const usuarios = ref([]);

                    //Otras variables
                    const flagEditar = ref(false);
                    const itemEditar = ref({});
                    //Combo


                    //SNACKBAR
                    const loader = ref(false);
                    const snackbar = ref(false);
                    const mensaje_snackbar = ref("");
                    const color_snackbar = ref("");
                    //Loaders
                    //Dialogs
                    //DataTable
                    const dataUsuario = ref([]);
                    const headerCapacitacion = ref([
                        { text: "No.", align: "left", sortable: true, value: "numero_fila" },
                        { text: "Nombre", align: "left", sortable: true, value: "nombre" },
                        { text: "Primer Apellido", align: "left", sortable: true, value: "apellido_peterno" },
                        { text: "Segundo Apellido", align: "left", sortable: true, value: "apellido_materno" },
                        { text: "Nombre Usuario", align: "left", sortable: true, value: "nombre_usuario" },
                        { text: "RFC", align: "left", sortable: true, value: "rfc" },
                        { text: "Email", align: "left", sortable: true, value: "email" },
                        { text: "Asignar Acceso", align: "left", sortable: true, value: "editar" }
                    ]);
                    const searchCapacitacion = ref([]);

                    onMounted(() => {
                        fnConsultarTabla();
                        fnPerfiles();
                    });

                    async function fnConsultarTabla() {
                        try {
                            preloader("../../");
                            let parametros = new URLSearchParams();
                            parametros.append("accion", 1);
                            let { data, status } = await axios.post(ctr, parametros);
                            if (status == 200) {
                                if (data.length > 0) {
                                    dataUsuario.value = data;
                                }
                            }
                        } catch (error) {
                            mostrarSnackbar("error");
                            console.error(error);
                        } finally {
                            swal.close();
                        }
                    }

                    async function fnPerfiles() {
                        try {
                            preloader("../../");
                            let parametros = new URLSearchParams();
                            parametros.append("accion", 2);
                            let { data, status } = await axios.post(ctr, parametros);
                            if (status == 200) {
                                if (data.length > 0) {
                                    usuarios.value = data;
                                }
                            }
                        } catch (error) {
                            mostrarSnackbar("error");
                            console.error(error);
                        } finally {
                            swal.close();
                        }
                    }

                    async function fnEditar() {
                        this.$validator.validate().then(async (esValido) => {
                            if (esValido) {
                                try {
                                    preloader("../../");
                                    let parametros = new URLSearchParams();
                                    parametros.append("accion", 3);
                                    parametros.append("cve_grupo_seguridad", perfil.value);
                                    parametros.append("cve_persona", itemEditar.value.cve_persona);
                                    console.log(parametros);
                                    let { data, status } = await axios.post(ctr, parametros);
                                    if (status == 200) {
                                        if (data == "1") {
                                            mostrarSnackbar(
                                                "success",
                                                "Registro actualizado correctamente."
                                            );
                                            fnConsultarTabla();
                                            fnLimpiarCampos(this);
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
                        nombre,
                        primer_apellido,
                        segundo_apellido,
                        nombre_usuario,
                        rfc,
                        genero,
                        email,
                        movil,
                        perfil,
                        items,
                        usuarios,
                        mostrarSnackbar,
                        flagEditar,
                        headerCapacitacion,
                        searchCapacitacion,
                        fnConsultarTabla,
                        dataUsuario,
                        fnLimpiarCampos,
                        fnEditar,
                        itemEditar,
                    };
                },
            });

            Vue.config.devtools = true;
        </script>

    </html>