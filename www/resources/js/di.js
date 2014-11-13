// ---------------------------------------------funciones jquery para di --inicio--
$(document).ready(function(){
    /*
        En este espacio se encuentran las variables que permiten la internacionalizacion de
        los textos que son agregados a la vista.
        Todas las variables en esta seccion van a llevar el prefijo int_ esto significa que
        es una variable de internacionalizacion. 
        Una llamada al servidor por medio de ajax permite actualizar los valores de las
        variables de acuerdo al idioma seleccionado.
    */
    $.ajax({
	    type: 'POST',
	    url: 'utilitarios_ajax/lenguaje',
	    success: function(data){
            var datos = data.split("&");
            int_msjErrorAgregarTxtArea = datos[0];
            int_msjErrorCompletarInfo = datos[1];
            int_msjDialogGuardar = datos[2];
            int_btnGuardar = datos[3];
	        int_btnCancelar = datos[4];
	        int_msjSinCursosAsociados = datos[5];
            int_msjErrorDiNoGuardado = datos[6];
            int_msjClonarDi = datos[7];
            int_btnClonar = datos[8];
            int_btnClonarAbrir = datos[9];
            int_msjErrorNingunCursoSeleccionado = datos[10];
            int_msjEliminarDi = datos[11];
            int_btnEliminar = datos[12]; 
            int_msjErrorDiNoGuardadoNoEliminar = datos[13];
            int_msjErrorDiNoGuardado = datos[14];
            int_msjErrorEscritura = datos[15]; 
            int_msjFinalizacionDi = datos[16];
            int_msjExitoGuardado = datos[17];
            int_msjNoAplica = datos[18];
            int_msjPlaceHolder = datos[19];
	    }
	});
	/*
    int_msjErrorAgregarTxtArea = "No puede agregar más secciones sin haber ingresado la información correspondiente en la última agregada."
    int_msjErrorCompletarInfo = "No puede completar esta sección sin haber ingresado la información correspondiente.";
    int_msjDialogGuardar = "Guardar Diseño Instruccional";
    int_btnGuardar = "Guardar";
	int_btnCancelar = "Cancelar";
	int_msjSinCursosAsociados = "No posee cursos asignados";
    int_msjErrorDiNoGuardado = "El Diseño Instruccional no se ha guardado.\nNo se pueden guardar los cambios.";
    int_msjClonarDi = "Clonar Diseño Instruccional";
    int_btnClonar = "Clonar";
    int_btnClonarAbrir = "Clonar y Abrir";
    int_msjErrorNingunCursoSeleccionado = "Debe seleccionar un curso en donde clonar el DI";
    int_msjEliminarDi = "Eliminar Diseño Instruccional"
    int_btnEliminar = "Eliminar DI"; 
    int_msjErrorDiNoGuardadoNoEliminar = "El Diseño Instruccional no se ha guardado. No se puede eliminar";
    int_msjErrorDiNoGuardado = "El Diseño Instruccional no puede ser guardado";
    int_msjErrorEscritura = 'Usted ha introducido el carácter "  [str] ".\n\nEste es un carácter inválido para esta área de texto.\nLos caracteres inválidos son \"\^ \\ `\".\n'; 
    int_msjFinalizacionDi = '¡Buen trabajo! Usted ha finalizado el diseño instruccional. \n (más opciones están siendo desarrolladas para la siguiente versión.)';
    int_msjExitoGuardado = "El diseño instruccional: [nombreDI] ha sido guardado exitosamente.";
    int_msjNoAplica = "NO APLICA"; */
    /*
    --------------Fin de las variables utilizadas para la internacionalizacion--------------
    */
    $('#div_programa_curso #tabs').tabs();
    $('#div_ayuda_di #tabs').tabs();
    $('#div_contexto_di #tabs').tabs();
    
    nombreDI = "";
    nombreDI_anterior = "";
    nombreCurso = $("nombre_curso_param_post").val();
    codigoCurso = $("#curso_param_post").val();
    idDI = parseInt($("#di_param_post").val());
    idDI_anterior = -1;
    programaEstudio = $("#plan_param_post").val();
    opcion = parseInt($("#opcion_param_post").val());

    if ( $("#escuela_param_post").val().toUpperCase() == "NO APLICA" || $("#escuela_param_post").val().toUpperCase() == "NO APPLY" 
    		|| $("#escuela_param_post").val()=="") {
    	escuela = -1;
    } else {
    	escuela = $("#escuela_param_post").val();
    }
    
    diGuardado = false;
    btnBorrar=1;
    matrizEstadosRespuestaContexto = [];
    turnosGuardado = 0;
    guardando = 0;
	clonar = false;
	communityID = -1;
    
    $("#div_contexto_di h2").click(function() {
    	$('#vistaDI').text($.trim(nombreDI));
        tamTracking("tda-gdi", "Paso_3_Edicion_Contexto", "Clic Botón");
    //Funcionalidad para el guardado de las respuestas del contexto
    });
   
    //Genera la matriz del DI, que estará en memoria
    di_matriz = jQuery.makeArray();
    //Genera la matriz del DI, para las bolitas en memoria
    bolitas_matriz = jQuery.makeArray();
    inicio_fila = 0;
    total_fila = parseInt($('#instructional_design tr').length - 1);
    total_column = parseInt($('#menu_opciones li').length);
    celdas_totales = total_fila * total_column;
    //llena la matriz con espacios en blanco
    for(inicio_fila = 0; inicio_fila < total_fila; inicio_fila++) {
        var sesion_di = jQuery.makeArray();
        var columnas_bolitas = jQuery.makeArray();
        var inicio_column = 0;
        for (inicio_column = 0; inicio_column < total_column; inicio_column++) {
            valores = jQuery.makeArray();
            valores[0] = "";
            sesion_di[inicio_column] = valores;
            columnas_bolitas[inicio_column] = 0;
        }
        di_matriz[inicio_fila] = sesion_di;
        bolitas_matriz[inicio_fila] = columnas_bolitas;
    }
    nombreDI = "";

    //Verifica si se invoco la pagina para ver el programa del curso o es directamente al di.
    $(function(){    
        var opcion = parseInt($("#opcion_param_post").val());
        //opcion=3 == Brincar el programa de curso y redirigir al contexto. Curso inexistente.
        //opcion=1 == Ver programa curso.
        //opcion=0 == Matriz DI. 
        switch (opcion) {
            case 0:
                $('#contenedor #div_programa_curso').css('display','none');
                $('#contenedor #di').css('display','block'); 
                $('#contenedor #di #boton_anterior').css('display','none'); 
                    
                if(codigoCurso<0)
                {
                    $('#programa_curso').hide();        	
                }
                
                actualizarMenu(4);
                menuAnterior = 4;
                $.ajax({
                    type: 'POST',
                    url: 'utilitarios_ajax/obtenerNombreDI.tcl',
                    data: "di=" + idDI,
                    dataType:'text', 
                    success: function(data){
                        nombreDI = data; //acá se puede mostrar el error o lo que devuelve el ajax.
                        $('#form_guardar #nombre_DI').val(nombreDI);
                            //cambia el nombre del diseño instruccional cuando se va a exportar
                        $('#vistaDI').text($.trim(nombreDI));
                    }
                });
                cargarDI();
                //Obtiene el nombre del profesor y el nombre del curso
                nombreProfesor = "";
                nombreCurso = ""; 
	            $.ajax({
                    type: 'POST',
		            url: 'utilitarios_ajax/infoProfesorCurso.tcl',
                    data: { di: idDI, cod_curso: codigoCurso},
		            dataType:'text', 
		            success: function(data){
                        var datos      = data.split("&");
                        nombreProfesor = datos[1];
                        nombreCurso    = datos[0];
                        $('#vistaCurso').text(nombreCurso);
                            //cambia el nombre cuando se importa el programa del curso
                        $('#apc_nombre_curso').text(nombreCurso);
                        $('#vistaProfesor').text(nombreProfesor);
                      }
                });
                break;    
            case 1:
                //Obtiene el nombre del profesor y el nombre del curso
                nombreProfesor = "";
                nombreCurso    = "";
                $.ajax({
                    type: 'POST',
                    url: 'utilitarios_ajax/infoProfesorCurso.tcl',
                    data: { di: idDI, cod_curso: codigoCurso},
                    dataType:'text', 
                    success: function(data){
                        var datos      = data.split("&");
                        nombreProfesor = datos[1];
                        nombreCurso    = $("#nombre_curso_param_post").val();
                        $('#vistaCurso').text(nombreCurso);
                            //cambia el nombre cuando se importa el programa del curso
                        $('#apc_nombre_curso').text(nombreCurso);
                        $('#vistaProfesor').text(nombreProfesor);
                    }
                });
                            
                actualizarMenu(2);
                menuAnterior   = 2;
                break;
            case 3:
                actualizarMenu(3);
                menuAnterior   = 3;                
                $('#div_programa_curso').hide();
                $('#div_contexto_di').show();
                // $('#boton_anterior').hide();
                $('#programa_curso').hide();
                    
                // $('#contenedor #div_contexto_di #boton_anterior').hide();
                $('#form_guardar #nombre_DI').val(nombreDI);
                    
                    //Obtiene el nombre del profesor y el nombre del curso
                nombreProfesor = "";
                nombreCurso    = "";
                $.ajax({
            	    type: 'POST',
	                url: 'utilitarios_ajax/infoProfesorCurso.tcl',
                    data: { di: idDI, cod_curso: codigoCurso},
		            dataType:'text', 
                    success: function(data){
                        var datos      = data.split("&");
                        nombreProfesor = datos[1];
                        nombreCurso    = $("#nombre_curso_param_post").val();
                        $('#vistaCurso').text(nombreCurso);
                        //cambia el nombre cuando se importa el programa del curso
                        $('#apc_nombre_curso').text(nombreCurso);
                        $('#vistaProfesor').text(nombreProfesor);
                    }
                });
                break;
        }
    });

    //indica que el div con id progressbar es una barra de progreso en 0.
	$( "#progressbar" ).progressbar({
		value: 0
	});

    //Genera el arreglo que permite obtener las ayudas del wizard
    ayudas = jQuery.makeArray(); 
    	$.ajax({
		type: 'POST',
		url: 'utilitarios_ajax/ayudas.tcl',
		dataType:'text', 
		success: function(data){
			ayudas = data.split("&");
			 $('#contenido_wizard #info').text(ayudas[0]);
			 			
		}
	});

/*mueve el wizar y la flecha que señala la sesión que se está editando ------- inicio ---*/
//$('#instructional_design > tbody > tr > td[id]').children('tbody').children('tr').children('td[id]').on('click', function(){
    $('#instructional_design').on('click', 'tbody > tr > td[id]', function(){
        tamTracking("tda-gdi", "Paso_3_Edicion_Matriz_Wizard", "Clic Ícono");
        //toma la posición de la columna con el número de sesion.
        // var objetivo = $(this).parent().find('.sesion').offset();
        //toma la posicion del menu, para usarlo como base.
        var incioWizard = $('#di').offset();
        //toma el largo del wizard, para validar cuando este sea más pequeño que la tabla.
        var largoWizard = $('#wizard').innerHeight();
        //toma la posición de la fila que se quiere editar.
        var fila = $(this).parent().find('.sesion').offset();
        //valor de la posición inicial del wizard en Y
        var incioWizardY = incioWizard.top  + 10;
        //valor de la posición inicial del wizard en X
        var incioWizardX = incioWizard.left + 100;
        //valor de la posición inicial de la flecha en Y
        var flechaY = fila.top + 7;
        //valor de la posición inicial de la flecha en X
        var flechaX = incioWizardX - 19;
        //valida que si el click está más abajo del borde inferior del wizard+30, baje lo necesario, para que la flecha 
        //siga dentro del wizard
        if( flechaY + 30 > incioWizardY + largoWizard ){
        // lo debe de bajar es: (la posición Y del click + 30) - (el punto inicial del wizard en Y + el largo del wizard)
            incioWizardY = incioWizardY + ((flechaY + 30) - (incioWizardY + largoWizard));
        }
        //setea las posiciones del wizard y la flecha.
        $('#wizard').css('top',incioWizardY);      
        $('#wizard').css('left',incioWizardX);  
        $('#arrow').css('top', flechaY);
        $('#arrow').css('left', flechaX-7);
        //setea las flechas para que siempre se muestren
        $('#encabezado .siguiente').show('');
        $('#encabezado .anterior').show('');             
        //marca la opción del wizar correspondiente, según la celda clickleada en el wizard
        $('#wizard #menu_opciones li').removeClass('seleccionado');
        var column = $(this).attr('id') - 2;
        //cambia el texto del encabezado
        $('#encabezado #encabezado_sesion').text($('#instructional_design > thead > tr:first > th:first > span').text());
        //si da click en las 2 primeras columnas
        if (column < 0) {
            //agrega la clase correspondiente a la seleccion
            $('#wizard #menu_opciones li:first').addClass('seleccionado');
            //cambia el texto del numero de sesion
            $('#encabezado #encabezado_num_sesion').text($(this).parent().find('.sesion').text());
            //cambia el texto del componente
            $('#encabezado #encabezado_act_sesion').text('- '+$('#wizard #menu_opciones li:first').text());
        //si da click en cualquier otra columna
        }else {
            //agrega la clase correspondiente a la seleccion
            $('#wizard #menu_opciones li:gt('+column+'):first').addClass('seleccionado');
            //cambia el texto del numero de sesion
            $('#encabezado #encabezado_num_sesion').text($(this).parent().find('.sesion').text());
            //cambia el texto del componente
            $('#encabezado #encabezado_act_sesion').text('- '+$('#wizard #menu_opciones li:gt('+column+'):first').text());
        }
        //pone el valor correspondiente a la celda seleccionada.
        var id = parseInt($('#menu_opciones .seleccionado').attr('id'));
        $('#contenido_wizard #info').text(ayudas[id-1]);
        //quita la funcionalidad de agregar en el wizard para los titulos
        if ((id) == 1) 
	        $('#contenedor_agregar').css("visibility","hidden");
	    else 
	    	$('#contenedor_agregar').css("visibility","visible");
        limpiar_campos();
        var fila = parseInt($('#encabezado #encabezado_num_sesion').text());
        if( bolitas_matriz[fila-1][id-1] == '2') {
            $('#img_completo').css('background-position','-2764px 32.5px');
            $('#img_incompleto').css('background-position','-2764px 70px');
        } 
        if(bolitas_matriz[fila-1][id-1] == '1') {
            $('#img_incompleto').css('background-position','-2764px 32.5px');
            $('#img_completo').css('background-position','-2764px 70px');
        }
        actualizar_contenido(id);
        //Funcionalidad para quitar las flechas si se seleccionan las opciones del inicio o el final
        var id = parseInt($('#menu_opciones .seleccionado').attr('id'));
        var total = $('#menu_opciones li').length;
        if (id == 1) {
        	$('#encabezado .anterior').hide('');
        } else if (id == total) {
        	$('#encabezado .siguiente').hide('');
        }
        //hace visible el wizard
        $('#wizard').show('slow');
        $('#arrow').show('slow');
        //igualar tamaños --debe ir despues de mostrarlo
        var size = $('#contenido_wizard').height();
        //$('#menu_wizard').height(size);
        $('#menu_wizard').height('290px');
        //agrega la clase bandera que indica a la hora de ver el programa del curso, si esta visible o no.
        $('#wizard').addClass('visible');   
        //esconde el scroll para que no se desubique el wizard
        $('#di').css("overflow", "hidden");
    });
/*mueve el wizar y la flecha que señala la sesión que se está editando ------- fin ---*/

/*agregar más campos de texto ------- inicio ---*/
$('#agregar').click(function(){
    tamTracking("tda-gdi", "Paso_3_Edicion_Matriz_Wizard", "Clic Ícono");
    if (tieneTexto($('#area_trabajo  #observaciones textarea:last').val())) {
        btnBorrar++;
        $('#area_trabajo  #observaciones > div:last').after('<div class=\"clear\"></div> <div> <textarea id="wizard_observaciones_'+btnBorrar+'" type=\"text\" class=\"wizard_observaciones\" style="display:none;"  rows="1" name=\"txt_observaciones\" placeholder="'+int_msjPlaceHolder+'" maxlength=1000></textarea> <div id="btn_borrar_'+btnBorrar+'" class="img_borrar_observaciones" onclick="borrarAreaTexto('+btnBorrar+')"></div> </div>');
        $('#area_trabajo  #observaciones textarea:last').slideDown();
    }else {
        alertDialog(int_msjErrorAgregarTxtArea);
    }
});
/*agregar más campos de texto ------- fin ---*/ 

/*marca como completa o incompleta una sección ------- inicio ---*/
$('#img_completo').click(function(){
    tamTracking("tda-gdi", "Paso_3_Edicion_Matriz_Wizard", "Clic Ícono");
    var id = parseInt($('#menu_opciones .seleccionado').attr('id'));
    var fila = parseInt($('#encabezado #encabezado_num_sesion').text());
    salvar_contenido();
    actualizarEstadosDI();
    if (tieneTexto($('#area_trabajo  #observaciones textarea:first').val())) {    
        $('#instructional_design tr:eq('+fila+') \
        td:eq('+id+') img.bolita').attr('src','/resources/tda-gdi/images/iconos/bolita_llena.png');
        //pone como title el contenido de la columna 1, que sería el título del DI.
        if(id==1){
            $('#instructional_design tr:eq('+fila+') \
            td:eq('+id+')').attr('title',di_matriz[fila-1][id-1][0]);
        }
        bolitas_matriz[fila-1][id-1] = 2;
        completado(true);
        $('#img_incompleto').css('background-position','-2764px 70px');
        $('#img_completo').css('background-position','-2764px 32.5px');

    } else {
        alertDialog(int_msjErrorCompletarInfo);
    }
});
$('#img_incompleto').click(function(){
    tamTracking("tda-gdi", "Paso_3_Edicion_Matriz_Wizard", "Clic Ícono");
    var id = parseInt($('#menu_opciones .seleccionado').attr('id'));
    var fila = parseInt($('#encabezado #encabezado_num_sesion').text());
    salvar_contenido();
    actualizarEstadosDI();
    $('#instructional_design tr:eq('+fila+') \
    td:eq('+id+') img.bolita').attr('src','/resources/tda-gdi/images/iconos/bolita_incompleta.png');
    //pone como title el contenido de la columna 1, que sería el título del DI.
    if(id==1){
        $('#instructional_design tr:eq('+fila+') \
        td:eq('+id+')').attr('title',di_matriz[fila-1][id-1][0]);
    }
    bolitas_matriz[fila-1][id-1] = 1;
    completado(false);
    $('#img_incompleto').css('background-position','-2764px 32.5px');
    $('#img_completo').css('background-position','-2764px 70px');
});
/*marca como completa o incompleta una sección ------- fin ---*/    
    
    

/*se mueve dentro del wizard -------------------------------------------------------- inicio ---*/
    //cierra el wizard, guarda, actualiza, verifica el final, mueve el progressbar...
    $('#contenido_wizard #cerrar').click(function(){
        tamTracking("tda-gdi", "Paso_3_Edicion_Matriz_Wizard", "Clic Botón");
        salvar_contenido();
        actualizarEstadosDI();
        $('#txt_observaciones').val('');
        $('#wizard').hide('slow');
        $('#arrow').hide('slow');
        //quita la clase bandera que indica a la hora de ver el programa del curso, si esta visible o no.
        $('#wizard').removeClass('visible');   
        //muestra el scroll que fue ocultado para que no se desubique el wizard
        $('#di').css("overflow", "auto");
        limpiar_campos();
        completado(false);
    });
    
    
    //se encarga de "caminar" en el wizard hacie adelante
    $('#encabezado .siguiente').click(function(){
        tamTracking("tda-gdi", "Paso_3_Edicion_Matriz_Wizard", "Clic Ícono");
        var id = parseInt($('#menu_opciones .seleccionado').attr('id'));
        var total = $('#menu_opciones li').length;       
        if(id < total) {
            salvar_contenido();
            actualizarEstadosDI();
            //cambia el texto de la ayuda
            $('#contenido_wizard #info').text(ayudas[id]);
            //quita la funcionalidad de agregar en el wizard para los titulos
        	if ((id+1) == 1) 
	        	$('#contenedor_agregar').css("visibility","hidden");
	    	else 
	    		$('#contenedor_agregar').css("visibility","visible");
            $('#txt_observaciones').val('');
            $('#menu_opciones li:eq('+(id -1)+')').removeClass('seleccionado');
            $('#menu_opciones li:eq('+id+')').addClass('seleccionado');
            $('#encabezado .siguiente').show('');
            $('#encabezado .anterior').show('');
            //cambia el texto del componente
            $('#encabezado #encabezado_act_sesion').text('- '+$('#menu_opciones .seleccionado').find('span').text());
            limpiar_campos();
            actualizar_contenido(id+1);
            actualizarBolitaSiNo();
            actualizarEstadosDI();
            if (id == (total-1))
            	$('#encabezado .siguiente').hide('');
       /* } else	if(id = total){
        	$('#encabezado .siguiente').hide(''); */
        } else completado(false);
    });
    
    //se encarga de "caminar" en el wizard hacie atrás
    $('#encabezado .anterior').click(function(){
        tamTracking("tda-gdi", "Paso_3_Edicion_Matriz_Wizard", "Clic Ícono");
        var id = parseInt($('#menu_opciones .seleccionado').attr('id'));
        var total = $('#menu_opciones li').length;
        if(id > 1) {
            salvar_contenido();
            actualizarEstadosDI();
            //cambia el texto de la ayuda
            $('#contenido_wizard #info').text(ayudas[id-2]);
            //quita la funcionalidad de agregar en el wizard para los titulos
        	if ((id-1) == 1) 
	        	$('#contenedor_agregar').css("visibility","hidden");
	    	else 
	    		$('#contenedor_agregar').css("visibility","visible");
            $('#txt_observaciones').val('');
            $('#menu_opciones li:eq('+(id-1)+')').removeClass('seleccionado');
            $('#menu_opciones li:eq('+(id-2)+')').addClass('seleccionado');
            $('#encabezado .siguiente').show('');
            $('#encabezado .anterior').show('');
            //cambia el texto del componente
            $('#encabezado #encabezado_act_sesion').text("- " +$('#menu_opciones .seleccionado').find('span').text());
            limpiar_campos();
            actualizar_contenido(id-1);
            actualizarBolitaSiNo();
        	if (id == 2)
            	$('#encabezado .anterior').hide('');
       /* } else	if(id = total){
        	$('#encabezado .siguiente').hide(''); */
        	} else completado(false);
    });
    
    //cambia el estilo de la opcion seccionada
    $('#menu_opciones li').click(function(){
        tamTracking("tda-gdi", "Paso_3_Edicion_Menu", "Clic Ícono");

        salvar_contenido();
        actualizarEstadosDI();
        //cambia el texto del componente
        $('#encabezado #encabezado_act_sesion').text("- " +$(this).find('.menu_wizard_item_texto').text());
        $('#menu_opciones li').removeClass('seleccionado');
        $('#encabezado .siguiente').show('');
        $('#encabezado .anterior').show('');
        $(this).addClass('seleccionado');
        var id = parseInt($('#menu_opciones .seleccionado').attr('id'));
    	//cambia el texto de la ayuda
    	$('#contenido_wizard #info').text(ayudas[id-1]);
    	//quita la funcionalidad de agregar en el wizard para los titulos
        if (id == 1) 
	        $('#contenedor_agregar').css("visibility","hidden");
	    else 
	    	$('#contenedor_agregar').css("visibility","visible");
        limpiar_campos();
        actualizar_contenido();
        actualizarBolitaSiNo();
        completado(false);
        //Funcionalidad para quitar las flechas si se seleccionan las opciones del inicio o el final
        var id = parseInt($('#menu_opciones .seleccionado').attr('id'));
        var total = $('#menu_opciones li').length;
        if (id == 1) {
        	$('#encabezado .anterior').hide('');
        } else if (id == total) {
        	$('#encabezado .siguiente').hide('');
        }
    });
/*se mueve dentro del wizard -------------------------------------------------------- fin ---*/
    
    
/*barra de menú, íconos -------------------------------------------------------- inicio ---*/

 //Funcionamiento del botón de Programa del menú principal
      
    $("#menu #menuPrograma").parent().click(function() {
        tamTracking("tda-gdi", "Paso_3_Edicion_ProgramaCurso", "Clic Ícono");	   
	    $('#contenedor #div_programa_curso').show();
	    if (opcion == 0)
            $('#contenedor #div_programa_curso #boton_siguiente').css('display','none');
   //Oculta las demás pantallas 
        $('#contenedor #div_ayuda_di').hide(); 
        $('#contenedor #div_contexto_di').hide(); 
        $('#contenedor #di').hide(); 
        if($('#wizard').hasClass('visible')){
            $('#wizard').hide();
            $('#arrow').hide();
        }
    });



 //Funcionamiento del botón de Ayuda del menú principal
    $("#menu #menuAyuda").parent().click(function() {
        tamTracking("tda-gdi", "Paso_3_Edicion_Ayuda", "Clic Ícono");
	    $('#contenedor #div_ayuda_di').show();   
   //Oculta las demás pantallas 
        $('#contenedor #div_programa_curso').hide(); 
            
        $('#contenedor #div_contexto_di').hide(); 
            
        $('#contenedor #di').hide(); 
        if($('#wizard').hasClass('visible')){
        	$('#wizard').hide();
            $('#arrow').hide();
        }    
    });
    
    //Funcionamiento del botón de Contexto del menú principal
    $("#menu #menuContexto").parent().click(function() {
        tamTracking("tda-gdi", "Paso_3_Edicion_Contexto", "Clic Ícono");
	    $('#contenedor #div_contexto_di').show('speed');
	    if (opcion == 0) {
	        $('#contenedor #div_contexto_di #boton_anterior').css('display','none');
		    $('#contenedor #div_contexto_di #boton_siguiente').css('display','none');
		}
   //Oculta las demás pantallas 
        $('#contenedor #div_programa_curso').hide(); 
    
        $('#contenedor #div_ayuda_di').hide(); 
            
        $('#contenedor #di').hide(); 
        if($('#wizard').hasClass('visible')){
        	$('#wizard').hide();
            $('#arrow').hide();
        }    
    });
    


  //Funcionamiento del botón de Matriz del menú principal
     
    $("#menu #menuMatriz").parent().click(function() {
        tamTracking("tda-gdi", "Paso_3_Edicion_Matriz", "Clic Ícono");
    //Activa los siguientes elementos
	    $("#menuMatriz").addClass('btnMatriz_activo');
	    $("#menuMatriz").next().addClass('textoActivo');
	    $("#puntoMatriz").addClass('Activo');
	   
	    $('#contenedor #di').show(); 

        if($('#wizard').hasClass('visible')){
            $('#wizard').show();
            $('#arrow').show();
        }
        
        if (opcion == 0) 
            $('#contenedor #di #boton_anterior').css('display','none'); 
            
   //Oculta las demás pantallas 
        $('#contenedor #div_programa_curso').hide(); 
        $('#contenedor #div_ayuda_di').hide(); 
        $('#contenedor #div_contexto_di').hide();
    });
/*barra de menú, íconos -------------------------------------------------------- fin ---*/

$('#menuExportar').click(function(){
    crearArchivoExcel('DIvistaCompleta');
    tamTracking("tda-gdi", "Paso_3_Edicion_Exportar", "Clic Ícono");
});

/*propiedades del documento -------------------------------------------------------- inicio ---*/
	// Indica que el div dialog va a ser un widget dialog
    $('#dialog').dialog({ 
        resizable: false,
        closeOnEscape: false,
        zIndex: 3000,
        autoOpen: false,
        modal: true,
        closeText: 'X',
        draggable: true,
        maxWidth: 450,
    }).next(".ui-widget-overlay").css("background", "#f00ba2");
       
    //función que realiza cuando se preciona menu_propiedades_documento
    $('#menu_propiedades_documento').click(function(){
        tamTracking("tda-gdi", "Paso_3_Edicion_Menu", "Clic Ícono");
    	var isFirstEx = 0;
        $("#form_propiedades_documento").bPopup({
			modal: true
			, onOpen: function () {
			    $('#form_propiedades_documento').bPopup().close();
		    	$("#tbl_propiedades_asociar tr > td").parent().remove(); 
				if(idDI == "-1") {
				// el DI no se ha guardado
					$.ajax({
            	    	type: 'POST',
            	    	url: 'utilitarios_ajax/obtenerPropiedadesDI.tcl',
            	    	data: { idDi:  idDI } , 
            	    	dataType:'text', 
            	    	success: function(data){
            	        	$("#propiedades_nombre_di").val("No aplica *");
							$("#propiedades_nombre_curso").val(nombreCurso);
							$("#propiedades_nombre_curso").attr("size",(nombreCurso.length+10));
							$("#tbl_propiedades_asociar tr:last").after('<tr><td colspan="3" style="text-align:center"> Sin cursos asociados </td></tr>');
							if (escuela == "-1")
								$("#propiedades_escuela").val("No aplica");
							else {
								$("#propiedades_escuela").val(escuela);
								$("#propiedades_escuela").attr("size",(escuela.length+15));
							}
							$("#propiedades_nombre_usuario").val(data);
							$("#propiedades_nombre_usuario").attr("size",(data.length+15));
							$("#propiedades_fec_creacion").val("No aplica");
							$("#propiedades_fec_alteracion").val("No aplica");
							$("#txt_explicativo_propiedades").css("visibility","visible");
            	    	}
            		});
				} else {
					$.ajax({
            	    	type: 'POST',
            	    	url: 'utilitarios_ajax/obtenerPropiedadesDI.tcl',
            	    	data: { idDi:  idDI } , 
            	    	dataType:'text', 
            	    	success: function(data){
            	    		var arregloData = data.split("*");
            	        	$("#propiedades_nombre_di").val(arregloData[0]);
            	        	$("#propiedades_nombre_di").attr("size",(arregloData[0].length+15));
							$("#propiedades_nombre_curso").val(arregloData[1]);
							$("#propiedades_nombre_curso").attr("size",(arregloData[1].length+15));
							
							if (arregloData[2]=="-1")
								$("#propiedades_escuela").val("No aplica");
							else {
								$("#propiedades_escuela").val(arregloData[2]);
								$("#propiedades_escuela").attr("size",(arregloData[2].length+15));
							}
							$("#propiedades_nombre_usuario").val(arregloData[3]);
							$("#propiedades_nombre_usuario").attr("size",(arregloData[3].length+15));
							$("#propiedades_fec_creacion").val(arregloData[4]);
							$("#propiedades_fec_alteracion").val(arregloData[5]);
							
							var arregloCursosAsociados = arregloData[6].split("%");
							if(arregloCursosAsociados[0]!="@") {
								for (i = 1;i < arregloCursosAsociados.length; i++) {
									var cursoActual = arregloCursosAsociados[i].split("@");
									$("#tbl_propiedades_asociar tr:last").after('<tr>\
										<td> '+cursoActual[0]+' </td>\
										<td> '+cursoActual[1]+' </td>\
										<td> '+cursoActual[2]+' </td>\
									</tr>');
								}
							} else {
								$("#tbl_propiedades_asociar tr:last").after('<tr><td colspan="3" style="text-align:center"> Sin cursos asociados </td></tr>');
							}
							$("#txt_explicativo_propiedades").css("visibility","hidden");
            	    	}
            		});
				}
				
				// esta funcionalidad se utiliza para llevar a cabo el centrado del popup por primera vez
				$('#form_propiedades_documento').css("visibility","hidden");
		    	isFirstEx = $('#form_propiedades_documento').width();
			}	
			, closeClass: 'propiedades_btn_cerrar'
			, modalColor: 'white'
		}, 
		function () {
		// esta funcionalidad se utiliza para llevar a cabo el centrado del popup por primera vez
			if(isFirstEx == 0) {
				var w = $('#form_propiedades_documento').width();
        		var h = $('#form_propiedades_documento').height();
        		var left = Number((window.innerWidth/2)-(w/2));
        		var tops = Number((window.innerHeight/2)-(h/2));
        		$('#form_propiedades_documento').css("left", left);
  			    $('#form_propiedades_documento').css("top", tops - (tops/4.5));
  			    $('#form_propiedades_documento').css("visibility","hidden");
        	}	
        	
        	$('#form_propiedades_documento').css("visibility","visible");
    	});
    });

    //función para cerrar el dialog, y quedar en la misma página
    $('.ui-dialog-titlebar-close').click(function(){
        $('#dialog').dialog('close');
        desbloquear();
        tamTracking("tda-gdi", "Paso_3_Edicion_Menu", "Clic Botón");
    });
/*propiedades del documento -------------------------------------------------------- fin ---*/
    
/*---------------------------------------------------------------------------------------pop up compartir---- inicio---*/ 
    //hace visible y no visible al popup.  
    $('#menu #compartir').click(function(){
        $('#compartir-pop_up').slideToggle('slow');
    });
    //indica que esto va a ser un tab.    
	$('#compartir-pop_up #tabs').tabs();
    //primero, se agrega la clase 'select_index_propios' a todos los compañeros de la misma escuela.
    $('#seleccionar_persona option').addClass('select_index_propios');
    //se agrega la opción para que busque en otras escuelas.
    $('#seleccionar_persona').append('<option value=\"0\" class=\"select_index_otros\" >Buscar en otra escuela</option>');
 
    $('#form_compartir_persona .form-item-wrapper').filter(':first').after('<br><div id=\"buscar_otras_personas\"></div>');
    //acomoda los selects para que unos esten el el div oculto y otros no
    $('#form_compartir_buscar_persona').appendTo('#buscar_otras_personas');
	$('#form_compartir_persona .form-button').find('input').val('Buscar');
 
        // si selecciona la opcion de buscar otros cursos, muestra el formulario para la búsqueda.
    $('.select_index_otros').click(function() {
        $('#buscar_otras_personas').slideDown('slow').show();
    });
    //si selecciona la un curso que imparta en este momento, oculta el formulario para buscar otros cursos.
    $('.select_index_propios').click(function() {
        $('#buscar_otras_personas').slideUp('slow');
    });
    
    
    $('#div_programa_curso #boton_siguiente').click(function() {
        $('#div_programa_curso').hide('fast');
        $('#div_contexto_di').show('fast'); 
        
		// Activacion del menu del contexto
		actualizarMenu(3);
		menuAnterior = 3;
	    
	    // Visualizacion del contexto
		$('#contenedor #div_contexto_di').show('speed');
    });
    
    $('#div_contexto_di #boton_anterior').click(function() {
    	$('#div_contexto_di').hide('fast');
    	$('#div_programa_curso').show('fast');    
	   
	    // Activacion del menu del contexto
		actualizarMenu(2);
		menuAnterior = 2;
		
		// visualizacion del programa de curso
		$('#contenedor #div_programa_curso').show();
    });
    
    $('#div_contexto_di #boton_siguiente').click(function() {
        $('#div_contexto_di').hide('fast');
        $('#di').show('fast');
		
		// Activacion del menu del contexto
		actualizarMenu(4);
		menuAnterior = 4;
	});
	
	$('#contenedor #di #boton_anterior').click(function() {
	    $('#div_contexto_di').show('fast');
	    $('#di').hide();
	    
	    // Activacion del menu del contexto
		actualizarMenu(3);
		menuAnterior = 3;
    });
/*---------------------------------------------------------------------------------------pop up compartir---- fin---*/

	$( "#dialog:ui-dialog" ).dialog( "destroy" );
	$(".ui-dialog-buttonset button:first").attr('id','btn_guardar');
	$(".ui-dialog-buttonset button:first span").text("");
    	$(".ui-dialog-buttonset button:last").attr('id','btn_cancelar');
	$(".ui-dialog-buttonset button:last span").text("");
	
	//guarda el diseño instruccional
    $('#menu_guardar').click(function(){
        tamTracking("tda-gdi", "Paso_3_Edicion_Menu", "Clic Opción Menú");
    	if(nombreDI == "") {
	        var buttonOpts = {};
            buttonOpts[int_btnGuardar] = function () {
                nombreDI = $('#form_guardar #nombre_DI').val();
                guardarDI();
                $( this ).dialog( "close" );
            };
    
            buttonOpts[int_btnCancelar] = function () {
                $(this).dialog("close");
            };
            
            $( "#dialog-form" ).dialog({
                autoOpen: false,
                height: 'auto',
                width: 'auto',
                modal: true,
                closeText: "X",
                title: int_msjDialogGuardar,
                buttons: buttonOpts, 
                open:function () {
                    $(this).closest(".ui-dialog").find(".ui-dialog-buttonpane .ui-dialog-buttonset button").addClass("btn");
                    $(this).closest(".ui-dialog").find("#nombre_DI").css("width", "100%");
                }
            }).next(".ui-widget-overlay").css("background", "#f00ba2");
                    $( "#dialog-form" ).dialog( "open" );
        } else {
        	guardarDI();
        }
        $("ul.menu li span").parent().find("ul.menu_items_menu").slideUp('fast');
        actualizarMenu(menuAnterior);	
    });
    	
    $('#menu_guardar_como').click(function(){
        tamTracking("tda-gdi", "Paso_3_Edicion_Menu", "Clic Opción Menú");
        var buttonOpts = {};
	    buttonOpts[int_btnGuardar] = function () {
            nombreDI = $('#form_guardar #nombre_DI').val();
            guardarDI();
            $( this ).dialog( "close" );
        };
    
        buttonOpts[int_btnCancelar] = function () {
            $(this).dialog("close");
        };
        
    	$( "#dialog-form" ).dialog({
			autoOpen: false,
			height: 'auto',
			width: 'auto',
			modal: true,
			closeText: "X",
			title: int_msjDialogGuardar,
			buttons: buttonOpts,
			open:function () {
				$(this).closest(".ui-dialog").find(".ui-dialog-buttonpane .ui-dialog-buttonset button").addClass("btn");
				$(this).closest(".ui-dialog").find("#nombre_DI").css("width", "100%");
			}
		});
		$( "#dialog-form" ).dialog( "open" ).next(".ui-widget-overlay").css("background", "#f00ba2");
    	$("ul.menu li span").parent().find("ul.menu_items_menu").slideUp('fast');
    	actualizarMenu(menuAnterior);
    });
    
   // $("ul.menu li span").parent().find("ul.menu_items_menu").slideDown();
    	
    // Este ajax se ejecuta para cargar los datos de los cursos asociados al usuario en la tabla de asociaciones
    $.ajax({
        type: 'POST',
        url: 'utilitarios_ajax/obtenerCursosUsuario',
        data: {idDi: idDI},
        dataType:'text', 
        success: function(data){
        	cursos = data.split("%");
        	if (cursos[0] != "") {
        		for (i=0;i<(cursos.length-1);i++) {
        			curso = cursos[i].split("*");
        			if (curso[4]=="true") {
        				$('#tbl_asociar_di tr:last').after('<tr>\
        					<td> <input type="checkbox" value="'+curso[1]+'" asociado="si" checked> </td>\
        					<td> '+curso[0]+'</td>\
        					<td> '+curso[2]+'</td>\
        					<td> '+curso[3]+'</td>\
        				</tr>');
        				$('#tbl_clonar_di tr:last').after('<tr>\
        					<td> <input type="radio" name="clonar" value="'+curso[1]+'"> </td>\
        					<td id="nombreCurso'+curso[1]+'" >'+curso[0]+'</td>\
        					<td id="periodoCurso'+curso[1]+'">'+curso[2]+'</td>\
        					<td id="annioCurso'+curso[1]+'"  >'+curso[3]+'</td>\
        				</tr>');
        			} else {
        				$('#tbl_asociar_di tr:last').after('<tr>\
        					<td> <input type="checkbox" value="'+curso[1]+'"> </td>\
        					<td> '+curso[0]+'</td>\
        					<td> '+curso[2]+'</td>\
        					<td> '+curso[3]+'</td>\
        				</tr>');
        				$('#tbl_clonar_di tr:last').after('<tr>\
        					<td> <input type="radio" name="clonar" value="'+curso[1]+'"> </td>\
        					<td id="nombreCurso'+curso[1]+'" >'+curso[0]+'</td>\
        					<td id="periodoCurso'+curso[1]+'">'+curso[2]+'</td>\
        					<td id="annioCurso'+curso[1]+'"  >'+curso[3]+'</td>\
        				</tr>');
        			}
        		}
        	} else {
        		$('#tbl_asociar_di tr:last').after('<tr>\
        			<td colspan="4" style="text-align:center"> '+int_msjSinCursosAsociados+' </td>\
        		</tr>');
        		$('#tbl_clonar_di tr:last').after('<tr>\
        			<td colspan="4" style="text-align:center"> '+int_msjSinCursosAsociados+' </td>\
        		</tr>');
        	}
    	}
    });
    
    // Abre el popup que muestra la funcionalidad para asociar el DI a otros cursos
	$('#menu_asociar').click( function() {
        tamTracking("tda-gdi", "Paso_3_Edicion_Menu", "Clic Opción Menú");
	    var isFirstEx = 0;
		$('#form_asociar_di').bPopup({
			modal: true
			, onOpen: function() {
			    // esta funcionalidad se utiliza para llevar a cabo el centrado del popup por primera vez
				$('#form_asociar_di').css("visibility","hidden");
		    	isFirstEx = $('#form_asociar_di').width();
		    	$('#form_asociar_di').bPopup().close();
			}
			, modalColor: 'white'
		}, 
		function () {
		    // esta funcionalidad se utiliza para llevar a cabo el centrado del popup por primera vez
			if(isFirstEx == 0) {/*
				var w = $('#form_asociar_di').width();
        		var h = $('#form_asociar_di').height();
        		var left = Number((window.innerWidth/2)-(w/2));
        		var tops = Number((window.innerHeight/2)-(h/2));
        		$('#form_asociar_di').css("left", left);
  		      	$('#form_asociar_di').css("top", tops - (tops/4.5));
  		      	$('#form_asociar_di').css("visibility","hidden");*/
  		      	//$('#form_asociar_di').css("visibility","hidden");
        	}	
        	
        	$('#form_asociar_di').css("visibility","visible");
		});
		$("ul.menu li span").parent().find("ul.menu_items_menu").slideUp('fast');
		actualizarMenu(menuAnterior);
	});
	
	// Se agrega funcionalidad a los botones del popup del asocie de cursos al DI
	$("#btn_cerrar_asociar").click( function () { 
        tamTracking("tda-gdi", "Paso_3_Edicion_Menu", "Clic Botón");
		$("#form_asociar_di").bPopup().close();
		if(idDI != -1) {
			$('#tbl_asociar_di input').each( function() {
				if($(this).attr('asociado') != "si")
					$(this).attr('checked', false);
			});
		}
	});
	
	$("#btn_guardar_asociar").click( function () {
        tamTracking("tda-gdi", "Paso_3_Edicion_Menu", "Clic Botón");
		if (idDI != -1) {
	    	var data = "" 
	    // funcionalidad para obtener los valores de los inputs seleccionados
	    	$('#tbl_asociar_di input').each( function() {
	    		$(this).attr("asociado","no");
	    	});
			$('#tbl_asociar_di input:checked').each( function() {
				data = data +"*"+$(this).attr("value");
				$(this).attr("asociado","si");
			});
				// si se obtienen valores seleccionados entonces se envian los datos al servidor para
				// guardar los cambios en la BD
			$.ajax({
        		type: 'POST',
        		url: 'utilitarios_ajax/guardarCursosAsociados',
        		data: {idDi: idDI, arregloCommunityIds: data},
        		dataType:'text', 
        		success: function(data){
        			$("#form_asociar_di").bPopup().close();
        		}
    		});
    	} else
    		alertDialog(int_msjErrorDiNoGuardado);
	});
		// Se agrega funcionalidad a los botones del popup del clonar de cursos al DI
	$("#btn_cerrar_clonar").click( function () { 
		$("#form_clonar_di").bPopup().close();
        tamTracking("tda-gdi", "Paso_3_Edicion_Menu", "Clic Botón");
	});
	
	$("#btn_guardar_clonar").click( function () {
        tamTracking("tda-gdi", "Paso_3_Edicion_Menu", "Clic Botón");
		if (diGuardado) {
			if (typeof $('#tbl_clonar_di input[name=clonar]:radio:checked').val() != 'undefined'){
				$('#form_guardar #nombre_DI').val("");
				$("#form_clonar_di").bPopup().close();
		
				var buttonOpts = {};
	            buttonOpts[int_btnClonar] = function() {
			        nombreDI = $('#form_guardar #nombre_DI').val();
			        clonar = true;
					nombreDI_anterior = nombreDI;
					idDI_anterior = idDI;
					idDI = -1;
					communityID = $('#tbl_clonar_di input[name=clonar]:radio:checked').val();
					$('#datos_obtenidos_post #nombre_curso_param_post').attr("value", $('#tbl_clonar_di input[name=clonar]:radio:checked').parent().parent().find("td").eq(1).html());
					$.ajax({
                	    type: 'POST',
                		url: 'utilitarios_ajax/obtenerDatosDiClonado',
                		data: {communityId: communityID},
                		dataType:'text', 
                		success: function(data){
                		    var arregloData = data.split("#");
                    	    $('#datos_obtenidos_post #curso_param_post').attr("value", arregloData[1]);
							$('#datos_obtenidos_post #escuela_param_post').attr("value", arregloData[0]);
							$("#curso_param_post").attr(int_msjNoAplica);
							guardarDI();
						}
					});
							
					$( this ).dialog( "close" );		
				};
                
                buttonOpts[int_btnClonarAbrir] = function() {
				    nombreDI = $('#form_guardar #nombre_DI').val();
					clonar = true;
					idDI = -1;
					communityID = $('#tbl_clonar_di input[name=clonar]:radio:checked').val();
					$('#datos_obtenidos_post #nombre_curso_param_post').attr("value", $('#tbl_clonar_di input[name=clonar]:radio:checked').parent().parent().find("td").eq(1).html());
					
					$.ajax({
                	    type: 'POST',
                		url: 'utilitarios_ajax/obtenerDatosDiClonado',
                		data: {communityId: communityID},
                		dataType:'text', 
                		success: function(data){
                		    var arregloData = data.split("#");
                    		$('#datos_obtenidos_post #curso_param_post').attr("value", arregloData[1]);
							$('#datos_obtenidos_post #escuela_param_post').attr("value", arregloData[0]);
							guardarDI();
						    clonar = false;
                		}
            		});
            		
            		$( this ).dialog( "close" );
				};
                
                buttonOpts[int_btnCancelar] = function () {
                    $(this).dialog("close");
                };
        
				$( "#dialog-form" ).dialog({
					autoOpen: false,
					height: 'auto',
					width: 'auto',
					modal: true,
					closeText: "X",
					title: int_msjClonarDi,
					buttons: buttonOpts, 
					open:function () {
						//$(this).closest(".ui-dialog").find(".ui-dialog-buttonset").find(".ui-button").addClass("btn");
						$(this).closest(".ui-dialog").find(".ui-dialog-buttonpane .ui-dialog-buttonset button").addClass("btn");
						$(this).closest(".ui-dialog").find("#nombre_DI").css("width", "61%");
					}
				}).next(".ui-widget-overlay").css("background", "#f00ba2");	
				$( "#dialog-form" ).dialog( "open" );	
				} else {
					alertDialog(int_msjErrorNingunCursoSeleccionado);
				}
		} else {
			alertDialog(int_msjErrorDiNoGuardado);
		}
	
	});


	
    // Abre el popup que muestra la funcionalidad para clonar el DI a otros cursos
	$('#menu_clonar').click( function() {	
        tamTracking("tda-gdi", "Paso_3_Edicion_Menu", "Clic Menú Opción");	
		$('#form_clonar_di').bPopup({
			modal: true
			, modalColor: 'white'
			, onOpen: function() {
			    // esta funcionalidad se utiliza para llevar a cabo el centrado del popup por primera vez
				$('#form_clonar_di').css("visibility","hidden");
		    	isFirstEx = $('#form_clonar_di').width();
		    	$('#form_clonar_di').bPopup().close();
			}
		}, 
		function () {
		    // esta funcionalidad se utiliza para llevar a cabo el centrado del popup por primera vez
			if(isFirstEx == 0) {
				var w = $('#form_clonar_di').width();
        		var h = $('#form_clonar_di').height();
        		var left = Number((window.innerWidth/2)-(w/2));
        		var tops = Number((window.innerHeight/2)-(h/2));
        		$('#form_clonar_di').css("left", left);
  		      	$('#form_clonar_di').css("top", tops - (tops/4.5));
  		      	$('#form_clonar_di').css("visibility","hidden");
        	}	
        	
        	$('#form_clonar_di').css("visibility","visible");
		});
		$("ul.menu li span").parent().find("ul.menu_items_menu").slideUp('fast');
		actualizarMenu(menuAnterior);
	});  
	
	$("#menu_eliminar").click( function() {
	    tamTracking("tda-gdi", "Paso_3_Edicion_Menu", "Clic Menú Opción");
	    var buttonOpts = {};
	    buttonOpts[int_btnEliminar] = function() {
            if (diGuardado) {
                $.ajax({
                    type: 'POST',
                    url: 'utilitarios_ajax/eliminarDI.tcl',
                    data: "di=" + idDI,
                    dataType:'text', 
                    success: function(data){
                        window.location='index';
                    }
                });         
                        //window.location='index';   
                $( this ).dialog( "close" );
                $(window).unbind('beforeunload');
            } else {
                alertDialog(int_msjErrorDiNoGuardadoNoEliminar);
                $( this ).dialog( "close" );
            }
        }
        
        buttonOpts[int_btnCancelar] = function() {
            $( this ).dialog( "close" );
        }
	            
	    $( "#dialog-confirm" ).dialog({
	        autoOpen: false,
            resizable: false,
            closeText: "X",
            title: int_msjEliminarDi,
            height:150,
            width:400,
            modal: true,
            buttons: buttonOpts, 
            open:function () {
		        $(this).closest(".ui-dialog").find(".ui-dialog-buttonpane .ui-dialog-buttonset button").addClass("btn");
		    }
        });
		$( "#dialog-confirm" ).dialog( "open" );
    	$("ul.menu li span").parent().find("ul.menu_items_menu").slideUp('fast');
	});
	 
    //carga la info
    $(function(){    
        var opcion = $("#opcion_param_post").val();
        if(opcion[1] == 0){
            $.ajax({
                type: 'POST',
                url: 'utilitarios_ajax/obtenerNombreDI.tcl',
                data: "di=" + $("#di_param_post").val(),
                dataType:'text', 
                success: function(data){
                    nombreDI = data; //acá se puede mostrar el error o lo que devuelve el ajax.
                    $('#form_guardar #nombre_DI').val(nombreDI);
                }
            });
            cargarDI();
        }
    });
    
    
    //Cambia el primer valor de las ayudas del wizard
    self.setInterval(function(){  
        if (diGuardado == true){
    		actualizarEstadosDI();
    		guardarDI();
    	} /*else 
    		console.log(int_msjErrorDiNoGuardado);*/
    }, 60000 ); // Tip: 1000 ms = 1 second.
    //self.setInterval(function(){clock()},1000);actualizarEstadosDI()
    
    $('#img_completo').hover(function(){
    	$('#img_completo').css('background-position','-2764px -4px');
    });
    $('#img_completo').mouseout(function(){
    	actualizarBolitaSiNo();
    });
    
    $('#img_incompleto').hover(function(){
    	$('#img_incompleto').css('background-position','-2764px -4px');
    });
    
    $('#img_incompleto').mouseout(function(){
    	actualizarBolitaSiNo();
    });
    
    $('.ctxt_estado').click(function(){
    	$(this).parent().children().removeClass("llenarEstado");
    	$(this).attr('class','ctxt_estado llenarEstado inline');
    	salvarEstados();
    });
    
    
    $('#instructional_design').addClass("persist-area");
    $('#instructional_design thead').addClass("persist-header");
    $('#instructional_design thead').css("margin","-2px");
    $('#instructional_design thead').css("width","auto");
    $('#main-content .main-content-padding').css("padding", "0px");
    $('body').css("width", "99%");
    
    var clonedHeaderRow;
    
       $(".persist-area").each(function() {
           clonedHeaderRow = $(".persist-header", this);
           clonedHeaderRow
             .before(clonedHeaderRow.clone())
             .addClass("floatingHeader");
             
       });
       
       $(window)
        .scroll(UpdateTableHeaders)
        .trigger("scroll");
        
    var is_chrome = navigator.userAgent.toLowerCase().indexOf('chrome') > -1;
    if( is_chrome ) {
        $('.floatingHeader').css("margin", "1");
        $('#di').css("margin", "0 0.75% 1%"); 
    }
    
    $('#apc_nombre_curso').hide();


    /*Se agrega la funcionalidad para hacer sort a los valores del wizard */
    $("#observaciones").sortable({});
    // se agrega la funcionalidad para hacer el sort de las sesiones de la matriz principal
    $('td, th', '#instructional_design').each(function () {
        var cell = $(this);
        cell.width(cell.width());
    });

    $('#instructional_design tbody').sortable({
        handle: $('.sesion').closest('td'),
        start: function(event, ui) {
            $(this).data('previndex', ui.item.index());
        }, 
        update: function(event, ui) {
            var newIndex = ui.item.index();
            var oldIndex = $(this).data('previndex');
            actualizarCache(oldIndex, newIndex);
            actualizarDisennoInstruccional();
        }
    }).disableSelection();
    
    var appendHtml = "<i class=\"tds-lib-icon-menu2 tds-lib-18x\"></i><ul class=\"menu_items_session\" style=\"display: none;\">\
                        <li>\
                            <a id=\"agregar_sesion\">Agregar sesión</a>\
                        </li>\
                        <li>\
                            <a id=\"eliminar_sesion\">Eliminar sesión</a>\
                        </li>\
                        </ul>"; 
    $('#instructional_design').find('thead').first().children().children().first().append(appendHtml);
    $('#instructional_design').find('thead').last().children().children().first().append(appendHtml);

    $('.tds-lib-icon-menu2').on('click', function(e){
        tamTracking("tda-gdi", "Paso_3_Edicion_Matriz", "Clic Ícono");
        $(this).parent().children('.menu_items_session').slideToggle('fast');
        
        $("#marco").mousemove(function( event ) {
            var offset = $( ".menu_items_session" ).offset();
            var anchoMenu = $( ".menu_items_session" ).width();
            var largoMenu = $( ".menu_items_session" ).height();
            
            if ( ((offset.left - 2) > event.pageX || event.pageX > (offset.left + anchoMenu + 5)) 
                        || ((offset.top - 80) > event.pageY || event.pageY > (offset.top + largoMenu + 2))) {
                //alert("Sale Marco " + "( x = " + event.pageX + ", y = " + event.pageY + " )");
                //window.setTimeout(function(){ actualizarMenu(menuAnterior)},180);
                $('#instructional_design').children('thead').first().find('.menu_items_session').slideUp('fast');
            }
        });
        
    });


    var sesiones = parseInt($("#cantidad_sesiones_param_post").attr("value"));

    $('.menu_items_session').on('click','#agregar_sesion', function() {
        tamTracking("tda-gdi", "Paso_3_Edicion_Matriz", "Clic Botón");
        if (sesiones >= 32) {
            alertDialog("El Diseño instruccional ya posee el máximo de sesiones. <br>No es posible agregar más sesiones.");
        } else {
            $(".menu_items_session").slideUp('fast');
            $('#agregar_sesiones_form').bPopup({
                closeClass: 'cancelar',
                fadeSpeed: 'fast', //can be a string ('slow'/'fast') or int
                followSpeed: 1500, //can be a string ('slow'/'fast') or int
                modalColor: 'white'
            });
        }
    }).on('click','#eliminar_sesion', function() {
        tamTracking("tda-gdi", "Paso_3_Edicion_Matriz", "Clic Botón");
        if (sesiones == 1) {
            alertDialog("El Diseño instruccional ya posee el mínimo de sesiones. <br>No es posible eliminar más sesiones.");
        } else {
                $(".menu_items_session").slideUp('fast');
                $('#eliminar_sesiones_form').bPopup({
                    closeClass: 'cancelar',
                    fadeSpeed: 'fast', //can be a string ('slow'/'fast') or int
                    followSpeed: 1500, //can be a string ('slow'/'fast') or int
                    modalColor: 'white'
                });
        }
    });


    var agregar_sesiones_spinner = new tds_lib.Spinner(document.getElementsByClassName("tds-lib_form_spinner")[0]);
    var eliminar_sesiones_spinner = new tds_lib.Spinner(document.getElementsByClassName("tds-lib_form_spinner")[1]);
    actualizarSesiones(agregar_sesiones_spinner, eliminar_sesiones_spinner, sesiones);


    $('#agregar_sesiones_form').children('div').last().on('click', '.agregar', function() {
        tamTracking("tda-gdi", "Paso_3_Edicion_Matriz", "Clic Botón");
        if((32 - sesiones) == 0) {
            alertDialog("El rango de valores permitido es 1 a 32 sesiones <br> No se pueden agregar más sesiones");
        } else {
            var sessionsToAdd = $('#agregar_sesiones_spinner').val();
            var result; 
            var lastSession = $('#instructional_design').children('tbody').children().last().children().first().find('span').text();
            tamTracking("tda-gdi", "Paso_3_Edicion_Matriz", "Completar Text Field");
            for (var i = 0; i < sessionsToAdd; i++) {
                lastSession++;
                result = result + '<tr class="" style="">\
                    <td align="center" class="list-table" style="width: 133px;"><span class="sesion">'+lastSession+'</span></td>\
                    <td align="center" id="1" class="list-table" style="width: 133px;"><div class="bolita bolita_vacia" id="'+lastSession+'-1"></div></td>\
                    <td align="center" id="2" class="list-table" style="width: 133px;"><div class="bolita bolita_vacia" id="'+lastSession+'-2"></div></td>\
                    <td align="center" id="3" class="list-table" style="width: 133px;"><div class="bolita bolita_vacia" id="'+lastSession+'-3"></div></td>\
                    <td align="center" id="4" class="list-table" style="width: 133px;"><div class="bolita bolita_vacia" id="'+lastSession+'-4"></div></td>\
                    <td align="center" id="5" class="list-table" style="width: 133px;"><div class="bolita bolita_vacia" id="'+lastSession+'-5"></div></td>\
                    <td align="center" id="6" class="list-table" style="width: 133px;"><div class="bolita bolita_vacia" id="'+lastSession+'-6"></div></td></tr>';
                    di_matriz.push([[], [], [], [], [], []]);
                    bolitas_matriz.push([0, 0, 0, 0, 0, 0]);   
            };
            $('#instructional_design').children('tbody').append(result);
            $("#cantidad_sesiones_param_post").attr("value", lastSession);
            actualizarDisennoInstruccional();
            $('#agregar_sesiones_form').bPopup().close();
            sesiones = parseInt(sesiones) + parseInt(sessionsToAdd);

            actualizarSesiones(agregar_sesiones_spinner, eliminar_sesiones_spinner, sesiones);

            $('#instructional_design tbody').sortable({
                handle: $('.sesion').closest('td'),
                start: function(event, ui) {
                    $(this).data('previndex', ui.item.index());
                }, 
                update: function(event, ui) {
                    var newIndex = ui.item.index();
                    var oldIndex = $(this).data('previndex');
                    actualizarCache(oldIndex, newIndex);
                    actualizarDisennoInstruccional();
                }
            }).disableSelection();
        }
    });
    $('#eliminar_sesiones_form').children('div').last().on('click', '.eliminar', function(){
        tamTracking("tda-gdi", "Paso_3_Edicion_Matriz", "Clic Botón");
        var sessionToDelete = $('#eliminar_sesiones_spinner').val();
        var result; 
        var lastSession = $('#instructional_design').children('tbody').children().last().children().first().find('span').text();
        tamTracking("tda-gdi", "Paso_3_Edicion_Matriz", "Completar Text Field");

        di_matriz.splice(sessionToDelete-1, 1);
        bolitas_matriz.splice(sessionToDelete-1, 1);
      
        $('#instructional_design > tbody > tr:nth-child('+sessionToDelete+')').remove();
        $("#cantidad_sesiones_param_post").attr("value", lastSession-1);
        actualizarDisennoInstruccional();
        $('#eliminar_sesiones_form').bPopup().close();
        sesiones = sesiones-1;

        actualizarSesiones(agregar_sesiones_spinner, eliminar_sesiones_spinner, sesiones);

        $('#eliminar_sesiones_spinner').val("01");
    });
    
}); // FINALIZA EL READY

