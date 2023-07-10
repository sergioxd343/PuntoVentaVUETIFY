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
        <title>Análisis situacional docente</title>
    </head>
    <style>
        body {
            font-family: 'Roboto';
        }

        .tooltip-trigger {
            cursor: pointer;
        }
    </style>

    <body>
        <div id="app">
            <v-app>
                <v-container fluid>
                    <v-card>
                        <v-card-title style="background-color: #00b293; color:#ffffff; headline">
                            Análisis situacional docente
                        </v-card-title>
                        <!--En este apartado estan los inputs para comenzar el registro-->

                        <v-container fluid class="elevation-2">
                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">

                                <v-col md="6">
                                    <!--Unidad Academica-->
                                    <v-autocomplete v-model="cve_unidad_academica" outlined label="Unidad Académica"
                                        persistent-hint v-validate="'required|max:100'" data-vv-name="área académica"
                                        :items="arrayUnidadAcademica" item-value="cve_unidad_academica"
                                        item-text="nombre_unidad_academica" :error="errors.has('área académica')"
                                        :error-messages="errors.first('área académica')"></v-autocomplete>

                                    <!--Nombre de la Academia-->
                                    <v-autocomplete v-model="cve_academia" outlined label="Nombre de la academia:"
                                        persistent-hint v-validate="'required|max:100'"
                                        data-vv-name="nombre de academia" :items="arrayAcademia"
                                        item-value="cve_academia" item-text="nombre_academia"
                                        :error="errors.has('nombre de academia')"
                                        :error-messages="errors.first('nombre de academia')"></v-autocomplete>

                                    <!--Programa Educativo-->
                                    <v-text-field v-model="programa_educativo" outlined label="Programa educativo:"
                                        persistent-hint v-validate="'required|max:255'"
                                        data-vv-name="programa educativo" type="text"
                                        :error="errors.has('programa educativo')"
                                        :error-messages="errors.first('programa educativo')"></v-text-field>
                                </v-col>

                                <v-col md="6">
                                    <!--Numero PTC-->
                                    <v-text-field v-model="numero_ptc" outlined label="N° de PTC:" persistent-hint
                                        v-validate="'required|max:255'" data-vv-name="ptc" pattern="[0-9]*"
                                        type="number" :error="errors.has('ptc')"
                                        :error-messages="errors.first('ptc')"></v-text-field>

                                    <!--Fecha de registro-->
                                    <v-menu style="margin-top: 10px;" ref="menu1" :close-on-content-click="false"
                                        :return-value.sync="fechaActual" transition="scale-transition" offset-y
                                        min-width="auto">
                                        <template v-slot:activator="{ on, attrs }">
                                            <v-text-field v-model="fechaActual" label="Fecha de registro"
                                                prepend-icon="mdi-calendar" readonly></v-text-field>
                                        </template>
                                        <v-date-picker v-model="fechaActual" no-title scrollable :readonly="true">
                                            <v-spacer></v-spacer>
                                            <v-btn text color="primary" @click="menu1 = false">
                                                Cancel
                                            </v-btn>
                                            <v-btn text color="primary" @click="$refs.menu1.save(fechaActual)">
                                                OK
                                            </v-btn>
                                        </v-date-picker>
                                    </v-menu>

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
                                <v-col md="3">



                                </v-col>
                                <template>
                                    <div>
                                        <p class="font-weight-light">
                                            Con el fin de identificar el contexto educativo del personal docente y que
                                            permita construir el plan de capacitación anual se le solicita realizar un
                                            análisis situacional al PTC.
                                            <v-tooltip bottom open-on-hover>
                                                <template v-slot:activator="{ on, attrs }">
                                                    <span class="tooltip-trigger" v-bind="attrs" v-on="on">
                                                        <v-icon>
                                                            mdi-information
                                                        </v-icon>
                                                    </span>
                                                </template>
                                                <span>Tome en cuenta los resultados de las evaluaciones docentes,
                                                    desempeño de
                                                    tutoreo observaciones, necesidades y mejoras sobre la capacitación
                                                    al
                                                    interior del Programa Educativo (PE).
                                                    Su aportación será valiosa para establecer mejoras en la
                                                    capacitación que se
                                                    proporciona al profesorado y alcanzar el desarrollo de las
                                                    competencias
                                                    docentes y la actualización en el área de especialidad.</span>
                                            </v-tooltip>
                                        </p>
                                    </div>
                                </template>

                                <p class="font-weight-light">
                                    En el siguiente apartado inserte los resultados de evaluación docente, evaluación de
                                    tutoreo e indicadores de capacitación:
                                </p>


                                <v-col md="12">
                                    <v-card>
                                        <v-list>
                                            <!-- Encabezado de la tabla -->
                                            <v-row class="grey lighten-3">
                                                <v-col cols="4">
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
                                                <v-col cols="4" class="my-5">
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
                                                                class="my-2" label="Media de evaluación docente"
                                                                persistent-hint
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
                                                                class="my-2" label="Media de evaluación tutoreo"
                                                                persistent-hint
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

                                <v-col md="12">
                                    <v-card>
                                        <v-list>
                                            <!-- Encabezado de la tabla -->
                                            <v-row class="grey lighten-3">
                                                <v-col cols="4">
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
                                            </v-row>


                                            <!-- Filas de la tabla -->
                                            <v-row>
                                                <v-col cols="4" class="my-5">
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
                                                                class="my-2" label="Promedio de evaluación docente"
                                                                persistent-hint
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
                                                                class="my-2" label="Promedio de evaluación tutoreo"
                                                                persistent-hint
                                                                v-validate="{required: true, min_value: 7, max_value: 10}"
                                                                data-vv-name="promedio evaluación tutoreo"
                                                                inputmode="numeric" pattern="[0-9]*"
                                                                :error="errors.has('promedio evaluación tutoreo')"
                                                                :error-messages="errors.first('promedio evaluación tutoreo')"></v-text-field>
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                                <v-col class="mx-4">
                                                    <span class="font-weight-light">
                                                        *Del cuatrimestre Inmediato anterior.<br>
                                                        *Del año inmediato anterior.
                                                    </span>
                                                </v-col>
                                            </v-row>
                                        </v-list>
                                    </v-card>
                                </v-col>


                                <v-col md="12">
                                    <v-card>
                                        <v-list>
                                            <!-- Encabezado de la tabla -->
                                            <v-row class="grey lighten-3">
                                                <v-col cols="6">
                                                    <v-list-item-content>
                                                        <v-list-item-title
                                                            class="font-weight-bold text-wrap text-center">
                                                            Porcentaje
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                                <v-col cols="6">
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
                                                <v-col cols="6" class="my-5">
                                                    <v-list-item-content>
                                                        <v-list-item-title class="text-wrap text-center">
                                                            Porcentaje de docentes con curso acreditado en academia
                                                        </v-list-item-title>
                                                    </v-list-item-content>
                                                </v-col>
                                                <v-col cols="6">
                                                    <v-list-item-content>
                                                        <v-list-item-title class="text-wrap text-center">
                                                            <v-text-field v-model="porcentaje_docentes_acreditados"
                                                                outlined label="Porcentaje de docentes acreditados"
                                                                class="my-2" persistent-hint
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

                                <p class="font-weight-light my-12">
                                    Instrucciones: En los siguientes apartados, argumente los elementos que se solicitan
                                    basados en la participación y acreditación de cursos, evaluaciones
                                    institucionales y trabajo colaborativo dentro de la academia:

                                </p>

                                <v-col md="9">
                                    <!--Fortalezas-->
                                    <v-textarea v-model="fortalezas" outlined label="Fortalezas:" persistent-hint
                                        v-validate="'max:255'" class="mx-2" rows="1"
                                        prepend-icon="mdi-comment"></v-textarea>
                                </v-col>
                                <v-col md="2">
                                    <v-tooltip bottom open-on-hover>
                                        <template v-slot:activator="{ on, attrs }">
                                            <span class="tooltip-trigger" v-bind="attrs" v-on="on">
                                                <v-icon class="display-1">
                                                    mdi-information
                                                </v-icon>
                                            </span>
                                        </template>
                                        <span>
                                            Elementos positivos e internos que permitan el logro de los
                                            objetivos
                                        </span>
                                    </v-tooltip>
                                </v-col>

                                <v-col md="9">
                                    <!--Debilidades-->
                                    <v-textarea v-model="debilidades" outlined label="Debilidades:" persistent-hint
                                        v-validate="'max:255'" class="mx-2" rows="1"
                                        prepend-icon="mdi-comment"></v-textarea>
                                </v-col>
                                <v-col md="2">
                                    <v-tooltip bottom open-on-hover>
                                        <template v-slot:activator="{ on, attrs }">
                                            <span class="tooltip-trigger" v-bind="attrs" v-on="on">
                                                <v-icon class="display-1">
                                                    mdi-information
                                                </v-icon>
                                            </span>
                                        </template>
                                        <span>
                                            Elementos negativos internos que afectan el logro de los
                                            objetivos
                                        </span>
                                    </v-tooltip>
                                </v-col>

                                <v-col md="9">
                                    <!--Necesidades-->
                                    <v-textarea v-model="necesidades" outlined label="Necesidades detectadas:"
                                        persistent-hint v-validate="'max:255'" class="mx-2" rows="1"
                                        prepend-icon="mdi-comment"></v-textarea>
                                </v-col>
                                <v-col md="2">
                                    <v-tooltip bottom open-on-hover>
                                        <template v-slot:activator="{ on, attrs }">
                                            <span class="tooltip-trigger" v-bind="attrs" v-on="on">
                                                <v-icon class="display-1">
                                                    mdi-information
                                                </v-icon>
                                            </span>
                                        </template>
                                        <span>
                                            Basados en los resultados de encuestas, entregables,
                                            resultados de evaluación y seguimientos al docente, acreditaciones,
                                            actualizaciones de PE, proyectando un proceso formativo de 1 año
                                        </span>
                                    </v-tooltip>
                                </v-col>

                                <v-col md="9">
                                    <!--Tipos de necesidades-->
                                    <v-textarea v-model="estrategias_intervencion" outlined
                                        label="Tipos de necesidades:" persistent-hint v-validate="'max:255'"
                                        class="mx-2" rows="1" prepend-icon="mdi-comment"></v-textarea>
                                </v-col>
                                <v-col md="2">
                                    <v-tooltip bottom open-on-hover>
                                        <template v-slot:activator="{ on, attrs }">
                                            <span class="tooltip-trigger" v-bind="attrs" v-on="on">
                                                <v-icon class="display-1">
                                                    mdi-information
                                                </v-icon>
                                            </span>
                                        </template>
                                        <span>
                                            Detallar el tipo de capacitación que se requiere; curso,
                                            taller, diplomado, certificación, etc
                                        </span>
                                    </v-tooltip>
                                </v-col>

                                <v-col md="9">
                                    <!--Prioridad de capacitación-->
                                    <v-textarea v-model="prioridad_capacitacion" outlined
                                        label="Prioridad de capacitación:" persistent-hint v-validate="'max:255'"
                                        class="mx-2" rows="1" prepend-icon="mdi-comment"></v-textarea>
                                </v-col>
                                <v-col md="2">
                                    <v-tooltip bottom open-on-hover>
                                        <template v-slot:activator="{ on, attrs }">
                                            <span class="tooltip-trigger" v-bind="attrs" v-on="on">
                                                <v-icon class="display-1">
                                                    mdi-information
                                                </v-icon>
                                            </span>
                                        </template>
                                        <span>
                                            Indicar si se requiere de cursos, talleres, diplomados o
                                        certificaciones para atender una necesidad prioritaria, basado en:
                                        Acreditaciones de PE, certificaciones, actualización de PE, etc (A ejecutar en 1
                                        año) 
                                        </span>
                                    </v-tooltip>
                                </v-col>
                                <v-col md="4">
                                    <!--Estatus-->
                                    <v-radio-group v-model="estatus" v-if="false">
                                        Seleccione el estatus del proyecto:
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

                                <v-card>
                                    <v-card-title class="text-h5 grey lighten-2">
                                        Búsqueda Avanzada
                                    </v-card-title>
                                    <v-card-text>
                                        <v-row justify="center">
                                            <v-col md=8>
                                                <v-text-field outlined label="Academia | Año de aplicación | Gestor "
                                                    v-model="nombreBuscar" append-icon="mdi-magnify"
                                                    @input="fnBusqueda()"></v-text-field>
                                            </v-col>
                                        </v-row>
                                    </v-card-text>
                                </v-card>

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
                                                <v-btn fab small color="warning" @click="fnEditarItem(item)"
                                                    :disabled="!userPermission">
                                                    <v-icon>mdi-square-edit-outline</v-icon>
                                                </v-btn>
                                            </template>
                                            <template v-slot:item.estatus="{item}">
                                                <v-chip class="ma-2 "
                                                    style="width: 100px; display: flex; justify-content: center; align-items: center;"
                                                    link @click="fnCambiarEstatus(item)"
                                                    :color="item.estatus ? 'success' : 'yellow'" outlined>
                                                    {{ item.estatus ?
                                                    "Revisado" : "Cancelado" }}
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
                        const ctr = "../../controlador/innovacion_educativa/Controlador_analisis_situacional_docente.jsp";

                        const cve_analisis_docente = ref("");
                        const cve_unidad_academica = ref("");
                        const cve_academia = ref("");
                        //const cve_departamento = ref("");
                        //const cve_tipo_evento = ref("");
                        //const cve_ugac = ref("");
                        const programa_educativo = ref("");
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
                        const estatus = ref("");

                        const fechaActual = ref("");
                        const userPermission = ref(true);

                        const opc_revisado = ref("");
                        const opc_cancelado = ref("");


                        const arrayUnidadAcademica = ref([]);
                        const arrayAcademia = ref([]);
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

                        const currentUser = localStorage.getItem("currentUser");
                        const currentUserObj = JSON.parse(currentUser);
                        const usuario_registro = currentUserObj[0].cve_persona;

                        //Otras variables
                        const flagEditar = ref(false);
                        const itemEditar = ref({});

                        //DataUsuarios
                        const dataAnalisis = ref([]);
                        const dataUsuarios = ref([]);
                        const headersAnalisis = ref([
                            { text: 'No', align: 'left', sortable: true, value: 'cve_analisis_docente' },
                            { text: 'Nombre de Unidad Academica', align: 'left', sortable: true, value: 'nombre_unidad_academica' },
                            { text: 'Académia', align: 'left', sortable: true, value: 'nombre_academia' },
                            { text: 'Usuario de registro', align: 'left', sortable: true, value: 'nombre_completo' },
                            { text: 'Año de aplicación', align: 'left', sortable: true, value: 'anio_aplicacion' },
                            { text: 'Fecha de registro', align: 'left', sortable: true, value: 'fecha_registro' },
                            { text: 'Estatus', align: 'center', sortable: true, value: 'estatus' },
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
                            //fnDepartamento();
                            //fnTipoEvento();
                            fnUnidadAcademica();
                            fnAcademia();
                            //fnUGAC();
                            fnConsultarTabla();
                            fnReasignacionDatos();
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
                        async function fnAcademia() {
                            try {
                                preloader("../../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 8);
                                let { data, status } = await axios.post(ctr, parametros)
                                if (status == 200) {
                                    if (data.length > 0) {
                                        arrayAcademia.value = data
                                    }
                                }
                            } catch (error) {
                                mostrarSnackbar('error');
                                console.error(error);
                            } finally {
                                swal.close();
                            }
                        }
                        /*
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
                        }*/
                        /*
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
                        */

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

                        async function fnCambiarEstatus(item) {
                            try {
                                preloader("../../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 3);

                                parametros.append("estatus", (item.estatus == true ? 0 : 1));
                                parametros.append("cve_analisis_docente", item.cve_analisis_docente);
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

                        function fnEditarItem(item) {
                            this.flagEditar = true;
                            this.itemEditar = item;
                            this.cve_analisis_docente = item.cve_analisis_docente;
                            this.cve_unidad_academica = item.cve_unidad_academica;
                            this.cve_academia = item.cve_academia;
                            this.numero_ptc = item.numero_ptc;
                            this.programa_educativo = item.programa_educativo;
                            this.anio_aplicacion = item.anio_aplicacion.toString();
                            this.media_evaluacion_docente = item.media_evaluacion_docente;
                            this.media_evaluacion_tutoreo = item.media_evaluacion_tutoreo;
                            this.promedio_evaluacion_tutoreo = item.promedio_evaluacion_tutoreo;
                            this.promedio_evaluacion_docente = item.promedio_evaluacion_docente;
                            this.porcentaje_docentes_acreditados = item.porcentaje_docentes_acreditados;
                            this.fortalezas = item.fortalezas;
                            this.debilidades = item.debilidades;
                            this.necesidades = item.necesidades;
                            this.fechaActual = item.fecha_registro;
                            this.prioridad_capacitacion = item.prioridad_capacitacion;
                            this.estrategias_intervencion = item.estrategias_intervencion;
                            this.activo = item.activo;
                            this.fecha_registro = item.fecha_registro;
                            this.usuario_registro = item.usuario_registro;
                            this.estatus = item.estatus === "Revisado" ? "opc_validado" : "opc_cancelado";
                        }

                        function fnBusqueda() {
                            if (this.nombreBuscar === '') {
                                this.fnConsultarTabla();
                            } else {
                                this.dataAnalisis = this.dataAnalisis.filter(item => {
                                    const academiaRegistroMatch = item.nombre_academia.toLowerCase().includes(this.nombreBuscar.toLowerCase());
                                    const fechaRegistroMatch = item.fecha_registro.toLowerCase().includes(this.nombreBuscar.toLowerCase());
                                    const usuarioRegistroMatch = item.nombre_completo.toLowerCase().includes(this.nombreBuscar.toLowerCase());

                                    return academiaRegistroMatch || fechaRegistroMatch || usuarioRegistroMatch;
                                });
                            }
                        }

                        function fnReasignacionDatos() {
                            fechaActual.value = new Date().toISOString().substr(0, 10);
                        }

                        async function fnGuardar() {
                            this.$validator.validate().then(async esValido => {
                                try {
                                    preloader("../../");
                                    let parametros = new URLSearchParams();
                                    parametros.append("accion", 2);
                                    parametros.append("cve_unidad_academica", cve_unidad_academica.value);
                                    parametros.append("cve_academia", cve_academia.value);
                                    //parametros.append("cve_departamento", cve_departamento.value);
                                    //parametros.append("cve_tipo_evento", cve_tipo_evento.value);
                                    //parametros.append("cve_ugac", cve_ugac.value);
                                    parametros.append("programa_educativo", programa_educativo.value);
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
                                    parametros.append("fecha_registro", fechaActual.value);
                                    parametros.append("activo", activo.value);
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
                            })
                        }

                        async function fnEditar() {
                            this.$validator.validate().then(async esValido => {
                                try {
                                    preloader("../../");
                                    let parametros = new URLSearchParams();
                                    parametros.append("accion", 9);

                                    parametros.append("cve_unidad_academica", cve_unidad_academica.value);
                                    parametros.append("cve_academia", cve_academia.value);
                                    parametros.append("programa_educativo", programa_educativo.value);
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
                                    parametros.append("fecha_registro", fecha_registro.value);
                                    parametros.append("activo", (activo.value == true ? 0 : 1));
                                    parametros.append("usuario_registro", this.usuario_registro);

                                    parametros.append("cve_analisis_docente", cve_analisis_docente.value);

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
                            })
                        }
                        function fnLimpiarCampos(cx) {//cx = contexto

                            cve_analisis_docente.value = "";
                            cve_academia.value = "";
                            cve_unidad_academica.value = "";
                            //cve_departamento.value = "";
                            //cve_tipo_evento.value = "";
                            //cve_ugac.value = "";
                            programa_educativo.value = "";
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

                            nombreBuscar.value = "";

                            estatus.value = "";


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
                            cve_analisis_docente, cve_unidad_academica, cve_academia,
                            numero_ptc, anio_aplicacion, media_evaluacion_docente, media_evaluacion_tutoreo,
                            promedio_evaluacion_tutoreo, promedio_evaluacion_docente, porcentaje_docentes_acreditados, estatus,
                            fortalezas, debilidades, necesidades, prioridad_capacitacion, estrategias_intervencion, activo,
                            fechaActual, fnReasignacionDatos, userPermission, currentUser, currentUserObj,
                            fecha_registro, usuario_registro, programa_educativo, arrayAcademia,
                            arrayUnidadAcademica, arrayUGAC, arrayTipoEvento, arrayDepartamento, fnBusqueda, fnEditarItem,
                            dialogBuscador, nombreBuscar, searchBusqueda,
                            fnUnidadAcademica, fnConsultarTabla, fnAcademia, fnCambiarEstatus,
                            color_snackbar, snackbar, mensaje_snackbar, loader, mostrarSnackbar,
                            headersAnalisis, flagEditar, dataAnalisis, searchAnalisis, fnLimpiarCampos, fnGuardar,
                            fnEditar, itemEditar
                        }
                    }
                });
                Vue.config.devtools = true;
            </script>

    </html>