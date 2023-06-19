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
                    <v-card-title class="text-center align-center" style="background-color: #00b293; color:#ffffff;">
                        <v-spacer></v-spacer>
                        <v-chip class="ma-2" color="white" outlined pill>
                            {{ nombre }} {{ primerAp }} {{segundoAp}}
                            <v-icon right>
                                mdi-account-outline
                            </v-icon>
                        </v-chip>
                    </v-card-title>
                    <v-card class="backgruond">
                        <v-row justify="center">
                            <v-col fluid md="3" style="padding: 0; margin: 0; height: 100%; overflow-y: auto">
                                <v-navigation-drawer permanent absolute>
                                    <v-list shaped>
                                        <v-list-group v-for="menuNv1 in itemMenuSeleccionado" :key="menuNv1.cve_menu"
                                            :value="false">
                                            <template v-slot:activator>
                                                <v-list-item-title>{{menuNv1.nombre}}</v-list-item-title>
                                            </template>
                                            <v-list-item v-if="menuNv1.submenu" v-for="menuNv2 in menuNv1.submenu"
                                                :key="menuNv2.cve_menu" link :href="menuNv2.ruta"
                                                target="iframe_modelo">
                                                <v-list-item-icon>
                                                    <v-icon>mdi-chevron-right</v-icon>
                                                </v-list-item-icon>
                                                <v-list-item-title v-text="menuNv2.nombre"></v-list-item-title>
                                            </v-list-item>
                                        </v-list-group>
                                    </v-list>
                                </v-navigation-drawer>
                            </v-col>
                            <v-col>
                                <iframe name="iframe_modelo" src="../../images/1.2.jpg" style="border: none;"
                                    class="align-center" width="100%" height="600px">
                                </iframe>
                            </v-col>
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
                            const ctr = "../../controlador/sistema/Loggin.jsp";
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
                            const menuArray = ref([]);
                            let objeto = {};
                            const itemMenuSeleccionado = ref([]);

                            const currentUser = localStorage.getItem('currentUser');
                            const user = JSON.parse(currentUser);
                            const nombre = user[0].nombre;
                            const primerAp = user[0].apellido_peterno;
                            const segundoAp = user[0].apellido_materno;

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
                                    parametros.append("accion", 3);
                                    parametros.append("usuario", 'sjonathan');
                                    parametros.append("password", '56964')
                                    let { data, status } = await axios.post(ctr, parametros);
                                    if (status == 200) {
                                        fnCargarDatos(data);
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

                            async function fnCargarDatos(menus) {
                                let menu_temp_1 = "";
                                let MenuNv1 = [];
                                for (const menu1 of menus) {
                                    if (menu_temp_1 !== menu1.menu_nivel_1) {
                                        menu_temp_1 = menu1.menu_nivel_1;
                                        let menu_temp_2 = "";
                                        let count_2 = 0;
                                        let MenuNv2 = [];
                                        for (const menu2 of menus) {
                                            if (
                                                menu_temp_1 === menu2.menu_nivel_1 &&
                                                menu_temp_2 !== menu2.menu_nivel_2
                                            ) {
                                                menu_temp_2 = menu2.menu_nivel_2;
                                                count_2++;
                                                let count_3 = 0;
                                                MenuNv2.push({
                                                    nivel: 2,
                                                    id_menu_padre: menu2.cve_padre_2,
                                                    id_menu: menu2.cve_menu_2,
                                                    nombre: menu2.menu_nivel_2,
                                                    ruta: menu2.ruta_2,
                                                    menu_abierto: "",
                                                    submenu: [],
                                                    num_submenus: count_3
                                                });
                                            }
                                        }
                                        MenuNv1.push({
                                            nivel: 1,
                                            id_menu_padre: 0,
                                            id_menu: menu1.cve_menu,
                                            nombre: menu1.menu_nivel_1,
                                            submenu: MenuNv2,
                                            num_submenus: count_2
                                        });
                                        MenuNv2 = [];
                                    }
                                }
                                itemMenuSeleccionado.value = MenuNv1;
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
                                cabeceraTablaReporte,
                                modalFechaInicioReporte,
                                dateFechaInicioReporte,
                                modalFechaFinReporte,
                                dateFechaFinReporte,
                                fnCargarDatos, save, formatDate,
                                parseDate,
                                cabeceraTemp,
                                items,
                                fnExportar,
                                objeto,
                                itemMenuSeleccionado,
                                fnMenu,
                                currentUser,
                                user,
                                nombre,
                                primerAp,
                                segundoAp,
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