$(document).delegate('textarea','keyup',function() {
    // 
        var $th = $(this);
        $th.val( $th.val().replace(/[\^\\\\`]/g, 
        function(str){ 
            arrMsj = int_msjErrorEscritura.split("[str]");
            alertDialog(arrMsj[0]+str+arrMsj[1]); 
            return ''; 
        } ) );
       // $(this).css('overflow', 'hidden').autogrow();
        $(this).css('overflow', 'hidden').autosize();
        if ($th.val()=="") {
            //$(this).css('height','36px');
        }
});

/*--------------------------------------------------------------Funciones ------------ inicio ------*/
/*funcion que genera la funcionalidad de los puntos en la etiqueta "guardando" */
function ptosGuardando(){
    if (turnosGuardado == 0) {
    	clearInterval ( guardando );
	$('#guardando').css('visibility', 'hidden');
    	return;
    }
    
    if ($('#ptosGuardando').text().length == 3) {
    	$('#ptosGuardando').text('');
	turnosGuardado--;
    }
    else {
    	$('#ptosGuardando').text($('#ptosGuardando').text()+'.');
	turnosGuardado--;
    }
}
/* funcion que actualiza la matriz de los estados de las 
respuestas del contexto. Se llama salvar porque guarda el estado
de las respuestas en memoria al igual que salvarEstados();
*/
function salvarEstados(){
    var i = 0;
    $("#div_contexto_di #tabs #contenido .ui-tabs-panel").each(function (){
    	var idActual = $(this).attr("id");
	var estadoRespuesta = 0;
	var arregloIdActual = idActual.split("_");
    	var idPregunta = arregloIdActual[arregloIdActual.length-1];    			
        var respuestaContexto = $("#textarea_contexto_di_"+idPregunta).val();

    	if($('#ctxt_estado_'+idPregunta+' .ctxt_estado:first').hasClass('llenarEstado')) {
    		estadoRespuesta = 1;
    	}
    	
    	matrizEstadosRespuestaContexto[i] = [idPregunta,estadoRespuesta];
 
    	i++;
   });

}
/*funcion que se encarga de guardar en memoria la matriz
además cambia el ícono para representar los campos editados 
de la matriz.
*/
function salvar_contenido(){
    var id = parseInt($('#menu_opciones .seleccionado').attr('id'));
    var fila = parseInt($('#encabezado #encabezado_num_sesion').text());
    var cantidad = $("#area_trabajo #observaciones .wizard_observaciones").length;
    var texto = "";  
    var elementos = jQuery.makeArray();
    var insertarEn = 0;
    for (posicion = 0; posicion < cantidad; posicion++) {
        var valor = $("#area_trabajo #observaciones .wizard_observaciones:eq("+posicion+")").val();
        if (tieneTexto(valor)) {
            elementos[insertarEn] = valor;
            insertarEn++;
            texto = texto + valor + "<br>";

        }
    }
    di_matriz[fila-1][id-1] = elementos;
    $('#DI_visualizar tr:eq('+(fila)+') td:eq('+(id)+')').html(texto);
}

function actualizarBolitaSiNo() {
    var id = parseInt($('#menu_opciones .seleccionado').attr('id'));
    var fila = parseInt($('#encabezado #encabezado_num_sesion').text());
    if(bolitas_matriz[fila-1][id-1] == 2) {
        $('#img_completo').css('background-position','-2764px 32.5px');
        $('#img_incompleto').css('background-position','-2764px 70px');
    } 
    else if(bolitas_matriz[fila-1][id-1] == 1) {
        $('#img_incompleto').css('background-position','-2764px 32.5px');
        $('#img_completo').css('background-position','-2764px 70px');
    }
    else {
    	$('#img_incompleto').css('background-position','-2764px 70px');
        $('#img_completo').css('background-position','-2764px 70px');
    }
}
/*
Funcion que actualiza los estados de la matriz del DI. Pone las imagenes de las bolitas no completadas como rojas, 
en proceso en anaranjado y finalizadas y marcadas como terminadas las deja en color verde.
*/
function actualizarEstadosDI(){  
    //iteracion en la fila actual para cambiar estados
    var totalFilas = bolitas_matriz.length;
    for(filaActual=0;filaActual<totalFilas;filaActual++){
        var totalColumnas = bolitas_matriz[filaActual].length;
    	var cambiarEstados = false;
    	for(columnaActual = 0; columnaActual < totalColumnas; columnaActual++) {
        	if(bolitas_matriz[filaActual][columnaActual]!=0 || 
        		(di_matriz[filaActual][columnaActual].length != 0 && di_matriz[filaActual][columnaActual]!="")){
        		cambiarEstados = true;
        		break;
        	}
    	}
    	if(cambiarEstados==true) {
        	for(columnaActual = 0; columnaActual < totalColumnas; columnaActual++) {
        		var actual = (filaActual+1).toString()+'-'+(columnaActual+1).toString();
        		if(bolitas_matriz[filaActual][columnaActual]==0 && 
        			(di_matriz[filaActual][columnaActual].length == 0 || di_matriz[filaActual][columnaActual]=="")) {
				    $('#'+actual).removeClass("bolita_vacia");
				    $('#'+actual).removeClass("bolita_no_terminada");
				    $('#'+actual).removeClass("bolita_llena");
				    $('#'+actual).addClass("bolita_pendiente");
		        } else if (bolitas_matriz[filaActual][columnaActual]==1) {
		        	$('#'+actual).removeClass("bolita_vacia");
				    $('#'+actual).removeClass("bolita_pendiente");
				    $('#'+actual).removeClass("bolita_llena");
    				$('#'+actual).addClass("bolita_no_terminada");
			    } else if (bolitas_matriz[filaActual][columnaActual]==2) {
                    $('#'+actual).removeClass("bolita_vacia");
		  	        $('#'+actual).removeClass("bolita_no_terminada");
                    $('#'+actual).removeClass("bolita_pendiente");
                    $('#'+actual).addClass("bolita_llena");
		        } else if (di_matriz[filaActual][columnaActual].length != 0 && 
		        	(di_matriz[filaActual][columnaActual].length != 0 && di_matriz[filaActual][columnaActual]!="")) {
		        	bolitas_matriz[filaActual][columnaActual]=1;
		        	$('#'+actual).removeClass("bolita_vacia");
				    $('#'+actual).removeClass("bolita_pendiente");
				    $('#'+actual).removeClass("bolita_llena");
				    $('#'+actual).addClass("bolita_no_terminada");
		        }
		         
		    }
    	}
    }
}
function tieneTexto(texto) {  
    for ( caracter = 0; caracter < texto.length; caracter++ ) {  
        if ( texto.charAt(caracter) != " " ) {  
            return true;  
        }  
    }  
    return false;
}  
//quita los campos de texto extra, excepto el primero.
// OJO si se ocupan ordenar los text area se debe revisar esta funcion.
function limpiar_campos() {
    
    $("#area_trabajo #observaciones textarea:first('.wizard_observaciones')").attr('id','wizard_observaciones_1');
    $("#area_trabajo #observaciones textarea:not(:first('.wizard_observaciones'))").remove();
    $("#area_trabajo #observaciones div.img_borrar_observaciones").remove();
    $('#img_incompleto').css('background-position','-2764px 70px');
    $('#img_completo').css('background-position','-2764px 70px');
    
    btnBorrar = 1;
}

/*funcion que se encarga de poner el contenido correspondiente
en el área de trabajo, para ser visto o editado.
*/
function actualizar_contenido(){
    btnBorrar = 1;
    var id = parseInt($('#menu_opciones .seleccionado').attr('id'));
    var fila = parseInt($('#encabezado #encabezado_num_sesion').text());

    var elementos = di_matriz[fila-1][id-1];
    var cantidadElementos = elementos.length;
    
    $("#area_trabajo #observaciones").html(
        '<div><textarea id="wizard_observaciones_1" class="wizard_observaciones text_area" maxlength="1000" placeholder="'+int_msjPlaceHolder+'" rows="1" name="txt_observaciones" type="text">\
        \\'+elementos[0]+'\
        </textarea></div>');
    
    $("#area_trabajo #observaciones .wizard_observaciones:eq(0)").val(elementos[0]);
    //$("#area_trabajo #observaciones .wizard_observaciones:eq(0)").css('overflow', 'hidden').autogrow();
    $("#area_trabajo #observaciones .wizard_observaciones:last").css('overflow', 'hidden').autosize();
    $('#observaciones textarea').after('<div id="btn_borrar_'+btnBorrar+'" class="img_borrar_observaciones" onclick="borrarAreaTexto('+btnBorrar+')"></div>');
    for (posicion = 1; posicion < cantidadElementos; posicion++) {
        btnBorrar++;
        $('#area_trabajo  #observaciones > div:last').after("<div class=\"clear\"></div><div><textarea id='wizard_observaciones_"+(btnBorrar)+"' type=\"text\" class=\"wizard_observaciones\" rows=\"1\" name=\"txt_observaciones\" maxlength=1000>"+elementos[posicion]+"</textarea><div id='btn_borrar_"+btnBorrar+"' class='img_borrar_observaciones' onclick='borrarAreaTexto("+btnBorrar+")'></div></div>");
        //$("#area_trabajo #observaciones textarea:last").css('overflow', 'hidden').autogrow();
        $("#area_trabajo #observaciones textarea:last").css('overflow', 'hidden').autosize();
    }
}
/*
se encarga de notificar cuando se terminó el diseño instruccional
actualiza el progressbar y las bolitas
*/
function completado(mensaje){
    var resultado = false;
    var celdas_completadas = 0;
    for(inicio_fila = 0; inicio_fila < total_fila; inicio_fila++) {
        var inicio_column = 0;
        for (inicio_column = 0; inicio_column < total_column; inicio_column++) {
            if(bolitas_matriz[inicio_fila][inicio_column] == 2){
                celdas_completadas++;
            }
        }
    }
    var aumento = Math.round((celdas_completadas / celdas_totales)*100);
	controladorBarra(aumento);
    if(celdas_completadas == celdas_totales && mensaje){
        alertDialog(int_msjFinalizacionDi);
    }
}
/*
llamada por completado(), se encarga de controlar la barra de progreso.
*/
function controladorBarra(punto){
    var valor = parseInt($('#progressbar').progressbar("value"));
    var movimientos = Math.abs(valor-punto);
    $('#progresstext').text(valor+'%');
    if(valor == punto){
        return;
    } else if (valor > punto){
        setTimeout("controladorBarra("+punto+");",100);
        valor=valor-1;
        $('#progressbar').progressbar("option", "value", valor);
    } else {
        setTimeout("controladorBarra("+punto+");",100);
        valor=valor+1;
        $('#progressbar').progressbar("option", "value", valor);
    }
    if  (valor > 55) {    
       $('#progresstext').css("color", "white");
    } else {
       $('#progresstext').css("color", "#777777");
    }
}
/*
guardar DI
*/
function guardarDI(){
    $('#guardando').css('visibility', 'visible');
    //salvar_contenido();
    //alert("El diseño instruccional: "+nombreDI + " ha sido guardado exitosamente.");
    turnosGuardado = 4;
    guardando =  setInterval ( "ptosGuardando()", 1000 );
    var diTexto = "";
    var estados = "";
    var cantidadFilas = di_matriz.length;
    var cantidadColumnas = di_matriz[0].length;
    
    var nombreCurso = $("#nombre_curso_param_post").attr("value");
    var sesiones = $("#cantidad_sesiones_param_post").attr("value");
    if ( $("#escuela_param_post").attr("value").toUpperCase() == "NO APLICA" || $("#escuela_param_post").attr("value").toUpperCase() == "NO APPLY" || $("#escuela_param_post").val()=="") {
    	escuela = -1;
    } else {
    	escuela = $("#escuela_param_post").attr("value");
    }
    
    codigoCurso = $("#curso_param_post").attr("value");
    if ( codigoCurso.toUpperCase() == 'NO APLICA' || codigoCurso.toUpperCase() == 'NO APPLY' ){
		codigoCurso = -1;
    }
    
    if (programaEstudio == "No aplica" || programaEstudio == "No apply" || programaEstudio === "undefined" ) {
        programaEstudio = -1;
    }
    
    
    // Este condicional sirve para manejar el problema que se presenta cuando se va a realizar el guardado 
    // de un diseño instruccional al no haberse generado todavía el wizard. El problema es que genera un 
    // error por elementos nulos en salvarEstados()
    //if (!isNaN(parseInt($('#encabezado #encabezado_num_sesion').text()))) {
    //    salvar_contenido();
    //    salvarEstados(); 
    //}
    
    for (fila = 0; fila < cantidadFilas; fila++){
        for (columna = 0; columna < cantidadColumnas; columna++){    
            var valores = di_matriz[fila][columna];
            var cantidadValores = valores.length;
            if (estados != ""){
                estados = estados + "-"+ bolitas_matriz[fila][columna];
            } else {
                estados = ""+ bolitas_matriz[fila][columna];
            }
            for (valor = 0; valor < cantidadValores; valor++){
                if (valor != 0) {
                    diTexto = diTexto +"\\"+ valores[valor];
                } else {
                    diTexto = diTexto + valores[valor];
                }
            }
            
            if (columna != (cantidadColumnas - 1)) {
                 diTexto = diTexto +"^";
            }
        }
        if (fila != (cantidadFilas - 1)) {
            diTexto = diTexto +"`";
        }
    }
    
    $.ajax({
        type: 'POST',
        url: 'utilitarios_ajax/guardar_di.tcl',
        data: { idDI: idDI, di: diTexto, nombre: $.trim(nombreDI), cod_curso: codigoCurso, estados: estados, nombre_curso: nombreCurso, sesiones: sesiones, programaEstudio: programaEstudio, escuela: escuela, clonar: clonar, communityID: communityID },
        dataType:'text', 
        success: function(data){
            idDI=data;
            if (data == -1) {
                console.log("La sesión ha caducado!!!!");
                $(window).unbind('beforeunload');
                window.location='index';

            }
            //Funcionalidad para el guardado de las respuestas del contexto
            var respuestasContexto = "";
            $("#div_contexto_di #tabs #contenido .ui-tabs-panel").each(function (){
    	        var idActual = $(this).attr("id");
    	        var arregloIdActual = idActual.split("_");
    	        var idPregunta = arregloIdActual[arregloIdActual.length-1];
            	var respuestaContexto = $("#textarea_contexto_di_"+idPregunta).val();
            	var estadoRespuesta = "";
            	
            	for (i = 0;i < matrizEstadosRespuestaContexto.length ;i++) {
            		if( matrizEstadosRespuestaContexto[i][0] == idPregunta ) {
            			estadoRespuesta = matrizEstadosRespuestaContexto[i][1];
            			break;
            		}	 
            	}

    		respuestasContexto = respuestasContexto + "~" + idPregunta + "|" + respuestaContexto + "|" + idDI + "|" + estadoRespuesta;
    	    });
    	    if (idDI>=0){
    			$.ajax({
    				type: 'POST',
        			url: 'utilitarios_ajax/guardar_contexto.tcl',
        			data: { respuestas_contexto: respuestasContexto },
        			dataType:'text', 
        			success: function(data){
        				if(diGuardado == false) {
        	    				
        	    				var arr_msj = int_msjExitoGuardado.split("[nombreDI]");
        	    				diGuardado = true;
        	    				alertDialog(arr_msj[0]+ nombreDI + arr_msj[1]);
        	    			}
        			} 
    			});
    	    }
    	    if (clonar) {
    			nombreDI = nombreDI_anterior;
				idDI = idDI_anterior;
				clonar = false;
			}
    	}
    });
    //cambiar el nombre del DI para cuando se va a exportar.
    $('#vistaDI').text($.trim(nombreDI));
    
}
/*
cargar DI
*/
function cargarDI(){
    var infoDI = "";
    $.ajax({
        type: 'POST',
        url: 'utilitarios_ajax/cargar_di.tcl',
        data: { di: idDI, cantidadSesiones: $("#cantidad_sesiones_param_post").val() },
        dataType:'text', 
        success: function(data){
            infoDI = data;
            var sesiones = infoDI.split('`');
            var cantidadFilas = sesiones.length;
            for (fila = 0; fila < cantidadFilas; fila++){
                var sesion = sesiones[fila];
                var columnas = sesion.split('^');
                var cantidadColumnas = columnas.length;
                for (columna = 0; columna < cantidadColumnas; columna++){
                    var componente = columnas[columna];
                    var elementos = componente.split('\\');
                    var cantidadElementos = elementos.length;
                    var valores = jQuery.makeArray();
                    var texto = "";
                    for (valor = 0; valor < cantidadElementos; valor++){
                        var elemento = $.trim(elementos[valor]);
                        if (tieneTexto(elemento)) {
                           valores[valor] = elemento;
                           texto = texto + elemento + "<br>";
                        }
                    }
                    di_matriz[fila][columna] = valores;
                    $('#DI_visualizar tr:eq('+(fila+1)+') td:eq('+(columna+1)+')').html(texto);
                }
            }
        }
    });
    $.ajax({
        type: 'POST',
        url: 'utilitarios_ajax/cargar_di_estado.tcl',
        data: { di: idDI, cantidadSesiones: $("#cantidad_sesiones_param_post").val() },
        dataType:'text', 
        success: function(data){
            var estados = data.split('-');
            var cantidadElementos = estados.length;
            var estado = 0;
            var fila = 0;
            var columna = 0;
            for (pos = 0; pos < cantidadElementos; pos++){
                estado = parseInt(estados[pos]);
                fila = ~~(pos/6);
                columna = pos%6;
                bolitas_matriz[fila][columna] = estado;
                var actual = (fila+1).toString()+'-'+(columna+1).toString();
                if(estado==1){
                    $('#'+actual).removeClass("bolita_vacia");
                    $('#'+actual).removeClass("bolita_pendiente");
	            $('#'+actual).removeClass("bolita_llena");
		    $('#'+actual).addClass("bolita_no_terminada");
                }
                else if(estado==2) {
                   // $('#instructional_design tr:eq('+(fila+1)+') \
                    // td:eq('+(columna+1)+') img.bolita').attr('src','/resources/tda-gdi/images/iconos/bolita_llena.png');
                    $('#'+actual).removeClass("bolita_vacia");
                    $('#'+actual).removeClass("bolita_pendiente");
		    $('#'+actual).removeClass("bolita_no_terminada");
		    $('#'+actual).addClass("bolita_llena");
                }
            }
       	    completado(false);
       	    for (filaActual=0;filaActual<=fila;filaActual++) {
       	    		actualizarEstadosDI();
       	    }
        }
    });
    diGuardado = true;
}

function borrarAreaTexto(num){
        observaciones = document.getElementById("observaciones");
        textarea_observaciones = observaciones.getElementsByTagName("textarea");
	if(textarea_observaciones.length==1) {
		$('#wizard_observaciones_'+num).val("");
	} else {
	        $('#wizard_observaciones_'+num).remove();
        	$('#btn_borrar_'+num).remove();
        }
}

function UpdateTableHeaders() {
       $(".persist-area").each(function() {
       
           var el             = $(this),
               offset         = el.offset(),
               scrollTop      = $(window).scrollTop(),
               floatingHeader = $(".floatingHeader", this)
           
           if ((scrollTop > offset.top) && (scrollTop < offset.top + el.height())) {
               floatingHeader.css({
                "visibility": "visible"
               });
           } else {
               floatingHeader.css({
                "visibility": "hidden"
               });
               $(".menu_items_session").slideUp('fast');      
           };
       });
    }

//Función utilizada para actualizar los elementos del DOM de la matriz una vez que hay un 
// cambio en la matriz.
function actualizarDisennoInstruccional(){
    var table = document.getElementById("instructional_design"); 
    var i = -1;
    $('#instructional_design tr').each(function(){
        if (i > 0) {
            $(this).children().first().find('span').text(i);
            $(this).removeClass();
            if ((i % 2) == 0) {
                $(this).addClass('even');    
            } else {
                $(this).addClass('odd');    
            }
            // actualizar los di de los div que están dentro de cada td
            var j = 0; 
            $(this).children().each(function () {
                $(this).find('div').attr('id',i+'-'+j);
                j++;
            });
        }
        i++;
    });  
}

//Esta función actualiza los estados de la matriz del DI
// a nivel lógico
function actualizarCache(oldIndex, newIndex){
    di_matriz.move(oldIndex, newIndex); 
    bolitas_matriz.move(oldIndex, newIndex);
}

Array.prototype.move = function (old_index, new_index) {
    while (old_index < 0) {
        old_index += this.length;
    }
    while (new_index < 0) {
        new_index += this.length;
    }
    if (new_index >= this.length) {
        var k = new_index - this.length;
        while ((k--) + 1) {
            this.push(undefined);
        }
    }
    this.splice(new_index, 0, this.splice(old_index, 1)[0]);
    return this; 
};

//Esta función actualiza los mínimos y máximos de los spinner para agregar y 
// eliminar sesiones
function actualizarSesiones(agregar_sesiones, eliminar_sesiones, sesiones) {
    agregar_sesiones.setMaxValue(32 - sesiones);
    agregar_sesiones.setMinValue(01);    
    
    agregar_sesiones.setSpinnerValue(01);
    eliminar_sesiones.setMaxValue(sesiones);
    eliminar_sesiones.setMinValue(01);
}
/*--------------------------------------------------------------Funciones ------------ fin ------*/

// ---------------------------------------------funciones jquery para di --fin--
