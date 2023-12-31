<%@page contentType="text/html; charset=UTF-8" language="java" errorPage="" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900" rel="stylesheet">
        <link href="../../styles/icon_material_design_4495/css/materialdesignicons.min.css" rel="stylesheet">
        <link href="../../javascript/VueJs/sweetalert2/sweetalert2.css" />
        <link href="../../javascript/VueJs/vuetify/vuetify.min.css" rel="stylesheet">
        <link rel="shortcut icon" href="../../images/favicon.ico" type="image/x-icon">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui UTF-8">
        <script src="../../javascript/VueJs/vue/vue.js"></script>
        <script type="" src="../../javascript/VueJs/vue/vue-composition-api.prod.js" ></script>
        <title>Autoevaluaci&oacute;n de eficacia de capacitaci&oacute;n docente</title>
    </head>
    <style>
        body {
          font-family: 'Roboto';
        }

        #tabla {
            border-collapse: collapse;
            
        }

        .th,
        .td {
            
            border: 1px solid gray;
            padding: 1px;
            padding-left: 5px;
            padding-right: 5px;
        }


    </style>
    <body>
        <div id="app">
            <v-app>
                <v-container fluid>
                    <v-card>
                        <v-card-title  style="background-color: #00b293; color:#ffffff;" >		
                            AUTOEVALUACI&Oacute;N DE EFICACIA DE CAPACITACI&Oacute;N DOCENTE
                        </v-card-title>
                        <v-container fluid>

                            <!--Columna-->
                            <v-row justfy="center" dense >
                                <v-col class="text-center"><b>Datos del docente capacitado</b></v-col>
                            </v-row>
                            <v-divider></v-divider>
                            <v-row class="align-end" style="padding: 0px 50px 0px 50px">
                                <v-col md=12>
                                <table id="tabla" class="text-left">
                                    <tbody>
                                        <tr>
                                            <th class="th" style="width: 220px;">Número de control</th>
                                            <td class="td" style="width: 990px;"> {{idEmpleado}} </td>
                                        </tr>
                                        <tr>
                                            <th class="th">Nombre del participante</th>
                                            <td class="td" style="width: 990px;"> {{nombre}} {{ape1}} {{ape2}} </td>
                                        </tr>
                                        <tr>
                                            <th class="th">Sexo</th>
                                            <td class="td" style="width: 990px;"> {{sexo}} </td>
                                        </tr>
                                        <tr>
                                            <th class="th">Puesto</th>
                                            <td class="td" style="width: 990px;"> {{puesto}} </td>
                                        </tr>
                                        <tr>
                                            <th class="th">Área</th>
                                            <td class="td" style="width: 990px;"> {{area}} </td>
                                        </tr>
                                        <tr>
                                            <th class="th">Carrera</th>
                                            <td class="td" style="width: 990px;"> {{carrera}} </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </v-col>
                            </v-row>

                                
                            

                            <v-row justfy="center" dense >
                                <v-col class="text-center"><b>Datos del curso asistido </b></v-col>
                            </v-row>
                                <v-divider></v-divider> 

                            <v-row class="align-center" style="padding: 0px 50px 0px 50px">
                                <v-col md=7>
                                    <v-select 
                                        v-model="cursoTomado"
                                        outlined
                                        label="Seleccione el curso del cual desea hacer su autoevaluación"
                                        v-validate="'required'"
                                        :items="arrayCursosTomados"
                                        item-value="cve_even_prog"
                                        item-text="nombre_evento"
                                        data-vv-name="areaCapacitacion"
                                        :error="errors.has('areaCapacitacion')"
                                        :error-messages="errors.first('areaCapacitacion')"
                                    ></v-select>
                                </v-col>
                           
                                <v-col md=12>
                                <table id="tabla" class="text-left">
                                    <tbody>
                                        <tr>
                                            <th class="th" style="width: 110px;">Objetivo:</th>
                                            <td class="td" style="width: 1110px;" id="objetivoCel"> {{objetivoR}}  </td>
                                        </tr>
                                        <tr>
                                            <th class="th">Periodo:</th>
                                            <td class="td" style="width: 1110px;">  </td>
                                        </tr>
                                        <tr>
                                            <th class="th">Fecha inicio:</th>
                                            <td class="td" style="width: 1110px;" id="fechaICel"> {{fechaI}}</td>
                                        </tr>
                                        <tr>
                                            <th class="th">Fecha fin:</th>
                                            <td class="td" style="width: 1110px;" id="fechaFCel"> {{fechaF}}</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </v-col>
                            </v-row>

                            <v-row class="align-end" style="padding: 0px 50px 0px 50px">
                                <!-- AREA EN QUE SE CAPACITO -->
                                 <v-col md=3>
                                    <v-select 
                                        v-model="areaCapacitacion"
                                        outlined
                                        label="Competencia en que se capacito"
                                        v-validate="'required'"
                                        :items="arrayAreasCapacitacion"
                                        
                                        data-vv-name="areaCapacitacion"
                                        :error="errors.has('areaCapacitacion')"
                                        :error-messages="errors.first('areaCapacitacion')"
                                    ></v-select>
                                </v-col>
                            </v-row>
                                
                                <v-row class="align-center" style="padding: 0px 50px 0px 100px">
                                    <v-p> <b>Conteste las siguientes preguntas de manera objetiva, considerando la siguiente escala: <br>
                                        10. Totalmente de acuerdo					<br>
                                        9. De acuerdo					<br>
                                        8. Ni de acuerdo ni en desacuerdo	<br>				
                                        7. En desacuerdo					<br>
                                        6. Totalmente en desacuerdo
                                        </b>
                                    </v-p>
                                </v-row>

                                <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">

                                    <v-col md=10>
                                        <v-p>1.- &#191;El contenido del curso me permiti&oacute; identificar t&eacute;cnicas, estrategias 
                                            y/ o acciones para la mejora mis funciones docentes?</v-p>
                                    </v-col>

                                    <v-col md=2>
                                        <v-select 
                                        v-model="escala1"
                                        outlined
                                        v-validate="'required'"
                                        :items="arrayEscala"
                                        item-value="idEscala"
                                        item-text="numero"
                                        data-vv-name="escala"
                                        :error="errors.has('escala')"
                                        :error-messages="errors.first('escala')"
                                        @input="calcularPromedio"
                                        ></v-select>
                                    </v-col>
                                </v-row>

                                <v-row class="align-center" style="padding: 0px 50px 0px 50px">
                                    <v-col md=6>
                                        
                                        <v-text-field 
                                            v-if="escala1 === 6 || escala1 === 7  "
                                            v-model="otraAct"
                                            outlined
                                            label="Indique brevemente los factores que no permitieron su identificación"
                                            persistent-hint
                                            v-validate="'required|max:200'"
                                            

                                        ></v-text-field>
                                        
                        
                                    </v-col>
                                </v-row>

                                <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">

                                    <v-col md=10>
                                        <v-p> 
                                            2.- Posterior al curso de capacitaci&oacute;n, &#191;Gener&eacute; propuestas de mejora en mi pr&aacute;ctica docente?
                                        </v-p>
                                    </v-col>

                                    <v-col md=2>
                                        <v-select 
                                        v-model="escala2"
                                        outlined
                                        v-validate="'required'"
                                        :items="arrayEscala"
                                        item-value="idEscala"
                                        item-text="numero"
                                        data-vv-name="tipo"
                                        :error="errors.has('tipo')"
                                        :error-messages="errors.first('tipo')"
                                        @input="calcularPromedio"
                                        ></v-select>
                                    </v-col>
                                </v-row>

                                <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">

                                    <v-col md=10>
                                        <v-p> 
                                            3.- &#191;En mi pr&aacute;ctica docente del cuatrimestre actual puse en pr&aacute;ctica las competencias adquiridas en el curso de capacitaci&oacute;n?
                                        </v-p>
                                    </v-col>

                                    <v-col md=2>
                                        <v-select 
                                        v-model="escala3"
                                        outlined
                                        v-validate="'required'"
                                        :items="arrayEscala"
                                        item-value="idEscala"
                                        item-text="numero"
                                        data-vv-name="tipo"
                                        :error="errors.has('tipo')"
                                        :error-messages="errors.first('tipo')"
                                        @input="calcularPromedio"
                                        ></v-select>
                                    </v-col>
                                </v-row>

                                <v-row class="align-center" style="padding: 0px 50px 0px 50px">
                                    <v-col md=6>
                                        <v-text-field 
                                        v-if="escala3 === 6 || escala3 === 7  "
                                            v-model="otraAct1"
                                            outlined
                                            label="Indique brevemente los factores que no permitieron su aplicación"
                                            persistent-hint
                                            v-validate="'required|max:200'"
                                            
                                        ></v-text-field>
                                        
                        
                                    </v-col>
                                </v-row>

                                <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">

                                    <v-col md=10>
                                        <v-p> 
                                            4.- La aplicaci&oacute;n de las nuevas competencias en mi pr&aacute;ctica docente mostr&oacute; mejoras en el desempe&ntilde;o de mis estudiantes:
                                        </v-p>
                                    </v-col>

                                    <v-col md=2>
                                        <v-select 
                                        v-model="escala4"
                                        outlined
                                        v-validate="'required'"
                                        :items="arrayEscala"
                                        item-value="idEscala"
                                        item-text="numero"
                                        data-vv-name="tipo"
                                        :error="errors.has('tipo')"
                                        :error-messages="errors.first('tipo')"
                                        @input="calcularPromedio"
                                        ></v-select>
                                    </v-col>
                                </v-row>

                                <v-row  class="align-center" style="padding: 0px 50px 0px 50px">

                                    <v-col md=10>
                                        <v-p> 
                                            5.- Seleccione el tipo de evidencia que utiliz&oacute; para verificar el impacto de las t&eacute;cnicas, estrategias o acciones aprendidas en el curso:
                                        </v-p>
                                    </v-col>

                                    <v-col md=2>
                                        <v-text-field
                                            disabled
                                            v-model="promedio"
                                            v-show="true"
                                        ></v-text-field>
                                    </v-col>
                                </v-row>

                                <v-row  class="align-center" style="padding: 0px 50px 0px 50px">
                                <v-col md=5>
                                    <v-radio-group v-model="evidencias">
                                        <v-radio value="Calificaciones de estudiantes" label="Calificaciones de estudiantes"></v-radio>
                                        <v-radio value="Encuestas a estudiantes" label="Encuestas a estudiantes"></v-radio>
                                        <v-radio value="Resultados de evaluación docente" label="Resultados de evaluación docente"></v-radio>
                                        <v-radio value="Entrevistas a estudiantes" label="Entrevistas a estudiantes"></v-radio>
                                        <v-radio value="Ninguno" label="Ninguno"></v-radio>
                                        <v-radio value="Otro" label="Otro"></v-radio>
                                      </v-radio-group>
                                </v-col>

                                <v-col md="4">
                                    <v-text-field
                                      v-if="evidencias === 'Otro'"
                                      v-model="otro"
                                      outlined
                                      label="Otro"
                                      v-validate="'required|max:200'"
                                    ></v-text-field>
                                </v-col>

                                



                            </v-row>

                                    
                                    
                            <v-row justify="center">
                                <v-btn color="primary" @click="flagEditar ? fnEditar() : fnGuardar()"><v-icon>mdi-content-save</v-icon>{{flagEditar ? 'Editar' : 'Guardar'}}</v-btn>
                                &nbsp;
                                <v-btn color="error" @click="fnLimpiarCampos()"><v-icon>mdi-cancel</v-icon>Cancelar</v-btn>
                            </v-row>
                            <v-row justify="center">
                                <v-col md=12>
                                    <v-data-table
                                        :headers="headersProveedores"
                                        :items="dataProveedores"
                                        :search="searchProveedores"
                                        class="elevation-2"
                                        no-data-text="No se encontro ningun registro"
                                        :hide-default-header="dataProveedores.length < 1"
                                        :hide-default-footer="dataProveedores.length < 1"
                                        locale="es-ES"
                                        :mobile-breakpoint="NaN"
                                        items-per-page="10"
                                    >

                                    <template v-slot:item.estatus="{ item }">
                                                           
                                        <v-icon id= "g" color="green" @click="">mdi-circle</v-icon>
                                        <v-icon id= "y" color="yellow" @click="">mdi-circle</v-icon>
                                        <v-icon id= "r" color="red" @click="">mdi-circle</v-icon>
                                    
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
        import {preloader, guardar, errorGuardar, actualizar, errorActualizar, eliminar, errorEliminar, cerrar, confirmarE, aviso, confirmar} from '../../javascript/mensajeSistema/mensajes_sweetalert_vue.js';
        Vue.use(VeeValidate, {
            classes: true	
        });

        //Lenguaje de VeeValidate
        VeeValidate.Validator.localize("es");

        new Vue({
            el: "#app",
            vuetify: new Vuetify(),
            setup(){
                const {
                    ref,
                    onMounted,
                    watch
                } = VueCompositionAPI;
                const ctr = "../../controlador/formacion_docente/controlador_catalogo_autoevaluacion_capacitacion_docente.jsp";
                
                
                const objetivo = ref("");
                const alcance = ref("");
                const periodo = ref("");
                const fecha = ref("");
                const areaCapacitacion = ref("");
                const escala1 = ref("");
                const escala2 = ref("");
                const escala3 = ref("");
                const escala4 = ref("");
                const escala5 = ref("");
                const otraAct = ref("");
                const otraAct1 = ref("");
                const option = ref("");
                const option1 = ref("");
                const option2 = ref("");
                const option3 = ref("");
                const option4 = ref("");
                const evidencias = ref("");
                const otro = ref("");
                const promedio = ref("");
                const cursoTomado = ref("");
                
                //ARREGLOS
                const arrayCarreras = ref([]);
                const arrayAreasCapacitacion = ref(["Estrategias pedagógicas", "Comunicación", 
                "Herramientas digitales", "Tutoreo", "Procesos institucionales", "Investigación", 
                "Competencias técnicas"]);
                const arrayEscala = ref([10,9,8,7,6]);
                const arrayPeriodo = ref([]);
                const arrayCursos = ref([]);
                const arrayCursosTomados = ref([]);
                const arrayCursoSeleccionado = ref([]);
                const arrayCursoSeleccionadoInfo = ref([]);

                
                //Otras variables
                const flagEditar = ref(false);
                const itemEditar = ref({});
                //Setup del calendario
                const arrayTiposProveedores = ref([]);
                //Setup de inputs


                //SNACKBAR
                const loader = ref(false);
                const snackbar = ref(false);
                const mensaje_snackbar = ref('');
                const color_snackbar = ref('');
                //Loaders
                //Dialogs
                const dialogBuscador = ref(true);
                const nombreBuscar = ref('');
                const searchBusqueda = ref('');

                const dialogDetallesCotizacion = ref(false);
                const dialogProveedor = ref(false);

                //DataTable
                const headers = ref([]);
                const dataProveedores = ref([]);
                const headersProveedores = ref([
                    {text: 'N° de control', align: 'left', sortable: true, value: 'cve_empleado'},
                    {text: 'Nombre del docente', align: 'left', sortable: true, value: 'nombre'},
                    {text: 'Tema del curso', align: 'left', sortable: true, value: 'nombre_evento'},
                    {text: 'Promedio calificación', align: 'left', sortable: true, value: 'promedio'},
                    {text: 'Fecha', align: 'left', sortable: true, value: 'fecha_registro'},
                    { text: "Estatus", align: "left", sortable: false, value: "estatus" },

                ]);
                const searchProveedores = ref([]);

                const currentUser = localStorage.getItem('currentUser');
                const user = JSON.parse(currentUser);
                const cve_persona = user[0].cve_persona;
                const idEmpleado = user[0].cve_empleado;
                const nombre = user[0].nombre;
                const ape1 = user[0].apellido_paterno;
                const ape2 = user[0].apellido_materno;
                const sexo = user[0].sexo;
                const puesto = user[0].nombre_puesto;
                const area = user[0].nombre_area;
                const carrera = user[0].nombre_ugac;

                const objetivoR = ref('');
                const fechaI = ref('');
                const fechaF = ref('');

                

                onMounted(() => {
                    fnConsultarTabla();
                    periodos();
                    cursos();
                    
                    
                });

        

                async function fnGuardar(){
                    this.$validator.validate().then(async esValido => {
                        if(esValido){
                            try{
                                preloader("../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 2);
                                parametros.append("numeroControl", numeroControl.value);
                                parametros.append("evidencias", evidencias.value + '-->' + otro.value);
                                parametros.append("otraAct", otraAct.value);
                                parametros.append("otraAct1", otraAct1.value);
                                parametros.append("promedio", promedio.value);
                                
                                let {data,status} = await axios.post(ctr, parametros);
                                    console.log(parametros);
                                    if(status == 200){
                                        if(data == "1"){
                                            mostrarSnackbar("success", "Registro guardado correctamente.");
                                            fnConsultarTabla();
                                            fnLimpiarCampos(this);   
                                        }
                                    }
                                
                            } catch(error){
                                mostrarSnackbar('error');
                                console.error(error);
                            } finally{
                                swal.close();
                            }
                        }
                    })
                }

                async function fnConsultarTabla(){
                    try{
                        preloader("../");
                        //arreglo
                        let parametros = new URLSearchParams();
                        //le mandamos un parametro llamado accion
                        parametros.append("accion", 1);
                        //axios envia la peticion
                        let {data,status} = await axios.post(ctr, parametros)
                        if(status == 200){
                            if(data.length > 0){
                                dataProveedores.value = data
                            }
                        }
                    } catch(error){
                        mostrarSnackbar('error');
                        console.error(error);
                    } finally{
                        swal.close();
                    }
                }

                async function periodos(){
                    try{
                        preloader("../");
                        //arreglo
                        let parametros = new URLSearchParams();
                        //le mandamos un parametro llamado accion
                        parametros.append("accion", 4);
                        //axios envia la peticion
                        let {data,status} = await axios.post(ctr, parametros)
                        if(status == 200){
                            if(data.length > 0){
                                arrayPeriodo.value = data
                            }
                        }
                    } catch(error){
                        mostrarSnackbar('error');
                        console.error(error);
                    } finally{
                        swal.close();
                    }
                }
                
                async function cursos(){
                    try{
                        preloader("../");
                        let parametros = new URLSearchParams();
                        parametros.append("accion", 3);
                        preloader("../../");
                        parametros.append("cve", idEmpleado); 
                        let {data,status} = await axios.post(ctr, parametros)
                        if(status == 200){
                            if(data.length > 0){
                                arrayCursosTomados.value = data
                                
                            }
                        }
                    } catch(error){
                        mostrarSnackbar('error');
                        console.error(error);
                    } finally{
                        swal.close();
                    }
                }

                async function fnInfoCursos(){
                    try{
                        preloader("../");
                        let parametros = new URLSearchParams();
                        parametros.append("accion", 5);
                        preloader("../../");
                        parametros.append("cursoSeleccionado", this.cursoTomado);
                        console.log('cursoo',cursoTomado)
                        let {data,status} = await axios.post(ctr, parametros)
                        if(status == 200){
                            if(data.length > 0){
                                arrayCursoSeleccionadoInfo.value = data
                                console.log('info evento programado:',arrayCursoSeleccionadoInfo)
                                console.log('nombre origen:', this.arrayCursoSeleccionadoInfo[0].nombre_origen)
                                if( this.arrayCursoSeleccionadoInfo[0].nombre_origen === 'DANC'){
                                    console.log('clave de origen de curso:', this.arrayCursoSeleccionadoInfo[0].cve_origen_evento);
                                    try{
                                        preloader("../");
                                        let parametros = new URLSearchParams();
                                        parametros.append("accion", 6);
                                        parametros.append("cursoSeleccionado", this.arrayCursoSeleccionadoInfo[0].cve_origen_evento);
                                        let {data,status} = await axios.post(ctr, parametros)
                                        if(status == 200){
                                            if(data.length > 0){
                                                arrayCursoSeleccionadoInfo.value = data
                                                const objetivoR = this.arrayCursoSeleccionadoInfo[0].objetivo_evento;
                                                const objetivoCel = document.getElementById('objetivoCel');
                                                objetivoCel.textContent = objetivoR;

                                                const fechaI = this.arrayCursoSeleccionadoInfo[0].fecha_inicio;
                                                const fechaICel = document.getElementById('fechaICel');
                                                fechaICel.textContent = fechaI;

                                                const fechaF = this.arrayCursoSeleccionadoInfo[0].fecha_temino;
                                                const fechaFCel = document.getElementById('fechaFCel');
                                                fechaFCel.textContent = fechaF;
                                                
                                            }
                                        }
                                    } catch(error){
                                        mostrarSnackbar('error');
                                        console.error(error);
                                    } finally{
                                        swal.close();
                                    }
                                } 
                            }
                        }
                    } catch(error){
                        mostrarSnackbar('error');
                        console.error(error);
                    } finally{
                        swal.close();
                    }
                }

                

                function fnLimpiarCampos(cx){//cx = contexto
                    
                    objetivo.value = "";
                    alcance.value = "";
                    periodo.value = "";
                    fecha.value = "";
                    areaCapacitacion.value = "";
                    escala1.value = "";
                    escala2.value = "";
                    escala3.value = "";
                    escala4.value = "";
                    escala5.value = "";
                    otraAct.value = "";
                    option.value = "";
                    option1.value = "";
                    option2.value = "";
                    option3.value = "";
                    option4.value = "";
                    otro.value = "";
                    promedio.value = "";
                
                   
                    flagEditar.value = false;
                    itemEditar.value = {};

                    if(this == undefined)
                        cx.$validator.reset();
                    else
                        this.$validator.reset();
                }

                function mostrarSnackbar(color, texto){
                    snackbar.value = true;
                    color_snackbar.value = color;
                    if(color=="error"){
                        mensaje_snackbar.value = "Ocurrió un error. Intentalo de nuevo más tarde.";
                    }else{
                        mensaje_snackbar.value = texto; }
                }

                

                return{
                    color_snackbar, snackbar, mensaje_snackbar, loader, mostrarSnackbar, flagEditar,
                    nombreBuscar,

                    idEmpleado, area, carrera,
                    objetivo, alcance, periodo, fecha, areaCapacitacion, escala1, escala2, escala3, escala4, escala5,  otraAct, otraAct1,
                    option, option1, option2, option3, option4, otro, evidencias, promedio, currentUser, nombre, ape1, ape2, sexo, puesto,
                    cursoTomado, objetivoR, fechaI, fechaF,
                    
                    arrayCarreras, arrayAreasCapacitacion, arrayEscala, arrayPeriodo, arrayCursos, arrayCursosTomados, arrayCursoSeleccionado,
                    arrayCursoSeleccionadoInfo,                    
                    
                    dataProveedores, headersProveedores, searchProveedores, arrayTiposProveedores, 
                    dialogBuscador, dialogDetallesCotizacion, dialogProveedor,
                    fnLimpiarCampos, itemEditar, searchBusqueda,
                    fnConsultarTabla, fnGuardar, periodos, fnInfoCursos
                }
            },
            methods: {
                calcularPromedio() {
                    const sumaEscalas = this.escala1 + this.escala2 + this.escala3 + this.escala4;
                    this.promedio = "Promedio: "+ sumaEscalas / 4;
                    console.log(this.promedio);
                },
                
            },
            // sirve para observar cambios en los datos y ejecutar funciones cuando se detecta un cambio

            watch: {
                cursoTomado(valorSeleccionado) {
                    const valor = valorSeleccionado;
                    console.log(valor); // Imprime el valor seleccionado en la consola
                    this.fnInfoCursos();
                    
                }
            },
            
        });

        Vue.config.devtools = true;
</script>
</html>