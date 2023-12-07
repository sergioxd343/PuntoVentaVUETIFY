<%@page contentType="text/html; charset=UTF-8" language="java" errorPage="" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900" rel="stylesheet">
        <link href="../../styles/icon_material_design_4495/css/materialdesignicons.min.css" rel="stylesheet">
        <link href="../../javascript/VueJs/sweetalert2/sweetalert2.css" />
        <link href="../../javascript/VueJs/vuetify/vuetify.min.css" rel="stylesheet">
        <meta name="viewport"
            content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
        <script src="../../javascript/VueJs/vue/vue.js"></script>
        <script type="" src="../../javascript/VueJs/vue/vue-composition-api.prod.js"></script>
        <title>JSP Page</title>
    </head>
    <style>
        body {
            font-family: 'Roboto';
        }

        .tarjeta:hover {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transform: scale(1.05);
            transition: box-shadow 0.3s, transform 0.3s;
        }
    </style>

    <body>
        <div id="app">
            <v-app style="background-color: white;">
                <!-- Componente de menu -->
                <v-card color="grey lighten-4" flat height="50px">
                    <v-toolbar dense style="background-color: #591607;">
                        <v-app-bar-nav-icon></v-app-bar-nav-icon>

                        <v-toolbar-title style="color: white">Title</v-toolbar-title>

                        <v-spacer></v-spacer>

                        <v-btn icon>
                            <v-icon style="color:white">mdi-magnify</v-icon>
                        </v-btn>

                        <v-btn icon>
                            <v-icon>mdi-heart</v-icon>
                        </v-btn>

                        <v-btn icon>
                            <v-icon>mdi-dots-vertical</v-icon>
                        </v-btn>
                    </v-toolbar>
                </v-card>

                <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                    <!--Columna-->

                    <v-col md="6">
                        <v-text-field label="Nombre de programa de desarrollo" outlined persistent-hint
                            v-validate="'required|max:200'" :error="errors.has('nombre programa de desarrollo')"
                            :error-messages="errors.first('nombre programa de desarrollo')"></v-text-field>
                    </v-col>

                </v-row>

                <!-- Empieza la grafica -->
                <v-card class="mt-12 mx-12" max-width="2000">
                    <v-sheet class="v-sheet--offset mx-auto" color="grey" elevation="12" max-width="calc(100% - 32px)">
                        <v-sparkline :labels="labels" :value="value" color="white" line-width="2" padding="20"
                            :style="{ fontSize: '10px' }"></v-sparkline>
                    </v-sheet>

                    <v-card-text class="pt-0">
                        <div class="text-h6 font-weight-light mb-2">
                            User Registrations
                        </div>
                        <div class="subheading font-weight-light grey--text">
                            Last Campaign Performance
                        </div>
                        <v-divider class="my-2"></v-divider>
                        <v-icon class="mr-2" small>
                            mdi-clock
                        </v-icon>
                        <span class="text-caption grey--text font-weight-light">last registration 26 minutes
                            ago</span>
                    </v-card-text>
                </v-card>

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
                import { preloader, guardar, errorGuardar, actualizar, errorActualizar, eliminar, errorEliminar, cerrar, confirmarE, aviso, confirmar } from '../../javascript/mensajeSistema/mensajes_sweetalert_vue.js';
                Vue.use(VeeValidate, {
                    classes: true
                });
                //Lenguaje de VeeValidate
                VeeValidate.Validator.localize("es");

                new Vue({
                    el: "#app",
                    vuetify: new Vuetify(),
                    setup() {
                        const {
                            ref,
                            onMounted,
                            watch
                        } = VueCompositionAPI;
                        const ctr = "../../controlador/ventas/Controlador_monitor_ventas.jsp";
                        //Variables POST}



                        //variables Array

                        const dataVentas = ref([]);

                        const dataLabels = ref([]);

                        const labels = ref(['hola' + 10, '3am', '6am', '9am', '12pm', '3pm', '6pm', '9pm']);

                        // ExtraFer los valores de la propiedad "Total" usando map
                        const newDataVentas = ref(dataVentas.value.map(item => item.Total));

                        // Usa newDataVentas en lugar de value
                        const value = ref(newDataVentas.value);





                        //Otras variables





                        // const newDataVentas = ref(dataVentas.value.map(item => item.Total));

                        // Usa newDataVentas en lugar de value
                        // const value = ref(newDataVentas.value);
                        //Setup del calendario

                        //Setup de inputs


                        //SNACKBAR

                        //Loaders
                        //Dialogs

                        //DataTable
                        //dataUsuarios

                        //Accion automatizada para mostrar la tabla
                        onMounted(() => {
                            fnConsultarTabla();
                            fnConsultarTablaLabels();
                        });


                        async function fnConsultarTabla() {
                            try {
                                preloader("../../");
                                //arreglo
                                let parametros = new URLSearchParams();
                                //le mandamos un parametro llamado accion
                                parametros.append("accion", 1);
                                //axios envia la peticion
                                let { data, status } = await axios.post(ctr, parametros)
                                if (status == 200) {
                                    if (data.length > 0) {

                                        dataVentas.value = data
                                        console.log('dataVentas:', dataVentas.value);
                                        value.value = dataVentas.value.map(item => item.Total);

                                    }
                                }
                            } catch (error) {
                                mostrarSnackbar('error');
                                console.error(error);
                            } finally {
                                swal.close();
                            }
                        }

                        async function fnConsultarTablaLabels() {
                            try {
                                preloader("../../");
                                //arreglo
                                let parametros = new URLSearchParams();
                                //le mandamos un parametro llamado accion
                                parametros.append("accion", 2);
                                //axios envia la peticion
                                let { data, status } = await axios.post(ctr, parametros)
                                if (status == 200) {
                                    if (data.length > 0) {

                                        dataLabels.value = data
                                        console.log('dataLabels:', dataVentas.value);
                                        labels.value = dataLabels.value.map(item => item.FechaVenta);

                                    }
                                }
                            } catch (error) {
                                mostrarSnackbar('error');
                                console.error(error);
                            } finally {
                                swal.close();
                            }
                        }



                        return {
                            value, labels, fnConsultarTabla, fnConsultarTablaLabels, newDataVentas, dataLabels
                        }
                    },
                });
                Vue.config.devtools = true;
            </script>
            <style>
                .col-expanded {
                    height: 100%;
                }
            </style>

    </html>