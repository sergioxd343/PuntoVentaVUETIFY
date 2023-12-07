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
        <title>Rúbricas</title>
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
                        <v-card-title style="background-color: #00b293; color:#ffffff; headline">
                            Rúbricas
                        </v-card-title>
                        <!--En este apartado estan los inputs para comenzar el registro-->

                        <v-container fluid class="elevation-2">
                            <v-row justify="center" class="align-center" style="padding: 0px 50px 0px 50px">

                                <v-autocomplete v-model="cve_rubrica" outlined label="Rúbrica" persistent-hint
                                    v-validate="'required|max:150'" data-vv-name="rubrica" :items="rubricas"
                                    item-value="cve_rubrica" item-text="nombre_rubica" :error="errors.has('rubrica')"
                                    :error-messages="errors.first('rubrica')"></v-autocomplete>

                                <v-col md="12">
                                    <v-tabs v-model="activeTab" background-color="transparent" grow>
                                        <v-tab v-for="(tab, index) in tabs" :key="index">{{ tab }}</v-tab>
                                    </v-tabs>
                                    <v-tabs-items v-model="activeTab">
                                        <v-tab-item>
                                            <v-row>
                                                <!--TAB DE RUBRICA DE OBSERVACION DE CLASE-->
                                                <v-col md=4>
                                                    <!--Sección-->
                                                    Seleccione la sección a calificar:
                                                    <v-radio-group v-model="seccion">
                                                        <v-radio label="Inicio" value="sec_inicio"
                                                            @change="fnLimpiarCampos(this)"></v-radio>
                                                        <v-radio label="Desarrollo" value="sec_desarrollo"
                                                            @change="fnLimpiarCampos(this)"></v-radio>
                                                        <v-radio label="Cierre" value="sec_cierre"
                                                            @change="fnLimpiarCampos(this)"></v-radio>
                                                    </v-radio-group>
                                                </v-col>
                                                <v-col md="4">
                                                    <!--Empleado-->
                                                    <v-autocomplete v-model="cve_empleado_docente" outlined
                                                        label="Empleado" persistent-hint v-validate="'required|max:100'"
                                                        data-vv-name="empleado" :items="arrayEmpleado"
                                                        item-value="cve_empleado" item-text="nombre_completo"
                                                        :error="errors.has('empleado')"
                                                        :error-messages="errors.first('empleado')"></v-autocomplete>
                                                </v-col>

                                                <v-col md=12>
                                                    <v-card>
                                                        <v-list v-if="seccion === 'sec_inicio'">
                                                            <!-- Encabezado de la tabla -->
                                                            <v-row class="grey lighten-3">
                                                                <v-col cols="3">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="font-weight-bold">
                                                                            Autónomo (10)
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="3">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="font-weight-bold">
                                                                            Destacado (9)
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="font-weight-bold">
                                                                            Satisfactorio (8)
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="font-weight-bold">
                                                                            No Acreditado (7)
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="font-weight-bold">
                                                                            Calificación
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                            </v-row>

                                                            <!-- Filas de la tabla -->
                                                            <v-row>
                                                                <v-col cols="3">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            Es puntual e inicia inmediatamente
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="3">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            Es puntual para entrar al salón de clase
                                                                            pero no inicia con
                                                                            la clase
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            Llega a clase con demora
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            El/la docente no asiste
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-text-field v-model="calificacionSec[0]"
                                                                            outlined label="Calificación"
                                                                            persistent-hint
                                                                            v-validate="{required: true, min_value: 7, max_value: 10}"
                                                                            data-vv-name="1.calificación"
                                                                            inputmode="numeric" pattern="[0-9]*"
                                                                            type="number"
                                                                            :error="errors.has('1.calificación')"
                                                                            :error-messages="errors.first('1.calificación')"></v-text-field>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                            </v-row>

                                                            <v-row>
                                                                <v-col cols="3">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            Se presenta los objetivos de clase, los
                                                                            temas y las
                                                                            actividades
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="3">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            Se presenta los objetivos y los temas de
                                                                            clase
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            Se presenta el objetivo de clase
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            No se presenta el objetivo de la clase
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-text-field v-model="calificacionSec[1]"
                                                                            outlined label="Calificación"
                                                                            persistent-hint
                                                                            v-validate="{required: true, min_value: 7, max_value: 10}"
                                                                            data-vv-name="2.calificación"
                                                                            inputmode="numeric" pattern="[0-9]*"
                                                                            type="number"
                                                                            :error="errors.has('2.calificación')"
                                                                            :error-messages="errors.first('2.calificación')"></v-text-field>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                            </v-row>

                                                            <!-- Filas de la tabla -->
                                                            <v-row>
                                                                <v-col cols="3">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            El material es pertinente para la actividad
                                                                            y suficiente
                                                                            para todo el alumnado
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            Se asegura de tener el material para su
                                                                            clase antes de
                                                                            iniciar
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            Lleva material, pero es insuficiente para el
                                                                            alumnado
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="3">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            El material que se presenta sale del
                                                                            contexto de la clase y
                                                                            es insuficiente para ejecutar su actividad
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-text-field v-model="calificacionSec[2]"
                                                                            outlined label="Calificación"
                                                                            persistent-hint
                                                                            v-validate="{required: true, min_value: 7, max_value: 10}"
                                                                            data-vv-name="3.calificación"
                                                                            inputmode="numeric" pattern="[0-9]*"
                                                                            type="number"
                                                                            :error="errors.has('3.calificación')"
                                                                            :error-messages="errors.first('3.calificación')"></v-text-field>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                            </v-row>
                                                        </v-list>

                                                        <v-list v-if="seccion === 'sec_desarrollo'">
                                                            <!-- Encabezado de la tabla -->
                                                            <v-row class="grey lighten-3">
                                                                <v-col cols="3">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="font-weight-bold">
                                                                            Autónomo (10)
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="3">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="font-weight-bold">
                                                                            Destacado (9)
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="font-weight-bold">
                                                                            Satisfactorio (8)
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="font-weight-bold">
                                                                            No Acreditado (7)
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="font-weight-bold">
                                                                            Calificación
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                            </v-row>

                                                            <!-- Filas de la tabla -->
                                                            <v-row>
                                                                <v-col cols="3">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            El/la profesor(a) funge como facilitador del
                                                                            aprendizaje
                                                                            interactuando con todos el alumnado
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="3">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            El/la profesor(a) realiza exposición e
                                                                            interactúa con los
                                                                            estudiantes, promueve la colaboración
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            El/la profesor(a) realiza una exposición
                                                                            dirigida solo a
                                                                            algunos estudiantes sin promover la
                                                                            colaboración
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            El/la profesor(a) dirige la clase de manera
                                                                            unilateral,
                                                                            totalmente expositiva y sin promuever la
                                                                            colaboración
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-text-field v-model="calificacionSec[3]"
                                                                            outlined label="Calificación"
                                                                            persistent-hint
                                                                            v-validate="{required: true, min_value: 7, max_value: 10}"
                                                                            data-vv-name="4.calificación"
                                                                            inputmode="numeric" pattern="[0-9]*"
                                                                            type="number"
                                                                            :error="errors.has('4.calificación')"
                                                                            :error-messages="errors.first('4.calificación')"></v-text-field>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                            </v-row>

                                                            <v-row>
                                                                <v-col cols="3">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            No tiene muletillas, explica los tecnicismos
                                                                            y utiliza un
                                                                            lenguaje fluido
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="3">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            Se asegura que sus estudiantes comprendan
                                                                            los tecnicismos
                                                                            empleados
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            Utiliza pocas muletillas y/o explica algunos
                                                                            tecnicismos
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            El lenguaje es complejo para su comprensión
                                                                            o poco fluido
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-text-field v-model="calificacionSec[4]"
                                                                            outlined label="Calificación"
                                                                            persistent-hint
                                                                            v-validate="{required: true, min_value: 7, max_value: 10}"
                                                                            data-vv-name="5.calificación"
                                                                            inputmode="numeric" pattern="[0-9]*"
                                                                            type="number"
                                                                            :error="errors.has('5.calificación')"
                                                                            :error-messages="errors.first('5.calificación')"></v-text-field>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                            </v-row>

                                                            <!-- Filas de la tabla -->
                                                            <v-row>
                                                                <v-col cols="3">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            Genera un adecuado ambiente de aprendizaje
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="3">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            Utiliza estrategias para atraer la atención
                                                                            y retomarla
                                                                            cuando el grupo se dispersa
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            La intervención que realiza atrae la
                                                                            atención, con poca
                                                                            frecuencia
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            Omite el uso de estrategias que favorezcan
                                                                            la atención
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-text-field v-model="calificacionSec[5]"
                                                                            outlined label="Calificación"
                                                                            persistent-hint
                                                                            v-validate="{required: true, min_value: 7, max_value: 10}"
                                                                            data-vv-name="6.calificación"
                                                                            inputmode="numeric" pattern="[0-9]*"
                                                                            type="number"
                                                                            :error="errors.has('6.calificación')"
                                                                            :error-messages="errors.first('6.calificación')"></v-text-field>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                            </v-row>

                                                            <!-- Filas de la tabla -->
                                                            <v-row>
                                                                <v-col cols="3">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            Responde las dudas oportunamente y utiliza
                                                                            ejemplos del
                                                                            contexto del estudiante
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="3">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            Responde las dudas y agrega algunos ejemplos
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            Responde algunas dudas de los estudiantes
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            Evita cotestar las dudas de los estudiantes
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-text-field v-model="calificacionSec[6]"
                                                                            outlined label="Calificación"
                                                                            persistent-hint
                                                                            v-validate="{required: true, min_value: 7, max_value: 10}"
                                                                            data-vv-name="7.calificación"
                                                                            inputmode="numeric" pattern="[0-9]*"
                                                                            type="number"
                                                                            :error="errors.has('7.calificación')"
                                                                            :error-messages="errors.first('7.calificación')"></v-text-field>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                            </v-row>

                                                            <!-- Filas de la tabla -->
                                                            <v-row>
                                                                <v-col cols="3">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            Asigna actividades de aprendizaje indicando
                                                                            instrucciones,
                                                                            entregas y características, supervisa la
                                                                            ejecución de la
                                                                            actividad de los estudiantes
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="3">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            Asigna actividades de aprendizaje, supervisa
                                                                            con poca
                                                                            frecuencia su comprensión o elaboración
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            Asigna 1 actividad de aprendizaje
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            No propone actividades de aprendizaje
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-text-field v-model="calificacionSec[7]"
                                                                            outlined label="Calificación"
                                                                            persistent-hint
                                                                            v-validate="{required: true, min_value: 7, max_value: 10}"
                                                                            data-vv-name="8.calificación"
                                                                            inputmode="numeric" pattern="[0-9]*"
                                                                            type="number"
                                                                            :error="errors.has('8.calificación')"
                                                                            :error-messages="errors.first('8.calificación')"></v-text-field>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                            </v-row>

                                                            <!-- Filas de la tabla -->
                                                            <v-row>
                                                                <v-col cols="3">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            Utiliza técnicas de grupos o trabajo
                                                                            colaborativo y domina
                                                                            la metodología
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="3">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            Utiliza técnicas de grupo o trabajo
                                                                            colaborativo, pero
                                                                            requiere dominar la metodología
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            Utiliza técnicas de grupo o trabajo
                                                                            colaborativo pero no
                                                                            están contextualizadas
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            No utiliza técnicas de grupo ni promueve la
                                                                            colaboración
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-text-field v-model="calificacionSec[8]"
                                                                            outlined label="Calificación"
                                                                            persistent-hint
                                                                            v-validate="{required: true, min_value: 7, max_value: 10}"
                                                                            data-vv-name="9.calificación"
                                                                            inputmode="numeric" pattern="[0-9]*"
                                                                            type="number"
                                                                            :error="errors.has('9.calificación')"
                                                                            :error-messages="errors.first('9.calificación')"></v-text-field>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                            </v-row>

                                                            <!-- Filas de la tabla -->
                                                            <v-row>
                                                                <v-col cols="3">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            Domina el tema y lo sabe explicar, plantea
                                                                            ejemplos del
                                                                            contexto del alumnado
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="3">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            Domina el tema, pero no es claro en su
                                                                            explicación
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            Conoce el tema y al explicarlo duda del uso
                                                                            de conceptos
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            No conoce el tema o no sabe explicarlo
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-text-field v-model="calificacionSec[9]"
                                                                            outlined label="Calificación"
                                                                            persistent-hint
                                                                            v-validate="{required: true, min_value: 7, max_value: 10}"
                                                                            data-vv-name="10.calificación"
                                                                            inputmode="numeric" pattern="[0-9]*"
                                                                            type="number"
                                                                            :error="errors.has('10.calificación')"
                                                                            :error-messages="errors.first('10.calificación')"></v-text-field>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                            </v-row>
                                                        </v-list>

                                                        <v-list v-if="seccion === 'sec_cierre'">
                                                            <!-- Encabezado de la tabla -->
                                                            <v-row class="grey lighten-3">
                                                                <v-col cols="3">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="font-weight-bold">
                                                                            Autónomo (10)
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="3">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="font-weight-bold">
                                                                            Destacado (9)
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="font-weight-bold">
                                                                            Satisfactorio (8)
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="font-weight-bold">
                                                                            No Acreditado (7)
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="font-weight-bold">
                                                                            Calificación
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                            </v-row>

                                                            <!-- Filas de la tabla -->
                                                            <v-row>
                                                                <v-col cols="3">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            Construye con el grupo el sec_cierre,
                                                                            promueve la reflexión
                                                                            sobre el aprendizaje significativo
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            Elabora el sec_cierre integrando la
                                                                            información revisada en
                                                                            clase
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            Hace un sec_cierre apresurado al terminar la
                                                                            hora de clase
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="3">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            Omite el sec_cierre de tema, o lo hace con
                                                                            mucho tiempo de
                                                                            anticipación del termino de clase
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-text-field v-model="calificacionSec[10]"
                                                                            outlined label="Calificación"
                                                                            persistent-hint
                                                                            v-validate="{required: true, min_value: 7, max_value: 10}"
                                                                            data-vv-name="11.calificación"
                                                                            inputmode="numeric" pattern="[0-9]*"
                                                                            type="number"
                                                                            :error="errors.has('11.calificación')"
                                                                            :error-messages="errors.first('11.calificación')"></v-text-field>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                            </v-row>

                                                            <v-row>
                                                                <v-col cols="3">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            Explica la tarea, criterios de entrega y se
                                                                            asegura su
                                                                            comprensión
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            Al asignar una tarea, Explica la actividad y
                                                                            los criterios
                                                                            de entrega
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            Al asignar tarea, explica la actividad, no
                                                                            especifica los
                                                                            criterios de entrega
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="3">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            Al asignar una tarea, genera confusión en
                                                                            las instrucciónes,
                                                                            especificaciones o criterios de entrega
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-text-field v-model="calificacionSec[11]"
                                                                            outlined label="Calificación"
                                                                            persistent-hint
                                                                            v-validate="{required: true, min_value: 7, max_value: 10}"
                                                                            data-vv-name="12.calificación"
                                                                            inputmode="numeric" pattern="[0-9]*"
                                                                            type="number"
                                                                            :error="errors.has('12.calificación')"
                                                                            :error-messages="errors.first('12.calificación')"></v-text-field>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                            </v-row>

                                                            <!-- Filas de la tabla -->
                                                            <v-row>
                                                                <v-col cols="3">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            Termina la clase a tiempo, recoge el
                                                                            material y el salón
                                                                            queda en orden
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            Termina clase a tiempo, recoge el material,
                                                                            pero no
                                                                            organizan el salón
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            Termina la clase a tiempo, pero no recoge el
                                                                            material u
                                                                            ordena el salón
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="3">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title class="text-wrap">
                                                                            Se excede del tiempo de la sesión. O se
                                                                            retira antes de
                                                                            terminar la clase
                                                                        </v-list-item-title>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                                <v-col cols="2">
                                                                    <v-list-item-content>
                                                                        <v-text-field v-model="calificacionSec[12]"
                                                                            outlined label="Calificación"
                                                                            persistent-hint
                                                                            v-validate="{required: true, min_value: 7, max_value: 10}"
                                                                            data-vv-name="13.calificación"
                                                                            inputmode="numeric" pattern="[0-9]*"
                                                                            type="number"
                                                                            :error="errors.has('13.calificación')"
                                                                            :error-messages="errors.first('13.calificación')"></v-text-field>
                                                                    </v-list-item-content>
                                                                </v-col>
                                                            </v-row>
                                                        </v-list>
                                                    </v-card>
                                                </v-col>

                                                <v-col md="6">
                                                    <v-text-field outlined label="Calificación de la sección"
                                                        persistent-hint data-vv-name="calificación de sección"
                                                        inputmode="numeric" pattern="[0-9]*" type="number"
                                                        :error="errors.has('calificación de sección')"
                                                        :error-messages="errors.first('calificación de sección')"
                                                        :readonly="true" v-model="calificacionPromedio"></v-text-field>
                                                </v-col>
                                                <v-col md="6">
                                                    <v-text-field outlined label="Calificación total" persistent-hint
                                                        data-vv-name="calificación total" inputmode="numeric"
                                                        pattern="[0-9]*" type="number"
                                                        :error="errors.has('calificación total')"
                                                        :error-messages="errors.first('calificación total')"
                                                        :readonly="true" v-model="calificacionTotal"></v-text-field>
                                                </v-col>
                                                <v-col md="8">
                                                    <!--Comentario-->
                                                    <v-textarea v-model="comentario" outlined label="Comentario:"
                                                        persistent-hint v-validate="'max:255'"></v-textarea>
                                                </v-col>

                                                <v-col md="2">
                                                    <v-checkbox v-model="activo" label="Activo/Cancelado"
                                                        color="success" value=true hide-details
                                                        :disabled="!flagEditar"></v-checkbox>
                                                </v-col>
                                            </v-row>
                                        </v-tab-item>
                                    </v-tabs-items>
                                </v-col>

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
                                    <v-col md=12>
                                        <v-data-table :headers="headersRubrica" :items="dataRubrica"
                                            :search="searchRubrica" class="elevation-2"
                                            no-data-text="No se encontro ningun registro"
                                            :hide-default-header="dataRubrica.length < 1"
                                            :hide-default-footer="dataRubrica.length < 1" locale="es-ES"
                                            :mobile-breakpoint="NaN" items-per-page="10">
                                            <template v-slot:item.status="{item}">
                                                <%-- <v-tooltip bottom> --%>
                                                    <%-- <template v-slot:activator="{on, attrs}"> --%>
                                                        <%-- v-bind="attrs" v-on="on" --%>
                                                            <v-switch v-model="item.status"
                                                                @change="fnCambiarEstatus(item)"></v-switch>
                                                            <%-- </template> --%>
                                                                <%-- <span>d</span> --%>
                                                                    <%-- </v-tooltip> --%>
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
                                            <template v-slot:item.editar="{item}">
                                                <v-btn fab small color="warning" @click="flagEditar = true; itemEditar = item;
                                                    cve_empleado_docente = item.cve_empleado_docente;
                                                    cve_rubrica = item.cve_rubrica;
                                                    seccion = item.seccion;
                                                    calificacion_seccion = item.calificacion_seccion;
                                                    calificacion_total = item.calificacion_total;
                                                    cometario = item.cometario;
                                                    activo = item.activo;
                                                    fecha_registro = item.fecha_registro;
                                                    usuario_registro = item.usuario_registro;
                                                "><v-icon>mdi-square-edit-outline</v-icon></v-btn>
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
                                <v-text-field label="Filtrar" v-model="searchBusqueda"></v-text-field>
                            </v-col>
                        </v-row>

                    </v-card-text>
                </v-card>

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
        <%--sec_desarrollo--%>
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
                        const ctr = "../../controlador/innovacion_educativa/Controlador_rubrica_observacion_clase.jsp";

                        const cve_empleado_docente = ref("");
                        const cve_rubrica = ref("");
                        const seccion = ref("");
                        const calificacion_seccion = ref("");
                        const calificacion_total = ref("");
                        const comentario = ref("");
                        const activo = ref("");
                        const fecha_registro = ref("");
                        const usuario_registro = ref("");

                        const arrayEmpleado = ref([]);

                        const sec_inicio = ref("");
                        const sec_desarrollo = ref("");
                        const sec_cierre = ref("");

                        const calificacionSec = ref([""]);

                        const activeTab = null;
                        const tabs = ref(["Observación de clase"]);
                        const rubricas = ref([]);

                        //SNACKBAR
                        const loader = ref(false);
                        const snackbar = ref(false);
                        const mensaje_snackbar = ref('');
                        const color_snackbar = ref('');

                        const dialogBuscador = ref(true);
                        const nombreBuscar = ref('');
                        const searchBusqueda = ref('');

                        //Otras variables
                        const flagEditar = ref(false);
                        const itemEditar = ref({});

                        //DataUsuarios
                        const dataRubrica = ref([]);
                        const dataUsuarios = ref([]);
                        const headersRubrica = ref([
                            { text: 'Rubrica', align: 'left', sortable: true, value: 'cve_rubrica' },
                            { text: 'Empleado/Docente', align: 'left', sortable: true, value: 'nombre_completo' },
                            { text: 'Sección calificada', align: 'left', sortable: true, value: 'seccion' },
                            { text: 'Calificación de sección', align: 'left', sortable: true, value: 'calificacion_seccion' },
                            { text: 'Calificación total', align: 'left', sortable: true, value: 'calificacion_total' },
                            { text: 'Fecha de registro', align: 'left', sortable: true, value: 'fecha_registro' },
                            { text: 'Estatus', align: 'left', sortable: true, value: 'activo' },
                            { text: 'Editar', align: 'left', sortable: true, value: 'editar' },
                        ]);
                        const searchRubrica = ref([]);

                        function mostrarSnackbar(color, texto) {
                            snackbar.value = true;
                            color_snackbar.value = color;
                            if (color == "error")
                                mensaje_snackbar.value = "Ocurrió un error. Intentalo de nuevo más tarde.";
                            else
                                mensaje_snackbar.value = texto;
                        }

                        //Accion automatizada para mostrar la tabla
                        onMounted(() => {
                            fnConsultarTabla();
                            fnEmpleado();
                            fnRubricas();
                        });

                        //Consultar datos en la base de datos.
                        async function fnEmpleado() {
                            try {
                                preloader("../../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 3);
                                let { data, status } = await axios.post(ctr, parametros)
                                if (status == 200) {
                                    if (data.length > 0) {
                                        arrayEmpleado.value = data;
                                    }
                                }
                            } catch (error) {
                                mostrarSnackbar('error');
                                console.error(error);
                            } finally {
                                swal.close();
                            }
                        }

                        async function fnRubricas() {
                            try {
                                preloader("../../");
                                let parametros = new URLSearchParams();
                                parametros.append("accion", 6);
                                let { data, status } = await axios.post(ctr, parametros)
                                if (status == 200) {
                                    if (data.length > 0) {
                                        rubricas.value = data;
                                    }
                                }
                            } catch (error) {
                                mostrarSnackbar('error');
                                console.error(error);
                            } finally {
                                swal.close();
                            }
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
                                        data.forEach(objeto => {
                                            if (objeto.activo === true) {
                                                objeto.activo = "Activo";
                                            } else if (objeto.activo === false) {
                                                objeto.activo = "Cancelado";
                                            }
                                        });

                                        data.forEach(objeto => {
                                            if (objeto.seccion === "sec_inicio") {
                                                objeto.seccion = "Inicio";
                                            } else if (objeto.seccion === "sec_desarrollo") {
                                                objeto.seccion = "Desarrollo";
                                            } else if (objeto.seccion === "sec_cierre") {
                                                objeto.seccion = "Cierre";
                                            }
                                        });
                                        dataRubrica.value = data;
                                    }
                                }
                            } catch (error) {
                                mostrarSnackbar('error');
                                console.error(error);
                            } finally {
                                swal.close();
                            }
                        }

                        function fnBusquedaNombre() {
                            this.dataDNAP = this.dataDNAP.filter(item => item.materia === this.nombreBuscar);
                        }

                        async function fnGuardar() {
                            this.$validator.validate().then(async esValido => {
                                if (esValido) {
                                    try {
                                        preloader("../../");
                                        let parametros = new URLSearchParams();
                                        parametros.append("accion", 2);

                                        parametros.append("cve_empleado_docente", cve_empleado_docente.value);
                                        parametros.append("seccion", seccion.value);
                                        parametros.append("calificacion_seccion", parseInt(calificacion_seccion.value));
                                        parametros.append("calificacion_total", parseInt(calificacion_total.value));
                                        parametros.append("comentario", comentario.value);

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

                        async function fnEditar() {
                            this.$validator.validate().then(async esValido => {
                                if (esValido) {
                                    try {
                                        preloader("../../");
                                        let parametros = new URLSearchParams();
                                        parametros.append("accion", 4);

                                        parametros.append("cve_empleado_docente", cve_empleado_docente.value);
                                        parametros.append("seccion", seccion.value);
                                        parametros.append("calificacion_seccion", calificacion_seccion.value);
                                        parametros.append("calificacion_total", calificacion_total.value);
                                        parametros.append("comentario", comentario.value);
                                        parametros.append("activo", activo.value);
                                        parametros.append("cve_rubrica", cve_rubrica.value);

                                        let { data, status } = await axios.post(ctr, parametros)
                                        if (status == 200) {
                                            if (data == "1") {
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
                            cve_empleado_docente.value = "";
                            cve_rubrica.value = "";
                            seccion.value = "";
                            calificacion_seccion.value = 0;
                            calificacion_total.value = 0;
                            comentario.value = "";
                            activo.value = "";
                            fecha_registro.value = "";
                            usuario_registro.value = "";
                            calificacionSec.value = [""];
                            tabs.value = ["Observación de clase"];

                            flagEditar.value = false;
                            itemEditar.value = {};

                            fnConsultarTabla();

                            if (this == undefined)
                                cx.$validator.reset();
                            else
                                this.$validator.reset();
                        }

                        return {
                            cve_empleado_docente, cve_rubrica, seccion, calificacion_seccion, calificacion_total,
                            comentario, activo, fecha_registro, usuario_registro, calificacionSec, arrayEmpleado,
                            sec_inicio, sec_desarrollo, sec_cierre, fnConsultarTabla, fnEmpleado, fnBusquedaNombre,
                            color_snackbar, snackbar, mensaje_snackbar, loader, mostrarSnackbar,
                            dialogBuscador, nombreBuscar, searchBusqueda, activeTab, tabs, rubricas,
                            headersRubrica, flagEditar, dataRubrica, searchRubrica, fnLimpiarCampos, fnGuardar,
                            fnEditar, itemEditar
                        }
                    },
                    computed: {
                        calificacionPromedio() {
                            const calificaciones = this.calificacionSec.filter(calificacion => calificacion !== "");
                            if (calificaciones.length > 0) {
                                const suma = calificaciones.reduce((total, calificacion) => total + parseInt(calificacion), 0);
                                const promedio = suma / calificaciones.length;
                                this.calificacion_seccion = promedio;
                                return promedio.toFixed(0);
                            } else {
                                return "";
                            }
                        },
                        calificacionTotal() {
                            const calificaciones = this.calificacionSec.filter(calificacion => calificacion !== "");
                            if (calificaciones.length > 0) {
                                const suma = calificaciones.reduce((total, calificacion) => total + parseInt(calificacion), 0);
                                this.calificacion_total = suma;
                                return suma;
                            } else {
                                return "";
                            }
                        }
                    },
                });
                Vue.config.devtools = true;
            </script>

    </html>