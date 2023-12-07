/*
 *  Alert Bootstrap
 *  (c) 2014, DxnyeL Sp.
 *  04-04-2014
 */



//<![CDATA[
// Definir lista de extensiones y el tipo de fichero de audio asociado. Puedes añadir más


(function ($, w, undefined) {
    //Variables globales
    var cronometro, wdoc = w.top.document;

    //Mensaje del sistema
    var Walert = function (opciones_user) {






        var opciones_default = {
            msg: "",
            tipo: 1, //Disponibles: los que acepte bootstrap
            tiempo: 5,
            bold: true,
            ubica: "t-der" //Disponibles: b-izq, b-der, t-izq y t-der

        }
        var opciones = $.extend(opciones_default, opciones_user);

        //Crear control si no existe
        if (!$("#_Growlbt_div").length)
        {
            var hojaCss = wdoc.createElement("style");
            var capaMsg = wdoc.createElement("div");
            var css = "#_Growlbt_div{" +
                    "z-index: 1100;" +
                    "position: fixed;" +
                    "display: none;" +
//                                        "opacity: 0.8!important;" +
                    "}" +
//                                        "#_Growlbt_div:hover{" +
//                                        "box-shadow: 1px 1px 10px 2px #BEBEBE;" +
//                                        "opacity: 1!important;" +
//					"}" +

                    "#_Growlbt_div > div{" +
                    "display: table;" +
                    "}" +
                    "#_Growlbt_div > div > div{" +
                    "display: table-row;" +
                    "}" +
                    "#_Growlbt_div > div > div > *{" +
                    "display: table-cell;" +
                    "padding-left:5px;" +
                    "vertical-align:middle;" +
                    "}" +
                    "#_Growlbt_div.b-izq{" +
                    "left: 15px;" +
                    "bottom: 15px;" +
                    "}" +
                    "#_Growlbt_div.b-der{" +
                    "right: 15px;" +
                    "bottom: 15px;" +
                    "}" +
                    "#_Growlbt_div.t-izq{" +
                    "left: 15px;" +
                    "top: 15px;" +
                    "}" +
                    "#_Growlbt_div.t-der{" +
                    "right: 50px;" +
                    "top: 60px;" +
                    "}";

//                                        ".icono{"+
//                                        "font-size:150%;"+
//                                        "opacity: .9!important;"+
//                                        "}"+


            hojaCss.innerHTML = css;
            capaMsg.id = "_Growlbt_div";
            // wdoc.body.appendChild(hojaCss);
            // wdoc.body.appendChild(capaMsg);
			// alert($("#puto_m").text())
			$("#msj_v_valid").append(hojaCss)
			$("#msj_v_valid").append(capaMsg)

        }



        //Mostrar si esta invisible
        if (!$("#_Growlbt_div").is(":visible"))
        {
            $("#_Growlbt_div").slideDown(700);
            cronometro = setTimeout(function () {
                cerrar();
            }, opciones.tiempo * 1000);
        }
        else
        {
            clearTimeout(cronometro);
            $("#_Growlbt_div").hide().fadeIn(500);
            cronometro = setTimeout(function () {
                cerrar();
            }, opciones.tiempo * 1000);
        }

        $("#_Growlbt_div").removeClass().addClass(opciones.ubica);


        var msj = opciones.msg;
        if (opciones.msg === "G" && parseInt(opciones.tipo) === 1) {
            msj = "El registro se ha guardado de forma correcta."
        }
        if (opciones.msg === "M" && parseInt(opciones.tipo) === 1) {
            msj = "El registro se ha modificado de forma correcta."
        }
        if (opciones.msg === "E" && parseInt(opciones.tipo) === 1) {
            msj = "El registro se ha eliminado de forma correcta."
        }

        if (opciones.msg === "G" && parseInt(opciones.tipo) === 0) {
            msj = "El registro no se pudo guardar de forma correcta."
        }
        if (opciones.msg === "M" && parseInt(opciones.tipo) === 0) {
            msj = "El registro no se pudo modificar de forma correcta."
        }
        if (opciones.msg === "E" && parseInt(opciones.tipo) === 0) {
            msj = "El registro no se pudo modificar de forma correcta."
        }

        if (opciones.msg === "S") {
            msj = "Seleccione un registro del listado."
        }
        

        if (parseInt(opciones.tipo)===0)

        
        $("#_Growlbt_div").removeClass("alert-danger");
        $("#_Growlbt_div").removeClass("alert-success");
        $("#_Growlbt_div").removeClass("alert-info");
        $("#_Growlbt_div").removeClass("alert-warning");
        $("#_Growlbt_div").removeClass("alert-danger");
        
        if (parseInt(opciones.tipo)===0)

            $("#_Growlbt_div").addClass("alert alert-danger").html("<div> <div><i class='glyphicon glyphicon-remove icono'></i> <strong>" + msj + "</strong></div> </div>");
        else if (parseInt(opciones.tipo)===1)
            $("#_Growlbt_div").addClass("alert alert-success").html("<div> <div><i class='glyphicon glyphicon-ok icono'></i> <strong>" + msj + "</strong></div> </div>");
        else if (parseInt(opciones.tipo)===2)
            $("#_Growlbt_div").addClass("alert alert-info").html("<div> <div><i class='glyphicon glyphicon-info-sign icono animated'></i> <strong>" + msj + "</strong></div> </div>");
        else if (parseInt(opciones.tipo)===3)
            $("#_Growlbt_div").addClass("alert alert-warning").html("<div> <div><i class='glyphicon glyphicon-warning-sign icono animated '></i> <strong>" + msj + "</strong></div> </div>");
        else if (parseInt(opciones.tipo)===5)
            $("#_Growlbt_div").addClass("alert alert-danger").html("<div> <div><strong>" + msj + "</strong></div> </div>");

//                $("#_Growlbt_div > div > div").append("<span class='glyphicon glyphicon-remove'></span>").find('span').click(function(){cerrar()}).css('cursor','pointer');
//                $("#_Growlbt_div > div > div").find('i').addClass("bounce")

        $("#_Growlbt_div > div > div").click(function () {
            cerrar()
        })



        function cerrar()
        {
            clearTimeout(cronometro);
            $("#_Growlbt_div").slideUp(700);            
        }
    }

    //Declaramos el objeto global
    $.Walert = w.Walert = Walert;
})(jQuery, window);