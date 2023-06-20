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
        <title>Asistencia a capacitación</title>
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
                            LISTA DE ASISTENCIA DE CAPACITACIÓN
                        </v-card-title>
                        <v-container fluid>
                            
                                <!--Columna-->
                                <v-row justfy="center" dense >
                                    <v-col class="text-center"><b>Datos del Evento</b></v-col>
                                </v-row>
                                <v-divider></v-divider>
                                <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                
                                <!-- NOMBRE DEL EVENTO -->
                                <v-col md=4>
                                    <v-text-field 
                                        v-model="nombreEvento"
                                        outlined
                                        label="Nombre del evento"
                                        persistent-hint
                                        v-validate="'required'"
                                        data-vv-name="nombreEvento"
                                        :error="errors.has('nombreEvento')"
                                        :error-messages="errors.first('nombreEvento')"
                                    ></v-text-field>
                                </v-col>


                                <!-- NÚMERO DE SESIONES -->
                                <v-col md=2>
                                    <v-text-field 
                                        v-model="sesiones"
                                        outlined
                                        label="Num de sesiones"
                                        persistent-hint
                                        v-validate="'required|max:200'"
                                        data-vv-name="sesiones"
                                        :error="errors.has('sesiones')"
                                        :error-messages="errors.first('sesiones')"
                                    ></v-text-field>
                                </v-col>

                                <!-- TOTAL DE HORAS -->
                                <v-col md=2>
                                    <v-text-field 
                                        v-model="horas"
                                        outlined
                                        label="Total de horas"
                                        persistent-hint
                                        v-validate="'required|max:200'"
                                        data-vv-name="horas"
                                        :error="errors.has('horas')"
                                        :error-messages="errors.first('horas')"
                                    ></v-text-field>
                                </v-col>

                                  <!-- FECHA DE INICIO DEL EVENTO -->
                                <v-col cols="12" sm="6" md="2" >
                                    <v-dialog
                                        ref="dialog"
                                        :return-value.sync="fecha"
                                        //persistent
                                        width="290px"
                                    >
                                        <template v-slot:activator="{ on, attrs }">
                                        <v-text-field
                                            v-model="fecha"
                                            label="Fecha de inicio del evento"
                                            prepend-icon="mdi-calendar"
                                            readonly
                                            v-bind="attrs"
                                            v-on="on"
                                        ></v-text-field>
                                        </template>
                                        <v-date-picker
                                        v-model="fecha"
                                        scrollable
                                        >
                                        <v-spacer></v-spacer>
                                        <v-btn
                                            text
                                            color="primary"
                                            @click="modal = false"
                                        >
                                            Cancel
                                        </v-btn>
                                        <v-btn
                                            text
                                            color="primary"
                                            @click="$refs.dialog.save(fecha)"
                                        >
                                            OK
                                        </v-btn>
                                        </v-date-picker>
                                    </v-dialog>
                                </v-col>

                                <!-- FECHA DEL FIN DEL EVENTO -->
                                <v-col cols="12" sm="6" md="2" >
                                    <v-dialog
                                        ref="dialog"
                                        :return-value.sync="fecha"
                                        //persistent
                                        width="290px"
                                    >
                                        <template v-slot:activator="{ on, attrs }">
                                        <v-text-field
                                            v-model="fecha1"
                                            label="Fecha de fin del evento"
                                            prepend-icon="mdi-calendar"
                                            readonly
                                            v-bind="attrs"
                                            v-on="on"
                                        ></v-text-field>
                                        </template>
                                        <v-date-picker
                                        v-model="fecha1"
                                        scrollable
                                        >
                                        <v-spacer></v-spacer>
                                        <v-btn
                                            text
                                            color="primary"
                                            @click="modal = false"
                                        >
                                            Cancel
                                        </v-btn>
                                        <v-btn
                                            text
                                            color="primary"
                                            @click="$refs.dialog.save(fecha)"
                                        >
                                            OK
                                        </v-btn>
                                        </v-date-picker>
                                    </v-dialog>
                                </v-col>
                            </v-row>

                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                 <!-- NOMBRE DEL INSTRUCTOR -->
                                <v-col md=4>
                                    <v-select 
                                        v-model="nombreInstructor"
                                        outlined
                                        label="Nombre del instructor"
                                        v-validate="'required'"
                                        :items="arrayInstructores"
                                        item-value="idInstructor"
                                        item-text="nombreInstructor"
                                        data-vv-name="nombreInstructor"
                                        :error="errors.has('nombreInstructor')"
                                        :error-messages="errors.first('nombreInstructor')"
                                    ></v-select>
                                </v-col>
                               
                                 <!-- HORARIO -->
                                <v-col md=2>
                                    <v-text-field 
                                        v-model="horario"
                                        outlined
                                        label="Horario"
                                        v-validate="'required'"
                                        data-vv-name="horario"
                                        :error="errors.has('horario')"
                                        :error-messages="errors.first('horario')"
                                    ></<v-text-field >
                                </v-col>

                                <!-- LUGAR DE CAPACITACIÓN -->
                                <v-col md=3>
                                    <v-select 
                                        v-model="lugar"
                                        outlined
                                        label="Lugar"
                                        v-validate="'required'"
                                        :items="arrayLugares"
                                        item-value="idLugar"
                                        item-text="nombreLugar"
                                        data-vv-name="lugar"
                                        :error="errors.has('lugar')"
                                        :error-messages="errors.first('lugar')"
                                    ></v-select>
                                </v-col>

                                <!-- TIPO DE ACTIVIDAD -->
                                <v-col md=3>
                                        <v-select 
                                        v-model="tipoActividad"
                                        outlined
                                        label="Tipo actividad"
                                        v-validate="'required'"
                                        :items="arrayTiposActividad"
                                        item-value="idTipoActividad"
                                        item-text="nombre"
                                        data-vv-name="tipoActividad"
                                        :error="errors.has('tipoActividad')"
                                        :error-messages="errors.first('tipoActividad')"
                                    ></v-select>

                                    
                                </v-col>
                            </v-row>

                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                               <!-- OTRA ACTIVIDAD -->
                                <v-col md=3>
                                    <v-text-field 
                                    v-if="tipoActividad === 7"
                                        v-model="otraAct"
                                        outlined
                                        label="¿Cuál?"
                                        persistent-hint
                                        v-validate="'required|max:200'"
                                        data-vv-name="otraAct"
                                        :error="errors.has('otraAct')"
                                        :error-messages="errors.first('otraAct')"
                                    ></v-text-field>
                                </v-col>
                            </v-row>

                                <v-row justfy="center" dense >
                                    <v-col class="text-center"><b>Datos del Asistente</b></v-col>
                                </v-row>
                                <v-divider></v-divider>

                        
                                <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                    <!-- NUMERO DE CONTROL -->
                                    <v-col md=2>
                                        <v-text-field 
                                            v-model="numeroControl"
                                            outlined
                                            label="Número de control"
                                            persistent-hint
                                            v-validate="'required|max:200'"
                                            data-vv-name="numeroControl"
                                            :error="errors.has('numeroControl')"
                                            :error-messages="errors.first('numeroControl')"
                                        ></v-text-field>
                                    </v-col>

                                    <!-- NOMBRE DEL ASISTENTE -->
                                    <v-col md=4>
                                        <v-text-field 
                                            v-model="nombreAsistente"
                                            outlined
                                            label="Nombre(s)"
                                            persistent-hint
                                            v-validate="'required|max:200'"
                                            data-vv-name="nombreAsistente"
                                            :error="errors.has('nombreAsistente')"
                                            :error-messages="errors.first('nombreAsistente')"
                                        ></v-text-field>
                                    </v-col>

                                    <!-- PRIMER APELLIDO DEL ASISTENTE -->
                                    <v-col md=3>
                                        <v-text-field 
                                            v-model="primerApellidoA"
                                            outlined
                                            label="Primer apellido"
                                            persistent-hint
                                            v-validate="'required|max:200'"
                                            data-vv-name="primerApellidoA"
                                            :error="errors.has('primerApellidoA')"
                                            :error-messages="errors.first('primerApellidoA')"
                                        ></v-text-field>
                                    </v-col>

                                     <!-- SEGUNDO APELLIDO DEL ASISTENTE -->
                                     <v-col md=3>
                                        <v-text-field 
                                            v-model="segundoApellidoA"
                                            outlined
                                            label="Segundo apellido"
                                            persistent-hint
                                            v-validate="'required|max:200'"
                                            data-vv-name="segundoApellidoA"
                                            :error="errors.has('segundoApellidoA')"
                                            :error-messages="errors.first('segundoApellidoA')"
                                        ></v-text-field>
                                    </v-col>
                                </v-row>

                                <v-row  class="align-center" style="padding: 0px 50px 0px 50px"> 
                                    
                                     <!-- IDENTIDAD / SEXO -->
                                     <v-col md=5 >   
                                        <p>Sexo</p>                              
                                        <v-radio-group
                                            v-model="sexo"                                                                                         
                                            class="mt-0"
                                            v-validate="'required'"
                                            data-vv-name="tipo de persona"
                                            :error="errors.has('tipo de persona')"
                                            :error-messages="errors.first('tipo de persona')"
                                            row> 
                                            <v-radio
                                                label="Masculino"
                                                value='M'
                                            ></v-radio>
                                            <v-radio
                                                label="Femenino"
                                                value='F'
                                            ></v-radio>
                                            <v-radio
                                                label="No binario"
                                                value='Nb'
                                            ></v-radio>
                                            <v-radio
                                                label="Otro"
                                                value='O'
                                            ></v-radio>
                                        </v-radio-group>
                                    </v-col>

                                     <!-- DISCAPACIDAD -->
                                    <v-col md=3 >   
                                        <p>¿Tiene alguna discapacidad?</p>                                 
                                        <v-radio-group
                                            v-model="discapacidad"
                                        
                                            class="mt-1"
                                            v-validate="'required'"
                                            data-vv-name="discapacidad"
                                            :error="errors.has('discapacidad')"
                                            :error-messages="errors.first('discapacidad')"
                                            row>
                                            <v-radio
                                                label="Si"
                                                value='true'
                                            ></v-radio>
                                            <v-radio
                                                label="No"
                                                value='false'
                                            ></v-radio>
                                        </v-radio-group>
                                </v-col>
                                    <!--TIPO DE DISCAPACIDAD -->
                                    <v-col md=3>
                                    <v-text-field 
                                                v-if="discapacidad === 'true'"
                                                v-model="tipoDiscapacidad"
                                                outlined
                                                label="¿Cuál?"
                                                persistent-hint
                                                v-validate="'required|max:200'"
                                                data-vv-name="tipoDiscapacidad"
                                                :error="errors.has('tipoDiscapacidad')"
                                                :error-messages="errors.first('tipoDiscapacidad')"
                                    ></v-text-field>
                                </v-col>

                                
                            </v-row>

                            <v-row  class="align-center" style="padding: 0px 50px 0px 50px">
                                <!-- DIRECCION -->
                                <v-col md=3>
                                    <v-text-field 
                                        v-model="direccion"
                                        outlined
                                        label="Dirección en la que se encuentra"
                                        persistent-hint
                                        v-validate="'required|max:200'"
                                        data-vv-name="direccion"
                                        :error="errors.has('direccion')"
                                        :error-messages="errors.first('direccion')"
                                    ></v-text-field>
                                </v-col>
                        
                                <!-- PUESTO -->
                                    <v-col md=2>
                                        <v-select 
                                            v-model="puesto"
                                            outlined
                                            label="Puesto"
                                            v-validate="'required'"
                                            :items="arrayPuestos"
                                            item-value="idPuesto"
                                            item-text="nombrePuesto"
                                            data-vv-name="puesto"
                                            :error="errors.has('puesto')"
                                            :error-messages="errors.first('puesto')"
                                        ></v-select>
                                    </v-col>

                                    <v-col md="5">
                                        <v-text-field 
                                          v-if="puesto === 1 || puesto === 2"
                                          v-model="informacionAdicional"
                                          outlined
                                          label="Programa educativo en el que te encuentras"
                                          persistent-hint
                                          v-validate="'required|max:200'"
                                          data-vv-name="informacionAdicional"
                                          :error="errors.has('informacionAdicional')"
                                          :error-messages="errors.first('informacionAdicional')"
                                        ></v-text-field>                
                                      </v-col>
                                </v-row>

         

                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px"> 
                               
                            </v-row>   
                                

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

                
                <v-snackbar v-model="snackbar" top="top" :bottom="true" :multi-line="true" :color="color_snackbar">
                    {{mensaje_snackbar}}
                    <%-- <v-icon color="white" @click="snackbar = false">mdi-close-circle</v-icon> --%>
                </v-snackbar>
                
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
                const ctr = "../../controlador/formacion_docente/controlador_lista_asistencia_capacitacion.jsp";
                //Variables POST
                const nombreEvento = ref("");
                const fecha = ref("");
                const fecha1 = ref("");
                const sesiones = ref("");
                const horas = ref("");
                const nombreInstructor = ref("");
                const horario = ref("");
                const lugar = ref("");
                const tipoActividad = ref("");
                const otraAct = ref("");
                const numeroControl = ref("");
                const nombreAsistente = ref("");
                const primerApellidoA = ref("");
                const segundoApellidoA = ref("");
                const puesto = ref("");
                const sexo = ref("");
                const discapacidad = ref("");
                const tipoDiscapacidad = ref("");
                const direccion = ref("");
                const informacionAdicional = ref("");
                
                
                
                //Otras variables
                const flagEditar = ref(false);
                const itemEditar = ref({});
                //Setup del calendario
                const arrayTiposProveedores = ref([]);
                const arrayTiposActividad = ref([]);
                const arrayHorarios = ref([]);
                const arrayPuestos = ref([]);
                const arrayInstructores = ref([]);
                const arrayLugares = ref([]);

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
                const headersProveedores = ref([
                    {text: 'Nombre Usuario', align: 'left', sortable: true, value: 'rfc'},
                    {text: 'Fecha', align: 'left', sortable: true, value: 'nombre_corto'},
                    {text: 'Estatus Usuario', align: 'left', sortable: true, value: 'nombre_contacto'},
                    {text: 'Estatus Perfil', align: 'left', sortable: true, value: 'tipo_persona'},
                    {text: 'Editar', align: 'left', sortable: true, value: 'editar'},
                    {text: 'Eliminar', align: 'left', sortable: true, value: 'eliminar'},
                ]);
                const searchProveedores = ref([]);

                onMounted(() => {
                    fnTiposActividad();
                    fnTiposProveedor();
                    fnHorarios();
                    fnPuestos();
                    fnInstructores();
                    fnLugares();
                });
                
                async function fnTiposActividad(){
                    try{
                        preloader("../../");
                        let parametros = new URLSearchParams();
                        parametros.append("accion", 1);
                        let {data,status} = await axios.post(ctr, parametros)
                        if(status == 200){
                            if(data.length > 0){
                                arrayTiposActividad.value = data
                            }
                        }
                    } catch(error){
                        mostrarSnackbar('error');
                        console.error(error);
                    } finally{
                        swal.close();
                    }
                }
                
                async function fnHorarios(){
                    try{
                        preloader("../../");
                        let parametros = new URLSearchParams();
                        parametros.append("accion", 7);
                        let {data,status} = await axios.post(ctr, parametros)
                        if(status == 200){
                            if(data.length > 0){
                                arrayHorarios.value = data
                            }
                        }
                    } catch(error){
                        mostrarSnackbar('error');
                        console.error(error);
                    } finally{
                        swal.close();
                    }
                }

                async function fnPuestos(){
                    try{
                        preloader("../../");
                        let parametros = new URLSearchParams();
                        parametros.append("accion", 8);
                        let {data,status} = await axios.post(ctr, parametros)
                        if(status == 200){
                            if(data.length > 0){
                                arrayPuestos.value = data
                            }
                        }
                    } catch(error){
                        mostrarSnackbar('error');
                        console.error(error);
                    } finally{
                        swal.close();
                    }
                }
                
                async function fnInstructores(){
                    try{
                        preloader("../../");
                        let parametros = new URLSearchParams();
                        parametros.append("accion", 9);
                        let {data,status} = await axios.post(ctr, parametros)
                        if(status == 200){
                            if(data.length > 0){
                                arrayInstructores.value = data
                            }
                        }
                    } catch(error){
                        mostrarSnackbar('error');
                        console.error(error);
                    } finally{
                        swal.close();
                    }
                }

                async function fnLugares(){
                    try{
                        preloader("../../");
                        let parametros = new URLSearchParams();
                        parametros.append("accion", 10);
                        let {data,status} = await axios.post(ctr, parametros)
                        if(status == 200){
                            if(data.length > 0){
                                arrayLugares.value = data
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
                                parametros.append("nombreEvento", nombreEvento.value);
                                parametros.append("sesiones",sesiones.value);
                                parametros.append("horas",horas.value);
                                parametros.append("horario", horario.value);
                                parametros.append("nombreInstructor",nombreInstructor.value);
                                parametros.append("lugar",lugar.value);
                                parametros.append("tipoActividad",tipoActividad.value);
                                parametros.append("nombreAsistente",nombreAsistente.value);
                                parametros.append("tipo", tipo.value);
                                parametros.append("numeroControl", numeroControl.value);
                                parametros.append("fecha", fecha.value);
                                parametros.append("rfc", rfc.value);
                                parametros.append("padron", padron.value);
                                parametros.append("nombrePerfil", nombrePerfil.value);
                                parametros.append("correoContacto", correoContacto.value);
                                parametros.append("telefonoContacto", telefonoContacto.value);
                                parametros.append("estatus", estatus.value);
                                parametros.append("pass", rfc.value.substring(0,3) + Math.random().toString(36).slice(-3));
                                let {data,status} = await axios.post(ctr, parametros)
                                if(status == 200){
                                    if(data == "1"){
                                        mostrarSnackbar("success", "Registro guardado correctamente.");

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
                                parametros.append("sesiones", sesiones.value);
                                parametros.append("horas",horas.value);
                                parametros.append("horario", horario.value);
                                parametros.append("nombreInstructor",nombreInstructor.value);
                                parametros.append("lugar",lugar.value);
                                parametros.append("tipoActividad",tipoActividad.value);
                                parametros.append("nombreAsistente",nombreAsistente.value);
                                parametros.append("numeroControl", numeroControl.value);
                                parametros.append("fecha", fecha.value);
                                parametros.append("rfc", rfc.value);
                                parametros.append("padron", padron.value);
                                parametros.append("nombrePerfil", nombrePerfil.value);
                                parametros.append("correoContacto", correoContacto.value);
                                parametros.append("telefonoContacto", telefonoContacto.value);
                                parametros.append("estatus", estatus.value);
                                parametros.append("pass", rfc.value.substring(0,3) + Math.random().toString(36).slice(-3));
                                let {data,status} = await axios.post(ctr, parametros)
                                if(status == 200){
                                    if(data == "1"){
                                        mostrarSnackbar("success", "Registro actualizado correctamente.");
                                        
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
                    nombreEvento.value = "";
                    sesiones.vale = "";
                    horas.value = "";
                    horario.value = "";
                    nombreInstructor.value = "";
                    lugar.value = "";
                    tipoActividad.value = "";
                    nombreAsistente.value = "";
                    numeroControl.value = "";
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
                    
                    nombreEvento, fecha, fecha1, sesiones, horas, nombreInstructor, horario, lugar, tipoActividad, otraAct,
                    numeroControl, nombreAsistente, primerApellidoA, segundoApellidoA, puesto, sexo, discapacidad, direccion,
                    tipoDiscapacidad, arrayLugares, informacionAdicional,
                    
                    dataProveedores, headersProveedores, searchProveedores, arrayTiposProveedores, arrayTiposActividad,arrayHorarios,
                    arrayPuestos, arrayInstructores,
                    dialogBuscador, dialogDetallesCotizacion, dialogProveedor,
                     fnGuardar, fnLimpiarCampos, fnEditar, fnEliminar, itemEditar
                }
            },
            
        });

        Vue.config.devtools = true;
</script>
</html>