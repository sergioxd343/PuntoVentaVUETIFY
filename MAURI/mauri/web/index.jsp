<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900" rel="stylesheet" />
        <link href="styles/icon_material_design_4495/css/materialdesignicons.min.css" rel="stylesheet" />
        <link href="javascript/VueJs/sweetalert2/sweetalert2.css" />
        <link href="javascript/VueJs/vuetify/vuetify.min.css" rel="stylesheet" />
        <meta name="viewport"
            content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui" />
        <script src="javascript/VueJs/vue/vue.js"></script>
        <script type="" src="javascript/VueJs/vue/vue-composition-api.prod.js"></script>
        <title>MAURI</title>
</head>
<body>
    <div id="contenedor"></div>
    <button onclick="cargarModulo();">Hola</button>
</body>
<script>
    function cargarModulo(){
        fetch("jsp/catalogo_innovacion_educativa/catalogo_solicitud_proyecto.jsp")
            .then(
                    function (response) {
                        return response.text();
                    }
            )
            .then(
                    function (html) {
                        document.getElementById("contenedor").innerHTML = html;
                    }
            );
    }
</script>
</html>