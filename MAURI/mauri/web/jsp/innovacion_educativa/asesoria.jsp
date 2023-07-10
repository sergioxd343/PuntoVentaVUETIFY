<%@page contentType="text/html; charset=UTF-8" language="java" errorPage="" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900" rel="stylesheet">
        <link href="../../styles/icon_material_design_4495/css/materialdesignicons.min.css" rel="stylesheet">
        <link href="../../javascript/VueJs/sweetalert2/sweetalert2.css" />
        <link href="../../javascript/VueJs/vuetify/vuetify.min.css" rel="stylesheet">
        <meta name="viewport"
            content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
        <script src="../../javascript/VueJs/vue/vue.js"></script>
        <script type="" src="../../javascript/VueJs/vue/vue-composition-api.prod.js"></script>
        <title>Solicitud capacitación tecnica</title>
    </head>
    <style>
        body {
            font-family: 'Roboto';
        }

        .seccion_1 {
            border: 1px solid black;
            padding: 10px;
            border-radius: 5px;
        }
    </style>

    <body>
        <div id="app">
            <v-app>
                <v-container fluid>
                    <v-card>
                        <v-card-title style="background-color: #00b293; color:#ffffff; headline">
                            Detección de necesidades para el asesoramiento pedagógico
                        </v-card-title>
                        <!--En este apartado estan los inputs para comenzar el registro-->

                        <v-container fluid class="elevation-2">
                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">


                                <v-col md="8">
                                    <!--Nombre del/la docente-->
                                    <v-text-field outlined label="Nombre del/la docente:" persistent-hint
                                        v-validate="'required|max:100'" :readonly="true"
                                        :value="nombreCompleto"></v-text-field>
                                </v-col>
                                <v-col md="8">
                                    <!--Materia-->
                                    <v-text-field v-model="materia" outlined label="Materia:" persistent-hint
                                        v-validate="'required|max:55'" data-vv-name="materia"
                                        :error="errors.has('materia')" :error-messages="errors.first('materia')"
                                        :readonly="modoEdicion"></v-text-field>
                                </v-col>
                                <v-col md=8>
                                    <!--Academia-->
                                    <v-autocomplete v-model="cve_academia" outlined label="Academia:" persistent-hint
                                        v-validate="'required|max:100'" data-vv-name="nombre de academia"
                                        :items="arrayAcademia" item-value="cve_academia" item-text="nombre_academia"
                                        :error="errors.has('nombre de academia')"
                                        :error-messages="errors.first('nombre de academia')"
                                        :readonly="modoEdicion"></v-autocomplete>
                                </v-col>
                                <v-col md="8">
                                    <!--Solicitante-->
                                    <v-autocomplete v-model="cve_empleado" outlined label="Solicitante:" persistent-hint
                                        v-validate="'required|max:100'" data-vv-name="nombre de solicitante"
                                        :items="arrayEmpleado" item-value="cve_empleado" item-text="nombre_completo"
                                        :error="errors.has('nombre de solicitante')"
                                        :error-messages="errors.first('nombre de solicitante')"
                                        :readonly="modoEdicion"></v-autocomplete>
                                </v-col>

                                <v-col md="8">
                                    <!--Fecha-->
                                    <v-menu ref="menu1" :close-on-content-click="false" :return-value.sync="fecha"
                                        transition="scale-transition" offset-y min-width="auto">
                                        <template v-slot:activator="{ on, attrs }">
                                            <v-text-field v-model="fechaActual" label="Fecha"
                                                prepend-icon="mdi-calendar" readonly></v-text-field>
                                        </template>
                                        <v-date-picker v-model="fecha" no-title scrollable :readonly="true">
                                            <v-spacer></v-spacer>
                                            <v-btn text color="primary" @click="menu1 = false">
                                                Cancel
                                            </v-btn>
                                            <v-btn text color="primary" @click="$refs.menu1.save(fecha)">
                                                OK
                                            </v-btn>
                                        </v-date-picker>
                                    </v-menu>
                                </v-col>

                                <v-col md="10">
                                    <p class="font-weight-thin">
                                        Redacte brevemente los motivos por los que solicita asesoramiento pedagógico.
                                    </p>
                                    <!--Motivo de solicitud-->
                                    <v-textarea v-model="motivo_solicitud" outlined label="Motivo de la solicitud:"
                                        persistent-hint v-validate="'required'" data-vv-name="motivo"
                                        :error="errors.has('motivo')" :error-messages="errors.first('motivo')"
                                        :readonly="modoEdicion" class="mx-2" rows="1"
                                        prepend-icon="mdi-comment"></v-textarea>
                                </v-col>
                                <v-col md="10" class="seccion_1">
                                    <v-col md="10">
                                        <p class="font-weight-thin">
                                            ¿Se le han dado algunas sugerencias sobre su práctica docente?
                                        </p>
                                        <!--Pregunta-->
                                        <v-radio-group v-model="sugerenciasActivo">
                                            <v-radio label="Si" value="opc_si"></v-radio>
                                            <v-radio label="No" value="opc_no"></v-radio>
                                        </v-radio-group>
                                    </v-col>
                                    <v-col md="10" v-if="sugerenciasActivo === 'opc_si'">
                                        <!--Explicación sugerencias-->
                                        <v-textarea v-model="sugerencias" outlined label="Explique brevemente:"
                                            persistent-hint data-vv-name="sugerencias"
                                            :error="errors.has('sugerencias')"
                                            :error-messages="errors.first('sugerencias')" :readonly="modoEdicion"
                                            class="mx-2" rows="1" prepend-icon="mdi-comment"></v-textarea>
                                    </v-col>
                                </v-col>
                                <v-col md="10">
                                    <!--Entrevista-->
                                    <v-textarea v-model="entrevista" outlined label="Breve relatoria de la entrevista:"
                                        persistent-hint v-validate="'required'" data-vv-name="entrevista"
                                        :error="errors.has('entrevista')" :error-messages="errors.first('entrevista')"
                                        :readonly="modoEdicion" class="mx-2" rows="1"
                                        prepend-icon="mdi-comment"></v-textarea>
                                </v-col>

                                <v-col md="4">
                                    <!--Compromisos-->
                                    <v-textarea v-model="compromisos" outlined label="Compromisos:" persistent-hint
                                        v-validate="'required'" data-vv-name="compromisos"
                                        :error="errors.has('compromisos')" :error-messages="errors.first('compromisos')"
                                        :readonly="modoEdicion" class="mx-2" rows="1"
                                        prepend-icon="mdi-comment"></v-textarea>
                                </v-col>
                                <v-col md="4">
                                    <!--Fecha-->
                                    <v-menu ref="menu1" :close-on-content-click="false" :return-value.sync="fecha"
                                        transition="scale-transition" offset-y min-width="auto">
                                        <template v-slot:activator="{ on, attrs }">
                                            <v-text-field v-model="fecha" label="Fecha de seguimiento"
                                                prepend-icon="mdi-calendar" readonly v-bind="attrs"
                                                v-on="on"></v-text-field>
                                        </template>
                                        <v-date-picker v-model="fecha" no-title scrollable :readonly="modoEdicion">
                                            <v-spacer></v-spacer>
                                            <v-btn text color="primary" @click="menu1 = false">
                                                Cancel
                                            </v-btn>
                                            <v-btn text color="primary" @click="$refs.menu1.save(fecha)">
                                                OK
                                            </v-btn>
                                        </v-date-picker>
                                </v-col>
                                <v-col md="4">
                                    <!--Responsable-->
                                    <v-autocomplete v-model="responsable" outlined label="Responsable:" persistent-hint
                                        v-validate="'required|max:100'" data-vv-name="responsable"
                                        :items="arrayEmpleado" item-value="cve_empleado" item-text="nombre_completo"
                                        :error="errors.has('responsable')" :error-messages="errors.first('responsable')"
                                        :readonly="modoEdicion"></v-autocomplete>
                                </v-col>

                                <v-col md="4">
                                    <!--Firma-->
                                    <v-radio-group v-model="activo" v-if="modoEdicion">
                                        Firma / Validación
                                        <v-radio label="Validado" value="opc_validado"></v-radio>
                                        <v-radio label="No Validado" value="opc_noValidado"></v-radio>
                                    </v-radio-group>
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

                                <v-card>
                                    <v-card-title class="text-h5 grey lighten-2">
                                        Búsqueda Avanzada
                                    </v-card-title>
                                    <v-card-text>
                                        <v-row justify="center">
                                            <v-col md=8>
                                                <v-text-field outlined
                                                    label="Solicitante | Usuario de registro | Academia"
                                                    v-model="nombreBuscar" append-icon="mdi-magnify"
                                                    @input="fnBusqueda()"></v-text-field>
                                            </v-col>
                                        </v-row>
                                    </v-card-text>
                                </v-card>
                                <v-row justify="center">
                                    <v-col md=12>
                                        <v-data-table :headers="headersDNAP" :items="dataDNAP" :search="searchDNAP"
                                            class="elevation-2" no-data-text="No se encontro ningun registro"
                                            :hide-default-header="dataDNAP.length < 1"
                                            :hide-default-footer="dataDNAP.length < 1" locale="es-ES"
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
                                            <template v-slot:item.editar="{ item }">
                                                <v-btn fab small color="warning" @click="fnEditarItem(item)"
                                                    :disabled="!userPermission">
                                                    <v-icon>mdi-square-edit-outline</v-icon>
                                                </v-btn>
                                            </template>
                                            <template v-slot:item.activo="{item}">
                                                <v-chip class="ma-2 "
                                                    style="width: 100px; display: flex; justify-content: center; align-items: center;"
                                                    link @click="fnCambiarEstatus(item)"
                                                    :color="item.activo ? 'success' : 'grey'" outlined>
                                                    {{ item.activo ?
                                                    "Validado" : "No Validado" }}
                                                </v-chip>
                                            </template>
                                        </v-data-table>
                                    </v-col>
                                </v-row>
                        </v-container>
                    </v-card>
                </v-container>

                <!-- TODO: ALERTAS DE SISTEMA-->
                <v-snackbar v-model="snackbar" top="top" :bottom="true" :multi-line="true" :color="color_snackbar">
                    {{mensaje_snackbar}}
                    <%-- <v-icon color="white" @click="snackbar = false">mdi-close-circle</v-icon> --%>
                </v-snackbar>
                <v-overlay :value="loader" z-index="1000">
                    <v-img aspect-ratio="2" class="white--text align-end" height="212px" width="292px"
                        src="../../images/Logo_utl_animado.gif">
                    </v-img>
                </v-overlay>
            </v-app>
        </div>
    </body>

    <%--apis--%>
        <script src="../../javascript/axios/axios.js"></script>

        <script src="../../javascript/VueJs/vuetify/vuetify.min.js"></script>
        <script src="../../javascript/VueJs/vee-validate/vee-validate.js"></script>
        <script src="../../javascript/VueJs/vee-validate/es.js"></script>
        <script src="../../javascript/VueJs/sweetalert2/sweetalert2.all.js"></script>
        <%--Desarrollo--%>
            <script type="module">
                import { preloader, guardar, errorGuardar, actualizar, errorActualizar, eliminar, errorEliminar, cerrar, confirmarE, aviso, confirmar } from '../../javascript/mensajeSistema/mensajes_sweetalert_vue.js';

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
                        const ctr = "../../controlador/innovacion_educativa/Controlador_deteccion_necesidades_asesoramiento_pedagogico.jsp";

                        const cve_asesoria = ref("");
                        const cve_empleado = ref("");
                        const cve_academia = ref("");
                        const materia = ref("");
                        const fecha = ref("");
                        const motivo_solicitud = ref("");
                        const sugerencias = ref("");
                        const entrevista = ref("");
                        const compromisos = ref("");
                        const responsable = ref(""); //cve_empleado
                        const fechaActual = ref("");

                        const fecha_registro = ref("");
                        const arrayEmpleado = ref([]);
                        const arrayAcademia = ref([]);

                        const activo = ref("");
                        const opc_validado = ref("");
                        const opc_noValidado = ref("");

                        const sugerenciasActivo = ref("");
                        const opc_si = ref("");
                        const opc_no = ref("");

                        const menu2 = false;
                        const modal2 = false;

                        const currentUser = localStorage.getItem("currentUser");
                        const currentUserObj = JSON.parse(currentUser);
                        const usuario_registro = currentUserObj[0].cve_persona;

                        const nombreCompleto = ref("");

                        const userPermission = ref(false);
                        const arrayUsuario = ref([]);
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

                        //Bloquear edicion de los campos cuando flagEditar es true
                        const modoEdicion = ref(false);

                        //DataUsuarios
                        const dataDNAP = ref([]);
                        const dataUsuarios = ref([]);
                        const headersDNAP = ref([
                            { text: 'No', align: 'left', sortable: true, value: 'cve_asesoria' },
                            { text: 'Nombre del solicitante', align: 'left', sortable: true, value: 'nombre_completo_solicitante' },
                            { text: 'Nombre de academia', align: 'left', sortable: true, value: 'nombre_academia' },
                            { text: 'Materia', align: 'left', sortable: true, value: 'materia' },
                            { text: 'Fecha de seguimiento', align: 'left', sortable: true, value: 'fecha' },
                            { text: 'Usuario de registro', align: 'left', sortable: true, value: 'nombre_completo' },
                            { text: 'Fecha de registro', align: 'left', sortable: true, value: 'fecha_registro' },
                            { text: 'Firma de validación', align: 'left', sortable: true, value: 'activo' },
                            //{ text: 'Editar', align: 'left', sortable: true, value: 'editar' },
                        ]);
                        const searchDNAP = ref([]);

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
                            fnEmpleado();
                            fnAcademia();
                            fnConsultarUsuario();
                            fnReasignacionDatos();
                        });

                        //Consultar datos en la base de datos.
                        async function fnEmpleado() {
                            try {
                                preloader("../../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 4);
                                let { data, status } = await axios.post(ctr, parametros)
                                if (status == 200) {
                                    if (data.length > 0) {
                                        arrayEmpleado.value = data;
                                    }
                                }
                            } catch (error) {
                                mostrarSnackbar('error');
                                console.error(error);
                            } finally {
                                swal.close();
                            }
                        } async function fnAcademia() {
                            try {
                                preloader("../../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 5);
                                let { data, status } = await axios.post(ctr, parametros)
                                if (status == 200) {
                                    if (data.length > 0) {
                                        arrayAcademia.value = data;
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
                                preloader("../../");
                                //arreglo
                                let parametros = new URLSearchParams();
                                //le mandamos un parametro llamado accion
                                parametros.append("accion", 1);
                                //axios envia la peticion
                                let { data, status } = await axios.post(ctr, parametros)
                                if (status == 200) {
                                    if (data.length > 0) {
                                        dataDNAP.value = data
                                    }
                                }
                            } catch (error) {
                                mostrarSnackbar('error');
                                console.error(error);
                            } finally {
                                swal.close();
                            }
                        }

                        //Sirve para encontrar a los usuarios que pueden editar unicamente.
                        async function fnConsultarUsuario() {
                            try {
                                preloader("../../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 6);

                                let { data, status } = await axios.post(ctr, parametros);
                                if (status == 200) {
                                    if (data.length > 0) {
                                        arrayUsuario.value = data;
                                        for (let i = 0; i < arrayUsuario.value.length; i++) {
                                            if (
                                                arrayUsuario.value[i].cve_persona === usuario_registro &&
                                                arrayUsuario.value[i].cve_grupo_seguridad === 2
                                            ) {
                                                userPermission.value = true;

                                                break;
                                            } else {
                                                userPermission.value = false;
                                            }
                                        }
                                    } else {
                                        userPermission.value = false;
                                    }
                                    console.log(userPermission.value);
                                }
                            } catch (error) {
                                mostrarSnackbar("error");
                                console.error(error);
                            } finally {
                                swal.close();
                            }
                        }

                        async function fnCambiarEstatus(item) {
                            try {
                                preloader("../../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 3);
                                
                                parametros.append("activo", (item.activo == true ? 0 : 1));
                                parametros.append("cve_asesoria", item.cve_asesoria);
                                console.log("🚀 ~ file: asesoria.jsp:481 ~ fnCambiarEstatus ~ parametros:", parametros)
                                let { data, status } = await axios.post(ctr, parametros);
                                if (status == 200) {
                                    if (data == "1") {
                                        mostrarSnackbar(
                                            "success",
                                            "Registro actualizado correctamente."
                                        );
                                        fnConsultarTabla();
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

                        function fnBusqueda() {
                            if (this.nombreBuscar === '') {
                                this.fnConsultarTabla();
                            } else {
                                this.dataDNAP = this.dataDNAP.filter(item => {
                                    const nombreAcademiaMatch = item.nombre_academia.toLowerCase().includes(this.nombreBuscar.toLowerCase());
                                    const usuarioRegistroMatch = item.nombre_completo.toLowerCase().includes(this.nombreBuscar.toLowerCase());
                                    const solicitanteMatch = item.nombre_completo_solicitante.toString().includes(this.nombreBuscar);

                                    return nombreAcademiaMatch || usuarioRegistroMatch || solicitanteMatch;
                                });
                            }
                        }

                        function fnEditarItem(item) {
                            this.modoEdicion = true;
                            this.flagEditar = true;
                            this.itemEditar = item;
                            this.cve_asesoria = item.cve_asesoria;
                            this.cve_empleado = item.cve_empleado;
                            this.cve_academia = item.cve_academia;
                            this.nombreCompleto = item.nombre_completo_solicitante;
                            this.materia = item.materia;
                            this.fecha = item.fecha;
                            this.fechaActual = item.fecha_registro;
                            this.motivo_solicitud = item.motivo_solicitud;
                            this.sugerencias = item.sugerencias;
                            this.entrevista = item.entrevista;
                            this.compromisos = item.compromisos;
                            this.responsable = item.responsable;
                            this.fecha_registro = item.fecha_registro;
                            this.activo = item.activo === "Validado" ? "opc_validado" : "opc_noValidado";

                            if (item.sugerencias !== null && item.sugerencias !== "-") {
                                this.sugerenciasActivo = "opc_si";
                            } else {
                                this.sugerenciasActivo = "opc_no";
                            }
                        }

                        function fnReasignacionDatos() {
                            nombreCompleto.value = currentUserObj[0].nombre + ' ' + currentUserObj[0].apellido_paterno + ' ' + currentUserObj[0].apellido_materno;
                            fechaActual.value = new Date().toISOString().substr(0, 10);
                        }

                        async function fnGuardar() {
                            this.$validator.validate().then(async esValido => {
                                if (esValido) {
                                    try {
                                        preloader("../../");
                                        let parametros = new URLSearchParams();
                                        parametros.append("accion", 2);

                                        console.log(cve_empleado.value);
                                        parametros.append("cve_empleado", cve_empleado.value);
                                        parametros.append("cve_academia", cve_academia.value);
                                        parametros.append("materia", materia.value);
                                        parametros.append("fecha", fechaActual.value);
                                        parametros.append("motivo_solicitud", motivo_solicitud.value);
                                        parametros.append("sugerencias", sugerencias.value);
                                        parametros.append("entrevista", entrevista.value);
                                        parametros.append("compromisos", compromisos.value);
                                        parametros.append("responsable", responsable.value);
                                        parametros.append("fecha_seguimiento", fecha.value);
                                        parametros.append("usuario_registro", this.usuario_registro);

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

                        async function fnEditar() {
                            this.$validator.validate().then(async esValido => {
                                if (esValido) {
                                    try {
                                        preloader("../../");
                                        let parametros = new URLSearchParams();
                                        parametros.append("accion", 3);

                                        parametros.append("cve_asesoria", cve_asesoria.value);
                                        parametros.append("cve_empleado", cve_empleado.value);
                                        parametros.append("cve_academia", cve_academia.value);
                                        parametros.append("materia", materia.value);
                                        parametros.append("fecha", fecha.value);
                                        parametros.append("motivo_solicitud", motivo_solicitud.value);
                                        parametros.append("sugerencias", sugerencias.value);
                                        parametros.append("entrevista", entrevista.value);

                                        if (activo.value === "opc_noValidado") {
                                            parametros.append("activo", false);
                                        } else if (activo.value === "opc_validado") {
                                            parametros.append("activo", true);
                                        } else {
                                            mostrarSnackbar("error", "Estatus inválido");
                                            return;
                                        }

                                        let { data, status } = await axios.post(ctr, parametros)
                                        if (status == 200) {
                                            if (data == "1") {
                                                mostrarSnackbar("success", "Registro actualizado correctamente.");
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
                            cve_asesoria.value = "";
                            cve_empleado.value = "";
                            cve_academia.value = "";
                            materia.value = "";
                            fecha.value = "";
                            motivo_solicitud.value = "";
                            sugerencias.value = "";
                            entrevista.value = "";
                            compromisos.value = "";
                            responsable.value = "";
                            fecha_registro.value = "";
                            modoEdicion.value = false;

                            nombreBuscar.value = "";

                            activo.value = "";
                            opc_validado.value = "";
                            opc_noValidado.value = "";

                            sugerenciasActivo.value = "";
                            opc_si.value = "";
                            opc_no.value = "";

                            flagEditar.value = false;
                            itemEditar.value = {};

                            fnReasignacionDatos();
                            fnConsultarTabla();

                            if (this == undefined)
                                cx.$validator.reset();
                            else
                                this.$validator.reset();
                        }

                        return {
                            cve_asesoria, cve_empleado, cve_academia, materia, fecha, motivo_solicitud, compromisos, responsable,
                            sugerencias, entrevista, activo, fecha_registro, usuario_registro,
                            arrayEmpleado, arrayAcademia, sugerenciasActivo, opc_si, opc_no,
                            currentUser, currentUserObj, userPermission, arrayUsuario,
                            opc_validado, opc_noValidado, modoEdicion, nombreCompleto, fnCambiarEstatus,
                            menu2, modal2, fnBusqueda, fnEditarItem, fnConsultarTabla, fnConsultarUsuario, fnReasignacionDatos,
                            dialogBuscador, nombreBuscar, searchBusqueda, fechaActual,
                            color_snackbar, snackbar, mensaje_snackbar, loader, mostrarSnackbar,
                            headersDNAP, flagEditar, dataDNAP, searchDNAP, fnLimpiarCampos, fnGuardar,
                            fnEditar, itemEditar
                        }
                    }

                });
                Vue.config.devtools = true;
            </script>

    </html>