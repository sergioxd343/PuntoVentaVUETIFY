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
                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                <!--NÚMERO DE CONTROL-->
                            
                                <v-col md=2>
                                    <v-text-field 
                                        v-model="numeroControl"
                                        outlined
                                        label="N&uacute;mero de control"
                                        persistent-hint
                                        v-validate="'required|max:200'"
                                        data-vv-name="numeroControl"
                                        :error="errors.has('numeroControl')"
                                        :error-messages="errors.first('numeroControl')"
                                        @keyup.enter="fnBuscarDocente()"
                                    ></v-text-field>
                                </v-col>
                            

                                <!-- DIRECCIÓN ACADEMICA -->
                                <v-col md="5">
                                    <v-text-field 
                                        disabled
                                        v-model="direccion" 
                                        outlined label="Dirección académica"
                                        v-validate="'required|max:500'" 
                                        persistent-hint
                                        data-vv-name="dirección académica"
                                        :error="errors.has('dirección académica')"
                                        :error-messages="errors.first('dirección académica')">
                                    </v-text-field>
                                </v-col>

                                <!-- PROGRAMA EDUCATIVO -->
                                <v-col md="3">
                                    <v-text-field 
                                        disabled
                                        v-model="programa" 
                                        outlined label="Programa educativo" 
                                        persistent-hint
                                        v-validate="'required|max:500'" 
                                        data-vv-name="programa educativo"
                                        :error="errors.has('programa educativo')"
                                        :error-messages="errors.first('programa educativo')">
                                    </v-text-field>
                                </v-col>
                            

                                <!-- PUESTO -->
                                <v-col md="2">
                                    <v-text-field 
                                        disabled
                                        v-model="puesto" 
                                        outlined label="Puesto" 
                                        v-validate="'required|max:500'" 
                                        persistent-hint
                                        data-vv-name="puesto"
                                        :error="errors.has('puesto')"
                                        :error-messages="errors.first('puesto')">
                                    </v-text-field>
                                </v-col>

                                
                            </v-row>

                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">

                                <!-- NOMBRE DEL SOLICITANTE -->
                                <v-col md="5">
                                    <v-text-field 
                                        disabled
                                        v-model="nombre" 
                                        outlined label="Nombre del solicitante"
                                        persistent-hint v-validate="'required|max:500'"
                                        data-vv-name="nombre del solicitante"
                                        :error="errors.has('nombre del solicitante')"
                                        :error-messages="errors.first('nombre del solicitante')">
                                    </v-text-field>
                                </v-col>

                                <!--TIPO DE COMPETENCIA-->
                                <v-col md="7">
                                    <p>Tipo de competencia</p>  
                                    <v-radio-group 
                                        v-model="tipoCompetencia" 
                                        class="mt-0"
                                        v-validate="'required'" 
                                        data-vv-name="tipo de competencia"
                                        :error="errors.has('tipo de competencia')"
                                        :error-messages="errors.first('tipo de competencia')"
                                        row>
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
                                    <v-col md="4">
                                        <v-select
                                            v-model="nombreCurso" 
                                            outlined label="Nombre del Curso"
                                            persistent-hint
                                            :items="cursos"
                                            item-value="cve_curso"
                                            item-text="nombre_curso" 
                                            v-validate="'required|max:500'"
                                            data-vv-name="nombre del curso" 
                                            :error="errors.has('nombre del curso')"
                                            :error-messages="errors.first('nombre del curso')"
                                            :disabled="deshabilitar">
                                        </v-select>
                                    </v-col>

                                    <!-- FECHA INICIO -->
                                    <v-col md="3">
                                        <v-menu 
                                            ref="menu1" 
                                            :close-on-content-click="false"
                                            :return-value.sync="fechaInicio" 
                                            transition="scale-transition" 
                                            offset-y
                                            min-width="auto">
                                            <template v-slot:activator="{ on, attrs }">
                                                <v-text-field 
                                                    v-validate="'required'" 
                                                    data-vv-name="fecha inicio"
                                                    :error="errors.has('fecha inicio')" 
                                                    v-model="fechaInicio"
                                                    label="Fecha Inicio" 
                                                    :error-messages="errors.first('fecha inicio')"
                                                    prepend-icon="mdi-calendar" 
                                                    readonly v-bind="attrs"
                                                    v-on="on"></v-text-field>
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
                                    <v-col md="3">
                                        <v-menu ref="menu2" :close-on-content-click="false"
                                            :return-value.sync="fechaFin" transition="scale-transition" offset-y
                                            min-width="auto">
                                            <template v-slot:activator="{ on, attrs }">
                                                <v-text-field v-validate="'required'" data-vv-name="fecha fin"
                                                    :error="errors.has('fecha fin')" v-model="fechaFin"
                                                    label="Fecha Fin" :error-messages="errors.first('fecha fin')"
                                                    prepend-icon="mdi-calendar" readonly v-bind="attrs"
                                                    v-on="on"></v-text-field>
                                            </template>
                                            <v-date-picker v-model="fechaFin" no-title scrollable>
                                                <v-spacer></v-spacer>
                                                <v-btn text color="primary" @click="menu2 = false">
                                                    Cancel
                                                </v-btn>
                                                <v-btn text color="primary" @click="$refs.menu2.save(fechaFin)">
                                                    OK
                                                </v-btn>
                                            </v-date-picker>
                                        </v-menu>
                                    </v-col>

                                    <!--HORARIO-->
                                    <v-col md="2">
                                        <v-text-field v-model="horario" label="Horario" v-validate="'required'"
                                            :error="errors.has('horario')" data-vv-name="horario"
                                            :error-messages="errors.first('horario')"
                                            prepend-icon="mdi-clock-outline"></v-text-field>
                                    </v-col>

                                    <!--LUGAR -->
                                    <v-col md="4">
                                        <v-text-field v-model="lugar" outlined label="Lugar" persistent-hint
                                            v-validate="'required|max:500'" data-vv-name="lugar"
                                            :error="errors.has('lugar')"
                                            :error-messages="errors.first('lugar')"></v-text-field>
                                    </v-col>

                                    <!-- TIPO CURSO -->
                                    <v-col md="4">
                                        <p>Curso</p>  
                                        <v-radio-group v-model="tipoCurso" v-validate="'required'"
                                            data-vv-name="curso" :error="errors.has('curso')"
                                            :error-messages="errors.first('curso')" row>
                                            <v-radio label="Abierto a comunidad UTL" value="abierto"></v-radio>
                                            <v-radio label="Grupo cerrado " value="cerrado"></v-radio>
                                        </v-radio-group>
                                    </v-col>

                                    <!-- TOTAL DE DÍAS-->
                                    <v-col md="2">
                                        <v-text-field v-model="dias" outlined label="Total de Días" inputmode="numeric"
                                            pattern="[0-9]*" type="number" persistent-hint
                                            v-validate="'required|max:500'" data-vv-name="total de días"
                                            :error="errors.has('total de días')"
                                            :error-messages="errors.first('total de días')" :disabled="deshabilitar"></v-text-field>
                                    </v-col>

                                    <!-- TOTAL DE HORAS -->
                                    <v-col md="2">
                                        <v-text-field v-model="horas" outlined label="Total de Horas" persistent-hint
                                            inputmode="numeric" pattern="[0-9]*" type="number"
                                            :disabled="deshabilitar"
                                            v-validate="'required|max:500'" data-vv-name="total de horas"
                                            :error="errors.has('total de horas')"
                                            :error-messages="errors.first('total de horas')"></v-text-field>
                                    </v-col>
                                </v-row>

                                <v-row class="align-center" style="padding: 0px 50px 0px 50px">

                                    <!--NÚMERO DE PARTICIPANTES -->
                                    <v-col md="3">
                                        <v-text-field v-model="numeroParticipantes" outlined
                                            label="Número de participantes" persistent-hint inputmode="numeric"
                                            pattern="[0-9]*" type="number" v-validate="'required|max:500'"
                                            data-vv-name="número de participantes"
                                            :disabled="deshabilitar"
                                            :error="errors.has('número de participantes')"
                                            :error-messages="errors.first('número de participantes')"></v-text-field>
                                    </v-col>
                                </v-row>
                        
                                <%-- <v-row justfy="center" dense>
                                    </v-row> --%>
                                    <v-divider></v-divider>
                                    <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                        <!--OBJETIVO-->
                                        <v-col md="4">

                                            <v-textarea v-model="objetivo" data-vv-name="objetivo"
                                                :disabled="deshabilitar"
                                                :error="errors.has('objetivo')"
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
                                                :error="errors.has('metodología')"
                                                :disabled="deshabilitar"
                                                :error-messages="errors.first('metodología')" label="Metodología"
                                                persistent-hint v-validate="'required|max:500'" auto-grow outlined
                                                rows="1" row-height="15"></v-textarea>
                                        </v-col>

                                        <!-- PROGRAMA DEL CURSO -->
                                        <v-col md="4">
                                            <v-textarea v-model="programaCurso"
                                                data-vv-name="programa del curso"
                                                :disabled="deshabilitar"
                                                :error="errors.has('programa del curso y horas por tema')"
                                                :error-messages="errors.first('programa del curso y horas por tema')"
                                                label="Programa del curso" persistent-hint
                                                v-validate="'required|max:500'" auto-grow outlined rows="1"
                                                row-height="15"></v-textarea>
                                        </v-col>

                                        <!-- HORAS POR TEMA -->
                                        <v-col md="4">
                                            <v-textarea v-model="horasPorTema"
                                                data-vv-name="programa del curso y horas por tema"
                                                :disabled="deshabilitar"
                                                :error="errors.has('programa del curso y horas por tema')"
                                                :error-messages="errors.first('programa del curso y horas por tema')"
                                                label="Horas por tema" persistent-hint
                                                v-validate="'required|max:500'" auto-grow outlined rows="1"
                                                row-height="15"></v-textarea>
                                        </v-col>

                                        <!--RESULTADO DEL APRENDIZAJE-->
                                        <v-col md="4">
                                            <v-textarea v-model="resultadoAprendizaje"
                                                data-vv-name="resultado del aprendizaje"
                                                :disabled="deshabilitar"
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
                                            <v-col class="text-center"><b>Facilitadores(as)</b></v-col>
                                        </v-row>

                                        <v-divider></v-divider>
                                        <v-row v-for="index in numberOfInputs" :key="index" justify="center"
                                            class="align-center" style="padding: 0px 50px 0px 50px">

                                            <v-col md="3">
                                                <v-select
                                                    v-model="tipoFacilitador[index]" 
                                                    outlined
                                                    :items="instructores"
                                                    item-value="cve_tipo_instructor" 
                                                    item-text="nombre_tipo_instructor"
                                                    label="Tipo Facilitador"
                                                    persistent-hint v-validate="'required|max:500'"
                                                    data-vv-name="tipo facilitador"
                                                    :error="errors.has('tipo facilitador')"
                                                    :error-messages="errors.first('tipo facilitador')"
                                                    @input="filtrarNombres">
                                                    
                                                </v-select>
                                            </v-col>

                                            <v-col md="3">
                                                <v-select 
                                                    v-model="nombreFacilitador[index]" 
                                                    outlined label="Nombre"
                                                    persistent-hint 
                                                    :items="facilitadoresFiltrados"
                                                    item-value="cve" 
                                                    item-text="nombre"
                                                    v-validate="'required|max:500'"
                                                    data-vv-name="nombre" 
                                                    :error="errors.has('nombre')"
                                                    :error-messages="errors.first('nombre')">
                                                </v-select>
                                            </v-col>
                                            <v-col md="3">
                                                <v-autocomplete v-model="areaPertenece[index]" outlined
                                                    label="Área académica a la que pertenece" 
                                                    :items="areas"
                                                    item-value="cve_area" 
                                                    item-text="nombre_area"
                                                    v-validate="'required|max:500'" persistent-hint
                                                    data-vv-name="área académica a la que pertenece"
                                                    :error="errors.has('área académica a la que pertenece')"
                                                    :error-messages="errors.first('área académica a la que pertenece')"></v-autocomplete>
                                            </v-col>
                                            <v-col md="3">
                                                <v-text-field v-model="programaEducativo[index]" outlined
                                                    label="Programa Educativo" persistent-hint
                                                    v-validate="'required|max:500'" data-vv-name="programa educativo"
                                                    :error="errors.has('programa educativo')"
                                                    :error-messages="errors.first('programa educativo')"></v-text-field>
                                            </v-col>
                                            
                                        </v-row>
                                    </div>

                                        <v-tooltip top>
                                            <template v-slot:activator="{ on, attrs }">
                                                <v-btn color="primary" v-bind="attrs" v-on="on"
                                                    @click="numberOfInputs++"><v-icon>mdi-account-multiple-plus</v-icon></v-btn>
                                            </template>
                                            <span>Agregar un nuevo facilitador</span>
                                        </v-tooltip>

                                        
                                    <!--BOTONES CRUD-->
                                        <v-row justify="center">
                                            <v-btn color="primary" @click="flagDescargar ? fnDescargar() : fnGuardar()">
                                              <v-icon>{{ flagDescargar ? 'mdi-download' : 'mdi-content-save' }}</v-icon>
                                              {{ flagDescargar ? 'Descargar' : 'Guardar' }}
                                            </v-btn>
                                            &nbsp;
                                            <v-btn color="error" @click="fnLimpiarCampos()">
                                              <v-icon>mdi-cancel</v-icon>Cancelar
                                            </v-btn>
                                        </v-row>
                                          

                                            <!--BARRA DE BUSQUEDA-->
                                            <v-row justify="end">
                                                <v-col md = "5">
                                                    <template>
                                                        <br>
                                                        <div>
                                                           <v-text-field v-model="buscar" label="Buscar" :append-icon="iconoBusqueda" clearable @keyup.enter="filtrarTabla"></v-text-field>
                                                        </div>
                                                      </template>
                                                </v-col>
                                            </v-row>

                                        <!-- TABLA -->
                                            <v-row justify="center">    
                                                <v-col md="12"> 
                                                    <v-data-table 
                                                        :headers="headerCapacitacion" 
                                                        :items="datosFiltrados" class="elevation-2"
                                                        no-data-text="No se encontró ningún registro" :hide-default-header="datosFiltrados.length < 1"
                                                        :hide-default-footer="datosFiltrados.length < 1" locale="es-ES" :mobile-breakpoint="NaN"
                                                        items-per-page="10">
                                                        <!--SEMAFORO-->
                                                        <template v-slot:item.actions="{ item }">
                                                                <v-icon color="green" @click="snackbar = false">mdi-circle</v-icon>
                                                                <v-icon color="yellow" @click="snackbar = false">mdi-circle</v-icon>
                                                                <v-icon color="red" @click="snackbar = false">mdi-circle</v-icon>
                                                        </template>

                                                        <!--VISUALIZARs-->
                                                        <template v-slot:item.ver="{ item }">                                                            
                                                                <v-icon color="blue" @click="$vuetify.goTo(0); itemVer = item; deshabilitar = true; flagDescargar = true;
                                                                    idSolicitud = item.idSolicitud;
                                                                    nombreCurso = item.cve_curso
                                                                    dias = item.total_dias
                                                                    horas = item.total_horas
                                                                    numeroParticipantes = item.numero_participantes
                                                                    objetivo = item.objetivo
                                                                    alcance = item.alcance
                                                                    metodologia = item.metodologia
                                                                    programaCurso = item.programa_evento
                                                                    horasPorTema = item.horas_tema
                                                                    resultadoAprendizaje = item.resultado_aprendizaje
                                                                    perfil = item.perfil_participante;
                                                                    tipoFacilitador = item.cve_tipo_instructor
                                                                    nombreFacilitador = item.nombre_instructor
                                                                " >mdi-eye</v-icon> 
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
                    const horasPorTema = ref("");
                    const numeroControl = ref("");
                    const direccion = ref("");
                    const area = ref("");
                    const programa = ref("");
                    const nombre = ref("");
                    const puesto = ref("");
                    const tipoCompetencia = ref("");
                    const fechaInicio = ref("");
                    const fechaFin = ref("");
                    const nombreCurso = ref("");
                    const horario = ref("");
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


                    const nombreFacilitador = ref([]);
                    const areaPertenece = ref([]);
                    const programaEducativo = ref([]);
                    const tipoFacilitador = ref([]);

                    const puestos = ["PTC", "PA", "Técnico académico", "Administrativo académico", "Administrativo"];
                    const numberOfInputs = 1;
                    const instructores = ref([]);
                    const cursos = ref([]);
                    const areas = ref([]);
                    const facilitadores = ref([]);
                    const facilitadoresFiltrados = ref([]);

                    const modal2 = false;
                    //Otras variables
                    const flagDescargar = ref(false);
                    const itemEditar = ref({});
                    const itemVer = ref({});
                    const buscar = ref("");
                    //Combo
                    

                    //SNACKBAR
                    const loader = ref(false);
                    const snackbar = ref(false);
                    const mensaje_snackbar = ref("");
                    const color_snackbar = ref("");
                    //Loaders
                    //Dialogs
                    //DataTable
                    const dataSolicitudCapacitacion = ref([]);
                    const headerCapacitacion = ref([
                        { text: "Nombre del curso", align: "left", sortable: true, value: "nombre_curso" },
                        { text: "Total de días", align: "left", sortable: true, value: "total_dias" },
                        { text: "Total de horas", align: "left", sortable: true, value: "total_horas" },
                        { text: "Objetivo", align: "left", sortable: true, value: "objetivo" },
                        { text: "Estatus", align: "left", sortable: false, value: "actions" },
                        { text: "Ver", align: "left", sortable: false, value: "ver" },
                       
                    ]);
                    const searchCapacitacion = ref([]);
                    const dataBusqueda = ref([]);
                    

                    onMounted(() => {
                        fnConsultarTabla();
                        fnAreas();
                        fnCursos();
                        fnInstructores();
                        fnbuscar_cve_docente();
                        fnbuscarFacilitadores();
                        
                    });

                    async function fnbuscar_cve_docente(){
                    try{
                        preloader("../../");
                        let parametros = new URLSearchParams();
                        parametros.append("accion", 4);
                        let {data,status} = await axios.post(ctr, parametros)
                        if(status == 200){
                            if(data.length > 0){
                                dataBusqueda.value = data
                            }
                        }
                    } catch(error){
                        mostrarSnackbar('error');
                        console.error(error);
                    } finally{
                        swal.close();
                    }
                }

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



                    async function fnBuscarDocente() {
                        const numeroControl = this.numeroControl;
                        console.log(numeroControl);

                        let encontrado = false; 
                        for (let i = 0; i < this.dataBusqueda.length; i++) {
                            if (numeroControl === this.dataBusqueda[i].cve_persona.toString()) {                           
                                this.direccion = this.dataBusqueda[i].nombre_area,
                                this.programa = this.dataBusqueda[i].nombre_ugac,
                                this.puesto = this.dataBusqueda[i].nombre_tipo_puesto,
                                this.nombre = this.dataBusqueda[i].nombre + ' ' +
                                    this.dataBusqueda[i].apellido_peterno + ' ' + 
                                    this.dataBusqueda[i].apellido_materno

                                encontrado = true; 
                            break; 
                            }
                        }
                        if (!encontrado) {
                            Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'El número de control no coincide.',
                            });
                        }
                    }

                    async function fnbuscarFacilitadores(){
                        try{
                            preloader("../../");
                            let parametros = new URLSearchParams();
                            parametros.append("accion", 6);
                            let {data,status} = await axios.post(ctr, parametros)
                            if(status == 200){
                                if(data.length > 0){
                                    facilitadores.value = data
                                }
                            }
                        } catch(error){
                            mostrarSnackbar('error');
                            console.error(error);
                        } finally{
                            swal.close();
                        }
                    }

                    async function fnCursos() {
                        try {
                            preloader("../../");
                            let parametros = new URLSearchParams();
                            parametros.append("accion", 3);
                            let { data, status } = await axios.post(ctr, parametros);
                            if (status == 200) {
                                if (data.length > 0) {
                                    cursos.value = data;
                                }
                            }
                        } catch (error) {
                            mostrarSnackbar("error");
                            console.error(error);
                        } finally {
                            swal.close();
                        }
                    }

                    async function fnAreas() {
                        try {
                            preloader("../../");
                            let parametros = new URLSearchParams();
                            parametros.append("accion", 7);
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

                    async function fnInstructores() {
                        try {
                            preloader("../../");
                            let parametros = new URLSearchParams();
                            parametros.append("accion", 5);
                            let { data, status } = await axios.post(ctr, parametros);
                            if (status == 200) {
                                if (data.length > 0) {
                                    instructores.value = data;
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
                                    parametros.append("nombreFacilitador", nombreFacilitador.value.join(",").slice(1));
                                    parametros.append("nombreCurso", nombreCurso.value);
                                    parametros.append("dias", dias.value);
                                    parametros.append("horas", horas.value);
                                    parametros.append("numeroParticipantes", numeroParticipantes.value);
                                    parametros.append("objetivo", objetivo.value);
                                    parametros.append("alcance", alcance.value);
                                    parametros.append("metodologia", metodologia.value);
                                    parametros.append("programaCurso", programaCurso.value);
                                    parametros.append("horasPorTema", horasPorTema.value);
                                    parametros.append("resultadoAprendizaje", resultadoAprendizaje.value);
                                    parametros.append("perfil", perfil.value);
                                    let { data, status } = await axios.post(ctr, parametros);
                                    if (status == 200) {
                                        if (data == "1") {
                                            mostrarSnackbar(
                                                "success",
                                                "Registro guardado correctamente."
                                            );
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
                                    mostrarSnackbar("error");
                                    console.error(error);
                                } finally {
                                    swal.close();
                                }
                            }
                        });
                    }

                    /*async function fnVer() {
                        this.$validator.validate().then(async esValido => {
                            if (esValido) {
                                try {
                                    console.log(itemVer)
                                    parametros.append("idSolicitud", itemVer.value.cve_sol_cap_int);
                                    
                                    parametros.append("nombreCurso", nombreCurso.value);
                                    parametros.append("dias", dias.value);
                                    parametros.append("horas", horas.value);
                                    parametros.append("numeroParticipantes", numeroParticipantes.value);
                                    parametros.append("objetivo", objetivo.value);
                                    parametros.append("alcance", alcance.value);
                                    parametros.append("metodologia", metodologia.value);
                                    parametros.append("programaCurso", programaCurso.value);
                                    parametros.append("horasPorTema", horasPorTema.value);
                                    parametros.append("resultadoAprendizaje", resultadoAprendizaje.value);
                                    parametros.append("perfil", perfil.value);
                                } catch (error) {
                                    mostrarSnackbar('error');
                                    console.error(error);
                                } finally {
                                    swal.close();
                                }
                            }
                        })
                    }*/

                


                    async function fnCambiarEstatus(item) {
                        try {
                            preloader("../../");
                            let parametros = new URLSearchParams();
                            parametros.append("accion", 5);
                            parametros.append("idProyecto", item.idProyecto);
                            parametros.append("estatus", item.estatus == true ? 1 : 0);
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

                    function fnLimpiarCampos(cx) {
                        //cx = contexto
                        numeroControl.value = "";
                        direccion.value = ""; 
                        programa.value = "";
                        puesto.value = "";
                        nombre.value = ""; 
                        tipoCompetencia.value = ""; 
                        nombreCurso.value = "";
                        fechaInicio.value = ""; 
                        fechaFin.value = ""; 
                        horario.value = "";
                        lugar.value = ""; 
                        tipoCurso.value = ""; 
                        dias.value = ""; 
                        horas.value = ""; 
                        numeroParticipantes.value = ""; 
                        objetivo.value = ""; 
                        alcance.value = ""; 
                        metodologia.value = ""; 
                        programaCurso.value = ""; 
                        horasPorTema.value = ""; 
                        resultadoAprendizaje.value = ""; 
                        perfil.value = ""; 
                        tipoFacilitador.value = ""; 
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
                        idSolicitud,
                        numeroControl,
                        color_snackbar,
                        snackbar,
                        mensaje_snackbar,
                        loader,
                        mostrarSnackbar,
                        flagDescargar,
                        area,
                        areas,
                        direccion,
                        cursos,
                        programa,
                        nombre,
                        puesto,
                        tipoCompetencia,
                        fechaInicio,
                        fechaFin,
                        nombreCurso,
                        horario,
                        lugar,
                        dias,
                        horas,
                        numeroParticipantes,
                        tipoCurso,
                        objetivo,
                        alcance,
                        metodologia,
                        programaCurso,
                        resultadoAprendizaje,
                        perfil,
                        nombreFacilitador,
                        areaPertenece,
                        programaEducativo,
                        tipoFacilitador,
                        modal2,
                        numberOfInputs,
                        puestos,
                        dataSolicitudCapacitacion,
                        headerCapacitacion,
                        searchCapacitacion,
                        fnConsultarTabla,
                        fnGuardar,
                        fnLimpiarCampos,
                        fnDescargar,
                        fnCambiarEstatus,
                        fnbuscar_cve_docente,
                        fnBuscarDocente,
                        itemEditar,
                        instructores,
                        dataBusqueda,
                        horasPorTema,
                        facilitadores,
                        facilitadoresFiltrados,
                        itemVer,
                        buscar: "",
                        iconoBusqueda: 'mdi-magnify',
                        deshabilitar : false,
                        
                    }
                },
                computed: {
                    datosFiltrados() {
                    if (!this.buscar) {
                        return this.dataSolicitudCapacitacion;
                    }

                    const keyword = this.buscar.toLowerCase();
                    return this.dataSolicitudCapacitacion.filter(item => item.nombre_curso.toLowerCase().includes(keyword));
                    console.log(datosFiltrados())
                    }
                },
                methods: {
                    filtrarNombres() {
                        
                        const tipoSeleccionado = this.tipoFacilitador[1];
                        console.log(tipoSeleccionado);

                       
                        const facilitadoresTipo = this.facilitadores.filter(
                            facilitador => facilitador.cve_tipo_instructor === tipoSeleccionado
                        );

                        this.facilitadoresFiltrados = facilitadoresTipo.map(facilitador => ({
                            cve: facilitador.cve_instructor,
                            nombre: facilitador.nombre_instructor
                        }));

                        console.log(this.facilitadoresFiltrados);
                        },
                    
                    filtrarTabla() {
                        console.log("jijojio:", this.buscar);
                    }
                    },
                   
            
        });
                        
                  

            Vue.config.devtools = true;
        </script>

    </html>