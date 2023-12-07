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
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
        <script src="../../javascript/VueJs/vue/vue.js"></script>
        <script type="" src="../../javascript/VueJs/vue/vue-composition-api.prod.js" ></script>
        <title>Evaluación de capacitación</title>
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
                        <v-card-title  style="background-color: #00b293; color:#ffffff;" >		
                            Evaluación de capacitación docente
                        </v-card-title>
                        <v-container fluid>
                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px"> 
                            
                                <template>
                                    <!--<v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                      <v-col md="6">
                                        <v-data-table
                                          v-if="mostrarGrupos"
                                          :headers="headersGrupos"
                                          :items="dataGrupos"
                                          class="elevation-2"
                                          no-data-text="No se encontró ningún registro"
                                          :hide-default-header="dataGrupos.length < 1"
                                          :hide-default-footer="dataGrupos.length < 1"
                                          locale="es-ES"
                                          :mobile-breakpoint="NaN"
                                          items-per-page="10"
                                        >
                                          <template v-slot:item.ingresar="{ item }">
                                            <v-icon color="green" @click="mostrarParticipantes = true; mostrarGrupos = false; fnObtener(item); fnLlenar()">mdi-arrow-right</v-icon>
                                          </template>
                                        </v-data-table>
                                      </v-col>-->

                                    <v-col md=7>
                                        <v-select 
                                            v-model="curso"
                                            outlined
                                            label="Seleccione "
                                            v-validate="'required'"
                                            :items="dataGrupos"
                                            item-value="cve_even_prog"
                                            item-text="nombre_evento"
                                            
                                        ></v-select>
                                    </v-col>
                                </v-row>
                                  
                                    <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                        <v-row v-if="mostrarParticipantes">
                                            <v-col md=12>
                                                <table id="tabla" class="text-left">
                                                    <tbody>
                                                        <tr>
                                                            <th class="th">Número del curso</th>
                                                            <td class="td" style="width: 670px;">  {{ this.nombreEvento }} </td>
                                                        </tr>
                                                        <tr>
                                                            <th class="th">Nombre del instructor</th>
                                                            <td class="td" style="width: 650px;"> {{ this.nombreInstructor }} </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </v-col>
                                            </v-row>
                                    </v-row>

                                    <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                        <v-col md="12">
                                            <v-data-table
                                            v-if="mostrarParticipantes"
                                            :headers="headersParticipantes"
                                            :items="dataParticipantes"
                                            class="elevation-2"
                                            no-data-text="No se encontró ningún registro"
                                            :hide-default-header="dataParticipantes.length < 1"
                                            :hide-default-footer="dataParticipantes.length < 1"
                                            locale="es-ES"
                                            :mobile-breakpoint="NaN"
                                            items-per-page="10"
                                            >
                                            <template v-slot:item.calificacion="{ item }">
                                                <v-text-field outlined persistent-hint v-model="item.calificacion"></v-text-field>
                                            </template>
                                            <template v-slot:item.asistencias="{ item }">
                                                <v-text-field outlined persistent-hint v-model="item.asistencias"></v-text-field>
                                            </template>
                                              
                                            </v-data-table>
                                        </v-col>
                                      
                                  
                                        <v-row justify="center" v-if="mostrarParticipantes">
                                          <v-btn color="blue darken-3" class="white--text" @click="mostrarParticipantes = false; mostrarGrupos = true"><v-icon>mdi-arrow-left</v-icon>Regresar</v-btn>
                                          &nbsp;
                                          <v-btn color="primary" @click="flagEditar ? fnEditar() : fnGuardar()"><v-icon>mdi-content-save</v-icon>{{flagEditar ? 'Editar' : 'Guardar'}}</v-btn>
                                          &nbsp;
                                          <v-btn color="error" @click="fnLimpiarCampos()"><v-icon>mdi-cancel</v-icon>Cancelar</v-btn>
                                         
                                        </v-row>
                                      
                                    </v-row>
                                  </template>
                            </v-row>

                            <v-row justify="center">
                                <v-col md=12>
                                    <v-data-table
                                        :headers="headersEvaluaciones"
                                        :items="dataEvaluaciones"
                                        class="elevation-2"
                                        no-data-text="No se encontro ningun registro"
                                        :hide-default-header="dataEvaluaciones.length < 1"
                                        :hide-default-footer="dataEvaluaciones.length < 1"
                                        locale="es-ES"
                                        :mobile-breakpoint="NaN"
                                        items-per-page="10"
                                    >   
                                      
                                        <template v-slot:item.editar="{ item }">
                                            <v-btn fab small color="warning" @click="fnEditar(); flagEditar = true; itemEditar = item; 
                                                ">
                                                <v-icon>mdi-square-edit-outline</v-icon>
                                            </v-btn>
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
                    <v-img
                        aspect-ratio="2"
                        class="white--text align-end"
                        height="212px"
                        width="292px"
                        src="../../images/Logo_utl_animado.gif"
                    > 
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
                const ctr = "../../controlador/formacion_docente/controlador_evaluacion_capacitacion.jsp";
                //Variables POST
                const items = 1;
                const curso = ref('');

                //Otras variables
                const flagEditar = ref(false);
                const itemEditar = ref({});
                
                //SNACKBAR
                const loader = ref(false);
                const snackbar = ref(false);
                const mensaje_snackbar = ref('');
                const color_snackbar = ref('');
                
                //Dialogs
                const dialogBuscador = ref(false);
                const dialogDetallesCotizacion = ref(false);
                const dialogProveedor = ref(false);

                //DataTable
                const headersGrupos = ref([
                    {text: 'Curso', align: 'left', sortable: true, value: 'nombre_evento'},
                    {text: '', align: 'left', sortable: true, value: 'ingresar'},
                ]);
                const dataGrupos = ref([]);

                const headersParticipantes = ref([
                    {text: 'N°', align: 'left', sortable: true, value: 'cve_empleado'},
                    {text: 'Número de control', align: 'left', sortable: true, value: 'cve_empleado'},
                    {text: 'Nombre', align: 'left', sortable: true, value: 'nombre'},
                    {text: 'Puesto', align: 'left', sortable: true, value: 'nombre_puesto'},
                    {text: 'Dirección', align: 'left', sortable: true, value: 'nombre_area'},
                    {text: 'Asistencias', align: 'left', sortable: true, value: 'asistencias'},
                    {text: 'Calificación final', align: 'left', sortable: true, value: 'calificacion'},
                ]);
                const dataParticipantes = ref([]);
                const dataCalificaciones = ref([]);

                const headersEvaluaciones = ref([
                    
                    {text: 'Nombre del curso', align: 'left', sortable: true, value: 'nombre_evento'},
                    {text: 'Nombre del instructor', align: 'left', sortable: true, value: 'nombre_facilitador'},
                    {text: 'Fecha de evaluación', align: 'left', sortable: true, value: 'fecha_registro'},
                    {text: 'Editar', align: 'left', sortable: true, value: 'editar'},
                ]);
                const dataEvaluaciones = ref([]);

                const currentUser = localStorage.getItem('currentUser');
                const user = JSON.parse(currentUser);
                const cve_persona = user[0].cve_persona;
                const idEmpleado = user[0].cve_empleado;

                onMounted(() => {
                    fnConsultarTabla();
                    fnConsultarTablaEvaluaciones();
                    console.log('current',currentUser)
                    console.log('id',idEmpleado);
                    fnVerCursos();
                });

                async function fnConsultarTabla(){
                    try{
                        preloader("../../");
                        let parametros = new URLSearchParams();
                        parametros.append("accion", 1);
                        let {data,status} = await axios.post(ctr, parametros)
                        if(status == 200){
                            if(data.length > 0){
                                dataGrupos.value = data
                            }
                        }
                    } catch(error){
                        mostrarSnackbar('error');
                        console.error(error);
                    } finally{
                        swal.close();
                    }
                }

                async function fnVerCursos(){
                    try{
                        preloader("../../");
                        let parametros = new URLSearchParams();
                        parametros.append("accion", 1);
                        parametros.append("idUsuario", idEmpleado);
                        let {data,status} = await axios.post(ctr, parametros)
                        if(status == 200){
                            if(data.length > 0){
                                dataGrupos.value = data
                            }
                        }
                    } catch(error){
                        mostrarSnackbar('error');
                        console.error(error);
                    } finally{
                        swal.close();
                    }
                }

                function fnObtener(grupo) {
                    const arregloGrupo = Object.values(grupo);
                    console.log('Arreglo del grupo:', arregloGrupo);
                    console.log('id evento:', arregloGrupo[0]);
                    this.cve = arregloGrupo[0];
                }

                function ejecutarFunciones() {
                    this.mostrarParticipantes = true;
                    this.mostrarGrupos = false;
                    this.fnObtener(curso);
                    this.fnLlenar();
                }
                

                async function fnLlenar() {
                        this.$validator.validate().then(async (esValido) => {
                            if (esValido) {
                                try {
                                    preloader("../../");
                                    let parametros = new URLSearchParams();
                                    parametros.append("accion", 2);
                                    parametros.append("cve", this.cve);
                                    let { data, status } = await axios.post(ctr, parametros);
                                    if (status == 200) {
                                            dataParticipantes.value = data;
                                            console.log('valor participantes ', dataParticipantes)

                                            this.nombreEvento = dataParticipantes.value[0].nombre_evento;
                                            this.nombreInstructor = dataParticipantes.value[0].nombre_instructor;
                                            
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
                    
                async function fnGuardar(){
                    this.$validator.validate().then(async esValido => {
                        if(esValido){
                            this.dataParticipantes.forEach(async (participante) => {
                            try{
                                preloader("../");
                                let parametros = new URLSearchParams();
                                
                                    parametros.append("accion", 3);
                                    parametros.append("cve_empleado", participante.cve_empleado);
                                    parametros.append("cve_curso", this.cve);
                                    parametros.append("nombreInstructor", this.nombreInstructor);
                                    parametros.append("calificacion", participante.calificacion);
                                    parametros.append("idUsuario", idEmpleado);
                                
                                let {data,status} = await axios.post(ctr, parametros);
                                    console.log(parametros);
                                    if(status == 200){
                                        if(data == "1"){
                                            mostrarSnackbar("success", "Registro guardado correctamente.");
                                            fnConsultarTablaEvaluaciones();
                                        }
                                    }
                            } catch(error){
                                mostrarSnackbar('error');
                                console.error(error);
                            } finally{
                                swal.close();
                            }
                        });
                        }
                    })
                }

                

                async function fnConsultarTablaEvaluaciones(){
                    try{
                        preloader("../../");
                        let parametros = new URLSearchParams();
                        parametros.append("accion", 4);
                        let {data,status} = await axios.post(ctr, parametros)
                        if(status == 200){
                            if(data.length > 0){
                                dataEvaluaciones.value = data
                            }
                        }
                    } catch(error){
                        mostrarSnackbar('error');
                        console.error(error);
                    } finally{
                        swal.close();
                    }
                }
            
                async function fnEditar(){
                    this.$validator.validate().then(async esValido => {
                        if(esValido){
                            try{
                                preloader("../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 5);
                                parametros.append("cve_curso", this.cve);
                                let {data,status} = await axios.post(ctr, parametros)
                                
                                /*data.forEach(objeto => { console.log(objeto.calificacion_final);
                                });*/

                                if(status == 200){
                                    /*const calificacionesFinales = data.map(objeto => objeto.calificacion_final);
                                    console.log('valor calificaciones', calificacionesFinales);

                                    for (let i = 0; i < this.dataParticipantes.length; i++) {
                                        this.dataParticipantes[i].calificacion = calificacionesFinales[i];
                                        console.log(this.dataParticipantes[i].calificacion); 
                                    }
                                    console.log(this.dataParticipantes); */

                                    console.log("data",data)
                                    

                                    this.dataParticipantes.forEach(participante => {
                                        data.forEach(calificacion => {
                                            console.log(participante.cve_empleado + " == "+calificacion.cve_empleado_docente)
                                            if(participante.cve_empleado == calificacion.cve_empleado_docente)
                                                participante.calificacion = calificacion.calificacion_final;
                                        })
                                    })
                                    console.log("array",this.dataParticipantes)

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

                function mostrarSnackbar(color, texto){
                    snackbar.value = true;
                    color_snackbar.value = color;
                    if(color=="error")
                        mensaje_snackbar.value = "Ocurrió un error. Intentalo de nuevo más tarde.";
                    else
                        mensaje_snackbar.value = texto; 
                }

                return{
                    calificacion: [], items, curso,
                    calificacionesFinales: [],
                    color_snackbar, snackbar, mensaje_snackbar, loader, mostrarSnackbar, flagEditar,

                    headersGrupos, headersParticipantes, headersEvaluaciones,
                    dataGrupos, dataParticipantes, dataCalificaciones, dataEvaluaciones , cve:'',
                    dialogBuscador, dialogDetallesCotizacion, dialogProveedor,
                    fnConsultarTabla, fnObtener, fnLlenar, fnConsultarTablaEvaluaciones, itemEditar,
                    mostrarGrupos: true,
                    mostrarParticipantes: false,

                    fnGuardar, fnEditar, ejecutarFunciones
                }
            }, watch: {
                curso(valorSeleccionado){
                    const valor = valorSeleccionado;
                    console.log(valor);
                    this.ejecutarFunciones();
                    
                }
            }
            
            
        });

        Vue.config.devtools = true;
</script>
</html>