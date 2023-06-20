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
    </style>

    <body>
        <div id="app">
            <v-app>
                <v-container fluid>
                    <v-card>
                        <v-card-title style="background-color: #00b293; color:#ffffff; headline">
                            Solicitud de Proyecto
                        </v-card-title>
                        <!--En este apartado estan los inputs para comenzar el registro-->

                        <v-container fluid class="elevation-2">
                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">

                                <v-col md="3">
                                    <!--Nombre de proyecto-->
                                    <v-text-field v-model="nombre_proyecto" outlined label="Nombre del proyecto"
                                        persistent-hint v-validate="'required|max:100'"
                                        data-vv-name="nombre del proyecto" :error="errors.has('nombre del proyecto')"
                                        :error-messages="errors.first('nombre del proyecto')"></v-text-field>

                                    <!--Objetivo de proyecto-->
                                    <v-text-field v-model="objetivo_proyecto" outlined label="Objetivo del proyecto"
                                        persistent-hint v-validate="'required|max:255'"
                                        data-vv-name="objetivo del proyecto"
                                        :error="errors.has('objetivo del proyecto')"
                                        :error-messages="errors.first('objetivo del proyecto')"></v-text-field>
                                </v-col>

                                <v-col md="3">
                                    <!--Área-->
                                    <v-autocomplete v-model="cve_area" outlined label="Área" persistent-hint
                                        v-validate="'required|max:55'" data-vv-name="área" :items="arrayArea"
                                        item-value="cve_area" item-text="nombre_area" :error="errors.has('área')"
                                        :error-messages="errors.first('área')"></v-autocomplete>

                                    <!--Género-->
                                    <v-autocomplete v-model="sexo" outlined label="Género" persistent-hint
                                        v-validate="'required|max:55'" data-vv-name="género" :items="arraySexo"
                                        item-value="género" item-text="género" :error="errors.has('género')"
                                        :error-messages="errors.first('género')"></v-autocomplete>
                                </v-col>

                                <v-col md="3">
                                    <!--Recursos necesarios-->
                                    <v-textarea v-model="recursos_necesarios" class="mx-2" label="Recursos necesarios"
                                        rows="1" prepend-icon="mdi-comment" v-validate="'max:255'"></v-textarea>

                                    <!--Acuerdos establecidos-->
                                    <v-textarea v-model="acuerdos_establecidos" class="mx-2"
                                        label="Acuerdos establecidos" rows="1" prepend-icon="mdi-comment"
                                        v-validate="'max:255'"></v-textarea>
                                </v-col>

                                <v-col md="3">
                                    <!--Descripción del proyecto-->
                                    <v-textarea v-model="descripcion_proyecto" class="mx-2"
                                        label="Descripción del proyecto" rows="1" prepend-icon="mdi-comment"
                                        v-validate="'max:255'"></v-textarea>

                                    <!--Estatus-->
                                    Seleccione el estatus del proyecto:
                                    <v-radio-group v-model="estatus">
                                        <v-radio label="Revisado" value="opc_revisado"></v-radio>
                                        <v-radio label="Cancelado" value="opc_cancelado"></v-radio>
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

                                <v-row justify="center">
                                    <v-col md=12>
                                        <v-data-table :headers="headersSolicitud" :items="dataSolicitud"
                                            :search="searchSolicitud" class="elevation-2"
                                            no-data-text="No se encontro ningun registro"
                                            :hide-default-header="dataSolicitud.length < 1"
                                            :hide-default-footer="dataSolicitud.length < 1" locale="es-ES"
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
                                            <template v-slot:item.editar="{item}">
                                                <v-btn fab small color="warning" @click="flagEditar = true; itemEditar = item;
                                                cve_solicitud_proyecto = item.cve_solicitud_proyecto;
                                                cve_area = item.cve_area;
                                                nombre_proyecto = item.nombre_proyecto;
                                                objetivo_proyecto = item.objetivo_proyecto;
                                                descripcion_proyecto = item.descripcion_proyecto;
                                                recursos_necesarios = item.recursos_necesarios;
                                                acuerdos_establecidos = item.acuerdos_establecidos;
                                                estatus = item.estatus;
                                                sexo = item.sexo;
                                                    
                                                "><v-icon>mdi-square-edit-outline</v-icon></v-btn>
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
                                <v-text-field outlined label="Área" v-model="nombreBuscar"
                                    @keyup.enter="fnBusquedaArea()"></v-text-field>
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
                        const ctr = "../../controlador/innovacion_educativa/Controlador_solicitud_proyecto.jsp";


                        const cve_solicitud_proyecto = ref("");
                        const cve_area = ref("");
                        const nombre_proyecto = ref("");
                        const objetivo_proyecto = ref("");
                        const descripcion_proyecto = ref("");
                        const recursos_necesarios = ref("");
                        const acuerdos_establecidos = ref("");
                        const estatus = ref("");
                        const sexo = ref("");

                        const arraySexo = ref(["Masculino", "Femenino", "Otro", "Prefiero no mencionarlo"])
                        const arrayArea = ref([]);
                        const opc_revisado = ref("");
                        const opc_cancelado = ref("");

                        //SNACKBAR
                        const loader = ref(false);
                        const snackbar = ref(false);
                        const mensaje_snackbar = ref('');
                        const color_snackbar = ref('');

                        //Dialogs
                        const dialogBuscador = ref(true);
                        const nombreBuscar = ref('');
                        const searchBusqueda = ref('');

                        //Otras variables
                        const flagEditar = ref(false);
                        const itemEditar = ref({});

                        //DataUsuarios
                        const dataSolicitud = ref([]);
                        const headersSolicitud = ref([
                            { text: 'No', align: 'left', sortable: true, value: 'cve_solicitud_proyecto' },
                            { text: 'Nombre de Área', align: 'left', sortable: true, value: 'nombre_area' },
                            { text: 'Nombre del proyecto', align: 'left', sortable: true, value: 'nombre_proyecto' },
                            { text: 'Sexo', align: 'left', sortable: true, value: 'sexo' },
                            { text: 'Estatus', align: 'left', sortable: true, value: 'estatus' },
                            { text: 'Fecha de registro', align: 'left', sortable: true, value: 'fecha_registro' },
                            { text: 'Editar', align: 'left', sortable: true, value: 'editar' },
                        ]);
                        const searchSolicitud = ref([]);

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
                            fnArea();
                            fnConsultarTabla();
                        });

                        //Consulta a base de datos
                        async function fnArea() {
                            try {
                                preloader("../../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 3);
                                let { data, status } = await axios.post(ctr, parametros)
                                if (status == 200) {
                                    if (data.length > 0) {
                                        arrayArea.value = data
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
                                        for (let i = 0; i < data.length; i++) {
                                            if (data[i].estatus === true) {
                                                data[i].estatus = "Revisado";
                                            } else if (data[i].estatus === false) {
                                                data[i].estatus = "Cancelado";
                                            }
                                        }
                                        dataSolicitud.value = data
                                    }
                                }
                            } catch (error) {
                                mostrarSnackbar('error');
                                console.error(error);
                            } finally {
                                swal.close();
                            }
                        }

                        function fnBusquedaArea() {
                            this.dataSolicitud = this.dataSolicitud.filter(item => item.nombre_area === this.nombreBuscar);
                        }

                        async function fnGuardar() {
                            this.$validator.validate().then(async esValido => {
                                if (esValido) {
                                    try {
                                        preloader("../../");
                                        let parametros = new URLSearchParams();
                                        parametros.append("accion", 2);

                                        parametros.append("cve_area", cve_area.value);
                                        parametros.append("nombre_proyecto", nombre_proyecto.value);
                                        parametros.append("objetivo_proyecto", objetivo_proyecto.value);
                                        parametros.append("descripcion_proyecto", descripcion_proyecto.value);
                                        parametros.append("recursos_necesarios", recursos_necesarios.value);
                                        parametros.append("acuerdos_establecidos", acuerdos_establecidos.value);

                                        if (estatus.value === "opc_cancelado") {
                                            parametros.append("estatus", false);
                                        } else if (estatus.value === "opc_revisado") {
                                            parametros.append("estatus", true);
                                        } else {
                                            // Manejar el caso en el que el valor de "estatus" no sea ninguno de los esperados.
                                            mostrarSnackbar("error", "Estatus inválido");
                                            return;
                                        }

                                        parametros.append("sexo", sexo.value);

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
                                        parametros.append("accion", 4);

                                        if (estatus.value === "opc_cancelado") {
                                            parametros.append("estatus", false);
                                        } else if (estatus.value === "opc_revisado") {
                                            parametros.append("estatus", true);
                                        } else {
                                            // Manejar el caso en el que el valor de "estatus" no sea ninguno de los esperados.
                                            mostrarSnackbar("error", "Estatus inválido");
                                            return;
                                        }
                                        parametros.append("cve_solicitud_proyecto", cve_solicitud_proyecto.value);


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
                            cve_solicitud_proyecto.value = "";
                            cve_area.value = "";
                            nombre_proyecto.value = "";
                            objetivo_proyecto.value = "";
                            descripcion_proyecto.value = "";
                            recursos_necesarios.value = "";
                            acuerdos_establecidos.value = "";
                            estatus.value = "";
                            sexo.value = "";

                            opc_revisado.value = "";
                            opc_cancelado.value = "";

                            flagEditar.value = false;
                            itemEditar.value = {};

                            fnConsultarTabla();

                            if (this == undefined)
                                cx.$validator.reset();
                            else
                                this.$validator.reset();
                        }

                        return {
                            cve_solicitud_proyecto, cve_area, nombre_proyecto, objetivo_proyecto,
                            descripcion_proyecto, recursos_necesarios, acuerdos_establecidos, estatus,
                            sexo,
                            opc_revisado, opc_cancelado, fnBusquedaArea,
                            arraySexo, arrayArea, fnArea, fnConsultarTabla,
                            dialogBuscador, nombreBuscar, searchBusqueda,
                            color_snackbar, snackbar, mensaje_snackbar, loader, mostrarSnackbar,
                            headersSolicitud, flagEditar, dataSolicitud, searchSolicitud, fnLimpiarCampos, fnGuardar,
                            fnEditar, itemEditar
                        }
                    }

                });
                Vue.config.devtools = true;
            </script>

    </html>