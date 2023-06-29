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
                                    <v-col md=5>
                                        <v-data-table
                                            :headers="headersGrupos"
                                            :items="dataGrupos"
                                            class="elevation-2"
                                            no-data-text="No se encontro ningun registro"
                                            :hide-default-header="dataGrupos.length < 1"
                                            :hide-default-footer="dataGrupos.length < 1"
                                            locale="es-ES"
                                            :mobile-breakpoint="NaN"
                                            items-per-page="10"
                                        >
                                            <template v-slot:item.ingresar="{ item }">
                                                            
                                                <v-icon color="green" @click="fnObtener(item); fnLlenar()">mdi-arrow-right</v-icon>
                                            
                                            </template>
                                        </v-data-table>

                                    </v-col>
                                </template>

                                <template>
                                    <v-col md=5>
                                        <v-data-table
                                            :headers="headersParticipantes"
                                            :items="dataParticipantes"
                                            class="elevation-2"
                                            no-data-text="No se encontro ningun registro"
                                            :hide-default-header="dataParticipantes.length < 1"
                                            :hide-default-footer="dataParticipantes.length < 1"
                                            locale="es-ES"
                                            :mobile-breakpoint="NaN"
                                            items-per-page="10"
                                        >

                                            <template v-slot:item.calificacion="{ item }">
                                                                
                                                <v-text-field outlined persistent-hint></v-text-field>
                                            
                                            </template>
                                        </v-data-table>
                                    </v-col>
                                </template>

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
                
                       

                //Otras variables
                const flagEditar = ref(false);
                const itemEditar = ref({});
                //Setup del calendario
               
                //Setup de inputs


                //SNACKBAR
                const loader = ref(false);
                const snackbar = ref(false);
                const mensaje_snackbar = ref('');
                const color_snackbar = ref('');
                //Loaders
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
                    {text: 'Número de control', align: 'left', sortable: true, value: 'cve_empleado'},
                    {text: 'Nombre', align: 'left', sortable: true, value: 'nombre'},
                    {text: 'Calificación final', align: 'left', sortable: true, value: 'calificacion'},
                ]);
                const dataParticipantes = ref([]);
                
                

                onMounted(() => {
                    fnConsultarTabla();
                    
                });

                function fnObtener(grupo) {
                   
                    const arregloGrupo = Object.values(grupo);
                    console.log('Arreglo del grupo:', arregloGrupo);
                    console.log('id evento:', arregloGrupo[0]);
                    this.cve = arregloGrupo[0];
                    
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

            
                function mostrarSnackbar(color, texto){
                    snackbar.value = true;
                    color_snackbar.value = color;
                    if(color=="error")
                        mensaje_snackbar.value = "Ocurrió un error. Intentalo de nuevo más tarde.";
                    else
                        mensaje_snackbar.value = texto; 
                }

                return{
                    color_snackbar, snackbar, mensaje_snackbar, loader, mostrarSnackbar, flagEditar,

                   
                    dataGrupos, headersGrupos, dataParticipantes, headersParticipantes, cve:'',
                    dialogBuscador, dialogDetallesCotizacion, dialogProveedor,
                    fnConsultarTabla, fnObtener, fnLlenar, itemEditar
                }
            },
        });

        Vue.config.devtools = true;
</script>
</html>