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
                            Detección de necesidades para el asesoramiento pedagógico
                        </v-card-title>
                        <!--En este apartado estan los inputs para comenzar el registro-->

                        <v-container fluid class="elevation-2">
                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">

                                <v-col md=5>
                                    <!--Empleado-->
                                    <v-autocomplete v-model="cve_empleado" outlined label="Empleado" persistent-hint
                                        v-validate="'required|max:100'" data-vv-name="empleado" :items="arrayEmpleado"
                                        item-value="cve_empleado" item-text="nombre_completo"
                                        :error="errors.has('empleado')"
                                        :error-messages="errors.first('empleado')"></v-autocomplete>
                                    <!--Materia-->
                                    <v-text-field v-model="materia" outlined label="Materia" persistent-hint
                                        v-validate="'required|max:55'" data-vv-name="materia"
                                        :error="errors.has('materia')"
                                        :error-messages="errors.first('materia')"></v-text-field>
                                </v-col>

                                <v-col md=5>
                                    <!--Fecha-->
                                    <v-menu ref="menu1" :close-on-content-click="false"
                                        :return-value.sync="fecha_registro" transition="scale-transition" offset-y
                                        min-width="auto">
                                        <template v-slot:activator="{ on, attrs }">
                                            <v-text-field v-model="fecha_registro" label="Fecha de aplicación"
                                                prepend-icon="mdi-calendar" readonly v-bind="attrs"
                                                v-on="on"></v-text-field>
                                        </template>
                                        <v-date-picker v-model="fecha_registro" no-title scrollable>
                                            <v-spacer></v-spacer>
                                            <v-btn text color="primary" @click="menu1 = false">
                                                Cancel
                                            </v-btn>
                                            <v-btn text color="primary" @click="$refs.menu1.save(fecha_registro)">
                                                OK
                                            </v-btn>
                                        </v-date-picker>
                                </v-col>

                                <v-col md=4>
                                    <!--Motivo de solicitud-->
                                    <v-textarea v-model="motivo_solicitud" outlined label="Motivo de la solicitud:"
                                        persistent-hint v-validate="'required|max:255'" data-vv-name="motivo"
                                        :error="errors.has('motivo')"
                                        :error-messages="errors.first('motivo')"></v-textarea>
                                </v-col>

                                <v-col md="4">
                                    <!--Entrevista-->
                                    <v-textarea v-model="entrevista" outlined label="Breve relatoria de la entrevista:"
                                        persistent-hint v-validate="'required|max:255'" data-vv-name="entrevista"
                                        :error="errors.has('entrevista')"
                                        :error-messages="errors.first('entrevista')"></v-textarea>
                                </v-col>

                                <v-col md=4>
                                    <!--Explicación sugerencias-->
                                    <v-textarea v-model="sugerencias" outlined label="Sugerencias:" persistent-hint
                                        v-validate="'required|max:255'" data-vv-name="sugerencias"
                                        :error="errors.has('sugerencias')"
                                        :error-messages="errors.first('sugerencias')"></v-textarea>
                                </v-col>

                                <v-col md="2">
                                    <v-checkbox v-model="firma" label="Validación/Firma" color="success" value=true
                                        hide-details :disabled="!flagEditar"></v-checkbox>
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
                                            <template v-slot:item.editar="{item}">
                                                <v-btn fab small color="warning" @click="flagEditar = true; itemEditar = item;
                                                cve_asesoria = item.cve_asesoria;
                                                cve_empleado = item.cve_empleado;
                                                materia = item.materia;
                                                fecha = item.fecha;
                                                motivo_solicitud = item.motivo_solicitud;
                                                sugerencias = item.sugerencias;
                                                entrevista = item.entrevista;
                                                firma = item.firma;
                                                activo = item.activo;
                                                fecha_registro = item.fecha_registro;
                                                usuario_registro = item.usuario_registro;
                                                
                                                    
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
                                <v-text-field outlined label="Materia" v-model="nombreBuscar"
                                    @keyup.enter="fnBusquedaMateria()"></v-text-field>
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
                        const ctr = "../controlador/innovacion_educativa/Controlador_deteccionNecesidadesAsesoramientoPedagogico.jsp";

                        const cve_asesoria = ref("");
                        const cve_empleado = ref("");
                        const materia = ref("");
                        const fecha = ref("");
                        const motivo_solicitud = ref("");
                        const sugerencias = ref("");
                        const entrevista = ref("");
                        const firma = ref("");
                        const activo = ref("");
                        const fecha_registro = ref("");
                        const usuario_registro = ref("");
                        const arrayEmpleado = ref([]);

                        const menu2 = false;
                        const modal2 = false;

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

                        //DataUsuarios
                        const dataDNAP = ref([]);
                        const dataUsuarios = ref([]);
                        const headersDNAP = ref([
                            { text: 'No', align: 'left', sortable: true, value: 'cve_asesoria' },
                            { text: 'Nombre del empleado', align: 'left', sortable: true, value: 'nombre_completo' },
                            { text: 'Materia', align: 'left', sortable: true, value: 'materia' },
                            { text: 'Fecha de aplicación', align: 'left', sortable: true, value: 'fecha' },
                            { text: 'Fecha de registro', align: 'left', sortable: true, value: 'fecha_registro' },
                            { text: 'Firma de validación', align: 'left', sortable: true, value: 'firma' },
                            { text: 'Editar', align: 'left', sortable: true, value: 'editar' },
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
                        });

                        //Consultar datos en la base de datos.
                        async function fnEmpleado() {
                            try {
                                preloader("../");
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
                                        data.forEach(item => {
                                            if (item.firma === false) {
                                                item.firma = "No validado";
                                            } else {
                                                item.firma = "Validado";
                                            }
                                        });
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

                        function fnBusquedaMateria() {
                            this.dataDNAP = this.dataDNAP.filter(item => item.materia === this.nombreBuscar);
                        }


                        async function fnGuardar() {
                            this.$validator.validate().then(async esValido => {
                                if (esValido) {
                                    try {
                                        preloader("../");
                                        let parametros = new URLSearchParams();
                                        parametros.append("accion", 2);

                                        console.log(cve_empleado.value);
                                        parametros.append("cve_empleado", cve_empleado.value);
                                        parametros.append("materia", materia.value);
                                        parametros.append("fecha", fecha_registro.value);
                                        parametros.append("motivo_solicitud", motivo_solicitud.value);
                                        parametros.append("sugerencias", sugerencias.value);
                                        parametros.append("entrevista", entrevista.value);
                                        parametros.append("firma", firma.value);

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
                                        preloader("../");
                                        let parametros = new URLSearchParams();
                                        parametros.append("accion", 3);

                                        parametros.append("cve_asesoria", cve_asesoria.value);
                                        parametros.append("cve_empleado", cve_empleado.value);
                                        parametros.append("materia", materia.value);
                                        parametros.append("fecha", fecha.value);
                                        parametros.append("motivo_solicitud", motivo_solicitud.value);
                                        parametros.append("sugerencias", sugerencias.value);
                                        parametros.append("entrevista", entrevista.value);
                                        parametros.append("firma", firma.value);

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
                            materia.value = "";
                            fecha.value = "";
                            motivo_solicitud.value = "";
                            sugerencias.value = "";
                            entrevista.value = "";
                            firma.value = "";
                            activo.value = "";
                            fecha_registro.value = "";
                            usuario_registro.value = "";

                            flagEditar.value = false;
                            itemEditar.value = {};

                            if (this == undefined)
                                cx.$validator.reset();
                            else
                                this.$validator.reset();
                        }

                        return {
                            cve_asesoria, cve_empleado, materia, fecha, motivo_solicitud,
                            sugerencias, entrevista, firma, activo, fecha_registro, usuario_registro,
                            arrayEmpleado,
                            menu2, modal2, fnBusquedaMateria,
                            dialogBuscador, nombreBuscar, searchBusqueda,
                            color_snackbar, snackbar, mensaje_snackbar, loader, mostrarSnackbar,
                            headersDNAP, flagEditar, dataDNAP, searchDNAP, fnLimpiarCampos, fnGuardar,
                            fnEditar, itemEditar
                        }
                    }

                });
                Vue.config.devtools = true;
            </script>

    </html>