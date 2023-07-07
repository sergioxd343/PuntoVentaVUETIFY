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
                            Evento Programado
                        </v-card-title>
                        <v-container fluid>
                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                <!--Columna-->
                                

                                <v-col md="6">
                                    <v-select
                                      v-model="cve_espacio"
                                      :items="arrayEspacio"
                                      item-text="nombre_espacio" // Especifica la propiedad del objeto a mostrar como texto en el select
                                      item-value="cve_espacio" // Especifica la propiedad del objeto a usar como valor en el select
                                      outlined
                                      label="Espacio donde se aplicara"
                                      persistent-hint
                                      v-validate="'required|max:200'"
                                      data-vv-name="espacio"
                                      :error="errors.has('espacio')"
                                      :error-messages="errors.first('espacio')"
                                      
                                    ></v-select>
                                  </v-col>

                                
                                  <v-col md="6">
                                    <v-select
                                      v-model="cve_modalidad"
                                      :items="arrayModalidad"
                                      item-text="nombre_modalidad" // Especifica la propiedad del objeto a mostrar como texto en el select
                                      item-value="cve_modalidad" // Especifica la propiedad del objeto a usar como valor en el select
                                      outlined
                                      label="Modalidad"
                                      persistent-hint
                                      v-validate="'required|max:200'"
                                      data-vv-name="programa de desarrollo"
                                      :error="errors.has('programa de desarrollo')"
                                      :error-messages="errors.first('programa de desarrollo')"
                                      
                                    ></v-select>
                                  </v-col>

                                                            
                                <v-col md=6>
                                    <v-text-field 
                                        v-model="nombre_evento"
                                        outlined
                                        label="Nombre del Evento"
                                        persistent-hint
                                        v-validate="'required|max:200'"
                                        data-vv-name="nombre corto"
                                        :error="errors.has('nombre corto')"
                                        :error-messages="errors.first('nombre corto')"
                                    ></v-text-field>
                                </v-col>

                                <v-col md=6>
                                    <v-text-field 
                                        v-model="nombre_origen"
                                        outlined
                                        label="Nombre del Origen"
                                        persistent-hint
                                        v-validate="'required|max:200'"
                                        data-vv-name="nombre corto"
                                        :error="errors.has('nombre corto')"
                                        :error-messages="errors.first('nombre corto')"
                                    ></v-text-field>
                                </v-col>

                                <template>
                                    <v-col md="6">
                                      <v-switch v-model="sin_horario" label="¿Cuenta con un horario?"></v-switch>
                                    </v-col>
                                  </template>

                                  <v-col md="6" v-if="sin_horario">
                                    <v-card outlined>
                                      <v-card-title class="subheading">Horario Inicio</v-card-title>
                                      <v-card-text>
                                        <v-time-picker v-model="horario_inicio"></v-time-picker>
                                      </v-card-text>
                                    </v-card>
                                  </v-col>
                                
                                  <v-col md="6" v-if="sin_horario">
                                    <v-card outlined>
                                      <v-card-title class="subheading">Horario Fin</v-card-title>
                                      <v-card-text>
                                        <v-time-picker v-model="horario_fin"></v-time-picker>
                                      </v-card-text>
                                    </v-card>
                                  </v-col>

                                

                                <v-col cols="12" sm="6" md="4">
                                    <v-menu 
                                            ref="menu1"  
                                            :close-on-content-click="false"
                                            :return-value.sync="fecha_inicio" 
                                            transition="scale-transition" 
                                            offset-y min-width="auto">
                                        <template v-slot:activator="{ on, attrs }">
                                            <v-text-field v-model="fecha_inicio" label="Fecha Inicio" prepend-icon="mdi-calendar"
                                                readonly v-bind="attrs" v-on="on"></v-text-field>
                                        </template>
                                        <v-date-picker v-model="fecha_inicio" no-title scrollable>
                                            <v-spacer></v-spacer>
                                            <v-btn text color="primary" @click="menu1 = false">
                                                Cancel
                                            </v-btn>
                                            <v-btn text color="primary" @click="$refs.menu1.save(fecha_inicio)">
                                                OK
                                            </v-btn>
                                        </v-date-picker>
                                    </v-menu>
                                </v-col>

                                <v-col cols="12" sm="6" md="4">
                                    <v-menu 
                                            ref="menu2"  
                                            :close-on-content-click="false"
                                            :return-value.sync="fecha_fin" 
                                            transition="scale-transition" 
                                            offset-y min-width="auto">
                                        <template v-slot:activator="{ on, attrs }">
                                            <v-text-field v-model="fecha_fin" label="Fecha Termino" prepend-icon="mdi-calendar"
                                                readonly v-bind="attrs" v-on="on"></v-text-field>
                                        </template>
                                        <v-date-picker v-model="fecha_fin" no-title scrollable>
                                            <v-spacer></v-spacer>
                                            <v-btn text color="primary" @click="menu2 = false">
                                                Cancel
                                            </v-btn>
                                            <v-btn text color="primary" @click="$refs.menu2.save(fecha_fin)">
                                                OK
                                            </v-btn>
                                        </v-date-picker>
                                    </v-menu>
                                </v-col>


                                
                            </v-row>

                            
                            <%-- <v-row justfy="center" dense >
                            </v-row> --%>
                            
                            <v-divider></v-divider>
                           

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
                                                tipo = item.tipo;
                                                nombreUsuario = item.nombre;
                                                fecha = item.fecha;
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
                const ctr = "../../controlador/eventos/Controlador_evento_programado.jsp";
                //Variables POST
                const sin_horario =ref("");
                const nombreUsuario = ref("");
                const cve_even_prog = ref("");
                const cve_origen_evento = ref("");
                const cve_espacio = ref("");
                const cve_modalidad = ref("");
                const nombre_evento = ref("");
                const nombre_origen = ref("");
                const horario_inicio = ref("");
                const horario_fin = ref("");
                const fecha_inicio = ref("");
                const fecha_fin = ref("");
                //Otras variables
                const flagEditar = ref(false);
                const itemEditar = ref({});
                //Setup del calendario
                const arrayEspacio =ref([]);
                const arrayModalidad = ref([]);
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
                const dataUsuarios = ref([]);
                const headersProveedores = ref([
                    {text: 'No', align: 'left', sortable: true, value: 'cve_even_prog'},
                    {text: 'Nombre del Evento', align: 'left', sortable: true, value: 'nombre_evento'},
                    {text: 'Nombre del Origen', align: 'left', sortable: true, value: 'nombre_origen'},
                    {text: 'Horario inicio', align: 'left', sortable: true, value: 'horario_inicio'},
                    {text: 'fecha inicio', align: 'left', sortable: true, value: 'fecha_inicio'},
                    {text: 'Estatus', align: 'left', sortable: true, value: 'activo'},
                ]);
                const searchProveedores = ref([]);

                //Accion automatizada para mostrar la tabla
                onMounted(() => {
                    fnConsultarTabla();
                    fnEspacios();
                    fnModalidad();
                    //fnTiposProveedor();
                });

                
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

                async function fnGuardar(){
                    this.$validator.validate().then(async esValido => {
                        if(esValido){
                            try{
                                preloader("../../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 4);
                                parametros.append("cve_espacio", cve_espacio.value);
                                parametros.append("cve_modalidad", cve_modalidad.value);
                                parametros.append("nombre_evento", nombre_evento.value);
                                parametros.append("nombre_origen", nombre_origen.value);
                                parametros.append("sin_horario", sin_horario.value);
                                parametros.append("horario_inicio", horario_inicio.value);
                                parametros.append("horario_fin", horario_fin.value);
                                parametros.append("fecha_inicio", nombreUsuario.value);
                                parametros.append("fecha_fin", fecha_fin.value);
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

                async function fnEspacios(){
                    try{
                        preloader("../../");
                        let parametros = new URLSearchParams();
                        parametros.append("accion", 2);
                        let {data,status} = await axios.post(ctr, parametros)
                        if(status == 200){
                            if(data.length > 0){
                                arrayEspacio.value = data
                            }
                        }
                    } catch(error){
                        mostrarSnackbar('error');
                        console.error(error);
                    } finally{
                        swal.close();
                    }
                }

                async function fnModalidad(){
                    try{
                        preloader("../../");
                        let parametros = new URLSearchParams();
                        parametros.append("accion", 3);
                        let {data,status} = await axios.post(ctr, parametros)
                        if(status == 200){
                            if(data.length > 0){
                                arrayModalidad.value = data
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
                                parametros.append("tipo", tipo.value);
                                parametros.append("nombreUsuario", nombreUsuario.value);
                                parametros.append("fecha", fecha.value);
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
                                parametros.append("id_usuario", item.id_usuario);
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
                    nombreUsuario.value = "";
                    fecha.value = "";
                    rfc.value = "";
                    padron.value = "";
                    nombrePerfil.value = "";
                    correoContacto.value = "";
                    telefonoContacto.value = "";
                    estatus.value = "";
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
                    nombre_evento, nombre_origen, horario_inicio, horario_fin, fecha_inicio, fecha_fin,
                    dataProveedores, headersProveedores, searchProveedores, arrayTiposUsuario, sin_horario,
                    arrayEspacio, arrayModalidad,
                    dialogBuscador, dialogDetallesCotizacion, dialogProveedor,cve_even_prog,cve_origen_evento,cve_espacio,cve_modalidad,
                    fnConsultarTabla, fnGuardar, fnLimpiarCampos, fnEditar, fnEliminar, itemEditar
                }
            },
            
        });

        Vue.config.devtools = true;
</script>
</html>