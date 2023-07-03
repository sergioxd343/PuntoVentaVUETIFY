<%@page contentType="text/html; charset=UTF-8" language="java" errorPage="" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900" rel="stylesheet" />
        <link href="../../styles/icon_material_design_4495/css/materialdesignicons.min.css" rel="stylesheet" />
        <link href="../../javascript/VueJs/sweetalert2/sweetalert2.css" />
        <link href="../../javascript/VueJs/vuetify/vuetify.min.css" rel="stylesheet" />
        <link rel="shortcut icon" href="../../images/favicon.ico" type="image/x-icon">
        <meta name="viewport"
            content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui" />
        <script src="../../javascript/VueJs/vue/vue.js"></script>
        <script type="" src="../../javascript/VueJs/vue/vue-composition-api.prod.js"></script>
        <title>Solicitud apoyo para la formación docente</title>
    </head>
    <style>
        body {
            font-family: "Roboto";
        }

        .direccion {
            width: 100%;
        }


        .th,
        .td {
            border: 1px solid black;
            padding: 10px;
        }

        .th {
            background-color: #41da9f;
        }

        .tituloTh {
            font-weight: bold;
            margin-left: 39px;
            margin-right: 39px;
            text-align: center;
        }

        #tabla {
            border-collapse: collapse;
            margin: auto;
        }

        .align-center {
            align-items: center;
        }
    </style>

    <body>
        <div id="app">
            <v-app>
                <v-container fluid>
                    <v-card>
                        <v-card-title style="background-color: #00b293; color:#ffffff;">
                            Solicitud de apoyo para la formación docente
                        </v-card-title>
                        <v-container fluid>
                            <v-row justify="center" dense>
                                <v-row style="padding: 0px 50px 0px 50px">
                                    
                                    <v-col md="5" justify="center" class="align-center">
                                        <v-radio-group v-model="direccionAcademia" label="Unidad Académica"
                                            v-validate="'required'" data-vv-name="unidad académica"
                                            :error="errors.has('unidad académica')"
                                            :error-messages="errors.first('unidad académica')"
                                            row>
                                            <v-radio label="León" value="León"></v-radio>
                                            <v-radio label="Acámbaro" value="Acámbaro"></v-radio>
                                        </v-radio-group>
                                    </v-col>
                                    
                                    <v-col md="4" class="align-end">
                                        <v-menu ref="menu" :close-on-content-click="false" :return-value.sync="fecha"
                                            transition="scale-transition" offset-y min-width="auto">
                                            <template v-slot:activator="{ on, attrs }">
                                                <v-text-field v-validate="'required'" data-vv-name="fecha"
                                                    :error="errors.has('fecha')" v-model="fecha" label="Fecha"
                                                    :error-messages="errors.first('fecha')" prepend-icon="mdi-calendar"
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
                                    
                                </v-row>
                                
                                <template>
                                    <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                        <v-col md="12">
                                            <p class="tituloTh" style="margin-bottom: 0px;">
                                              Dirección Académica
                                            </p>
                                            <table id="tabla">
                                              <tbody>
                                                <tr>
                                                  <th class="th">Área</th>
                                                  <th class="th">EA</th>
                                                  <th class="th">TEEI</th>
                                                  <th class="th">DAyD</th>
                                                  <th class="th">Idiomas</th>
                                                </tr>
                                                <tr>
                                                  <th class="th">Programa Educativo</th>
                                                  <td class="td" style="width: 200px;">
                                                    <v-radio-group v-model="selectedArea" row>
                                                      <v-radio  value="EA" class="align-center"></v-radio>
                                                    </v-radio-group>
                                                  </td>
                                                  <td class="td" style="width: 200px;">
                                                    <v-radio-group v-model="selectedArea" row>
                                                      <v-radio value="TEEI"></v-radio>
                                                    </v-radio-group>
                                                  </td>
                                                  <td class="td" style="width: 200px;">
                                                    <v-radio-group v-model="selectedArea" row>
                                                      <v-radio value="DAyD"></v-radio>
                                                    </v-radio-group>
                                                  </td>
                                                  <td class="td" style="width: 200px;">
                                                    <v-radio-group v-model="selectedArea" row>
                                                      <v-radio value="Idiomas"></v-radio>
                                                    </v-radio-group>
                                                  </td>
                                                </tr>
                                              </tbody>
                                            </table>
                                          </v-col>
                                    </v-row> 
                                </template>

                                <template>
                                    <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                        <v-col md="12">
                                            <table id="tabla">
                                                <tbody>
                                                    <tr>
                                                        <th class="th">N°</th>
                                                        <th class="th">Número de empleado(a) o alumnado</th>
                                                        <th class="th">Nombre completo del participante</th>
                                                        <th class="th">Sexo</th>
                                                        <th class="th">PTC</th>
                                                        <th class="th">Tecnico docente</th>
                                                        <th class="th">Alumnado</th>
                                                        <th class="th">Personal administrativo o del área academica</th>
                                                        <th class="th">Otro</th>
                                                    </tr>
                                                    <tr v-for="index in numberOfInputs" :key="index">
                                                        <th class="th"> {{ index === 0 ? index + 1 : index }} </th>
                                                        <td class="td">
                                                            <v-text-field 
                                                                v-model="numEmpleado[index]" 
                                                                outlined
                                                                persistent-hint
                                                            ></v-text-field>
                                                        </td>
                                                        <td class="td">
                                                            <v-text-field 
                                                                v-model="nombreParticipante[index]" 
                                                                outlined
                                                                persistent-hint>
                                                            </v-text-field>
                                                        </td>
                                                        <td class="td">
                                                            <v-radio-group v-model="sexo[index]" v-validate="'required'"
                                                            data-vv-name="sexo" :error="errors.has('sexo')"
                                                            :error-messages="errors.first('sexo')">
                                                            <v-radio label="M" value="horario trabajo"></v-radio>
                                                            <v-radio label="F" value="fuera horario"></v-radio>
                                                            </v-radio-group>
                                                        </td>
                                                        <td class="td">
                                                            <v-checkbox v-model="ptc[index]" value="ptc" @change="handleCheckboxChange(index, ptc)"></v-checkbox>
                                                        </td>
                                                        <td class="td">
                                                            <v-checkbox v-model="tecnico[index]" value="tecnico" @change="handleCheckboxChange(index, tecnico)"></v-checkbox>
                                                        </td>
                                                        <td class="td">
                                                            <v-checkbox v-model="alumnado[index]" value="alumnado" @change="handleCheckboxChange(index, alumnado)"></v-checkbox>
                                                        </td>
                                                        <td class="td ">
                                                            <v-checkbox v-model="admin[index]" value="administrativo" @change="handleCheckboxChange(index, admin)"></v-checkbox>
                                                        </td>
                                                        <td class="td">
                                                            <v-checkbox v-model="otro[index]" value="otro" @change="handleCheckboxChange(index, otro)"></v-checkbox>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </v-col>
                                    </v-row>
                                </template>
                                <br>

                                <v-tooltip top>
                                    <template v-slot:activator="{ on, attrs }">
                                        <v-btn color="primary" v-bind="attrs" v-on="on"
                                            @click="numberOfInputs++"><v-icon>mdi-account-multiple-plus</v-icon></v-btn>
                                    </template>
                                    <span>Agregar participante</span>
                                </v-tooltip>

                                <v-row class="align-center" style="padding: 0px 50px 0px 50px">

                                    <v-col md="5">
                                        <v-text-field v-model="nombrePrograma" outlined
                                            label="Nombre del programa solicitado" persistent-hint
                                            v-validate="'required|max:500'"
                                            data-vv-name="nombre del programa solicitado"
                                            :error="errors.has('nombre del programa solicitado')"
                                            :error-messages="errors.first('nombre del programa solicitado')"></v-text-field>
                                    </v-col>

                                
                                    <v-col md="9">
                                        <p>Seleccione Tipo de Evento:</p>
                                        <v-row class="light--text">
                                            <v-col cols="4">
                                                <v-checkbox v-model="tipoEvento" label="Capacitación (3340)"
                                                    value="Capacitación (3340)"></v-checkbox>
                                            </v-col>
                                            <v-col cols="4">
                                                <v-checkbox v-model="tipoEvento" label="Ponencia en congreso (3830)"
                                                    value="Ponencia en congreso (3830)"></v-checkbox>
                                            </v-col>
                                            <v-col cols="4">
                                                <v-checkbox v-model="tipoEvento" label="Certificación (3920)"
                                                    value="Certificación (3920)"></v-checkbox>
                                            </v-col>
                                        </v-row>
                                        <v-row class="light--text">
                                            <v-col cols="4">
                                                <v-checkbox v-model="tipoEvento" label="Estancia de Investigación"
                                                    value="Estancia de Investigación"></v-checkbox>
                                            </v-col>
                                            <v-col cols="4">
                                                <v-checkbox v-model="tipoEvento" label="Convocatoria"
                                                    value="Convocatoria"></v-checkbox>
                                            </v-col>
                                            <v-col cols="4">
                                                <v-checkbox v-model="enabled" label="Otro" value="otro" hide-details
                                                    class="shrink mr-2 mt-0"></v-checkbox>
                                                <v-text-field @change="agregarOtroTipoEvento()" :disabled="!enabled"
                                                    v-model="tipoEventoOtro" label="Especificar"></v-text-field>
                                            </v-col>
                                        </v-row>
                                    </v-col>
                                    
                                    <v-col md="3" justify="center" class="align-center">
                                        <v-radio-group v-model="modalidad" label="Modalidad" v-validate="'required'"
                                            data-vv-name="modalidad" :error="errors.has('modalidad')"
                                            :error-messages="errors.first('modalidad')">
                                            <v-radio label="En horario de trabajo" value="horario trabajo"></v-radio>
                                            <v-radio label="Fuera de horario" value="fuera horario"></v-radio>
                                            <v-radio label="No se requiere presupuesto" value="no requiere"></v-radio>
                                        </v-radio-group>
                                    </v-col>
                                </v-row>
                                <v-row justify="center" dense>
                                    
                                </v-row>

                                
                                 
                                
                                <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                    
                                    <v-col md="3">
                                        <v-text-field v-model="lugar" outlined label="Lugar"
                                            persistent-hint v-validate="'required|max:500'" data-vv-name="centro gestor"
                                            :error="errors.has('centro gestor')"
                                            :error-messages="errors.first('centro gestor')"></v-text-field>
                                    </v-col>

                                    <v-col md="3">
                                        <v-text-field v-model="horario" label="Horario" v-validate="'required'"
                                            :error="errors.has('horario')" data-vv-name="horario"
                                            :error-messages="errors.first('horario')"
                                            prepend-icon="mdi-clock-outline"></v-text-field>
                                    </v-col>

                                    <v-col md="3">
                                        <v-text-field v-model="numHoras" outlined label="Número de horas"
                                            persistent-hint v-validate="'required|max:500'" data-vv-name="centro gestor"
                                            :error="errors.has('centro gestor')"
                                            :error-messages="errors.first('centro gestor')"></v-text-field>
                                    </v-col>

                                    <v-col md="3">
                                        <v-menu 
                                            ref="menu1" 
                                            :close-on-content-click="false"
                                            :return-value.sync="fechaInicio" 
                                            transition="scale-transition" 
                                            offset-y
                                            min-width="auto">
                                            <template v-slot:activator="{ on, attrs }">
                                                <v-text-field 
                                                    v-validate="'required'" 
                                                    data-vv-name="fecha inicio"
                                                    :error="errors.has('fecha inicio')" 
                                                    v-model="fechaInicio"
                                                    label="Fecha Inicio" 
                                                    :error-messages="errors.first('fecha inicio')"
                                                    prepend-icon="mdi-calendar" 
                                                    readonly v-bind="attrs"
                                                    v-on="on"></v-text-field>
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
                                    

                                    <v-col md="4">
                                        <v-text-field v-model="centroGestor" outlined label="Centro Gestor"
                                            persistent-hint v-validate="'required|max:500'" data-vv-name="centro gestor"
                                            :error="errors.has('centro gestor')"
                                            :error-messages="errors.first('centro gestor')"></v-text-field>
                                    </v-col>
                                    <v-col md="4">
                                        <v-text-field v-model="proyectoPresupuestal" outlined
                                            label="Proyecto Presupuestal" persistent-hint
                                            v-validate="'required|max:500'" data-vv-name="proyecto presupuestal"
                                            :error="errors.has('proyecto presupuestal')"
                                            :error-messages="errors.first('proyecto presupuestal')"></v-text-field>
                                    </v-col>
                                    <v-col md="4">
                                        <v-text-field  v-model="costoTotal" prefix="$" outlined label="Costo total" persistent-hint
                                            v-validate="'required|max:500'" data-vv-name="costo total"
                                            :error="errors.has('costo total')"
                                            :error-messages="errors.first('costo total')"></v-text-field>
                                    </v-col>
                                </v-row>
                                <template>
                                    <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                        <v-col md="12">
                                            <p class="tituloTh" style="margin-bottom: 0px; cursor: pointer;"
                                                @mouseover="showAlert = true" @mouseleave="showAlert = false">
                                                Transferencia bancaria<br>
                                                Dato de control
                                            </p>
                                            <v-alert style="margin-left: 39px;margin-right: 39px;margin-bottom: 0px;"
                                                v-if="showAlert" border="top" colored-border type="info" elevation="2">
                                                En caso de solicitar pago al interesado(a), favor de mencionar solo
                                                nombre y si es a un proveedor
                                                completar todos los datos bancarios (si el evento es partida 3340, dejar
                                                en blanco este espacio)
                                            </v-alert>
                                            <table id="tabla">
                                                <tbody>
                                                    <tr>
                                                        <th class="th">A nombre de:</th>
                                                        <td class="td" style="padding-right: 646px;"><v-text-field
                                                                v-model="ea" outlined persistent-hint></v-text-field>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <th class="th">Número de cuenta:</th>
                                                        <td class="td" style="padding-right: 646px;"><v-text-field
                                                                v-model="dayd" outlined type="number"
                                                                persistent-hint></v-text-field></td>
                                                    </tr>
                                                    <tr>
                                                        <th class="th">Plaza:</th>
                                                        <td class="td" style="padding-right: 646px;"><v-text-field
                                                                v-model="idiomas" outlined
                                                                persistent-hint></v-text-field></td>
                                                    </tr>
                                                    <tr>
                                                        <th class="th">Banco:</th>
                                                        <td class="td" style="padding-right: 646px;"><v-text-field
                                                                v-model="idiomas" outlined
                                                                persistent-hint></v-text-field></td>
                                                    </tr>
                                                    <tr>
                                                        <th class="th">Clabe interbancaria (18 dígitos):</th>
                                                        <td class="td" style="padding-right: 646px;"><v-text-field
                                                                type="number" v-model="teei" outlined
                                                                persistent-hint></v-text-field>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </v-col>
                                    </v-row>
                                </template>
                                <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                    <v-col md="12">
                                        <v-textarea v-model="observaciones" data-vv-name="observaciones"
                                            :error="errors.has('observaciones')"
                                            :error-messages="errors.first('observaciones')" label="Observaciones"
                                            persistent-hint hint="(A llenar por quien revisa)"
                                            v-validate="'required|max:500'" auto-grow outlined rows="1"
                                            row-height="15"></v-textarea>
                                    </v-col>
                                    <v-alert outlined type="warning" prominent border="left">
                                        <strong>Políticas para considerar por el/la solicitante en caso de autorización:</strong><br>
                                        &#10022; Es responsabilidad del solicitante realizar los trámites de comprobación
                                        conforme se establece en el SGI.<br>
                                        &#10022; Se compromete a aplicar los conocimientos adquiridos en las actividades o
                                        funciones que realice y a reproducir con eficiencia y calidad la información
                                        obtenida.<br>
                                        &#10022; Se compromete a acreditar el curso o taller solicitado, entregando al área
                                        correspondiente el comprobante que avale el término y la aprobación del curso de
                                        lo contrario tendrá que reembolsar el monto pagado por la UTL y no podrá
                                        solicitar otra capacitación hasta que entregue la comprobación anterior.

                                    </v-alert>
                                </v-row>
                            </v-row>
                            <%-- <v-row justfy="center" dense> </v-row> --%>
                                <v-row justify="center">
                                    <v-btn color="primary"
                                        @click="flagEditar ? fnEditar() : fnGuardar()"><v-icon>mdi-content-save</v-icon>{{flagEditar
                                        ? 'Editar' : 'Guardar'}}</v-btn>
                                    &nbsp;
                                    <v-btn color="error"
                                        @click="fnLimpiarCampos()"><v-icon>mdi-cancel</v-icon>Cancelar</v-btn>
                                </v-row>
                                <v-row justify="center">
                                    <v-col md="12">
                                        <v-data-table :headers="headerCapacitacion" :items="dataSolicitudCapacitacion"
                                            class="elevation-2" no-data-text="No se encontro ningun registro"
                                            :hide-default-header="dataSolicitudCapacitacion.length < 1"
                                            :hide-default-footer="dataSolicitudCapacitacion.length < 1" locale="es-ES"
                                            :mobile-breakpoint="NaN" items-per-page="10">
                                        </v-data-table>
                                    </v-col>
                                </v-row>
                        </v-container>
                    </v-card>
                </v-container>
                <!-- TODO: ALERTAS DE SISTEMA-->
                <v-snackbar v-model="snackbar" top="top" :bottom="true" :multi-line="true" :color="color_snackbar">
                    {{ mensaje_snackbar }}
                    <%-- <v-icon color="white" @click="snackbar = false">mdi-close-circle</v-icon>
                        --%>
                </v-snackbar>
                <v-overlay :value="loader" z-index="1000">
                    <v-img aspect-ratio="2" class="white--text align-end" height="212px" width="292px"
                        src="../images/Logo_utl_animado.gif">
                    </v-img>
                </v-overlay>
            </v-app>
        </div>
    </body>
    <script src="../../javascript/axios/axios.js"></script>
    <script src="../../javascript/VueJs/vuetify/vuetify.min.js"></script>
    <script src="../../javascript/VueJs/vee-validate/vee-validate.js"></script>
    <script src="../../javascript/VueJs/vee-validate/es.js"></script>
    <script src="../../javascript/VueJs/sweetalert2/sweetalert2.all.js"></script>

    <%--Desarrollo--%>
        <script type="module">
            import {
                preloader,
                guardar,
                errorGuardar,
                actualizar,
                errorActualizar,
                eliminar,
                errorEliminar,
                cerrar,
                confirmarE,
                aviso,
                confirmar,
            } from "../../javascript/mensajeSistema/mensajes_sweetalert_vue.js";
            Vue.use(VeeValidate, {
                classes: true,
            });

            //Lenguaje de VeeValidate
            VeeValidate.Validator.localize("es");

            new Vue({
                el: "#app",
                vuetify: new Vuetify(),
                setup() {
                    const { ref, onMounted, watch } = VueCompositionAPI;
                    const ctr =
                        "../../controlador/formacion_docente/Controlador_catalogo_solicitud_formacion_docente.jsp";
                    //Variables POST
                    const nombrePrograma = ref("");
                    const fecha = ref("");
                    const tipoEvento = ref([]);
                    const enabled = false;
                    const tipoEventoOtro = ref("");
                    const direccionAcademia = ref("");
                    const ea = ref("");
                    const teei = ref("");
                    const dayd = ref("");
                    const idiomas = ref("");
                    const modalidad = ref("");
                    const centroGestor = ref("");
                    const proyectoPresupuestal = ref("");
                    const costoTotal = ref("");
                    const showAlert = false;
                    const observaciones = ref("");
                    const lugar = ref("");
                    const horario = ref("");
                    const numHoras = ref("");
                    const fechaInicio = ref("");
                    const numEmpleado = ref("");
                    const nombreParticipante = ref("");
                    const sexo = ref("");
                    const ptc = ref("");
                    const tecnico = ref("");
                    const alumnado = ref("");
                    const admin = ref("");
                    const otro = ref("");
                    const numberOfInputs = 1;
                    const selectedArea = ref("");

                    //Otras variables
                    const flagEditar = ref(false);
                    const itemEditar = ref({});
                    //Combo


                    //SNACKBAR
                    const loader = ref(false);
                    const snackbar = ref(false);
                    const mensaje_snackbar = ref("");
                    const color_snackbar = ref("");
                    //Loaders
                    //Dialogs
                    //DataTable
                    const dataSolicitudCapacitacion = ref([]);
                    const headerCapacitacion = ref([
                        { text: "No.", align: "left", sortable: true, value: "numero_fila" },
                        { text: "Nombre Solicitante", align: "left", sortable: true, value: "nombreSolicitante" },
                        { text: "Area Solicitante", align: "left", sortable: true, value: "nombreAreaS" },
                        { text: "Puesto", align: "left", sortable: true, value: "puesto" },
                        { text: "Tipo Competencia", align: "left", sortable: true, value: "tipoCompetencias" },
                        { text: "Nombre Curso", align: "left", sortable: true, value: "nombreCurso" },
                        { text: "Fecha Curso", align: "left", sortable: true, value: "fechaCurso" },
                        { text: "Nombre Facilitador", align: "left", sortable: true, value: "nombreFacilitador" },
                        { text: "Area Facilitador", align: "left", sortable: true, value: "nombreAreaF" }
                    ]);
                    const searchCapacitacion = ref([]);

                    onMounted(() => {
                        //fnConsultarTabla();
                        //fntipoArea();
                    });

                    async function fntipoArea() {
                        try {
                            preloader("../../");
                            let parametros = new URLSearchParams();
                            parametros.append("accion", 3);
                            let { data, status } = await axios.post(ctr, parametros);
                            if (status == 200) {
                                if (data.length > 0) {
                                    areas.value = data;
                                }
                            }
                        } catch (error) {
                            mostrarSnackbar("error");
                            console.error(error);
                        } finally {
                            swal.close();
                        }
                    }

                    async function fnConsultarTabla() {
                        try {
                            preloader("../../");
                            let parametros = new URLSearchParams();
                            parametros.append("accion", 2);
                            let { data, status } = await axios.post(ctr, parametros);
                            if (status == 200) {
                                if (data.length > 0) {
                                    dataSolicitudCapacitacion.value = data;
                                }
                            }
                        } catch (error) {
                            mostrarSnackbar("error");
                            console.error(error);
                        } finally {
                            swal.close();
                        }
                    }

                    function agregarOtroTipoEvento() {
                        if (this.enabled && this.tipoEventoOtro) {
                            this.tipoEvento.push(this.tipoEventoOtro);
                        }
                    }

                    async function fnGuardar() {
                        this.$validator.validate().then(async (esValido) => {
                            if (esValido) {
                                try {
                                    preloader("../../");
                                    let parametros = new URLSearchParams();
                                    parametros.append("accion", 1);
                                    parametros.append("idAreaF", areaPertenece.value);
                                    parametros.append("idAreaS", area.value);
                                    parametros.append("nombreCurso", nombreCurso.value);
                                    parametros.append("fechaCurso", fecha.value);
                                    parametros.append("horaCurso", horario.value);
                                    parametros.append("lugar", lugar.value);
                                    parametros.append("nombreFacilitador", nombreFacilitador.value);
                                    parametros.append("programaEducativoS", fecha.value);
                                    parametros.append("nombreSolicitante", nombre.value);
                                    parametros.append("tipoCurso", tipoCurso.value);
                                    parametros.append("puesto", puesto.value);
                                    parametros.append("tipoCompetencias", tipoCompetencia.value);
                                    parametros.append("totalDias", dias.value);
                                    parametros.append("totalHoras", horas.value);
                                    parametros.append("numeroParticipantes", numeroParticipantes.value);
                                    parametros.append("objetivos", objetivo.value);
                                    parametros.append("alcance", alcance.value);
                                    parametros.append("metodologia", metodologia.value);
                                    parametros.append("programaDelCurso", programaCurso.value);
                                    parametros.append("horasPorTema", horasTema.value);
                                    parametros.append("resultadoDeAprendizaje", resultadoAprendizaje.value);
                                    parametros.append("vperfilDeParticipante", perfil.value);
                                    let { data, status } = await axios.post(ctr, parametros);
                                    if (status == 200) {
                                        if (data == "1") {
                                            mostrarSnackbar(
                                                "success",
                                                "Registro guardado correctamente."
                                            );
                                            //fnConsultarTabla();
                                            fnLimpiarCampos(this);
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
                        });
                    }

                    async function fnEditar() {
                        this.$validator.validate().then(async (esValido) => {
                            if (esValido) {
                                try {
                                    preloader("../../");
                                    let parametros = new URLSearchParams();
                                    parametros.append("accion", 4);
                                    parametros.append("id_recursos", itemEditar.value.id_recursos);
                                    parametros.append("accion", 2);
                                    parametros.append("recursos", recursos.value);
                                    parametros.append("nombreProyecto", nombreProyecto.value);
                                    parametros.append("fecha", fecha.value);
                                    console.log(parametros);
                                    let { data, status } = await axios.post(ctr, parametros);
                                    if (status == 200) {
                                        if (data == "1") {
                                            mostrarSnackbar(
                                                "success",
                                                "Registro actualizado correctamente."
                                            );
                                            fnConsultarTabla();
                                            fnLimpiarCampos(this);
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
                        });
                    }

                    async function fnCambiarEstatus(item) {
                        try {
                            preloader("../../");
                            let parametros = new URLSearchParams();
                            parametros.append("accion", 5);
                            parametros.append("idProyecto", item.idProyecto);
                            parametros.append("estatus", item.estatus == true ? 1 : 0);
                            let { data, status } = await axios.post(ctr, parametros);
                            if (status == 200) {
                                if (data == "1") {
                                    mostrarSnackbar(
                                        "success",
                                        "Registro actualizado correctamente."
                                    );
                                    fnConsultarTabla();
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

                    function fnLimpiarCampos(cx) {
                        //cx = contexto
                        nombrePrograma.value = "";
                        fecha.value = "";
                        tipoEvento.value = "";

                        flagEditar.value = false;
                        itemEditar.value = {};

                        if (this == undefined) cx.$validator.reset();
                        else this.$validator.reset();
                    }

                    function mostrarSnackbar(color, texto) {
                        snackbar.value = true;
                        color_snackbar.value = color;
                        if (color == "error")
                            mensaje_snackbar.value =
                                "Ocurrió un error. Intentalo de nuevo más tarde.";
                        else mensaje_snackbar.value = texto;
                    }

                    return {
                        color_snackbar,
                        snackbar,
                        mensaje_snackbar,
                        loader,
                        mostrarSnackbar,
                        flagEditar,
                        nombrePrograma,
                        fecha,
                        tipoEvento,
                        tipoEventoOtro,
                        enabled,
                        direccionAcademia,
                        ea,
                        teei,
                        dayd,
                        idiomas,
                        modalidad,
                        centroGestor,
                        proyectoPresupuestal,
                        costoTotal,
                        observaciones,
                        showAlert,
                        dataSolicitudCapacitacion,
                        headerCapacitacion,
                        searchCapacitacion,
                        fnConsultarTabla,
                        fnGuardar,
                        fnLimpiarCampos,
                        fnEditar,
                        fnCambiarEstatus,
                        agregarOtroTipoEvento,
                        itemEditar,
                        lugar,
                        horario,
                        numHoras,
                        fechaInicio,
                        numEmpleado,
                        nombreParticipante,
                        sexo,
                        ptc,
                        tecnico,
                        alumnado,
                        admin,
                        otro,
                        selectedArea,
                        numberOfInputs
                    }
                },
                methods: {
                    handleCheckboxChange(index, field) {
                        // Desactivar los otros checkboxes en la misma fila
                        for (let i = 0; i < this.numberOfInputs; i++) {
                            if (i !== index) {
                                this[field][i] = false;
                            }
                        }
                    }}
            });

            Vue.config.devtools = true;
        </script>

    </html>