<%@page contentType="text/html; charset=UTF-8" language="java" errorPage="" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900" rel="stylesheet">
        <link href="../styles/icon_material_design_4495/css/materialdesignicons.min.css" rel="stylesheet">
        <link href="../javascript/VueJs/sweetalert2/sweetalert2.css" />
        <link href="../javascript/VueJs/vuetify/vuetify.min.css" rel="stylesheet">
        <meta name="viewport"
            content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
        <script src="../javascript/VueJs/vue/vue.js"></script>
        <script type="" src="../javascript/VueJs/vue/vue-composition-api.prod.js"></script>
        <title>Solicitud capacitación tecnica</title>
    </head>
    <style>
        body {
            font-family: 'Roboto';
        }
    </style>

    <body>
        <div id="app">
            <v-app>
                <v-container fluid>
                    <v-card>
                        <v-card-title style="background-color: #00b293; color:#ffffff; headline">
                            Encuesta de Satisfacción y Evaluación de resultados
                        </v-card-title>
                        <!--En este apartado estan los inputs para comenzar el registro-->

                        <v-container fluid class="elevation-2">
                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">

                                <v-col md="6">
                                    <!--Cuatrimestre-->
                                    <v-autocomplete v-model="cuatrimestre" outlined label="Cuatrimestre" persistent-hint
                                        v-validate="'required|max:7'" data-vv-name="cuatrimestre"
                                        :items="arrayCuatrimestre" item-value="idCuatrimestre" item-text="cuatrimestre"
                                        :error="errors.has('cuatrimestre')"
                                        :error-messages="errors.first('cuatrimestre')"></v-autocomplete>
                                </v-col>

                                <v-col md="5">
                                    <!--Tipo de servicio-->
                                    <v-autocomplete v-model="cve_t_servicio" outlined label="Tipo de Servicio"
                                        persistent-hint v-validate="'required|max:100'" data-vv-name="tipo de servicio"
                                        :items="arrayTipoServicio" item-value="cve_tipo_servicio"
                                        item-text="nombre_tipo_servicio" :error="errors.has('tipo de servicio')"
                                        :error-messages="errors.first('tipo de servicio')"></v-autocomplete>

                                    <!--Asesoria de Proyecto-->
                                    <v-autocomplete v-model="cve_asesoria_proyecto" outlined
                                        label="Asesoria de Proyecto" persistent-hint v-validate="'required|max:100'"
                                        data-vv-name="asesoria de proyecto" :items="arrayAsesoriaProyecto"
                                        item-value="cve_asesoria" item-text="materia"
                                        :error="errors.has('asesoria de Proyecto')"
                                        :error-messages="errors.first('asesoria de proyecto')"></v-autocomplete>
                                </v-col>

                                <v-col md="8">
                                    <v-card>
                                        <v-list>
                                            <!-- Encabezado de la tabla -->
                                            <v-row class="grey lighten-3">
                                                <v-col cols="2">
                                                    <v-list-item-content>
                                                        <v-list-item-title
                                                            class="font-weight-bold text-wrap text-center">
                                                            Totalmente de acuerdo
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                                <v-col cols="2">
                                                    <v-list-item-content>
                                                        <v-list-item-title
                                                            class="font-weight-bold text-wrap text-center">
                                                            De acuerdo
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                                <v-col cols="2">
                                                    <v-list-item-content>
                                                        <v-list-item-title
                                                            class="font-weight-bold text-wrap text-center">
                                                            Ni de acuerdo ni en desacuerdo
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                                <v-col cols="2">
                                                    <v-list-item-content>
                                                        <v-list-item-title
                                                            class="font-weight-bold text-wrap text-center">
                                                            En desacuerdo
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                                <v-col cols="2">
                                                    <v-list-item-content>
                                                        <v-list-item-title
                                                            class="font-weight-bold text-wrap text-center">
                                                            Totalmente en desacuerdo
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                            </v-row>

                                            <!-- Filas de la tabla -->
                                            <v-row>
                                                <v-col cols="2">
                                                    <v-list-item-content>
                                                        <v-list-item-title class="text-wrap text-center">
                                                            10
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                                <v-col cols="2">
                                                    <v-list-item-content>
                                                        <v-list-item-title class="text-wrap text-center">
                                                            9
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                                <v-col cols="2">
                                                    <v-list-item-content>
                                                        <v-list-item-title class="text-wrap text-center">
                                                            8
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                                <v-col cols="2">
                                                    <v-list-item-content>
                                                        <v-list-item-title class="text-wrap text-center"
                                                            style="color:red; font-weight: bold;">
                                                            7
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                                <v-col cols="2">
                                                    <v-list-item-content>
                                                        <v-list-item-title class="text-wrap text-center"
                                                            style="color:red; font-weight: bold;">
                                                            6
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                            </v-row>
                                        </v-list>
                                    </v-card>
                                </v-col>

                                <v-col md="10">
                                    <v-card>
                                        <v-list>
                                            <!-- Encabezado de la tabla -->
                                            <v-row class="grey lighten-3">
                                                <v-col cols="6">
                                                    <v-list-item-content>
                                                        <v-list-item-title
                                                            class="font-weight-bold text-wrap text-center">
                                                            Indicador
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                                <v-col cols="4">
                                                    <v-list-item-content>
                                                        <v-list-item-title
                                                            class="font-weight-bold text-wrap text-center">
                                                            Calificación
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                            </v-row>

                                            <!-- Filas de la tabla -->
                                            <v-row>
                                                <v-col cols="6">
                                                    <v-list-item-content>
                                                        <v-list-item-title class="text-wrap text-center">
                                                            Mostró facilidad para contactar y llevar a cabo el proyecto
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                                <v-col cols="4">
                                                    <v-list-item-content>
                                                        <v-list-item-title>
                                                            <v-text-field v-model="calificaciones[0]" outlined
                                                                label="Calificación" persistent-hint
                                                                v-validate="{required: true, min_value: 6, max_value: 10}"
                                                                data-vv-name="1.Calificación" inputmode="numeric"
                                                                pattern="[0-9]*" type="number"
                                                                :error="errors.has('1.Calificación')"
                                                                :error-messages="errors.first('1.Calificación')"></v-text-field>
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                            </v-row>

                                            <!-- Filas de la tabla -->
                                            <v-row>
                                                <v-col cols="6">
                                                    <v-list-item-content>
                                                        <v-list-item-title class="text-wrap text-center">
                                                            El asesoramiento que le proporcionó el departamento le fue
                                                            de utilidad
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                                <v-col cols="4">
                                                    <v-list-item-content>
                                                        <v-list-item-title>
                                                            <v-text-field v-model="calificaciones[1]" outlined
                                                                label="Calificación" persistent-hint
                                                                v-validate="{required: true, min_value: 6, max_value: 10}"
                                                                data-vv-name="2.Calificación" inputmode="numeric"
                                                                pattern="[0-9]*" type="number"
                                                                :error="errors.has('2.Calificación')"
                                                                :error-messages="errors.first('2.Calificación')"></v-text-field>
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                            </v-row>

                                            <!-- Filas de la tabla -->
                                            <v-row>
                                                <v-col cols="6">
                                                    <v-list-item-content>
                                                        <v-list-item-title class="text-wrap text-center">
                                                            Se cubrieron los objetivos establecidos al inicio del
                                                            proyecto o asesoría
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                                <v-col cols="4">
                                                    <v-list-item-content>
                                                        <v-list-item-title>
                                                            <v-text-field v-model="calificaciones[2]" outlined
                                                                label="Calificación" persistent-hint
                                                                v-validate="{required: true, min_value: 6, max_value: 10}"
                                                                data-vv-name="3.Calificación" inputmode="numeric"
                                                                pattern="[0-9]*" type="number"
                                                                :error="errors.has('3.Calificación')"
                                                                :error-messages="errors.first('3.Calificación')"></v-text-field>
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                            </v-row>

                                            <!-- Filas de la tabla -->
                                            <v-row>
                                                <v-col cols="6">
                                                    <v-list-item-content>
                                                        <v-list-item-title class="text-wrap text-center">
                                                            Acudiría nuevamente al departamento de Innovación Educativa
                                                            a solicitar apoyo
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                                <v-col cols="4">
                                                    <v-list-item-content>
                                                        <v-list-item-title>
                                                            <v-text-field v-model="calificaciones[3]" outlined
                                                                label="Calificación" persistent-hint
                                                                v-validate="{required: true, min_value: 6, max_value: 10}"
                                                                data-vv-name="4.Calificación" inputmode="numeric"
                                                                pattern="[0-9]*" type="number"
                                                                :error="errors.has('4.Calificación')"
                                                                :error-messages="errors.first('4.Calificación')"></v-text-field>
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                            </v-row>

                                            <!-- Filas de la tabla -->
                                            <v-row>
                                                <v-col cols="6">
                                                    <v-list-item-content>
                                                        <v-list-item-title class="text-wrap text-center">
                                                            El proyecto o asesoría se concluyó de manera satisfactoria
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                                <v-col cols="4">
                                                    <v-list-item-content>
                                                        <v-list-item-title>
                                                            <v-text-field v-model="calificaciones[4]" outlined
                                                                label="Calificación" persistent-hint
                                                                v-validate="{required: true, min_value: 6, max_value: 10}"
                                                                data-vv-name="5.Calificación" inputmode="numeric"
                                                                pattern="[0-9]*" type="number"
                                                                :error="errors.has('5.Calificación')"
                                                                :error-messages="errors.first('5.Calificación')"></v-text-field>
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                            </v-row>

                                            <!-- Filas de la tabla -->
                                            <v-row>
                                                <v-col cols="6">
                                                    <v-list-item-content>
                                                        <v-list-item-title
                                                            class="font-weight-bold text-wrap text-center">
                                                            Suma
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                                <v-col cols="4">
                                                    <v-list-item-content>
                                                        <v-list-item-title>
                                                            <v-text-field v-model="suma" outlined
                                                                label="Total calificaciones" persistent-hint
                                                                readonly></v-text-field>
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                            </v-row>
                                        </v-list>
                                    </v-card>
                                </v-col>

                                <v-col md="6">
                                    <v-textarea v-model="comentarios" class="mx-2" label="Comentarios" rows="1"
                                        prepend-icon="mdi-comment"></v-textarea>
                                </v-col>

                            </v-row>
                            <%-- <v-row justfy="center" dense>
                                </v-row> --%>

                                <v-divider></v-divider>

                                <v-row justify="center">
                                    <v-btn color="primary"
                                        @click="flagEditar ? fnEditar() : fnGuardar()"><v-icon>mdi-content-save</v-icon>{{flagEditar
                                        ? 'Editar' : 'Guardar'}}</v-btn>
                                    &nbsp;
                                    <v-btn color="error"
                                        @click="fnLimpiarCampos()"><v-icon>mdi-cancel</v-icon>Cancelar</v-btn>
                                </v-row>

                                <v-row justify="center">
                                    <v-col md=12>
                                        <v-data-table :headers="headersEncuesta" :items="dataEncuesta"
                                            :search="searchEncuesta" class="elevation-2"
                                            no-data-text="No se encontro ningun registro"
                                            :hide-default-header="dataEncuesta.length < 1"
                                            :hide-default-footer="dataEncuesta.length < 1" locale="es-ES"
                                            :mobile-breakpoint="NaN" items-per-page="10">
                                            <template v-slot:item.status="{item}">
                                                <%-- <v-tooltip bottom> --%>
                                                    <%-- <template v-slot:activator="{on, attrs}"> --%>
                                                        <%-- v-bind="attrs" v-on="on" --%>
                                                            <v-switch v-model="item.status"
                                                                @change="fnCambiarEstatus(item)"></v-switch>
                                                            <%-- </template> --%>
                                                                <%-- <span>d</span> --%>
                                                                    <%-- </v-tooltip> --%>
                                            </template>
                                            <template v-slot:item.password="{item}">
                                                <v-tooltip bottom>
                                                    <template v-slot:activator="{on, attrs}">
                                                        <span v-bind="attrs" v-on="on"
                                                            @click="navigator.clipboard.writeText(item.password); mostrarSnackbar('success', 'Texto copiado al portapapeles.')"><b>{{item.password}}</b></span>
                                                    </template>
                                                    <span>Copiar contraseña</span>
                                                </v-tooltip>
                                            </template>
                                        </v-data-table>
                                    </v-col>
                                </v-row>
                        </v-container>
                    </v-card>
                </v-container>
                <v-card>
                    <v-card-title class="text-h5 grey lighten-2">
                        Búsqueda Avanzada
                    </v-card-title>

                    <v-card-text>
                        <v-row justify="center">
                            <v-col md=8>
                                <v-text-field outlined label="Materia" v-model="nombreBuscar"
                                    @keyup.enter="fnBusquedaCuatrimestre()"></v-text-field>
                            </v-col>
                        </v-row>

                        <v-row justify="center">
                            <v-col md=4 offset-md=8>
                                <v-text-field label="Filtrar" v-model="searchBusqueda"></v-text-field>
                            </v-col>
                        </v-row>

                    </v-card-text>
                </v-card>

                <!-- TODO: ALERTAS DE SISTEMA-->
                <v-snackbar v-model="snackbar" top="top" :bottom="true" :multi-line="true" :color="color_snackbar">
                    {{mensaje_snackbar}}
                    <%-- <v-icon color="white" @click="snackbar = false">mdi-close-circle</v-icon> --%>
                </v-snackbar>
                <v-overlay :value="loader" z-index="1000">
                    <v-img aspect-ratio="2" class="white--text align-end" height="212px" width="292px"
                        src="../images/Logo_utl_animado.gif">
                    </v-img>
                </v-overlay>
            </v-app>
        </div>
    </body>

    <%--apis--%>
        <script src="../javascript/axios/axios.js"></script>

        <script src="../javascript/VueJs/vuetify/vuetify.min.js"></script>
        <script src="../javascript/VueJs/vee-validate/vee-validate.js"></script>
        <script src="../javascript/VueJs/vee-validate/es.js"></script>
        <script src="../javascript/VueJs/sweetalert2/sweetalert2.all.js"></script>
        <%--Desarrollo--%>
            <script type="module">
                import { preloader, guardar, errorGuardar, actualizar, errorActualizar, eliminar, errorEliminar, cerrar, confirmarE, aviso, confirmar } from '../javascript/mensajeSistema/mensajes_sweetalert_vue.js';

                Vue.use(VeeValidate, {
                    classes: true
                });

                //Lenguaje de VeeValidate
                VeeValidate.Validator.localize("es");

                new Vue({
                    el: "#app",
                    vuetify: new Vuetify(),
                    setup() {
                        const {
                            ref,
                            onMounted,
                            watch
                        } = VueCompositionAPI;
                        const ctr = "../controlador/innovacion_educativa/Controlador_catalogo_encuestaSatisfaccionEvaluacion.jsp";

                        const cve_eval_resul = ref("");
                        const cve_t_servicio = ref("");
                        const cve_asesoria_proyecto = ref("");
                        const suma = ref("");
                        const porcentaje = ref("");
                        const cuatrimestre = ref("");
                        const comentarios = ref("");
                        const activo = ref("");
                        const fecha_registro = ref("");
                        const usuario_registro = ref("");

                        const calificaciones = ref([0, 0, 0, 0, 0]);

                        const fecha = ref("");
                        const hora = ref("");

                        const arrayCuatrimestre = ref(["Ene-Abr", "May-Jun", "Jul-Ags"]);
                        const arrayTipoServicio = ref([]);
                        const arrayAsesoriaProyecto = ref([]);

                        const headersEncuesta = ref([
                            { text: 'No', align: 'left', sortable: true, value: 'cve_eval_resul' },
                            { text: 'Cuatrimestre', align: 'left', sortable: true, value: 'cuatrimestre' },
                            { text: 'Tipo de servicio', align: 'left', sortable: true, value: 'nombre_tipo_servicio' },
                            { text: 'Materia de asesoria', align: 'left', sortable: true, value: 'materia' },
                            { text: 'Total Calificación', align: 'left', sortable: true, value: 'suma' },
                            { text: 'Porcentaje Calificación', align: 'left', sortable: true, value: 'porcentaje' },
                            { text: 'Fecha', align: 'left', sortable: true, value: 'fecha_registro' },
                        ]);
                        const dataEncuesta = ref([]);
                        const searchEncuesta = ref([]);

                        //SNACKBAR
                        const loader = ref(false);
                        const snackbar = ref(false);
                        const mensaje_snackbar = ref('');
                        const color_snackbar = ref('');

                        const dialogBuscador = ref(true);
                        const nombreBuscar = ref('');
                        const searchBusqueda = ref('');

                        //Otras variables
                        const flagEditar = ref(false);
                        const itemEditar = ref({});

                        function mostrarSnackbar(color, texto) {
                            snackbar.value = true;
                            color_snackbar.value = color;
                            if (color == "error")
                                mensaje_snackbar.value = "Ocurrió un error. Intentalo de nuevo más tarde.";
                            else
                                mensaje_snackbar.value = texto;
                        }

                        //Accion automatizada para mostrar la tabla
                        onMounted(() => {
                            fnConsultarTabla();
                            fnTipoServicio();
                            fnAsesoriaProyecto();
                        });

                        //Consultar datos en la base de datos.
                        async function fnTipoServicio() {
                            try {
                                preloader("../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 3);
                                let { data, status } = await axios.post(ctr, parametros)
                                if (status == 200) {
                                    if (data.length > 0) {
                                        arrayTipoServicio.value = data
                                    }
                                }
                            } catch (error) {
                                mostrarSnackbar('error');
                                console.error(error);
                            } finally {
                                swal.close();
                            }
                        }
                        async function fnAsesoriaProyecto() {
                            try {
                                preloader("../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 4);
                                let { data, status } = await axios.post(ctr, parametros)
                                if (status == 200) {
                                    if (data.length > 0) {
                                        arrayAsesoriaProyecto.value = data
                                    }
                                }
                            } catch (error) {
                                mostrarSnackbar('error');
                                console.error(error);
                            } finally {
                                swal.close();
                            }
                        }


                        async function fnConsultarTabla() {
                            try {
                                preloader("../");
                                //arreglo
                                let parametros = new URLSearchParams();
                                //le mandamos un parametro llamado accion
                                parametros.append("accion", 1);
                                //axios envia la peticion
                                let { data, status } = await axios.post(ctr, parametros)
                                if (status == 200) {
                                    if (data.length > 0) {
                                        dataEncuesta.value = data
                                    }
                                }
                            } catch (error) {
                                mostrarSnackbar('error');
                                console.error(error);
                            } finally {
                                swal.close();
                            }
                        }

                        function fnBusquedaCuatrimestre() {
                            this.dataEncuesta = this.dataEncuesta.filter(item => item.cuatrimestre === this.nombreBuscar);
                        }

                        async function fnGuardar() {
                            this.$validator.validate().then(async esValido => {
                                if (esValido) {
                                    try {
                                        preloader("../");
                                        let parametros = new URLSearchParams();
                                        parametros.append("accion", 2);

                                        parametros.append("cve_t_servicio", cve_t_servicio.value);
                                        parametros.append("cve_asesoria_proyecto", cve_asesoria_proyecto.value);
                                        parametros.append("suma", suma.value);
                                        parametros.append("porcentaje", porcentaje.value);
                                        parametros.append("cuatrimestre", cuatrimestre.value);
                                        parametros.append("comentarios", comentarios.value);

                                        let { data, status } = await axios.post(ctr, parametros)
                                        if (status == 200) {
                                            if (data == "1") {
                                                mostrarSnackbar("success", "Registro guardado correctamente.");
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
                                        mostrarSnackbar('error');
                                        console.error(error);
                                    } finally {
                                        swal.close();
                                    }
                                }
                            })
                        }

                        function fnLimpiarCampos(cx) {//cx = contexto
                            cve_eval_resul.value = "";
                            cve_t_servicio.value = "";
                            cve_asesoria_proyecto.value = "";
                            porcentaje.value = "";
                            cuatrimestre.value = "";
                            comentarios.value = "";
                            activo.value = "";
                            fecha_registro.value = "";
                            usuario_registro.value = "";
                            fecha.value = "";
                            hora.value = "";
                            suma.value = "";
                            calificaciones.value = [0, 0, 0, 0, 0];

                            flagEditar.value = false;
                            itemEditar.value = {};

                            if (this == undefined)
                                cx.$validator.reset();
                            else
                                this.$validator.reset();
                        }

                        return {
                            cve_eval_resul, cve_t_servicio, cve_asesoria_proyecto,
                            suma, porcentaje, cuatrimestre, comentarios, activo,
                            fecha_registro, usuario_registro, calificaciones,
                            fecha, hora, arrayCuatrimestre, arrayTipoServicio, arrayAsesoriaProyecto,
                            headersEncuesta, dataEncuesta, searchEncuesta,fnBusquedaCuatrimestre,
                            dialogBuscador, nombreBuscar, searchBusqueda,
                            fnConsultarTabla, fnTipoServicio, fnAsesoriaProyecto,
                            color_snackbar, snackbar, mensaje_snackbar, loader, mostrarSnackbar,
                            flagEditar, fnLimpiarCampos, fnGuardar,
                            itemEditar
                        }
                    },
                    methods: {
                        calcularSuma() {
                            const total = this.calificaciones.reduce((a, b) => parseInt(a) + parseInt(b), 0);
                            this.suma = total.toString();
                            const porcentajeTotal = (total / 500) * 1000; // Calcula el porcentaje
                            this.porcentaje = porcentajeTotal.toString(); // Asigna el porcentaje a la variable
                        },
                    },
                    watch: {
                        calificaciones: {
                            handler() {
                                this.calcularSuma();
                            },
                            deep: true,
                        },
                    },
                });
                Vue.config.devtools = true;
            </script>

    </html>