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
                            Programa de desarrollo de modúlos
                        </v-card-title>
                        <v-container fluid>
                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                <!--Columna-->
                                                                
                                <v-col md="6">
                                    <v-select
                                      v-model="cve_prog_des"
                                      :items="ArrayProgramaDesarrollo"
                                      item-text="nombre_prog_des" // Especifica la propiedad del objeto a mostrar como texto en el select
                                      item-value="cve_prog_des" // Especifica la propiedad del objeto a usar como valor en el select
                                      outlined
                                      label="Programa de desarrollo"
                                      persistent-hint
                                      v-validate="'required|max:200'"
                                      data-vv-name="programa de desarrollo"
                                      :error="errors.has('programa de desarrollo')"
                                      :error-messages="errors.first('programa de desarrollo')"
                                    ></v-select>
                                  </v-col>

                                  <v-col md="6">
                                    <v-select
                                      v-model="cve_modulo"
                                      :items="ArrayModulo"
                                      outlined
                                      label="Módulo"
                                      persistent-hint
                                      ></v-select>
                                  </v-col>

                                <v-col md=6>
                                    <v-text-field 
                                        v-model="nombre_modulo"
                                        outlined
                                        label="Nombre Módulo"
                                        persistent-hint
                                        v-validate="'required|max:200'"
                                        data-vv-name="nombre módulo"
                                        :error="errors.has('nombre módulo')"
                                        :error-messages="errors.first('nombre módulo')"
                                    ></v-text-field>
                                </v-col>

                                <v-col md=6>
                                    <v-text-field 
                                        v-model="num_materias"
                                        outlined
                                        label="Número de Materias"
                                        persistent-hint
                                        v-validate="'required|max:200'"
                                        data-vv-name="número materias"
                                        type="number"
                                        pattern="[0-9]*"
                                        :error="errors.has('número materias')"
                                        :error-messages="errors.first('número materias')"
                                    ></v-text-field>
                                </v-col>

                                <v-col md="6">
                                    <v-select
                                      v-model="color"
                                      :items="coloresBasicos"
                                      item-text="text"
                                      item-value="value"
                                      outlined
                                      label="Color"
                                      persistent-hint
                                      v-validate="'required|max:200'"
                                      data-vv-name="color"
                                      :error="errors.has('color')"
                                      :error-messages="errors.first('color')"
                                    ></v-select>
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
                                    <v-text-field
                                    v-model="search"
                                    append-icon="mdi-magnify"
                                    label="Buscar"
                                    outlined
                                    hide-details
                                  ></v-text-field>
                                    <v-data-table
                                    :headers="headersProveedores"
                                    :items="dataProveedores"
                                    :search="search"
                                    class="elevation-2"
                                    no-data-text="No se encontró ningún registro"
                                    :hide-default-header="dataProveedores.length < 1"
                                    :hide-default-footer="dataProveedores.length < 1"
                                    locale="es-ES"
                                    :mobile-breakpoint="NaN"
                                    items-per-page="10"
                                    >
                                    <template v-slot:item.color="{ item }">
                                        <v-icon :style="{ color: item.color }">mdi-circle</v-icon>
                                    </template>
                                    <template v-slot:item.activo="{ item }">
                                        <td>
                                          <v-icon :class="{'green--text': item.activo, 'red--text': !item.activo}">
                                            {{ item.activo ? 'mdi-check' : 'mdi-close' }}
                                          </v-icon>
                                        </td>
                                      </template>
                                    <template v-slot:item.status="{ item }">
                                        <v-switch v-model="item.status" @change="fnCambiarEstatus(item)"></v-switch>
                                    </template>
                                    <template v-slot:item.editar="{ item }">
                                        <v-btn fab small color="warning" @click="flagEditar = true; itemEditar = item;
                                        tipo = item.tipo;
                                        nombreUsuario = item.nombre;
                                        fecha = item.fecha;
                                        "><v-icon>mdi-square-edit-outline</v-icon></v-btn>
                                    </template>
                                    <template v-slot:item.eliminar="{ item }">
                                        <v-btn fab small color="error" @click="fnEliminar(item);"><v-icon>mdi-trash-can</v-icon></v-btn>
                                    </template>
                                    <template v-slot:item.password="{ item }">
                                        <v-tooltip bottom>
                                        <template v-slot:activator="{ on, attrs }">
                                            <span v-bind="attrs" v-on="on" @click="navigator.clipboard.writeText(item.password); mostrarSnackbar('success', 'Texto copiado al portapapeles.')"><b>{{ item.password }}</b></span>
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
                const ctr = "../../controlador/programas/Controlador_programa_desarrollo_modulos.jsp";
                //Variables POST
                const cve_prog_des = ref("");
                const cve_modulo = ref("");
                const nombreUsuario = ref("");
                const nombre_modulo = ref("");
                const num_materias = ref("");
                const color = ref("");
                const search = ref("");
                                //Otras variables
                const flagEditar = ref(false);
                const itemEditar = ref({});
                //Setup del calendario
                const ArrayProgramaDesarrollo = ref([]);
                const ArrayModulo= ref([]);
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

                //Arreglo Colores
                const coloresBasicos=ref( [
      { text: 'Rojo', value: 'red' },
      { text: 'Verde', value: 'green' },
      { text: 'Azul', value: 'blue' },
      { text: 'Amarillo', value: 'yellow' },
      { text: 'Magenta', value: 'magenta' },
      { text: 'Cian', value: 'cyan' }
    ])
                //dataUsuarios
                const dataProveedores = ref([]); 
                const dataUsuarios = ref([]);
                const headersProveedores = ref([
                    {text: 'Nombre del módulo', align: 'left', sortable: true, value: 'nombre_modulo'},
                    {text: 'Número de materias', align: 'left', sortable: true, value: 'num_materias'},
                    {text: 'Color ', align: 'left', sortable: true, value: 'color'},
                    {text: 'Estatus', align: 'left', sortable: true, value: 'activo'},
                    {text: 'Desactivar', align: 'left', sortable: true, value: 'eliminar'},
                ]);
                const searchProveedores = ref([]);

                //Accion automatizada para mostrar la tabla
                onMounted(() => {
                    fnConsultarTabla();
                    fnProgramaDesarrollo();
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
                                parametros.append("accion", 2);
                                parametros.append("cve_prog_des", cve_prog_des.value);
                                parametros.append("nombre_modulo", nombre_modulo.value);
                                parametros.append("num_materias", num_materias.value);
                                parametros.append("color", color.value);
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

                async function fnProgramaDesarrollo(){
                    try{
                        preloader("../../");
                        let parametros = new URLSearchParams();
                        parametros.append("accion", 3);
                        let {data,status} = await axios.post(ctr, parametros)
                        if(status == 200){
                            if(data.length > 0){
                                ArrayProgramaDesarrollo.value = data
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
                                parametros.append("accion", 4);
                                parametros.append("cve_prog_des", item.cve_prog_des);
                                parametros.append("nombre_modulo", item.nombre_modulo);
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
                    cve_prog_des.value = "";
                    nombreUsuario.value = "";
                    cve_modulo.value = "";
                    nombre_modulo.value = "";
                    num_materias.value = "";
                    color.value = "";
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
                    nombreUsuario, cve_prog_des, cve_modulo,nombre_modulo, num_materias,color,
                    dataProveedores, headersProveedores, searchProveedores, ArrayProgramaDesarrollo, ArrayModulo, search,
                    dialogBuscador, dialogDetallesCotizacion, dialogProveedor, coloresBasicos,
                    fnConsultarTabla, fnGuardar, fnLimpiarCampos, fnEditar, fnEliminar, itemEditar
                }
            },
            
        });

        Vue.config.devtools = true;
</script>
</html>