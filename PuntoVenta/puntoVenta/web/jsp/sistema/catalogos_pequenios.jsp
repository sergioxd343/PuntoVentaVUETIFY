<%@page contentType="text/html; charset=utf-8" language="java" errorPage="" %>
    <!DOCTYPE html>
    <html lang="es">

    <head>
        <link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900" rel="stylesheet">
        <link href="../../styles/icon_material_design_4495/css/materialdesignicons.min.css" rel="stylesheet">
        <link href="../../javascript/VueJs/vuetify/vuetify.min.css" rel="stylesheet">
        <link rel="shortcut icon" href="../../images/favicon.ico" type="image/x-icon">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sistema de Mejora de la Aplicación Única del Registro de la Información</title>
        <style>
            html {
                overflow-y: hidden !important;
            }

            .msj-error {
                position: absolute !important;
                bottom: 65px;
            }

            .lux-col1 {
                /* background-image: url('resource/img/zonagif.gif'); */
                background-image: url('../../images/1.2.jpg');

                background-position-x: left;
                position: relative;
            }

            .lux-col2 {
                position: relative;
            }

            .bg-perfil {
                background: #F6CE3C;
                /* fallback for old browsers */
                background: -webkit-linear-gradient(to right, #F6CE3C, #FFB600);
                /* Chrome 10-25, Safari 5.1-6 */
                background: linear-gradient(to right, #F6CE3C, #FFB600);
                /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */

            }
        </style>
        <style>
            body {
                font-family: 'Roboto', sans-serif;
                height: 100% !important;
            }

            .backgruond {
                background-image: url(../../images/1.2.jpg) !important;
                background-blend-mode: multiply;
            }
        </style>
    </head>

    <body>
        <div id="app">
            <v-app>
                <v-card>
                    <v-card class="backgruond">
                        <v-row justify="center">
                            <template>
                                <v-card color="basil">
                                    <v-tabs v-model="tab" show-arrows>
                                        <v-tabs v-model="tab" background-color="transparent" color="basil" grow>
                                            <v-tab v-for="item in itemMenuSeleccionado" :key="item">
                                                {{ item.nombre }}
                                            </v-tab>
                                        </v-tabs>

                                        <v-tabs-items v-model="tab">
                                            <v-tab-item v-for="item in itemMenuSeleccionado" :key="item">
                                                <v-card color="basil" flat>
                                                    <iframe name="iframe_modelo" :src="item.ruta" style="border: none;"
                                                        class="align-center" width="100%" height="600px">
                                                    </iframe>
                                                </v-card>
                                            </v-tab-item>
                                        </v-tabs-items>
                                    </v-tabs>
                                </v-card>
                            </template>
                        </v-row>
                    </v-card>
                </v-card>
            </v-app>
        </div>
        <%--Desarrollo--%>
            <script src="../../javascript/axios/axios.js"></script>
            <script src="../../javascript/VueJs/vue/vue.js"></script>
            <script src="../../javascript/VueJs/vue/vue-composition-api.prod.js"></script>
            <script src="../../javascript/VueJs/vuetify/vuetify.min.js"></script>





            <%--Desarrollo--%>
                <!--<script src="controlador/js/escolar/reporte_validacion_solicitud_captura_tardia_new.js"></script>-->
                <script>
                    /*  global axios, Vue, VueCompositionAPI */
                    const ca = window.VueCompositionAPI;


                    Vue.use(ca.default);
                    const vm = new Vue({
                        el: "#app",
                        vuetify: new Vuetify(),
                        setup() {
                            let obj = this;
                            //Composition components

                            const { ref, onMounted, watch } = VueCompositionAPI;
                            const ctr = "../../controlador/catalogos_pequenios/controlador_catalogos_pequenios.jsp";
                            const accion = ref(0);
                            const modalFechaInicioReporte = ref(false);
                            const modalFechaFinReporte = ref(false);
                            const dateFechaInicioReporte = ref((new Date(Date.now() - (new Date()).getTimezoneOffset() * 60000)).toISOString().substr(0, 10));
                            const dateFechaFinReporte = ref((new Date(Date.now() - (new Date()).getTimezoneOffset() * 60000)).toISOString().substr(0, 10));
                            const dataExportar = ref([]);
                            const busqueda = ref('');
                            const password = ref('');
                            const cuenta = ref('');
                            const show = ref(false);
                            const loading = ref(false);
                            const passwordShow = ref(false);

                            let items = [];
                            const tab = null;
                            const menuArray = ref([]);
                            let objeto = {};
                            const itemMenuSeleccionado = ref([]);

                            //SNACKBAR
                            const loader = ref(false);
                            const snackbar = ref(false);
                            const mensaje_alerta = ref('');
                            const color_mensaje = ref('');

                            //datatable reporte
                            const tablaReporte = ref([]);
                            const cabeceraTemp = ref(null);
                            const cabeceraTablaReporte = ref([
                                { text: 'Cabeceras', align: 'start', sortable: true, value: 'no' },

                            ]);

                            //LifeCicle vue
                            onMounted(() => {
                                //fnLogin();
                                fnMenu();
                            });

                            async function fnMenu() {
                                try {
                                    //Peticion ajax al controlador y envio de parametros
                                    let parametros = new URLSearchParams();
                                    parametros.append("accion", 1);
                                    let { data, status } = await axios.post(ctr, parametros);
                                    if (status == 200) {
                                        itemMenuSeleccionado.value = data;
                                    }
                                } catch (error) {
                                    console.log(error);
                                } finally {
                                    loader.value = false;
                                }
                            }

                            /*watch(() => 
                                cve_colonia_.value,
                                    (value)=> {
                                        console.log("colonia: ",value);
                                    },	
                            	
                            );
                            */

                            function formatDate(date) {
                                //console.log("Date: ", date);
                                if (!date) return null

                                const [year, month, day] = date.split('-')
                                //console.log("Date2: ", day);
                                return day + '/' + month + '/' + year
                            }

                            function save(date) {
                                var o = this;
                                o.$refs.menu.save(date)

                                pickerDate.value = date;
                            }

                            function parseDate(date) {
                                if (!date) return null

                                const [month, day, year] = date.split('/')
                                return `${year}/${month.padStart(2, '0')}/${day.padStart(2, '0')}`
                            }

                            async function fnExportar() {
                                loader.value = true;

                                if (tablaReporte.value.length > 0) {
                                    //loader.value = true;
                                    dataExportar.value = []
                                    let array_ = [];
                                    cabeceraTablaReporte.value.map(i => {
                                        console.log("Cabeceras: ", i.text);
                                        array_.push(
                                            { text: i.text }
                                        )
                                    });
                                    dataExportar.value.push([{ text: '' }]);
                                    dataExportar.value.push(array_);


                                    console.log("dataExportar.value: ", dataExportar.value);


                                    array_ = [];
                                    /*
                                    tablaReporte.value.forEach(function(item, index){ 
                                    cabeceraTablaReporte.value.map(i=>{
                                    array_.push(
                                    {text:item.}
                                    )
                                    })
                                    dataExportar.value.push(array_);
                                    array_  = [];
                                    })
                                    */

                                    tablaReporte.value.forEach(function (item, index) {

                                        console.log("item: ", item.no);

                                        cabeceraTablaReporte.value.map(i => {
                                            array_.push(

                                                { text: item[i.value] },

                                            )
                                        })
                                        dataExportar.value.push(array_);
                                        array_ = [];
                                    })



                                    //Se declara el nombre del archivo y de la hoja de excel, así mismo se manda llamar el data = dataExport
                                    var tableData = [
                                        {
                                            "sheetName": "Reporte Transparencia",
                                            "data": dataExportar.value
                                        }
                                    ];

                                    var date_variable = new Date();
                                    var year = date_variable.getFullYear();
                                    var month = date_variable.getMonth() + 1;
                                    var day = date_variable.getDate();

                                    var hour = date_variable.getHours();
                                    var minutes = date_variable.getMinutes();
                                    var seconds = date_variable.getSeconds();

                                    var full_date = year + month + day + hour + minutes + seconds;

                                    var options = {
                                        fileName: "Reporte de Transparencia_" + full_date
                                    };
                                    //Libreria que realiza el exportar a Excel
                                    Jhxlsx.export(tableData, options);

                                }

                                try {
                                }
                                catch (error) {
                                    console.log(error);
                                } finally {
                                    //oading2.value = false;
                                    loader.value = false;
                                }
                            };



                            return {
                                accion,
                                loader,
                                snackbar,
                                mensaje_alerta,
                                color_mensaje,
                                tablaReporte,
                                tab,
                                cabeceraTablaReporte,
                                modalFechaInicioReporte,
                                dateFechaInicioReporte,
                                modalFechaFinReporte,
                                dateFechaFinReporte,
                                save, formatDate,
                                parseDate,
                                cabeceraTemp,
                                items,
                                fnExportar,
                                objeto,
                                itemMenuSeleccionado,
                                fnMenu,
                                busqueda,
                                cuenta,
                                password,
                                show,
                                loading,
                                passwordShow
                            }
                        }


                    });
                </script>

    </body>

    </html>