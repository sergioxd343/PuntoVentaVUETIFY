<%@page contentType="text/html; charset=utf-8" language="java" errorPage="" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900" rel="stylesheet">
        <link href="../../styles/icon_material_design_4495/css/materialdesignicons.min.css" rel="stylesheet">
        <link href="../../javascript/VueJs/vuetify/vuetify.min.css" rel="stylesheet">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
		 <style>

html{overflow-y: hidden!important;}

.msj-error {
    position: absolute !important;
    bottom: 65px;
}
.lux-col1{
    /* background-image: url('resource/img/zonagif.gif'); */
    background-image: url('images/1.2.jpg');
    
    background-position-x: left;
    position: relative;
}

.lux-col2{
    position: relative;
}

.bg-perfil{
  background: #F6CE3C; /* fallback for old browsers */
  background: -webkit-linear-gradient(to right, #F6CE3C, #FFB600); /* Chrome 10-25, Safari 5.1-6 */
  background: linear-gradient(to right, #F6CE3C, #FFB600); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */

}
 </style>
 <style>
  .backgruond{
    background-image: url(../../images/1.2.jpg) !important;
    height: 100%;
    width: 100%;
    display: block;
    position: absolute;
    top: 0;
    background-size: cover;
  }
</style>
    </head>
    <body>
        <div id="app">
            <v-app>
				<div class="backgruond"></div>
    <v-main class="d-flex justify-center align-start">
      <v-col cols="12" lg="4" xl="4" md="12" sm="12" style="margin-top: 15%;">
        <v-card class="pa-4 " elevation="10">
          <div class="text-center">
            <h2 class="primary--text">Acceso</h2>
          </div>
          <v-form >
            <v-card-text>
				<h1>Usuario logeado:></h1>
            </v-card-text>
          </v-form>
        </v-card>
      </v-col>
    </v-main>
    <v-overlay :value="loader" z-index="1000">
                                    <v-img
                                        aspect-ratio="2"
                                        class="white--text align-end"
                                        height="212px"
                                        width="292px"
                                        src="./images/Logo_utl_animado.gif"
                                    > </v-img>
                                </v-overlay>
								<v-snackbar v-model="snackbar" top="top" :bottom="true" :multi-line="true" :color="color_mensaje">
                                 <span v-html="mensaje_alerta"></span>
                                <v-icon color="white" @click="snackbar=false">mdi-close-circle</v-icon>
                              </v-snackbar>
				</template>
            </v-app>
        </div>
        <%--Desarrollo--%>
        <script src="javascript/axios/axios.js"></script>
        <script src="javascript/VueJs/vue/vue.js"></script>
        <script src="javascript/VueJs/vue/vue-composition-api.prod.js"></script>
        <script src="javascript/VueJs/vuetify/vuetify.min.js"></script>
        
		
		
		
        
        <%--Desarrollo--%>
        <!--<script src="controlador/js/escolar/reporte_validacion_solicitud_captura_tardia_new.js"></script>-->
		<script>
			/* global axios, Vue, VueCompositionAPI */
 const ca = window.VueCompositionAPI;
 
 
 Vue.use(ca.default);
 const vm = new Vue({
  el: "#app",
  vuetify: new Vuetify(),
  setup() {
	  let obj = this;
        //Composition components
		
        const {ref,onMounted, watch} = VueCompositionAPI;
        const ctr= "controlador/sistema/Loggin.jsp";
        const accion= ref(0);
		const modalFechaInicioReporte = ref(false);
		const modalFechaFinReporte = ref(false);
		const dateFechaInicioReporte = ref((new Date(Date.now() - (new Date()).getTimezoneOffset() * 60000)).toISOString().substr(0, 10));
		const dateFechaFinReporte = ref((new Date(Date.now() - (new Date()).getTimezoneOffset() * 60000)).toISOString().substr(0, 10));
        const dataExportar = ref ([]);
		const busqueda = ref('');
		const password = ref('');
		const cuenta = ref('');
		const show= ref(false);
		const loading= ref(false);
		const passwordShow= ref(false);
		
        //SNACKBAR
        const loader= ref(false);
        const snackbar= ref(false);
        const mensaje_alerta= ref('');
        const color_mensaje= ref(''); 
		
		//datatable reporte
		const tablaReporte = ref([]);
		const cabeceraTemp = ref(null);
		const cabeceraTablaReporte= ref([
            {text: 'Cabeceras', align: 'start', sortable: true, value: 'no'},

          ]);
		
        //LifeCicle vue
        onMounted(() => {
			fnLogin();
			
			
        });
		
		/*watch(() => 
			cve_colonia_.value,
				(value)=> {
					console.log("colonia: ",value);
				},	
			
		);
		*/
		
		
		
		async function fnLogin(){
                    try{
                       
                            loader.value= true;
                            //Peticion ajax al controlador y envio de parametros
                            let parametros = new URLSearchParams();
                            parametros.append("accion", 2);
                            
                            let {data, status}= await axios.post(ctr, parametros);
                            if(status==200){
                                console.log("data: ",data);
                                if(Object.keys(data).length > 0){
                                    
                                }else{
								color_mensaje.value = 'warning';
								mensaje_alerta.value= 'Usuario contraseña no valido';
								snackbar.value = true;
                                }
                            }
                       
                    }catch(error){
                        console.log(error);
                    }finally{
                        loader.value = false;
                    }

                }
		
		
		function formatDate (date) {
		//console.log("Date: ", date);
		if (!date) return null

		const [year, month, day] = date.split('-')
		//console.log("Date2: ", day);
		return day+'/'+month+'/'+year
		}
		
		function save (date) {
		var o = this;
		o.$refs.menu.save(date)

		pickerDate.value = date;
		}

		function parseDate (date) {
		if (!date) return null

		const [month, day, year] = date.split('/')
		return `${year}/${month.padStart(2, '0')}/${day.padStart(2, '0')}`
		}
		
		async function fnCargarDatos(){
			
			loader.value = true;
					try{
					let parametros = new URLSearchParams();
					parametros.append("accion", 1);
					parametros.append("inicio", formatDate(dateFechaInicioReporte.value));
					parametros.append("fin", formatDate(dateFechaFinReporte.value));

					//Petici�n ajax al controlador y envio de parametros
					let {data, status}= await axios.post(ctr, parametros);
           
					if(status==200){
						cabeceraTemp.value = data[0];
						
						cabeceraTablaReporte.value = [];
						
						cabeceraTablaReporte.value.push({
							text: 'No.', align: 'start', sortable: true, value: 'no'
						});
						/*
						Object.getOwnPropertyNames(cabeceraTemp.value).map(i=>{
							cabeceraTablaReporte.value.push({
							text: i, align: 'start', sortable: true, value: i
						});
						});
						*/
						
						//console.log(Object.getOwnPropertyNames(cabeceraTemp.value).length);
						
						for(var i = 0; i < Object.getOwnPropertyNames(cabeceraTemp.value).length -1 ; i++)
						{
							//console.log(Object.getOwnPropertyNames(cabeceraTemp.value)[i], " i ", i);
							cabeceraTablaReporte.value.push({
							text: Object.getOwnPropertyNames(cabeceraTemp.value)[i], align: 'start', sortable: true, value: Object.getOwnPropertyNames(cabeceraTemp.value)[i]
						});
						}
					
						
						//console.log("cabeceraTablaReporte 1: ",cabeceraTablaReporte); 
						
						//cabeceraTablaReporte.value.slice(0, -1);
						
						//console.log("cabeceraTablaReporte 2: ",cabeceraTablaReporte);
						
						tablaReporte.value = data;
						tablaReporte.value.map((i,index)=>{
							i.no = index+1;
						});
							}
					}catch(error){
					console.log(error);
					}finally{
					loader.value = false;
					}
			
		}
		

		async function  fnExportar(){
		loader.value=true;

		if(tablaReporte.value.length > 0){
		//loader.value = true;
		dataExportar.value = []
		let array_  = [];
		cabeceraTablaReporte.value.map(i=>{
		console.log("Cabeceras: ", i.text);	
		array_.push(
		{text:i.text}
		)		
		});
		dataExportar.value.push([{text: ''}]);
		dataExportar.value.push(array_);
		
		
		console.log("dataExportar.value: ", dataExportar.value);
		

		array_  = [];
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
		
		tablaReporte.value.forEach(function(item, index){ 
		
		console.log("item: ", item.no);
		
		cabeceraTablaReporte.value.map(i=>{
		array_.push(
		
		{text:item[i.value]},
		
		)
		})
		dataExportar.value.push(array_);
		array_  = [];
		})
		
		

		//Se declara el nombre del archivo y de la hoja de excel, así mismo se manda llamar el data = dataExport
		var tableData = [
		 {
			 "sheetName": "Reporte Transparencia",
			 "data": dataExportar.value
		 }
		];
		
		 var date_variable = new Date();
            var year    = date_variable.getFullYear();
            var month   = date_variable.getMonth() + 1;
            var day     = date_variable.getDate();

            var hour    = date_variable.getHours();
            var minutes = date_variable.getMinutes();
            var seconds = date_variable.getSeconds();

            var full_date = year + month + day + hour + minutes + seconds;

		var options = {
			 fileName: "Reporte de Transparencia_"+full_date
		 };
		 //Libreria que realiza el exportar a Excel
		 Jhxlsx.export(tableData, options);

		} 

		try{
		}
		catch(error){
		console.log(error);
		}finally{                                
		//oading2.value = false;
		loader.value=false;
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
		fnCargarDatos,save,formatDate,
		parseDate,
		cabeceraTemp,
		fnExportar,
		busqueda,
		cuenta,
		password,
		show,
		loading,
		fnLogin,
		passwordShow
    }
  }
  
  
});
		</script>
		
    </body>
</html>