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

function validarSiNumeroPrecio(numero){
    if(numero.value != "" && numero.length != 0 && numero != null){
        var regex_numeros =  /^\d{2,5}$/;
        if ((regex_numeros).exec(numero))
            return true;
        else
            return false;
    }
    else{
        return false;
    }
}

function validarSiNumero(numero){
    if(numero.value != "" && numero.length != 0 && numero != null){
        var regex_numeros =  /^\d{8,10}$/;
        if ((regex_numeros).exec(numero))
            return true;
        else
            return false;
    }
    else{
        return false;
    }
}

function validaRut(campo){
    if ( campo.length == 0 ){ return false; }
    if ( campo.length < 8 ){ return false; }

    campo = campo.replace('-','')
    campo = campo.replace(/\./g,'')

    var suma = 0;
    var caracteres = "1234567890kK";
    var contador = 0;
    for (var i=0; i < campo.length; i++){
        u = campo.substring(i, i + 1);
        if (caracteres.indexOf(u) != -1)
            contador ++;
    }
    if ( contador==0 ) { return false }

    var rut = campo.substring(0,campo.length-1)
    var drut = campo.substring( campo.length-1 )
    var dvr = '0';
    var mul = 2;

    for (i= rut.length -1 ; i >= 0; i--) {
        suma = suma + rut.charAt(i) * mul
        if (mul == 7) 	mul = 2
        else	mul++
    }
    res = suma % 11
    if (res==1)		dvr = 'k'
    else if (res==0) dvr = '0'
    else {
        dvi = 11-res
        dvr = dvi + ""
    }
    if ( dvr != drut.toLowerCase() ) { return false; }
    else { return true; }
}

