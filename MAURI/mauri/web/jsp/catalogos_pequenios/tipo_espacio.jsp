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
                            Catalogos tipo
                        </v-card-title>
                        <v-container fluid>
                            
                            <v-row justfy="center" dense >
                                <v-col class="text-center"><b>Tipo de espacio</b></v-col>
                            </v-row>

                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                <v-col md=2>
                                        <v-text-field 
                                            v-model="nombreTipoEspacio" 
                                            outlined label="Nombre espacio" 
                                            persistent-hint
                                            v-validate="'required|max:200'" 
                                            data-vv-name="nombre tipo espacio"
                                            :error="errors.has('nombre tipo espacio')"
                                            :error-messages="errors.first('nombre espacio servicio')"></v-text-field>
                                    </v-col>
                                </v-col>
                                <v-row justify="center">
                                    <v-btn color="primary" @click="flagEditar ? fnEditar() : fnGuardarTipoEspacio()"><v-icon>mdi-content-save</v-icon>{{flagEditar ? 'Editar' : 'Guardar'}}</v-btn>
                                    &nbsp;
                                    <v-btn color="error" @click="fnLimpiarCampos()"><v-icon>mdi-cancel</v-icon>Cancelar</v-btn>
                                </v-row>
                            </v-row>
                            <!-- Tabla tipo espacio -->
                            <v-row justify="center">
                                <v-col md=12>
                                    <v-data-table
                                        :headers="headersTipoEspacio"
                                        :items="dataTipoEspacio"
                                        :search="searchTipos"
                                        class="elevation-2"
                                        no-data-text="No se encontro ningun registro"
                                        :hide-default-header="dataTipoEspacio.length < 1"
                                        :hide-default-footer="dataTipoEspacio.length < 1"
                                        locale="es-ES"
                                        :mobile-breakpoint="NaN"
                                        items-per-page="10"
                                    >
                                    <template v-slot:item.activo="{item}">
                                        <v-container class="px-0" fluid>
                                            <v-switch v-model="item.activo" @change="fnEliminarEspacio(item)"></v-switch>
                                        </v-container>
                                    </template>
                                    </v-data-table>
                                </v-col>
                            
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
                                        :headers="headersBusqueda"
                                        :items="dataBusqueda"
                                        :search="searchBusqueda"
                                        class="elevation-2"
                                        no-data-text="No se encontro ningun registro"
                                        :hide-default-header="dataBusqueda.length < 1"
                                        :hide-default-footer="dataBusqueda.length < 1"
                                        locale="es-ES"
                                        :mobile-breakpoint="NaN"
                                        items-per-page="10"
                                        @click:row="seleccionarUsuario"
                                    >
                                    </v-data-table>
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
                const ctr = "../../controlador/catalogos_pequenios/Controlador_tipo_espacio.jsp";
                //Variables POST
                
                const nombreTipoEspacio = ref("");
                
                //Otras variables
                const flagEditar = ref(false);
                const itemEditar = ref({});
                
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
                const dataTipoEspacio = ref([]);

                const headersTipoEspacio = ref([
                    {text: 'No', align: 'left', sortable: true, value: 'cve_tipo_espacio'},
                    {text: 'Nombre espacio', align: 'left', sortable: true, value: 'nombre_tipo_espacio'},
                    {text: 'Fecha de registro', align: 'left', sortable: true, value: 'fecha_registro'},
                    {text: 'Eliminar', align: 'left', sortable: true, value: 'activo'},
                ]);
                const searchProveedores = ref([]);
                const searchTipos = ref([]);

                onMounted(() => {
                    fnConsultarTablaTipoEspacio();
                    
                });
                
               async function fnConsultarTablaTipoEspacio(){
                    try{
                        preloader("../../");
                        let parametros = new URLSearchParams();
                        parametros.append("accion", 1);
                        let {data,status} = await axios.post(ctr, parametros)
                        if(status == 200){
                            if(data.length > 0){

                                dataTipoEspacio.value = data
                            }
                        }
                    } catch(error){
                        mostrarSnackbar('error');
                        console.error(error);
                    } finally{
                        swal.close();
                    }
               }

                async function fnGuardarTipoEspacio(){
                    this.$validator.validate().then(async esValido => {
                        if(esValido){
                            try{
                                preloader("../../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 2);
                                parametros.append("nombre_tipo_espacio", nombreTipoEspacio.value);
                                let {data,status} = await axios.post(ctr, parametros)
                                if(status == 200){
                                    if(data == "1"){
                                        mostrarSnackbar("success", "Registro guardado correctamente.");
                                        fnConsultarTablaTipoEspacio();
                                        fnLimpiarCampos(this);
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

              async function fnEliminarEspacio(item){
                            try{
                                preloader("../../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 3);
                                parametros.append("activo", (item.activo == true ? 1 : 0));
                                parametros.append("cve_tipo_espacio", item.cve_tipo_espacio);
                                let {data,status} = await axios.post(ctr, parametros)
                                if(status == 200){
                                    if(data=="1"){
                                        fnConsultarTablaTipoEspacio();
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
                    nombreTipoEspacio.value = "";
                    
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
                    if(color=="error")
                        mensaje_snackbar.value = "Ocurrió un error. Intentalo de nuevo más tarde.";
                    else
                        mensaje_snackbar.value = texto; 
                }

                return{
                    color_snackbar, snackbar, mensaje_snackbar, loader, mostrarSnackbar, flagEditar,
                    nombreTipoEspacio, dataTipoEspacio, headersTipoEspacio, fnConsultarTablaTipoEspacio, fnLimpiarCampos,
                    fnGuardarTipoEspacio, fnEliminarEspacio,searchTipos,
                    dialogBuscador, dialogDetallesCotizacion, dialogProveedor,
                    
                    //fnConsultarTabla, fnGuardar, fnLimpiarCampos, fnEditar, fnEliminar, itemEditar
                }
            },
            
        });

        Vue.config.devtools = true;
</script>
</html>