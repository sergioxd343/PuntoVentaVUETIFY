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
                            
                                <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                    

                                    <v-col md=3>
                                            
                                        <v-select 
                                            v-model="unidadAcademica"
                                            outlined
                                            label="Unidad académica:"
                                            v-validate="'required'"
                                            :items="arrayUnidadAcademica"
                                            item-value="nombre_unidad_academica"
                                            item-text="nombre_unidad_academica"
                                            data-vv-name="unidadAcademica"
                                            :error="errors.has('unidadAcademica')"
                                            :error-messages="errors.first('unidadAcademica')"
                                        ></v-select>
                                    </v-col>

                                    
                                    <v-col md="2">
                                        <v-text-field v-model="fecha" outlined label="Fecha de solicitud:" persistent-hint
                                            v-validate="'required|max:500'" data-vv-name="fecha"
                                            :error="errors.has('fecha')" :error-messages="errors.first('fecha')"
                                            readonly></v-text-field>
                                    </v-col>

                                    <v-col md=2>
                                            
                                        <v-select 
                                            v-model="selectedArea"
                                            outlined
                                            persistent-hint
                                            label="Area:"
                                            hint="Dirección Académica"
                                            v-validate="'required'"
                                            :items="arrayArea"
                                            item-value="cve_area"
                                            item-text="nombre_area"
                                            data-vv-name="selectedArea"
                                            :error="errors.has('selectedArea')"
                                            :error-messages="errors.first('selectedArea')"
                                        ></v-select>
                                    </v-col>
                                    
                                </v-row>

                                <v-row justfy="center" dense >
                                    <v-col class="text-center"><b>Agregar Participantes</b></v-col>
                                </v-row>

                                <v-row v-for="(item, index) in numberOfInputs" :key="index" justify="center"
                                        class="align-center" style="padding: 0px 50px 0px 50px">
                                    <v-col md="9">
                                        <v-select v-model="cve_empleado[index]" @change="agregarPraticipante(cve_empleado[index])" outlined
                                                  label="Datos del participante:" persistent-hint
                                                  hint="Nombre completo del participante -- sexo -- puesto"
                                                  :items="arrayParticipantes"
                                                  item-value="cve_empleado" :item-text="obtenerNombreCompleto"
                                                  v-validate="'required|max:500'" data-vv-name="cve_empleado"
                                                  :error="errors.has('cve_empleado')" :error-messages="errors.first('cve_empleado')">
                                        </v-select>
                                      </v-col> 
                                    
                                      <!--<v-col md="2">
                                        <v-text-field v-model="numEmpleado" outlined persistent-hint
                                                      hint="Numero de empleado"
                                                      v-validate="'required|max:500'" data-vv-name="numEmpleado"
                                                      :error="errors.has('numEmpleado')" :error-messages="errors.first('numEmpleado')"
                                                      readonly></v-text-field>
                                      </v-col>
                                    
                                      <v-col md="2">
                                        <v-text-field v-model="sexo" outlined persistent-hint
                                                      hint="Sexo"
                                                      v-validate="'required|max:500'" data-vv-name="sexo"
                                                      :error="errors.has('sexo')" :error-messages="errors.first('sexo')"
                                                      readonly></v-text-field>
                                      </v-col>
                                    
                                      <v-col md="2">
                                        <v-text-field v-model="puesto" outlined persistent-hint
                                                      hint="Puesto"
                                                      v-validate="'required|max:500'" data-vv-name="puesto"
                                                      :error="errors.has('puesto')" :error-messages="errors.first('puesto')"
                                                      readonly></v-text-field>
                                      </v-col>   -->  
                                </v-row>
                                <v-row  justify="center"
                                class="align-center">
                                    <v-tooltip top >
                                        <template v-slot:activator="{ on, attrs }">
                                            <v-btn color="primary" v-bind="attrs" v-on="on"
                                                @click="numberOfInputs++" style="margin-right: 25px; margin-left: 25px;"><v-icon>mdi-account-multiple-plus</v-icon></v-btn>
                                        </template>
                                        <span>Agregar un nuevo participante</span>
                                    </v-tooltip>
                                
                                    <v-tooltip top>
                                        <template v-slot:activator="{ on, attrs }">
                                            <v-btn color="error" v-bind="attrs" v-on="on" @click="numberOfInputs--">
                                                <v-icon>mdi-close</v-icon>
                                            </v-btn>
                                        </template>
                                        <span>Quitar participante</span>
                                    </v-tooltip>
                                </v-row>
                            

                                    <v-row justfy="center" dense style="margin-top: 20px;" >
                                        <v-col class="text-center"><b>Datos sobre la solicitud </b></v-col>
                                    </v-row>

                                <v-row  justify="center" class="align-center">



                                    <v-col md="8">
                                        <v-text-field v-model="nombrePrograma" outlined
                                            label="Nombre del programa solicitado" persistent-hint
                                            v-validate="'required|max:500'"
                                            data-vv-name="nombre del programa solicitado"
                                            :error="errors.has('nombre del programa solicitado')"
                                            :error-messages="errors.first('nombre del programa solicitado')"></v-text-field>
                                    </v-col>
                                    <v-col md=3>
                                            
                                        <v-select 
                                            v-model="tipoEvento"
                                            outlined
                                            persistent-hint
                                            hint="Selecciona el tipo de evento"
                                            label="Tipo de evento:"
                                            v-validate="'required'"
                                            :items="arrayTipoEvento"
                                            item-value="nombre_tipo_evento"
                                            item-text="nombre_tipo_evento"
                                            data-vv-name="tipoEvento"
                                            :error="errors.has('tipoEvento')"
                                            :error-messages="errors.first('tipoEvento')"
                                        ></v-select>
                                    </v-col>


                                </v-row>

                                <v-row justify="center" class="align-center">
                                    
                                

                                    <v-col md="8">
                                        <v-text-field 
                                            v-model="lugar" 
                                            outlined label="Lugar donde se impartira:"
                                            persistent-hint 
                                            v-validate="'required|max:500'" 
                                            data-vv-name="lugar"
                                            :error="errors.has('lugar')"
                                            :error-messages="errors.first('lugar')"></v-text-field>
                                    </v-col>
                                    <v-col md=3 ></v-col>

                                    

                                </v-row>

                                <v-row justify="center" class="align-center" >
                                        
                                    
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
                                </v-row>

                                <v-row justify="center" class="align-center" >
                                <v-col md=4>
                                
                                    <template>
                                        <div>
                                            <v-col style=" flex: 0 1 auto;">
                                              <h4>Hora de inicio:</h4>
                                              <v-time-picker
                                                v-model="horaInicio"
                                                :max="horaFin"
                                                width ="170px"
                                                landscape
                                                type="month"
                                                
                                                class="mt-3"
                                              ></v-time-picker>
                                            </v-col>
                                            
                                        </div>
                                      </template>
                                </v-col>
                                <v-col md=4>
                                    <v-col style="flex: 0 1 auto;">
                                        <h4>Hora de fin:</h4>
                                        <v-time-picker
                                          v-model="horaFin"
                                          :min="horaInicio"
                                          width ="170px"
                                          landscape
                                          type="month"
                                          width="170"
                                          class="mt-1"
                                        ></v-time-picker>
                                      </v-col>
                                </v-col> 
                                
                                <v-col md=2>
                                    <v-text-field 
                                        v-model="numHoras" 
                                        outlined label="Número de horas"
                                        persistent-hint v-validate="'required|max:500'" data-vv-name="numHoras"
                                        :error="errors.has('numHoras')"
                                        :error-messages="errors.first('numHoras')"></v-text-field>
                                </v-col>
                                </v-row>
                                <v-row justify="center" class="align-center" >
                                    

                                    <v-col md=2>
                                            
                                        <v-select 
                                            v-model="tipoModalidad"
                                            outlined
                                            label="Tipo de modalidad:"
                                            v-validate="'required'"
                                            :items="arrayTipoModalidad"
                                            item-value="nombre_tipo_modalidad"
                                            item-text="nombre_tipo_modalidad"
                                            data-vv-name="tipoModalidad"
                                            :error="errors.has('tipoModalidad')"
                                            :error-messages="errors.first('tipoModalidad')"
                                        ></v-select>
                                    </v-col>

                                    <v-col md="2">
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
                                    <v-col md="2">
                                        <v-text-field  v-model="costoTotal" prefix="$" outlined label="Costo total" persistent-hint
                                            v-validate="'required|max:500'" data-vv-name="costo total"
                                            :error="errors.has('costo total')"
                                            :error-messages="errors.first('costo total')"></v-text-field>
                                    </v-col>
                                </v-row>

                                    <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px; " v-if="tipoEvento !== 'Capacitación (3340)'">
                                        
                                        <v-col md="12" >


                                            <p class="tituloTh" style="margin-bottom: 0px; cursor: pointer;">
                                            Transferencia bancaria<br>
                                            Dato de control
                                            <v-tooltip bottom open-on-hover>
                                                <template v-slot:activator="{ on, attrs }">
                                                    <span class="tooltip-trigger" v-bind="attrs" v-on="on">
                                                        <v-icon>
                                                            mdi-information
                                                        </v-icon>
                                                    </span>
                                                </template>
                                                <span>En caso de solicitar pago al interesado(a), favor de mencionar solo
                                                    nombre y si es a un proveedor
                                                    completar todos los datos bancarios. En caso de ser partida 3340(Capacitación), se deja vacio este apartado.</span>
                                            </v-tooltip>
                                            </p>

                                        </v-col>
                                    </v-row>

                                        <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px; " md="12" >
                                            <v-col md=3 >
                                            
                                                <v-select 
                                                    v-model="solicitudPago"
                                                    outlined
                                                    label="Solicitud de pago para:"
                                                    v-validate="'required'"
                                                    :items="arrayPago"
                                                    item-value="arrayPago"
                                                    item-text="arrayPago"
                                                    data-vv-name="solicitudPago"
                                                    :error="errors.has('solicitudPago')"
                                                    :error-messages="errors.first('solicitudPago')"
                                                ></v-select>
                                            </v-col>

                                        </v-row>
                                        <v-row justify="center" class="align-center" >
                                            
                                            <v-col md=2  class="text-align text-center">

                                                <v-span>A nombre de:</v-span>

                                            </v-col>
                                            <v-col md="9">
                                                <v-text-field v-model="Anombre" outlined
                                                    persistent-hint
                                                    hint="Ingresa el nombre"
                                                    v-validate="'required|max:500'"
                                                    data-vv-name="Anombre"
                                                    :error="errors.has('Anombre')"
                                                    :error-messages="errors.first('Anombre')"></v-text-field>
                                            </v-col>

                                            <v-col md=2  class="text-align text-center" v-if="solicitudPago !== 'Interesado(a)'">
                                                <v-span class="justify-content: center;">Numero de cuenta:</v-span>

                                            </v-col>

                                            <v-col md="9" v-if="solicitudPago !== 'Interesado(a)'">
                                                <v-text-field v-model="numCuenta" outlined
                                                    persistent-hint
                                                    hint="Ingresa el numero de cuenta"
                                                    v-validate="'required|max:500'"
                                                    data-vv-name="numCuenta"
                                                    :error="errors.has('numCuenta')"
                                                    :error-messages="errors.first('numCuenta')"></v-text-field>
                                            </v-col>

                                            <v-col md=2  class="text-align text-center" v-if="solicitudPago !== 'Interesado(a)'">

                                                <v-span>Plaza:</v-span>

                                            </v-col>

                                            <v-col md="9" v-if="solicitudPago !== 'Interesado(a)'">
                                                <v-text-field v-model="plaza" outlined
                                                    persistent-hint
                                                    hint="Ingresa la plaza"
                                                    v-validate="'required|max:500'"
                                                    data-vv-name="plaza"
                                                    :error="errors.has('plaza')"
                                                    :error-messages="errors.first('plaza')"></v-text-field>
                                            </v-col>
                                            <v-col md=2  class="text-align text-center" v-if="solicitudPago !== 'Interesado(a)'">

                                                <v-span>Banco:</v-span>

                                            </v-col>
                                            <v-col md="9" v-if="solicitudPago !== 'Interesado(a)'">
                                                <v-text-field v-model="banco" outlined
                                                    persistent-hint
                                                    hint="Ingresa el nombre del banco"
                                                    v-validate="'required|max:500'"
                                                    data-vv-name="banco"
                                                    :error="errors.has('banco')"
                                                    :error-messages="errors.first('banco')"></v-text-field>
                                            </v-col>

                                            <v-col md=2  class="text-align text-center" v-if="solicitudPago !== 'Interesado(a)'">

                                                <v-span>Clabe interbancaria:</v-span>

                                            </v-col>

                                            <v-col md="9" v-if="solicitudPago !== 'Interesado(a)'">
                                                <v-text-field v-model="clabeInter" outlined
                                                    hint="Ingresa la clabe interbancaria" persistent-hint
                                                    v-validate="'required|max:500'"
                                                    data-vv-name="clabeInter"
                                                    :error="errors.has('clabeInter')"
                                                    :error-messages="errors.first('clabeInter')"></v-text-field>
                                            </v-col>
                                        
                                                  
                                    </v-row>

                                    <v-row justify="center" class="align-center" >

                                        <v-col md="3">
                                            <v-text-field v-model="solicitante"  
                                                persistent-hint hint="Solicitante"
                                                v-validate="'required|max:500'" data-vv-name="solicitante"
                                                :error="errors.has('solicitante')"
                                                :error-messages="errors.first('solicitante')"
                                                disabled></v-text-field>
                                        </v-col>

                                    </v-row>

                                    

                                
                                <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                   <!-- <v-col md="12">
                                        <v-textarea v-model="observaciones" data-vv-name="observaciones"
                                            :error="errors.has('observaciones')"
                                            :error-messages="errors.first('observaciones')" label="Observaciones"
                                            persistent-hint hint="(A llenar por quien revisa)"
                                            v-validate="'required|max:500'" auto-grow outlined rows="1"
                                            row-height="15"
                                            disabled></v-textarea>
                                    </v-col> -->
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
                                        <v-data-table :headers="headersSolicitudFormacionDocente" :items="dataSolicitudFormacionDocente"
                                            class="elevation-2" no-data-text="No se encontro ningun registro"
                                            :hide-default-header="dataSolicitudFormacionDocente.length < 1"
                                            :hide-default-footer="dataSolicitudFormacionDocente.length < 1" locale="es-ES"
                                            :mobile-breakpoint="NaN" items-per-page="10">
                                        
                                        <template>
                                            <v-btn text color="primary" @click="">
                                                Estatus
                                            </v-btn>
                                        </template>
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
                    const currentUser = localStorage.getItem("currentUser");
                    const currentUserObj = JSON.parse(currentUser);
                    const usuario_registro = currentUserObj[0].cve_persona;
                    const nombre = currentUserObj[0].nombre;
                    const ape1 = currentUserObj[0].apellido_paterno;
                    const ape2 = currentUserObj[0].apellido_materno;
                
                    const nombrePrograma = ref("");
                    const puesto = ref("");
                
                    const unidadAcademica = ref("");
                    const fecha = ref("");
                    const tipoEvento = ref("");
                    const enabled = false;
                    const tipoEventoOtro = ref("");
                    const direccionAcademia = ref("");
                    const ea = ref("");
                    const solicitudPago = ref("");
                    const showAlert = false;
                    const sexo = ref("");
                    const teei = ref("");
                    const dayd = ref("");
                    const idiomas = ref("");
                    const tipoModalidad = ref("");
                    const centroGestor = ref("");
                    const proyectoPresupuestal = ref("");
                    const costoTotal = ref("");
                    const observaciones = ref("");
                    const cve_empelado_anotado = ref("");
                    const lugar = ref("");
                    const horaInicio = ref("");
                    const horaFin = ref("");
                    const numHoras = ref("");
                    const fechaInicio = ref("");
                    const fechaFin = ref("");
                    const numEmpleado = ref("");
                    const cve_empleado = ref("");
                    const Anombre = ref("");
                    const plaza = ref("");
                    const banco = ref("");
                    const clabeInter = ref("");
                    const numCuenta = ref("");
                    const solicitante = nombre + " "+ ape1+" "+ ape2;
                    const ptc = ref("");
                    const tecnico = ref("");
                    const alumnado = ref("");
                    const admin = ref("");
                    const otro = ref("");
                    const numberOfInputs = 1;
                    const selectedArea = ref("");
                    const selectedRol = ref("");

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
                    const dataSolicitudFormacionDocente = ref([]);
                    const arrayTipoEvento = ref([]);
                    const arrayTipoModalidad = ref([]);
                    const arrayUnidadAcademica = ref([]);
                    const arrayArea = ref([]);
                    const arrayParticipantes = ref([]);
                    const participanteSeleccionado = ref([]);
                    const arrayPago = ref(["Interesado(a)","Proveedor"]);

                    const headersSolicitudFormacionDocente = ref([
                        { text: "No.", align: "left", sortable: true, value: "numero_fila" },
                        { text: "Area", align: "left", sortable: true, value: "nombre_area" },
                        { text: "Nombre programa solicitado", align: "left", sortable: true, value: "" },
                        { text: "Tipo de evento", align: "left", sortable: true, value: "nombre_tipo_evento" },
                        { text: "Centro gestor", align: "left", sortable: true, value: "centro_gestor" },
                        
                    ]);
                    const searchCapacitacion = ref([]);

                    onMounted(() => {
                        //fnConsultarTabla();
                        //fntipoArea();
                        fnTipoevento();
                        fnTipoModalidad();
                        
                        fnUnidadAcademica();
                        fnReasignacionDatos();
                        fnParticipantes();
                        fnArea();
                    });

                    function fnReasignacionDatos() {
                        fecha.value = new Date().toISOString().substr(0, 10);
                    }

                    async function fnConsultarTabla() {
                        try {
                            preloader("../../");
                            let parametros = new URLSearchParams();
                            parametros.append("accion", 1);
                            let { data, status } = await axios.post(ctr, parametros);
                            if (status == 200) {
                                if (data.length > 0) {
                                    dataSolicitudFormacionDocente.value = data;
                                }
                            }
                        } catch (error) {
                            mostrarSnackbar("error");
                            console.error(error);
                        } finally {
                            swal.close();
                        }
                    }

                    async function fnGuardar() {
                        this.$validator.validate().then(async (esValido) => {
                            if (esValido) {
                                try {
                                    preloader("../../");
                                    let parametros = new URLSearchParams();
                                    parametros.append("accion", 2);
                                    parametros.append("cve_unidad_academica", unidadAcademica.value);
                                    parametros.append("fecha", fecha.value);
                                    parametros.append("cve_area", selectedArea.value);
                                    parametros.append("cve_departamento", nombreCurso.value);
                                    parametros.append("cve_ugac", selectedArea.value);
                                    parametros.append("cve_tipo_evento", tipoEvento.value);
                                    parametros.append("cve_tipo_modalidadd", tipoModalidad.value);
                                    parametros.append("cve_empleado_valida", empleadoValida.value);
                                    parametros.append("cve_empleado_responsable", empleadoResponsable.value);
                                    parametros.append("cve_empelado_autoriza", empleadoAutoriza.value);
                                    parametros.append("lugar", lugar.value);
                                    parametros.append("fecha_inicio", fechaInicio.value);
                                    parametros.append("horaInicio", horaInicio.value);
                                    parametros.append("horaFin", horaFin.value);
                                    parametros.append("numero_horas", numHoras.value);
                                    parametros.append("centro_gestor", centroGestor.value);
                                    parametros.append("proyecto_presupuesto", proyectoPresupuestal.value);
                                    parametros.append("costo_total", costoTotal.value);
                                    parametros.append("transferencia_nombre", Anombre.value);
                                    parametros.append("transferencia_cuenta", numCuenta.value);
                                    parametros.append("transferencia_plaza", plaza.value);
                                    parametros.append("transferencia_banco", banco.value);
                                    parametros.append("transferencia_clabe", clabeInter.value);
                                    parametros.append("cve_empleado", this.participanteSeleccionado.join(","));
                                    parametros.append("cve_persona",this.usuario_registro);
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
                                    parametros.append("accion",3);
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
                            parametros.append("accion", 4);
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

                    async function fnArea() {
                            try {
                                preloader("../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 5); // arreglo que se manda 
                                let { data, status } = await axios.post(ctr, parametros) // axios hace peticion y manda a la ruta los parametros por POST
                                if (status == 200) { // si es 200 encontro informacion 
                                    if (data.length > 0) {
                                        arrayArea.value = data // llena los datos del dataTable
                                    }
                                }
                            } catch (error) {
                                mostrarSnackbar('error');
                                console.error(error);
                            } finally {
                                swal.close();
                            }
                        }

                    async function fnTipoevento() {
                            try {
                                preloader("../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 6); // arreglo que se manda 
                                let { data, status } = await axios.post(ctr, parametros) // axios hace peticion y manda a la ruta los parametros por POST
                                if (status == 200) { // si es 200 encontro informacion 
                                    if (data.length > 0) {
                                        arrayTipoEvento.value = data // llena los datos del dataTable
                                    }
                                }
                            } catch (error) {
                                mostrarSnackbar('error');
                                console.error(error);
                            } finally {
                                swal.close();
                            }
                        }
                        async function fnTipoModalidad() {
                            try {
                                preloader("../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 7); // arreglo que se manda 
                                let { data, status } = await axios.post(ctr, parametros) // axios hace peticion y manda a la ruta los parametros por POST
                                if (status == 200) { // si es 200 encontro informacion 
                                    if (data.length > 0) {
                                        arrayTipoModalidad.value = data // llena los datos del dataTable
                                    }
                                }
                            } catch (error) {
                                mostrarSnackbar('error');
                                console.error(error);
                            } finally {
                                swal.close();
                            }
                        }

                        async function fnUnidadAcademica() {
                            try {
                                preloader("../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 8); // arreglo que se manda 
                                let { data, status } = await axios.post(ctr, parametros) // axios hace peticion y manda a la ruta los parametros por POST
                                if (status == 200) { // si es 200 encontro informacion 
                                    if (data.length > 0) {
                                        arrayUnidadAcademica.value = data // llena los datos del dataTable
                                    }
                                }
                            } catch (error) {
                                mostrarSnackbar('error');
                                console.error(error);
                            } finally {
                                swal.close();
                            }
                        }
                        async function fnParticipantes() {
                            try {
                                preloader("../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 9); // arreglo que se manda 
                                let { data, status } = await axios.post(ctr, parametros) // axios hace peticion y manda a la ruta los parametros por POST
                                if (status == 200) { // si es 200 encontro informacion 
                                    if (data.length > 0) {
                                        arrayParticipantes.value = data // llena los datos del dataTable
                                    }
                                }
                            } catch (error) {
                                mostrarSnackbar('error');
                                console.error(error);
                            } finally {
                                swal.close();
                            }
                        }

                        function obtenerNombreCompleto(participante) {
                            return participante.nombre + ' ' + participante.apellido_paterno + ' ' + participante.apellido_materno 
                            + ' -- ' + participante.sexo + ' -- ' + participante.nombre_puesto;
                            }
                        

                    function fnLimpiarCampos(cx) {
                        unidadAcademica = "";
                        fecha = "";
                        selectedArea = "";
                        numEmpleado = "";
                        cve_empleado = "";
                        sexo = "";
                        selectedRol = "";
                        nombrePrograma.value = "";
                        tipoEvento = "";
                        tipoModalidad = "";
                        lugar = "";
                        horaInicio = "";
                        horaFin = "";
                        numHoras = "";
                        fechaInicio = "";
                        centroGestor = "";
                        proyectoPresupuestal = "";
                        costoTotal = "";
                        solicitudPago = "";
                        Anombre = "";
                        numCuenta = "";
                        plaza = "";
                        banco = "";
                        clabeInter = "";
                        
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
                        color_snackbar, snackbar, mensaje_snackbar, loader, mostrarSnackbar, flagEditar,
                        nombrePrograma, fecha, tipoEvento, enabled, direccionAcademia, ea, teei, dayd,
                        idiomas, centroGestor, proyectoPresupuestal, costoTotal, observaciones,
                         dataSolicitudCapacitacion, headersSolicitudFormacionDocente, searchCapacitacion,
                        fnConsultarTabla, fnGuardar, fnLimpiarCampos, fnEditar, fnCambiarEstatus, 
                        itemEditar, lugar, horaInicio, horaFin, numHoras, fechaInicio, numEmpleado, cve_empleado, sexo,
                        arrayTipoEvento, fnTipoModalidad, arrayTipoModalidad, tipoModalidad, showAlert,
                        puesto, selectedRol, unidadAcademica, arrayUnidadAcademica, fnUnidadAcademica, dataSolicitudFormacionDocente,
                        arrayPago, solicitudPago, fnReasignacionDatos, Anombre, plaza, numCuenta, clabeInter, banco, fnParticipantes, 
                        arrayParticipantes, fnArea, arrayArea, participanteSeleccionado, obtenerNombreCompleto, fechaFin, solicitante,
                        ape1, ape2, 
                        ptc, tecnico, alumnado, admin, otro, selectedArea, numberOfInputs
                    }
                },
                methods: {

                    agregarParticipante(participante) {
                        if (participante) {
                            const index = this.participanteSeleccionado.indexOf(participante);
                            if (index === -1) {
                                this.participanteSeleccionado.push(participante);
                            }
                        }
                        console.log(this.participanteSeleccionado);
                    }
                    /*handleCheckboxChange(index, field) {
                        // Desactivar los otros checkboxes en la misma fila
                        for (let i = 0; i < this.numberOfInputs; i++) {
                            if (i !== index) {
                                this[field][i] = false;
                            }
                        }
                    }*/}
            });

            Vue.config.devtools = true;
        </script>

    </html>
