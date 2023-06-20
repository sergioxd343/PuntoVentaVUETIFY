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

                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
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
                                <v-divider></v-divider>
                                <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
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
                                            :error-messages="errors.first('nombre del curso')">
                                        </v-select>
                                    </v-col>

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
                                    <v-col md="2">
                                        <v-text-field v-model="horario" label="Horario" v-validate="'required'"
                                            :error="errors.has('horario')" data-vv-name="horario"
                                            :error-messages="errors.first('horario')"
                                            prepend-icon="mdi-clock-outline"></v-text-field>
                                    </v-col>

                                    <v-col md="4">
                                        <v-text-field v-model="lugar" outlined label="Lugar" persistent-hint
                                            v-validate="'required|max:500'" data-vv-name="lugar"
                                            :error="errors.has('lugar')"
                                            :error-messages="errors.first('lugar')"></v-text-field>
                                    </v-col>

                                    <v-col md="4">
                                        <p>Curso</p>  
                                        <v-radio-group v-model="tipoCurso" v-validate="'required'"
                                            data-vv-name="curso" :error="errors.has('curso')"
                                            :error-messages="errors.first('curso')" row>
                                            <v-radio label="Abierto a comunidad UTL" value="abierto"></v-radio>
                                            <v-radio label="Grupo cerrado " value="cerrado"></v-radio>
                                        </v-radio-group>
                                    </v-col>

                                    
                                    <v-col md="2">
                                        <v-text-field v-model="dias" outlined label="Total de Días" inputmode="numeric"
                                            pattern="[0-9]*" type="number" persistent-hint
                                            v-validate="'required|max:500'" data-vv-name="total de días"
                                            :error="errors.has('total de días')"
                                            :error-messages="errors.first('total de días')"></v-text-field>
                                    </v-col>
                                    <v-col md="2">
                                        <v-text-field v-model="horas" outlined label="Total de Horas" persistent-hint
                                            inputmode="numeric" pattern="[0-9]*" type="number"
                                            v-validate="'required|max:500'" data-vv-name="total de horas"
                                            :error="errors.has('total de horas')"
                                            :error-messages="errors.first('total de horas')"></v-text-field>
                                    </v-col>
                                </v-row>

                                <v-row class="align-center" style="padding: 0px 50px 0px 50px">

                                    <v-col md="3">
                                        <v-text-field v-model="numeroParticipantes" outlined
                                            label="Número de participantes" persistent-hint inputmode="numeric"
                                            pattern="[0-9]*" type="number" v-validate="'required|max:500'"
                                            data-vv-name="número de participantes"
                                            :error="errors.has('número de participantes')"
                                            :error-messages="errors.first('número de participantes')"></v-text-field>
                                    </v-col>
                                </v-row>
                                <%-- <v-row justfy="center" dense>
                                    </v-row> --%>
                                    <v-divider></v-divider>
                                    <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                        <v-col md="4">
                                            <v-textarea v-model="objetivo" data-vv-name="objetivo"
                                                :error="errors.has('objetivo')"
                                                hint="(Cuál es la finalidad del curso de capacitación)"
                                                :error-messages="errors.first('objetivo')" label="Objetivo"
                                                persistent-hint v-validate="'required|max:500'" auto-grow outlined
                                                rows="1" row-height="15"></v-textarea>
                                        </v-col>
                                        <v-col md="4">
                                            <v-textarea v-model="alcance" data-vv-name="alcance"
                                                hint="(Es el impacto que se pretende con el curso)"
                                                :error="errors.has('alcance')" :error-messages="errors.first('alcance')"
                                                label="Alcance" persistent-hint v-validate="'required|max:500'"
                                                auto-grow outlined rows="1" row-height="15"></v-textarea>
                                        </v-col>
                                        <v-col md="4">
                                            <v-textarea v-model="metodologia" data-vv-name="metodología"
                                                hint="(indicar si es un curso, foro, taller, etc., describir las características que tendrán las actividades a desarrollar)"
                                                :error="errors.has('metodología')"
                                                :error-messages="errors.first('metodología')" label="Metodología"
                                                persistent-hint v-validate="'required|max:500'" auto-grow outlined
                                                rows="1" row-height="15"></v-textarea>
                                        </v-col>
                                        <v-col md="4">
                                            <v-textarea v-model="programaCurso"
                                                data-vv-name="programa del curso"
                                                :error="errors.has('programa del curso y horas por tema')"
                                                :error-messages="errors.first('programa del curso y horas por tema')"
                                                label="Programa del curso" persistent-hint
                                                v-validate="'required|max:500'" auto-grow outlined rows="1"
                                                row-height="15"></v-textarea>
                                        </v-col>
                                        <v-col md="4">
                                            <v-textarea v-model="horasPorTema"
                                                data-vv-name="programa del curso y horas por tema"
                                                :error="errors.has('programa del curso y horas por tema')"
                                                :error-messages="errors.first('programa del curso y horas por tema')"
                                                label="Horas por tema" persistent-hint
                                                v-validate="'required|max:500'" auto-grow outlined rows="1"
                                                row-height="15"></v-textarea>
                                        </v-col>
                                        <v-col md="4">
                                            <v-textarea v-model="resultadoAprendizaje"
                                                data-vv-name="resultado del aprendizaje"
                                                hint="(Es el desempeño y las evidencias que se obtendrán del curso)"
                                                :error="errors.has('resultado del aprendizaje')"
                                                :error-messages="errors.first('resultado del aprendizaje')"
                                                label="Resultado del aprendizaje" persistent-hint
                                                v-validate="'required|max:500'" auto-grow outlined rows="1"
                                                row-height="15"></v-textarea>
                                        </v-col>
                                        <v-col md="4">
                                            <v-textarea v-model="perfil" data-vv-name="perfil del(a) participante"
                                                :error="errors.has('perfil del(a) participante')"
                                                :error-messages="errors.first('perfil del(a) participante')"
                                                label="Perfil del(a) participante" persistent-hint
                                                v-validate="'required|max:500'" auto-grow outlined rows="1"
                                                row-height="15"></v-textarea>
                                        </v-col>
                                    </v-row>
                                    <%-- <v-row justfy="center" dense>
                                        </v-row> --%>
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
                                                    :error-messages="errors.first('tipo facilitador')">
                                                </v-select>
                                            </v-col>

                                            <v-col md="3">
                                                <v-text-field v-model="nombreFacilitador[index]" outlined label="Nombre"
                                                    persistent-hint v-validate="'required|max:500'"
                                                    data-vv-name="nombre" :error="errors.has('nombre')"
                                                    :error-messages="errors.first('nombre')"></v-text-field>
                                            </v-col>
                                            <v-col md="3">
                                                <v-autocomplete v-model="areaPertenece[index]" outlined
                                                    label="Área académica a la que pertenece" :items="areas"
                                                    item-value="idArea" item-text="nombreArea"
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
                                        <v-tooltip top>
                                            <template v-slot:activator="{ on, attrs }">
                                                <v-btn color="primary" v-bind="attrs" v-on="on"
                                                    @click="numberOfInputs++"><v-icon>mdi-account-multiple-plus</v-icon></v-btn>
                                            </template>
                                            <span>Agregar un nuevo facilitador</span>
                                        </v-tooltip>
                                        <%-- <v-row justfy="center" dense> </v-row> --%>
                                            <v-row justify="center">
                                                <v-btn color="primary"
                                                    @click="flagEditar ? fnEditar() : fnGuardar()"><v-icon>mdi-content-save</v-icon>{{flagEditar
                                                    ? 'Editar' : 'Guardar'}}</v-btn>
                                                &nbsp;
                                                <v-btn color="error"
                                                    @click="fnLimpiarCampos()"><v-icon>mdi-cancel</v-icon>Cancelar</v-btn>
                                            </v-row>
                                            <v-row justify="center">
                                                <v-col md="12">
                                                    <v-data-table :headers="headerCapacitacion"
                                                        :items="dataSolicitudCapacitacion" class="elevation-2"
                                                        no-data-text="No se encontro ningun registro"
                                                        :hide-default-header="dataSolicitudCapacitacion.length < 1"
                                                        :hide-default-footer="dataSolicitudCapacitacion.length < 1"
                                                        locale="es-ES" :mobile-breakpoint="NaN" items-per-page="10">
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

                    const modal2 = false;
                    //Otras variables
                    const flagEditar = ref(false);
                    const itemEditar = ref({});
                    //Combo
                    const cursos = ref([]);
                    const areas = ref([]);

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
                       
                    ]);
                    const searchCapacitacion = ref([]);
                    const dataBusqueda = ref([]);

                    onMounted(() => {
                        fnConsultarTabla();
                        fnCursos();
                        fnbuscar_cve_docente();
                        fnInstructores();
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

                async function fnBuscarDocente() {
                    const numeroControl = this.numeroControl;
                    console.log(numeroControl);

                    for (let i = 0; i < this.dataBusqueda.length; i++) {
                        if (numeroControl === this.dataBusqueda[i].cve_persona.toString()) {                           
                            this.direccion = this.dataBusqueda[i].nombre_area,
                            this.programa = this.dataBusqueda[i].nombre_ugac,
                            this.puesto = this.dataBusqueda[i].nombre_tipo_puesto,
                            this.nombre = this.dataBusqueda[i].nombre + ' ' +
                                this.dataBusqueda[i].apellido_peterno + ' ' + 
                                this.dataBusqueda[i].apellido_materno
                            
                        break; 
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: 'El número de control no coincide.',
                            });
                        }
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
                                    parametros.append("idAreaF", areaPertenece.value);
                                    parametros.append("idAreaS", area.value);
                                    parametros.append("nombreCurso", nombreCurso.value);
                                    parametros.append("fechaCurso", fecha.value);
                                    parametros.append("horaCurso", horario.value);
                                    parametros.append("lugar", lugar.value);
                                    parametros.append("nombreFacilitador", nombreFacilitador.value);
                                    parametros.append("programaEducativoS", fecha.value);
                                    parametros.append("nombreSolicitante", nombre.value);
                                    parametros.append("tipoCurso", tipoCurso.value);
                                    parametros.append("puesto", puesto.value);
                                    parametros.append("tipoCompetencias", tipoCompetencia.value);
                                    parametros.append("totalDias", dias.value);
                                    parametros.append("totalHoras", horas.value);
                                    parametros.append("numeroParticipantes", numeroParticipantes.value);
                                    parametros.append("objetivos", objetivo.value);
                                    parametros.append("alcance", alcance.value);
                                    parametros.append("metodologia", metodologia.value);
                                    parametros.append("programaDelCurso", programaCursoHoras.value);
                                    parametros.append("resultadoDeAprendizaje", resultadoAprendizaje.value);
                                    parametros.append("vperfilDeParticipante", perfil.value);
                                    let { data, status } = await axios.post(ctr, parametros);
                                    if (status == 200) {
                                        if (data == "1") {
                                            mostrarSnackbar(
                                                "success",
                                                "Registro guardado correctamente."
                                            );
                                            //fnConsultarTabla();
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

                    async function fnEditar() {
                        this.$validator.validate().then(async (esValido) => {
                            if (esValido) {
                                try {
                                    preloader("../../");
                                    let parametros = new URLSearchParams();
                                    parametros.append("accion", 4);
                                    parametros.append("id_recursos", itemEditar.value.id_recursos);
                                    parametros.append("accion", 2);
                                    parametros.append("recursos", recursos.value);
                                    parametros.append("nombreProyecto", nombreProyecto.value);
                                    parametros.append("fecha", fecha.value);
                                    console.log(parametros);
                                    let { data, status } = await axios.post(ctr, parametros);
                                    if (status == 200) {
                                        if (data == "1") {
                                            mostrarSnackbar(
                                                "success",
                                                "Registro actualizado correctamente."
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
                        area.value = "";
                        programa.value = "";
                        nombre.value = "";
                        puesto.value = "";
                        tipoCompetencia.value = "";
                        fechaInicio.value = "";
                        fechaFin.value = "";
                        nombreCurso.value = "";
                        horario.value = "";
                        lugar.value = "";
                        dias.value = "";
                        horas.value = "";
                        numeroParticipantes.value = "";
                        tipoCurso.value = "";
                        objetivo.value = "";
                        alcance.value = "";
                        metodologia.value = "";
                        programaCursoHoras.value = "";
                        resultadoAprendizaje.value = "";
                        perfil.value = "";
                        nombreFacilitador.value = "";
                        areaPertenece.value = "";
                        programaEducativo.value = "";
                        tipoFacilitador.value = "";

                        flagEditar.value = false;
                        itemEditar.value = {};

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
                        numeroControl,
                        color_snackbar,
                        snackbar,
                        mensaje_snackbar,
                        loader,
                        mostrarSnackbar,
                        flagEditar,
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
                        fnEditar,
                        fnCambiarEstatus,
                        fnbuscar_cve_docente,
                        fnBuscarDocente,
                        itemEditar,
                        instructores,
                        dataBusqueda,
                        horasPorTema
                    };
                },
            });

            Vue.config.devtools = true;
        </script>

    </html>