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
                        <v-card-title style="background-color: #00b293; color: #ffffff; headline" >
                            Evento
                        </v-card-title>
                        <v-container fluid>
                            <v-row justify="center" class="aling-center" style="padding: 0px 50px 0px 50px" >
                                <!--Columna-->
                                <v-col md=6>
                                        <v-text-field 
                                            v-model="anioEjercer"
                                            outlined
                                            label="A&ntilde;o a ejercer"    
                                            persistent-hint
                                            v-validate="'required|max:200'"
                                            inputmode="numeric"
                                            pattern="[0-9]*"
                                            type="number"
                                            data-vv-name="anioEjercer"
                                            :error="errors.has('anioEjercer')"
                                            :error-messages="errors.first('anioEjercer')"
                                        ></v-text-field>
                                    </v-col>

                                    <v-col md=6>
                                    <v-select
                                        v-model="direccionResponsable"
                                        outlined
                                        label="Direcci&oacute;n o subdirecci&oacute;n responsable"
                                        v-validate="'required'"
                                        :items="arrayAcademia"
                                        item-value="direccionResponsable"
                                        item-text="direccionResponsable"
                                        data-vv-name="direccionResponsable"
                                        :error="errors.has('direccionResponsable')"
                                        :error-messages="errors.first('direccionResponsable')"
                                        required
                                    ></v-select>
                                </v-col>

                                <v-col md=12>
                                        <v-subheader>Fecha de elaboraci&oacute;n</v-subheader>
                                        <v-date-picker
                                        v-model="fechaElaboracion"
                                        landscape
                                        class="mt-3"
                                        v-validate="'required|max:200'"
                                        data-vv-name="fecha elaboracion"
                                        :error="errors.has('fecha elaboracion')"
                                        :error-messages="errors.first('fecha elaboracion')"
                                        ></v-date-picker>
                                    </v-col>

                                <v-col md=12 style="text-align: center; background-color: #00b293; color: floralwhite;">
                                    <v-toolbar-title>Informaci&oacute;n de la Academia</v-toolbar-title>
                                </v-col>
                                
                                <v-col md=6>
                                    <v-select
                                        v-model="idAcademia"
                                        outlined
                                        label="Academia"
                                        v-validate="'required'"
                                        :items="arrayAcademia"
                                        item-value="idAcademia"
                                        item-text="unidadAcademica"
                                        data-vv-name="academia"
                                        :error="errors.has('academia')"
                                        :error-messages="errors.first('academia')"
                                        required
                                    ></v-select>
                                </v-col>

                                <v-col md=12 style="text-align: center; background-color: #00b293; color: floralwhite;">
                                    <v-toolbar-title>Informaci&oacute;n del Evento</v-toolbar-title>
                                </v-col>

                                <v-col md=6>
                                    <v-text-field 
                                        v-model="necesidadesDetectadas"
                                        outlined
                                        label="Necesidades detectadas mediante"
                                        persistent-hint
                                        v-validate="'required|max:200'"
                                        data-vv-name="nombre evento"
                                        :error="errors.has('nombre evento')"
                                        :error-messages="errors.first('nombre evento')"
                                    ></v-text-field>
                                </v-col>

                                <v-col md=6>
                                    <v-text-field 
                                        v-model="nombreEventoCapacitacion"
                                        outlined
                                        label="Nombre del Evento"
                                        persistent-hint
                                        v-validate="'required|max:200'"
                                        data-vv-name="nombre evento"
                                        :error="errors.has('nombre evento')"
                                        :error-messages="errors.first('nombre evento')"
                                    ></v-text-field>
                                </v-col>

                                <v-col md=6>
                                    <v-text-field 
                                        v-model="objetivoEvento"
                                        outlined
                                        label="Objetivo del evento"
                                        persistent-hint
                                        v-validate="'required|max:200'"
                                        data-vv-name="objetivo evento"
                                        :error="errors.has('objetivo evento')"
                                        :error-messages="errors.first('objetivo evento')"
                                    ></v-text-field>
                                </v-col>

                                <v-col md=6>
                                    <v-select 
                                        v-model="orientacionEvento"
                                        outlined
                                        label="Orientaci&oacute;n del Evento"
                                        persistent-hint
                                        v-validate="'required|max:200'"
                                        data-vv-name="orientacion evento"
                                        :error="errors.has('orientacion evento')"
                                        :error-messages="errors.first('orientacion evento')"
                                    ></v-select>
                                </v-col>

                                <v-col md=6>
                                    <v-text-field 
                                        v-model="justificacionEvento"
                                        outlined
                                        label="Justificaci&oacute;n del Evento"
                                        persistent-hint
                                        v-validate="'required|max:200'"
                                        data-vv-name="justificacion evento"
                                        :error="errors.has('justificacion evento')"
                                        :error-messages="errors.first('justificacion evento')"
                                    ></v-text-field>
                                </v-col>

                                <v-col md=6>
                                    <v-select 
                                        v-model="tipoEvento"
                                        outlined
                                        label="Tipo de Evento"
                                        persistent-hint
                                        v-validate="'required|max:200'"
                                        data-vv-name="tipo evento"
                                        :error="errors.has('tipo evento')"
                                        :error-messages="errors.first('tipo evento')"
                                    ></v-select>
                                </v-col>

                                <v-col md=6>
                                    <v-text-field 
                                        v-model="otroTipoEvento"
                                        outlined
                                        label="En caso de otros especificar"
                                        persistent-hint
                                        v-validate="'required|max:200'"
                                        data-vv-name="otro tipo evento"
                                        :error="errors.has('otro tipo evento')"
                                        :error-messages="errors.first('otro tipo evento')"
                                    ></v-text-field>
                                </v-col>
                                
                                <v-col md=6>
                                    <v-select 
                                        v-model="tipoPrograma"
                                        outlined
                                        label="Tipo de Programa"    
                                        persistent-hint
                                        v-validate="'required|max:200'"
                                        data-vv-name="tipo programa"
                                        :error="errors.has('tipo programa')"
                                        :error-messages="errors.first('tipo programa')"
                                    ></v-select>
                                </v-col>

                                <v-col md=6>
                                    <v-text-field 
                                        v-model="proveedorSugerido"
                                        outlined
                                        label="Proveedor (Sugerido)"    
                                        persistent-hint
                                    ></v-text-field>
                                </v-col>

                                <v-col md=6>
                                    <v-text-field 
                                        v-model="costoCapacitacionSugerido"
                                        outlined
                                        prefix="$"
                                        label="Costo Capacitaci&oacute;n (Sugerido)"    
                                        persistent-hint
                                        inputmode="decimal"
                                        pattern="[0-9]+(\.[0-9][0-9]?)?"
                                        type="number"
                                        data-vv-name="costo capacitacion"
                                        :error="errors.has('costo capacitacion')"
                                        :error-messages="errors.first('costo capacitacion')"
                                    ></v-text-field>
                                </v-col>
                                    <v-col md=6>
                                        <v-text-field 
                                            v-model="origenRecursoEvento"
                                            outlined
                                            label="Origen del Recurso para el Evento"    
                                            persistent-hint
                                            v-validate="'required|max:200'"
                                            data-vv-name="origen recurso"
                                            :error="errors.has('origen recurso')"
                                            :error-messages="errors.first('origen recurso')"
                                        ></v-text-field>
                                    </v-col>


                                    <v-col md=12 style="text-align: center; background-color: #00b293; color: floralwhite;">
                                        <v-toolbar-title>Per&iacute;odo para participar al evento</v-toolbar-title>
                                    </v-col>

                                    <!--datos periodo-->

                                    

                                    <v-col md=6>
                                        <v-subheader>Fecha de inicio</v-subheader>
                                        <v-date-picker
                                        v-model="fechaInicio"
                                        landscape
                                        class="mt-3"
                                        v-validate="'required'"
                                        data-vv-name="fecha inicio"
                                        :error="errors.has('fecha inicio')"
                                        :error-messages="errors.first('fecha inicio')"
                                        ></v-date-picker>
                                    </v-col>

                                    <v-col md=6>
                                        <v-subheader>Fecha de termino</v-subheader>
                                        <v-date-picker
                                        v-model="fechaTermino"
                                        landscape
                                        class="mt-3"
                                        v-validate="'required|max:200'"
                                        data-vv-name="fecha termino"
                                        :error="errors.has('fecha termino')"
                                        :error-messages="errors.first('fecha termino')"
                                        ></v-date-picker>
                                    </v-col>

                                    <v-col md=3>
                                        <v-text-field 
                                            v-model="numDias"
                                            outlined
                                            label="N&uacute;mero de d&iacute;as"    
                                            persistent-hint
                                            v-validate="'required|max:200'"
                                            inputmode="numeric"
                                            pattern="[0-9]*"
                                            type="number"
                                            data-vv-name="numero dias"
                                            :error="errors.has('numero dias')"
                                            :error-messages="errors.first('numero dias')"
                                        ></v-text-field>
                                    </v-col>

                                    <v-col md=3>
                                        <v-text-field 
                                            v-model="numHorasEfectivas"
                                            outlined
                                            label="Numero de horas efectivas"    
                                            persistent-hint
                                            v-validate="'required|max:200'"
                                            inputmode="numeric"
                                            pattern="[0-9]*"
                                            type="number"
                                            data-vv-name="numero dias efectivas"
                                            :error="errors.has('numero dias efectivas')"
                                            :error-messages="errors.first('numero dias efectivas')"
                                        ></v-text-field>
                                    </v-col>

                                    <v-col md=6 v-if="false">
                                        <v-text-field 
                                            v-model="idEvento"
                                            outlined
                                            label="idEvento"    
                                            persistent-hint
                                        ></v-text-field>
                                    </v-col>
                                    <v-col md=6 v-if="false"> 
                                        <v-text-field 
                                            v-model="idPeriodo"
                                            outlined
                                            label="Periodo"    
                                            persistent-hint
                                            
                                        ></v-text-field>
                                    </v-col>

                                    <v-col md=12 style="text-align: center; background-color: #00b293; color: floralwhite;">
                                        <v-toolbar-title>Participantes</v-toolbar-title>
                                    </v-col>

                                    <v-col md=3> 
                                        <v-text-field 
                                            v-model="numeroPTC"
                                            outlined
                                            label="PTC"    
                                            persistent-hint
                                            v-validate="'required|max:200'"
                                            data-vv-name="PTC"
                                            :error="errors.has('PTC')"
                                            :error-messages="errors.first('PTC')"
                                        ></v-text-field>
                                    </v-col>

                                    <v-col md=3 > 
                                        <v-text-field 
                                            v-model="numeroLaboratorista"
                                            outlined
                                            label="Laboratorista"    
                                            persistent-hint
                                            v-validate="'required|max:200'"
                                            data-vv-name="numero de laboratorista"
                                            :error="errors.has('numero de laboratorista')"
                                            :error-messages="errors.first('numero de laboratorista')"                                            
                                        ></v-text-field>
                                    </v-col>

                                    <v-col md=3 > 
                                        <v-text-field 
                                            v-model="administrativoArea"
                                            outlined
                                            label="Administrativo del &Aacute;rea Acad&eacute;mica"    
                                            persistent-hint
                                            v-validate="'required|max:200'"
                                            data-vv-name="administrativo del area"
                                            :error="errors.has('administrativo del area')"
                                            :error-messages="errors.first('administrativo del area')"
                                        ></v-text-field>
                                    </v-col>
                                    <v-col md=3> 
                                        <v-text-field 
                                            v-model="otrosParticipantes"
                                            outlined
                                            label="Otros Participantes"    
                                            persistent-hint
                                            v-validate="'required|max:200'"
                                            data-vv-name="otros participantes"
                                            :error="errors.has('otros participantes')"
                                            :error-messages="errors.first('otros participantes')"
                                        ></v-text-field>
                                    </v-col>

                                    
                                    <v-col md=4> 
                                        <v-text-field 
                                            v-model="totalParticipantes"
                                            outlined
                                            label="Total"    
                                            persistent-hint
                                            v-validate="'required|max:200'"
                                            data-vv-name="total de participantes"
                                            :error="errors.has('total de participantes')"
                                            :error-messages="errors.first('total de participantes')"
                                        ></v-text-field>
                                    </v-col>
                                    <v-col md=4> 
                                        <v-text-field 
                                            v-model="totalHombres"
                                            outlined
                                            label="Total Hombres"    
                                            persistent-hint
                                            v-validate="'required|max:200'"
                                            data-vv-name="total hombres"
                                            :error="errors.has('total hombres')"
                                            :error-messages="errors.first('total hombres')"
                                        ></v-text-field>
                                    </v-col>
                                    <v-col md=4> 
                                        <v-text-field 
                                            v-model="totalMujeres"
                                            outlined
                                            label="Total Mujeres"    
                                            persistent-hint
                                            v-validate="'required|max:200'"
                                            data-vv-name="total mujeres"
                                            :error="errors.has('total mujeres')"
                                            :error-messages="errors.first('total mujeres')"
                                        ></v-text-field>
                                    </v-col>



                                </v-row>
                                <%-- <v-row justfy="center" dense >
                                </v-row> --%>

                                <v-divider></v-divider>

                                <!--Botones-->
                                <v-row justify="center">
                                    <v-btn color="primary" @click="flagEditar ? fnEditar() : fnGuardar()"><v-icon>mdi-content-save</v-icon>{{flagEditar ? 'Editar' : 'Guardar'}}</v-btn>
                                    &nbsp;
                                    <v-btn color="error" @click="fnLimpiarCampos()"><v-icon>mdi-cancel</v-icon>Cancelar</v-btn>
                                </v-row>
                                <v-row justify="center">
                                    <v-col md=12>
                                        <v-data-table
                                            :headers="headersEventos"
                                            :items="dataEventos"
                                            :search="searchEventos"
                                            class="elevation-2"
                                            no-data-text="No se encontro ningun registro"
                                            :hide-default-header="dataEventos.length < 1"
                                            :hide-default-footer="dataEventos.length < 1"
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
                                                <v-btn fab small color="warning" @click="$vuetify.goTo(0); flagEditar = true; itemEditar = item;
                                                    idAcademia = item.idAcademia;
                                                    nombreEventoCapacitacion = item.nombreEventoCapacitacion;
                                                    objetivoEvento = item.objetivoEvento;
                                                    orientacionEvento = item.orientacionEvento;
                                                    justificacionEvento = item.justificacionEvento;
                                                    tipoEvento = item.tipoEvento;
                                                    otroTipoEvento = item.otroTipoEvento;
                                                    tipoPrograma = item.tipoPrograma;
                                                    proveedorSugerido = item.proveedorSugerido;
                                                    costoCapacitacionSugerido = item.costoCapacitacionSugerido;
                                                    origenRecursoEvento = item.origenRecursoEvento;

                                                    idEvento = item.Expr2;
                                                    idPeriodo=item.Expr8;

                                                    mes = item.Expr3;
                                                    fechaInicio = item.Expr4;
                                                    fechaTermino = item.Expr5;
                                                    numDias = item.Expr6;
                                                    numHorasEfectivas = item.Expr7;
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
                </v-container>
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
                const ctr = "../controlador/eventos/contrpolador_catalogo_evento.jsp";


                const anioEjercer=ref("");
                const direccionResponsable=ref("");
                const fechaElaboracion=ref("");
                const necesidadesDetectadas=ref("");
                const numeroPTC=ref("");
                const numeroLaboratorista=ref("");
                const administrativoArea=ref("");
                const otrosParticipantes=ref("");
                const totalParticipantes=ref("");
                const totalHombres=ref("");
                const totalMujeres=ref("");
                //Variables POST
                const idAcademia = ref("");
                const nombreEventoCapacitacion= ref("");
                const objetivoEvento=ref("");
                const orientacionEvento=ref("");
                const justificacionEvento=ref("");
                const tipoEvento=ref("");
                const otroTipoEvento=ref("");
                const tipoPrograma=ref("");
                const proveedorSugerido=ref("");
                const costoCapacitacionSugerido=ref("");
                const origenRecursoEvento=ref("");

                const idEvento =ref("");
                const idPeriodo=ref("");

                const mes=ref("");
                const fechaInicio=ref("");
                const fechaTermino=ref("");
                const numDias=ref("");
                const numHorasEfectivas=ref("");
                //Arreglos
                const arrayAcademia =ref([]);
                const arrayMes =ref(['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'])

                  //SNACKBAR
                const loader = ref(false);
                const snackbar = ref(false);
                const mensaje_snackbar = ref('');
                const color_snackbar = ref('')

                //Otras funciones
                const flagEditar = ref(false);
                const itemEditar = ref({});
                //DataTable
                //dataUduarios
                const dataEventos = ref([]);
                const searchEventos = ref([]);
                const headersEventos = ref([
                    {text: 'no', align: 'left', sortable: true, value: 'Expr2'},
                    {text: 'Nombre del evento de capacitacion', align: 'left', sortable: true, value: 'nombreEventoCapacitacion'},
                    {text: 'Objetivo del evento', align: 'left', sortable: true, value: 'objetivoEvento'},
                    {text: 'Editar', align: 'left', sortable: true, value: 'editar'},
                    {text: 'Eliminar', align: 'left', sortable: true, value: 'eliminar'}
                ]);

                //Accion automatizada para mostrar la tabla
                onMounted(() => {
                    fnTipoEvento();
                    fnConsultarTabla();
                });

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

                                dataEventos.value = data
                            }
                        }
                    } catch(error){
                        mostrarSnackbar('error');
                        console.error(error);
                    } finally{
                        swal.close();
                    }
                }

                

                async function fnTipoEvento(){
                    try{
                        preloader("../");
                        let parametros = new URLSearchParams();
                        parametros.append("accion", 3);
                        let {data,status} = await axios.post(ctr, parametros)
                        if(status == 200){
                            if(data.length > 0){
                                arrayAcademia.value = data
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
                                parametros.append("idAcademia", idAcademia.value);
                                parametros.append("nombreEventoCapacitacion", nombreEventoCapacitacion.value);
                                parametros.append("objetivoEvento", objetivoEvento.value);
                                parametros.append("orientacionEvento", orientacionEvento.value);
                                parametros.append("justificacionEvento", justificacionEvento.value);
                                parametros.append("tipoEvento", tipoEvento.value);
                                parametros.append("otroTipoEvento", otroTipoEvento.value);
                                parametros.append("tipoPrograma", tipoPrograma.value);
                                parametros.append("proveedorSugerido", proveedorSugerido.value);
                                parametros.append("costoCapacitacionSugerido", costoCapacitacionSugerido.value);
                                parametros.append("origenRecursoEvento", origenRecursoEvento.value);

                                parametros.append("mes", mes.value);
                                parametros.append("fechaInicio", fechaInicio.value);
                                parametros.append("fechaTermino", fechaTermino.value);    
                                parametros.append("numDias", numDias.value);    
                                parametros.append("numHorasEfectivas", numHorasEfectivas.value);        
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


                async function fnEditar(){
                    this.$validator.validate().then(async esValido => {
                        if(esValido){
                            try{
                                preloader("../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 5); 
                                parametros.append("idAcademia", idAcademia.value);
                                parametros.append("nombreEventoCapacitacion", nombreEventoCapacitacion.value);
                                parametros.append("objetivoEvento", objetivoEvento.value);
                                parametros.append("orientacionEvento", orientacionEvento.value);
                                parametros.append("justificacionEvento", justificacionEvento.value);
                                parametros.append("tipoEvento", tipoEvento.value);
                                parametros.append("otroTipoEvento", otroTipoEvento.value);
                                parametros.append("tipoPrograma", tipoPrograma.value);
                                parametros.append("proveedorSugerido", proveedorSugerido.value);
                                parametros.append("costoCapacitacionSugerido", costoCapacitacionSugerido.value);
                                parametros.append("origenRecursoEvento", origenRecursoEvento.value);

                                parametros.append("idEvento", idEvento.value);


                                parametros.append("mes", mes.value);
                                parametros.append("fechaInicio", fechaInicio.value);
                                parametros.append("fechaTermino", fechaTermino.value);    
                                parametros.append("numDias", numDias.value);    
                                parametros.append("numHorasEfectivas", numHorasEfectivas.value); 
                                parametros.append("idPeriodo", idPeriodo.value);
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
                                parametros.append("accion", 4);
                                parametros.append("idPeriodo", item.Expr8);
                                parametros.append("idEvento", item.Expr2);
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
                    idAcademia.value = "";
                    nombreEventoCapacitacion.value = "";
                    objetivoEvento.value = "";
                    orientacionEvento.value = "";
                    justificacionEvento.value = "";
                    tipoEvento.value = "";
                    otroTipoEvento.value = "";
                    tipoPrograma.value = "";
                    proveedorSugerido.value = "";
                    costoCapacitacionSugerido.value = "";
                    origenRecursoEvento.value = "";
                    
                    mes.value = "";
                    fechaInicio.value = "";
                    fechaTermino.value = "";
                    numDias.value = "";
                    numHorasEfectivas.value = "";

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
                    anioEjercer, direccionResponsable, fechaElaboracion,necesidadesDetectadas, numeroPTC, numeroLaboratorista,
                    administrativoArea, otrosParticipantes, totalParticipantes, totalHombres, totalMujeres,
                    idAcademia, arrayAcademia, arrayMes, nombreEventoCapacitacion, objetivoEvento, orientacionEvento
                    , justificacionEvento,tipoEvento,otroTipoEvento,tipoPrograma,proveedorSugerido,
                    costoCapacitacionSugerido,origenRecursoEvento,flagEditar,
                    dataEventos,headersEventos, searchEventos, color_snackbar, snackbar, mensaje_snackbar,loader
                    ,fnLimpiarCampos,fnGuardar,fnEliminar,fnEditar
                    ,mes,fechaInicio,fechaTermino,numDias,numHorasEfectivas
                    ,idEvento,idPeriodo
                }
            },
        });

    </script>


    </html>