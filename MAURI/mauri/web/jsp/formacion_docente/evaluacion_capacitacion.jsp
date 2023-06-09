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
                            Evaluación de capacitación
                        </v-card-title>
                        <v-container fluid>
                            
                            <v-row justfy="center" dense >
                                <v-col class="text-center"><b>Datos sobre la capacitación </b></v-col>
                            </v-row>

                            <v-row justify="" class="align-center" style="padding: 0px 50px 0px 50px">
                                <v-col md=4>
                                    <v-text-field 
                                        v-model="nombreCurso" 
                                        outlined label="Nombre del curso" 
                                        persistent-hint
                                        v-validate="'required|max:200'" 
                                        data-vv-name="nombre curso"
                                        :error="errors.has('nombre curso')"
                                        :error-messages="errors.first('nombre curso')"></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="3">
                                    <v-menu 
                                            ref="menu"  
                                            :close-on-content-click="false"
                                            :return-value.sync="fecha" 
                                            transition="scale-transition" 
                                            offset-y min-width="auto">
                                        <template v-slot:activator="{ on, attrs }">
                                            <v-text-field v-model="fecha" label="Fecha" prepend-icon="mdi-calendar"
                                                readonly v-bind="attrs" v-on="on"></v-text-field>
                                        </template>
                                        <v-date-picker v-model="fecha" no-title scrollable>
                                            <v-spacer></v-spacer>
                                            <v-btn text color="primary" @click="menu = false">
                                                Cancel
                                            </v-btn>
                                            <v-btn text color="primary" @click="$refs.menu.save(fecha)">
                                                OK
                                            </v-btn>
                                        </v-date-picker>
                                    </v-menu>
                                </v-col>
                                <v-col md=4>
                                    <v-text-field 
                                        v-model="nombreFacilitador" 
                                        outlined label="Nombre del facilitador" 
                                        persistent-hint
                                        v-validate="'required|max:200'" 
                                        data-vv-name="nombre facilitador"
                                        :error="errors.has('nombre facilitador')"
                                        :error-messages="errors.first('nombre facilitador')"></v-text-field>
                                </v-col>
                                <v-col md=2 >
                                    <v-radio-group
                                        v-model="constancia"
                                        label="Requiere una constancia"
                                        v-validate="'required'"
                                        data-vv-name="constancia"
                                        :error="errors.has('constancia')"
                                        :error-messages="errors.first('constancia')"
                                    >
                                        <v-radio
                                            label="Si"
                                            value="true"
                                        ></v-radio>
                                        <v-radio
                                            label="No"
                                            value="false"
                                        ></v-radio>
                                    </v-radio-group>
                                </v-col>

                            </v-row>

                            <v-row justfy="center" dense >
                                <v-col class="text-center"><b>Información del capacitado</b></v-col>
                            </v-row>

                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">

                                <v-col md=2>
                                    <v-text-field 
                                        v-model="noControl" 
                                        outlined label="Número de control" 
                                        persistent-hint
                                        v-validate="'required|max:200'" 
                                        data-vv-name="numero control"
                                        :error="errors.has('numero control')"
                                        :error-messages="errors.first('numero control')"></v-text-field>
                                </v-col>
                                
                                <v-col md=3>
                                    <v-select 
                                        v-model="puesto"
                                        outlined
                                        label="Puesto"
                                        v-validate="'required'"
                                        :items="arrayPuesto"
                                        item-value="nombrePuesto"
                                        item-text="nombrePuesto"
                                        data-vv-name="puesto"
                                        :error="errors.has('puesto')"
                                        :error-messages="errors.first('puesto')"
                                    ></v-select>
                                </v-col>
                                <v-col md=4>
                                    <v-text-field 
                                        v-model="direccionPuesto" 
                                        outlined label="Dirección/Subdirección en la que te encuentras" 
                                        persistent-hint
                                        v-validate="'required|max:200'" 
                                        data-vv-name="direccion puesto"
                                        :error="errors.has('direccion puesto')"
                                        :error-messages="errors.first('direccion puesto')"></v-text-field>
                                </v-col>
                                 
                            </v-row>

                            <v-row justfy="center" dense >
                               
                            </v-row>

                            

                            <%-- <v-row justfy="center" dense >
                            </v-row> --%>
                            
                            <v-row justify="center">
                                <v-btn color="primary" @click="flagEditar ? fnEditar() : fnGuardar()"><v-icon>mdi-content-save</v-icon>{{flagEditar ? 'Editar' : 'Guardar'}}</v-btn>
                                &nbsp;
                                <v-btn color="error" @click="fnLimpiarCampos()"><v-icon>mdi-cancel</v-icon>Cancelar</v-btn>
                            </v-row>
                            
                            <v-row justify="center">
                                <v-col md=12>
                                    <v-data-table
                                        :headers="headersProveedores"
                                        :items="dataDocentes"
                                        :search="searchProveedores"
                                        class="elevation-2"
                                        no-data-text="No se encontro ningun registro"
                                        :hide-default-header="dataDocentes.length < 1"
                                        :hide-default-footer="dataDocentes.length < 1"
                                        locale="es-ES"
                                        :mobile-breakpoint="NaN"
                                        items-per-page="10"
                                    >
                                <v-col md=12>
                                    <v-data-table
                                        :headers="headersProveedores"
                                        :items="dataDocentes"
                                        :search="searchProveedores"
                                        class="elevation-2"
                                        no-data-text="No se encontro ningun registro"
                                        :hide-default-header="dataDocentes.length < 1"
                                        :hide-default-footer="dataDocentes.length < 1"
                                        locale="es-ES"
                                        :mobile-breakpoint="NaN"
                                        items-per-page="10"
                                    >
                                        <template v-slot:item.status="{item}">
                                            <%-- <v-tooltip bottom> --%>
                                                <%-- <template v-slot:activator="{on, attrs}"> --%>
                                                <%-- v-bind="attrs" v-on="on" --%>
                                                    <v-switch v-model="item.status" @change="fnCambiarEstatus(item)"></v-switch>
                                                <%-- </template> --%>
                                                <%-- <span>d</span> --%>
                                            <%-- </v-tooltip> --%>
                                        </template>
                                        <template v-slot:item.editar="{item}">
                                            <v-btn fab small color="warning" @click="flagEditar = true; itemEditar = item;
                                                tipo = item.cve_tipo;
                                                nombreCorto = item.nombre_corto;
                                                razonSocial = item.nombre;
                                                rfc = item.rfc;
                                                padron = item.clave_patron;
                                                nombreContacto = item.nombre_contacto;
                                                correoContacto = item.correo;
                                                telefonoContacto = item.telefono;
                                                tipoPersona = item.tipo_persona
                                            "><v-icon>mdi-square-edit-outline</v-icon></v-btn>
                                        </template>
                                        <template v-slot:item.eliminar="{item}">
                                            <v-btn fab small color="error" @click="fnEliminar(item);"><v-icon>mdi-trash-can</v-icon></v-btn>
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
                const ctr = "../../controlador/formacion_docente/controlador_evaluacion_capacitacion.jsp";
                //Variables POST
                const tipoUsuario = ref("");
                const fecha = ref ("");
                const nombreUsuario = ref("");
                const tipo = ref("");
                const nombreCorto = ref("");
                const examenDiagnosticoFinal = ref("");
                const asistencia = ref("");
                const participacion= ref("");
                const desempennioActividades = ref("");
                const calificacionFinal = ref("");

                const nombreCurso = ref("");
                const nombreFacilitador = ref("");
                const noControl = ref("");
                const nombreCompleto = ref("");
                const puesto = ref("");
                const direccionPuesto = ref("");
                const constancia = ref("");

                        const razonSocial = ref("");
                        const rfc = ref("");
                        const padron = ref("");
                        const nombreContacto = ref("");
                        const correoContacto = ref("");
                        const telefonoContacto = ref("");
                        const tipoPersona = ref("");
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
                const dialogBuscador = ref(false);

                const dialogDetallesCotizacion = ref(false);
                const dialogProveedor = ref(false);

                //DataTable
                const dataProveedores = ref([]);
                const dataDocentes = ref([]);
                const arrayTipoUsuario = ref([]);
                const arrayCalificacion = ref(["7","8","9","10"]);
                const arrayPuesto = ref(["PTC","PA"]);

                const headersProveedores = ref([
                    {text: 'No', align: 'left', sortable: true, value: 'idDocente'},
                    {text: 'Nombre docente', align: 'left', sortable: true, value: 'nombreDocente'},
                    {text: 'Puesto', align: 'left', sortable: true, value: 'puesto'},
                    {text: 'Nombre curso', align: 'left', sortable: true, value: 'nombreCurso'},
                    {text: 'Calificacion final', align: 'left', sortable: true, value: 'calificacionFinal'},
                    {text: 'Editar', align: 'left', sortable: true, value: 'editar'},
                    {text: 'Estatus', align: 'left', sortable: true, value: 'activo' },
                    {text: 'Eliminar', align: 'left', sortable: true, value: 'eliminar'},
                ]);
                const listaCurso = ref([                    
                    {text: 'Nombre docente', align: 'left', sortable: true, value: 'nombreDocente'},
                    {text: 'Calificacion final', align: 'left', sortable: true, value: 'puesto'},
                    {text: 'Nombre curso', align: 'left', sortable: true, value: 'nombreCurso'},
                    {text: 'Calificacion final', align: 'left', sortable: true, value: 'calificacionFinal'},
                    {text: 'Editar', align: 'left', sortable: true, value: 'editar'},
                    {text: 'Estatus', align: 'left', sortable: true, value: 'activo' },
                    {text: 'Eliminar', align: 'left', sortable: true, value: 'eliminar'},
                ]);
                const searchProveedores = ref([]);

                onMounted(() => {
                    fnConsultarTabla();
                    fnPuesto();
                });
                
                async function fnConsultarTabla(){
                    try{
                        preloader("../../");
                        let parametros = new URLSearchParams();
                        parametros.append("accion", 1);
                        let {data,status} = await axios.post(ctr, parametros)
                        if(status == 200){
                            if(data.length > 0){

                                dataDocentes.value = data
                            }
                        }
                    } catch(error){
                        mostrarSnackbar('error');
                        console.error(error);
                    } finally{
                        swal.close();
                    }
                }
                async function fnPuesto() {
                            try {
                                preloader("../../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 2); // arreglo que se manda 
                                let { data, status } = await axios.post(ctr, parametros) // axios hace peticion y manda a la ruta los parametros por POST
                                if (status == 200) { // si es 200 encontro informacion 
                                    if (data.length > 0) {
                                        arrayPuesto.value = data // llena los datos del dataTable
                                    }
                                }
                            } catch (error) {
                                mostrarSnackbar('error');
                                console.error(error);
                            } finally {
                                swal.close();
                            }
                        }


                async function fnGuardar(){
                    this.$validator.validate().then(async esValido => {
                        if(esValido){
                            try{
                                preloader("../../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 8);
                                parametros.append("tipo", tipo.value);
                                parametros.append("nombreCorto", nombreCorto.value);
                                parametros.append("razonSocial", razonSocial.value);
                                parametros.append("rfc", rfc.value);
                                parametros.append("padron", padron.value);
                                parametros.append("nombreContacto", nombreContacto.value);
                                parametros.append("correoContacto", correoContacto.value);
                                parametros.append("telefonoContacto", telefonoContacto.value);
                                parametros.append("tipoPersona", tipoPersona.value);
                                parametros.append("pass", rfc.value.substring(0,3) + Math.random().toString(36).slice(-3));
                                let {data,status} = await axios.post(ctr, parametros)
                                if(status == 200){
                                    if(data == "1"){
                                        mostrarSnackbar("success", "Registro guardado correctamente.");
                                        fnConsultarTabla();
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

                async function fnTiposProveedor(){
                    try{
                        preloader("../../");
                        let parametros = new URLSearchParams();
                        parametros.append("accion", 3);
                        let {data,status} = await axios.post(ctr, parametros)
                        if(status == 200){
                            if(data.length > 0){
                                arrayTiposProveedores.value = data
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
                                preloader("../../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 4);
                                parametros.append("cve_proveedor", itemEditar.value.cve_proveedor);
                                parametros.append("tipo", tipo.value);
                                parametros.append("nombreCorto", nombreCorto.value);
                                parametros.append("razonSocial", razonSocial.value);
                                parametros.append("rfc", rfc.value);
                                parametros.append("padron", padron.value);
                                parametros.append("nombreContacto", nombreContacto.value);
                                parametros.append("correoContacto", correoContacto.value);
                                parametros.append("telefonoContacto", telefonoContacto.value);
                                parametros.append("tipoPersona", tipoPersona.value);
                                parametros.append("pass", rfc.value.substring(0,3) + Math.random().toString(36).slice(-3));
                                let {data,status} = await axios.post(ctr, parametros)
                                if(status == 200){
                                    if(data == "1"){
                                        mostrarSnackbar("success", "Registro actualizado correctamente.");
                                        fnConsultarTabla();
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

                async function fnEliminar(item){
                    confirmarE("¿Realmente quieres eliminar éste registro?").then(async (result) => {
                        if(result.isConfirmed){
                            try{
                                preloader("../../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 5);
                                parametros.append("cve_proveedor", item.cve_proveedor);
                                let {data,status} = await axios.post(ctr, parametros)
                                if(status == 200){
                                    if(data=="1"){
                                        fnConsultarTabla();
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

                function fnLimpiarCampos(cx){//cx = contexto
                    tipo.value = "";
                    nombreCorto.value = "";
                    razonSocial.value = "";
                    rfc.value = "";
                    padron.value = "";
                    nombreContacto.value = "";
                    correoContacto.value = "";
                    telefonoContacto.value = "";
                    tipoPersona.value = "";
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
                    tipo, nombreCurso, fecha, nombreFacilitador, noControl, nombreCompleto, puesto, 
                    direccionPuesto, constancia, examenDiagnosticoFinal, asistencia, participacion, 
                    desempennioActividades, calificacionFinal, tipoUsuario, nombreCorto, nombreUsuario, 
                    razonSocial, arrayCalificacion, rfc, padron, nombreContacto, correoContacto, telefonoContacto,tipoPersona,
                    dataProveedores, dataDocentes, headersProveedores, fecha, searchProveedores, arrayTiposProveedores, 
                    dialogBuscador, arrayPuesto,arrayTipoUsuario, dialogDetallesCotizacion, dialogProveedor,
                    fnConsultarTabla, fnGuardar, fnLimpiarCampos, fnEditar, fnEliminar, itemEditar
                }
            },
            
        });

        Vue.config.devtools = true;
</script>
</html>