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
    </style>

    <body>
        <div id="app">
            <v-app>
                <v-container fluid>
                    <v-card>
                        <v-card-title style="background-color: #591607; color:#ffffff; headline">
                            Presentaciones
                        </v-card-title>
                        <v-container fluid>
                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                <!--Columna-->
                                <v-col md="6" v-if="false">
                                    <v-text-field 
                                        v-model="IDPresentacion"
                                        outlined
                                        
                                    ></v-text-field>
                                </v-col>

                                <v-col md="6">
                                    <v-select
                                      v-model="IDProducto"
                                      :items="ArrayProductos"
                                      item-text="NombreProducto" // Especifica la propiedad del objeto a mostrar como texto en el select
                                      item-value="IDProducto" // Especifica la propiedad del objeto a usar como valor en el select
                                      outlined
                                      label="Nombre del producto"
                                      persistent-hint
                                      v-validate="'required|max:200'"
                                      data-vv-name="nombre del producto"
                                      :error="errors.has('nombre del producto')"
                                      :error-messages="errors.first('nombre del producto')"
                                      ref="nombreProductoField"
                                    ></v-select>
                                  </v-col>

                                <v-col md="6">
                                    <v-text-field 
                                        v-model="NombrePresentacion"
                                        outlined
                                        label="Nombre de la presentacion"
                                        persistent-hint
                                        v-validate="'required|max:200'"
                                        data-vv-name="nombre del producto"
                                        :error="errors.has('nombre del producto')"
                                        :error-messages="errors.first('nombre del producto')"
                                        
                                    ></v-text-field>
                                </v-col>

                                <v-col md=6>
                                    <v-text-field 
                                        v-model="PrecioPresentacion"
                                        outlined
                                        label="Precio de la presentacion"
                                        persistent-hint
                                        prefix="$"
                                        suffix="pesos"
                                        v-validate="'required|max:200'"
                                        data-vv-name="peso de la unidad"
                                        :error="errors.has('peso de la unidad')"
                                        :error-messages="errors.first('peso de la unidad')"
                                        
                                    ></v-text-field>
                                </v-col>

                                <v-col md=6>
                                    <v-textarea v-model="Descripcion" outlined label="Descripción del producto"
                                        persistent-hint v-validate="'required|max:200'"
                                        data-vv-name="Descripcion"
                                        :error="errors.has('descripcion')"
                                        :error-messages="errors.first('descripciona')" :rows="3"
                                        :style="{ height: 'auto', 'max-height': '84px' }"></v-textarea>
                                </v-col>

                                






                            </v-row>

                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">




                            </v-row>
                            <%-- <v-row justfy="center" dense>
                                </v-row> --%>

                                <v-divider></v-divider>


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
                                        <v-text-field v-model="search" append-icon="mdi-magnify" label="Buscar" outlined
                                            hide-details></v-text-field>

                                        <v-data-table :headers="headersProgramaDesarrollo"
                                            :items="dataProgramaDesarrollo" :search="search" class="elevation-2"
                                            no-data-text="No se encontró ningún registro"
                                            :hide-default-header="dataProgramaDesarrollo.length < 1"
                                            :hide-default-footer="dataProgramaDesarrollo.length < 1" locale="es-ES"
                                            :mobile-breakpoint="NaN" items-per-page="10">

                                            <template v-slot:item.estatus="{item}">
                                                <v-chip class="ma-2"
                                                    style="width: 80px; display: flex; justify-content: center; align-items: center;"
                                                    link @click="fnCambiarEstatus(item)"
                                                    :color="item.Activo ? 'success' : 'grey'" outlined>
                                                    {{ item.Activo ?
                                                    "Activo" : "Inactivo" }}
                                                </v-chip>
                                            </template>

                                            <template v-slot:item.foto="{item}">
                                                <v-img :src="decodeBase64(item.Foto)" height="50" width="50"></v-img>
                                            </template>

                                            <template v-slot:item.editar="{item}">
                                                <v-btn fab small color="warning" @click="flagEditar = true; itemEditar = item;
                                                NombrePresentacion = item.NombrePresentacion
                                                IDPresentacion = item.IDPresentacion;
                                                IDProducto = item.IDProducto;
                                                PrecioPresentacion = item.PrecioPresentacion;
                                                Descripcion = item.Descripcion;
                                                $refs.nombreProductoField.focus();
                                            "><v-icon>mdi-square-edit-outline</v-icon></v-btn>
                                            </template>

                                            <template v-slot:item.eliminar="{item}">
                                                <v-btn fab small color="error"
                                                    @click="fnEliminar(item);"><v-icon>mdi-trash-can</v-icon></v-btn>
                                            </template>
                                            <template v-slot:item.password="{item}">
                                                <v-tooltip bottom>
                                                    <template v-slot:activator="{on, attrs}">
                                                        <span v-bind="attrs" v-on="on"
                                                            @click="navigator.clipboard.writeText(item.password); mostrarSnackbar('success', 'Texto copiado al portapapeles.')"><b>{{item.password}}</b></span>
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
                <%-- <v-dialog v-model="dialogBuscador" width="70%" scrollable transition="dialog-bottom-transition">
                    <v-card>
                        <v-card-title class="text-h5 grey lighten-2">
                            Búsqueda Avanzada
                        </v-card-title>
                        <v-card-text>
                            <v-row justify="center">
                                <v-col md=8>
                                    <v-text-field outlined label="Nombre" v-model="nombreBuscar"
                                        @keyup.enter="fnBusquedaNombre()"></v-text-field>
                                </v-col>
                            </v-row>
                            <v-row justify="center">
                                <v-col md=4 offset-md=8>
                                    <v-text-field label="Filtrar" v-model="search"></v-text-field>
                                </v-col>
                            </v-row>

                            <v-row justify="center">
                                <v-col md=12>
                                    <v-data-table :headers="headersBusqueda" :items="dataBusqueda" :search="search"
                                        class="elevation-2" no-data-text="No se encontro ningun registro"
                                        :hide-default-header="dataBusqueda.length < 1"
                                        :hide-default-footer="dataBusqueda.length < 1" locale="es-ES"
                                        :mobile-breakpoint="NaN" items-per-page="10" @click:row="seleccionarUsuario">
                                    </v-data-table>
                                </v-col>
                            </v-row>
                        </v-card-text>
                        <v-divider></v-divider>
                        <v-card-actions>
                            <v-spacer></v-spacer>
                            <v-btn color="primary" text @click="dialogBuscador = false">
                                Cerrar
                            </v-btn>
                        </v-card-actions>
                    </v-card>
                    </v-dialog> --%>
                    <!-- TODO: ALERTAS DE SISTEMA-->
                    <v-snackbar v-model="snackbar" top="top" :bottom="true" :multi-line="true" :color="color_snackbar">
                        {{mensaje_snackbar}}
                        <%-- <v-icon color="white" @click="snackbar = false">mdi-close-circle</v-icon> --%>
                    </v-snackbar>
                    <v-overlay :value="loader" z-index="1000">
                        <v-img aspect-ratio="2" class="white--text align-end" height="212px" width="292px"
                            src="../../images/Logo_utl_animado.gif">
                        </v-img>
                    </v-overlay>
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
                        const ctr = "../../controlador/productos/Controlador_presentaciones.jsp";

                        //Variables POST

                        const IDPresentacion = ref("");
                        const IDProducto = ref("");
                        const NombrePresentacion = ref("");
                        const PrecioPresentacion = ref("");
                        const Descripcion = ref("");

                        



                        //Otras variables
                        const flagEditar = ref(false);
                        const itemEditar = ref({});
                        //Setup del calendario
                        const arrayTiposUsuario = ref([]);
                        const ArrayProductos = ref([]);

                        //Setup de inputs
                        const search = ref("");

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
                        //dataUsuarios
                        const dataProgramaDesarrollo = ref([]);
                        const dataUsuarios = ref([]);
                        const headersProgramaDesarrollo = ref([
                            { text: 'Nombre de la presentacion', align: 'left', sortable: true, value: 'NombrePresentacion' },
                            { text: 'Precio de la presentacion', align: 'left', sortable: true, value: 'PrecioPresentacion' },
                            { text: 'Descripción', align: 'left', sortable: true, value: 'Descripcion' },
                            { text: 'Editar', align: 'left', sortable: true, value: 'editar' },
                            { text: 'Estatus', align: 'left', sortable: true, value: 'estatus', valueFormat: (value) => value ? 'true' : 'false', color: (value) => value ? 'green' : 'red' },
                        ]);

                        const searchProgramaDesarrollo = ref([]);

                        //Accion automatizada para mostrar la tabla
                        onMounted(() => {
                            fnConsultarTabla();
                            fnSelectProducto();
                        });

                        function decodeBase64(base64String) {
                        try {
                            var fotobase = 'data:image/png;base64,'+ base64String;
                            
                            return fotobase;
                        } catch (error) {
                            return null;
                        }
                    }

                        function getImagenUrl(base64Foto) {
                            return decodeBase64(base64Foto);
                        }

                        async function handleFileChange(file) {
                            // Convierte el archivo a base64
                            const reader = new FileReader();
                            reader.onload = () => {
                                this.encodedFile = reader.result.split(",")[1];
                                console.log('Archivo codificado en base64:', this.encodedFile);
                            };
                            reader.readAsDataURL(file);

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

                                        dataProgramaDesarrollo.value = data
                                    }
                                }
                            } catch (error) {
                                mostrarSnackbar('error');
                                console.error(error);
                            } finally {
                                swal.close();
                            }
                        }

                        async function fnSelectProducto() {
                            try {
                                preloader("../../");
                                //arreglo
                                let parametros = new URLSearchParams();
                                //le mandamos un parametro llamado accion
                                parametros.append("accion", 5);
                                //axios envia la peticion
                                let { data, status } = await axios.post(ctr, parametros)
                                if (status == 200) {
                                    if (data.length > 0) {

                                        ArrayProductos.value = data
                                    }
                                }
                            } catch (error) {
                                mostrarSnackbar('error');
                                console.error(error);
                            } finally {
                                swal.close();
                            }
                        }

                        async function fnGuardar() {
                            this.$validator.validate().then(async esValido => {
                                if (esValido) {
                                    try {
                                        preloader("../../");
                                        let parametros = new URLSearchParams();
                                        parametros.append("accion", 2);
                                        parametros.append("IDProducto", IDProducto.value);
                                        parametros.append("NombrePresentacion", NombrePresentacion.value);
                                        parametros.append("PrecioPresentacion", PrecioPresentacion.value);
                                        parametros.append("Descripcion", Descripcion.value);
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


                        async function fnCambiarEstatus(item) {
                            confirmarE("¿Realmente quieres desactivar éste registro?").then(async (result) => {
                                if (result.isConfirmed) {
                                    try {
                                        preloader("../");
                                        let parametros = new URLSearchParams();
                                        parametros.append("accion", 3);
                                        parametros.append("IDPresentacion", item.IDPresentacion);
                                        parametros.append("Activo", (item.Activo == true ? 0 : 1));
                                        console.log("🚀 ~ file: perfil_usuario.jsp:283 ~ fnCambiarEstatus ~ parametros:", parametros)
                                        let { data, status } = await axios.post(ctr, parametros);
                                        if (status == 200) {
                                            if (data == "1") {
                                                mostrarSnackbar(
                                                    "success",
                                                    "Registro actualizado correctamente."
                                                );
                                                fnConsultarTabla();
                                                
                                            }
                                        }
                                    } catch (error) {
                                        mostrarSnackbar("error");
                                        console.error(error);
                                    } finally {
                                        swal.close();
                                    }
                                }
                            })
                        }

                        async function fnEditar(item) {
                            confirmarE("¿Realmente quieres desactivar éste registro?").then(async (result) => {
                                if (result.isConfirmed) {
                                    try {
                                        preloader("../../");
                                        let parametros = new URLSearchParams();
                                        parametros.append("accion", 4);
                                        parametros.append("IDProducto", IDProducto.value);
                                        parametros.append("NombrePresentacion", NombrePresentacion.value);
                                        parametros.append("PrecioPresentacion", PrecioPresentacion.value);
                                        parametros.append("Descripcion", Descripcion.value);
                                        parametros.append("IDPresentacion", IDPresentacion.value);
                                        let { data, status } = await axios.post(ctr, parametros)
                                        if (status == 200) {
                                            if (data == "1") {
                                                mostrarSnackbar("success", "Registro actualizado correctamente.");
                                                fnConsultarTabla();
                                                fnLimpiarCampos(this);

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

                        function fnLimpiarCampos(cx) {//cx = contexto
                            NombrePresentacion.value ="";
                            IDPresentacion.value ="";
                            IDProducto.value ="";
                            PrecioPresentacion.value ="";
                            Descripcion.value ="";

                            flagEditar.value = false;
                            itemEditar.value = {};

                            if (this == undefined)
                                cx.$validator.reset();
                            else
                                this.$validator.reset();
                        }

                        function mostrarSnackbar(color, texto) {
                            snackbar.value = true;
                            color_snackbar.value = color;
                            if (color == "error")
                                mensaje_snackbar.value = "Ocurrió un error. Intentalo de nuevo más tarde.";
                            else
                                mensaje_snackbar.value = texto;
                        }
                        return {
                            color_snackbar, snackbar, mensaje_snackbar, loader, mostrarSnackbar, flagEditar,
                            NombrePresentacion, PrecioPresentacion, Descripcion, IDPresentacion,IDProducto,  
                            handleFileChange, getImagenUrl, decodeBase64,ArrayProductos,
                            dataProgramaDesarrollo, headersProgramaDesarrollo, searchProgramaDesarrollo, arrayTiposUsuario,
                            dialogBuscador, dialogDetallesCotizacion, dialogProveedor, search,
                            fnConsultarTabla, fnGuardar, fnLimpiarCampos, fnEditar ,  fnCambiarEstatus, itemEditar
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