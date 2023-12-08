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

                <v-row>
                    <v-col md="8">
                        <template>
                            <v-container>
                                <v-row>
                                    <v-col v-for="(producto, index) in dataPresentacion" :key="index" cols="12" sm="4"
                                        md="4">
                                        <v-card class="d-flex flex-column align-center tarjeta" dark width="300px"
                                            @click="agregarElementoATabla(producto)"
                                            style="border-radius: 13px; background-color: #F2D6BD; margin-bottom: 20px;">

                                            <v-img style="margin-top: 10px;" :src="decodeBase64(producto.Foto)"
                                                aspect-ratio="3" class="d-flex justify-center align-center mb-1"
                                                width="230px" height="200px"></v-img>

                                            <v-container class="text-center"
                                                style="background-color: #F2D6BD; padding: 2px; height: 60px; width: 100%; color: #591607; font-size: 25px;">
                                                <v-row align="center" justify="center">
                                                    <v-col>
                                                        <strong>{{ producto.NombreProducto }}</strong>
                                                    </v-col>
                                                </v-row>
                                            </v-container>

                                            <!-- Texto con fondo blanco siempre visible -->
                                            <v-container class="text-center"
                                                style="background-color: #F2D6BD; padding: 2px; height: 60px; width: 100%; color: #591607; font-size: 18px;">
                                                <v-row align="center" justify="center">
                                                    <v-col>
                                                        <strong>{{ producto.NombrePresentacion }}</strong>
                                                    </v-col>
                                                </v-row>
                                            </v-container>

                                        </v-card>
                                    </v-col>
                                </v-row>
                            </v-container>
                        </template>
                    </v-col>
                    <v-col md="4">
                        <v-data-table :headers="headersProductos" :items="elementosTabla" class="elevation-2"
                            no-data-text="No se encontró ningún registro"
                            :hide-default-header="elementosTabla.length < 1"
                            :hide-default-footer="elementosTabla.length < 1" locale="es-ES" :mobile-breakpoint="NaN"
                            items-per-page="6" style="height: 400px;">
                            <template v-slot:item.s="{ item }">
                                <v-edit-dialog :return-value.sync="getSValue(item)"
                                    @save="(value) => guardarCantidad(value, item)">
                                    <div>{{ getSValue(item) }}</div>
                                    <v-text-field slot="input" v-model="item.S" label="Cantidad" single-line
                                        dense></v-text-field>
                                </v-edit-dialog>
                            </template>
                        </v-data-table>


                        <template>
                            <v-container>
                                <v-row>

                                    <v-col md="6">
                                        <v-text-field v-model="resultados.sumaS" label="Cantidad de productos"
                                            readonly></v-text-field>
                                    </v-col>
                                    <v-col md="6">

                                        <v-text-field v-model="resultados.totalDespuesDescuento" label="Subtotal"
                                            prefix="$"
                                            readonly></v-text-field>
                                    </v-col>
                                    <v-col md="6">

                                        <v-text-field v-model="resultados.porcentajeDelTotal" label="IVA" 
                                            prefix="$" readonly></v-text-field>
                                    </v-col>
                                    <v-col md="6">
                                        <v-text-field v-model="resultados.sumaTotal" label="Total de la venta" 
                                            prefix="$" readonly></v-text-field>
                                    </v-col>

                                    <v-row justify="center">
                                        
                                    
                                        <v-btn color="error"  x-large 
                                            @click="fnLimpiarCampos()"><v-icon>mdi-cancel</v-icon></v-btn>
                                            &nbsp;

                                            <v-btn color="primary" x-large  
                                            @click="fnGuardar()"><v-icon>mdi-content-save</v-icon>Aceptar</v-btn>
                                    </v-row>
                                </v-row>
                            </v-container>
                        </template>

                    </v-col>
                </v-row>

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
                        const ctr = "../../controlador/ventas/Controlador_vender.jsp";
                        //Variables POST


                        const productos = ref([
                            { imageUrl: 'url_1', nombre: 'Producto 1' },
                            { imageUrl: 'url_2', nombre: 'Producto 2' },
                            { imageUrl: 'url_3', nombre: 'Producto 3' },
                            { imageUrl: 'url_4', nombre: 'Producto 4' },
                        ]);
                        const ventas = ref([
                            { imageUrl: "../../images/monitorVenta.png", redirectUrl: "jsp/sistema/4.jsp", texto: "Monitor de ventas" },
                            { imageUrl: "../../images/abrirTurno.png", redirectUrl: "jsp/sistema/5.jsp", texto: "Abrir turno" },
                            { imageUrl: "../../images/cerrarTurno.png", redirectUrl: "jsp/sistema/6.jsp", texto: "Cerrar turno" },
                        ]);



                        const headersProductos = ref([
                            { text: 'Producto', align: 'left', sortable: true, value: 'NombreProducto' },
                            { text: 'Presentacion', align: 'left', sortable: true, value: 'NombrePresentacion' },
                            { text: 'Precio', align: 'left', sortable: true, value: 'PrecioPresentacion' },
                            { text: 'Cantidad', align: 'left', sortable: true, value: 's' },
                            { text: 'Total', align: 'left', sortable: true, value: 'Total' },
                        ]);

                        const elementosTabla = ref([]);


                        const dataPresentacion = ref([]);

                        const venta = ref([]);


                        const cantidad = ref("");
                        const subtotal = ref("");
                        const iva = ref("");
                        const total = ref("");




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
                            fnConsultarTabla();
                        });



                        function getSValue(item) {
                            // Verificar si el objeto item es válido antes de acceder a la propiedad S
                            return item ? item.S : '';
                        }

                        async function fnGuardar() {
                            this.$validator.validate().then(async esValido => {
                                if (esValido) {
                                    try {
                                        preloader("../../");
                                        let parametros = new URLSearchParams();
                                        
                                        parametros.append("accion", 2);
                                        parametros.append("CantidadProductos", this.resultados.sumaS);
                                        parametros.append("CostoTotal", this.resultados.sumaTotal);
                                        console.log(parametros);
                                        let { data, status } = await axios.post(ctr, parametros)
                                        if (status == 200) {
                                            if (data == "1") {
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
                                    } catch (error) {
                                        mostrarSnackbar('error');
                                        console.error(error);
                                    } finally {
                                        swal.close();
                                    }
                                }
                            })
                        }

                        function guardarCantidad(value, item) {
                            if (item && item.S) {
                                const intValue = parseInt(item.S, 10); // El segundo parámetro es la base (10 para decimal).

                                if (!isNaN(intValue)) {
                                    console.log(intValue);

                                    // Buscar el índice del producto en la lista
                                    const index = this.elementosTabla.findIndex(elemento => elemento.S === item.S);

                                    if (index !== -1) {
                                        // Si el producto existe, actualizar su cantidad
                                        this.elementosTabla[index].S = intValue;


                                    } else {
                                        console.error(`No se encontró el producto con cantidad ${item.S} en la lista.`);
                                    }

                                } else {
                                    console.error(`No se pudo convertir ${item.S} a un número entero.`);
                                }
                            }
                            this.actualizarTotales();

                        }

                        function actualizarTotales() {
                            console.log("Hola");
                            this.elementosTabla.forEach(item => {
                                console.log("Hola 3");
                                item.Total = (item.PrecioPresentacion || 0) * (item.S || 1);
                            });
                        }

                        function agregarElementoATabla(producto) {
                            const nuevoProducto = { ...producto, S: 1 };
                            this.elementosTabla.push(nuevoProducto);
                            this.actualizarTotales();
                        }

                        function decodeBase64(base64String) {
                            try {
                                var fotobase = 'data:image/png;base64,' + base64String;

                                return fotobase;
                            } catch (error) {
                                return null;
                            }
                        }

                        function getImagenUrl(base64Foto) {
                            return decodeBase64(base64Foto);
                        }

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

                                        dataPresentacion.value = data
                                    }
                                }
                            } catch (error) {
                                mostrarSnackbar('error');
                                console.error(error);
                            } finally {
                                swal.close();
                            }
                        }

                        function calcularSumas() {
                            const sumaTotal = this.elementosTabla.reduce((total, item) => total + (item.Total || 0), 0);
                            const sumaS = this.elementosTabla.reduce((total, item) => total + (item.S || 0), 0);

                            const descuento = sumaTotal * 0.16; // 16%


                            return {
                                sumaTotal,
                                sumaS,
                                totalDespuesDescuento: sumaTotal - descuento,
                                porcentajeDelTotal: descuento
                            };
                        }



                        async function handleProductoClick(producto) {
                            // Puedes agregar lógica adicional aquí antes de redirigir si es necesario
                            window.location.href = producto.redirectUrl;
                        }

                        async function handleVentaClick(venta) {
                            // Puedes agregar lógica adicional aquí antes de redirigir si es necesario
                            window.location.href = venta.redirectUrl;
                        }

                        return {
                            cantidad, subtotal, iva, total, fnGuardar,
                            guardarCantidad, getSValue, actualizarTotales, calcularSumas,
                            handleProductoClick, agregarElementoATabla, handleVentaClick, ventas, venta, productos, elementosTabla, fnConsultarTabla, dataPresentacion,
                            decodeBase64, getImagenUrl, headersProductos
                        }
                    },
                    computed: {
                        resultados() {
                            return this.calcularSumas();
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