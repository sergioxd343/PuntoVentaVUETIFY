/* 
 * Copyright 2013 Emmanuel Espitia Rea <eespitia.rea@gmail.com>.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


function obtener(url) {
    var request = null;
    try {
        request = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject("Microsft,HMLHttp");
    } catch (e) {
        throw "Es necesario actualizar su navegador. Consulte a su equipo de soporte";
    }
    request.open("GET", url, false);
    request.send();
    try {
        return JSON.parse(request.responseText);
    }
    catch (e) {
        return eval('(' + request.responseText + ')');
    }
    return null;
}

function capitalize(string) {
    if (string.indexOf(" ") > -1) {
        var words = string.split(" "), stack = "";
        for (var i = 0; i < words.length; i++) {
            if (i === 0)
                stack += capitalize(words[i]);
            else
                stack += " " + capitalize(words[i]);
        }
        return stack;
    }
    else {
        if (string.indexOf("-") > -1) {
            var words = string.split("-"), stack = "";
            for (var i = 0; i < words.length; i++) {
                if (i === 0)
                    stack += capitalize(words[i]);
                else
                    stack += " " + capitalize(words[i]);
            }
            return stack;
        }
        else
            return string.charAt(0).toUpperCase() + string.slice(1);
    }
}

function on(target, event, function_) {
    if (target) {
        if (window.addEventListener)
            target.addEventListener(event, function_, false);
        else
            target.attachEvent("on" + event, function_);
    }
    else
        console.warn("Target not found!");
}

function get(descriptor) {
    switch (descriptor.charAt(0)) {
        case '#':
            return document.getElementById ? document.getElementById(descriptor.slice(1)) : null;
        case ':':
            return document.getElementsByName ? document.getElementsByName(descriptor.slice(1)) : null;
        case '.':
            return document.getElementsByClassName ? document.getElementsByClassName(descriptor.slice(1)) : null;
        default:
            return document.getElementsByTagName ? document.getElementsByTagName(descriptor) : null;
    }
}

function attr(element, name, value) {
    if (typeof value === "undefined")
        return element.getAttribute(name);
    else
        element.setAttribute(name, value);
}

function clear(element) {
    element.removeAttribute("class");
    element.removeAttribute("title");
    while (element.hasChildNodes())
        element.removeChild(element.lastChild);
}

function txt(element, text) {
    if (typeof text === "undefined")
        return element.childNodes[0].nodeValue;
    for (var i = 0; i < element.childNodes.length; i++) {
        if (element.childNodes[i].nodeType === 3)
            element.removeChild(element.childNodes[i]);
    }
    element.insertBefore(document.createTextNode(text), element.childNodes[0]);
}

function mk(descriptor) {
    if (descriptor.slice(0, descriptor.indexOf(":")) === "txt")
        return document.createTextNode(descriptor.slice(descriptor.indexOf(":") + 1));
    if (descriptor.indexOf(":") === -1)
        return document.createElement(descriptor);
    var element = document.createElement(descriptor.slice(0, descriptor.indexOf(":")));
    txt(element, descriptor.slice(descriptor.indexOf(":") + 1));
    return element;
}

function hover(element, attribute, invalue, outvalue) {
    on(element, "mouseover", function() {
        attr(element, attribute, invalue);
    });
    on(element, "mouseout", function() {
        attr(element, attribute, outvalue);
    });
}

function parseDate(strDate, format) {
    var date = new Date();
    if (typeof strDate === "undefined" && typeof format === "undefined")
        return date;
    if (strDate["dia"] && strDate["mes"] && strDate["anio"])
        return new Date((Number(strDate.mes) + 1) + "/" + strDate.dia + "/" + strDate.anio);
    switch (format) {
        case "ddmmaa":
            date.setDate(Number(strDate.split("/")[0]));
            date.setMonth(Number(strDate.split("/")[1]) - 1);
            date.setFullYear(Number("20" + strDate.split("/")[2]));
            break;
        case "mmddaa":
            date.setMonth(Number(strDate.split("/")[0]) - 1);
            date.setDate(Number(strDate.split("/")[1]));
            date.setFullYear(Number("20" + strDate.split("/")[2]));
            break;
        case "ddmmaaaa":
            date.setDate(Number(strDate.split("/")[0]));
            date.setMonth(Number(strDate.split("/")[1]) - 1);
            date.setFullYear(Number(strDate.split("/")[2]));
            break;
        case "mmddaaaa":
            date.setMonth(Number(strDate.split("/")[0]) - 1);
            date.setDate(Number(strDate.split("/")[1]));
            date.setFullYear(Number(strDate.split("/")[2]));
            break;
    }
    return date;
}

function stringifyDate(dateObj, format) {
    if (dateObj.getDate && dateObj.getMonth && dateObj.getFullYear) {
        if (typeof format === "undefined") {
            format = "mmddaa";
            console.log("Format parameter not present, default setup.");
        }
        switch (format) {
            case "mmddaa":
                return (dateObj.getMonth() < 9 ? "0" + (dateObj.getMonth() + 1) : dateObj.getMonth() + 1) + "/" + dateObj.getDate() + "/" + (dateObj.getFullYear() + "").slice(-2);
            case "ddmmaa":
                return dateObj.getDate() + "/" + (dateObj.getMonth() < 9 ? "0" + (dateObj.getMonth() + 1) : dateObj.getMonth() + 1) + "/" + (dateObj.getFullYear() + "").slice(-2);
            case "mmddaaaa":
                return (dateObj.getMonth() < 9 ? "0" + (dateObj.getMonth() + 1) : dateObj.getMonth() + 1) + "/" + dateObj.getDate() + "/" + dateObj.getFullYear();
            case "ddmmaaaa":
                return dateObj.getDate() + "/" + (dateObj.getMonth() < 9 ? "0" + (dateObj.getMonth() + 1) : dateObj.getMonth() + 1) + "/" + dateObj.getFullYear();
        }
    }
    return null;
}

function firstDayWeekday(dateObj) {
    return (new Date((dateObj.getMonth() + 1) + "/01/" + dateObj.getFullYear())).getDay();
}

function days(dateObj) {
    var temp = new Date();
    temp.setMonth(dateObj.getMonth() + 1);
    temp.setDate(0);
    return temp.getDate();
}

function getStatus(dateObj) {
    if (esVisita(dateObj).length > 0)
        return mof.global.estados[(esVisita(dateObj)[0])["status"]];
    if (esInhabil(dateObj))
        return "inhabil";
    if (dateObj.getDay() === 0 || dateObj.getDay() === 6)
        return "fin-semana";
    else
        return (esRegistrable(dateObj) ? "disponible" : "no-disponible");
}

function esRegistrable(dateObj) {
    if (!mof.global.periodos[dateObj.getFullYear() + ""])
        mof.global.periodos[dateObj.getFullYear() + ""] = obtener("PeriodosRegistro.jsp?anio=" + mof.fecha.getFullYear());
    var periodos = mof.global.periodos[dateObj.getFullYear() + ""];
    if (periodos.length === 0)
        return true;
    for (var i = 0; i < periodos.length; i++) {
        if (parseDate((periodos[i])["inicio"]) <= dateObj && parseDate((periodos[i])["fin"]) >= dateObj)
            return true;
    }
    return false;
}

function esInhabil(dateObj) {
    if (!mof.global.inhabiles[dateObj.getFullYear() + ""])
        mof.global.inhabiles[dateObj.getFullYear() + ""] = obtener("DiasInhabiles.jsp?anio=" + mof.fecha.getFullYear());
    var inhabiles = mof.global.inhabiles[dateObj.getFullYear() + ""];
    if (inhabiles.length === 0)
        return false;
    for (var i = 0; i < inhabiles.length; i++) {
        if (parseDate((inhabiles[i])["fecha_inicio"]) <= dateObj && parseDate((inhabiles[i])["fecha_fin"]) >= dateObj)
            return true;
    }
    return false;
}

function esVisita(dateObj) {
    if (!mof.global.visitas[dateObj.getFullYear() + ""])
        mof.global.visitas[dateObj.getFullYear() + ""] = obtener("SolicitudesVisita.jsp?anio=" + mof.fecha.getFullYear());
    var visitas = mof.global.visitas[dateObj.getFullYear() + ""], response = [];
    for (var i = 0; i < visitas.length; i++) {
        if (parseDate((visitas[i])["fecha_salida"]) <= dateObj && parseDate((visitas[i])["fecha_regreso"]) >= dateObj)
            response.push(visitas[i]);
    }
    return response;
}

function construyeVisita(visita) {
    var fieldset = mk("fieldset");
    fieldset.appendChild(mk("legend:" + capitalize(mof.global.estados[visita.status])));
    fieldset.appendChild(build("Solicitante", visita.solicitante, false));
    fieldset.appendChild(build("Empresas", visita.empresas, true));
    fieldset.appendChild(build("Grupos", visita.grupos, true));
    fieldset.appendChild(build("Alumnos", visita.cantidad_alumnos, false));
    var btnOk = mk("button:Detalles"), btnCancel = mk("button:Cancelar");
    on(btnOk, "click", function() {
        window.location = "../busquedas/catalogo_busqueda_solicitud_visita.jsp?yCve_solicitud_visita=" + visita.clave + "";
    });
    on(btnCancel, "click", function() {
        get("body")[0].removeChild(get("#blackscreen"));
    });
    fieldset.appendChild(btnOk);
    fieldset.appendChild(btnCancel);
    return fieldset;
}

function build(name, value, parsed) {
    var str = "";
    if (parsed)
        value = JSON.parse(value);
    if (!Number(value) && value.length > 0)
        for (var i = 0; i < value.length; i++)
            str += (i === 0 ? "" : ",") + value[i];
    else
        str = value;
    var div = mk("div"), name_ = mk("span:" + name), text = mk("span:" + str);
    attr(name_, "class", "label-name");
    attr(text, "class", "label-text");
    div.appendChild(name_);
    div.appendChild(text);
    return div;
}

function configurar(element) {
    var fecha = new Date((mof.mes() + 1) + "/" + txt(element) + "/" + mof.anio()), status = getStatus(fecha);
    if (element.childNodes.length > 1) {
        for (var i in element.childNodes)
            element.childNodes[i].nodeType === 1 && element.removeChild(element.childNodes[i]);
    }
    attr(element, "class", status);
    attr(element, "title", capitalize(status));
    var dep, indexes = [];
    if ((dep = esVisita(fecha)).length > 0) {
        for (var i = 0; i < dep.length; i++) {
            if (!mof.temp[(dep[i])["clave"]])
                mof.temp[(dep[i])["clave"]] = dep[i];
            indexes.push((dep[i])["clave"]);
        }
        var countbox = mk("div:" + dep.length);
        attr(countbox, "class", "countbox");
        attr(countbox, "data-i", indexes);
        on(countbox, "click", function() {
            if (get("#perfil").value === "on") {
                var data = eval("([" + attr(countbox, "data-i") + "])");
                var bs = mk("div:txt");
                attr(bs, "id", "blackscreen");
                var infobox = mk("div");
                attr(infobox, "class", "infobox");
                for (var i in data)
                    infobox.appendChild(construyeVisita(mof.temp[data[i]]));
                bs.appendChild(infobox);
                get("body")[0].appendChild(bs);
            }
            else
                {
                window.location = "../solicitud_visita/proceso_solicitud_visita.jsp?yFechaSalida='" + fecha.getDay() + "-" + (fecha.getMonth() + 1) + "-" + fecha.getFullYear() + "'";
                }
        });
        element.appendChild(countbox);
    }
    else {
        element.addEventListener("click", function() {
            window.location = "../solicitud_visita/proceso_solicitud_visita.jsp?yFechaSalida='" + fecha.getDay() + "-" + (fecha.getMonth() + 1) + "-" + fecha.getFullYear() + "'";
        }, true);
    }
}

var mof = {
    global: {
        dias: ["domingo", "lunes", "martes", "miércoles", "jueves", "viernes", "sábado"],
        estados: ["disponible", "pendiente", "solicitada", "autorizada", "rechazada", "gestion-terminada", "realizada", "cancelada"],
        meses: ["enero", "febrero", "marzo", "abril", "mayo", "junio", "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre"],
        visitas: {},
        inhabiles: {},
        periodos: {}
    },
    temp: {
    },
    fecha: new Date(),
    dia: function(args) {
        if (typeof args === "undefined")
            return this.fecha.getDate();
        Number(args) && (function() {
            this.fecha.setDate(Number(args));
            return true;
        })();
        switch (args) {
            case "++":
                this.fecha.setDate(this.dia() + 1);
                return true;
            case "--":
                this.fecha.setDate(this.dia() - 1);
                return true;

        }
        return false;
    },
    mes: function(args) {
        if (typeof args === "undefined")
            return this.fecha.getMonth();
        Number(args) && (function() {
            this.fecha.setMonth(Number(args));
            return true;
        })();
        switch (args) {
            case "++":
                this.fecha.setMonth(this.mes() + 1);
                return true;
            case "--":
                this.fecha.setMonth(this.mes() - 1);
                return true;
        }
        return false;
    },
    anio: function(args) {
        if (typeof args === "undefined")
            return this.fecha.getFullYear();
        Number(args) && (function() {
            this.fecha.setFullYear(Number(args));
            return true;
        })();
        switch (args) {
            case "++":
                this.fecha.setFullYear(this.anio() + 1);
                return true;
            case "--":
                this.fecha.setFullYear(this.anio() - 1);
                return true;

        }
        return false;
    },
    stringify: function(format) {
        return stringifyDate(this.fecha, format);
    },
    firstday: function() {
        return firstDayWeekday(this.fecha);
    },
    monthDays: function() {
        return days(this.fecha);
    },
    bind: function() {
        on(get("#dpp"), "click", function() {
            mof.dia("++");
            mof.print();
        });
        on(get("#dmm"), "click", function() {
            mof.dia("--");
            mof.print();
        });
        on(get("#mpp"), "click", function() {
            mof.mes("++");
            mof.print();
        });
        on(get("#mmm"), "click", function() {
            mof.mes("--");
            mof.print();
        });
        on(get("#app"), "click", function() {
            mof.anio("++");
            mof.print();
        });
        on(get("#amm"), "click", function() {
            mof.anio("--");
            mof.print();
        });
    },
    print: function() {
        get("#mc") && (function() {
            txt(get("#mc"), capitalize(mof.global.meses[mof.fecha.getMonth()]));
        })();
        get("#yc") && (function() {
            txt(get("#yc"), mof.fecha.getFullYear());
        })();
        var index = mof.firstday();
        for (var i = 0; i < mof.firstday(); i++)
            clear(get("td")[i]);
        for (var i = 1; i <= mof.monthDays(); i++) {
            txt(get("td")[index], i, true);
            configurar(get("td")[index]);
            index++;
        }
        for (var i = index; i < get("td").length; i++)
            clear(get("td")[i]);
    }
};