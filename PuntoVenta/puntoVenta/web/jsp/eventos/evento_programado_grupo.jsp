<%@page contentType="text/html; charset=UTF-8" language="java" errorPage="" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900" rel="stylesheet">
        <link href="../../styles/icon_material_design_4495/css/materialdesignicons.min.css" rel="stylesheet">
        <link href="../../javascript/VueJs/sweetalert2/sweetalert2.css" />
        <link href="../../javascript/VueJs/vuetify/vuetify.min.css" rel="stylesheet">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
        <script src="../../javascript/VueJs/vue/vue.js"></script>
        <script type="" src="../../javascript/VueJs/vue/vue-composition-api.prod.js" ></script>
        <title>JSP Page</title>
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
                        <v-card-title  style="background-color: #00b293; color:#ffffff; headline" >		
                            Evento programado en grupo
                        </v-card-title>
                        <v-container fluid>
                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                <!--Columna-->
                                <v-col md="12">
                                    <v-card-title  style="background-color: #00b293; color:#ffffff; headline" >		
                                        Eventos programados
                                    </v-card-title>

                                    <v-data-table
                                    :headers="headersProveedores"
                                    :items="dataProveedores"
                                    :search="search"
                                    class="elevation-1"
                                    :sort-by="['nombre_origen', 'fat']"
                                    :sort-desc="[true, true]"
                                  >
                                    <template v-slot:item.horario="{ item }">
                                      {{ item.horario_inicio.substring(0, 5) }} - {{ item.horario_fin.substring(0, 5) }}
                                    </template>
                                    <template v-slot:item.fecha="{ item }">
                                        {{ item.fecha_inicio_dia_mes_anio | formatDate }} - {{ item.fecha_fin_dia_mes_anio | formatDate }}
                                      </template>
                                    <template v-slot:item.select="{ item }">
                                        <v-icon @click="checkbox(item)">mdi-calendar-clock</v-icon>
                                      </template>
                                  </v-data-table>

                                </v-col>
                                

                            </v-row>
                                    <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                        <v-col md="12">
                                        <v-card-title  style="background-color: #00b293; color:#ffffff; headline" >		
                                            Eventos a los que asistiré
                                        </v-card-title>
                                    <v-data-table
                                      :headers="headersAsistencia"
                                      :items="dataAsistencia"
                                      class="elevation-1"
                                    >
                                    <template v-slot:item.eliminar="{item}">
                                        <v-btn fab small color="error" @click="fnEliminar(item);"><v-icon>mdi-trash-can</v-icon></v-btn>
                                    </template>
                                    <template v-slot:item.horario="{ item }">
                                        {{ item.horario_inicio.substring(0, 5) }} - {{ item.horario_fin.substring(0, 5) }}
                                      </template>
                                      <template v-slot:item.fecha="{ item }">
                                        {{ item.fecha_inicio_dia_mes_anio }} - {{ item.fecha_fin_dia_mes_anio }}
                                      </template>
                                      <template v-slot:item.select="{ item }">
                                          <v-icon @click="checkbox(item)">mdi-calendar-clock</v-icon>
                                        </template>
                                    </v-data-table>
                                  </v-col>
                                
                                

                                
                            </v-row>

                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px"> 

                                
                                
                            </v-row>
                            <%-- <v-row justfy="center" dense >
                            </v-row> --%>
                            
                            <v-divider></v-divider>
                           

                            <v-row justify="center" hidden>
                                <v-btn color="primary" @click="flagEditar ? fnEditar() : fnGuardar()"><v-icon>mdi-content-save</v-icon>{{flagEditar ? 'Editar' : 'Guardar'}}</v-btn>
                                &nbsp;
                                <v-btn color="error" @click="fnLimpiarCampos()"><v-icon>mdi-cancel</v-icon>Cancelar</v-btn>
                            </v-row>
                            
                            
                        </v-container>
                    </v-card>
                </v-container>
                <%-- <v-dialog v-model="dialogBuscador" width="70%" scrollable transition="dialog-bottom-transition">
                    <v-card>
                        <v-card-title class="text-h5 grey lighten-2">
                            Búsqueda Avanzada
                        </v-card-title>
                        <v-card-text>
                            <v-row justify="center">
                                <v-col md=8>
                                    <v-text-field outlined label="Nombre" v-model="nombreBuscar" @keyup.enter="fnBusquedaNombre()"></v-text-field>
                                </v-col>
                            </v-row>
                            <v-row justify="center">
                                <v-col md=4 offset-md=8>
                                    <v-text-field label="Filtrar" v-model="searchBusqueda"></v-text-field>
                                </v-col>
                            </v-row>

                            <v-row justify="center">
                                <v-col md=12>
                                    <v-data-table
                                        :headers="headersEventos"
                                        :items="selectedProveedores"
                                        class="elevation-1"
                                        ></v-data-table>
                                </v-col>
                            </v-row>
                        </v-card-text>
                        <v-divider></v-divider>
                        <v-card-actions>
                            <v-spacer></v-spacer>
                            <v-btn
                                color="primary"
                                text
                                @click="dialogBuscador = false"
                            >
                                Cerrar
                            </v-btn>
                        </v-card-actions>
                    </v-card>
                </v-dialog> --%>
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
                const ctr = "../../controlador/eventos/Controlador_evento_programado_grupo.jsp";
                //Variables primera tabla
                const singleSelect = ref("");
                const tableSelected = ref("");


                //pruebas
                const search = ref("");
                const selectedProveedores = ref([]);

                //Otras variables
                const flagEditar = ref(false);
                const itemEditar = ref({});
                //Setup del calendario
                const arrayTiposUsuario = ref([]);
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
                //dataUsuarios
                const dataProveedores = ref([]); 
                const dataAsistencia = ref([]);
                const dataUsuarios = ref([]);

                const headersAsistencia = ref([
                    {text: 'Nombre evento', align: 'left', sortable: true, value: 'nombre_evento'},
                    {text: 'Nombre origen', align: 'left', sortable: true, value: 'nombre_origen'},
                    { text: 'Nombre del instructor', align: 'left', sortable: true, value: 'nombre_instructor' },
                    { text: 'Horario', align: 'left', sortable: true, value: 'horario' },
                    { text: 'Fecha', align: 'left', sortable: true, value: 'fecha' },
                    {text: 'Eliminar', align: 'left', sortable: true, value: 'eliminar'},
                 ]);

                
                const headersProveedores = ref([
                    { text: 'Nombre del evento', align: 'left', sortable: true, value: 'nombre_evento' },
                    { text: 'Nombre origen', align: 'left', sortable: true, value: 'nombre_origen' },
                    { text: 'Nombre del instructor', align: 'left', sortable: true, value: 'nombre_instructor' },
                    { text: 'Horario', align: 'left', sortable: true, value: 'horario' },
                    { text: 'Fecha', align: 'left', sortable: true, value: 'fecha' },
                    { text: 'Programar', align: 'left', sortable: false, value: 'select' },
                ]);
                const searchProveedores = ref([]);

                //Accion automatizada para mostrar la tabla
                onMounted(() => {
                    fnConsultarTabla();
                    fnConsultarTablaAsistencia();
                });

                function moveSelectedProveedores() {
                    const selected = dataProveedores.value.filter((proveedor) => proveedor.selected);
                    selectedProveedores.value.push(...selected);
                    dataProveedores.value = dataProveedores.value.filter((proveedor) => !proveedor.selected);
                    selected.forEach((proveedor) => {
                        proveedor.selected = false;
                    });
                }

                async function fnTiposUsuario(){
                    try{
                        preloader("../../");
                        let parametros = new URLSearchParams();
                        parametros.append("accion", 3);
                        let {data,status} = await axios.post(ctr, parametros)
                        if(status == 200){
                            if(data.length > 0){
                                arrayTiposUsuario.value = data
                            }
                        }
                    } catch(error){
                        mostrarSnackbar('error');
                        console.error(error);
                    } finally{
                        swal.close();
                    }
                }
                
                async function fnConsultarTablaAsistencia(){
                    try{
                        preloader("../../");
                        //arreglo
                        let parametros = new URLSearchParams();
                        //le mandamos un parametro llamado accion
                        parametros.append("accion", 3);
                        //axios envia la peticion
                        let {data,status} = await axios.post(ctr, parametros)
                        if(status == 200){
                            if(data.length > 0){

                                dataAsistencia.value = data
                            }
                        }
                    } catch(error){
                        mostrarSnackbar('error');
                        console.error(error);
                    } finally{
                        swal.close();
                    }
                }

                async function fnConsultarTabla(){
                    try{
                        preloader("../../");
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

                async function checkbox(item){
                    this.$validator.validate().then(async esValido => {
                        if(esValido){
                            try{
                                preloader("../../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 2);
                                parametros.append("cve_even_prog", item.cve_even_prog);
                                let {data,status} = await axios.post(ctr, parametros)
                                if(status == 200){
                                    if(data == "1"){
                                        mostrarSnackbar("success", "Registro guardado correctamente.");
                                        fnConsultarTabla();
                                        fnConsultarTablaAsistencia();
                                        // this.$validator.pause();
                                        // Vue.nextTick(() => {
                                        //     this.$validator.errors.clear();
                                        //     this.$validator.resume();
                                        // });   
                                    }if(data == "0"){
                                        mostrarSnackbar("errord", "Ya cuentas con un registro similar");
                                        
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

                async function fnGuardar(){
                    this.$validator.validate().then(async esValido => {
                        if(esValido){
                            try{
                                preloader("../../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 2);
                                parametros.append("tipo", tipo.value);
                                parametros.append("nombreUsuario", nombreUsuario.value);
                                parametros.append("fecha", fecha.value);
                                let {data,status} = await axios.post(ctr, parametros)
                                if(status == 200){
                                    if(data == "1"){
                                        mostrarSnackbar("success", "Registro guardado correctamente.");
                                        fnConsultarTabla();
                                        fnConsultarTablaAsistencia();
                                        // this.$validator.pause();
                                        // Vue.nextTick(() => {
                                        //     this.$validator.errors.clear();
                                        //     this.$validator.resume();
                                        // });   
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

               
                async function fnEliminar(item){
                    confirmarE("¿Realmente quieres eliminar éste registro?").then(async (result) => {
                        if(result.isConfirmed){
                            try{
                                preloader("../../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 4);
                                parametros.append("cve_even_prog_grupo", item.cve_even_prog_grupo);
                                let {data,status} = await axios.post(ctr, parametros)
                                if(status == 200){
                                    if(data=="1"){
                                        fnConsultarTabla();
                                        fnConsultarTablaAsistencia();
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

               

                function mostrarSnackbar(color, texto){
                    snackbar.value = true;
                    color_snackbar.value = color;
                    if(color=="error")
                        mensaje_snackbar.value = "Ocurrió un error. Intentalo de nuevo más tarde.";
                    else if(color=="errord")
                        mensaje_snackbar.value = "Ya cuentas con un registro similar";
                    else
                        mensaje_snackbar.value = texto; 
                }

                return{
                    color_snackbar, snackbar, mensaje_snackbar, loader, mostrarSnackbar, flagEditar,
                    tableSelected, singleSelect, selectedProveedores, checkbox, dataAsistencia, search,
                    dataProveedores, headersProveedores, headersAsistencia, searchProveedores, arrayTiposUsuario, 
                    dialogBuscador, dialogDetallesCotizacion, dialogProveedor, moveSelectedProveedores,
                    fnConsultarTabla, fnGuardar, fnEliminar, itemEditar
                }
            },
            
        });

        Vue.config.devtools = true;
</script>
</html>