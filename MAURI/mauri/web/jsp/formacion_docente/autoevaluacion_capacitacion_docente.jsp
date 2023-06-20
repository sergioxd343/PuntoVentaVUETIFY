
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900" rel="stylesheet">
        <link href="../../styles/icon_material_design_4495/css/materialdesignicons.min.css" rel="stylesheet">
        <link href="../../javascript/VueJs/sweetalert2/sweetalert2.css" />
        <link href="../../javascript/VueJs/vuetify/vuetify.min.css" rel="stylesheet">
        <link rel="shortcut icon" href="../../images/favicon.ico" type="image/x-icon">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui UTF-8">
        <script src="../../javascript/VueJs/vue/vue.js"></script>
        <script type="" src="../../javascript/VueJs/vue/vue-composition-api.prod.js" ></script>
        <title>Autoevaluaci&oacute;n de eficacia de capacitaci&oacute;n docente</title>
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
                            AUTOEVALUACI&Oacute;N DE EFICACIA DE CAPACITACI&Oacute;N DOCENTE
                        </v-card-title>
                        <v-container fluid>

                            <!--Columna-->
                            <v-row justfy="center" dense >
                                <v-col class="text-center"><b>Datos del docente capacitado</b></v-col>
                            </v-row>
                            <v-divider></v-divider>
                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">

                                    <!-- NUMERO DE CONTROL -->
                                    <v-col md=2>
                                        <v-text-field 
                                            v-model="numeroControl"
                                            outlined
                                            label="N&uacute;mero de control"
                                            persistent-hint
                                            v-validate="'required|max:200'"
                                            data-vv-name="numeroControl"
                                            :error="errors.has('numeroControl')"
                                            :error-messages="errors.first('numeroControl')"
                                            @keyup.enter="fnBuscarDocente()"
                                        ></v-text-field>
                                    </v-col>

                                    <!-- NOMBRE DEL DOCENTE -->
                                    <v-col md=4>
                                        <v-text-field 
                                            disabled
                                            v-model="nombreDocente"
                                            outlined
                                            label="Nombre(s)"
                                            persistent-hint
                                            v-validate="'required|max:200'"
                                            data-vv-name="nombreDocente"
                                            :error="errors.has('nombreDocente')"
                                            :error-messages="errors.first('nombreDocente')"
                                        ></v-text-field>
                                    </v-col>

                                    <!-- PRIMER APELLIDO DEL DOCENTE -->
                                    <v-col md=3>
                                        <v-text-field 
                                            disabled
                                            v-model="primerApellidoD"
                                            outlined
                                            label="Primer apellido"
                                            persistent-hint
                                            v-validate="'required|max:200'"
                                            data-vv-name="primerApellidoD"
                                            :error="errors.has('primerApellidoD')"
                                            :error-messages="errors.first('primerApellidoD')"
                                        ></v-text-field>
                                    </v-col>

                                     <!-- SEGUNDO APELLIDO DEL DOCENTE -->
                                     <v-col md=3>
                                        <v-text-field 
                                            disabled
                                            v-model="segundoApellidoD"
                                            outlined
                                            label="Segundo apellido"
                                            persistent-hint
                                            v-validate="'required|max:200'"
                                            data-vv-name="segundoApellidoD"
                                            :error="errors.has('segundoApellidoD')"
                                            :error-messages="errors.first('segundoApellidoD')"
                                        ></v-text-field>
                                    </v-col>
                                </v-row>

                                
                                <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">

                                <!-- IDENTIDAD / SEXO -->
                                <v-col md=5 >   
                                    <p>Sexo</p>                              
                                    <v-radio-group
                                        disabled
                                        v-model="sexo"                                                                                         
                                        class="mt-0"
                                        v-validate="'required'"
                                        data-vv-name="tipo de persona"
                                        :error="errors.has('tipo de persona')"
                                        :error-messages="errors.first('tipo de persona')"
                                        row> 
                                        <v-radio
                                            label="Masculino"
                                            value='Masculino'
                                        ></v-radio>
                                        <v-radio
                                            label="Femenino"
                                            value='Femenino'
                                        ></v-radio>
                                        <v-radio
                                            label="No binario"
                                            value='No binario'
                                        ></v-radio>
                                        <v-radio
                                            label="Otro"
                                            value='Otro'
                                        ></v-radio>
                                    </v-radio-group>
                                </v-col>

                                <!-- PUESTO -->
                                <v-col md=2 >   
                                    <p>Puesto</p>                              
                                    <v-radio-group
                                        disabled
                                        v-model="puesto"                                                                                         
                                        class="mt-0"
                                        v-validate="'required'"
                                        data-vv-name="puesto"
                                        :error="errors.has('puesto')"
                                        :error-messages="errors.first('puesto')"
                                        row> 
                                        <v-radio
                                            label="PTC"
                                            value='PTC'
                                        ></v-radio>
                                        <v-radio
                                            label="PA"
                                            value='PA'
                                        ></v-radio>

                                    </v-radio-group>
                                </v-col>

                                  <!-- AREA -->
                                 <v-col md=3>
                                    <v-text-field 
                                        disabled
                                        v-model="area"
                                        outlined
                                        label="Área"
                                        v-validate="'required'"
                                        :items="arrayAreas"
                                        item-value="cve_area"
                                        item-text="nombre_area"
                                        data-vv-name="area"
                                        :error="errors.has('area')"
                                        :error-messages="errors.first('area')"
                                    ></v-text-field>
                                </v-col>

                                
                                <!--CARRERA-->

                                <v-col md=2>
                                    <v-text-field   
                                        disabled
                                        v-model="carrera"
                                        outlined
                                        label="Carrera"
                                        persistent-hint
                                        v-validate="'required|max:200'"
                                        data-vv-name="carrera"
                                        :error="errors.has('carrera')"
                                        :error-messages="errors.first('carrera')"
                                    ></v-text-field>
                                </v-col>

                               <!-- <v-col md=2>
                                    <v-select 
                                        v-model="carrera"
                                        outlined
                                        label="Carrera"
                                        v-validate="'required'"
                                        :items="arrayCarreras"
                                        item-value="idCarrera"
                                        item-text="nombre"
                                        data-vv-name="carrera"
                                        :error="errors.has('carrera')"
                                        :error-messages="errors.first('carrera')"
                                    ></v-select>
                                </v-col> -->
                                </v-row> <br>

                                <v-row justfy="center" dense >
                                    <v-col class="text-center"><b>Datos del curso asistido </b></v-col>
                                </v-row>
                                <v-divider></v-divider> 
                                <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                    <!--TEMA-->
                                    <v-col md=3>
                                        <v-text-field 
                                            v-model="tema"
                                            outlined
                                            label="Tema"
                                            persistent-hint
                                            v-validate="'required|max:200'"
                                            data-vv-name="tema"
                                            :error="errors.has('tema')"
                                            :error-messages="errors.first('tema')"
                                        ></v-text-field>
                                    </v-col>

                                    <!--OBJETIVO-->
                                    <v-col md=4>
                                        <v-text-field 
                                            v-model="objetivo"
                                            outlined
                                            label="Objetivo"
                                            v-validate="'required|max:200'"
                                            data-vv-name="objetivo"
                                            :error="errors.has('objetivo')"
                                            :error-messages="errors.first('objetivo')"
                                        ></v-text-field>
                                    </v-col>

                                    <!--ALCANCE-->
                                    <v-col md=5>
                                        <v-text-field
                                            v-model="alcance"
                                            outlined
                                            label="Alcance"
                                            v-validate="'required|max:20'"
                                            data-vv-name="alcance"
                                            :error="errors.has('alcance')"
                                            :error-messages="errors.first('alcance')"
                                        ></v-text-field>
                                    </v-col>
                                </v-row>

                                <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                    <!--PERIODO-->
                                <v-col md=6>
                                    <v-text-field
                                        v-model="periodo"
                                        outlined
                                        label="Periodo"
                                        v-validate="'required|max:10'"
                                        data-vv-name="periodo"
                                        :error="errors.has('periodo')"
                                        :error-messages="errors.first('periodo')"
                                    ></v-text-field>
                                </v-col>

                                 <!-- AREA EN QUE SE CAPACITO -->
                                 <v-col md=3>
                                    <v-select 
                                        v-model="areaCapacitacion"
                                        outlined
                                        label="Competencia en que se capacito"
                                        v-validate="'required'"
                                        :items="arrayAreasCapacitacion"
                                        item-value="cve_area"
                                        item-text="nombre_area"
                                        data-vv-name="areaCapacitacion"
                                        :error="errors.has('areaCapacitacion')"
                                        :error-messages="errors.first('areaCapacitacion')"
                                    ></v-select>
                                </v-col>
                                
                                <!-- FECHA DEL EVENTO -->
                                  <v-col cols="12" sm="6" md="3" >
                                    <v-dialog
                                        ref="dialog"
                                        :return-value.sync="fecha"
                                        //persistent
                                        width="290px"
                                    >
                                        <template v-slot:activator="{ on, attrs }">
                                        <v-text-field
                                            v-model="fecha"
                                            label="Fecha"
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

                               
                                </v-row>
                                
                                <v-row class="align-center" style="padding: 0px 50px 0px 100px">
                                    <v-p> <b>Conteste las siguientes preguntas de manera objetiva, considerando la siguiente escala: <br>
                                        10. Totalmente de acuerdo					<br>
                                        9. De acuerdo					<br>
                                        8. Ni de acuerdo ni en desacuerdo	<br>				
                                        7. En desacuerdo					<br>
                                        6. Totalmente en desacuerdo
                                        </b>
                                    </v-p>
                                </v-row>

                                <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">

                                    <v-col md=10>
                                        <v-p>1.- &#191;El contenido del curso me permiti&oacute; identificar t&eacute;cnicas, estrategias 
                                            y/ o acciones para la mejora mis funciones docentes?</v-p>
                                    </v-col>

                                    <v-col md=2>
                                        <v-select 
                                        v-model="escala1"
                                        outlined
                                        v-validate="'required'"
                                        :items="arrayEscala"
                                        item-value="idEscala"
                                        item-text="numero"
                                        data-vv-name="escala"
                                        :error="errors.has('escala')"
                                        :error-messages="errors.first('escala')"
                                        ></v-select>
                                    </v-col>
                                </v-row>

                                <v-row class="align-center" style="padding: 0px 50px 0px 50px">
                                    <v-col md=6>
                                        
                                        <v-text-field 
                                            v-if="escala1 === 1 || escala1 === 2  "
                                            v-model="otraAct"
                                            outlined
                                            label="Indique brevemente los factores que no permitieron su identificación"
                                            persistent-hint
                                            v-validate="'required|max:200'"
                                            data-vv-name="otraAct"
                                            :error="errors.has('otraAct')"
                                            :error-messages="errors.first('otraAct')"
                                        ></v-text-field>
                                        
                        
                                    </v-col>
                                </v-row>

                                <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">

                                    <v-col md=10>
                                        <v-p> 
                                            2.- Posterior al curso de capacitaci&oacute;n, &#191;Gener&eacute; propuestas de mejora en mi pr&aacute;ctica docente?
                                        </v-p>
                                    </v-col>

                                    <v-col md=2>
                                        <v-select 
                                        v-model="escala2"
                                        outlined
                                        v-validate="'required'"
                                        :items="arrayEscala"
                                        item-value="idEscala"
                                        item-text="numero"
                                        data-vv-name="tipo"
                                        :error="errors.has('tipo')"
                                        :error-messages="errors.first('tipo')"
                                        ></v-select>
                                    </v-col>
                                </v-row>

                                <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">

                                    <v-col md=10>
                                        <v-p> 
                                            3.- &#191;En mi pr&aacute;ctica docente del cuatrimestre actual puse en pr&aacute;ctica las competencias adquiridas en el curso de capacitaci&oacute;n?
                                        </v-p>
                                    </v-col>

                                    <v-col md=2>
                                        <v-select 
                                        v-model="escala3"
                                        outlined
                                        v-validate="'required'"
                                        :items="arrayEscala"
                                        item-value="idEscala"
                                        item-text="numero"
                                        data-vv-name="tipo"
                                        :error="errors.has('tipo')"
                                        :error-messages="errors.first('tipo')"
                                        ></v-select>
                                    </v-col>
                                </v-row>

                                <v-row class="align-center" style="padding: 0px 50px 0px 50px">
                                    <v-col md=6>
                                        <v-text-field 
                                        v-if="escala3 === 6 || escala3 === 7  "
                                            v-model="otraAct"
                                            outlined
                                            label="Indique brevemente los factores que no permitieron su aplicación"
                                            persistent-hint
                                            v-validate="'required|max:200'"
                                            data-vv-name="otraAct"
                                            :error="errors.has('otraAct')"
                                            :error-messages="errors.first('otraAct')"
                                        ></v-text-field>
                                        
                        
                                    </v-col>
                                </v-row>

                                <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">

                                    <v-col md=10>
                                        <v-p> 
                                            4.- La aplicaci&oacute;n de las nuevas competencias en mi pr&aacute;ctica docente mostr&oacute; mejoras en el desempe&ntilde;o de mis estudiantes:
                                        </v-p>
                                    </v-col>

                                    <v-col md=2>
                                        <v-select 
                                        v-model="escala4"
                                        outlined
                                        v-validate="'required'"
                                        :items="arrayEscala"
                                        item-value="idEscala"
                                        item-text="numero"
                                        data-vv-name="tipo"
                                        :error="errors.has('tipo')"
                                        :error-messages="errors.first('tipo')"
                                        ></v-select>
                                    </v-col>
                                </v-row>

                                <v-row  class="align-center" style="padding: 0px 50px 0px 50px">

                                    <v-col md=10>
                                        <v-p> 
                                            5.- Seleccione la(s) evidencia(s) que utiliz&oacute; para verificar el impacto de las t&eacute;cnicas, estrategias o acciones aprendidas en el curso:
                                        </v-p>
                                    </v-col>
                                </v-row>

                                <v-row  class="align-center" style="padding: 0px 200px 0px 200px"></v-row>
                                <v-col md=10>
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<input type="checkbox" id="kiki" v-model="option">
                                    <label for="kiki">Calificaciones de estudiantes</label> <br>

                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<input type="checkbox" id="kiki" v-model="option1">
                                    <label for="kiki">Encuestas a estudiantes </label> <br>

                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<input type="checkbox" id="kiki" v-model="option2">
                                    <label for="kiki">Resultados de evaluaci&oacute;n docente </label> <br>

                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<input type="checkbox" id="kiki" v-model="option3">
                                    <label for="kiki">Entrevistas a estudiantes</label><br>

                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<input type="checkbox" id="kiki" v-model="option4">
                                    <label for="kiki">Ninguno</label><br>
                                </v-col>

                                <v-col md=4>
                                    <v-text-field 
                                        v-model="otro"
                                        outlined
                                        label="Otro"
                                        v-validate="'required|max:200'"
                                        data-vv-name="otro"
                                        :error="errors.has('otro')"
                                        :error-messages="errors.first('otro')"
                                    ></v-text-field>
                                </v-col>



                                    
                                    
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

                
                
                

                <!-- TODO: ALERTAS DE SISTEMA-->
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
                const ctr = "../../controlador/formacion_docente/controlador_catalogo_autoevaluacion_capacitacion_docente.jsp";

                const numeroControl= ref("");
                const nombreDocente = ref("");
                const primerApellidoD = ref("");
                const segundoApellidoD = ref("");
                const sexo = ref("");
                const puesto = ref("");
                const area = ref("");
                const carrera = ref("");
                const tema = ref("");
                const objetivo = ref("");
                const alcance = ref("");
                const periodo = ref("");
                const fecha = ref("");
                const areaCapacitacion = ref("");
                const escala1 = ref("");
                const escala2 = ref("");
                const escala3 = ref("");
                const escala4 = ref("");
                const escala5 = ref("");
                const otraAct = ref("");
                const option = ref("");
                const option1 = ref("");
                const option2 = ref("");
                const option3 = ref("");
                const option4 = ref("");
                const otro = ref("");

                

                const arrayAreas = ref(["Tecnologias de la informacion","Quimica"]);
                const arrayCarreras = ref([]);
                const arrayAreasCapacitacion = ref(["Estrategias pedagógicas", "Comunicación", 
                "Herramientas digitales", "Tutoreo", "Procesos institucionales", "Investigación", 
                "Competencias técnicas"]);
                const arrayEscala = ref([10,9,8,7,6]);
                const dataBusqueda = ref([]);


                

                
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
                const dialogBuscador = ref(true);
                const nombreBuscar = ref('');
                const searchBusqueda = ref('');

                const dialogDetallesCotizacion = ref(false);
                const dialogProveedor = ref(false);

                //DataTable
                const headers = ref([]);
                const dataProveedores = ref([]);
                const headersProveedores = ref([
                    {text: 'N° de control', align: 'left', sortable: true, value: 'cve_empleado'},
                    {text: 'Nombre del docente', align: 'left', sortable: true, value: 'nombre'},
                    {text: 'Tema del curso', align: 'left', sortable: true, value: 'tema_curso'},
                    {text: 'Objetivo del curso', align: 'left', sortable: true, value: 'objetivo_curso'},
                    {text: 'Editar', align: 'left', sortable: true, value: 'editar'},
                    {text: 'Eliminar', align: 'left', sortable: true, value: 'eliminar'},
                ]);
                const searchProveedores = ref([]);

                

                onMounted(() => {
                    fnConsultarTabla();
                    fnbuscar_cve_docente();
                });
                
                async function fnGuardar(){
                    this.$validator.validate().then(async esValido => {
                        if(esValido){
                            try{
                                preloader("../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 2);
                                parametros.append("numeroControl", numeroControl.value);
                                parametros.append("tema", tema.value);
                                parametros.append("objetivo", objetivo.value);
                                parametros.append("alcance", alcance.value);
                                parametros.append("periodo", periodo.value);
                                parametros.append("fecha", fecha.value);
                                parametros.append("escala1", escala1.value);
                                
                                let {data,status} = await axios.post(ctr, parametros);
                                console.log(parametros);
                                if(status == 200){
                                    if(data == "1"){
                                        mostrarSnackbar("success", "Registro guardado correctamente.");
                                        fnConsultarTabla();
                                        fnLimpiarCampos(this);   
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
                
                
                async function fnbuscar_cve_docente(){
                    try{
                        preloader("../../");
                        let parametros = new URLSearchParams();
                        parametros.append("accion", 3);
                        let {data,status} = await axios.post(ctr, parametros)
                        if(status == 200){
                            if(data.length > 0){
                                dataBusqueda.value = data
                            }
                        }
                    } catch(error){
                        mostrarSnackbar('error');
                        console.error(error);
                    } finally{
                        swal.close();
                    }
                }

                async function fnBuscarDocente() {

                    const numeroControl = this.numeroControl;
                    console.log(numeroControl);

                    for (let i = 0; i < this.dataBusqueda.length; i++) {
                        if (numeroControl === this.dataBusqueda[i].cve_persona.toString()) {
                            this.nombreDocente = this.dataBusqueda[i].nombre;
                            this.primerApellidoD = this.dataBusqueda[i].apellido_peterno;
                            this.segundoApellidoD = this.dataBusqueda[i].apellido_materno;
                            this.sexo = this.dataBusqueda[i].sexo;
                            this.puesto = this.dataBusqueda[i].nombre_tipo_puesto;
                            this.area = this.dataBusqueda[i].nombre_area;
                            this.carrera = this.dataBusqueda[i].nombre_ugac;
                        break; 
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: 'El número de control no coincide.',
                            });
                        }
                    }

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
                    nombreBuscar,

                    numeroControl, nombreDocente, primerApellidoD, segundoApellidoD, sexo, puesto, area, carrera, tema,
                    objetivo, alcance, periodo, fecha, areaCapacitacion, escala1, escala2, escala3, escala4, escala5,  otraAct,
                    option, option1, option2, option3, option4, otro,
                    

                    arrayAreas, arrayCarreras, arrayAreasCapacitacion, arrayEscala,
                    
                    
                    dataProveedores, headersProveedores, searchProveedores, arrayTiposProveedores, 
                    dialogBuscador, dialogDetallesCotizacion, dialogProveedor,
                    fnLimpiarCampos, itemEditar, searchBusqueda, fnBuscarDocente,
                    dataBusqueda, fnConsultarTabla, fnGuardar
                }
            },
            
        });

        Vue.config.devtools = true;
</script>
</html>