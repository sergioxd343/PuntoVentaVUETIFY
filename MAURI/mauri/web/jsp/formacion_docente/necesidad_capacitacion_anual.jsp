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
                                <v-col md=3>
                                    <v-text-field 
                                        v-model="annio"
                                        outlined
                                        label="A&ntilde;o a ejercer"    
                                        persistent-hint
                                        v-validate="'required|max:200'"
                                        data-vv-name="año a ejercer"
                                        :error="errors.has('año a ejercer')"
                                        :error-messages="errors.first('año a ejercer')"
                                        type="number"
                                    ></v-text-field>
                                </v-col>

                                <v-col md=6>
                                    <v-select
                                        v-model="direccion"
                                        outlined
                                        label="Direcci&oacute;n o subdirecci&oacute;n responsable"
                                        v-validate="'required'"
                                        :items="arrayDireccSub"
                                        item-value="idAcademia"
                                        item-text="unidadAcademica"
                                        data-vv-name="dirección o subdirección"
                                        :error="errors.has('dirección o subdirección')"
                                        :error-messages="errors.first('dirección o subdirección')"
                                        required
                                    ></v-select>
                                </v-col>

                                <v-col cols="12" sm="6" md="3">
                                    <v-menu 
                                            ref="menu0"  
                                            :close-on-content-click="false"
                                            :return-value.sync="fechaElavoracion" 
                                            transition="scale-transition" 
                                            offset-y min-width="auto">
                                        <template v-slot:activator="{ on, attrs }">
                                            <v-text-field 
                                                v-model="fechaElavoracion" 
                                                label="Fecha de elaboraci&oacute;n" 
                                                prepend-icon="mdi-calendar"
                                                readonly v-bind="attrs" 
                                                v-on="on"
                                            ></v-text-field>
                                        </template>
                                        <v-date-picker v-model="fechaElavoracion" no-title scrollable>
                                            <v-spacer></v-spacer>
                                            <v-btn text color="primary" @click="menu0 = false">
                                                Cancel
                                            </v-btn>
                                            <v-btn text color="primary" @click="$refs.menu0.save(fechaElavoracion)">
                                                OK
                                            </v-btn>
                                        </v-date-picker>
                                    </v-menu>
                                </v-col>

                            </v-row>

                                <v-row justfy="center" dense >
                                    <v-col class="text-center"><b>Informacion de la academia</b></v-col>
                                </v-row>
                                <v-divider> </v-divider>
                            


                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                
                                <v-col md=4>
                                    <v-select
                                        v-model="unidadAcademica"
                                        outlined
                                        label="Unidad acad&eacute;mica"
                                        v-validate="'required'"
                                        :items="arrayUnidadesAcademicas"
                                        item-value="cve_unidad_academica"
                                        item-text="nombre_unidad_academica"
                                        data-vv-name="unidad acad&eacute;mica"
                                        :error="errors.has('unidad acad&eacute;mica')"
                                        :error-messages="errors.first('unidad acad&eacute;mica')"
                                        required
                                    ></v-select>
                                </v-col>

                                <v-col md=4>
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

                                <v-col md=4>
                                    <v-select
                                        v-model="direccionArea"
                                        outlined
                                        label="Direcci&oacute;n del &aacute;rea"
                                        v-validate="'required'"
                                        :items="arrayAreas"
                                        item-value="idAcademia"
                                        item-text="direccionArea"
                                        data-vv-name="direcci&oacute;n de &aacute;rea"
                                        :error="errors.has('direcci&oacute;n de &aacute;rea')"
                                        :error-messages="errors.first('direcci&oacute;n &aacute;rea')"
                                        required
                                    ></v-select>
                                </v-col>
                            
                            </v-row>

                            <v-row  class="align-center" style="padding: 0px 50px 0px 50px">

                                <v-col md=4>
                                    <v-text-field 
                                        v-model="programaEducativo"
                                        outlined
                                        label="Programa educativo"
                                        persistent-hint
                                        v-validate="'required|max:200'"
                                        data-vv-name="programa educativo"
                                        :error="errors.has('programa educativo')"
                                        :error-messages="errors.first('programa educativo')"
                                    ></v-text-field>
                                </v-col>

                                <v-col md=4>
                                    <v-text-field 
                                        v-model="nombreGestor"
                                        outlined
                                        label="Nombre del gestor responsable"
                                        persistent-hint
                                        v-validate="'required|max:200'"
                                        data-vv-name="nombre del gestor responsable"
                                        :error="errors.has('nombre del gestor responsable')"
                                        :error-messages="errors.first('nombre del gestor responsable')"
                                    ></v-text-field>
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
                                        label="Necesidades detectadas mediante"
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
                                        label="Nombre del Evento"
                                        persistent-hint
                                        v-validate="'required|max:200'"
                                        data-vv-name="nombre del evento"
                                        :error="errors.has('nombre del evento')"
                                        :error-messages="errors.first('nombre del evento')"
                                    ></v-text-field>
                                </v-col>

                                <v-col md=4>
                                    <v-text-field 
                                        v-model="objetivoEvento"
                                        outlined
                                        label="Objetivo del evento"
                                        persistent-hint
                                        v-validate="'required|max:200'"
                                        data-vv-name="objetivo del evento"
                                        :error="errors.has('objetivo del evento')"
                                        :error-messages="errors.first('objetivo del evento')"
                                    ></v-text-field>
                                </v-col>
                            </v-row>

                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                                <v-col md=4>
                                    <v-select 
                                        v-model="orientacionEvento"
                                        outlined
                                        v-validate="'required'"
                                        :items="arrayOrientacion"
                                        label="Orientaci&oacute;n del Evento"
                                        data-vv-name="orientacion del evento"
                                        :error="errors.has('orientacion del evento')"
                                        :error-messages="errors.first('orientacion del evento')"
                                    ></v-select>
                                </v-col>

                                <v-col md=4>
                                    <v-select 
                                        v-model="justificacionEvento"
                                        outlined
                                        v-validate="'required'"
                                        :items="arrayJustificacion"
                                        label="Justificaci&oacute;n del Evento"
                                        persistent-hint
                                        data-vv-name="justificacion del evento"
                                        :error="errors.has('justificacion del evento')"
                                        :error-messages="errors.first('justificacion del evento')"
                                    ></v-select>
                                </v-col>

                                <v-col md=4>
                                    <v-select 
                                        v-model="tipoEvento"
                                        outlined
                                        v-validate="'required'"
                                        :items="arrayTipoEvento"
                                        item-value="cve_tipo_evento"
                                        item-text="nombre_tipo_evento"
                                        label="Tipo de Evento"
                                        persistent-hint
                                        data-vv-name="tipo evento"
                                        :error="errors.has('tipo evento')"
                                        :error-messages="errors.first('tipo evento')"
                                    ></v-select>
                                </v-col>
                            </v-row>

                            <v-row class="align-center" style="padding: 0px 50px 0px 50px">
                                <v-col md=6>
                                    <v-text-field 
                                    v-if="tipoEvento === 'Otro'"
                                        v-model="otroEvento"
                                        outlined
                                        label="Especifique el tipo de evento"
                                        persistent-hint
                                        v-validate="'required|max:200'"
                                        data-vv-name="otro evento"
                                        :error="errors.has('otro evento')"
                                        :error-messages="errors.first('otro evento')"
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
                                        inputmode="decimal"
                                        pattern="[0-9]+(\.[0-9][0-9]?)?"
                                        type="number"
                                    ></v-text-field>
                                </v-col>

                                    <v-col md=6>
                                        <v-select  
                                            v-model="origenRecursoEvento"
                                            outlined
                                            v-validate="'required'"
                                            :items="arrayOrigen"
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

                                <v-col md=2>
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

                                <v-col cols="12" sm="6" md="3">
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

                                <v-col cols="12" sm="6" md="3">
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
                                            ></v-text-field>
                                        </template>
                                        <v-date-picker v-model="fechaTermino" no-title scrollable>
                                            <v-spacer></v-spacer>
                                            <v-btn text color="primary" @click="menu = false">
                                                Cancel
                                            </v-btn>
                                            <v-btn text color="primary" @click="$refs.menu.save(fechaTermino)">
                                                OK
                                            </v-btn>
                                        </v-date-picker>
                                    </v-menu>
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
                                        data-vv-name="numero de días"
                                        :error="errors.has('numero de días')"
                                        :error-messages="errors.first('numero de días')"
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
                                        data-vv-name="numero de horas efectivas"
                                        :error="errors.has('numero de horas efectivas')"
                                        :error-messages="errors.first('numero de horas efectivas')"
                                    ></v-text-field>
                                </v-col>

                            </v-row>

                            <v-row justfy="center" dense >
                                <v-col class="text-center"><b>Participantes</b></v-col>
                            </v-row>
                            <v-divider></v-divider>

                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                            
                                <v-col md=3 > 
                                    <v-text-field 
                                        v-model="ptc"
                                        outlined
                                        label="PTC"    
                                        persistent-hint
                                        data-vv-name="PTC"
                                        :error="errors.has('PTC')"
                                        :error-messages="errors.first('PTC')"
                                        
                                    ></v-text-field>
                                </v-col>

                                <v-col md=3 > 
                                    <v-text-field 
                                        v-model="laboratoristas"
                                        outlined
                                        label="Laboratoristas"    
                                        persistent-hint
                                        data-vv-name="laboratoristas"
                                        :error="errors.has('laboratoristas')"
                                        :error-messages="errors.first('laboratoristas')"
                                        
                                    ></v-text-field>
                                </v-col>

                                <v-col md=3 > 
                                    <v-text-field 
                                        v-model="administrativo"
                                        outlined
                                        label="Administrativo del &aacute;rea acad&eacute;mica"    
                                        persistent-hint
                                        data-vv-name="administrativo"
                                        :error="errors.has('administrativo')"
                                        :error-messages="errors.first('administrativo')"
                                        
                                    ></v-text-field>
                                </v-col>
                                <v-col md=3> 
                                    <v-text-field 
                                        v-model="otros"
                                        outlined
                                        label="Otros participantes"    
                                        persistent-hint
                                        data-vv-name="otros"
                                        :error="errors.has('otros')"
                                        :error-messages="errors.first('otros')"
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
                                        
                                    ></v-text-field>
                                </v-col>
                                <v-col md=3> 
                                    <v-text-field 
                                        v-model="lugar"
                                        outlined
                                        label="Lugar"    
                                        persistent-hint
                                        data-vv-name="lugar"
                                        :error="errors.has('lugar')"
                                        :error-messages="errors.first('lugar')"
                                    ></v-text-field>
                                </v-col>
                            </v-row>

                            <v-row justfy="center" dense >
                                <v-col class="text-center"><b>Gestionar en las &aacute;reas academicas el recurso de viaticar</b></v-col>
                            </v-row>
                            <v-divider></v-divider>

                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">
                            
                                <v-col md=3> 
                                    <v-text-field 
                                        v-model="transporte"
                                        outlined
                                        prefix="$"
                                        label="Transporte (autobus)"    
                                        persistent-hint
                                        data-vv-name="transporte"
                                        :error="errors.has('transporte')"
                                        :error-messages="errors.first('transporte')"
                                    ></v-text-field>
                                </v-col>

                                <v-col md=3> 
                                    <v-text-field 
                                        v-model="casetas"
                                        outlined
                                        prefix="$"
                                        label="Casetas"    
                                        persistent-hint
                                        data-vv-name="casetas"
                                        :error="errors.has('casetas')"
                                        :error-messages="errors.first('casetas')"
                                    ></v-text-field>
                                </v-col>

                                <v-col md=3> 
                                    <v-text-field 
                                        v-model="alimentacion"
                                        outlined
                                        prefix="$"
                                        label="Alimentacion"    
                                        persistent-hint
                                        data-vv-name="alimentacion"
                                        :error="errors.has('alimentacion')"
                                        :error-messages="errors.first('alimentacion')"
                                    ></v-text-field>
                                </v-col>

                                <v-col md=3> 
                                    <v-text-field 
                                        v-model="hospedaje"
                                        outlined
                                        prefix="$"
                                        label="Hospedaje"    
                                        persistent-hint
                                        data-vv-name="hospedaje"
                                        :error="errors.has('hospedaje')"
                                        :error-messages="errors.first('hospedaje')"
                                    ></v-text-field>
                                </v-col>
                            
                            </v-row>

                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">

                                <v-col md=3> 
                                    <v-text-field 
                                        v-model="taxis"
                                        outlined
                                        prefix="$"
                                        label="Taxis"    
                                        persistent-hint
                                        data-vv-name="taxis"
                                        :error="errors.has('taxis')"
                                        :error-messages="errors.first('taxis')"
                                    ></v-text-field>
                                </v-col>

                                <v-col md=3> 
                                    <v-text-field 
                                        v-model="otrosGastos"
                                        outlined
                                        prefix="$"
                                        label="Otros"    
                                        persistent-hint
                                        data-vv-name="otros"
                                        :error="errors.has('otros')"
                                        :error-messages="errors.first('otros')"
                                    ></v-text-field>
                                </v-col>

                                <v-col md=3> 
                                    <v-text-field 
                                        v-model="oficial"
                                        outlined
                                        prefix="$"
                                        label="Ofical (vales de gasolina)"    
                                        persistent-hint
                                        data-vv-name="oficial"
                                        :error="errors.has('oficial')"
                                        :error-messages="errors.first('ofical')"
                                    ></v-text-field>
                                </v-col>

                                <v-col md=3> 
                                    <v-text-field 
                                        v-model="particular"
                                        outlined
                                        prefix="$"
                                        label="Particular (vales de gasolina)"    
                                        persistent-hint
                                        data-vv-name="particular"
                                        :error="errors.has('particular')"
                                        :error-messages="errors.first('particular')"
                                    ></v-text-field>
                                </v-col>

                            </v-row>
                            
                            <v-row class="align-center" style="padding: 0px 50px 0px 50px">

                                <v-col md=3> 
                                    <v-text-field 
                                        v-model="otrosO"
                                        outlined
                                        prefix="$"
                                        label="Otros"    
                                        persistent-hint
                                        data-vv-name="otros"
                                        :error="errors.has('otros')"
                                        :error-messages="errors.first('otros')"
                                    ></v-text-field>
                                </v-col>

                                <v-col md=4> 
                                    <v-text-field 
                                        v-model="origen"
                                        outlined
                                        prefix="$"
                                        label="Mencionar el origen del recurso viaticos"    
                                        persistent-hint
                                        data-vv-name="origen"
                                        :error="errors.has('origen')"
                                        :error-messages="errors.first('origen')"
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
                                                    fechaElavoracion = item.Expr5;
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

                const annio = ref("");
                const direccion = ref("");
                const fechaElavoracion=ref("");
                const unidadAcademica = ref("");
                const nivelEducativo = ref("");
                const direccionArea = ref("");
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
                const ptc=ref("");
                const laboratoristas=ref("");
                const administrativo=ref("");
                const otros=ref("");
                const total=ref("");
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

                




                const arrayUnidadesAcademicas = ref(["León","Acambaro"]);
                const arrayNivelEducativo = ref(["T.S.U","Ingenieria"]);
                const arrayAreas = ref(["Dirección de Económico Administrativo","Dirección de Electromecanica Industrial","Dirección de Sustentabilidad para el desarrollo","Dirección de Desarrollo Académico y Docente","Unidad Académica de Acámbaro","Centro de Idiomas"]);
                const arrayOrientacion = ref(["Pedagógicas","Investigación","Tutoreo","Digitales","Técnicas","Transversales","Desarrollo de habilidades"]);
                const arrayJustificacion = ref(["Pedagógicas","Investigación","Tutoreo","Digitales","Técnicas","Transversales","Desarrollo de habilidades"]);
                const arrayTipoEvento = ref(["Curso (3340)","Ponente (3830)","Certificación (3920)","Asistencia a congreso (3830)","Otro"]);
                const arrayTipoPrograma = ref(["Interna","Externa"]);
                const arrayOrigen = ref(["PFCE","Formación docente","Dirección académica"]);
                const arrayMes =ref(['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'])
                const arrayAcademia =ref([]);
                const arrayDireccSub =ref(['Direccion 1', 'Direccion 2']);

                
                


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
                    {text: 'Unidad Academica', align: 'left', sortable: true, value: 'nombre_unidad_academica'},
                    {text: 'Nombre del evento', align: 'left', sortable: true, value: 'nombre_evento'},
                    {text: 'Tipo de evento', align: 'left', sortable: true, value: 'nombre_tipo_evento'},
                    {text: 'Fecha inicio', align: 'left', sortable: true, value: 'fecha_inicio'},
                    {text: 'Fecha termino', align: 'left', sortable: true, value: 'fecha_temino'},
                    {text: 'Número de días', align: 'left', sortable: true, value: 'num_dias'},
                    {text: 'Editar', align: 'left', sortable: true, value: 'editar'},
                    {text: 'Eliminar', align: 'left', sortable: true, value: 'eliminar'}
                ]);

                //Accion automatizada para mostrar la tabla
                onMounted(() => {
                    fnTipoEvento();
                    fnConsultarTabla();
                    fnUnidadAcademica();
                });

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


                async function fnGuardar(){
                    this.$validator.validate().then(async esValido => {
                        if(esValido){
                            try{
                                preloader("../../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 4);
                                parametros.append("unidadAcademica", unidadAcademica.value);
                                parametros.append("tipoEvento", tipoEvento.value);
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
                                parametros.append("fechaTermino", fechaInicio.value);
                                parametros.append("numDias", numDias.value);    
                                parametros.append("numHorasEfectivas", numHorasEfectivas.value);  
                                parametros.append("ptc", ptc.value);  
                                parametros.append("laboratoristas", laboratoristas.value);  
                                parametros.append("administrativo", administrativo.value);  
                                parametros.append("otros", otros.value);  
                                parametros.append("total", total.value);  
                                parametros.append("totalH", totalH.value);  
                                parametros.append("totalM", totalM.value);  
                                parametros.append("numHorasEfectivas", numHorasEfectivas.value);        
                                parametros.append("fechaElavoracion", fechaElavoracion.value);    
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
                                preloader("../../");
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
                                parametros.append("fechaElavoracion", fechaElavoracion.value);    
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
                                preloader("../../");
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
                    fechaElavoracion.value = "";
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
                    annio, direccion, fechaElavoracion, unidadAcademica, nivelEducativo, direccionArea, programaEducativo,
                    nombreGestor, necesidadesDetectadas, nombreEventoCapacitacion, objetivoEvento, orientacionEvento,
                    justificacionEvento,tipoEvento, otroEvento, tipoPrograma, proveedorSugerido, costoCapacitacionSugerido, 
                    origenRecursoEvento, mes, fechaInicio, fechaTermino, numDias, numHorasEfectivas, ptc:0, laboratoristas:0, administrativo:0,
                    otros:0, total:0, totalH, totalM, lugar, transporte, casetas, alimentacion, hospedaje, taxis, otrosGastos, oficial,
                    particular, otrosO, origen,


                    arrayOrientacion, arrayJustificacion, arrayTipoEvento, arrayTipoPrograma, arrayOrigen, arrayMes, arrayUnidadesAcademicas,
                    arrayAcademia, arrayNivelEducativo, arrayAreas, arrayDireccSub,
                    flagEditar,
                    dataEventos,headersEventos, searchEventos, color_snackbar, snackbar, mensaje_snackbar,loader
                    ,fnLimpiarCampos,fnGuardar,fnEliminar,fnEditar
                    
                    
                }
            },
            watch: {
                ptc: function(newVal, oldVal) {
                    this.calculateTotal();
                },
                laboratoristas: function(newVal, oldVal) {
                    this.calculateTotal();
                },
                administrativo: function(newVal, oldVal) {
                    this.calculateTotal();
                },
                otros: function(newVal, oldVal) {
                    this.calculateTotal();
                }
                },
                methods: {
                calculateTotal() {
                    this.total = parseFloat(this.ptc) + parseFloat(this.laboratoristas) + parseFloat(this.administrativo) 
                    + parseFloat(this.otros) ;
                }
                }

        });

    </script>


    </html>