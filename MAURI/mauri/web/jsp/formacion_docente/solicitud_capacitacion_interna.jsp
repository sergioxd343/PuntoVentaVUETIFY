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


        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.4/jspdf.debug.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.4/jspdf.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.3/html2pdf.bundle.min.js"></script>
        <title>Solicitud de registro de capacitacíon interna</title>
        
    </head>
    <style>
        body {
            font-family: "Roboto";
        }

        #tabla {
            border-collapse: collapse;
            margin: auto;
        }

        .th,
        .td {
            border: 1px solid gray;
            padding: 1px;
            padding-left: 5px;
            padding-right: 5px;
        }

        .td {
            width: 685px;
        }
    </style>

    <body>
        <div id="app">
            <v-app>
                <v-container fluid>
                    <v-card>
                        <v-card-title style="background-color: #00b293; color:#ffffff;">
                            Solicitud de registro de capacitacíon interna
                        </v-card-title>
                        <v-container fluid>
                            <v-row justify="center" dense>
                                <v-col class="text-center"><b>Datos del Solicitante</b></v-col>
                            </v-row>
                            <v-divider></v-divider>
                            <div id="imprimir">
                                <v-row style="padding: 0px 50px 0px 50px">
                                    <v-col md=12>
                                        <table id="tabla" class="text-left">
                                            <tbody>
                                                <tr>
                                                    <th class="th">Área académica</th>
                                                    <td class="td"> {{area}} </td>
                                                </tr>

                                                <tr>
                                                    <th class="th">Programa educativo</th>
                                                    <td class="td"> {{carrera}} </td>
                                                </tr>

                                                <tr>
                                                    <th class="th">Nombre del solicitante</th>
                                                    <td class="td"> {{nombre}} {{ape1}} {{ape2}} </td>
                                                </tr>

                                                <tr>
                                                    <th class="th">Puesto</th>
                                                    <td class="td"> {{puesto}} </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </v-col>
                                </v-row>



                                <v-row class="align-center" style="padding: 0px 50px 0px 50px">

                                    <!--TIPO DE COMPETENCIA-->
                                    <v-col md="12">
                                        <p>Seleccione el tipo de competencia: </p>
                                        <v-radio-group v-model="tipoCompetencia" class="mt-0" v-validate="'required'"
                                            data-vv-name="tipo de competencia"
                                            :error="errors.has('tipo de competencia')"
                                            :error-messages="errors.first('tipo de competencia')" row :disabled="deshabilitar">
                                            <v-radio label="Pedagógicas" value="pedagógica"></v-radio>
                                            <v-radio label="Investigación " value="investigación"></v-radio>
                                            <v-radio label="Tutoreo" value="tutoreo"></v-radio>
                                            <v-radio label="Digitales" value="digitales"></v-radio>
                                            <v-radio label="Técnicas" value="técnicas"></v-radio>
                                        </v-radio-group>
                                    </v-col>
                                </v-row>

                                <v-row justify="center" dense>
                                    <v-col class="text-center"><b>Datos del Curso</b></v-col>
                                </v-row>
                                <v-row justfy="center" dense>

                                </v-row>
                                <v-divider></v-divider>
                                <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                    <!--NOMBRE DEL CURSO-->
                                    <v-col md="12">
                                        <v-text-field v-model="nombreCurso" outlined label="Nombre del curso"
                                            v-validate="'required'" :disabled="deshabilitar"
                                            :error="errors.has('nombre del curso')" data-vv-name="nombre del curso"
                                            :error-messages="errors.first('nombre del curso')"></v-text-field>
                                    </v-col>
                                </v-row>

                                <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                    <!-- FECHA INICIO -->
                                    <v-col md="6">
                                        <v-menu ref="menu1" :close-on-content-click="false"
                                            :return-value.sync="fechaInicio" transition="scale-transition" offset-y
                                            min-width="auto">
                                            <template v-slot:activator="{ on, attrs }">
                                                <v-text-field v-validate="'required'" data-vv-name="fecha inicio"
                                                    :error="errors.has('fecha inicio')" v-model="fechaInicio"
                                                    label="Fecha Inicio" :error-messages="errors.first('fecha inicio')"
                                                    prepend-icon="mdi-calendar" readonly v-bind="attrs" v-on="on"
                                                    :disabled="deshabilitar"></v-text-field>
                                            </template>
                                            <v-date-picker v-model="fechaInicio" no-title scrollable>
                                                <v-spacer></v-spacer>
                                                <v-btn text color="primary" @click="menu1 = false">
                                                    Cancel
                                                </v-btn>
                                                <v-btn text color="primary" @click="$refs.menu1.save(fechaInicio)">
                                                    OK
                                                </v-btn>
                                            </v-date-picker>
                                        </v-menu>
                                    </v-col>

                                    <!-- FECHA TERMINO -->
                                    <v-col md="6">
                                        <v-menu ref="menu2" :close-on-content-click="false"
                                            :return-value.sync="fechaFin" transition="scale-transition" offset-y
                                            min-width="auto">
                                            <template v-slot:activator="{ on, attrs }">
                                                <v-text-field v-validate="'required'" data-vv-name="fecha fin"
                                                    :error="errors.has('fecha fin')" v-model="fechaFin"
                                                    label="Fecha Fin" :error-messages="errors.first('fecha fin')"
                                                    prepend-icon="mdi-calendar" readonly v-bind="attrs"
                                                    v-on="on" :disabled="deshabilitar"
                                                    ></v-text-field>
                                            </template>
                                            <v-date-picker v-model="fechaFin" no-title scrollable>
                                                <v-spacer></v-spacer>
                                                <v-btn text color="primary" @click="menu2 = false">
                                                    Cancel
                                                </v-btn>
                                                <v-btn text color="primary" @click="$refs.menu2.save(fechaFin); validarFechas();">
                                                    OK
                                                </v-btn>
                                            </v-date-picker>
                                        </v-menu>
                                    </v-col>
                                </v-row>


                                <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">

                                    <!--HORARIO INICIO -->
                                    <v-col md="6">
                                        <template>
                                            <div>
                                                <v-col style=" flex: 0 1 auto;">
                                                  <h4>Hora de inicio:</h4>
                                                  <v-time-picker
                                                    v-model="horario_inicio"
                                                    width ="180px"
                                                    landscape
                                                    type="time"
                                                    class="mt-3"
                                                    :disabled="deshabilitar"
                                                  ></v-time-picker>
                                                </v-col>
                                            </div>
                                          </template>
                                    </v-col>

                                    <!--HORARIO FIN -->
                                    <v-col md="6">
                                        <template>
                                            <div>
                                                <v-col style=" flex: 0 1 auto;">
                                                  <h4>Hora de fin:</h4>
                                                  <v-time-picker
                                                    v-model="horario_fin"
                                                    width ="180px"
                                                    landscape
                                                    type="time"
                                                    class="mt-3"
                                                    :disabled="deshabilitar"
                                                  ></v-time-picker>
                                                </v-col>
                                            </div>
                                          </template>
                                    </v-col>


                                </v-row>

                                <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">

                                    <!-- TOTAL DE DÍAS-->
                                    <v-col md="6">
                                        <v-text-field v-model="dias" outlined label="Total de Días" inputmode="numeric"
                                             persistent-hint
                                            v-validate="'required|max:500'" data-vv-name="total de días"
                                            :error="errors.has('total de días')"
                                            :error-messages="errors.first('total de días')" :disabled="deshabilitar"
                                            :rules="[validacion]"></v-text-field>
                                    </v-col> 

                                    <!-- TOTAL DE HORAS -->
                                    <v-col md="6">
                                        <v-text-field v-model="horas" outlined label="Total de Horas" persistent-hint
                                            inputmode="numeric" pattern="[0-9]*" type="number" :disabled="deshabilitar"
                                            v-validate="'required|max:500'" data-vv-name="total de horas"
                                            :error="errors.has('total de horas')"
                                            :error-messages="errors.first('total de horas')" :rules="[validacion]"></v-text-field>
                                    </v-col>

                                    
                                </v-row>

                                <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">

                                    <!--LUGAR -->
                                    <v-col md="6">
                                        <v-text-field v-model="lugar" outlined label="Lugar" persistent-hint
                                            v-validate="'required|max:500'" data-vv-name="lugar"
                                            :error="errors.has('lugar')" :error-messages="errors.first('lugar')"
                                            :disabled="deshabilitar"></v-text-field>
                                    </v-col>

                                    <v-col md="6|">
                                        <v-text-field v-model="numeroParticipantes" outlined
                                            label="Número de participantes" persistent-hint inputmode="numeric"
                                            pattern="[0-9]*" type="number" v-validate="'required|max:500'"
                                            data-vv-name="número de participantes" :disabled="deshabilitar"
                                            :error="errors.has('número de participantes')"
                                            :error-messages="errors.first('número de participantes')" :rules="[validacion]"></v-text-field>
                                    </v-col>
                                </v-row>

                                <v-row class="align-center" style="padding: 0px 50px 0px 50px">
                                        <!-- TIPO CURSO -->
                                        <v-col md="6">
                                            <p>Curso</p>
                                            <v-radio-group v-model="tipoCurso" v-validate="'required'" data-vv-name="curso"
                                                :error="errors.has('curso')" :error-messages="errors.first('curso')" row
                                                :disabled="deshabilitar">
                                                <v-radio label="Abierto a comunidad UTL" value="abierto"></v-radio>
                                                <v-radio label="Grupo cerrado " value="cerrado"></v-radio>
                                            </v-radio-group>
                                        </v-col>
                                </v-row>


                                <%-- <v-row justfy="center" dense>
                                    </v-row> --%>
                                    <v-divider></v-divider>
                                    <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                        <!--OBJETIVO-->
                                        <v-col md="4">

                                            <v-textarea v-model="objetivo" data-vv-name="objetivo"
                                                :disabled="deshabilitar" :error="errors.has('objetivo')"
                                                hint="(Cuál es la finalidad del curso de capacitación)"
                                                :error-messages="errors.first('objetivo')" label="Objetivo"
                                                persistent-hint v-validate="'required|max:500'" auto-grow outlined
                                                rows="1" row-height="15"></v-textarea>
                                        </v-col>

                                        <!-- ALCANCE -->
                                        <v-col md="4">
                                            <v-textarea v-model="alcance" data-vv-name="alcance"
                                                :disabled="deshabilitar"
                                                hint="(Es el impacto que se pretende con el curso)"
                                                :error="errors.has('alcance')" :error-messages="errors.first('alcance')"
                                                label="Alcance" persistent-hint v-validate="'required|max:500'"
                                                auto-grow outlined rows="1" row-height="15"></v-textarea>
                                        </v-col>

                                        <!--METODOLOGÍA-->
                                        <v-col md="4">
                                            <v-textarea v-model="metodologia" data-vv-name="metodología"
                                                hint="(indicar si es un curso, foro, taller, etc., describir las características que tendrán las actividades a desarrollar)"
                                                :error="errors.has('metodología')" :disabled="deshabilitar"
                                                :error-messages="errors.first('metodología')" label="Metodología"
                                                persistent-hint v-validate="'required|max:500'" auto-grow outlined
                                                rows="1" row-height="15"></v-textarea>
                                        </v-col>

                                        <!-- PROGRAMA DEL CURSO -->
                                        <v-col md="4">
                                            <v-textarea v-model="programaCurso"
                                                hint="(Escribir el tema y aun lado entre parentesis las horas por tema)"
                                                data-vv-name="programa del curso" :disabled="deshabilitar"
                                                :error="errors.has('programa del curso y horas por tema')"
                                                :error-messages="errors.first('programa del curso y horas por tema')"
                                                label="Programa del curso" persistent-hint
                                                v-validate="'required|max:500'" auto-grow outlined rows="1"
                                                row-height="15"></v-textarea>
                                        </v-col>



                                        <!--RESULTADO DEL APRENDIZAJE-->
                                        <v-col md="4">
                                            <v-textarea v-model="resultadoAprendizaje"
                                                data-vv-name="resultado del aprendizaje" :disabled="deshabilitar"
                                                hint="(Es el desempeño y las evidencias que se obtendrán del curso)"
                                                :error="errors.has('resultado del aprendizaje')"
                                                :error-messages="errors.first('resultado del aprendizaje')"
                                                label="Resultado del aprendizaje" persistent-hint
                                                v-validate="'required|max:500'" auto-grow outlined rows="1"
                                                row-height="15"></v-textarea>
                                        </v-col>

                                        <!--PERFIL DEL PARTICIPANTE-->
                                        <v-col md="4">
                                            <v-textarea v-model="perfil" data-vv-name="perfil del(a) participante"
                                                :error="errors.has('perfil del(a) participante')"
                                                :disabled="deshabilitar"
                                                :error-messages="errors.first('perfil del(a) participante')"
                                                label="Perfil del(a) participante" persistent-hint
                                                v-validate="'required|max:500'" auto-grow outlined rows="1"
                                                row-height="15"></v-textarea>
                                        </v-col>
                                    </v-row>


                                    <v-row justfy="center" dense>
                                        <v-col class="text-center"><b>Instructores(as)</b></v-col>
                                    </v-row>

                                    <v-divider></v-divider>
                                    <v-row v-for="(item, index) in numberOfInputs" :key="index" justify="center"
                                        class="align-center" style="padding: 0px 50px 0px 50px">
                                        <v-col md="4">
                                            <v-select v-model="nombreFacilitador[index]"
                                                @change="agregarInstructor(nombreFacilitador[index])" outlined
                                                label="Nombre" persistent-hint :items="facilitadores"
                                                item-value="cve_instructor" item-text="nombre_instructor"
                                                :disabled="deshabilitar"
                                                v-validate="'required|max:500'" data-vv-name="nombre"
                                                :error="errors.has('nombre')" :error-messages="errors.first('nombre')">
                                            </v-select>
                                        </v-col>

                                        <v-col md="4">
                                            <v-autocomplete v-model="areaPertenece[index]" outlined
                                                @change="agregarArea(areaPertenece[index])"
                                                label="Área académica a la que pertenece" 
                                                :items="areas"
                                                item-value="cve_area" 
                                                item-text="nombre_area"
                                                :disabled="deshabilitar">
                                            </v-autocomplete>
                                        </v-col>

                                        <v-col md="4">
                                            <v-autocomplete v-model="programaEducativo[index]" outlined
                                            @change="agregarPrograma(programaEducativo[index])"
                                                label="Programa Educativo" persistent-hint
                                                :items="programas"
                                                item-value="cve_ugac" 
                                                item-text="nombre_ugac" 
                                                :disabled="deshabilitar">
                                            </v-autocomplete>
                                        </v-col>
                                    </v-row>

                            </div>

                            <v-tooltip top>
                                <template v-slot:activator="{ on, attrs }">
                                    <v-btn color="primary" v-bind="attrs" v-on="on"
                                        @click="numberOfInputs++"><v-icon>mdi-account-multiple-plus</v-icon></v-btn>
                                </template>
                                <span>Agregar un nuevo instructor</span>
                            </v-tooltip>


                            <v-tooltip top>
                                <template v-slot:activator="{ on, attrs }">
                                    <v-btn color="error" v-bind="attrs" v-on="on" @click="numberOfInputs--">
                                        <v-icon>mdi-close</v-icon>
                                    </v-btn>
                                </template>
                                <span>Quitar instructor</span>
                            </v-tooltip>



                            <!--BOTONES CRUD-->
                            <v-row justify="center">
                                <v-btn color="primary" @click="flagDescargar ? fnDescargar() : fnGuardar()">
                                    <v-icon>{{ flagDescargar ? 'mdi-download' : 'mdi-content-save' }}</v-icon>
                                    {{ flagDescargar ? 'Descargar' : 'Guardar' }}
                                </v-btn>
                                &nbsp;
                                <v-btn color="error" @click="fnLimpiarCampos(); numberOfInputs = 1; deshabilitar = false;" >
                                    <v-icon>mdi-cancel</v-icon>Cancelar
                                </v-btn>
                            </v-row>


                            <!--BARRA DE BUSQUEDA-->
                            <v-row justify="end">
                                <v-col md="5">
                                    <template>
                                        <br>
                                        <div>
                                            <v-text-field v-model="buscar" label="Buscar" :append-icon="iconoBusqueda"
                                                clearable @keyup.enter="filtrarTabla"></v-text-field>
                                        </div>
                                    </template>
                                </v-col>
                                <v-col md = "1">
                                    <v-tooltip bottom open-on-hover>
                                        <template v-slot:activator="{ on, attrs }">
                                            <span class="tooltip-trigger" v-bind="attrs" v-on="on">
                                                <v-icon> mdi-information </v-icon>
                                            </span>
                                        </template>
                                        <span>La busqueda se realiza por nombre curso, tipo de competencia, programa educativo </span>
                                    </v-tooltip>
                                </v-col>
                            </v-row>

                            <!-- TABLA -->
                            <v-row justify="center">
                                <v-col md="12">
                                    <v-data-table :headers="headerCapacitacion" :items="datosFiltrados"
                                        class="elevation-2" no-data-text="No se encontró ningún registro"
                                        :hide-default-header="datosFiltrados.length < 1"
                                        :hide-default-footer="datosFiltrados.length < 1" locale="es-ES"
                                        :mobile-breakpoint="NaN" items-per-page="10">
                                        <!--SEMAFORO-->
                                        <template v-slot:item.actions="{ item }">
                                            <v-icon color="green" @click="snackbar = false">mdi-circle</v-icon>
                                            <v-icon color="yellow" @click="snackbar = false">mdi-circle</v-icon>
                                            <v-icon color="red" @click="snackbar = false">mdi-circle</v-icon>
                                        </template>

                                        <!--VISUALIZARs-->
                                        <template v-slot:item.ver="{ item }">
                                            <v-icon color="blue" @click="$vuetify.goTo(0); itemVer = item; flagDescargar = true; fnObtener(item); cargarInstructores(); cargarSolicitudes(); deshabilitar = true;
                                                                    idSolicitud = item.idSolicitud;
                                                                    tipoCompetencia = item.tipo_competencia
                                                                    nombreCurso = item.nombre
                                                                    fechaInicio = item.fecha_inicio
                                                                    fechaFin = item.fecha_fin
                                                                    dias = item.total_dias
                                                                    lugar = item.lugar
                                                                    horas = item.total_horas
                                                                    numeroParticipantes = item.numero_participantes
                                                                    tipoCurso = item.curso
                                                                    objetivo = item.objetivo
                                                                    alcance = item.alcance
                                                                    metodologia = item.metodologia
                                                                    programaCurso = item.programa_evento
                                                                    horasPorTema = item.horas_tema
                                                                    resultadoAprendizaje = item.resultado_aprendizaje
                                                                    perfil = item.perfil_participante
                                                                ">mdi-eye</v-icon>
                                        </template>
                                    </v-data-table>
                                </v-col>
                            </v-row>
                        </v-container>
                    </v-card>
                </v-container>
                <!-- TODO: ALERTAS DE SISTEMA-->
                <v-snackbar v-model="snackbar" top="top" :bottom="true" :multi-line="true" :color="color_snackbar">
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
                        "../../controlador/formacion_docente/Controlador_catalogo_solicitud_capacitacion_interna.jsp";

                    //Variables POST
                    const idSolicitud = ref("");

                    const programa = ref("");
                    const tipoCompetencia = ref("");
                    const fechaInicio = ref("");
                    const fechaFin = ref("");
                    const nombreCurso = ref("");
                    const horario_inicio = ref("");
                    const horario_fin = ref("");
                    const lugar = ref("");
                    const dias = ref("");
                    const horas = ref("");
                    const numeroParticipantes = ref("");
                    const tipoCurso = ref("");
                    const objetivo = ref("");
                    const alcance = ref("");
                    const metodologia = ref("");
                    const programaCurso = ref("");
                    const resultadoAprendizaje = ref("");
                    const perfil = ref("");

                    //Pueden ser varios, por eso es un arreglo
                    const nombreFacilitador = ref([]);
                    const areaPertenece = ref([]);
                    const programaEducativo = ref([]);
                    const numberOfInputs = 1; //las veces que se agraga otro

                    //Arreglos
                    const areas = ref([]);
                    const facilitadores = ref([]);
                    const programas = ref([]);
                    const instructoresSeleccionados = ref([]);
                    const areasSeleccionados = ref([]);
                    const programasSeleccionados = ref([]);
                    const dataInstructores = ref([]);

                    //Otras variables
                    const flagDescargar = ref(false);
                    const itemEditar = ref({});
                    const itemVer = ref({});
                    const buscar = ref("");

                    //SNACKBAR
                    const loader = ref(false);
                    const snackbar = ref(false);
                    const mensaje_snackbar = ref("");
                    const color_snackbar = ref("");
                    
                    //DataTable
                    const dataSolicitudCapacitacion = ref([]);
                    const headerCapacitacion = ref([
                        { text: "Nombre del curso", align: "left", sortable: true, value: "nombre" },
                        { text: "Tipo de competencia", align: "left", sortable: true, value: "tipo_competencia" },
                        { text: "Total de días", align: "left", sortable: true, value: "total_dias" },
                        { text: "Total de horas", align: "left", sortable: true, value: "total_horas" },
                        { text: "Objetivo", align: "left", sortable: true, value: "objetivo" },
                        { text: "Estatus", align: "left", sortable: false, value: "actions" },
                        { text: "Ver", align: "left", sortable: false, value: "ver" },
                    ]);

                    const currentUser = localStorage.getItem('currentUser');
                    const user = JSON.parse(currentUser);
                    const nombre = user[0].nombre;
                    const idPersona = user[0].cve_persona;
                    const ape1 = user[0].apellido_paterno;
                    const ape2 = user[0].apellido_materno;
                    const area = user[0].nombre_area;
                    const puesto = user[0].nombre_puesto;
                    const carrera = user[0].nombre_ugac;


                    onMounted(() => {
                        fnConsultarTabla();
                        fnAreas();
                        fnFacilitadores();
                        fnProgramaEducativo();
                        console.log({ idPersona })
                    });

                    

                    async function fnDescargar() {
                        var element = document.getElementById("imprimir");

                        var options = {
                            margin: 7,
                            filename: 'Solicitud de capacitación interna.pdf',
                            image: { type: 'png', quality: 0.98 },
                            html2canvas: { scale: 1 },
                            jsPDF: { unit: 'pt', format: 'a4', orientation: 'landscape' }
                        };

                        await html2pdf().from(element).set(options).save();
                    }

                    function fnObtener(solicitud) {
                        const arregloSolicitud = Object.values(solicitud);
                        console.log('Arreglo de la solicitud:', arregloSolicitud);
                        console.log('cve solicitud:', arregloSolicitud[0]);
                        this.cve_solicitud = arregloSolicitud[0];
                    }

                    async function cargarInstructores() {
                        try {
                            preloader("../../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 6);
                                parametros.append("cve_solicitud", this.cve_solicitud);
                                let { data, status } = await axios.post(ctr, parametros);
                                    if (status == 200) {
                                        dataInstructores.value = data;
                                        this.numberOfInputs = data.length;
                                        console.log('Instructores ', dataInstructores)

                                        for(let i = 0; i < data.length; i++){
                                            this.nombreFacilitador[i] = data[i].cve_instructor;
                                            this.areaPertenece[i] = data[i].cve_area;
                                            this.programaEducativo[i] = data[i].cve_ugac;
                                        }
                                    }
                        } catch (error) {
                            mostrarSnackbar("error");
                            console.error(error);
                        } finally {
                            swal.close();
                        }
                    }

                    async function cargarSolicitudes() {
                        
                        try {
                            preloader("../../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 7);
                                parametros.append("cve_solicitud", this.cve_solicitud);
                                let { data, status } = await axios.post(ctr, parametros);
                                    if (status == 200) {
                                        dataSolicitudCapacitacion.value = data;

                                        console.log('hora_inicio:', data[0].hora_inicio);
                                        let horaInicio = data[0].hora_inicio;
                                        let horaFin = data[0].hora_fin;
                                        
                                        let horaInicioF = horaInicio.slice(0, 5);
                                        let horaFinF = horaFin.slice(0, 5); 
                                        console.log(horaInicioF); 

                                        this.horario_inicio = horaInicioF;
                                        this.horario_fin = horaFinF;



                                           
                                           
                                    }
                        } catch (error) {
                            mostrarSnackbar("error");
                            console.error(error);
                        } finally {
                            swal.close();
                        }
                    }
                    

                    async function fnFacilitadores() {
                        try {
                            preloader("../../");
                            let parametros = new URLSearchParams();
                            parametros.append("accion", 3);
                            let { data, status } = await axios.post(ctr, parametros)
                            if (status == 200) {
                                if (data.length > 0) {
                                    facilitadores.value = data
                                }
                            }
                        } catch (error) {
                            mostrarSnackbar('error');
                            console.error(error);
                        } finally {
                            swal.close();
                        }
                    }

                    async function fnProgramaEducativo() {
                        try {
                            preloader("../../");
                            let parametros = new URLSearchParams();
                            parametros.append("accion", 5);
                            let { data, status } = await axios.post(ctr, parametros)
                            if (status == 200) {
                                if (data.length > 0) {
                                    programas.value = data
                                }
                            }
                        } catch (error) {
                            mostrarSnackbar('error');
                            console.error(error);
                        } finally {
                            swal.close();
                        }
                    }

                    async function fnAreas() {
                        try {
                            preloader("../../");
                            let parametros = new URLSearchParams();
                            parametros.append("accion", 4);
                            let { data, status } = await axios.post(ctr, parametros);
                            if (status == 200) {
                                if (data.length > 0) {
                                    areas.value = data;
                                }
                            }
                        } catch (error) {
                            mostrarSnackbar("error");
                            console.error(error);
                        } finally {
                            swal.close();
                        }
                    }

                    async function fnConsultarTabla() {
                        try {
                            preloader("../../");
                            let parametros = new URLSearchParams();
                            parametros.append("accion", 2);
                            let { data, status } = await axios.post(ctr, parametros);
                            if (status == 200) {
                                if (data.length > 0) {
                                    dataSolicitudCapacitacion.value = data;
                                }
                            }
                        } catch (error) {
                            mostrarSnackbar("error");
                            console.error(error);
                        } finally {
                            swal.close();
                        }
                    }

                    async function fnGuardar() {
                        this.$validator.validate().then(async (esValido) => {
                            if (esValido) {
                                try {
                                    preloader("../../");
                                    let parametros = new URLSearchParams();
                                    parametros.append("accion", 1);
                                    parametros.append("nombreFacilitador", this.instructoresSeleccionados.join(","));
                                    parametros.append("areaPertenece", this.areasSeleccionados.join(","));
                                    parametros.append("programaEducativo", this.programasSeleccionados.join(","));
                                    parametros.append("horario_inicio", horario_inicio.value);
                                    parametros.append("horario_fin", horario_fin.value);

                                    parametros.append("tipoCompetencia", tipoCompetencia.value);
                                    parametros.append("nombreCurso", nombreCurso.value);
                                    parametros.append("dias", dias.value);
                                    parametros.append("horas", horas.value);
                                    parametros.append("fechaInicio", fechaInicio.value);
                                    parametros.append("fechaFin", fechaFin.value);
                                    parametros.append("lugar", lugar.value);
                                    parametros.append("tipoCurso", tipoCurso.value);
                                    parametros.append("numeroParticipantes", numeroParticipantes.value);
                                    parametros.append("objetivo", objetivo.value);
                                    parametros.append("alcance", alcance.value);
                                    parametros.append("metodologia", metodologia.value);
                                    parametros.append("programaCurso", programaCurso.value);
                                    parametros.append("resultadoAprendizaje", resultadoAprendizaje.value);
                                    parametros.append("perfil", perfil.value);
                                    parametros.append("id", idPersona);
                                    let { data, status } = await axios.post(ctr, parametros);
                                    if (status == 200) {
                                        if (data == "1") {
                                            mostrarSnackbar(
                                                "success",
                                                "Registro guardado correctamente."
                                            );
                                            fnConsultarTabla();
                                            fnLimpiarCampos(this);
                                            this.numberOfInputs = 1;
                                            
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
                            tipoCompetencia.value = "";
                            nombreCurso.value = "";
                            fechaInicio.value = "";
                            fechaFin.value = "";
                            horario_inicio.value = "";
                            horario_fin.value = "";
                            lugar.value = "";
                            tipoCurso.value = "";
                            dias.value = "";
                            horas.value = "";
                            numeroParticipantes.value = "";
                            objetivo.value = "";
                            alcance.value = "";
                            metodologia.value = "";
                            programaCurso.value = "";
                            resultadoAprendizaje.value = "";
                            perfil.value = "";

                            nombreFacilitador.value = "";
                            areaPertenece.value = "";
                            programaEducativo.value = "";

                            flagDescargar.value = false;
                            itemEditar.value = {};
                            itemVer.value = {};

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
                        nombre, ape1, ape2, area, programa, puesto, carrera,

                        tipoCompetencia, fechaInicio, fechaFin, nombreCurso, horario_inicio, horario_fin, lugar, dias, horas,
                        numeroParticipantes, tipoCurso, objetivo, alcance, metodologia, programaCurso, resultadoAprendizaje, perfil,
                        nombreFacilitador, areaPertenece, programaEducativo, numberOfInputs,

                        programas, areas, facilitadores, instructoresSeleccionados, areasSeleccionados, programasSeleccionados,
                        dataInstructores,

                        idSolicitud,

                        color_snackbar, snackbar, mensaje_snackbar, loader, mostrarSnackbar, flagDescargar,

                        dataSolicitudCapacitacion, headerCapacitacion,

                        fnConsultarTabla, fnGuardar, fnLimpiarCampos, fnDescargar, fnFacilitadores, fnObtener, cargarInstructores,
                        cargarSolicitudes, 

                        itemEditar,
                        itemVer,
                        buscar: "",
                        iconoBusqueda: 'mdi-magnify',
                        deshabilitar: false,

                    }
                },
                computed: {
                    datosFiltrados() {
                        if (!this.buscar) {
                            return this.dataSolicitudCapacitacion;
                        }

                    const keyword = this.buscar.toLowerCase();
                    return this.dataSolicitudCapacitacion.filter(item => {
                        const nombre =  item.nombre.toLowerCase(); 
                        const tipoCompetencia = item.tipo_competencia.toLowerCase();
                        

                        return (
                            nombre.includes(keyword) ||
                            tipoCompetencia.includes(keyword) 
                        );
                    });
                    },
                    validacion() {
                    return (value) => {
                        if (!value || /^\d+$/.test(value)) {
                        // Si el campo está vacío o solo contiene números, es válido
                        return true;
                        }
                        // De lo contrario, muestra un mensaje de error
                        return 'Ingrese solo números en este campo.';
                    };
                    },

                },
                methods: {

                    filtrarTabla() {
                        console.log("jijojio:", this.buscar);
                    },
                    // METODO PARA LLENAR UN ARRAY CON LOS INSTRUCTORES PROPUESTOS PARA LA CAPACITACIÓN
                    agregarInstructor(instructor) {
                        if (instructor) {
                        const index = this.instructoresSeleccionados.indexOf(instructor);
                        if (index === -1) {
                        this.instructoresSeleccionados.push(instructor);
                        }
                    }
                    console.log(this.instructoresSeleccionados);
                    },
                    agregarArea(area) {
                        if (area) {
                            this.areasSeleccionados.push(area);
                        } else {
                            const index = this.areasSeleccionados.indexOf(area);
                            if (index !== -1) {
                                this.areasSeleccionados.splice(index, 1);
                            }
                        }
                        console.log(this.areasSeleccionados);
                    },
                    agregarPrograma(programa) {
                        if (programa) {
                            this.programasSeleccionados.push(programa);
                        } else {
                            const index = this.programasSeleccionados.indexOf(programa);
                            if (index !== -1) {
                                this.programasSeleccionados.splice(index, 1);
                            }
                        }
                        console.log(this.programasSeleccionados);
                    },

                    eliminarInstructor(index) {
                        this.instructoresSeleccionados.splice(index, 1);
                        this.areasSeleccionados.splice(index, 1);
                        this.programasSeleccionados.splice(index, 1);
                        console.log(this.instructoresSeleccionados);
                        
                        this.nombreFacilitador[index] = '';
                        this.areaPertenece[index] = '';
                        this.programaEducativo[index] = '';

                    }, validarFechas() {
                    if (this.fechaInicio && this.fechaFin) {
                        if (this.fechaFin < this.fechaInicio) {
                        console.log("La fecha de término debe ser posterior a la fecha de inicio");
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'La fecha de término debe ser posterior a la fecha de inicio',
                            }).then(() => {
                            this.fechaInicio = null;
                            this.fechaFin = null;
                            });
                        } else {
                        // Las fechas son válidas
                        console.log("Las fechas son válidas");
                        }
                    }
                }
                },


            });



            Vue.config.devtools = true;
        </script>

    </html>