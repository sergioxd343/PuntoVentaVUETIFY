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
                            Orientación
                        </v-card-title>
                        <v-container fluid>
                            
                            

                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                
                                <v-col md=3>
                                    <v-select 
                                        v-model="tipoInstructor"
                                        outlined
                                        label="Tipo de instructor:"
                                        v-validate="'required'"
                                        :items="arrayTipoInstructor"
                                        item-value="cve_tipo_instructor"
                                        item-text="nombre_tipo_instructor"
                                        data-vv-name="tipoInstructor"
                                        :error="errors.has('tipoInstructor')"
                                        :error-messages="errors.first('tipoInstructor')"
                                    ></v-select>
                                </v-col>
                                
                                <v-col md=4 >
                                    <v-text-field 
                                        v-model="nombreInstructor" 
                                        label="Nombre del instructor:" 
                                        persistent-hint
                                        hint="Ingresa el nombre del instructor"
                                        v-validate="'required|max:200'" 
                                        data-vv-name="nombre instructor"
                                        :error="errors.has('nombre instructor')"
                                        :error-messages="errors.first('nombre instructor')"
                                        :disabled="tipoInstructor === 1"></v-text-field>
                                </v-col>

                                <v-col md=3>
                                    <v-select 
                                        v-model="areaAcademica"
                                        outlined
                                        label="Area academica:"
                                        v-validate="'required'"
                                        :items="arrayAreaAcademica"
                                        item-value="nombre_area"
                                        item-text="nombre_area"
                                        data-vv-name="areaAcademica"
                                        :error="errors.has('areaAcademica')"
                                        :error-messages="errors.first('areaAcademica')"
                                    ></v-select>
                                </v-col>
                                <v-row justify="center" class="align-center">
                                <v-col md=6 v-if="tipoInstructor === 1">
                                    <span style="color: red">Da click en el registro que desean elegir</span>
                                    <v-data-table
                                        :headers="headersEmpleados"
                                        :items="dataEmpleados"
                                        persistent-hint
                                        hint="Ingresa el nombre del instructor"
                                        class="elevation-1"
                                        no-data-text="No se encontro ningun registro"
                                        :hide-default-header="dataEmpleados.length < 1"
                                        :hide-default-footer="dataEmpleados.length < 1"
                                        locale="es-ES"
                                        :mobile-breakpoint="NaN"
                                        items-per-page="10"
                                        @click:row="selectRow"
                                    >
                                    </v-data-table>
                                </v-col>

                                
                                    <v-btn color="primary" @click="flagEditar ? fnEditar() : fnGuardarInstructor()"><v-icon>mdi-content-save</v-icon>{{flagEditar ? 'Editar' : 'Guardar'}}</v-btn>
                                    &nbsp;
                                    <v-btn color="error" @click="fnLimpiarCampos()"><v-icon>mdi-cancel</v-icon>Cancelar</v-btn>
                                </v-row>
                               
                            </v-row>

                            

                            <!-- Tabla tipo orieentación -->
                            <v-row justify="center">
                                <v-col md=12>
                                    <v-data-table
                                        :headers="headersInstructor"
                                        :items="dataInstructor"
                                        :search="searchTipos"
                                        class="elevation-1"
                                        no-data-text="No se encontro ningun registro"
                                        :hide-default-header="dataInstructor.length < 1"
                                        :hide-default-footer="dataInstructor.length < 1"
                                        locale="es-ES"
                                        :mobile-breakpoint="NaN"
                                        items-per-page="10"
                                        
                                    >
                                    <template v-slot:item.estatus="{item}">
                                        <v-chip style="width: 75px; justify-content: center;" class="ma-2" link @click="fnCambiarEstatus(item)"
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
                const ctr = "../../controlador/catalogos_pequenios/Controlador_instructor.jsp";
                //Variables POST
            
                const nombreInstructor = ref("");
                const tipoInstructor = ref("");
                const areaAcademica = ref("");
                const instructorInterno = ref("");
                

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
                
                const dataInstructor = ref([]);
                const dataEmpleados = ref([]);
                const arrayAreaAcademica = ref([]);
                const arrayTipoInstructor = ref([]);
                const arrayInstructorInterno = ref([]);
                
                const headersInstructor = ref([
                    {text: 'No', align: 'left', sortable: true, value: 'cve_instructor'},
                    {text: 'Nombre del instructor', align: 'left', sortable: true, value: 'nombre_instructor'},
                    {text: 'Area academica', align: 'left', sortable: true, value: 'area_academica'},
                    {text: 'Programa educativo', align: 'left', sortable: true, value: 'programa_educativo'},
                    {text: 'Fecha de registro', align: 'left', sortable: true, value: 'fecha_registro'},
                    {text: 'Estatus', align: 'left', sortable: true, value: 'estatus'},
                ]);

                const headersEmpleados = ref([
                    {text: 'No', align: 'left', sortable: true, value: 'cve_empleado'},
                    {text: 'Nombre', align: 'left', sortable: true, value: 'nombre'},
                    {text: 'Apellio Paterno', align: 'left', sortable: true, value: 'apellido_peterno'},
                    {text: 'Apellido materno', align: 'left', sortable: true, value: 'apellido_materno'},
                    {text: 'Puesto', align: 'left', sortable: true, value: 'nombre_puesto'},
                ]);
                
                const searchProveedores = ref([]);
                const searchTipos = ref([]);
                
                onMounted(() => {
                    fnConsultarInstructor();
                    fnTipoInstructor();
                    fnAreaAcademia();
                    fnConsultarEmpleado();
                    
                });
                async function selectRow(item) {
                 this.nombreInstructor = item.nombre;
                 this.nombreInstructor = item.nombre;
                 console.log(dataEmpleados)
                    }
                async function fnConsultarInstructor(){
                    try{
                        preloader("../../");
                        let parametros = new URLSearchParams();
                        parametros.append("accion", 1);
                        let {data,status} = await axios.post(ctr, parametros)
                        if(status == 200){
                            if(data.length > 0){

                                dataInstructor.value = data
                            }
                        }
                    } catch(error){
                        mostrarSnackbar('error');
                        console.error(error);
                    } finally{
                        swal.close();
                    }
               }
               async function fnConsultarEmpleado(){
                    try{
                        preloader("../../");
                        let parametros = new URLSearchParams();
                        parametros.append("accion", 6);
                        let {data,status} = await axios.post(ctr, parametros)
                        if(status == 200){
                            if(data.length > 0){

                                dataEmpleados.value = data
                            }
                        }
                    } catch(error){
                        mostrarSnackbar('error');
                        console.error(error);
                    } finally{
                        swal.close();
                    }
               }
               async function fnNombreEmpelado(){
                    try{
                        preloader("../../");
                        let parametros = new URLSearchParams();
                        parametros.append("accion", 7);
                        let {data,status} = await axios.post(ctr, parametros)
                        if(status == 200){
                            if(data.length > 0){

                                nombreInstructor.value = data
                            }
                        }
                    } catch(error){
                        mostrarSnackbar('error');
                        console.error(error);
                    } finally{
                        swal.close();
                    }
               }
               
               async function fnGuardarInstructor(){
                    this.$validator.validate().then(async esValido => {
                        if(esValido){
                            try{
                                preloader("../../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 2);
                                parametros.append("cve_tipo_instructor", tipoInstructor.value);
                                parametros.append("nombre_instructor", nombreInstructor.value);
                                parametros.append("area_academica", areaAcademica.value);
                                parametros.append("cve_persona",this.usuario_registro); // Agrega el valor de cve_persona
                                let {data,status} = await axios.post(ctr, parametros)
                                if(status == 200){
                                    if(data == "1"){
                                        mostrarSnackbar("success", "Registro guardado correctamente.");
                                        fnConsultarInstructor();
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
                            parametros.append("cve_instructor", item.cve_instructor);
                            parametros.append("activo", (item.activo == true ? 0 : 1));
                            console.log("🚀 ~ file: instructor.jsp:283 ~ fnCambiarEstatus ~ parametros:", parametros)
                            let { data, status } = await axios.post(ctr, parametros);
                            if (status == 200) {
                                if (data == "1") {
                                    mostrarSnackbar(
                                        "success",
                                        "Registro actualizado correctamente."
                                    );
                                    fnConsultarInstructor();
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
                    
                    async function fnTipoInstructor() {
                            try {
                                preloader("../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 4); // arreglo que se manda 
                                let { data, status } = await axios.post(ctr, parametros) // axios hace peticion y manda a la ruta los parametros por POST
                                if (status == 200) { // si es 200 encontro informacion 
                                    if (data.length > 0) {
                                        arrayTipoInstructor.value = data // llena los datos del dataTable
                                    }
                                }
                            } catch (error) {
                                mostrarSnackbar('error');
                                console.error(error);
                            } finally {
                                swal.close();
                            }
                        }

                        async function fnAreaAcademia() {
                            try {
                                preloader("../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 5); // arreglo que se manda 
                                let { data, status } = await axios.post(ctr, parametros) // axios hace peticion y manda a la ruta los parametros por POST
                                if (status == 200) { // si es 200 encontro informacion 
                                    if (data.length > 0) {
                                        arrayAreaAcademica.value = data // llena los datos del dataTable
                                    }
                                }
                            } catch (error) {
                                mostrarSnackbar('error');
                                console.error(error);
                            } finally {
                                swal.close();
                            }
                        }

                function fnLimpiarCampos(cx){//cx = contexto
                    tipoInstructor.value = "";                    
                    areaAcademica.value = "";                    
                    nombreInstructor.value = "";                    
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
                    nombreInstructor, tipoInstructor, currentUser, currentUserObj, usuario_registro,
                    headersInstructor, fnConsultarInstructor, dataInstructor, areaAcademica,
                    searchTipos, fnLimpiarCampos, fnGuardarInstructor, fnCambiarEstatus, arrayTipoInstructor,
                    arrayAreaAcademica, fnAreaAcademia, fnTipoInstructor, instructorInterno, arrayInstructorInterno, selectRow,
                    dialogBuscador, dialogDetallesCotizacion, dialogProveedor, headersEmpleados, dataEmpleados,
                    
                    //fnConsultarTabla, fnGuardar, fnLimpiarCampos, fnEditar, fnEliminar, itemEditar
                }
            },
            
        });

        Vue.config.devtools = true;
</script>
</html>