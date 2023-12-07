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

        .seccion-nombre {
            writing-mode: vertical-rl;
            text-orientation: upright;
            border: 1px solid black;
            background-color: #6fa79d;
            padding: 10px;
            height: 100px;
        }

        |
    </style>

    <body>
        <div id="app">
            <v-app>
                <v-container fluid>
                    <v-card>
                        <v-card-title style="background-color: #00b293; color:#ffffff;">
                            Generación de Rúbricas
                        </v-card-title>
                        <!--En este apartado estan los inputs para comenzar el registro-->


                        <v-container fluid class="elevation-2">
                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">

                                <v-col cols="12">
                                    <v-tabs v-model="activeTab" background-color="transparent" grow>
                                        <v-tab v-for="(tab, index) in tabs" :key="index">{{ tab }}</v-tab>
                                    </v-tabs>
                                    <v-tabs-items v-model="activeTab">
                                        <v-tab-item>
                                            <v-row>
                                                <v-col cols="6" md="6">
                                                    <!--Empleado-->
                                                    <v-autocomplete v-model="cve_empleado" outlined label="Empleado"
                                                        persistent-hint v-validate="'required|max:100'"
                                                        data-vv-name="empleado" :items="arrayEmpleado"
                                                        item-value="cve_empleado" item-text="nombre_completo"
                                                        :error="errors.has('empleado')"
                                                        :error-messages="errors.first('empleado')"></v-autocomplete>
                                                    <!--Nombre de rúbrica-->
                                                    <v-text-field v-model="nombre_rubica" outlined
                                                        label="Nombre de rúbrica" persistent-hint
                                                        v-validate="'required|max:255'" data-vv-name="nombre de rúbrica"
                                                        :error="errors.has('nombre de rúbrica')"
                                                        :error-messages="errors.first('nombre de rúbrica')"></v-text-field>
                                                </v-col>

                                                <v-col cols="6" md="6">
                                                    <!--Filas-->
                                                    <v-text-field v-model="filas" outlined label="Cantidad de filas"
                                                        persistent-hint v-validate="'required|numeric|max_value:16'"
                                                        data-vv-name="filas" inputmode="numeric" pattern="[0-9]*"
                                                        type="number" :error="errors.has('filas')"
                                                        :error-messages="errors.first('filas')">
                                                    </v-text-field>
                                                    <!--Columnas-->
                                                    <v-text-field v-model="columnas" outlined
                                                        label="Cantidad de columnas" persistent-hint
                                                        v-validate="'required|numeric|max_value:8'"
                                                        data-vv-name="columnas" inputmode="numeric" pattern="[0-9]*"
                                                        type="number" :error="errors.has('columnas')"
                                                        :error-messages="errors.first('columnas')"></v-text-field>
                                                </v-col>
                                                <v-col md="6">
                                                    <v-row class="justify-center">
                                                        <v-btn
                                                            @click="mostrarCamposSeccion = true; mostrarCamposColumna = false; mostrarCamposCriterios = false"
                                                            style="background-color: rgb(0, 182, 91); color: #ffffff;"
                                                            class="my-4" :disabled="!agregarSeccionFlag">Agregar Sección
                                                        </v-btn>
                                                    </v-row>
                                                </v-col>
                                                <v-col md="6">
                                                    <v-row class="justify-center">
                                                        <v-btn
                                                            @click="mostrarCamposColumna = true; mostrarCamposSeccion = false;  mostrarCamposCriterios = false"
                                                            style="background-color: rgb(0, 182, 91); color: #ffffff;"
                                                            class="my-4" :disabled="!agregarColumnaFlag">Agregar Columna
                                                        </v-btn>
                                                    </v-row>
                                                </v-col>
                                                <v-col>
                                                    <v-row class="justify-center">
                                                        <v-btn
                                                            @click=" mostrarCamposCriterios = true ;mostrarCamposColumna = false; mostrarCamposSeccion = false"
                                                            style="background-color: rgb(0, 182, 91); color: #ffffff;"
                                                            class="my-4" :disabled="!agregarCriterioFlag">Agregar
                                                            Criterio
                                                        </v-btn>
                                                    </v-row>
                                                </v-col>

                                                <v-col md="12" v-if="mostrarCamposColumna">
                                                    <v-row class="justify-center">
                                                        <v-col cols="12" md="6">
                                                            <v-col md="12">
                                                                <!--Nombre columna-->
                                                                <v-text-field v-model="nombreColumna" outlined
                                                                    label="Nombre de columna" persistent-hint
                                                                    v-validate="'max:255'"
                                                                    data-vv-name="nombre de columna"
                                                                    :error="errors.has('nombre de columna')"
                                                                    :error-messages="errors.first('nombre de columna')"></v-text-field>
                                                            </v-col>
                                                            <v-col>
                                                                Indique la posición de la columna.
                                                                <!--Posición columna-->
                                                                <v-text-field v-model="columnaInicio" outlined
                                                                    label="Posición de columna" persistent-hint
                                                                    v-validate="'max:2'" data-vv-name="posición"
                                                                    inputmode="numeric" pattern="[0-9]*" type="number"
                                                                    :error="errors.has('posición')"
                                                                    :error-messages="errors.first('posición')"></v-text-field>
                                                            </v-col>
                                                            <v-row>
                                                                <v-col class="d-flex justify-center">
                                                                    <v-btn color="success" elevation="8" outlined
                                                                        x-large
                                                                        @click="fnAgregarColumna(editarColumnaFlag)">
                                                                        {{ editarColumnaFlag ? 'Editar Columna' :
                                                                        'Agregar Columna' }}
                                                                    </v-btn>
                                                                </v-col>
                                                                <v-col class="d-flex justify-center">
                                                                    <v-btn color="error" elevation="8" outlined x-large
                                                                        @click="fnLimpiarColumna">
                                                                        Cancelar
                                                                    </v-btn>
                                                                </v-col>
                                                            </v-row>
                                                        </v-col>
                                                        <v-col md="6">
                                                            <template>
                                                                <div>
                                                                    <v-card>
                                                                        <v-card-text>
                                                                            <v-data-table :headers="headersColumna"
                                                                                :items="columnasArray"
                                                                                :items-per-page="5">
                                                                                <template v-slot:top>
                                                                                    <v-toolbar flat>
                                                                                        <v-toolbar-title>Tabla de
                                                                                            Columnas</v-toolbar-title>
                                                                                        <v-spacer></v-spacer>
                                                                                    </v-toolbar>
                                                                                </template>
                                                                                <template v-slot:item="{ item }">
                                                                                    <tr>
                                                                                        <td>{{ item[0] }}</td>
                                                                                        <td>{{ item[1] }}</td>
                                                                                        <td>
                                                                                            <v-btn color="primary"
                                                                                                @click="fnEditarColumna(item);">
                                                                                                Editar
                                                                                            </v-btn>
                                                                                        </td>
                                                                                    </tr>
                                                                                </template>
                                                                            </v-data-table>
                                                                            <!-- Mostrar mensajes de error -->
                                                                            <v-alert v-if="errorMensaje" type="error"
                                                                                outlined>
                                                                                {{ errorMensaje }}
                                                                            </v-alert>
                                                                        </v-card-text>
                                                                    </v-card>
                                                                </div>
                                                            </template>
                                                        </v-col>
                                                    </v-row>
                                                </v-col>

                                                <v-col md="12" v-if="mostrarCamposSeccion">
                                                    <v-row class="justify-center">

                                                        <v-col cols="12" md="6">
                                                            <v-col md="12">
                                                                <v-text-field v-model="nombreSeccion" outlined
                                                                    label="Nombre de sección" persistent-hint
                                                                    v-validate="'max:255'"
                                                                    data-vv-name="nombre de sección"
                                                                    :error="errors.has('nombre de sección')"
                                                                    :error-messages="errors.first('nombre de sección')"></v-text-field>
                                                            </v-col>

                                                            <v-col>
                                                                Indique la fila desde donde inicia la sección.
                                                                <!--Seccion fila inicio-->
                                                                <v-text-field v-model="filaInicio" outlined
                                                                    label="Inicio" persistent-hint v-validate="'max:2'"
                                                                    data-vv-name="inicio" inputmode="numeric"
                                                                    pattern="[0-9]*" type="number"
                                                                    :error="errors.has('inicio')"
                                                                    :error-messages="errors.first('inicio')"></v-text-field>
                                                            </v-col>
                                                            <v-col>
                                                                Indique la fila desde donde finaliza la sección.
                                                                <!-- Seccion fila fin -->
                                                                <v-text-field v-model="filaFin" outlined label="Fin"
                                                                    persistent-hint v-validate="'max:2'"
                                                                    data-vv-name="fin" inputmode="numeric"
                                                                    pattern="[0-9]*" type="number"
                                                                    :error="errors.has('fin')"
                                                                    :error-messages="errors.first('fin')"></v-text-field>
                                                            </v-col>
                                                            <v-row>
                                                                <v-col class="d-flex justify-center">
                                                                    <v-btn color="success" elevation="8" outlined
                                                                        x-large
                                                                        @click="fnAgregarSeccion(editarSeccionFlag)">
                                                                        {{ editarSeccionFlag ? 'Editar Sección' :
                                                                        'Agregar Sección' }}
                                                                    </v-btn>
                                                                </v-col>
                                                                <v-col class="d-flex justify-center">
                                                                    <v-btn color="error" elevation="8" outlined x-large
                                                                        @click="fnLimpiarSeccion">
                                                                        Cancelar
                                                                    </v-btn>
                                                                </v-col>
                                                            </v-row>
                                                        </v-col>

                                                        <v-col md="6">
                                                            <template>
                                                                <div>
                                                                    <v-card>
                                                                        <v-card-text>
                                                                            <v-data-table :headers="headersSeccion"
                                                                                :items="seccion" :items-per-page="5">
                                                                                <template v-slot:top>
                                                                                    <v-toolbar flat>
                                                                                        <v-toolbar-title>Tabla de
                                                                                            Secciones</v-toolbar-title>
                                                                                        <v-spacer></v-spacer>
                                                                                    </v-toolbar>
                                                                                </template>
                                                                                <template v-slot:item="{ item }">
                                                                                    <tr>
                                                                                        <td>{{ item[0] }}</td>
                                                                                        <td>{{ item[1] }}</td>
                                                                                        <td>{{ item[2] }}</td>
                                                                                        <td>
                                                                                            <v-btn color="primary"
                                                                                                @click="fnEditarSeccion(item);">
                                                                                                Editar
                                                                                            </v-btn>
                                                                                        </td>
                                                                                    </tr>
                                                                                </template>
                                                                            </v-data-table>
                                                                            <!-- Mostrar mensajes de error -->
                                                                            <v-alert v-if="errorMensaje" type="error"
                                                                                outlined>
                                                                                {{ errorMensaje }}
                                                                            </v-alert>
                                                                        </v-card-text>
                                                                    </v-card>
                                                                </div>
                                                            </template>
                                                        </v-col>
                                                </v-col>

                                                <v-col md="12" v-if="mostrarCamposCriterios">
                                                    <v-row class="justify-center">
                                                        <v-col>
                                                            <!--Posicion del criterio-->
                                                            <v-autocomplete outlined label="Posicion del criterio"
                                                                persistent-hint v-model="posicion_criterio"
                                                                :items="arrayPosicionRubrica"></v-autocomplete>
                                                        </v-col>
                                                        <v-col md="12">
                                                            <!--Criterio-->
                                                            <v-textarea v-model="criterios_por_celda"
                                                                label="Escriba el criterio"
                                                                hint="Tome en cuenta la columna y sección donde se encuentra"></v-textarea>
                                                        </v-col>
                                                        <v-row>
                                                            <v-col class="d-flex justify-center">
                                                                <v-btn color="success" elevation="8" outlined x-large
                                                                    @click="fnAgregarCriterio()">
                                                                    {{ editarSeccionFlag ? 'Editar Criterio' :
                                                                    'Agregar Criterio' }}
                                                                </v-btn>
                                                            </v-col>
                                                            <v-col class="d-flex justify-center">
                                                                <v-btn color="error" elevation="8" outlined x-large
                                                                    @click="fnLimpiarCriterio">
                                                                    Cancelar
                                                                </v-btn>
                                                            </v-col>
                                                        </v-row>
                                                    </v-row>
                                                </v-col>
                                            </v-row>
                                        </v-tab-item>
                                        <v-tab-item>
                                            <v-row>
                                                <v-col cols="6" md="12">
                                                    <template>
                                                        <v-data-table :headers="headersTablaDinamica"
                                                            :items="tabla"></v-data-table>
                                                    </template>
                                                </v-col>
                                            </v-row>

                                        </v-tab-item>
                                    </v-tabs-items>
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
                                            <template v-slot:item.editar="{ item }">
                                                <v-btn fab small color="warning" @click="fnEditarItem(item)">
                                                    <v-icon>mdi-square-edit-outline</v-icon>
                                                </v-btn>
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
                        const ctr = "../../controlador/innovacion_educativa/Controlador_generacion_rubrica.jsp";

                        const cve_rubrica = ref("");
                        const cve_empleado = ref("");
                        const nombre_rubica = ref("");
                        const nombreColumna = ref('');
                        const columnaInicio = ref('');
                        const filas = ref("");
                        const columnas = ref("");
                        const criterios = ref([]);

                        const criterios_por_celda = ref("");
                        const activo = ref("");
                        const fecha_registro = ref("");
                        const usuario_registro = ref("");

                        const arrayEmpleado = ref([]);

                        //Control logico de la tabla generada.
                        const mostrarCamposSeccion = ref(false);
                        const mostrarCamposColumna = ref(false);
                        const mostrarCamposCriterios = ref(false);
                        const activeTab = null;
                        const tabs = ref(['Generar', 'Vista']);
                        const errorMensaje = ref('');
                        const searchSeccion = ref([]);
                        const savedCriterios = ref([]);

                        const agregarSeccionFlag = ref(false);
                        const agregarColumnaFlag = ref(false);
                        const agregarCriterioFlag = ref(false);
                        const editarSeccionFlag = ref(false);
                        const editarColumnaFlag = ref(false);
                        const indiceSeccion = ref("");
                        const indiceColumna = ref("");
                        const nombreSeccion = ref('');
                        const filaInicio = ref('');
                        const filaFin = ref('');

                        const seccion = ref([]);
                        const tabla = ref([]);
                        const headersTablaDinamica = ref([{ text: "Tabla", value: "nombreSeccion" }]);
                        const columnasArray = ref([]);

                        const arrayPosicionRubrica = ref([]);
                        const posicion_criterio = ref("");

                        const posicionColumna = ref("");
                        const editarCriterio = ref(false);

                        const headersSeccion = ref([
                            { text: 'Nombre de Sección', sortable: true, align: 'left', value: 'nombreSeccion' },
                            { text: 'Fila Inicio', sortable: true, align: 'left', value: 'filaInicio' },
                            { text: 'Fila Fin', sortable: true, align: 'left', value: 'filaFin' },
                            { text: 'Editar', align: 'center', value: 'editarSeccion' }
                        ]);
                        const headersColumna = ref([
                            { text: 'Nombre de columna', sortable: true, align: 'left', value: 'nombreColumna' },
                            { text: 'Columna', sortable: true, align: 'left', value: 'columnaInicio' },
                            { text: 'Editar', align: 'center', value: 'editarSeccion' }
                        ]);

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
                            { text: 'Nombre del empleado', align: 'left', sortable: true, value: 'nombreCompleto' },
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

                        function fnEditarColumna(item) {
                            this.editarColumnaFlag = true;
                            this.nombreColumna = item[0];
                            this.columnaInicio = item[1];

                            this.indiceColumna = columnasArray.value.findIndex(columnaExistente => columnaExistente[0] === this.nombreColumna);
                        }

                        function fnEditarSeccion(item) {
                            this.editarSeccionFlag = true;
                            this.nombreSeccion = item[0];
                            this.filaInicio = item[1];
                            this.filaFin = item[2];

                            this.indiceSeccion = seccion.value.findIndex(seccionExistente => seccionExistente[0] === this.nombreSeccion);
                        }

                        function fnAgregarSeccion(editarSeccionFlag) {
                            const numFilas = parseInt(filas.value, 10);
                            const inicio = parseInt(filaInicio.value, 10);
                            const fin = parseInt(filaFin.value, 10);


                            // Verificar que la fila de inicio esté dentro del rango permitido (0 a número de filas )
                            if (inicio < 0 || inicio >= numFilas + 1) {
                                this.errorMensaje = 'La fila de inicio debe estar entre 0 y el número de filas: ' + numFilas;
                                return;
                            }

                            // Verificar que la fila de fin esté dentro del rango permitido (0 a número de filas)
                            if (fin < 0 || fin >= numFilas + 1) {
                                this.errorMensaje = 'La fila de fin debe estar entre 0 y el número de filas: ' + numFilas;
                                return;
                            }

                            // Verificar que la fila de fin sea mayor o igual a la fila de inicio
                            if (fin < inicio) {
                                this.errorMensaje = 'La fila de fin debe ser mayor o igual a la fila de inicio';
                                return;
                            }

                            if (!editarSeccionFlag) {
                                // Verificar que el nombre de sección no esté vacío
                                if (!this.nombreSeccion || !inicio || !fin) {
                                    this.errorMensaje = 'Hay campos vacios.';
                                    return;
                                }
                                // Verificar si el nombre de la nueva sección es igual al nombre de otra sección existente
                                const seccionConMismoNombre = seccion.value.find(seccionExistente => seccionExistente[0] === nombreSeccion.value);

                                if (seccionConMismoNombre) {
                                    this.errorMensaje = 'Ya existe una sección con el mismo nombre';
                                    return;
                                }

                                // Verificar si la nueva sección se superpone con alguna sección existente
                                const seccionSuperpuesta = seccion.value.find(seccionExistente => {
                                    const [_, inicioExistente, finExistente] = seccionExistente;
                                    return (inicio >= inicioExistente && inicio <= finExistente) || (fin >= inicioExistente && fin <= finExistente) || (inicioExistente >= inicio && inicioExistente <= fin) || (finExistente >= inicio && finExistente <= fin);
                                });

                                if (seccionSuperpuesta) {
                                    this.errorMensaje = 'Ya existe una sección que incluye completamente la nueva sección';
                                    return;
                                }

                                // Agregar la sección al arreglo
                                seccion.value.push([this.nombreSeccion, this.filaInicio, this.filaFin]);
                            } else {
                                // Edita la sección
                                seccion.value[this.indiceSeccion] = [];
                                const seccSuperpuesta = seccion.value.find(seccionExistente => {
                                    const [_, inicioExistente, finExistente] = seccionExistente;
                                    return (inicio >= inicioExistente && inicio <= finExistente) || (fin >= inicioExistente && fin <= finExistente) || (inicioExistente >= inicio && inicioExistente <= fin) || (finExistente >= inicio && finExistente <= fin);
                                });

                                if (!seccSuperpuesta) {
                                    // Utilizando Vue.set
                                    Vue.set(seccion.value, this.indiceSeccion, [nombreSeccion.value, filaInicio.value, filaFin.value]);

                                    // O utilizando la referencia reactiva
                                    seccion.value[this.indiceSeccion] = [nombreSeccion.value, filaInicio.value, filaFin.value];
                                } else {
                                    this.errorMensaje = 'Ya existe una sección que incluye completamente la nueva sección';
                                    return;
                                }
                            }

                            actualizarTablaDinamica();
                            fnLimpiarSeccion();
                            // Reiniciar el mensaje de error
                            this.errorMensaje = '';
                        }

                        function fnAgregarColumna(editarColumnaFlag) {
                            const numColumnas = parseInt(columnas.value, 10);
                            let columnaSuperpuesta = false;

                            if (!this.nombreColumna || !this.columnaInicio) {
                                this.errorMensaje = 'Hay campos vacios.';
                                return;
                            }
                            if (this.columnaInicio <= 0 || this.columnaInicio > numColumnas) {
                                this.errorMensaje = 'La columna debe estar entre 0 y el número de columnas: ' + numColumnas;
                                return;
                            }

                            if (!editarColumnaFlag) {
                                //Agregar Columna
                                for (let i = 0; i < columnasArray.value.length; i++) {
                                    if (this.columnaInicio === this.columnasArray[i][1]) {
                                        columnaSuperpuesta = true;
                                        break;
                                    }
                                }

                                if (columnaSuperpuesta) {
                                    this.errorMensaje = 'Ya existe una columna con la misma posición';
                                    return;
                                } else {
                                    columnasArray.value.push([this.nombreColumna, this.columnaInicio]);
                                    //Ordena las columnas
                                    columnasArray.value.sort(function (a, b) {
                                        return a[1] - b[1];
                                    });
                                }
                            } else {
                                //Editar columna
                                for (let i = 0; i < columnasArray.value.length; i++) {
                                    if (columnaInicio.value === columnasArray.value[i][1]) {
                                        columnasArray.value[i][1] = columnasArray.value[this.indiceColumna][1];
                                    }
                                }
                                // Utilizando Vue.set
                                Vue.set(columnasArray.value, this.indiceColumna, [nombreColumna.value, columnaInicio.value]);
                                // O utilizando la referencia reactiva
                                columnasArray.value[this.indiceColumna] = [nombreColumna.value, columnaInicio.value];
                                columnasArray.value.sort(function (a, b) {
                                    return a[1] - b[1];
                                });
                            }
                            actualizarTablaDinamica();
                            fnLimpiarColumna();
                            // Reiniciar el mensaje de error
                            this.errorMensaje = '';
                        }

                        function fnAgregarCriterio() {
                            let savedTabla = tabla.value;
                            actualizarTablaDinamica();
                            tabla.value = savedTabla;
                            if (!editarCriterio.value) {
                                let posicionParaCriterio = posicion_criterio.value.split(",");
                                let nombreCampo = "criterio_" + posicionParaCriterio[1];

                                let criterios_sanitisado = criterios_por_celda.value.replace(/\|/g, "&pipe&").replace(/,/g, "&coma&");

                                if (tabla.value[posicionParaCriterio[0]][nombreCampo]) {
                                    for (let i = 0; i < criterios.value.length; i++) {
                                        let pos_comparativa = criterios.value[i][1].replace('|', '').split(",");
                                        pos_comparativa[0] = parseInt(pos_comparativa[0]);
                                        pos_comparativa[1] = parseInt(pos_comparativa[1]);

                                        let pos_criterio_comparativa = posicion_criterio.value.split(",");
                                        pos_criterio_comparativa[0] = parseInt(pos_criterio_comparativa[0]);
                                        pos_criterio_comparativa[1] = parseInt(pos_criterio_comparativa[1]);

                                        if (pos_comparativa[0] === pos_criterio_comparativa[0] && pos_comparativa[1] === pos_comparativa[1]) {
                                            criterios.value[i][0] = criterios_sanitisado;
                                            criterios.value[i][1] = criterios.value[i][1];
                                            i = criterios.value.length;
                                        }
                                    }
                                } else {
                                    criterios.value.push([criterios_sanitisado, posicion_criterio.value]);
                                }
                                tabla.value[posicionParaCriterio[0]][nombreCampo] = criterios_por_celda.value;
                                fnLimpiarCriterio();
                            } else {
                                for (let i = 0; i < criterios.value.length; i++) {
                                    let posicion_criterio = criterios.value[i][1].split(",");
                                    posicion_criterio[0] = parseInt(posicion_criterio[0]);
                                    posicion_criterio[1] = parseInt(posicion_criterio[1]);

                                    let criterio_texto = criterios.value[i][0];
                                    let nombre_campo = "criterio_" + posicion_criterio[1];
                                    tabla.value[posicion_criterio[0]][nombre_campo] = criterio_texto;

                                    criterios.value[i][0] = criterios.value[i][0].replace(/\|/g, "&pipe&").replace(/,/g, "&coma&");
                                    criterios.value[i][1] = criterios.value[i][1];
                                }
                                editarCriterio.value = false;
                                fnLimpiarCriterio();
                            }
                        }


                        function actualizarTablaDinamica() {
                            tabla.value = [];
                            headersTablaDinamica.value = [];
                            arrayPosicionRubrica.value = [];
                            headersTablaDinamica.value.push({ text: "Tabla: " + nombre_rubica.value, value: "nombreSeccion" });

                            for (let i = 0; i < columnasArray.value.length; i++) {
                                headersTablaDinamica.value.push({ text: columnasArray.value[i][0], value: "criterio_" + i });
                            }

                            for (let i = 0; i < seccion.value.length; i++) {
                                // Convierte el valor en la posición [i][1] a un número entero
                                seccion.value[i][1] = parseInt(seccion.value[i][1], 10);

                                // Convierte el valor en la posición [i][2] a un número entero
                                seccion.value[i][2] = parseInt(seccion.value[i][2], 10);
                            }

                            for (let i = 0; i < seccion.value.length; i++) {
                                for (let j = seccion.value[i][1]; j <= seccion.value[i][2]; j++) {
                                    tabla.value.push({ nombreSeccion: seccion.value[i][0] });
                                }
                            }

                            arrayPosicionRubrica.value = [];
                            if (columnasArray.value.length > 0 && seccion.value.length > 0) {
                                agregarCriterioFlag.value = true;
                                for (let i = 0; i < tabla.value.length; i++) {
                                    for (let j = 0; j < columnasArray.value.length; j++) {
                                        arrayPosicionRubrica.value.push(i + "," + j);
                                    }
                                }
                            }

                        }

                        async function fnGuardar() {
                            this.$validator.validate().then(async esValido => {
                                if (esValido) {
                                    try {
                                        for (let i = 0; i < seccion.value.length; i++) {
                                            seccion.value[i][0] = seccion.value[i][0].replace(/,/g, "&coma&");
                                        }
                                        for (let i = 0; i < columnasArray.value.length; i++) {
                                            columnasArray.value[i][0] = columnasArray.value[i][0].replace(/,/g, "&coma&");
                                        }

                                        let secciones_txt = seccion.value.join(', ');
                                        let columnas_txt = columnasArray.value.join(', ');

                                        for (let i = 0; i < criterios.value.length; i++) {
                                            criterios.value[i][1] = "|" + criterios.value[i][1];
                                        }
                                        let criterios_txt = "";
                                        for (let i = 0; i < criterios.value.length; i++) {
                                            criterios.value[i][1] = criterios.value[i][1] + ", ";
                                            for (let j = 0; j < 2; j++) {
                                                criterios_txt += criterios.value[i][j];
                                            }
                                        }

                                        preloader("../../");
                                        let parametros = new URLSearchParams();
                                        parametros.append("accion", 2);
                                        parametros.append("cve_empleado", cve_empleado.value);
                                        parametros.append("nombre_rubica", nombre_rubica.value);
                                        parametros.append("filas", filas.value);
                                        parametros.append("columnas", columnas.value);
                                        parametros.append("secciones", secciones_txt);
                                        parametros.append("headers", columnas_txt);
                                        parametros.append("criterios_por_celda", criterios_txt);

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
                                        for (let i = 0; i < seccion.value.length; i++) {
                                            seccion.value[i][0] = seccion.value[i][0].replace(/,/g, "&coma&");
                                        }
                                        for (let i = 0; i < columnasArray.value.length; i++) {
                                            columnasArray.value[i][0] = columnasArray.value[i][0].replace(/,/g, "&coma&");
                                        }
                                        for (let i = 0; i < criterios.value.length; i++) {
                                            criterios.value[i][1] = "|" + criterios.value[i][1];
                                        }
                                        

                                        let secciones_txt = seccion.value.join(', ');
                                        let columnas_txt = columnasArray.value.join(', ');
                                        let criterios_txt = "";
                                        for (let i = 0; i < criterios.value.length; i++) {
                                            criterios.value[i][1] = criterios.value[i][1] + ", ";
                                            for (let j = 0; j < 2; j++) {
                                                criterios_txt += criterios.value[i][j];
                                            }
                                        }

                                        preloader("../../");
                                        let parametros = new URLSearchParams();
                                        parametros.append("accion", 3);

                                        parametros.append("cve_empleado", cve_empleado.value);
                                        parametros.append("nombre_rubica", nombre_rubica.value);
                                        parametros.append("filas", filas.value);
                                        parametros.append("columnas", columnas.value);
                                        parametros.append("secciones", secciones_txt);
                                        parametros.append("headers", columnas_txt);
                                        parametros.append("criterios_por_celda", criterios_txt);

                                        parametros.append("cve_rubrica", cve_rubrica.value);

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

                        function fnEditarItem(item) {
                            this.flagEditar = true;
                            this.itemEditar = item;
                            this.cve_rubrica = item.cve_rubrica;
                            this.cve_empleado = item.cve_empleado;
                            this.nombre_rubica = item.nombre_rubica;
                            this.filas = item.filas;
                            this.columnas = item.columnas;

                            let seccion_txt = item.secciones;
                            let headers_txt = item.headers;
                            let criterios_txt = item.criterios_por_celda;

                            let sub_seccion_txt = seccion_txt.split(', ');
                            let sub_headers_txt = headers_txt.split(', ');
                            let sub_criterios_txt = criterios_txt.split(', ');

                            seccion.value = sub_seccion_txt.map(elemento => elemento.split(','));
                            columnasArray.value = sub_headers_txt.map(elemento => elemento.split(','));
                            criterios.value = sub_criterios_txt.map(elemento => elemento.split('|'));

                            let savedCriterios = criterios.value;
                            criterios.value = [];
                            for(let i = 0; i < savedCriterios.length; i++){
                                if(savedCriterios[i] != ""){
                                    criterios.value.push([savedCriterios[i][0], savedCriterios[i][1]]);
                                }
                            }

                            for (let i = 0; i < seccion.value.length; i++) {
                                seccion.value[i][0] = seccion.value[i][0].replace(/&coma&/g, ",");
                            }
                            for (let i = 0; i < columnasArray.value.length; i++) {
                                columnasArray.value[i][0] = columnasArray.value[i][0].replace(/&coma&/g, ",");
                            }
                            for (let i = 0; i < criterios.value.length; i++) {
                                criterios.value[i][0] = criterios.value[i][0].replace(/&coma&/g, ",").replace(/&pipe&/g, "|");
                            }
                            editarCriterio.value = true;
                            actualizarTablaDinamica();
                            fnAgregarCriterio();

                            agregarCriterioFlag.value = true;

                            this.fecha_registro = item.fecha_registro;
                            this.activo = item.activo;
                            this.usuario_registro = item.usuario_registro;
                        }

                        function fnLimpiarColumna() {
                            nombreColumna.value = "";

                            columnaInicio.value = null;

                            errorMensaje.value = '';
                            editarColumnaFlag.value = false;
                        }

                        function fnLimpiarSeccion() {
                            nombreSeccion.value = "";

                            filaInicio.value = null;
                            filaFin.value = null;
                            indiceSeccion.value = null;

                            errorMensaje.value = '';
                            editarSeccionFlag.value = false;
                        }

                        function fnLimpiarCriterio() {
                            criterios_por_celda.value = "";
                            posicion_criterio.value = null;
                        }

                        function fnLimpiarCampos(cx) {
                            cve_rubrica.value = "";
                            cve_empleado.value = "";
                            nombre_rubica.value = "";
                            filas.value = null;
                            columnas.value = null;
                            criterios_por_celda.value = "";
                            activo.value = "";
                            fecha_registro.value = "";
                            usuario_registro.value = "";
                            errorMensaje.value = ""
                            indiceSeccion.value = null;
                            indiceColumna.value = null;

                            tabla.value = [];
                            seccion.value = [];
                            columnasArray.value = [];
                            criterios.value = [];
                            headersTablaDinamica.value = [{ text: "Tabla", value: "nombreSeccion" }];
                            arrayPosicionRubrica.value = [];
                            posicion_criterio.value = "";
                            savedCriterios.value = [];

                            mostrarCamposSeccion.value = false;
                            mostrarCamposColumna.value = false;
                            mostrarCamposCriterios.value = false;
                            agregarSeccionFlag.value = false;
                            agregarColumnaFlag.value = false;
                            agregarCriterioFlag.value = false;
                            editarSeccionFlag.value = false;
                            editarColumnaFlag.value = false;
                            editarCriterio.value = false;

                            flagEditar.value = false;
                            itemEditar.value = {};

                            fnConsultarTabla();

                            if (this == undefined) { cx.$validator.reset(); }
                            else { this.$validator.reset(); }
                        }


                        return {
                            cve_rubrica, cve_empleado, nombre_rubica, filas, columnas, criterios_por_celda, nombreColumna, posicionColumna, editarColumnaFlag,
                            activo, fecha_registro, usuario_registro, tabla, arrayEmpleado, mostrarCamposSeccion, mostrarCamposColumna, mostrarCamposCriterios, seccion, indiceColumna, indiceSeccion, columnaInicio,
                            dataBusqueda, nombreSeccion, filaInicio, filaFin, editarSeccionFlag, headersTablaDinamica, headersColumna,
                            dialogBuscador, nombreBuscar, searchBusqueda, activeTab, tabs, agregarSeccionFlag, criterios, arrayPosicionRubrica, agregarColumnaFlag, agregarCriterioFlag, headersSeccion, errorMensaje, columnasArray,
                            color_snackbar, snackbar, mensaje_snackbar, loader, itemEditar, editarCriterio, savedCriterios,
                            headersRubrica, flagEditar, dataRubrica, searchRubrica, posicion_criterio,
                            fnBusquedaNombre, fnAgregarSeccion, fnEditarSeccion, fnEditarColumna, fnAgregarColumna, fnEditarItem,
                            fnAgregarCriterio, fnEditar, fnLimpiarCampos, fnGuardar, actualizarTablaDinamica, fnLimpiarCriterio, mostrarSnackbar, fnEmpleado, fnConsultarTabla, fnLimpiarColumna, fnLimpiarSeccion
                        }
                    },
                    watch: {
                        filas() {
                            if (this.filas > 0 && this.filas <= 16) {
                                this.agregarSeccionFlag = true;
                            } else {
                                this.agregarSeccionFlag = false;
                                this.mostrarCamposSeccion = false;
                            }
                        },
                        columnas() {
                            if (this.columnas > 0 && this.columnas <= 16) {
                                this.agregarColumnaFlag = true;
                            } else {
                                this.agregarColumnaFlag = false;
                                this.mostrarCamposColumna = false;
                            }
                        }
                    }
                });
                Vue.config.devtools = true;
            </script>

    </html>