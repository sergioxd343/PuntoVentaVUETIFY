/*
 *  Alert Bootstrap
 *  (c) 2014, DxnyeL Sp.
 *  04-04-2014
 */



//<![CDATA[
// Definir lista de extensiones y el tipo de fichero de audio asociado. Puedes añadir más
jQuery.v_valid_b = true;
jQuery.v_valid_msj = "";

jQuery.v_valid_start = function ()
{
    $.v_valid_msj = "<ul>";
    $.v_valid_b = true;
};

jQuery.v_valid_end = function ()
{
    $.v_valid_msj += "</ul>";
    if ($.v_valid_b === false)
        Walert({msg: $.v_valid_msj, tipo: "5"})
    return $.v_valid_b;
};

(function ($) {

    var msj = "";

    var methods = {
        init: function (opciones_user) {
            var opciones_default = {
                msg: "no paso nada",
                tipo: 1, //Disponibles: los que acepte bootstrap      
            }
            var opciones = $.extend(opciones_default, opciones_user);
//            alert("init metod")
        },
		mensaje: function (opciones_user) {
            var opciones_default = {
                min: 1,
                max: 100, //Disponibles: los que acepte bootstrap      
				msg:'',
            }
            var opciones = $.extend(opciones_default, opciones_user);

            if (this.val().length > opciones.max || this.val().length < opciones.min) {
                this.addClass("error_valid");
                $.v_valid_msj += "<li>" + opciones.msg + this.attr("title") + "</li>";
                $.v_valid_b = $.v_valid_b && false;
            } else {
                this.removeClass("error_valid")
                $.v_valid_b = $.v_valid_b && true;
            }

            this.focus(function () {
                $(this).removeClass("error_valid")
            })

            return this;
        },
        length: function (opciones_user) {
            var opciones_default = {
                min: 1,
                max: 100, //Disponibles: los que acepte bootstrap      
            }
            var opciones = $.extend(opciones_default, opciones_user);

            if (this.val().length > opciones.max || this.val().length < opciones.min) {
                this.addClass("error_valid");
                $.v_valid_msj += "<li>Los caracteres de " + this.attr("title") + " deben ser mínimo " + opciones.min + " y máximo " + opciones.max + "</li>";
                $.v_valid_b = $.v_valid_b && false;
            } else {
                this.removeClass("error_valid")
                $.v_valid_b = $.v_valid_b && true;
            }

            this.focus(function () {
                $(this).removeClass("error_valid")
            })

            return this;
        },
        valorNumerico: function (opciones_user) {
            var opciones_default = {
                min: 1,
                max: 100, //Disponibles: los que acepte bootstrap      
            }
            var opciones = $.extend(opciones_default, opciones_user);

            if (this.val() < opciones.min || this.val() > opciones.max) {
                this.addClass("error_valid");
                $.v_valid_msj += "<li>El valor de <b>" + this.attr("title") + "</b> deben ser mayor o igual a " + opciones.min + " y menor o igual a " + opciones.max + "</li>";
                $.v_valid_b = $.v_valid_b && false;
            } else {
                this.removeClass("error_valid")
                $.v_valid_b = $.v_valid_b && true;
            }

            this.focus(function () {
                $(this).removeClass("error_valid")
            })

            return this;
        },
        espacios: function ()
        {
            var regexp = /\s+/;
            if ((regexp.test(this.val())))
            {
                this.addClass("error_valid");
                $.v_valid_msj += "<li>El Campo " + this.attr("title") + " tiene espacios</li>";
                $.v_valid_b = $.v_valid_b && false;
            } else
            {
                this.removeClass("error_valid")
                $.v_valid_b = $.v_valid_b && true;
            }
            return this;
        },
        select: function ()
        {
            if ($(this).is("select")) {

                if (this.find('option:selected').val() === '')
                {
                    this.addClass("error_valid");
                    $.v_valid_msj += "<li>Debes seleccionar una opción del campo " + this.attr("title") + "</li>";
                    $.v_valid_b = $.v_valid_b && false;
                } else {
                    this.removeClass("error_valid")
                    $.v_valid_b = $.v_valid_b && true;
                }

                this.change(function () {
                    $(this).removeClass("error_valid")
                })

            } else {
                alert("no es de tipo Select el elemento...")
            }


            return this;
        },
        radio: function ()
        {


            $.v_valid_b = false;
            this.each(function () {

                if ($(this).is(":checked"))
                {
                    console.log("checado")
                    $(this).removeClass("error_valid")
                    $.v_valid_b = true;
                }

            })//fin each

            console.log($.v_valid_b)
            if ($.v_valid_b === false)
            {
                $(this).addClass("error_valid");
                $.v_valid_msj += "<li>Debe Seleccionar una opcion de los radios</li>";

            }

            return this;
        },
        checkbox: function ()
        {
            this.each(function () {

                if ($(this).is(":checked"))
                {
                    $(this).addClass("error_valid");
                    $.v_valid_msj += "<li>Debe Seleccionar una opcion de los checkbox</li>";
                    $.v_valid_b = $.v_valid_b && false;
                } else {
                    $(this).removeClass("error_valid")
                    $.v_valid_b = $.v_valid_b && true;
                }

            })

            return this;
        },
        regexp: function (opciones_user)
        {
            var opciones_default = {expresion: "", msj_error: "no es validado"}
            var opciones = $.extend(opciones_default, opciones_user);

            var regexp = "";
            if (opciones.expresion === 'decimales') {
                regexp = /^(\d|-)?(\d|,)*\.?\d*$/;
            }
            if (opciones.expresion === 'correo') {
                regexp = /^[\w-\.]{3,}@([\w-]{2,}\.)*([\w-]{2,}\.)[\w-]{2,4}$/;
            } else if (opciones.expresion === 'fecha')
                regexp = /^(19|20)\d{2}[\-](0?[1-9]|1[012])[\-](0?[1-9]|[12][0-9]|3[01])$/;
            else if (opciones.expresion === 'LMMANE')//letras minusculas mayusculas acentos numeros espacios
                regexp = /^[a-zA-Z áéíóúÁÉÍÓÚÑñ 0-9 - ¿?,.": \n \t  \- \% /!¡() @#$""]+$/;
            else if (opciones.expresion === 'LMMN')//letras minusculas mayusculas numeros
                regexp = /^[a-zA-Z 0-9 ¿?,."/!¡() @#""]+$/;
            else if (opciones.expresion === 'password')
                regexp = /^[@#$ %^&!*ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890]+$/;
            else if (opciones.expresion === 'CCT')
                regexp = /^[@#$ %^&!*ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890]+$/;
            else if (opciones.expresion === 'LMMAE')//letras minusculas mayusculas acentos  espacios
                regexp = /^[a-zA-Z áéíóúÁÉÍÓÚÑñ -¿?,."/!¡()]+$/;
            else if (opciones.expresion === 'LMMA')//letras minusculas mayusculas acentos
                regexp = /^[a-zA-ZáéíóúAÉÍÓÚÑñ -¿?,."!¡()]+$/;
            else if (opciones.expresion === 'URL')
                regexp = /^(ht|f)tp(s?)\:\/\/[0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*(:(0-9)*)*(\/?)( [a-zA-Z0-9\-\.\?\,\'\/\\\+&%\$#_]*)?$/;
            else if (opciones.expresion === 'numeroEntero')
                regexp = /^[0123456789]+$/;
            else if (opciones.expresion === 'numeroReal')
                regexp = /^-{0,1}[0-9]+[.]{0,1}[0-9]*$/;
            else if (opciones.expresion === 'rfc')
                regexp = /^[a-zA-Z]{3,4}(\d{6})((\D|\d){3})?$/;
            else if (opciones.expresion === 'url')
                regexp = /^(ht|f)tps?:\/\/\w+([\.\-\w]+)?\.([a-z]{2,4}|travel)(:\d{2,5})?(\/.*)?$/i
            else if (opciones.expresion === 'hora')
                regexp = /^(0[1-9]|1\d|2[0-3]):([0-5]\d)$/
            else if (opciones.expresion === 'medioElectronico')
                regexp = /^(ht|f)tps?:\/\/\w+([\.\-\w]+)?\.([a-z]{2,4}|travel)(:\d{2,5})?(\/.*)? [0-9a-z_\-\.]+@([a-z0-9\-]+\.?)*[a-z0-9]+\.([a-z]{2,4}|travel)$/i;

            if (!(regexp.test(this.val()))) {
                this.addClass("error_valid");
                $.v_valid_msj += "<li> El valor del campo " + this.attr("title") + " " + opciones.msj_error + "</li>";
                $.v_valid_b = $.v_valid_b && false;
            } else {
                this.removeClass("error_valid");
                $.v_valid_b = $.v_valid_b && true;
            }

            return this;

        }
    }

    $.fn.extend({v_valid: function (method) {
            if (methods[method])
            {
                return methods[method].apply(this, Array.prototype.slice.call(arguments, 1))
            } else if (typeof method === 'object' || !method) {
                return methods.init.apply(this, arguments);
            } else {
                $.error('La función ' + method
                        + ' no existe en jQuery.tooltip');
            }
        }});
})(jQuery);






