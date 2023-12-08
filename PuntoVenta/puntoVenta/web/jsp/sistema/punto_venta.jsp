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
                <v-card color="grey lighten-4" flat height="50px" >
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

                <!-- 3 primeros items de productos del 1 al 3 -->
                <v-item-group active-class="primary" style="margin-top: 10px;">
                    <v-container>
                        <v-row>
                            <v-col v-for="(producto, index) in productos" :key="index" cols="10" md="4">
                                <v-item>
                                    <v-card class="d-flex flex-column align-center tarjeta" dark
                                        @click="handleProductoClick(producto)" style="border-radius: 13px; background-color: #F2D6BD;">
                                        <v-img style=" margin-top: 10px;" :src="producto.imageUrl" aspect-ratio="3"
                                            class="d-flex justify-center align-center mb-1" height="200px"
                                            width="230px"></v-img>

                                        <!-- Texto con fondo blanco siempre visible -->
                                        <v-container class="text-center"
                                            style="background-color: #F2D6BD; padding: 2px; height: 60px; width: 100%; color: #591607; font-size: 25px;">
                                            <v-row align="center" justify="center">
                                                <v-col cols="7">

                                                    <strong>
                                                        {{ producto.texto }}
                                                    </strong>
                                                </v-col>
                                            </v-row>
                                        </v-container>

                                    </v-card>
                                </v-item>
                            </v-col>
                        </v-row>
                    </v-container>
                </v-item-group>


                <v-item-group active-class="primary" style="margin-top: 10px;">
                    <v-container>
                        <v-row>
                            <v-col v-for="(venta, index) in ventas" :key="index" cols="10" md="4">
                                <v-item>
                                    <v-card class="d-flex flex-column align-center tarjeta" dark
                                        @click="handleProductoClick(venta)"
                                        style="border-radius: 13px; background-color: #F2D6BD;">
                                        <v-img style="margin-top: 10px;" :src="venta.imageUrl" aspect-ratio="2"
                                            class="white--text d-flex justify-center align-center mb-1" height="200px"
                                            width="230px"></v-img>

                                        <!-- Texto con fondo blanco siempre visible -->
                                        <v-container class="text-center"
                                            style="background-color: #F2D6BD; padding: 2px; height: 50px; width: 100%; color: #591607; font-size: larger;">
                                            <v-row align="center" justify="center">
                                                <v-col cols="7">
                                                    <strong>
                                                        {{ venta.texto }}
                                                    </strong>
                                                </v-col>
                                            </v-row>
                                        </v-container>

                                    </v-card>
                                </v-item>
                            </v-col>
                        </v-row>
                    </v-container>
                </v-item-group>
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
                        const ctr = "../../controlador/programas/Controlador_programa_desarrollo.jsp";
                        //Variables POST

                        const productos = ref([
                            { imageUrl: "../../images/vender.png", redirectUrl: "../ventas/vender.jsp", texto: "Vender" },
                            { imageUrl: "../../images/depositos.png", redirectUrl: "jsp/sistema/2.jsp", texto: "Retiros/Depositos" },
                            { imageUrl: "../../images/corteCaja.png", redirectUrl: "jsp/sistema/3.jsp", texto: "Corte de caja" },
                        ]);

                        const ventas = ref([
                            { imageUrl: "../../images/monitorVenta.png", redirectUrl: "../ventas/monitorVentas.jsp", texto: "Monitor de ventas" },
                            { imageUrl: "../../images/abrirTurno.png", redirectUrl: "jsp/sistema/5.jsp", texto: "Abrir turno" },
                            { imageUrl: "../../images/cerrarTurno.png", redirectUrl: "jsp/sistema/6.jsp", texto: "Cerrar turno" },
                        ]);

                        const producto = ref([]);

                        const venta = ref([]);


                        //Otras variables

                        //Setup del calendario

                        //Setup de inputs


                        //SNACKBAR

                        //Loaders
                        //Dialogs

                        //DataTable
                        //dataUsuarios

                        //Accion automatizada para mostrar la tabla
                        onMounted(() => {
                        });

                        async function handleProductoClick(producto) {
                            // Puedes agregar lógica adicional aquí antes de redirigir si es necesario
                            window.location.href = producto.redirectUrl;
                        }

                        async function handleVentaClick(venta) {
                            // Puedes agregar lógica adicional aquí antes de redirigir si es necesario
                            window.location.href = venta.redirectUrl;
                        }

                        return {
                            handleProductoClick, handleVentaClick, ventas, venta, producto, productos
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