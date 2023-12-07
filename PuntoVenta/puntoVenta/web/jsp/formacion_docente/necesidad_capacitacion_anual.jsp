<%@page contentType="text/html; charset=UTF-8" language="java" errorPage="" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900" rel="stylesheet">
        <link href="../../styles/icon_material_design_4495/css/materialdesignicons.min.css" rel="stylesheet">
        <link href="../../javascript/VueJs/sweetalert2/sweetalert2.css" />
        <link href="../../javascript/VueJs/vuetify/vuetify.min.css" rel="stylesheet">
        <link rel="shortcut icon" href="../../images/favicon.ico" type="image/x-icon">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
        <script src="../../javascript/VueJs/vue/vue.js"></script>
        <script type="" src="../../javascript/VueJs/vue/vue-composition-api.prod.js" ></script>
        <title>Necesidad de capacitaci&oacute;n anual</title>
    </head>
    <style>
        body {
          font-family: 'Roboto';
        }

        .circle-cell {
        display: flex;
        justify-content: center;
        align-items: center;
        }

        .circle-cell .circle {
        width: 16px;
        height: 16px;
        border-radius: 50%;
        }

        .circle-cell .circle.aceptado {
        background-color: green;
        }

        .circle-cell .circle.en_proceso {
        background-color: orange;
        }

        .circle-cell .circle.rechazado {
        background-color: red;
        }

        .validado {
        background-color: green;
        }

        .cancelado {
        background-color: red;
        }
    </style>
    <body>
        <div id="app">
            <v-app>
                <v-container fluid>
                    <v-card>
                        <v-card-title style="background-color: #00b293; color: #ffffff;" >
                            Necesidad de capacitaci&oacute;n anual
                        </v-card-title>
                        <v-container fluid>
                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                
                                <!--AÑO -->
                                <v-col md="3" class="text-right">
                                    <v-text-field 
                                        v-model="annio" 
                                        label="Año a ejercer"
                                        prepend-icon="mdi-calendar" 
                                        data-vv-name="año a ejercer"
                                        :error="errors.has('año a ejercer')"
                                        :error-messages="errors.first('año a ejercer')"
                                        required
                                        
                                        ></v-text-field>
                                </v-col>

                                <v-col>&nbsp;&nbsp;&nbsp;&nbsp;</v-col>

                                <v-col cols="12" sm="6" md="4" class="text-left">
                                    <v-menu ref="menu1" :close-on-content-click="false" :return-value.sync="fechaElavoracion"
                                        transition="scale-transition" offset-y min-width="auto">
                                        <template v-slot:activator="{ on, attrs }">
                                            <v-text-field v-model="fechaElavoracion" label="Fecha"
                                                prepend-icon="mdi-calendar" readonly></v-text-field>
                                        </template>
                                        <v-date-picker v-model="fechaElavoracion" no-title scrollable :readonly="true">
                                            <v-spacer></v-spacer>
                                            <v-btn text color="primary" @click="menu1 = false">
                                                Cancel
                                            </v-btn>
                                            <v-btn text color="primary" @click="$refs.menu1.save(fechaElavoracion)">
                                                OK
                                            </v-btn>
                                        </v-date-picker>
                                    </v-menu>
                                </v-col>
                            </v-row>

                            <v-row style="padding: 0px 50px 0px 50px">
                                <v-col md=10>
                                    <v-select
                                        v-model="direccion"
                                        outlined
                                        label="Direcci&oacute;n o subdirecci&oacute;n responsable"
                                        v-validate="'required'"
                                        :items="arrayDireccSub"
                                        item-value="cve_area"
                                        item-text="nombre_area"
                                        data-vv-name="dirección o subdirección"
                                        :error="errors.has('dirección o subdirección')"
                                        :error-messages="errors.first('dirección o subdirección')"
                                        required
                                ></v-select>
                                </v-col>

                                
                                
                            </v-row>

                                <v-row justfy="center" dense >
                                    <v-col class="text-center"><b>Informaci&oacute;n de la academia</b></v-col>
                                </v-row>
                                <v-divider> </v-divider>
                            


                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                
                                <v-col md=6>
                                    <v-select
                                        v-model="unidadAcademica"
                                        outlined
                                        label="Unidad acad&eacute;mica"
                                        v-validate="'required'"
                                        :items="arrayUnidadesAcademicas"
                                        item-value="cve_unidad_academica"
                                        item-text="nombre_unidad_academica"
                                        data-vv-name="unidad académica"
                                        :menu-props="{ maxHeight: '200' }" 
                                        :error="errors.has('unidad academica')"
                                        :error-messages="errors.first('unidad académica')"
                                        
                                    ></v-select>
                                </v-col>

                                <v-col md=6>
                                    <v-select
                                        v-model="nivelEducativo"
                                        outlined
                                        label="Nivel educativo"
                                        v-validate="'required'"
                                        :items="arrayNivelEducativo"
                                        item-value="idAcademia"
                                        item-text="nivelEducativo"
                                        data-vv-name="nivel educativo"
                                        :error="errors.has('nivel educativo')"
                                        :error-messages="errors.first('nivel educativo')"
                                        required
                                    ></v-select>
                                </v-col>

                               
                            </v-row>

                            <v-row  class="align-center" style="padding: 0px 50px 0px 50px">

                                <v-col md=6>
                                    <v-select
                                        v-model="programaEducativo"
                                        outlined
                                        label="Programa educativo"
                                        :items="arrayProgramas"
                                        item-value="cve_ugac"
                                        item-text="nombre_ugac"
                                        v-validate="'required|max:200'"
                                        data-vv-name="programa educativo"
                                        :error="errors.has('programa educativo')"
                                        :error-messages="errors.first('programa educativo')"
                                    ></v-select>
                                </v-col>

                                <v-col md=6>
                                    <v-select 
                                        v-model="nombreGestor"
                                        outlined
                                        v-validate="'required'"
                                        :items="arrayEmpleados"
                                        item-value="cve_empleado"
                                        item-text="nombre"
                                        label="Nombre del gestor responsable"
                                        data-vv-name="nombre del gestor responsable"
                                        :error="errors.has('nombre del gestor responsable')"
                                        :error-messages="errors.first('nombre del gestor responsable')"
                                    ></v-select>
                                </v-col>
                            </v-row>

                            <v-row justfy="center" dense >
                                <v-col class="text-center"><b>Informaci&oacute;n del evento</b></v-col>
                            </v-row>
                            <v-divider></v-divider>

                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                <v-col md=4>
                                    <v-text-field 
                                        v-model="necesidadesDetectadas"
                                        outlined
                                        label="Necesidades detectadas mediante ..."
                                        persistent-hint
                                        v-validate="'required|max:200'"
                                        data-vv-name="necesidades detectadas mediante"
                                        :error="errors.has('necesidades detectadas mediante')"
                                        :error-messages="errors.first('necesidades detectadas mediante')"
                                        
                                    ></v-text-field>
                                </v-col>

                                <v-col md=4>
                                    <v-text-field 
                                        v-model="nombreEventoCapacitacion"
                                        outlined
                                        label="Nombre del evento"
                                        persistent-hint
                                        v-validate="'required|max:50'"
                                        data-vv-name="nombre del evento"
                                        :error="errors.has('nombre del evento')"
                                        :error-messages="errors.first('nombre del evento')"
                                    ></v-text-field>
                                </v-col>

                                <v-col md=4>
                                    <v-textarea 
                                        v-model="objetivoEvento"
                                        outlined
                                        label="Objetivo del evento"
                                        persistent-hint
                                        v-validate="'required|max:200'"
                                        auto-grow outlined
                                        rows="1" row-height="15"
                                        data-vv-name="objetivo del evento"
                                        :error="errors.has('objetivo del evento')"
                                        :error-messages="errors.first('objetivo del evento')"
                                    ></v-textarea>
                                </v-col>
                            </v-row>

                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                <v-col md=4>
                                    <v-select 
                                        v-model="orientacionEvento"
                                        outlined
                                        v-validate="'required'"
                                        :items="arrayOrientacion"
                                        item-value="cve_tipo_orientacion"
                                        item-text="nombre_tipo_orientacion"
                                        label="Orientaci&oacute;n del evento"
                                        data-vv-name="orientación del evento"
                                        :error="errors.has('orientación del evento')"
                                        :error-messages="errors.first('orientación del evento')"
                                    ></v-select>
                                </v-col>

                                <v-col md=4>
                                    <v-textarea 
                                        v-model="justificacionEvento"
                                        outlined
                                        v-validate="'required|max:200'"
                                        label="Justificaci&oacute;n del evento"
                                        persistent-hint
                                        auto-grow outlined
                                        rows="1" row-height="15"
                                        data-vv-name="justificación del evento"
                                        :error="errors.has('justificación del evento')"
                                        :error-messages="errors.first('justificación del evento')"
                                    ></v-textarea>
                                </v-col>

                                <v-col md=4>
                                    <v-select 
                                        v-model="tipoEvento"
                                        outlined
                                        v-validate="'required'"
                                        :items="arrayTipoEvento"
                                        item-value="cve_tipo_evento"
                                        item-text="nombre_tipo_evento"
                                        label="Tipo de evento"
                                        persistent-hint
                                        data-vv-name="tipo del evento"
                                        :error="errors.has('tipo del evento')"
                                        :error-messages="errors.first('tipo del evento')"
                                    ></v-select>
                                </v-col>
                            </v-row>

                            <v-row class="align-center" style="padding: 0px 50px 0px 50px">
                                <v-col md=6>
                                    <v-text-field 
                                    v-if="tipoEvento === 7 "
                                        v-model="otroEvento"
                                        outlined
                                        label="Especifique el tipo de evento"
                                        persistent-hint
                                        v-validate="'required|max:200'"
                                    ></v-text-field>
                                </v-col>
                            </v-row>

                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                <v-col md=6>
                                    <v-select 
                                        v-model="tipoPrograma"
                                        outlined
                                        v-validate="'required'"
                                        :items="arrayTipoPrograma"
                                        item-value="cve_tipo_capacitacion"
                                        item-text="nombre_tipo_capacitacion"
                                        label="Tipo de Programa"    
                                        persistent-hint
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
                                        v-validate="'required|max:200'"
                                    ></v-text-field>
                                </v-col>

                                <v-col md=6>
                                    <v-text-field 
                                        v-model="costoCapacitacionSugerido"
                                        outlined
                                        prefix="$"
                                        label="Costo Capacitaci&oacute;n (Sugerido)"    
                                        persistent-hint
                                        v-validate="'required|max:200'"
                                        :rules="[validacion]"
                                                                             
                                    ></v-text-field>
                                </v-col>

                                    <v-col md=6>
                                        <v-select  
                                            v-model="origenRecursoEvento"
                                            outlined
                                            v-validate="'required'"
                                            :items="arrayOrigen"
                                            item-value="cve_tipo_origen"
                                            item-text="nombre_tipo_origen"
                                            label="Origen del recurso para el evento"    
                                            persistent-hint
                                            data-vv-name="origen del recurso"
                                            :error="errors.has('origen del recurso')"
                                            :error-messages="errors.first('origen del recurso')"
                                        ></v-select>
                                    </v-col>
                            </v-row>

                            <v-row justfy="center" dense >
                                <v-col class="text-center"><b>Per&iacute;odo para participar al evento</b></v-col>
                            </v-row>

                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">

                                <v-col md=4>
                                    <v-select  
                                        v-model="mes"
                                        outlined
                                        v-validate="'required'"
                                        :items="arrayMes"
                                        label="Seleccionar mes"    
                                        persistent-hint
                                        data-vv-name="mes"
                                        :error="errors.has('mes')"
                                        :error-messages="errors.first('mes')"
                                       
                                    ></v-select>
                                </v-col>

                                <v-col cols="12" sm="6" md="4">
                                    <v-menu 
                                            ref="menu1"  
                                            :close-on-content-click="false"
                                            :return-value.sync="fechaInicio" 
                                            transition="scale-transition" 
                                            offset-y min-width="auto">
                                        <template v-slot:activator="{ on, attrs }">
                                            <v-text-field 
                                                v-model="fechaInicio" 
                                                label="Fecha de inicio" 
                                                prepend-icon="mdi-calendar"
                                                readonly v-bind="attrs" 
                                                v-on="on"
                                                data-vv-name="fecha de inicio"
                                                :error="errors.has('fecha de inicio')"
                                                :error-messages="errors.first('fecha de inicio')" 
                                            ></v-text-field>
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

                                <v-col cols="12" sm="6" md="4">
                                    <v-menu 
                                            ref="menu"  
                                            :close-on-content-click="false"
                                            :return-value.sync="fechaTermino" 
                                            transition="scale-transition" 
                                            offset-y min-width="auto">
                                        <template v-slot:activator="{ on, attrs }">
                                            <v-text-field 
                                                v-model="fechaTermino" 
                                                label="Fecha de termino" 
                                                prepend-icon="mdi-calendar"
                                                readonly v-bind="attrs" 
                                                v-on="on"
                                                data-vv-name="fecha de termino"
                                                :error="errors.has('fecha de termino')"
                                                :error-messages="errors.first('fecha de termino')"
                                            ></v-text-field>
                                        </template>
                                        <v-date-picker v-model="fechaTermino" no-title scrollable>
                                            <v-spacer></v-spacer>
                                            <v-btn text color="primary" @click="menu = false">
                                                Cancel
                                            </v-btn>
                                            <v-btn text color="primary" @click="$refs.menu.save(fechaTermino); validarFechas();">
                                                OK
                                            </v-btn>
                                        </v-date-picker>
                                    </v-menu>
                                </v-col>
                            </v-row>


                            <v-row class="align-center" style="padding: 0px 50px 0px 50px">
                                <v-col md=3>
                                    <v-text-field 
                                        v-model="numDias"
                                        outlined
                                        label="N&uacute;mero de d&iacute;as"    
                                        persistent-hint
                                        v-validate="'required|max:200'"
                                        data-vv-name="número de días"
                                        :error="errors.has('número de días')"
                                        :error-messages="errors.first('número de días')"
                                        :rules="[validacion]"
                                    ></v-text-field>
                                </v-col>

                                <v-col md=4>
                                    <v-text-field 
                                        v-model="numHorasEfectivas"
                                        outlined
                                        label="N&uacute;mero de horas efectivas"    
                                        persistent-hint
                                        v-validate="'required|max:200'"
                                        data-vv-name="número de horas efectivas"
                                        :error="errors.has('número de horas efectivas')"
                                        :error-messages="errors.first('número de horas efectivas')"
                                        :rules="[validacion]"
                                        
                                    ></v-text-field>
                                </v-col>

                            </v-row>

                            <v-row justfy="center" dense >
                                <v-col class="text-center"><b>Participantes</b></v-col>
                            </v-row>
                            <v-divider></v-divider>

                            <v-row class="align-center" style="padding: 0px 50px 0px 50px">
                            
                                <v-col md=3 > 
                                    <v-text-field 
                                        v-model="ptc"
                                        outlined
                                        label="Cantidad de PTC"    
                                        persistent-hint
                                        data-vv-name="PTC"
                                        :error="errors.has('PTC')"
                                        :error-messages="errors.first('PTC')"
                                        :rules="[validacion]"
                                    ></v-text-field>
                                </v-col>

                                <v-col md=3 > 
                                    <v-text-field 
                                        v-model="laboratoristas"
                                        outlined
                                        label="Cantidad de técnicos académicos"    
                                        persistent-hint
                                        data-vv-name="técnicos académicos"
                                        :error="errors.has('técnicos académicos')"
                                        :error-messages="errors.first('técnicos académicos')"
                                        :rules="[validacion]"
                                    ></v-text-field>
                                </v-col>

                                <v-col md=3 > 
                                    <v-text-field 
                                        v-model="administrativo"
                                        outlined
                                        label="Cantidad de administrativo del &aacute;rea acad&eacute;mica"    
                                        persistent-hint
                                        data-vv-name="administrativo"
                                        :error="errors.has('administrativo')"
                                        :error-messages="errors.first('administrativo')"
                                        :rules="[validacion]"
                                        
                                    ></v-text-field>
                                </v-col>
                                <v-col md=3> 
                                    <v-text-field 
                                        v-model="otros"
                                        outlined
                                        label="Cantidad de otros participantes"    
                                        persistent-hint
                                        data-vv-name="otros"
                                        :error="errors.has('otros')"
                                        :error-messages="errors.first('otros')"
                                        :rules="[validacion]"
                                    ></v-text-field>
                                </v-col>

                                
                                <v-col md=3> 
                                    <v-text-field 
                                        disabled
                                        v-model="total"
                                        outlined
                                        label="Total"    
                                        persistent-hint
                                        data-vv-name="total"
                                        :error="errors.has('total')"
                                        :error-messages="errors.first('total')"
                                    ></v-text-field>
                                </v-col>

                                <v-col md=3> 
                                    <v-text-field 
                                        v-model="totalH"
                                        outlined
                                        label="Total Hombres"    
                                        persistent-hint
                                        data-vv-name="total de hombres"
                                        :error="errors.has('total de hombres')"
                                        :error-messages="errors.first('total de hombres')"
                                        :rules="[validacion]"
                                    ></v-text-field>
                                </v-col>

                                <v-col md=3> 
                                    <v-text-field 
                                        v-model="totalM"
                                        outlined
                                        label="Total Mujeres"    
                                        persistent-hint
                                        data-vv-name="total de mujeres"
                                        :error="errors.has('total de mujeres')"
                                        :error-messages="errors.first('total de mujeres')"
                                        @blur="comprobarTotal"
                                        :rules="[validacion]"
                                        
                                    ></v-text-field>
                                </v-col>
                            </v-row>

                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                <v-col md=12> 
                                    <v-text-field 
                                        v-model="lugar"
                                        outlined
                                        label="Lugar"    
                                        persistent-hint
                                        data-vv-name="lugar"
                                        :error="errors.has('lugar')"
                                        :error-messages="errors.first('lugar')"
                                        hint="(Si es fuera de la ciudad especificar)"
                                    ></v-text-field>
                                </v-col>
                            </v-row>

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

                                <!--BARRA DE BUSQUEDA-->
                                <v-row justify="end">
                                    <v-col md = "5">
                                        <template>
                                            <br>
                                            <div>
                                               <v-text-field v-model="buscar" label="Buscar" :append-icon="iconoBusqueda" clearable @keyup.enter="filtrarTabla"></v-text-field>                                               
                                            </div>
                                          </template>
                                    </v-col>
                                    <v-col md = "1">
                                        <v-tooltip bottom open-on-hover>
                                            <template v-slot:activator="{ on, attrs }">
                                                <span class="tooltip-trigger" v-bind="attrs" v-on="on">
                                                    <v-icon> mdi-information </v-icon>
                                                </span>
                                            </template>
                                            <span>La busqueda se realiza por unidad academica, nombre evento, tipo evento y direccion </span>
                                        </v-tooltip>
                                    </v-col>
                                </v-row>

                                <v-row justify="center">
                                    <v-col md=12>
                                        <v-data-table
                                            :headers="headersEventos"
                                            :items="datosFiltrados"
                                            :search="searchEventos"
                                            class="elevation-2"
                                            no-data-text="No se encontro ningun registro"
                                            :hide-default-header="datosFiltrados.length < 1"
                                            :hide-default-footer="datosFiltrados.length < 1"
                                            locale="es-ES"
                                            :mobile-breakpoint="NaN"
                                            items-per-page="10"
                                        >   

                                        <template v-slot:item.estatus="{item}">
                                            <v-select
                                            v-model="item.estatus"
                                            :items="arrayEstatus"
                                            item-text="text"
                                            item-value="icon"
                                          >
                                            <template v-slot:item="{ item }">
                                              <v-list-item-content>
                                                <v-icon :color="item.color">{{ item.icon }}</v-icon>
                                              </v-list-item-content>
                                            </template>
                                          </v-select>
                                        </template>
                                            
                                        </v-data-table>
                                    </v-col>
                                </v-row>    
                        </v-container>
                       <v-divider></v-divider>
                       
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
                        src="../../images/Logo_utl_animado.gif"
                    > 
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
        import {preloader, guardar, errorGuardar, actualizar, errorActualizar, eliminar, errorEliminar, cerrar, confirmarE, aviso, confirmar} from '../../javascript/mensajeSistema/mensajes_sweetalert_vue.js';
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
                const ctr = "../../controlador/formacion_docente/controlador_necesidad_capacitacion_anual.jsp";
                
                //Variables POST
                const idEvento = ref("");
                const annio = ref("");
                const direccion = ref("");
                const fechaElavoracion=ref("");
                const unidadAcademica = ref("");
                const nivelEducativo = ref("");
                
                const programaEducativo = ref("");
                const nombreGestor = ref("");
                const necesidadesDetectadas = ref("");
                const nombreEventoCapacitacion= ref("");
                const objetivoEvento=ref("");
                const orientacionEvento=ref("");
                const justificacionEvento=ref("");
                const tipoEvento=ref("");
                const otroEvento = ref("");
                const tipoPrograma=ref("");
                const proveedorSugerido=ref("");
                const ptc=ref(0);
                const laboratoristas=ref(0);
                const administrativo=ref(0);
                const otros=ref(0);
                const total=ref(0);
                const totalH=ref("");
                const totalM=ref("");
                const lugar=ref("");
                const costoCapacitacionSugerido=ref("");
                const transporte=ref("");
                const casetas=ref("");
                const alimentacion=ref("");
                const hospedaje=ref("");
                const taxis =ref("");
                const otrosGastos=ref("");
                const oficial = ref("");
                const particular = ref("");
                const otrosO = ref("");
                const origen = ref("");
                const origenRecursoEvento=ref("");
                const mes=ref("");
                const fechaInicio=ref("");
                const fechaTermino = ref("");
                const numDias=ref("");
                const numHorasEfectivas=ref("");
                const estatus=ref("");
                const buscar=ref("");

                

                const arrayUnidadesAcademicas = ref([]);
                const arrayNivelEducativo = ref(["T.S.U","Ingenieria"]);
                const arrayOrientacion = ref([]);
                const arrayJustificacion = ref([]);
                const arrayTipoEvento = ref([]);
                const arrayTipoPrograma = ref([]);
                const arrayOrigen = ref([]);
                const arrayMes =ref(['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'])
                const  arrayEstatus = ref([
                    { icon: 'mdi-check', text: 'Aceptado' , color: 'green'},
                    { icon: 'mdi-close', text: 'Cancelado', color: 'red' },
                    { icon: 'mdi-pencil', text: 'Editar', color: 'yellow' },
                ]);
                const arrayDireccSub =ref([]);
                const arrayProgramas =ref([]);
                const arrayEmpleados =ref([]);


                  //SNACKBAR
                const loader = ref(false);
                const snackbar = ref(false);
                const mensaje_snackbar = ref('');
                const color_snackbar = ref('')

                //Otras funciones
                const flagEditar = ref(false);
                const itemEditar = ref({});
                
                
                //DataTable
                const dataEventos = ref([]);
                const searchEventos = ref([]);
                const headersEventos = ref([
                    {text: 'Unidad Academica', align: 'left', sortable: true, value: 'nombre_unidad_academica', width: '200px'},
                    {text: 'Nombre del evento', align: 'left', sortable: true, value: 'nombre_evento'},
                    {text: 'Tipo de evento', align: 'left', sortable: true, value: 'nombre_tipo_evento'},
                    {text: 'Dirección', align: 'left', sortable: true, value: 'nombre_area'},
                    {text: 'Fecha inicio', align: 'left', sortable: true, value: 'fecha_inicio'},
                    { text: "Estatus", align: "left", sortable: false, value: "estatus", width: '200px' }
                ]);

                const currentUser = localStorage.getItem('currentUser');
                const user = JSON.parse(currentUser);
                const nombre = user[0].nombre;
                const idPersona = user[0].cve_persona;


                //Accion automatizada para mostrar la tabla
                onMounted(() => {
                    fnTipoEvento();
                    fnConsultarTabla();
                    fnUnidadAcademica();
                    fnDirecciones();
                    fnProgramas();
                    fnOrientacion();
                    fnOrigen();
                    fnEmpleados();
                    fnFecha();
                    fnTipoPrograma();
                    
                });

                function fnFecha() {
                    const calculo_fecha = new Date();
                    const options = { year: 'numeric', month: '2-digit', day: '2-digit' };
                    fechaElavoracion.value = new Date().toISOString().substr(0, 10);                    
                }
                
                async function fnTipoPrograma(){
                    try{
                        preloader("../../");
                        let parametros = new URLSearchParams();
                        parametros.append("accion", 10);
                        let {data,status} = await axios.post(ctr, parametros)
                        if(status == 200){
                            if(data.length > 0){
                                arrayTipoPrograma.value = data
                            }
                        }
                    } catch(error){
                        mostrarSnackbar('error');
                        console.error(error);
                    } finally{
                        swal.close();
                    }
                }

                async function fnOrientacion(){
                    try{
                        preloader("../../");
                        let parametros = new URLSearchParams();
                        parametros.append("accion", 7);
                        let {data,status} = await axios.post(ctr, parametros)
                        if(status == 200){
                            if(data.length > 0){
                                arrayOrientacion.value = data
                            }
                        }
                    } catch(error){
                        mostrarSnackbar('error');
                        console.error(error);
                    } finally{
                        swal.close();
                    }
                }

                async function fnConsultarTabla(){
                    try{
                        preloader("../../");
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

                async function fnUnidadAcademica(){
                    try{
                        preloader("../../");
                        let parametros = new URLSearchParams();
                        parametros.append("accion", 2);
                        let {data,status} = await axios.post(ctr, parametros)
                        if(status == 200){
                            if(data.length > 0){
                                arrayUnidadesAcademicas.value = data
                            }
                        }
                    } catch(error){
                        mostrarSnackbar('error');
                        console.error(error);
                    } finally{
                        swal.close();
                    }
                }

                async function fnOrigen(){
                    try{
                        preloader("../../");
                        let parametros = new URLSearchParams();
                        parametros.append("accion", 8);
                        let {data,status} = await axios.post(ctr, parametros)
                        if(status == 200){
                            if(data.length > 0){
                                arrayOrigen.value = data
                            }
                        }
                    } catch(error){
                        mostrarSnackbar('error');
                        console.error(error);
                    } finally{
                        swal.close();
                    }
                }

                async function fnProgramas(){
                    try{
                        preloader("../../");
                        let parametros = new URLSearchParams();
                        parametros.append("accion", 6);
                        let {data,status} = await axios.post(ctr, parametros)
                        if(status == 200){
                            if(data.length > 0){
                                arrayProgramas.value = data
                            }
                        }
                    } catch(error){
                        mostrarSnackbar('error');
                        console.error(error);
                    } finally{
                        swal.close();
                    }
                }
  
                async function fnDirecciones(){
                    try{
                        preloader("../../");
                        let parametros = new URLSearchParams();
                        parametros.append("accion", 5);
                        let {data,status} = await axios.post(ctr, parametros)
                        if(status == 200){
                            if(data.length > 0){
                                arrayDireccSub.value = data
                            }
                        }
                    } catch(error){
                        mostrarSnackbar('error');
                        console.error(error);
                    } finally{
                        swal.close();
                    }
                }

                async function fnEmpleados(){
                    try{
                        preloader("../../");
                        let parametros = new URLSearchParams();
                        parametros.append("accion", 9);
                        let {data,status} = await axios.post(ctr, parametros)
                        if(status == 200){
                            if(data.length > 0){
                                arrayEmpleados.value = data
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
                        preloader("../../");
                        let parametros = new URLSearchParams();
                        parametros.append("accion", 3);
                        let {data,status} = await axios.post(ctr, parametros)
                        if(status == 200){
                            if(data.length > 0){
                                arrayTipoEvento.value = data
                            }
                        }
                    } catch(error){
                        mostrarSnackbar('error');
                        console.error(error);
                    } finally{
                        swal.close();
                    }
                }

                async function fnGuardar() {
                        this.$validator.validate().then(async (esValido) => {
                            if (esValido) {
                                try {
                                    preloader("../../");
                                    let parametros = new URLSearchParams();
                                    parametros.append("accion", 4);
                                    parametros.append("direccion", direccion.value);
                                    parametros.append("unidadAcademica", unidadAcademica.value);
                                    parametros.append("nombreGestor", nombreGestor.value);
                                    parametros.append("orientacionEvento", orientacionEvento.value);
                                    parametros.append("tipoEvento", tipoEvento.value);
                                    parametros.append("tipoPrograma", tipoPrograma.value);
                                    parametros.append("nivelEducativo", nivelEducativo.value);
                                    parametros.append("programaEducativo", programaEducativo.value);
                                    parametros.append("annio", annio.value);
                                    parametros.append("necesidadesDetectadas", necesidadesDetectadas.value);
                                    parametros.append("nombreEventoCapacitacion", nombreEventoCapacitacion.value);
                                    parametros.append("objetivoEvento", objetivoEvento.value);
                                    parametros.append("justificacionEvento", justificacionEvento.value);
                                    parametros.append("otroEvento", otroEvento.value);
                                    parametros.append("proveedorSugerido", proveedorSugerido.value);
                                    parametros.append("costoCapacitacionSugerido", costoCapacitacionSugerido.value);
                                    parametros.append("mes", mes.value);                                    
                                    parametros.append("fechaInicio", fechaInicio.value);
                                    parametros.append("fechaTermino", fechaTermino.value);
                                    parametros.append("numDias", numDias.value);
                                    parametros.append("numHorasEfectivas", numHorasEfectivas.value);
                                    parametros.append("ptc", ptc.value);
                                    parametros.append("laboratoristas", laboratoristas.value);
                                    parametros.append("administrativo", administrativo.value);
                                    parametros.append("otros", otros.value);
                                    parametros.append("total", total.value);
                                    parametros.append("totalH", totalH.value);
                                    parametros.append("totalM", totalM.value);
                                    parametros.append("id", idPersona);
                                    let { data, status } = await axios.post(ctr, parametros);
                                    if (status == 200) {
                                        if (data == "1") {
                                            mostrarSnackbar(
                                                "success",
                                                "Registro guardado correctamente."
                                            );
                                            fnConsultarTabla();
                                            fnLimpiarCampos(this);
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

                function fnLimpiarCampos(cx){//cx = contexto
                    direccion.value = ' ';
                    unidadAcademica.value = ' ';
                    nombreGestor.value = ' ' ;
                    orientacionEvento.value = ' ' ;
                    origenRecursoEvento.value = ' ';
                    tipoEvento.value = ' ' ;
                    tipoPrograma.value = ' ' ;
                    nivelEducativo.value = ' ' ;
                    programaEducativo.value = ' ' ;
                    annio.value = ' ' ;
                    necesidadesDetectadas.value = ' ' ;
                    nombreEventoCapacitacion.value = ' ' ;
                    objetivoEvento.value = ' ' ;
                    justificacionEvento.value = ' ' ;
                    otroEvento.value = ' ' ;
                    proveedorSugerido.value = ' ' ;
                    costoCapacitacionSugerido.value = ' ' ;
                    mes.value = ' ' ;                                    
                    fechaInicio.value = ' ' ;
                    fechaTermino.value = ' ' ;
                    numDias.value = ' ' ;
                    numHorasEfectivas.value = ' ' ;
                    ptc.value = ' ' ;
                    laboratoristas.value = ' ' ;
                    administrativo.value = ' ' ;
                    otros.value = ' ' ;
                    total.value = ' ' ;
                    totalH.value = ' ' ;
                    totalM.value = ' ' ;
                    lugar.value = ' ';

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
                    annio, direccion, fechaElavoracion, unidadAcademica, nivelEducativo, programaEducativo,
                    nombreGestor, necesidadesDetectadas, nombreEventoCapacitacion, objetivoEvento, orientacionEvento,
                    justificacionEvento,tipoEvento, otroEvento, tipoPrograma, proveedorSugerido, costoCapacitacionSugerido, 
                    origenRecursoEvento, mes, fechaInicio, fechaTermino, numDias, numHorasEfectivas, ptc, laboratoristas, administrativo,
                    otros, total, totalH, totalM, lugar, transporte, casetas, alimentacion, hospedaje, taxis, otrosGastos, oficial,
                    particular, otrosO, origen, idEvento, buscar: "", iconoBusqueda: 'mdi-magnify', estado: 'Validado', estatus,
                    
                    
                    arrayOrientacion, arrayJustificacion, arrayTipoEvento, arrayTipoPrograma, arrayOrigen, arrayMes, arrayEstatus, arrayUnidadesAcademicas,
                    arrayNivelEducativo, arrayDireccSub, arrayProgramas, arrayEmpleados,

                    flagEditar, itemEditar,
                    dataEventos,headersEventos, searchEventos, color_snackbar, snackbar, mensaje_snackbar,loader
                    ,fnLimpiarCampos,fnGuardar, fnOrientacion, fnOrigen, fnEmpleados, fnFecha, fnTipoPrograma
                    
                    
                }
            },
            computed: {
                datosFiltrados() {
                    if (!this.buscar) {
                        return this.dataEventos;
                    }

                    const keyword = this.buscar.toLowerCase();
                    return this.dataEventos.filter(item => {
                        const tipoEvento = item.nombre_tipo_evento.toLowerCase();
                        const direccion = item.nombre_area.toLowerCase();
                        const nombreEvento = item.nombre_evento.toLowerCase();
                        const fecha = item.fecha_registro.toLowerCase();
                        const unidadAcademica = item.nombre_unidad_academica.toLowerCase();

                        return (
                        tipoEvento.includes(keyword) ||
                        direccion.includes(keyword) ||
                        nombreEvento.includes(keyword) ||
                        fecha.includes(keyword) ||
                        unidadAcademica.includes(keyword)
                        );
                    });
                    },

                    validacion() {
                    return (value) => {
                        
                        if (!value || /^\d*$/.test(value.trim())) {
                        // Si el campo está vacío o solo contiene números, es válido
                        return true;
                        }
                        return 'Ingrese solo números en este campo.';
                    };
                    },
            },
            watch: {
                ptc: function(newVal, oldVal) {
                    this.calcularTotal();
                },
                laboratoristas: function(newVal, oldVal) {
                    this.calcularTotal();
                },
                administrativo: function(newVal, oldVal) {
                    this.calcularTotal();
                },
                otros: function(newVal, oldVal) {
                    this.calcularTotal();
                },
            },
            methods: {
                calcularTotal() {
                    this.total = parseFloat(this.ptc) + parseFloat(this.laboratoristas) + parseFloat(this.administrativo) 
                    + parseFloat(this.otros) ;
                },
                comprobarTotal(){
                    if (this.totalM !== null && this.totalH !== null && this.total !== null) {
                        const sum = parseInt(this.totalM) + parseInt(this.totalH);
                        if (sum !== parseInt(this.total)) {
                            Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'La suma del total de mujeres y total hombres no coincide con el total',
                            }).then(() => {
                            this.totalM = null;
                            this.totalH = null;
                            });
                        }
                    }
                },
                filtrarTabla() {
                        console.log("jijojio:", this.buscar);
                },
                validarFechas() {
                    if (this.fechaInicio && this.fechaTermino) {
                        if (this.fechaTermino < this.fechaInicio) {
                        
                        console.log("La fecha de término debe ser posterior a la fecha de inicio");
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'La fecha de término debe ser posterior a la fecha de inicio',
                            }).then(() => {
                            this.fechaInicio = null;
                            this.fechaTermino = null;
                            });
                        } else {
                        // Las fechas son válidas
                        console.log("Las fechas son válidas");
                        }
                    }
                },
                isIcon(item) {
                return item.startsWith('mdi-');
                },
                
            },   
        });

    </script>


    </html>