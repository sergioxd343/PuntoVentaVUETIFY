<%@page contentType="text/html; charset=UTF-8" language="java" errorPage="" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900" rel="stylesheet">
        <link href="../styles/icon_material_design_4495/css/materialdesignicons.min.css" rel="stylesheet">
        <link href="../javascript/VueJs/sweetalert2/sweetalert2.css" />
        <link href="../javascript/VueJs/vuetify/vuetify.min.css" rel="stylesheet">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
        <script src="../javascript/VueJs/vue/vue.js"></script>
        <script type="" src="../javascript/VueJs/vue/vue-composition-api.prod.js" ></script>
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
                            An&aacute;lisis Situacional Docente
                        </v-card-title>
                        <v-container fluid>
                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                <!--Columna-->
                                <v-col md=4>
                                    <v-select 
                                        v-model="tipo"
                                        outlined
                                        label="Unidad academica"
                                        v-validate="'required'"
                                        :items="arrayTiposUsuario"
                                        item-value="id_tipo_usuario"
                                        item-text="nombre"
                                        data-vv-name="tipo"
                                        type="number"
                                        :error="errors.has('tipo')"
                                        :error-messages="errors.first('tipo')"
                                    ></v-select>
                                </v-col>

                                <v-col md=6>
                                    <v-select 
                                        v-model="nombreUsuario"
                                        outlined
                                        label="Nombre de la academia"
                                        persistent-hint
                                        v-validate="'required|max:200'"
                                        data-vv-name="nombre corto"
                                        :error="errors.has('nombre corto')"
                                        :error-messages="errors.first('nombre corto')"
                                    ></v-select>
                                </v-col>

                                <v-col md=6>
                                    <v-text-field 
                                        v-model="nombreUsuario"
                                        outlined
                                        label="Programa educativo"
                                        persistent-hint
                                        v-validate="'required|max:200'"
                                        data-vv-name="nombre corto"
                                        :error="errors.has('nombre corto')"
                                        :error-messages="errors.first('nombre corto')"
                                    ></v-text-field>
                                </v-col>

                                <v-col md=6>
                                    <v-text-field 
                                        v-model="nombreUsuario"
                                        outlined
                                        label="Numero de PTC"
                                        persistent-hint
                                        v-validate="'required|max:200'"
                                        data-vv-name="nombre corto"
                                        :error="errors.has('nombre corto')"
                                        :error-messages="errors.first('nombre corto')"
                                    ></v-text-field>
                                </v-col>

                                <v-col md=6>
                                    <v-text-field 
                                        v-model="nombreUsuario"
                                        outlined
                                        label="A&ntilde;o de apliaci&oacute;n"
                                        persistent-hint
                                        v-validate="'required|max:200'"
                                        data-vv-name="nombre corto"
                                        :error="errors.has('nombre corto')"
                                        :error-messages="errors.first('nombre corto')"
                                    ></v-text-field>
                                </v-col>

                                
                                    <v-col cols="12" sm="6" md="4">
                                        <v-menu 
                                                ref="menu1"  
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
                                                <v-btn text color="primary" @click="menu1 = false">
                                                    Cancel
                                                </v-btn>
                                                <v-btn text color="primary" @click="$refs.menu1.save(fecha)">
                                                    OK
                                                </v-btn>
                                            </v-date-picker>
                                        </v-menu>
                                    </v-col>

                                    
                                <v-col md=12 style="text-align: center; background-color: #00b293; color: floralwhite;">
                                        <v-toolbar-title>An&aacute;lisis</v-toolbar-title>
                                </v-col>
                                
                                

                                
                            </v-row>

                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px"> 

                                <v-col md=6 style="background-color: #ffffBf">
                                    <v-expansion-panels >
                                        <v-expansion-panel>
                                          <v-expansion-panel-header>
                                            NOTA
                                          </v-expansion-panel-header>
                                          <v-expansion-panel-content>
                                            <p>
                                                Con el fin de identificar el contexto educativo del personal docente y que permita construir el plan de capacitación anual se le solicita realizar un análisis situacional al PTC. Tome en cuenta los resultados de las evaluaciones docentes, desempeño de tutoreo observaciones, necesidades y mejoras sobre la capacitación al interior del Programa Educativo (PE) Su aportación será valiosa para establecer mejoras en la capacitación que se proporciona al profesorado y alcanzar el desarrollo de las competencias docentes y la actualización en el área de especialidad. 
                                            </p>
                                          </v-expansion-panel-content>
                                        </v-expansion-panel>
                                      </v-expansion-panels>
                                </v-col>

                                <v-col md="6" >
                                    <v-alert
                                        :value="true"
                                        color="info"
                                        icon="mdi-information-outline"
                                        style="color: white;"
                                    >
                                    En el siguiente apartado inserte los resultados de evaluación docente, evaluación de tutoreo e indicadores de capacitación.  
                                    </v-alert>
                                </v-col>

                                <v-col md=12 style="text-align: center;"><v-subheader style="text-align: center;">Promedio de evaluación docente</v-subheader></v-col>
                                <v-col md=6>
                                    
                                    <v-text-field 
                                        v-model="nombreUsuario"
                                        outlined
                                        label="Evaluación docente"
                                        persistent-hint
                                        v-validate="'required|max:200'"
                                        data-vv-name="nombre corto"
                                        :error="errors.has('nombre corto')"
                                        :error-messages="errors.first('nombre corto')"
                                    ></v-text-field>
                                </v-col>

                                <v-col md=6>
                                    <v-text-field 
                                        v-model="nombreUsuario"
                                        outlined
                                        label="Evaluación tutoreo"
                                        persistent-hint
                                        v-validate="'required|max:200'"
                                        data-vv-name="nombre corto"
                                        :error="errors.has('nombre corto')"
                                        :error-messages="errors.first('nombre corto')"
                                    ></v-text-field>
                                </v-col>

                                <v-col md=12 style="text-align: center;"><v-subheader style="text-align: center;">Promedio de evaluación</v-subheader></v-col>
                                <v-col md=6>
                                    
                                    <v-text-field 
                                        v-model="nombreUsuario"
                                        outlined
                                        label="Promedio evaluación docente academica"
                                        persistent-hint
                                        v-validate="'required|max:200'"
                                        data-vv-name="nombre corto"
                                        :error="errors.has('nombre corto')"
                                        :error-messages="errors.first('nombre corto')"
                                    ></v-text-field>
                                </v-col>

                                <v-col md=6>
                                    <v-text-field 
                                        v-model="nombreUsuario"
                                        outlined
                                        label="Promedio evaluación tutoreo academica"
                                        persistent-hint
                                        v-validate="'required|max:200'"
                                        data-vv-name="nombre corto"
                                        :error="errors.has('nombre corto')"
                                        :error-messages="errors.first('nombre corto')"
                                    ></v-text-field>
                                </v-col>

                                <v-col md=6>
                                    <v-subheader>Porcentaje de docentes con curso acreditado en academia </v-subheader>
                                    <v-text-field 
                                        v-model="nombreUsuario"
                                        outlined
                                        label="Indicador de capacitación PTC"
                                        persistent-hint
                                        v-validate="'required|max:200'"
                                        data-vv-name="nombre corto"
                                        :error="errors.has('nombre corto')"
                                        :error-messages="errors.first('nombre corto')"
                                    ></v-text-field>
                                </v-col>
                                <v-col md=12 style="text-align: center; background-color: #00b293; color: floralwhite;">
                                    <v-toolbar-title>Identificación de Fortalezas y Debilidades</v-toolbar-title>
                            </v-col>

                            <v-col md=6 style="background-color: red">
                                <v-expansion-panels >
                                    <v-expansion-panel>
                                      <v-expansion-panel-header>
                                        Instrucciones
                                      </v-expansion-panel-header>
                                      <v-expansion-panel-content>
                                        <p>
                                            En los siguientes apartados, argumente los elementos que se solicitan basados en la participación y acreditación de cursos, evaluaciones institucionales y trabajo colaborativo dentro de la academia:      
                                        </p>
                                      </v-expansion-panel-content>
                                    </v-expansion-panel>
                                  </v-expansion-panels>
                            </v-col>
                            <v-col md=6
                            ></v-col>

                            <v-col md=6>
                                <v-text-field 
                                    v-model="nombreUsuario"
                                    outlined
                                    label="Fortalezas"
                                    append-icon="mdi-help-circle"
                                    hint="Elementos positivos e internos que permitan el logro de los objetivos"
                                    persistent-hint
                                    v-validate="'required|max:200'"
                                    data-vv-name="nombre corto"
                                    :error="errors.has('nombre corto')"
                                    :error-messages="errors.first('nombre corto')"
                                ></v-text-field>
                            </v-col>

                            <v-col md=6>
                                <v-text-field 
                                    v-model="nombreUsuario"
                                    outlined
                                    label="Debilidades"
                                    append-icon="mdi-help-circle"
                                    hint="Elementos negativos internos que afectan el logro de los objetivos"
                                    persistent-hint
                                    v-validate="'required|max:200'"
                                    data-vv-name="nombre corto"
                                    :error="errors.has('nombre corto')"
                                    :error-messages="errors.first('nombre corto')"
                                ></v-text-field>
                            </v-col>
                            <v-col md=6>
                                <v-text-field 
                                    v-model="nombreUsuario"
                                    outlined
                                    label="Necesidades"
                                    append-icon="mdi-help-circle"
                                    hint="Basados en los resultados de encuestas, entregables, resultados de evaluación y seguimientos al docente, acreditaciones, actualizaciones de PE, proyectando un proceso formativo de 1 año"
                                    persistent-hint
                                    v-validate="'required|max:200'"
                                    data-vv-name="nombre corto"
                                    :error="errors.has('nombre corto')"
                                    :error-messages="errors.first('nombre corto')"
                                ></v-text-field>
                            </v-col>

                            <v-col md=6>
                                <v-select  
                                    v-model="nombreUsuario"
                                    outlined
                                    label="Tipo de Evento"
                                    hint="Tipo de capacitación que se requiere; curso, taller, diplomado, certificación, etc."
                                    persistent-hint
                                    v-validate="'required|max:200'"
                                    data-vv-name="nombre corto"
                                    :error="errors.has('nombre corto')"
                                    :error-messages="errors.first('nombre corto')"
                                ></v-select>
                            </v-col>

                            <v-col md=6>
                                <v-select  
                                    v-model="nombreUsuario"
                                    outlined
                                    label="Prioridad de capacitación"
                                    hint="Indicar si se requiere de cursos, talleres, diplomados o certificaciones para atender una necesidad prioritaria, basado en: Acreditaciones de PE, certificaciones, actualización de PE, etc (A ejecutar en 1 año)"
                                    persistent-hint
                                    v-validate="'required|max:200'"
                                    data-vv-name="nombre corto"
                                    :error="errors.has('nombre corto')"
                                    :error-messages="errors.first('nombre corto')"
                                ></v-select>
                            </v-col>

                            <v-col md=6>
                                <v-text-field 
                                    v-model="nombreUsuario"
                                    outlined
                                    label="Estrategias de intervención"
                                    hint="A ejecutar en 1 año"
                                    persistent-hint
                                    v-validate="'required|max:200'"
                                    data-vv-name="nombre corto"
                                    :error="errors.has('nombre corto')"
                                    :error-messages="errors.first('nombre corto')"
                                ></v-text-field>
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
                        src="../images/Logo_utl_animado.gif"
                    > 
                    </v-img>
                </v-overlay>
            </v-app>
        </div>
    </body>

    <%--apis--%>
    <script src="../javascript/axios/axios.js"></script>

    <script src="../javascript/VueJs/vuetify/vuetify.min.js"></script>
    <script src="../javascript/VueJs/vee-validate/vee-validate.js"></script>
    <script src="../javascript/VueJs/vee-validate/es.js"></script>
    <script src="../javascript/VueJs/sweetalert2/sweetalert2.all.js"></script>

    <%--Desarrollo--%>
    <script type="module">
        import {preloader, guardar, errorGuardar, actualizar, errorActualizar, eliminar, errorEliminar, cerrar, confirmarE, aviso, confirmar} from '../javascript/mensajeSistema/mensajes_sweetalert_vue.js';
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
                const ctr = "../controlador/ejemplo_usuario/Controlador_catalogo_usuario.jsp";
                //Variables POST
                const tipo = ref("");
                const nombreUsuario = ref("");
                const fecha = ref("");
                const rfc = ref("");
                const padron = ref("");
                const nombrePerfil = ref("");
                const correoContacto = ref("");
                const telefonoContacto = ref("");
                const estatus = ref("");
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
                const dataUsuarios = ref([]);
                const headersProveedores = ref([
                    {text: 'No', align: 'left', sortable: true, value: 'id_usuario'},
                    {text: 'Nombre', align: 'left', sortable: true, value: 'nombre'},
                    {text: 'Tipo de Usuario ', align: 'left', sortable: true, value: 'Expr1'},
                    {text: 'Fecha', align: 'left', sortable: true, value: 'fecha'},
                    {text: 'Editar', align: 'left', sortable: true, value: 'editar'},
                    {text: 'Estatus', align: 'left', sortable: true, value: 'activo'},
                    {text: 'Eliminar', align: 'left', sortable: true, value: 'eliminar'},
                ]);
                const searchProveedores = ref([]);

                //Accion automatizada para mostrar la tabla
                onMounted(() => {
                    fnConsultarTabla();
                    fnTiposUsuario();
                    //fnTiposProveedor();
                });

                async function fnTiposUsuario(){
                    try{
                        preloader("../");
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

                async function fnGuardar(){
                    this.$validator.validate().then(async esValido => {
                        if(esValido){
                            try{
                                preloader("../");
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
                        preloader("../");
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

                async function fnEditar(){
                    this.$validator.validate().then(async esValido => {
                        if(esValido){
                            try{
                                preloader("../");
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
                                preloader("../");
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
                    tipo, nombreUsuario, fecha, rfc, padron, nombrePerfil, correoContacto, telefonoContacto,estatus,
                    dataProveedores, headersProveedores, searchProveedores, arrayTiposUsuario, 
                    dialogBuscador, dialogDetallesCotizacion, dialogProveedor,
                    fnConsultarTabla, fnGuardar, fnLimpiarCampos, fnEditar, fnEliminar, itemEditar
                }
            },
            
        });

        Vue.config.devtools = true;
</script>
</html>