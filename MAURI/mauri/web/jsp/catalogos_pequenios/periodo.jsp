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
        .custom-switch .v-input--selection-controls__input {
  
  
  margin: 0px;
  padding: 0px;
  
}
    </style>
    <body>
        <div id="app">
            <v-app>
                <v-container fluid>
                    <v-card>
                        <v-card-title  style="background-color: #00b293; color:#ffffff; headline" >		
                            Periodo
                        </v-card-title>
                        <v-container fluid>

                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                                
                                
                                <v-col cols="12" sm="6" md="3">
                                    <v-menu 
                                            ref="menu1"  
                                            :close-on-content-click="false"
                                            :return-value.sync="fechaInicio" 
                                            transition="scale-transition" 
                                            offset-y min-width="auto">
                                        <template v-slot:activator="{ on, attrs }">
                                            <v-text-field v-model="fechaInicio" label="Fecha de inicio" prepend-icon="mdi-calendar"
                                                readonly v-bind="attrs" v-on="on"></v-text-field>
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
                                <v-col cols="12" sm="6" md="3">
                                    <v-menu 
                                            ref="menu2"  
                                            :close-on-content-click="false"
                                            :return-value.sync="fechaFin" 
                                            transition="scale-transition" 
                                            offset-y min-width="auto">
                                        <template v-slot:activator="{ on, attrs }">
                                            <v-text-field v-model="fechaFin" label="Fecha de fin" prepend-icon="mdi-calendar"
                                                readonly v-bind="attrs" v-on="on"></v-text-field>
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

                                <v-col md=3>

                                    <v-textarea
                                        v-model="descripcion"  
                                        persistent-hint
                                        v-validate="'required|max:200'" 
                                        data-vv-name="descripcion"
                                        :error="errors.has('descripcion')"
                                        :error-messages="errors.first('descripcion')"
                                        class="mx-2"
                                        label="Descripción:"
                                        rows="1"
                                    ></v-textarea>
                                </v-col>

                                <v-col md=3 >
                                    <v-radio-group
                                        v-model="numeroPeriodo"
                                        label="Numero de periodo"
                                        v-validate="'required'"
                                        data-vv-name="numeroPeriodo"
                                        :error="errors.has('numeroPeriodo')"
                                        :error-messages="errors.first('numeroPeriodo')"
                                    >
                                        <v-radio
                                            label="1. Enero-Abril"
                                            value=1
                                        ></v-radio>
                                        <v-radio
                                            label="2. Mayo-Agosto"
                                            value=2
                                        ></v-radio>
                                        <v-radio
                                            label="3. Septiembre-Diciembre"
                                            value=3
                                        ></v-radio>
                                    </v-radio-group>
                                </v-col>

                                <v-row justify="center">
                                    <v-btn color="primary" @click="flagEditar ? fnEditar() : fnGuardarPeriodo()"><v-icon>mdi-content-save</v-icon>{{flagEditar ? 'Editar' : 'Guardar'}}</v-btn>
                                    &nbsp;
                                    <v-btn color="error" @click="fnLimpiarCampos()"><v-icon>mdi-cancel</v-icon>Cancelar</v-btn>
                                </v-row>
                               
                            </v-row>
                            <!-- Tabla tipo orieentación -->
                            <v-row justify="center">
                                <v-col md=12>
                                    <v-data-table
                                        :headers="headersPeriodo"
                                        :items="dataPeriodo"
                                        :search="searchTipos"
                                        class="elevation-1"
                                        no-data-text="No se encontro ningun registro"
                                        :hide-default-header="dataPeriodo.length < 1"
                                        :hide-default-footer="dataPeriodo.length < 1"
                                        locale="es-ES"
                                        :mobile-breakpoint="NaN"
                                        items-per-page="10"
                                    >
                                    <template v-slot:item.estatus="{item}">
                                        <v-chip class="ma-2" link @click="fnCambiarEstatus(item)"
                                            :color="item.activo ? 'success' : 'grey'" outlined>
                                            {{ item.activo ?
                                            "Activo" : "Inactivo" }}
                                        </v-chip>
                                    </template>
                                    </v-data-table>
                                </v-col>
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
                const ctr = "../../controlador/catalogos_pequenios/Controlador_periodo.jsp";
                //Variables POST
            
                const fechaInicio = ref("");
                const fechaFin = ref("");
                const numeroPeriodo = ref("");
                const descripcion = ref("");
                const currentUser = localStorage.getItem("currentUser");
                const currentUserObj = JSON.parse(currentUser);
                const usuario_registro = currentUserObj[0].cve_persona;
                //Otras variables
                const flagEditar = ref(false);
                const itemEditar = ref({});
                //Setup del calendario
                
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
                
                const dataPeriodo = ref([]);
                
                const headersPeriodo = ref([
                    {text: 'No', align: 'left', sortable: true, value: 'cve_periodo'},
                    {text: 'Fecha de inicio', align: 'left', sortable: true, value: 'fecha_inicio'},
                    {text: 'Fecha de fin', align: 'left', sortable: true, value: 'fecha_fin'},
                    {text: 'Numero de periodo', align: 'left', sortable: true, value: 'numero_periodo'},
                    {text: 'Descripción', align: 'left', sortable: true, value: 'descripcion'},
                    {text: 'Estatus', align: 'left', sortable: true, value: 'estatus'},
                ]);
                
                const searchProveedores = ref([]);
                const searchTipos = ref([]);

                onMounted(() => {
                    fnConsultarTablaPeriodo();
                    
                });
                
                async function fnConsultarTablaPeriodo(){
                    try{
                        preloader("../../");
                        let parametros = new URLSearchParams();
                        parametros.append("accion", 1);
                        let {data,status} = await axios.post(ctr, parametros)
                        if(status == 200){
                            if(data.length > 0){

                                dataPeriodo.value = data
                            }
                        }
                    } catch(error){
                        mostrarSnackbar('error');
                        console.error(error);
                    } finally{
                        swal.close();
                    }
               }
               
               async function fnGuardarPeriodo(){
                    this.$validator.validate().then(async esValido => {
                        if(esValido){
                            try{
                                preloader("../../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 2);
                                parametros.append("fecha_inicio", fechaInicio.value);
                                parametros.append("fecha_fin", fechaFin.value);
                                parametros.append("numero_periodo", numeroPeriodo.value);
                                parametros.append("descripcion", descripcion.value);
                                parametros.append("cve_persona", this.usuario_registro);
                                let {data,status} = await axios.post(ctr, parametros)
                                if(status == 200){
                                    if(data == "1"){
                                        mostrarSnackbar("success", "Registro guardado correctamente.");
                                        fnConsultarTablaPeriodo();
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
             
                async function fnCambiarEstatus(item) {
                        try {
                            preloader("../");
                            let parametros = new URLSearchParams();
                            parametros.append("accion", 3);
                            parametros.append("cve_periodo", item.cve_periodo);
                            parametros.append("activo", (item.activo == true ? 0 : 1));
                            console.log("🚀 ~ file: periodo.jsp:283 ~ fnCambiarEstatus ~ parametros:", parametros)
                            let { data, status } = await axios.post(ctr, parametros);
                            if (status == 200) {
                                if (data == "1") {
                                    mostrarSnackbar(
                                        "success",
                                        "Registro actualizado correctamente."
                                    );
                                    fnConsultarTablaPeriodo();
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

                function fnLimpiarCampos(cx){//cx = contexto
                    fechaInicio.value = "";
                    fechaFin.value = "";                    
                    numeroPeriodo.value = "";
                    descripcion.value = "";

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
                    fechaInicio, fechaFin, numeroPeriodo, descripcion, currentUser, currentUserObj,
                    headersPeriodo, fnConsultarTablaPeriodo, dataPeriodo, usuario_registro,
                    searchTipos, fnLimpiarCampos, fnGuardarPeriodo, fnCambiarEstatus ,
                    dialogBuscador, dialogDetallesCotizacion, dialogProveedor, 
                    
                    //fnConsultarTabla, fnGuardar, fnLimpiarCampos, fnEditar, fnEliminar, itemEditar
                }
            },
            
        });

        Vue.config.devtools = true;
</script>
</html>