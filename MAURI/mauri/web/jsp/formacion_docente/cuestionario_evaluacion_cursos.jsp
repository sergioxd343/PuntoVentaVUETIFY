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
                                <v-col md="10">
                                    <v-text-field v-model="nombreCurso" outlined label="Nombre del curso"
                                        persistent-hint v-validate="'required|max:500'" data-vv-name="nombre del curso"
                                        :error="errors.has('nombre del curso')"
                                        :error-messages="errors.first('nombre del curso')"></v-text-field>
                                </v-col>
                                <v-col md="2">
                                    <v-text-field v-model="fecha" outlined label="Fecha" persistent-hint
                                        v-validate="'required|max:500'" data-vv-name="fecha"
                                        :error="errors.has('fecha')" :error-messages="errors.first('fecha')"
                                        readonly></v-text-field>
                                </v-col>
                                <v-col md="9">
                                    <v-text-field v-model="nombreInstructor" outlined
                                        label="Nombre del(a) instructor (a)" persistent-hint
                                        v-validate="'required|max:500'" data-vv-name="nombre del(a) instructor (a)"
                                        :error="errors.has('nombre del(a) instructor (a)')"
                                        :error-messages="errors.first('nombre del(a) instructor (a)')"></v-text-field>
                                </v-col>
                                <v-col md="3">
                                    <p>Tipo de curso: </p>
                                    <v-radio-group v-model="tipoCurso" class="mt-0" v-validate="'required'"
                                        data-vv-name="tipo de curso" :error="errors.has('tipo de curso')"
                                        :error-messages="errors.first('tipo de curso')" row>
                                        <v-radio label="Presencial" value="Presencial"></v-radio>
                                        <v-radio label="Virtual " value="Virtual"></v-radio>
                                        <v-radio label="Mixto" value="Mixto"></v-radio>
                                    </v-radio-group>
                                </v-col>
                                <v-alert outlined type="warning" prominent border="left">
                                    <strong>Estimado(a) participante:</strong><br>
                                    La siguiente encuesta tiene como objetivo retroalimentar nuestra actividad de
                                    capacitación, por lo mismo le pedimos la
                                    mayor objetividad posible al contestarla. Este instrumento es un factor importante
                                    para el mejoramiento de nuestra labor
                                    y la capacitación.
                                </v-alert>
                                <v-row class="align-center" style="padding: 0px 50px 0px 100px">
                                    <v-col md="12">
                                        <v-p> <b>CRITERIOS DE EVALUACIÓN<br>
                                                10. Excelente <br>
                                                9. Muy Bien <br>
                                                8. Bien <br>
                                                7. Regular <br>
                                                6. Insuficiente
                                            </b>
                                        </v-p>
                                    </v-col>
                                </v-row>
                                <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                    <v-col md=10>
                                        <v-p>1.- Con base en el objetivo del curso, la duraci&oacute;n fue</v-p>
                                    </v-col>
                                    <v-col md=2>
                                        <v-select v-model="escala1" outlined v-validate="'required'"
                                            :items="arrayEscala" item-value="idEscala" item-text="numero"
                                            data-vv-name="escala" :error="errors.has('escala')"
                                            :error-messages="errors.first('escala')"></v-select>
                                    </v-col>
                                </v-row>

                                <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">

                                    <v-col md=10>
                                        <v-p>
                                            2.- Los objetivos establecidos, se cumplieron de manera:
                                        </v-p>
                                    </v-col>

                                    <v-col md=2>
                                        <v-select v-model="escala2" outlined v-validate="'required'"
                                            :items="arrayEscala" item-value="idEscala" item-text="numero"
                                            data-vv-name="tipo" :error="errors.has('tipo')"
                                            :error-messages="errors.first('tipo')"></v-select>
                                    </v-col>
                                </v-row>

                                <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">

                                    <v-col md=10>
                                        <v-p>
                                            3.- La aplicación del contenido a mi labor docente la considero:
                                        </v-p>
                                    </v-col>

                                    <v-col md=2>
                                        <v-select v-model="escala3" outlined v-validate="'required'"
                                            :items="arrayEscala" item-value="idEscala" item-text="numero"
                                            data-vv-name="tipo" :error="errors.has('tipo')"
                                            :error-messages="errors.first('tipo')"></v-select>
                                    </v-col>
                                </v-row>

                                <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                    <v-col md=10>
                                        <v-p>
                                            4.- El contenido del curso se adaptó al modelo de la UTL:
                                        </v-p>
                                    </v-col>
                                    <v-col md=2>
                                        <v-select v-model="escala4" outlined v-validate="'required'"
                                            :items="arrayEscala" item-value="idEscala" item-text="numero"
                                            data-vv-name="tipo" :error="errors.has('tipo')"
                                            :error-messages="errors.first('tipo')"></v-select>
                                    </v-col>
                                </v-row>

                                <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                    <v-col md=10>
                                        <v-p>
                                            5.- De acuerdo al contenido ¿Cómo autoevalúo mi aprendizaje?
                                        </v-p>
                                    </v-col>
                                    <v-col md=2>
                                        <v-select v-model="escala4" outlined v-validate="'required'"
                                            :items="arrayEscala" item-value="idEscala" item-text="numero"
                                            data-vv-name="tipo" :error="errors.has('tipo')"
                                            :error-messages="errors.first('tipo')"></v-select>
                                    </v-col>
                                </v-row>
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
                    const nombreCurso = ref("");
                    const fecha = ref("");
                    const nombreInstructor = ref("");
                    const tipoCurso = ref("");
                    const arrayEscala = ref([10, 9, 8, 7, 6]);
                    const escala1 = ref("");
                    const escala2 = ref("");
                    const escala3 = ref("");
                    const escala4 = ref("");
                    const escala5 = ref("");


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
                    const headerCapacitacion = ref([
                    ]);
                    const searchCapacitacion = ref([]);

                    onMounted(() => {
                        fnReasignacionDatos();
                    });

                    function fnReasignacionDatos() {
                        fecha.value = new Date().toISOString().substr(0, 10);
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
                        nombreCurso,
                        fecha,
                        nombreInstructor,
                        tipoCurso,
                        escala1,
                        escala2,
                        escala3,
                        escala4,
                        escala5,
                        arrayEscala,
                        mostrarSnackbar,
                        fnReasignacionDatos,
                        flagEditar,
                        headerCapacitacion,
                        searchCapacitacion,
                        fnLimpiarCampos,
                        itemEditar,
                    };
                },
            });

            Vue.config.devtools = true;
        </script>

    </html>