$(document).on('turbolinks:load', function() {
    $("#Enviar").attr("disabled", true);
    $('form').on('click', '.remove_record', function(event) {
        $(this).prev('input[type=hidden]').val('1');
        $(this).closest('tr').remove();
        return event.preventDefault();
    });

    $(document).on('click', '.borrar', function (event) {
        $(this).closest('tr').remove();
        var nFilas = $("#cart tr").length;
        if(nFilas == 1){
            $("#Enviar").attr("disabled", true);
        }
        else{
            $("#Enviar").attr("disabled", false)
        }
    });

    $("#AgregarProd").click(function(){

        $("#Enviar").attr("disabled", false);
    });

    $("#Contador").click(function(){
        var nFilas = $("#cart tr").length;
        console.log(nFilas);
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
                    "emptyTable": "No existen datos para esos filtros",
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
                    "emptyTable": "No existen datos para esos filtros",
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
    var ValidNombre = false;
    var ValidApellido = false;
    var ValidacionRut = false;
    var ValidFono = false;
    var ValidDomicilio = false;
    var ValidCorreo = false;
    var ValPass1 = true;
    var ValPass2 = true;

    function ActivarBtnUsuario(){
        if(ValidNombre && ValidApellido && ValidacionRut && ValidFono && ValidDomicilio && ValidCorreo && ValPass1 && ValPass2){
            $('#BtnUsuario').prop('disabled', false);
        }
        else{
            $('#BtnUsuario').prop('disabled', true);
        }
    }

    function ValidarSistemaUsr(){
        var nombre =  $("#Nombre").val().trim();
        var apellidos = $("#Apellidos").val().trim();
        var rut = $("#Rut").val().trim();
        var fono = $("#Fono").val().trim();
        var domicilio = $("#Domicilio").val().trim();
        var correo = $("#Correo").val().trim();
        //validacion del nombre
        if(!ValidacionCampo(nombre)){
            ValidNombre = false;
        }
        else{
            ValidNombre = true;
        }
        //validacion del apellido
        if(!ValidacionCampo(apellidos)){
            ValidApellido = false;
        }
        else{
            ValidApellido = true;
        }
        //validacion del rut
        rut = rut.replace(".","");
        if(rut.length == 0){
            ValidacionRut = false;
        }
        else{
            if(rut.indexOf('-')==-1){
                ValidacionRut = false;
            }
            else{
                if(!validaRut(rut)){
                    ValidacionRut = false;
                }
                else{
                    ValidacionRut = true;
                }
            }

        }
        //validacion del fono
        if(!validarSiNumero(fono)){
            ValidFono = false;
        }
        else{
            ValidFono = true;
        }
        //validacion del domicilio
        if(domicilio.length == 0){
            ValidDomicilio = false;
        }
        else{
            if(domicilio.indexOf('0') == -1 && domicilio.indexOf('1') == -1 && domicilio.indexOf('2') == -1 && domicilio.indexOf('3') == -1 && domicilio.indexOf('4') == -1 && domicilio.indexOf('5') == -1 && domicilio.indexOf('6') == -1 && domicilio.indexOf('7') == -1 && domicilio.indexOf('8') == -1 &&  domicilio.indexOf('9') == -1){
                ValidDomicilio = false;
            }
            else{
                ValidDomicilio = true;
            }
        }
        //validacion del correo
        if (!isValidEmailAddress(correo)) {//Validacion del correo
            ValidCorreo = false;
        }
        else {
            ValidCorreo = true;
        }
    }


    $("#Nombre").focusout(function(){
       var campo = $("#Nombre").val().trim();
       if(!ValidacionCampo(campo)){
           $("#Nombre").attr("class", "form-control is-invalid");
           $("#ErrorNombre").html("Campo Erróneo");
           $("#Nombre").val("");
           ValidNombre = false;
       }
       else{
           $("#Nombre").attr("class", "form-control");
           $("#ErrorNombre").html("");
           ValidNombre = true;
       }
        ValidarSistemaUsr();
       ActivarBtnUsuario();
    });

    $("#Apellidos").focusout(function(){
        var campo = $("#Apellidos").val().trim();
        if(!ValidacionCampo(campo)){
            $("#Apellidos").attr("class", "form-control is-invalid");
            $("#ErrorApellido").html("Campo Erróneo");
            $("#Apellidos").val("");
            ValidApellido = false;
        }
        else{
            $("#Apellidos").attr("class", "form-control");
            $("#ErrorApellido").html("");
            ValidApellido = true;
        }
        ValidarSistemaUsr();
        ActivarBtnUsuario();
    });

    $("#Rut").focusout(function(){
        var campo = $("#Rut").val().trim();
        campo = campo.replace(".","");
        if(campo.length == 0){
            $("#Rut").attr("class", "form-control is-invalid");
            $("#ErrorRut").html("Ingrese el Rut");
            $("#Rut").val("");
            ValidacionRut = false;
        }
        else{
            if(campo.indexOf('-')==-1){
                $("#Rut").attr("class", "form-control is-invalid");
                $("#ErrorRut").html("Ingrese guión");
                $("#Rut").val("");
                ValidacionRut = false;
            }
            else{
                if(!validaRut(campo)){
                    $("#Rut").attr("class", "form-control is-invalid");
                    $("#ErrorRut").html("Formato invalido de Rut");
                    $("#Rut").val("");
                    ValidacionRut = false;
                }
                else{
                    $("#Rut").attr("class", "form-control");
                    $("#ErrorRut").html("");
                    ValidacionRut = true;
                }
            }

        }
        ValidarSistemaUsr();
        ActivarBtnUsuario();
    });

    $("#Fono").focusout(function(){
        var campo = $("#Fono").val().trim();
        if(!validarSiNumero(campo)){
            $("#Fono").attr("class", "form-control is-invalid");
            $("#ErrorFono").html("Campo Erróneo");
            $("#Fono").val("");
            ValidFono = false;
        }
        else{
            $("#Fono").attr("class", "form-control");
            $("#ErrorFono").html("");
            ValidFono = true;
        }
        ValidarSistemaUsr();
        ActivarBtnUsuario();
    });

    $("#Domicilio").focusout(function(){
        var campo = $("#Domicilio").val().trim();
        if(campo.length == 0){
            $("#Domicilio").attr("class", "form-control is-invalid");
            $("#ErrorDomicilio").html("Ingrese Domicilio");
            $("#Domicilio").val("");
            ValidDomicilio = false;
        }
        else{
            if(campo.indexOf('0') == -1 && campo.indexOf('1') == -1 && campo.indexOf('2') == -1 && campo.indexOf('3') == -1 && campo.indexOf('4') == -1 && campo.indexOf('5') == -1 && campo.indexOf('6') == -1 && campo.indexOf('7') == -1 && campo.indexOf('8') == -1 && campo.indexOf('9') == -1){
                $("#Domicilio").attr("class", "form-control is-invalid");
                $("#ErrorDomicilio").html("Su domicilio debe tener un numero");
                $("#Domicilio").val("");
                ValidDomicilio = false;
            }
            else{
                $("#Domicilio").attr("class", "form-control");
                $("#ErrorDomicilio").html("");
                ValidDomicilio = true;
            }
        }
        ValidarSistemaUsr();
        ActivarBtnUsuario();
    });

    $("#Correo").focusout(function(){
        var campo = $("#Correo").val().trim();
        if (!isValidEmailAddress(campo)) {//Validacion del correo
            $("#Correo").attr("class", "form-control is-invalid");
            $("#Correo").val("");
            $("#ErrorCorreo").html("Error de formato en correo");
            ValidCorreo = false;
        }
        else {
            $("#Correo").attr("class", "form-control");
            $("#ErrorCorreo").html("");
            ValidCorreo = true;
        }
        ValidarSistemaUsr();
        ActivarBtnUsuario();
    });



    //Validacion para la Creacion/Edicion de los Tipos
    $("#Tipo").focusout(function(){
        var campo = $("#Tipo").val().trim();
        if(!ValidacionCampo(campo)){
            $("#Tipo").attr("class", "form-control is-invalid");
            $("#ErrorTipo").html("Campo Erróneo");
            $("#Tipo").val("");
            $('#GuardarTipo').prop('disabled', true);
        }
        else{
            $("#Tipo").attr("class", "form-control");
            $("#ErrorTipo").html("");
            $('#GuardarTipo').prop('disabled', false);
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
        if(!validarSiNumeroPrecio(campo)){
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
        if(!validarSiNumeroPrecio(campo)){
            $("#Stock").attr("class", "form-control is-invalid");
            $("#ErrorStock").html("Campo Erróneo");
            $("#Stock").val("");
        }
        else{
            $("#Stock").attr("class", "form-control");
            $("#ErrorStock").html("");
        }
    });

    $("#Pass1").focusout(function(){
        var campo1 = $("#Pass1").val();
        var campo2 = $("#Pass2").val();
        if(campo1.length == 0 && campo2.length == 0){
            $("#Pass1").attr("class", "form-control");
            $("#ErrorPass1").html("");
            $("#Pass2").attr("class", "form-control");
            $("#ErrorPass2").html("");
            ValPass1 = true;
            ValPass2 = true;
        }
        else{
            if(campo1.length != 0 && campo2.length !=0){
                if(campo1 == campo2){
                    $("#Pass1").attr("class", "form-control");
                    $("#ErrorPass1").html("");
                    ValPass1 = true;

                    $("#Pass2").attr("class", "form-control");
                    $("#ErrorPass2").html("");
                    ValPass2 = true;
                }
                else{
                    $("#Pass1").attr("class", "form-control is-invalid");
                    $("#ErrorPass1").html("Contraseñas no coinciden");
                    $("#Pass1").val("");
                    ValPass1 = false;

                    $("#Pass2").attr("class", "form-control is-invalid");
                    $("#ErrorPass2").html("Contraseñas no coinciden");
                    $("#Pass2").val("");
                    ValPass2 = false;
                }
            }
            else{
                if (campo1.length != 0 && campo2.length == 0){
                    $("#Pass2").attr("class", "form-control is-invalid");
                    $("#ErrorPass2").html("Debe confirmar contraseña");
                    $("#Pass2").val("");
                    ValPass2 = false;
                }
                else{
                    $("#Pass1").attr("class", "form-control is-invalid");
                    $("#ErrorPass1").html("Debe llenar ambos campos");
                    $("#Pass1").val("");
                    ValPass1 = false;

                    $("#Pass2").attr("class", "form-control is-invalid");
                    $("#ErrorPass2").html("Debe llenar ambos campos");
                    $("#Pass2").val("");
                    ValPass2 = false;
                }
            }
        }
        ActivarBtnUsuario();
    });

    $("#Pass2").focusout(function(){
        var campo1 = $("#Pass1").val();
        var campo2 = $("#Pass2").val();
        if(campo1.length == 0 && campo2.length == 0){
            $("#Pass1").attr("class", "form-control");
            $("#ErrorPass1").html("");
            $("#Pass2").attr("class", "form-control");
            $("#ErrorPass2").html("");
            ValPass1 = true;
            ValPass2 = true;
        }
        else{
            if(campo1.length != 0 && campo2.length !=0){
                if(campo1 == campo2){
                    $("#Pass1").attr("class", "form-control");
                    $("#ErrorPass1").html("");
                    ValPass1 = true;

                    $("#Pass2").attr("class", "form-control");
                    $("#ErrorPass2").html("");
                    ValPass2 = true;
                }
                else{
                    $("#Pass1").attr("class", "form-control is-invalid");
                    $("#ErrorPass1").html("Contraseñas no coinciden");
                    $("#Pass1").val("");
                    ValPass1 = false;

                    $("#Pass2").attr("class", "form-control is-invalid");
                    $("#ErrorPass2").html("Contraseñas no coinciden");
                    $("#Pass2").val("");
                    ValPass2 = false;
                }
            }
            else{
                if (campo1.length == 0 && campo2.length != 0){
                    $("#Pass1").attr("class", "form-control is-invalid");
                    $("#ErrorPass1").html("Debe confirmar contraseña");
                    $("#Pass1").val("");
                    ValPass1 = false;
                }
                else{
                    $("#Pass1").attr("class", "form-control is-invalid");
                    $("#ErrorPass1").html("Debe llenar ambos campos");
                    $("#Pass1").val("");
                    ValPass1 = false;

                    $("#Pass2").attr("class", "form-control is-invalid");
                    $("#ErrorPass2").html("Debe llenar ambos campos");
                    $("#Pass2").val("");
                    ValPass2 = false;
                }
            }
        }
        ActivarBtnUsuario();
    });



    //Funcion para el filtro de fecha
    var ValidFechaInicio = false;
    var ValidFechaTermino = false;

    function ActivarBtn(){
        console.log(ValidFechaInicio +" "+ ValidFechaTermino);
        if(ValidFechaInicio && ValidFechaTermino){
            $('#Filtrar').prop('disabled', false);
        }
        else{
            $('#Filtrar').prop('disabled', true);
        }
    }

    $("#FechaInicio").focusout(function () {//Funcion para controlar la fecha de inicio
        var FechaInicio = $("#FechaInicio").val().trim();//Captura del campo
        if (FechaInicio == "") {//Verificar si el campo esta vacio
            $("#FechaInicio").attr("class", "form-control is-invalid");
            $("#ErrorFechaInicio").html("Debe ingresar fecha de inicio");
            $("#FechaInicio").val("");
            ValidFechaInicio = false;
        }
        else {//Campo distinto de vacio
            var FechaTermino = $("#FechaTermino").val().trim();
            var FormatoFechaI = new Date(FechaInicio);
            var FormatoFechaT = new Date(FechaTermino);
            if(FormatoFechaT.length == 0 && FormatoFechaT == null){
                ValidFechaTermino = false;
                $("#FechaTermino").attr("class", "form-control is-invalid");
                $("#ErrorFechaTermino").html("Debe ingesar fecha de termino");
                ValidFechaTermino = false;
            }
            else{
                if (FormatoFechaI > FormatoFechaT){
                    $("#FechaInicio").attr("class", "form-control is-invalid");
                    $("#ErrorFechaInicio").html("Fecha de inicio invalida");
                    $("#FechaInicio").val("");
                    ValidFechaInicio = false;
                }
                else{
                    $("#FechaInicio").attr("class", "form-control");
                    $("#ErrorFechaInicio").html("");
                    ValidFechaInicio = true;
                    ValidFechaTermino = true;
                }
            }
        }
        ActivarBtn();
    });

    $("#FechaTermino").focusout(function () {//Validacion de la fecha de termino
        var FechaTermino = $("#FechaTermino").val().trim();//Captura del campo
        if (FechaTermino == "") {//Campo vacio
            $("#FechaTermino").attr("class", "form-control is-invalid");
            $("#ErrorFechaTermino").html("Debe ingesar fecha de termino");
            $("#FechaTermino").val("");
            ValidFechaTermino = false;
        }
        else {//Campo esta lleno
            var FechaInicio = $("#FechaInicio").val().trim();
            var FormatoFechaT = new Date(FechaTermino);
            var FormatoFechaI = new Date(FechaInicio);
            if(FormatoFechaI.length == 0 && FormatoFechaI == null){
                $("#FechaInicio").attr("class", "form-control is-invalid");
                $("#ErrorFechaInicio").html("Debe ingresar fecha de inicio");
                ValidFechaInicio = false;
            }
            else{
                if(FechaTermino < FechaInicio){
                    $("#FechaTermino").attr("class", "form-control is-invalid");
                    $("#ErrorFechaTermino").html("Fecha de termino invalida");
                    $("#FechaTermino").val("");
                    ValidFechaTermino = false;
                }
                else{
                    $("#FechaTermino").attr("class", "form-control");
                    $("#ErrorFechaTermino").html("");
                    ValidFechaTermino = true;
                    ValidFechaInicio = true;
                }
            }
        }
        ActivarBtn();
    });

    $('#Boton').click(function () {
        $('#Filtrar').prop('disabled', false);
        ValidFechaInicio = false;
        ValidFechaTermino = false;
    });

    //EDITAR UN PRODUCTO

    var ValidStock = false;
    var ValidPrecio = false;

    function ActivarBtnProducto(){
        if(ValidStock && ValidPrecio){
            $('#GuardarBoton').prop('disabled', false);
        }
        else{
            $('#GuardarBoton').prop('disabled', true);
        }
    }

    $("#StockEdit").focusout(function () {
        var campo = $("#StockEdit").val().trim();
        if(!validarSiNumeroPrecio(campo)){
            $("#StockEdit").attr("class", "form-control is-invalid");
            $("#ErrorEditStock").html("Debe ingresar solo numeros");
            $("#StockEdit").val("");
            ValidStock = false;
        }
        else{
            $("#StockEdit").attr("class", "form-control");
            $("#ErrorEditStock").html("");
            ValidStock = true;
        }
        ActivarBtnProducto();
    });

    $("#PrecioEdit").focusout(function () {
        var campo = $("#PrecioEdit").val().trim();
        if(!validarSiNumeroPrecio(campo)){
            $("#PrecioEdit").attr("class", "form-control is-invalid");
            $("#ErrorEditPrecio").html("Debe ingresar solo numeros");
            $("#PrecioEdit").val("");
            ValidPrecio = false;
        }
        else{
            $("#PrecioEdit").attr("class", "form-control");
            $("#ErrorEditPrecio").html("");
            ValidPrecio = true;
        }
        ActivarBtnProducto();
    });

    //Validaciones del editar nombre

    $("#EditNombreVal").focusout(function () {
        var campo = $("#EditNombreVal").val().trim();
        if(!ValidacionCampo(campo)){
            $("#EditNombreVal").attr("class", "form-control is-invalid");
            $("#ErrorEditNombreVal").html("Debe ingresar solo letras");
            $("#EditNombreVal").val("");
            $('#GuardarBotonEditNombre').prop('disabled', true);
        }
        else{
            $("#EditNombreVal").attr("class", "form-control");
            $("#ErrorEditNombreVal").html("");
            $('#GuardarBotonEditNombre').prop('disabled', false);
        }
    });


    //CREAR UN PRODUCTO
    var ValidNombreProdCrear = false;
    var ValidPrecioProdCrear = false;
    var ValidStockProdCrear = false;
    var ValidSelectTipo = false;

    function ActivarBtnCrearProd(){
        if(ValidNombreProdCrear && ValidPrecioProdCrear && ValidStockProdCrear && ValidSelectTipo){
            $('#CrearProducto').prop('disabled', false);
        }
        else{
            $('#CrearProducto').prop('disabled', true);
        }
    }

    $("#NombreProd").focusout(function () {
        var campo = $("#NombreProd").val().trim();
        if(!ValidacionCampo(campo)){
            $("#NombreProd").attr("class", "form-control is-invalid");
            $("#ErrorNombreProd").html("Debe ingresar solo letras");
            $("#NombreProd").val("");
            ValidNombreProdCrear = false;
        }
        else{
            $("#NombreProd").attr("class", "form-control");
            $("#ErrorNombreProd").html("");
            ValidNombreProdCrear = true;
        }
        ActivarBtnCrearProd();
    });

    $("#Precio").focusout(function () {
        var campo = $("#Precio").val().trim();
        if(!validarSiNumeroPrecio(campo)){
            $("#Precio").attr("class", "form-control is-invalid");
            $("#ErrorPrecio").html("Debe ingresar solo letras");
            $("#Precio").val("");
            ValidPrecioProdCrear = false;
        }
        else{
            $("#Precio").attr("class", "form-control");
            $("#ErrorPrecio").html("");
            ValidPrecioProdCrear = true;
        }
        ActivarBtnCrearProd();
    });

    $("#Stock").focusout(function () {
        var campo = $("#Stock").val().trim();
        if(!validarSiNumeroPrecio(campo)){
            $("#Stock").attr("class", "form-control is-invalid");
            $("#ErrorStock").html("Debe ingresar solo letras");
            $("#Stock").val("");
            ValidStockProdCrear = false;
        }
        else{
            $("#Stock").attr("class", "form-control");
            $("#ErrorStock").html("");
            ValidStockProdCrear = true;
        }
        ActivarBtnCrearProd();
    });

    $("#TipoProducto").change(function(){
        var campo = $("select[id=TipoProducto]").val();
        if(campo==""){
            $("#TipoProducto").attr("class", "form-control is-invalid");
            $("#ErrorTipo").html("Debe seleccionar un tipo de producto");
            ValidSelectTipo = false;
        }
        else{
            $("#TipoProducto").attr("class", "form-control");
            $("#ErrorTipo").html("");
            ValidSelectTipo = true;
        }
        ActivarBtnCrearProd();
    });


});