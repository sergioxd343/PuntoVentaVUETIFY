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

        .tabla-dinamica {
            border-collapse: collapse;
        }

        .tabla-dinamica td {
            border: 1px solid black;
            padding: 8px;
        }

        .nombre-vertical {
            writing-mode: vertical-rl;
            text-orientation: mixed;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            padding-left: 5px;
            font-weight: bold;
            position: sticky;
            left: 0;
            font-size: 35px;
            background-color: rgb(189, 189, 189);
            padding: 5px;
            border-right: 1px solid black;
        }

        .contorno-negro {
            border: 1px solid black;
        }
    </style>

    <body>
        <div id="app">
            <v-app>
                <v-container fluid>
                    <v-card>
                        <v-card-title style="background-color: #00b293; color:#ffffff; headline">
                            Generación de Rúbricas
                        </v-card-title>
                        <!--En este apartado estan los inputs para comenzar el registro-->

                        <v-container fluid class="elevation-2">
                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">

                                <v-col md="6">
                                    <!--Empleado-->
                                    <v-autocomplete v-model="cve_empleado" outlined label="Empleado" persistent-hint
                                        v-validate="'required|max:100'" data-vv-name="empleado" :items="arrayEmpleado"
                                        item-value="cve_empleado" item-text="nombre_completo"
                                        :error="errors.has('empleado')"
                                        :error-messages="errors.first('empleado')"></v-autocomplete>
                                    <!--Nombre de rúbrica-->
                                    <v-text-field v-model="nombre_rubica" outlined label="Nombre de rúbrica"
                                        persistent-hint v-validate="'required|max:255'" data-vv-name="nombre de rúbrica"
                                        :error="errors.has('nombre de rúbrica')"
                                        :error-messages="errors.first('nombre de rúbrica')"></v-text-field>

                                    <!--Filas-->
                                    <v-text-field v-model="filas" outlined label="Cantidad de filas" persistent-hint
                                        v-validate="'required|numeric|max_value:8'" data-vv-name="filas"
                                        inputmode="numeric" pattern="[0-9]*" type="number" :error="errors.has('filas')"
                                        :error-messages="errors.first('filas')">
                                    </v-text-field>
                                </v-col>

                                <v-col md="6">
                                    <!--Columnas-->
                                    <v-text-field v-model="columnas" outlined label="Cantidad de columnas"
                                        persistent-hint v-validate="'required|numeric|max_value:8'"
                                        data-vv-name="columnas" inputmode="numeric" pattern="[0-9]*" type="number"
                                        :error="errors.has('columnas')"
                                        :error-messages="errors.first('columnas')"></v-text-field>

                                    <!--Nombre de sección-->
                                    <v-text-field v-model="nombre_seccion" outlined label="Nombre de sección"
                                        persistent-hint v-validate="'required|max:255'" data-vv-name="nombre de sección"
                                        :error="errors.has('nombre de sección')"
                                        :error-messages="errors.first('nombre de sección')"></v-text-field>
                                </v-col>

                                <v-col md="6">
                                    Indique la fila desde donde inicia la sección.
                                    <!--Seccion fila inicio-->
                                    <v-text-field v-model="secciona_fila_inicio" outlined label="Inicio" persistent-hint
                                        v-validate="'required|max:2'" data-vv-name="inicio" inputmode="numeric"
                                        pattern="[0-9]*" type="number" :error="errors.has('inicio')"
                                        :error-messages="errors.first('inicio')"></v-text-field>

                                    Indique la fila en donde finaliza la sección.
                                    <!--Seccion fila fin-->
                                    <v-text-field v-model="seccion_fila_fin" outlined label="Fin" persistent-hint
                                        v-validate="'required|max:2'" data-vv-name="fin" inputmode="numeric"
                                        pattern="[0-9]*" type="number" :error="errors.has('fin')"
                                        :error-messages="errors.first('fin')"></v-text-field>
                                </v-col>

                                <v-col md="6">
                                    <!--Nombre columna-->
                                    <v-text-field v-model="nombre_columna" outlined label="Nombre de columna"
                                        persistent-hint v-validate="'required|max:255'" data-vv-name="nombre de columna"
                                        :error="errors.has('nombre de columna')"
                                        :error-messages="errors.first('nombre de columna')"></v-text-field>

                                    <!--Criterios por cada celda-->
                                    <v-text-field v-model="criterios_por_celda" outlined label="Criterios de cada celda"
                                        persistent-hint v-validate="'required|max:255'"
                                        data-vv-name="criterios de cada celda"
                                        :error="errors.has('criterios de cada celda')"
                                        :error-messages="errors.first('criterios de cada celda')"></v-text-field>
                                </v-col>

                                <v-col cols="1">
                                    <div class="nombre-vertical contorno-negro">{{ nombre_seccion }}</div>
                                </v-col>
                                <v-col md="10">
                                    <table class="tabla-dinamica">
                                        <tr v-for="(fila, rowIndex) in tabla" :key="rowIndex">
                                            <td v-for="(celda, columnIndex) in fila" :key="columnIndex">
                                                <v-text-field v-model="celda.contenido" outlined dense></v-text-field>
                                            </td>
                                        </tr>
                                    </table>
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
                                        <v-data-table :headers="headersRubrica" :items="dataRubrica"
                                            :search="searchRubrica" class="elevation-2"
                                            no-data-text="No se encontro ningun registro"
                                            :hide-default-header="dataRubrica.length < 1"
                                            :hide-default-footer="dataRubrica.length < 1" locale="es-ES"
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
                                                cve_rubrica = item.cve_rubrica;
                                                cve_empleado = item.cve_empleado;
                                                nombre_rubica = item.nombre_rubica;
                                                filas = item.filas;
                                                columnas = item.columnas;
                                                nombre_seccion = item.nombre_seccion;
                                                secciona_fila_inicio = item.secciona_fila_inicio;
                                                seccion_fila_fin = item.seccion_fila_fin;
                                                nombre_columna = item.nombre_columna;
                                                criterios_por_celda = item.criterios_por_celda;
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
                                <v-text-field outlined label="Rúbrica" v-model="nombreBuscar"
                                    @keyup.enter="fnBusquedaNombre()"></v-text-field>
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
                        const ctr = "../../controlador/Controlador_generacionRubrica.jsp";

                        const cve_rubrica = ref("");
                        const cve_empleado = ref("");
                        const nombre_rubica = ref("");
                        const filas = ref("");
                        const columnas = ref("");
                        const nombre_seccion = ref("");
                        const secciona_fila_inicio = ref("");
                        const seccion_fila_fin = ref("");
                        const nombre_columna = ref("");
                        const criterios_por_celda = ref("");
                        const activo = ref("");
                        const fecha_registro = ref("");
                        const usuario_registro = ref("");

                        const tabla = [];
                        const arrayEmpleado = ref([]);

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
                        const dataRubrica = ref([]);
                        const dataUsuarios = ref([]);
                        const headersRubrica = ref([
                            { text: 'Rúbrica', align: 'left', sortable: true, value: 'cve_rubrica' },
                            { text: 'Nombre del empleado', align: 'left', sortable: true, value: 'nombre_completo' },
                            { text: 'Nombre Rúbrica', align: 'left', sortable: true, value: 'nombre_rubica' },
                            { text: 'Filas', align: 'left', sortable: true, value: 'filas' },
                            { text: 'Columnas', align: 'left', sortable: true, value: 'columnas' },
                            { text: 'Fecha de registro', align: 'left', sortable: true, value: 'fecha_registro' },
                            { text: 'Editar', align: 'left', sortable: true, value: 'editar' },
                        ]);
                        const searchRubrica = ref([]);
                        const dataBusqueda = ref([]);

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
                                        dataRubrica.value = data
                                    }
                                }
                            } catch (error) {
                                mostrarSnackbar('error');
                                console.error(error);
                            } finally {
                                swal.close();
                            }
                        }

                        function fnBusquedaNombre() {
                            this.dataRubrica = this.dataRubrica.filter(item => item.nombre_rubica === this.nombreBuscar);
                        }

                        async function fnGuardar() {
                            this.$validator.validate().then(async esValido => {
                                if (esValido) {
                                    try {
                                        preloader("../../");
                                        let parametros = new URLSearchParams();
                                        parametros.append("accion", 2);
                                        parametros.append("cve_empleado", cve_empleado.value);
                                        parametros.append("nombre_rubica", nombre_rubica.value);
                                        parametros.append("filas", filas.value);
                                        parametros.append("columnas", columnas.value);
                                        parametros.append("nombre_seccion", nombre_seccion.value);
                                        parametros.append("secciona_fila_inicio", secciona_fila_inicio.value);
                                        parametros.append("seccion_fila_fin", seccion_fila_fin.value);
                                        parametros.append("nombre_columna", nombre_columna.value);
                                        parametros.append("criterios_por_celda", criterios_por_celda.value);

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
                                        if (usuario_registro.value === null) {
                                            usuario_registro.value = 0;
                                        }
                                        parametros.append("accion", 3);
                                        parametros.append("cve_rubrica", cve_rubrica.value);
                                        parametros.append("cve_empleado", cve_empleado.value);
                                        parametros.append("nombre_rubica", nombre_rubica.value);
                                        parametros.append("filas", filas.value);
                                        parametros.append("columnas", columnas.value);
                                        parametros.append("nombre_seccion", nombre_seccion.value);
                                        parametros.append("secciona_fila_inicio", secciona_fila_inicio.value);
                                        parametros.append("seccion_fila_fin", seccion_fila_fin.value);
                                        parametros.append("nombre_columna", nombre_columna.value);
                                        parametros.append("criterios_por_celda", criterios_por_celda.value);
                                        parametros.append("usuario_registro", usuario_registro.value);
                                        parametros.append("activo", activo.value);
                                        parametros.append("fecha_registro", fecha_registro.value);

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
                            cve_rubrica.value = "";
                            cve_empleado.value = "";
                            nombre_rubica.value = "";
                            filas.value = 0;
                            columnas.value = 0;
                            nombre_seccion.value = "";
                            secciona_fila_inicio.value = "";
                            seccion_fila_fin.value = "";
                            nombre_columna.value = "";
                            criterios_por_celda.value = "";
                            activo.value = "";
                            fecha_registro.value = "";
                            usuario_registro.value = "";
                            tabla.value = [];

                            flagEditar.value = false;
                            itemEditar.value = {};

                            if (this == undefined)
                                cx.$validator.reset();
                            else
                                this.$validator.reset();
                        }

                        return {
                            cve_rubrica, cve_empleado, nombre_rubica, filas, columnas, nombre_seccion,
                            secciona_fila_inicio, seccion_fila_fin, nombre_columna, criterios_por_celda,
                            activo, fecha_registro, usuario_registro, tabla, arrayEmpleado,
                            fnConsultarTabla, fnEmpleado, fnBusquedaNombre, dataBusqueda,
                            dialogBuscador, nombreBuscar, searchBusqueda,
                            color_snackbar, snackbar, mensaje_snackbar, loader, mostrarSnackbar,
                            headersRubrica, flagEditar, dataRubrica, searchRubrica, fnLimpiarCampos, fnGuardar,
                            fnEditar, itemEditar
                        }
                    },
                    watch: {
                        columnas() {
                            if (this.columnas <= 8 && this.columnas > 0) {
                                this.generarTabla();
                            }
                        },
                        filas() {
                            if (this.filas <= 8 && this.filas > 0) {
                                this.generarTabla();
                            }
                        },
                    },
                    methods: {
                        generarTabla() {
                            const columnas = parseInt(this.columnas);
                            const filas = parseInt(this.filas);
                            this.tabla = [];

                            for (let i = 0; i < filas; i++) {
                                const fila = [];
                                for (let j = 0; j < columnas; j++) {
                                    fila.push({
                                        contenido: '',
                                    });
                                }
                                this.tabla.push(fila);
                            }
                        },
                    }
                });
                Vue.config.devtools = true;
            </script>

    </html>