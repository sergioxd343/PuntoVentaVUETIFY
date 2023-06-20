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
                            Rúbrica de observación de clase
                        </v-card-title>
                        <!--En este apartado estan los inputs para comenzar el registro-->

                        <v-container fluid class="elevation-2">
                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">

                                <v-col md="3">
                                    <!--Unidad Academica-->
                                    <v-autocomplete v-model="cve_unidad_academica" outlined label="Unidad Académica"
                                        persistent-hint v-validate="'required|max:100'" data-vv-name="área académica"
                                        :items="arrayUnidadAcademica" item-value="cve_unidad_academica"
                                        item-text="nombre_unidad_academica" :error="errors.has('área académica')"
                                        :error-messages="errors.first('área académica')"></v-autocomplete>

                                    <!--Departamento-->
                                    <v-autocomplete v-model="cve_departamento" outlined label="Departamento"
                                        persistent-hint v-validate="'required|max:100'" data-vv-name="departamento"
                                        :items="arrayDepartamento" item-value="cve_departamento"
                                        item-text="nombre_departamento" :error="errors.has('departamento')"
                                        :error-messages="errors.first('departamento')"></v-autocomplete>
                                </v-col>

                                <v-col md="3">
                                    <!--Tipo evento-->
                                    <v-autocomplete v-model="cve_tipo_evento" outlined label="Tipo de evento"
                                        persistent-hint v-validate="'required|max:100'" data-vv-name="tipo de evento"
                                        :items="arrayTipoEvento" item-value="cve_tipo_evento"
                                        item-text="nombre_tipo_evento" :error="errors.has('tipo de evento')"
                                        :error-messages="errors.first('tipo de evento')"></v-autocomplete>
                                    <!--UGAC-->
                                    <v-autocomplete v-model="cve_ugac" outlined label="UGAC" persistent-hint
                                        v-validate="'required|max:100'" data-vv-name="UGAC" :items="arrayUGAC"
                                        item-value="cve_ugac" item-text="nombre_ugac" :error="errors.has('UGAC')"
                                        :error-messages="errors.first('UGAC')"></v-autocomplete>
                                </v-col>
                                <v-col md="3">
                                    <!--Numero PTC-->
                                    <v-text-field v-model="numero_ptc" outlined label="Número de PTC" persistent-hint
                                        v-validate="'required|max:255'" data-vv-name="ptc" pattern="[0-9]*"
                                        type="number" :error="errors.has('ptc')"
                                        :error-messages="errors.first('ptc')"></v-text-field>

                                    <!--Año de aplicación-->
                                    <v-menu ref="menu1" :close-on-content-click="false"
                                        :return-value.sync="anio_aplicacion" transition="scale-transition" offset-y
                                        min-width="auto">
                                        <template v-slot:activator="{ on, attrs }">
                                            <v-text-field v-model="anio_aplicacion" label="Año de aplicación"
                                                prepend-icon="mdi-calendar" readonly v-bind="attrs"
                                                v-on="on"></v-text-field>
                                        </template>
                                        <v-date-picker v-model="anio_aplicacion" no-title scrollable type="year">
                                            <v-spacer></v-spacer>
                                            <v-btn text color="primary" @click="menu1 = false">
                                                Cancel
                                            </v-btn>
                                            <v-btn text color="primary" @click="$refs.menu1.save(anio_aplicacion)">
                                                OK
                                            </v-btn>
                                        </v-date-picker>
                                    </v-menu>
                                </v-col>
                                <p class="font-weight-light">
                                    Con el fin de identificar el contexto educativo del personal docente y que permita
                                    construir el plan de capacitación anual se le solicita realizar un análisis
                                    situacional
                                    al PTC. Tome en cuenta los resultados de las evaluaciones docentes, desempeño de
                                    tutoreo
                                    observaciones, necesidades y mejoras sobre la capacitación al interior del Programa
                                    Educativo (PE) Su aportación será valiosa para establecer mejoras en la capacitación
                                    que
                                    se proporciona al profesorado y alcanzar el desarrollo de las competencias docentes
                                    y la
                                    actualización en el área de especialidad.
                                </p>


                                <v-col md="9">
                                    <v-card>
                                        <v-list>
                                            <!-- Encabezado de la tabla -->
                                            <v-row class="grey lighten-3">
                                                <v-col cols="3">
                                                    <v-list-item-content>
                                                        <v-list-item-title
                                                            class="font-weight-bold text-wrap text-center">
                                                            Media
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                                <v-col cols="4">
                                                    <v-list-item-content>
                                                        <v-list-item-title
                                                            class="font-weight-bold text-wrap text-center">
                                                            Evaluación Docente
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                                <v-col cols="4">
                                                    <v-list-item-content>
                                                        <v-list-item-title
                                                            class="font-weight-bold text-wrap text-center">
                                                            Evaluación Tutoreo
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                            </v-row>

                                            <!-- Filas de la tabla -->
                                            <v-row>
                                                <v-col cols="3">
                                                    <v-list-item-content>
                                                        <v-list-item-title class="text-wrap text-center">
                                                            Media Institucional
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                                <v-col cols="4">
                                                    <v-list-item-content>
                                                        <v-list-item-title class="text-wrap text-center">
                                                            <v-text-field v-model="media_evaluacion_docente" outlined
                                                                label="Media de evaluación docente" persistent-hint
                                                                v-validate="{required: true, min_value: 7, max_value: 10}"
                                                                data-vv-name="evaluació docente" inputmode="numeric"
                                                                pattern="[0-9]*"
                                                                :error="errors.has('evaluació docente')"
                                                                :error-messages="errors.first('evaluació docente')"></v-text-field>
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                                <v-col cols="4">
                                                    <v-list-item-content>
                                                        <v-list-item-title>
                                                            <v-text-field v-model="media_evaluacion_tutoreo" outlined
                                                                label="Media de evaluación tutoreo" persistent-hint
                                                                v-validate="{required: true, min_value: 7, max_value: 10}"
                                                                data-vv-name="evaluación tutoreo" inputmode="numeric"
                                                                pattern="[0-9]*"
                                                                :error="errors.has('evaluación tutoreo')"
                                                                :error-messages="errors.first('evaluación tutoreo')"></v-text-field>
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                            </v-row>
                                        </v-list>
                                    </v-card>
                                </v-col>

                                <v-col md="9">
                                    <v-card>
                                        <v-list>
                                            <!-- Encabezado de la tabla -->
                                            <v-row class="grey lighten-3">
                                                <v-col cols="3">
                                                    <v-list-item-content>
                                                        <v-list-item-title
                                                            class="font-weight-bold text-wrap text-center">
                                                            Resultados
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                                <v-col cols="4">
                                                    <v-list-item-content>
                                                        <v-list-item-title
                                                            class="font-weight-bold text-wrap text-center">
                                                            Evaluación Docente
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                                <v-col cols="4">
                                                    <v-list-item-content>
                                                        <v-list-item-title
                                                            class="font-weight-bold text-wrap text-center">
                                                            Evaluación Tutoreo
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                            </v-row>

                                            <!-- Filas de la tabla -->
                                            <v-row>
                                                <v-col cols="3">
                                                    <v-list-item-content>
                                                        <v-list-item-title class="text-wrap text-center">
                                                            Promedio anual de Evaluación de academia
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                                <v-col cols="4">
                                                    <v-list-item-content>
                                                        <v-list-item-title class="text-wrap text-center">
                                                            <v-text-field v-model="promedio_evaluacion_docente" outlined
                                                                label="Promedio de evaluación docente" persistent-hint
                                                                v-validate="{required: true, min_value: 7, max_value: 10}"
                                                                data-vv-name="promedio evaluació docente"
                                                                inputmode="numeric" pattern="[0-9]*"
                                                                :error="errors.has('promedio evaluació docente')"
                                                                :error-messages="errors.first('promedio evaluació docente')"></v-text-field>
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                                <v-col cols="4">
                                                    <v-list-item-content>
                                                        <v-list-item-title>
                                                            <v-text-field v-model="promedio_evaluacion_tutoreo" outlined
                                                                label="Promedio de evaluación tutoreo" persistent-hint
                                                                v-validate="{required: true, min_value: 7, max_value: 10}"
                                                                data-vv-name="promedio evaluación tutoreo"
                                                                inputmode="numeric" pattern="[0-9]*"
                                                                :error="errors.has('promedio evaluación tutoreo')"
                                                                :error-messages="errors.first('promedio evaluación tutoreo')"></v-text-field>
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                            </v-row>
                                        </v-list>
                                    </v-card>
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
                                                            Porcentaje
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                                <v-col cols="7">
                                                    <v-list-item-content>
                                                        <v-list-item-title
                                                            class="font-weight-bold text-wrap text-center">
                                                            Indicador de capacitación PTC
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>

                                            </v-row>

                                            <!-- Filas de la tabla -->
                                            <v-row>
                                                <v-col cols="4">
                                                    <v-list-item-content>
                                                        <v-list-item-title class="text-wrap text-center">
                                                            Porcentaje de docentes con curso acreditado en academia
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                                <v-col cols="7">
                                                    <v-list-item-content>
                                                        <v-list-item-title class="text-wrap text-center">
                                                            <v-text-field v-model="porcentaje_docentes_acreditados"
                                                                outlined label="Porcentaje de docentes acreditados"
                                                                persistent-hint
                                                                v-validate="{required: true, min_value: 0, max_value: 100}"
                                                                data-vv-name="porcentaje docentes acreditados"
                                                                inputmode="numeric" pattern="[0-9]*"
                                                                :error="errors.has('porcentaje docentes acreditados')"
                                                                :error-messages="errors.first('porcentaje docentes acreditados')"></v-text-field>
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                            </v-row>
                                        </v-list>
                                    </v-card>
                                </v-col>

                                <v-col md="9">
                                    <!--Fortalezas-->
                                    <div class="hint-text">(Elementos positivos e internos que permitan el logro de los
                                        objetivos) </div>
                                    <v-textarea v-model="fortalezas" outlined label="Fortalezas:" persistent-hint
                                        v-validate="'max:255'"></v-textarea>
                                </v-col>
                                <v-col md="9">
                                    <!--Debilidades-->
                                    <div class="hint-text">(Elementos negativos internos que afectan el logro de los
                                        objetivos)</div>
                                    <v-textarea v-model="debilidades" outlined label="Debilidades:" persistent-hint
                                        v-validate="'max:255'"></v-textarea>
                                </v-col>
                                <v-col md="9">
                                    <!--Necesidades-->
                                    <div class="hint-text"> (Basados en los resultados de encuestas, entregables,
                                        resultados de evaluación y seguimientos al docente, acreditaciones,
                                        actualizaciones de PE, proyectando un proceso formativo de 1 año)</div>
                                    <v-textarea v-model="necesidades" outlined label="Necesidades detectadas:"
                                        persistent-hint v-validate="'max:255'"></v-textarea>
                                </v-col>
                                <v-col md="9">
                                    <!--Tipos de necesidades-->
                                    <div class="hint-text">(Detallar el tipo de capacitación que se requiere; curso,
                                        taller, diplomado, certificación, etc.) </div>
                                    <v-textarea v-model="estrategias_intervencion" outlined
                                        label="Tipos de necesidades:" persistent-hint
                                        v-validate="'max:255'"></v-textarea>
                                </v-col>
                                <v-col md="9">
                                    <!--Prioridad de capacitación-->
                                    <div class="hint-text">(Indicar si se requiere de cursos, talleres, diplomados o
                                        certificaciones para atender una necesidad prioritaria, basado en:
                                        Acreditaciones de PE, certificaciones, actualización de PE, etc (A ejecutar en 1
                                        año) )</div>
                                    <v-textarea v-model="prioridad_capacitacion" outlined
                                        label="Prioridad de capacitación:" persistent-hint
                                        v-validate="'max:255'"></v-textarea>
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
                                        <v-data-table :headers="headersAnalisis" :items="dataAnalisis"
                                            :search="searchAnalisis" class="elevation-2"
                                            no-data-text="No se encontro ningun registro"
                                            :hide-default-header="dataAnalisis.length < 1"
                                            :hide-default-footer="dataAnalisis.length < 1" locale="es-ES"
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
                                                cve_analisis_docente = item.cve_analisis_docente;
                                                cve_unidad_academica = item.cve_unidad_academica;
                                                cve_departamento = item.cve_departamento;
                                                cve_tipo_evento = item.cve_tipo_evento;
                                                cve_ugac = item.cve_ugac;
                                                numero_ptc = item.numero_ptc;
                                                anio_aplicacion = item.anio_aplicacion;
                                                media_evaluacion_docente = item.media_evaluacion_docente;
                                                media_evaluacion_tutoreo = item.media_evaluacion_tutoreo;
                                                promedio_evaluacion_tutoreo = item.promedio_evaluacion_tutoreo;
                                                promedio_evaluacion_docente = item.promedio_evaluacion_docente;
                                                porcentaje_docentes_acreditados = item.porcentaje_docentes_acreditados;
                                                fortalezas = item.fortalezas;
                                                debilidades = item.debilidades;
                                                necesidades = item.necesidades;
                                                prioridad_capacitacion = item.prioridad_capacitacion;
                                                estrategias_intervencion = item.estrategias_intervencion;
                                                activo = item.activo;
                                                fecha_registro = item.fecha_registro;
                                                usuario_registro = item.usuario_registro;
                                                    
                                                "><v-icon>mdi-square-edit-outline</v-icon></v-btn>
                                            </template>
                                            <template v-slot:item.password="{item}">
                                                <v-tooltip bottom>
                                                    <template v-slot:activator="{on, attrs}">
                                                        <span v-bind="attrs" v-on="on" @click="navigator.clipboard.writeText(item.password); mostrarSnackbar('success', 'Texto copiado al portapapeles.')"><b>{{item.password}}</b></span>
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
                                <v-text-field outlined label="Nombre de departamento" v-model="nombreBuscar"
                                    @keyup.enter="fnBusquedaDepartamento()"></v-text-field>
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
                        const ctr = "../../controlador/Controlador_analisisSituacionalDocente.jsp";

                        const cve_analisis_docente = ref("");
                        const cve_unidad_academica = ref("");
                        const cve_departamento = ref("");
                        const cve_tipo_evento = ref("");
                        const cve_ugac = ref("");
                        const numero_ptc = ref("");
                        const anio_aplicacion = ref("");
                        const media_evaluacion_docente = ref("");
                        const media_evaluacion_tutoreo = ref("");
                        const promedio_evaluacion_tutoreo = ref("");
                        const promedio_evaluacion_docente = ref("");
                        const porcentaje_docentes_acreditados = ref("");
                        const fortalezas = ref("");
                        const debilidades = ref("");
                        const necesidades = ref("");
                        const prioridad_capacitacion = ref("");
                        const estrategias_intervencion = ref("");
                        const activo = ref("");
                        const fecha_registro = ref("");
                        const usuario_registro = ref("");

                        const arrayUnidadAcademica = ref([]);
                        const arrayDepartamento = ref([]);
                        const arrayTipoEvento = ref([]);
                        const arrayUGAC = ref([]);
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
                        const dataAnalisis = ref([]);
                        const dataUsuarios = ref([]);
                        const headersAnalisis = ref([
                            { text: 'No', align: 'left', sortable: true, value: 'cve_analisis_docente' },
                            { text: 'Nombre del departamento', align: 'left', sortable: true, value: 'nombre_departamento' },
                            { text: 'Unidad Ácademica', align: 'left', sortable: true, value: 'nombre_unidad_academica' },
                            { text: 'Tipo de evento', align: 'left', sortable: true, value: 'nombre_tipo_evento' },
                            { text: 'Estatus', align: 'left', sortable: true, value: 'activo' },
                            { text: 'Editar', align: 'left', sortable: true, value: 'editar' },
                        ]);
                        const searchAnalisis = ref([]);

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
                            fnDepartamento();
                            fnTipoEvento();
                            fnUnidadAcademica();
                            fnUGAC();
                            fnConsultarTabla();
                        });
                        //Consultar datos en la base de datos.
                        async function fnUnidadAcademica() {
                            try {
                                preloader("../../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 4);
                                let { data, status } = await axios.post(ctr, parametros)
                                if (status == 200) {
                                    if (data.length > 0) {
                                        arrayUnidadAcademica.value = data
                                    }
                                }
                            } catch (error) {
                                mostrarSnackbar('error');
                                console.error(error);
                            } finally {
                                swal.close();
                            }
                        }
                        async function fnDepartamento() {
                            try {
                                preloader("../../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 5);
                                let { data, status } = await axios.post(ctr, parametros)
                                if (status == 200) {
                                    if (data.length > 0) {
                                        arrayDepartamento.value = data
                                    }
                                }
                            } catch (error) {
                                mostrarSnackbar('error');
                                console.error(error);
                            } finally {
                                swal.close();
                            }
                        }
                        async function fnTipoEvento() {
                            try {
                                preloader("../../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 6);
                                let { data, status } = await axios.post(ctr, parametros)
                                if (status == 200) {
                                    if (data.length > 0) {
                                        arrayTipoEvento.value = data
                                    }
                                }
                            } catch (error) {
                                mostrarSnackbar('error');
                                console.error(error);
                            } finally {
                                swal.close();
                            }
                        }
                        async function fnUGAC() {
                            try {
                                preloader("../../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 7);
                                let { data, status } = await axios.post(ctr, parametros)
                                if (status == 200) {
                                    if (data.length > 0) {
                                        arrayUGAC.value = data
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
                                        data.forEach(item => {
                                            if (item.activo === false) {
                                                item.activo = "Cancelado";
                                            } else {
                                                item.activo = "Revisado";
                                            }
                                        });
                                        dataAnalisis.value = data;
                                    }
                                }
                            } catch (error) {
                                mostrarSnackbar('error');
                                console.error(error);
                            } finally {
                                swal.close();
                            }
                        }

                        function fnBusquedaDepartamento() {
                            this.dataAnalisis = this.dataAnalisis.filter(item => item.nombre_departamento === this.nombreBuscar);
                        }

                        async function fnGuardar() {
                            this.$validator.validate().then(async esValido => {
                                if (esValido) {
                                    try {
                                        preloader("../../");
                                        let parametros = new URLSearchParams();
                                        parametros.append("accion", 2);
                                        parametros.append("cve_unidad_academica", cve_unidad_academica.value);
                                        parametros.append("cve_departamento", cve_departamento.value);
                                        parametros.append("cve_tipo_evento", cve_tipo_evento.value);
                                        parametros.append("cve_ugac", cve_ugac.value);
                                        parametros.append("numero_ptc", numero_ptc.value);
                                        parametros.append("anio_aplicacion", parseInt(anio_aplicacion.value.slice(0, 4), 10));
                                        parametros.append("media_evaluacion_docente", media_evaluacion_docente.value);
                                        parametros.append("media_evaluacion_tutoreo", media_evaluacion_tutoreo.value);
                                        parametros.append("promedio_evaluacion_tutoreo", promedio_evaluacion_tutoreo.value);
                                        parametros.append("promedio_evaluacion_docente", promedio_evaluacion_docente.value);
                                        parametros.append("porcentaje_docentes_acreditados", porcentaje_docentes_acreditados.value);
                                        parametros.append("fortalezas", fortalezas.value);
                                        parametros.append("debilidades", debilidades.value);
                                        parametros.append("necesidades", necesidades.value);
                                        parametros.append("prioridad_capacitacion", prioridad_capacitacion.value);
                                        parametros.append("estrategias_intervencion", estrategias_intervencion.value);

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

                                        //ejemplo: parametros.append("idSolicitudCapacitacion", idSolicitudCapacitacion.value);


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

                            cve_analisis_docente.value = "";
                            cve_unidad_academica.value = "";
                            cve_departamento.value = "";
                            cve_tipo_evento.value = "";
                            cve_ugac.value = "";
                            numero_ptc.value = "";
                            anio_aplicacion.value = "";
                            media_evaluacion_docente.value = "";
                            media_evaluacion_tutoreo.value = "";
                            promedio_evaluacion_tutoreo.value = "";
                            promedio_evaluacion_docente.value = "";
                            porcentaje_docentes_acreditados.value = "";
                            fortalezas.value = "";
                            debilidades.value = "";
                            necesidades.value = "";
                            prioridad_capacitacion.value = "";
                            estrategias_intervencion.value = "";
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
                            cve_analisis_docente, cve_unidad_academica, cve_departamento, cve_tipo_evento,
                            cve_ugac, numero_ptc, anio_aplicacion, media_evaluacion_docente, media_evaluacion_tutoreo,
                            promedio_evaluacion_tutoreo, promedio_evaluacion_docente, porcentaje_docentes_acreditados,
                            fortalezas, debilidades, necesidades, prioridad_capacitacion, estrategias_intervencion, activo,
                            fecha_registro, usuario_registro,
                            arrayUnidadAcademica, arrayUGAC, arrayTipoEvento, arrayDepartamento,fnBusquedaDepartamento,
                            dialogBuscador, nombreBuscar, searchBusqueda,
                            fnDepartamento, fnTipoEvento, fnUnidadAcademica, fnUGAC, fnConsultarTabla,
                            color_snackbar, snackbar, mensaje_snackbar, loader, mostrarSnackbar,
                            headersAnalisis, flagEditar, dataAnalisis, searchAnalisis, fnLimpiarCampos, fnGuardar,
                            fnEditar, itemEditar
                        }
                    }
                });
                Vue.config.devtools = true;
            </script>

    </html>