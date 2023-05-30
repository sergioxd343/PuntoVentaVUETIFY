<%@page contentType="text/html; charset=UTF-8" language="java" errorPage="" %>
  <!DOCTYPE html>
  <html>

  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900" rel="stylesheet" />
    <link href="../../styles/icon_material_design_4495/css/materialdesignicons.min.css" rel="stylesheet" />
    <link href="../../javascript/VueJs/sweetalert2/sweetalert2.css" />
    <link href="../../javascript/VueJs/vuetify/vuetify.min.css" rel="stylesheet" />
    <link rel="shortcut icon" href="../../images/favicon.ico" type="image/x-icon">
    <meta name="viewport"
      content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui" />
    <script src="../../javascript/VueJs/vue/vue.js"></script>
    <script type="" src="../../javascript/VueJs/vue/vue-composition-api.prod.js"></script>
    <title>Solicitud De Proyecto</title>
  </head>
  <style>
    body {
      font-family: "Roboto";
    }
  </style>

  <body>
    <div id="app">
      <v-app>
        <v-container fluid>
          <v-card>
            <v-card-title style="background-color: #00b293; color:#ffffff;">
              Solicitud de Proyecto
            </v-card-title>
            <v-container fluid>
              <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                <v-col md="5">
                  <v-text-field v-model="nombreProyecto" outlined label="Nombre del Proyecto" persistent-hint
                    v-validate="'required|max:500'" data-vv-name="nombre del proyecto"
                    :error="errors.has('nombre del proyecto')"
                    :error-messages="errors.first('nombre del proyecto')"></v-text-field>
                </v-col>
                <v-col md="2">
                  <v-menu ref="menu" :close-on-content-click="false" :return-value.sync="fecha"
                    transition="scale-transition" offset-y min-width="auto">
                    <template v-slot:activator="{ on, attrs }">
                      <v-text-field v-validate="'required'" data-vv-name="fecha" :error="errors.has('fecha')"
                        v-model="fecha" label="Fecha" :error-messages="errors.first('fecha')"
                        prepend-icon="mdi-calendar" readonly v-bind="attrs" v-on="on"></v-text-field>
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
                <v-col md="5">
                  <v-autocomplete v-model="area" outlined label="Área Solicitante" v-validate="'required'"
                    :items="areas" item-value="idArea" item-text="nombreArea" data-vv-name="área solicitante"
                    :error="errors.has('área solicitante')"
                    :error-messages="errors.first('área solicitante')"></v-autocomplete>
                </v-col>
                <v-col md="6">
                  <v-textarea v-model="objetivo" data-vv-name="objetivo del proyecto"
                    hint="La finalidad de la creación del proyecto, ¿qué? ¿A quién se aplica? ¿Para qué?¿cuándo?"
                    :error="errors.has('objetivo del proyecto')" :error-messages="errors.first('objetivo del proyecto')"
                    label="Objetivo del Proyecto" persistent-hint v-validate="'required|max:500'" auto-grow outlined
                    rows="1" row-height="15"></v-textarea>
                </v-col>
                <v-col md="6">
                  <v-textarea v-model="descripcion" data-vv-name="descripcion del proyecto"
                    :error="errors.has('descripcion del proyecto')" hint="Describa brevemente el proyecto"
                    :error-messages="errors.first('descripcion del proyecto')" label="Descripción del Proyecto"
                    persistent-hint v-validate="'required|max:500'" auto-grow outlined rows="1"
                    row-height="15"></v-textarea>
                </v-col>

                <v-col md="4">
                  <v-textarea v-model="recursos" auto-grow outlined rows="1" row-height="15" label="Recursos Necesarios"
                    persistent-hint v-validate="'required|max:500'" data-vv-name="recursos necesarios"
                    :error="errors.has('recursos necesarios')"
                    :error-messages="errors.first('recursos necesarios')"></v-textarea>
                </v-col>
                <v-col md="6">
                  <v-textarea v-model="acuerdos" label="Acuerdos Establecidos" data-vv-name="acuerdos establecidos"
                    hint="(por Innovación Educativa) " :error="errors.has('acuerdos establecidos')"
                    :error-messages="errors.first('acuerdos establecidos')" persistent-hint
                    v-validate="'required|max:500'" auto-grow outlined rows="1" row-height="15"></v-textarea>
                </v-col>
              </v-row>
              <%-- <v-row justfy="center" dense> </v-row> --%>
                <v-row justify="center">
                  <v-btn color="primary"
                    @click="flagEditar ? fnEditar() : fnGuardar()"><v-icon>mdi-content-save</v-icon>{{ flagEditar ?
                    "Editar" : "Guardar" }}</v-btn>
                  &nbsp;
                  <v-btn color="error" @click="fnLimpiarCampos()"><v-icon>mdi-cancel</v-icon>Cancelar</v-btn>
                </v-row>
                <v-row justify="center">
                  <v-col md="12">
                    <v-data-table :headers="headerProyectos" :items="dataSolicitudProyecto" :search="searchProyectos"
                      class="elevation-2" no-data-text="No se encontro ningun registro"
                      :hide-default-header="dataSolicitudProyecto.length < 1"
                      :hide-default-footer="dataSolicitudProyecto.length < 1" locale="es-ES" :mobile-breakpoint="NaN"
                      items-per-page="10">
                      <template v-slot:item.status="{item}">
                        <%-- <v-tooltip bottom>
                          --%> <%-- <template v-slot:activator="{on, attrs}">
                            --%> <%-- v-bind="attrs" v-on="on" --%>
                              <v-switch v-model="item.status" @change="fnCambiarEstatus(item)"></v-switch>
                              <%-- </template>
                                --%> <%-- <span>d</span> --%> <%-- </v-tooltip>
                                    --%>
                      </template>
                      <template v-slot:item.estatus="{item}">
                        <v-container class="px-0" fluid>
                          <v-switch v-model="item.estatus" :label="item.estatus ? 'Revisado' : 'Cancelado'"
                            @change="fnCambiarEstatus(item)"></v-switch>
                        </v-container>
                      </template>
                      <template v-slot:item.password="{item}">
                        <v-tooltip bottom>
                          <template v-slot:activator="{on, attrs}">
                            <span v-bind="attrs" v-on="on"
                              @click="navigator.clipboard.writeText(item.password); mostrarSnackbar('success', 'Texto copiado al portapapeles.')"><b>{{
                                item.password }}</b></span>
                          </template>
                          <span>Copiar contraseña</span>
                        </v-tooltip>
                      </template>
                    </v-data-table>
                  </v-col>
                </v-row>
          </v-card>
        </v-container>
        <%-- <v-dialog v-model="dialogBuscador" width="70%" scrollable transition="dialog-bottom-transition">
          <v-card>
            <v-card-title class="text-h5 grey lighten-2">
              Búsqueda Avanzada
            </v-card-title>
            <v-card-text>
              <v-row justify="center">
                <v-col md="8">
                  <v-text-field outlined label="Nombre" v-model="nombreBuscar"
                    @keyup.enter="fnBusquedaNombre()"></v-text-field>
                </v-col>
              </v-row>
              <v-row justify="center">
                <v-col md="4" offset-md="8">
                  <v-text-field label="Filtrar" v-model="searchBusqueda"></v-text-field>
                </v-col>
              </v-row>
              <v-row justify="center">
                <v-col md="12">
                  <v-data-table :headers="headersBusqueda" :items="dataBusqueda" :search="searchBusqueda"
                    class="elevation-2" no-data-text="No se encontro ningun registro"
                    :hide-default-header="dataBusqueda.length < 1" :hide-default-footer="dataBusqueda.length < 1"
                    locale="es-ES" :mobile-breakpoint="NaN" items-per-page="10" @click:row="seleccionarrecursos">
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
          </v-container fluid>
          </v-dialog>
          --%>
          <!-- TODO: ALERTAS DE SISTEMA-->
          <v-snackbar v-model="snackbar" top="top" :bottom="true" :multi-line="true" :color="color_snackbar">
            {{ mensaje_snackbar }}
            <%-- <v-icon color="white" @click="snackbar = false">mdi-close-circle</v-icon>
              --%>
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
              "../../controlador/innovacion_educativa/Controlador_catalogo_solicitud_proyecto.jsp";
            //Variables POST
            const area = ref("");
            const recursos = ref("");
            const objetivo = ref("");
            const descripcion = ref("");
            const acuerdos = ref("");
            const fecha = ref("");
            const nombreProyecto = ref("");
            //Otras variables
            const flagEditar = ref(false);
            const itemEditar = ref({});
            //Combo
            const areas = ref([]);

            //SNACKBAR
            const loader = ref(false);
            const snackbar = ref(false);
            const mensaje_snackbar = ref("");
            const color_snackbar = ref("");
            //Loaders
            //Dialogs
            const dialogBuscador = ref(false);

            const dialogDetallesCotizacion = ref(false);
            const dialogProveedor = ref(false);

            //DataTable
            const dataSolicitudProyecto = ref([]);
            const headerProyectos = ref([
              { text: "No.", align: "left", sortable: true, value: "numero_fila" },
              { text: "Área", align: "left", sortable: true, value: "nombreArea" },
              { text: "Nombre de Proyecto", align: "left", sortable: true, value: "nombreProyecto" },
              { text: "Recursos", align: "left", sortable: true, value: "RecursosNecesarios" },
              { text: "Fecha", align: "left", sortable: true, value: "fechaRegistro" },
              { text: "Estatus", align: "left", sortable: true, value: "estatus" }
            ]);
            const searchProyectos = ref([]);

            onMounted(() => {
              fnConsultarTabla();
              fntipoArea();
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
                parametros.append("accion", 1);
                let { data, status } = await axios.post(ctr, parametros);
                if (status == 200) {
                  if (data.length > 0) {
                    dataSolicitudProyecto.value = data;
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
                    parametros.append("idArea", area.value);
                    parametros.append("nombreProyecto", nombreProyecto.value);
                    parametros.append("fecha", fecha.value);
                    parametros.append("objetivos", objetivo.value);
                    parametros.append("descripcion", descripcion.value);
                    parametros.append("recursos", recursos.value);
                    parametros.append("acuerdos", acuerdos.value);
                    let { data, status } = await axios.post(ctr, parametros);
                    if (status == 200) {
                      if (data == "1") {
                        mostrarSnackbar(
                          "success",
                          "Registro guardado correctamente."
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
              recursos.value = "";
              objetivo.value = "";
              descripcion.value = "";
              acuerdos.value = "";
              fecha.value = "";
              area.value = "";
              nombreProyecto.value = "";
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
              recursos,
              acuerdos,
              objetivo,
              descripcion,
              area,
              fecha,
              nombreProyecto,
              areas,
              dataSolicitudProyecto,
              headerProyectos,
              searchProyectos,
              dialogBuscador,
              dialogDetallesCotizacion,
              dialogProveedor,
              fnConsultarTabla,
              fnGuardar,
              fnLimpiarCampos,
              fnEditar,
              fnCambiarEstatus,
              itemEditar,
            };
          },
        });

        Vue.config.devtools = true;
      </script>

  </html>