// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require jquery_nested_form
//= require datatables
//= require_tree .

function EsLetra(Txt) {//Funcion que retora true si solo hay letras ingresadas y false cuando son otros caracteres
    var regex_letras = /^[a-zA-ZáÁéÉíÍóÓúÚñÑüÜ\s]+$/;
    if ((regex_letras).exec(Txt)) {
        return true;
    } else {
        return false;
    }
}

function isValidEmailAddress(emailAddress) {
    var pattern = /^([a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+(\.[a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+)*|"((([ \t]*\r\n)?[ \t]+)?([\x01-\x08\x0b\x0c\x0e-\x1f\x7f\x21\x23-\x5b\x5d-\x7e\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|\\[\x01-\x09\x0b\x0c\x0d-\x7f\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))*(([ \t]*\r\n)?[ \t]+)?")@(([a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.)+([a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.?$/i;
    return pattern.test(emailAddress);
}

function ValidacionCampo(Cadena) {//Funcion para validar una cadena de caracteres
    if (Cadena.value != "" && Cadena.length != 0 && Cadena != null) {//Caso en que la cadena es distinto de vacio
        if (EsLetra(Cadena)) {//Cuando la cadena contiene solo caracteres de letras
            return true;
        }
        else {//Posee un caracter que no sea letra
            return false;
        }
    }
    else {//Caso de cadena vacia
        return false;
    }
}

function validarSiNumero(numero){
    if(numero.value != "" && numero.length != 0 && numero != null){
        if (!/^([0-9])*$/.test(numero))
            return false;
        else
            return true;
    }
    else{
        return false;
    }

}

$(document).on('turbolinks:load', function() {

    $('form').on('click', '.remove_record', function(event) {
        $(this).prev('input[type=hidden]').val('1');
        $(this).closest('tr').hide();
        return event.preventDefault();
    });

    $('form').on('click', '.add_fields', function(event) {
        var regexp, time;
        time = new Date().getTime();
        regexp = new RegExp($(this).data('id'), 'g');
        $('.fields').append($(this).data('fields').replace(regexp, time));
        return event.preventDefault();
    });

    $("table[role='datatable']").each(function(){
        $(this).DataTable({
            "bStateSave": true,
            "processing": true,
            "language":
                {
                    "emptyTable": "No existen campos para Feriados",
                    "zeroRecords": "No existen registros que cumplan el criterio de búsqueda",
                    "processing": "Buscando registros...",
                    "search": "Buscar:",
                    "lengthMenu": "Mostrar _MENU_ registros",
                    "info": "Registros del _START_ al _END_ de un total de _TOTAL_",
                    "paginate": {
                        "first": "Primero",
                        "last": "Último",
                        "next": "Siguiente",
                        "previous": "Anterior"
                    }
                },
        });
    });

    $("table[id='datatable']").each(function(){
        $(this).DataTable({
            "bStateSave": true,
            "processing": true,
            "language":
                {
                    "emptyTable": "No existen campos para Feriados",
                    "zeroRecords": "No existen registros que cumplan el criterio de búsqueda",
                    "processing": "Buscando registros...",
                    "search": "Buscar:",
                    "lengthMenu": "Mostrar _MENU_ registros",
                    "info": "Registros del _START_ al _END_ de un total de _TOTAL_",
                    "paginate": {
                        "first": "Primero",
                        "last": "Último",
                        "next": "Siguiente",
                        "previous": "Anterior"
                    }
                },
            columnDefs: [
                { type: 'date-uk', targets: 2 }
            ]
        });
    });


    jQuery.extend( jQuery.fn.dataTableExt.oSort, {
        "date-uk-pre": function ( a ) {
            if (a == null || a == "") {
                return 0;
            }
            var ukDatea = a.split('/');
            return (ukDatea[2] + ukDatea[1] + ukDatea[0]) * 1;
        },

        "date-uk-asc": function ( a, b ) {
            return ((a < b) ? -1 : ((a > b) ? 1 : 0));
        },

        "date-uk-desc": function ( a, b ) {
            return ((a < b) ? 1 : ((a > b) ? -1 : 0));
        }
    } );




    //Funciones para validaciones de usuario
    $("#Nombre").focusout(function(){
       var campo = $("#Nombre").val().trim();
       if(!ValidacionCampo(campo)){
           $("#Nombre").attr("class", "form-control is-invalid");
           $("#ErrorNombre").html("Campo Erróneo");
           $("#Nombre").val("");
       }
       else{
           $("#Nombre").attr("class", "form-control");
           $("#ErrorNombre").html("");
       }
    });

    $("#Apellidos").focusout(function(){
        var campo = $("#Apellidos").val().trim();
        if(!ValidacionCampo(campo)){
            $("#Apellidos").attr("class", "form-control is-invalid");
            $("#ErrorApellido").html("Campo Erróneo");
            $("#Apellidos").val("");
        }
        else{
            $("#Apellidos").attr("class", "form-control");
            $("#ErrorApellido").html("");
        }
    });

    $("#Rut").focusout(function(){
        var campo = $("#Rut").val().trim();
        if(campo.length == 0){
            $("#Rut").attr("class", "form-control is-invalid");
            $("#ErrorRut").html("Ingrese Rut");
            $("#Rut").val("");
        }
        else{
            $("#Rut").attr("class", "form-control");
            $("#ErrorRut").html("");
        }
    });

    $("#Fono").focusout(function(){
        var campo = $("#Fono").val().trim();
        if(!validarSiNumero(campo)){
            $("#Fono").attr("class", "form-control is-invalid");
            $("#ErrorFono").html("Campo Erróneo");
            $("#Fono").val("");
        }
        else{
            $("#Fono").attr("class", "form-control");
            $("#ErrorFono").html("");
        }
    });

    $("#Domicilio").focusout(function(){
        var campo = $("#Domicilio").val().trim();
        if(campo.length == 0){
            $("#Domicilio").attr("class", "form-control is-invalid");
            $("#ErrorDomicilio").html("Ingrese Domicilio");
            $("#Domicilio").val("");
        }
        else{
            $("#Domicilio").attr("class", "form-control");
            $("#ErrorDomicilio").html("");
        }
    });

    $("#Correo").focusout(function(){
        var campo = $("#Correo").val().trim();
        if (!isValidEmailAddress(campo)) {//Validacion del correo
            $("#Correo").attr("class", "form-control is-invalid");
            $("#Correo").val("");
            $("#ErrorCorreo").html("Error de formato en correo");
        }
        else {
            $("#Correo").attr("class", "form-control");
            $("#ErrorCorreo").html("");
        }
    });

    //Validacion para la Creacion/Edicion de los Tipos

    $("#Tipo").focusout(function(){
        var campo = $("#Tipo").val().trim();
        if(!ValidacionCampo(campo)){
            $("#Tipo").attr("class", "form-control is-invalid");
            $("#ErrorTipo").html("Campo Erróneo");
            $("#Tipo").val("");
        }
        else{
            $("#Tipo").attr("class", "form-control");
            $("#ErrorTipo").html("");
        }
    });

    //Validacion para la Creacion/Edicion de Productos
    $("#NombreProd").focusout(function(){
        var campo = $("#NombreProd").val().trim();
        if(!ValidacionCampo(campo)){
            $("#NombreProd").attr("class", "form-control is-invalid");
            $("#ErrorNombreProd").html("Campo Erróneo");
            $("#NombreProd").val("");
        }
        else{
            $("#NombreProd").attr("class", "form-control");
            $("#ErrorNombreProd").html("");
        }
    });

    $("#Precio").focusout(function(){
        var campo = $("#Precio").val().trim();
        if(!validarSiNumero(campo)){
            $("#Precio").attr("class", "form-control is-invalid");
            $("#ErrorPrecio").html("Campo Erróneo");
            $("#Precio").val("");
        }
        else{
            $("#Precio").attr("class", "form-control");
            $("#ErrorPrecio").html("");
        }
    });

    $("#Stock").focusout(function(){
        var campo = $("#Stock").val().trim();
        if(!validarSiNumero(campo)){
            $("#Stock").attr("class", "form-control is-invalid");
            $("#ErrorStock").html("Campo Erróneo");
            $("#Stock").val("");
        }
        else{
            $("#Stock").attr("class", "form-control");
            $("#ErrorStock").html("");
        }
    });



});