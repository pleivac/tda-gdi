// ---------------------------------------------funciones jquery para pagina_principal --inicio--

$(document).ready(function(){
	var diExistente = false;
	//lenguaje 0 = ingles
	//lenguaje 1 = espannol
	lenguaje = $("#language").val();

    $('#menu-left').css('z-index','-1');

	    
	$('#menuCrearDI').hide();
	

	//Muestra los botones específicos de la pantalla
	$("#menuSiguiente").parent().removeClass('oculto');
	

	if (lenguaje == 0) {
		$('#menuDesplazamiento').removeClass('btnSiguiente');
		$('#menuDesplazamiento').addClass('btnNext');
	}
	//Verifica si el invoco la pagina para abrir o crear un nuevo DI/
	$(function(){    
		var opcion = obtener_parametros_url()[0].split('=');
		//opcion=0 == Nuevo DI.
		//opcion=1 == Abrir DI. 
		
		$("#seleccionar_di").parent().parent().addClass('oculto');
		seleccionar_di_html.hide();
		if(opcion[0] == "opcion"){
			//$('#menuDesplazamiento').text('Anterior');
			$( "#tabs" ).tabs({selected:1});
			switch (opcion[1]) {
				case "0":
			//OJO cambio
			//Muestra los siguientes elementos        
					$("#menuNuevo").parent().removeClass('oculto');
					$("#menuAbrir").parent().removeClass('oculto');
					if (lenguaje == 0)
					$('#menuDesplazamiento').addClass('btnBack');
					else 
					$('#menuDesplazamiento').addClass('btnAtras');
					$('#menuDesplazamiento').removeClass('btnSiguiente');
					$('#menuDesplazamiento').removeClass('btnNext');
					$('#menuDesplazamiento').attr('value','a');
					$('#paso_1').css('display','none');
					$('#paso_2').css('display','block');
					$("#menuCrearDI").removeClass('oculto');
					$("#txtAbrir").addClass('txtSeleccion');
					
					$("#menuNuevo").addClass('btnNuevo_activo');
					$("#menuNuevo").next().addClass('textoActivo');
					$("#puntoNuevo").addClass('Activo');
					$("#txtNuevo").removeClass('oculto');
					//Oculta los siguientes elementos
					$("#menuAyuda").removeClass('btnAyuda_activo');
					$("#puntoAyuda").removeClass('Activo');
					$("#menuAyuda").next().removeClass('textoActivo');
					$("#menuMenu").removeClass('btnMenu_activo');
					$("#puntoMenu").removeClass('Activo');
					$("#menuMenu").next().removeClass('textoActivo');
					$("#menuAbrir").removeClass('btnAbrir_activo');
					$("#puntoAbrir").removeClass('Activo');    
					$("#menuAbrir").next().removeClass('textoActivo');
					
					$("#txtAbrir").addClass('oculto');
					break
				case "1":
				//Muestra los siguientes elementos        
					$("#menuNuevo").parent().removeClass('oculto');
					$("#menuAbrir").parent().removeClass('oculto');
					if (lenguaje == 0)
						$('#menuDesplazamiento').addClass('btnBack');
					else 
						$('#menuDesplazamiento').addClass('btnAtras');
					$('#menuDesplazamiento').removeClass('btnSiguiente');
					$('#menuDesplazamiento').removeClass('btnNext');
					$('#menuDesplazamiento').attr('value','a');
					
					$('#paso_1').css('display','none');
					$('#paso_2').css('display','block');
					
					$("#menuCrearDI").removeClass('oculto');
					$("#txtAbrir").addClass('txtSeleccion');
					$("#txtNuevo").removeClass('oculto');
					//Oculta los siguientes elementos
					$("#menuAyuda").removeClass('btnAyuda_activo');
					$("#puntoAyuda").removeClass('Activo');
					$("#menuAyuda").next().removeClass('textoActivo');
					$("#menuMenu").removeClass('btnMenu_activo');
					$("#puntoMenu").removeClass('Activo');
					$("#menuMenu").next().removeClass('textoActivo');
					$("#menuAbrir").removeClass('btnAbrir_activo');
					$("#puntoAbrir").removeClass('Activo');    
					$("#menuAbrir").next().removeClass('textoActivo');					
					$("#txtAbrir").addClass('oculto');
					$("#menuAbrir").addClass('btnAbrir_activo');
					$("#menuAbrir").next().addClass('textoActivo');
					$("#puntoAbrir").addClass('Activo');
					$("#txtAbrir").addClass('txtSeleccion');
					$("#txtNuevo").removeClass('txtSeleccion');
					$("#seleccionar_curso").parent().parent().addClass('oculto');
					$("#form_seleccion_buscar_curso").addClass('oculto');
					$("#seleccionar_di").removeClass('oculto');

					seleccionar_di_html.show();
					seleccionar_curso_html.hide();

					$("#txtAbrir").removeClass('oculto');
					$("#txtNuevo").addClass('oculto');
					//$("index_div_mostrar_existente").
					//Desactiva los siguientes elementos    
					$("#puntoMenu").removeClass('Activo');    
					$("#menuMenu").next().removeClass('textoActivo');
					$("#menuAyuda").removeClass('btnAyuda_activo');
					$("#puntoAyuda").removeClass('Activo');    
					$("#menuAyuda").next().removeClass('textoActivo');
					$("#menuNuevo").removeClass('btnNuevo_activo');
					$("#puntoNuevo").removeClass('Activo');    
					$("#menuNuevo").next().removeClass('textoActivo');
					
					break
		   }
		}
	});
	
	//crea un div en el form, para que este oculto o no.
	$('#form_seleccion .form-item-wrapper').filter(':first').after('<div id=\"div_buscar_otros\"></div>');
	//acomoda los selects para que unos esten el el div oculto y otros no
	$('#form_seleccion_buscar_curso').appendTo('#div_buscar_otros');
	//agrega una nota luego del form anterior
	if (lenguaje == 0)
		$('#div_buscar_otros .form-item-wrapper').filter(':last').after('<span class=\"nota\">* Información Requerida.</span>');
	else
		$('#div_buscar_otros .form-item-wrapper').filter(':last').after('<span class=\"nota\">* Requiered Information</span>');
	//agrega una nota luego del form anterior
	$('#div_buscar_otros .form-button').find('input').val('Buscar');

  
	//si selecciona la un curso que imparta en este momento, oculta el formulario para buscar otros cursos.
	$('.select_index_propios').click(function() {
		$('#div_buscar_otros').slideUp('slow');

		tamTracking("tda-gdi", "Paso_2_Seleccion", "Clic Ícono");
	});

	// cambia el tab cuando se cliquea el botón	
	
	
		$("#menuDesplazamiento").click(function() {
		
		$('#info_di').hide();
		$('#div_buscar_otros').slideUp();
		$('#seleccionar_carrera, #seleccionar_plan, #seleccionar_materia').val('label');    
		$('#seleccionar_curso').val('etiqueta');
		$('#info_curso').hide();
		$('#menuCrearDI').hide();
		$('#seleccionar_di').val('etiqueta');
		$('#index_botones1').removeClass('menuBotonesRight').addClass('menuBotones');
			
		if ($('#menuDesplazamiento').attr('value') == 's' ) {

			tamTracking("tda-gdi", "Paso_1_Bienvenida", "Clic Botón");
	//Muestra los siguientes elementos        
			$("#menuNuevo").parent().removeClass('oculto');
			$("#menuAbrir").parent().removeClass('oculto');
			if (lenguaje == 0)
				$('#menuDesplazamiento').addClass('btnBack');
			else 
				$('#menuDesplazamiento').addClass('btnAtras');
			$('#menuDesplazamiento').removeClass('btnSiguiente');
			$('#menuDesplazamiento').removeClass('btnNext');
			$('#menuDesplazamiento').attr('value','a');
			$('#paso_1').css('display','none');
			$('#paso_2').css('display','block');
			$("#menuCrearDI").removeClass('oculto');
			$("#txtAbrir").addClass('txtSeleccion');
			
			$("#menuNuevo").addClass('btnNuevo_activo');
			$("#menuNuevo").next().addClass('textoActivo');
			$("#puntoNuevo").addClass('Activo');
			
			 $("#txtNuevo").removeClass('oculto');
	
	//Oculta los siguientes elementos
			$("#menuAyuda").removeClass('btnAyuda_activo');
			$("#puntoAyuda").removeClass('Activo');
			$("#menuAyuda").next().removeClass('textoActivo');
			$("#menuMenu").removeClass('btnMenu_activo');
			$("#puntoMenu").removeClass('Activo');
			$("#menuMenu").next().removeClass('textoActivo');
			$("#menuAbrir").removeClass('btnAbrir_activo');
			$("#puntoAbrir").removeClass('Activo');    
			$("#menuAbrir").next().removeClass('textoActivo');
			
			$("#txtAbrir").addClass('oculto');
			seleccionar_di_html.hide();
			// $("#seleccionar_curso").parent().parent().removeClass('oculto');
			seleccionar_curso_html.show();
			// $("#seleccionar_di").parent().parent().addClass('oculto');

			
			$.ajax({
				type: 'POST',
				url: 'utilitarios_ajax/agregar_nombre.tcl',
				data: 'nom_usuario=' + $('#nombre_profesor').val(),
				dataType:'text', 
				success: function(data){
				}
			});
		}
		else {
			tamTracking("tda-gdi", "Paso_2_Seleccion_Abrir", "Clic Botón");

			$("#menuNuevo").parent().addClass('oculto');
				$("#menuAbrir").parent().addClass('oculto');	
			if (lenguaje == 0)
				$('#menuDesplazamiento').addClass('btnNext');
			else
				$('#menuDesplazamiento').addClass('btnSiguiente');
			$('#menuDesplazamiento').removeClass('btnAtras');
			$('#menuDesplazamiento').removeClass('btnBack');
			$('#menuDesplazamiento').attr('value','s');
			$('#paso_2').css('display','none');
			$('#paso_1').css('display','block');
			$("#menuCrearDI").addClass('oculto');
			
			
	//Oculta los siguientes elementos
			$("#menuAyuda").removeClass('btnAyuda_activo');
			$("#puntoAyuda").removeClass('Activo');
			$("#menuAyuda").next().removeClass('textoActivo');
			$("#menuMenu").removeClass('btnMenu_activo');
			$("#puntoMenu").removeClass('Activo');
			$("#menuMenu").next().removeClass('textoActivo');
			$("#puntoAbrir").removeClass('Activo');    
			$("#menuAbrir").next().removeClass('textoActivo');
			$("#menuAbrir").next().removeClass('textoActivo');
			$("#menuNuevo").removeClass('btnNuevo_activo');
			$("#puntoNuevo").removeClass('Activo');    
			$("#menuNuevo").next().removeClass('textoActivo');
		}
	});

	
	var seleccionar_di = new tds_lib.Select(document.getElementsByClassName("tds-lib_form_select")[4]);
	var seleccionar_di_html = $('.tds-lib_form_select').last();
	seleccionar_di_html.hide();
	
	if (lenguaje == 0) {
		seleccionar_di.prepend("etiqueta", "Select an option");
	} else {
		seleccionar_di.prepend("etiqueta", "Seleccione una opción");
	}

	seleccionar_di.setActiveOption("etiqueta");
	//Para mostrar la información de un DI existente
	seleccionar_di.onChangeOption(function(){
		if (seleccionar_di.getSelectValue() == "0" || seleccionar_di.getSelectValue() == 0) {
			$("select#seleccionar_materia")[0].selectedIndex = 0;
		 } else if (seleccionar_di.getSelectValue() =="etiqueta") {
			alertDialog("Seleccione una opción válida");
		 } else {
				$.ajax({
					type: 'POST',
					url: 'utilitarios_ajax/mostrar_datos_di.tcl',
					data: 'datosDI=' + seleccionar_di.getSelectValue(),
					dataType:'text', 
					success: function(data){
							$('#info_di #info_di_body tr').remove();
							$('#info_di #info_di_body').append(data);
				}});
				$('#info_curso').hide();
				$('#index_botones1').removeClass('menuBotonesRight').addClass('menuBotones'); 
				$('#info_di').show('slow');
				if (lenguaje == 0)
					$('#menuCrearDI').attr('class', 'btnOpenID btnStyle tds-lib_form');
				else 
					$('#menuCrearDI').attr('class', 'btnAbrirDI btnStyle tds-lib_form');
				diExistente = true;
				$('#menuCrearDI').show();
				$('#index_botones1').removeClass('menuBotones').addClass('menuBotonesRight'); 
				
				tamTracking("tda-gdi", "Paso_2_Seleccion_Abrir", "Selección Combobox");
		}
	});
	//Para que realice la búsqueda cuando se escoge un curso diferente, que no está dando
	$('#form_seleccion_buscar_curso .form-button formbutton:ok').click(function(){
		$('#contenidoCONF').show('slow');
		 if (lenguaje == 0)
				$('#menuCrearDI').attr('class', 'btnOpenID btnStyle tds-lib_form');
			else 
				$('#menuCrearDI').attr('class', 'btnAbrirDI btnStyle tds-lib_form'); 
		 diExistente = true;
		 $('#menuCrearDI').show();

		 tamTracking("tda-gdi", "Paso_2_Seleccion_Abrir", "Selección Combobox");
	});
	
	//Para mostrar la información del curso que está dando y fue seleccionado
	var seleccionar_curso = new tds_lib.Select(document.getElementsByClassName("tds-lib_form_select")[0]);
	var seleccionar_carrera = new tds_lib.Select(document.getElementsByClassName("tds-lib_form_select")[1]);
	var seleccionar_plan = new tds_lib.Select(document.getElementsByClassName("tds-lib_form_select")[2]);
	var seleccionar_materia = new tds_lib.Select(document.getElementsByClassName("tds-lib_form_select")[3]);

	
	if (lenguaje == 0) {
		// seleccionar_curso.prepend('<span value="N">New Course</span>');
		// seleccionar_curso.prepend('<span value="etiqueta">Select an option</span>');
		seleccionar_curso.prepend("N", "New Course");
		seleccionar_curso.prepend("etiqueta", "Select an option");

		seleccionar_carrera.prepend("etiqueta", "Select an option");
		//se agrega la opción para que busque otros cursos.
		//seleccionar_curso.append('<option value=\"seleccionar_curso\" class=\"select_index_otros\" >Find other couses</option>');
		seleccionar_curso.addOption("seleccionar_curso","Find other couses");
	} else {
		//seleccionar_curso.prepend('<span value="N">Curso Nuevo</span>');
		//seleccionar_curso.prepend('<span value="etiqueta">Seleccione una opci&oacuten</span>');
		seleccionar_curso.prepend("N", "Curso Nuevo");
		seleccionar_curso.prepend("etiqueta", "Seleccione una opción");
		
		seleccionar_carrera.prepend("etiqueta", "Seleccione una opción");
		// seleccionar_plan.prepend("etiqueta", "Seleccione una opción");
		// seleccionar_materia.prepend("etiqueta", "Seleccione una opción");
		// //se agrega la opción para que busque otros cursos.
		// //seleccionar_curso.append('<option value=\"seleccionar_curso\" class=\"select_index_otros\" >Buscar otros cursos</option>');
		seleccionar_curso.addOption("seleccionar_curso","Buscar otros cursos");
	}

	//workaround para agregar css a una opción del select 
	var seleccionar_curso_referencia = $('.tds-lib_form_select').first().find('div');
	seleccionar_curso_referencia.children('span').last().addClass("select_index_otros");
	seleccionar_curso.setActiveOption("etiqueta");
	var seleccionar_curso_html = $('.tds-lib_form_select').first();

	// $('#seleccionar_curso').change(function(){
	seleccionar_curso.onChangeOption(function(){
		if (seleccionar_curso.getSelectValue() == "0" || seleccionar_curso.getSelectValue() == 0) {
			alertDialog("Debe seleccionar un curso.");
			$("select#seleccionar_materia")[0].selectedIndex = 0;
			$('#div_buscar_otros').slideUp('slow');
		 } else if (seleccionar_curso.getSelectValue() == "seleccionar_curso"){
			$('#div_buscar_otros').slideDown('slow');

			seleccionar_carrera.setActiveOption("etiqueta");
			seleccionar_plan.setActiveOption("etiqueta");
			seleccionar_materia.setActiveOption("etiqueta");

			tamTracking("tda-gdi", "Paso_2_Seleccion_Nuevo", "Selección Combobox");
		 } else if (seleccionar_curso.getSelectValue() =="N") {    
			//implementacion del pop_up para mostrar la opcion de crear di para un curso que no existe en el tecnologico
			$("#index_div_nuevo_inexistente").bPopup({
			content: "html"
				, modal: true
				, closeClass: 'boton_cerrar_popup'
				, modalColor: 'white'
			});
			tamTracking("tda-gdi", "Paso_2_Seleccion_Nuevo", "Selección Combobox");
			$('#div_buscar_otros').slideUp('slow');
		  } else if (seleccionar_curso.getSelectValue()=="etiqueta") {
			alertDialog("Seleccione una opción válida");
		  } else {
				$.ajax({
					type: 'POST',
					url: 'utilitarios_ajax/mostrar_datos_curso.tcl',
					data: 'datosCurso=' + seleccionar_curso.getSelectValue(),
					dataType:'text', 
					success: function(data){
						$('#info_curso #info_curso_body tr').remove();
						$('#info_curso #info_curso_body').append(data);
				}});    
		   // $('#index_button_func').html("<img id=\"index_button_func_crear_di\" class=\"boton\" src=\"/resources/tda-gdi/images/iconos/btn-crear-di1.png\"/>");
				if (lenguaje == 0) 
					$('#menuCrearDI').attr('class', 'btnMakeID btnStyle tds-lib_form');
				else
					$('#menuCrearDI').attr('class', 'btnCrearDI btnStyle tds-lib_form'); 
				diExistente = false;
				$('#menuCrearDI').show();
				$('#info_curso').show('slow');
				$('#index_botones1').attr('class','menuBotonesRight');
				$('#info_di').hide();
				tamTracking("tda-gdi", "Paso_2_Seleccion_Nuevo", "Selección Combobox");
		  }
		  ///$('#div_buscar_otros').slideUp('slow');
		  console.log("txt_explicativo_propiedades");
	});
	
	//función que realiza cuando se preciona el botón menuCrearDI
	$('#menuCrearDI').click(function(){
		tamTracking("tda-gdi", "Paso_2_Seleccion_Crear", "Clic Botón");
		if(diExistente) {
			var cantidadSesiones = 0;
			$.ajax({
				type: 'POST',
				url: 'utilitarios_ajax/obtenerCantidadSesionesDI.tcl',
				data: 'di=' + $('#seleccionar_di option:selected').val(),
				dataType:'text', 
				success: function(data){
					cantidadSesiones = data;
					//window.location='design?opcion=0&di='+$('#seleccionar_di option:selected').val()+"&nombre_curso="+$.trim($('#info_di_body tr:first td:nth-child(2)').text())+'&cantidad_sesiones='+cantidadSesiones+"&curso="+$.trim($('#info_di #info_di_body tr td:first').text())+"&plan="+$.trim($('#info_di_body tr:first td:nth-child(3)').text());
					var codigoCurso = $.trim($('#info_di #info_di_body tr td:first').text());
					var planEstudios = $.trim($('#info_di_body tr:first td:nth-child(3)').text());
					if(codigoCurso == "No aplica" || codigoCurso == "No apply"){
						codigoCurso = -1;
					}
					if(planEstudios == "No aplica" || codigoCurso == "No apply"){
						planEstudios = -1;
					}
					/*
						Se selecciona un elemento del combo de DI creado.
					*/ 
					post("design", {
						opcion:0,
						di:$('#seleccionar_di option:selected').val(),
						nombre_curso:$.trim($('#info_di_body tr:first td:nth-child(2)').text()),
						cantidad_sesiones:cantidadSesiones,
						codigo:codigoCurso,
						plan:planEstudios,
						escuela:$.trim($('#info_di_body tr:first td:nth-child(3)').text()),
						es_di:"true",
						nombreEscuela:$.trim($('#info_di_body tr:first td:nth-child(3)').text())
					});
				}});		
		} else { // Cuando no se ha creado el DI pero el curso fue seleccionado desde la seccion depto, plan, cursos (Curso existente en la malla curricular)
			// Implementacion del pop up para asignar las sesiones al curso 
			tamTracking("tda-gdi", "Paso_2_Seleccion_Crear", "Clic Botón");
			$("#index_div_mostrar_existente").bPopup({
				content: "html"
				, modal: true
				, closeClass: 'boton_cerrar_popup'
				, modalColor: 'white'
			});
		
		// tratamiento para que el input nombre_curso_label no sea editable, el tamannio y sin borde.
			$("#nombre_curso_label").val($.trim( $("#info_curso_body #resultados_nombre").text()));
			var largoNombreCurso = $.trim( $('#info_curso_body #resultados_nombre').text() ).length;
			$('#nombre_curso_label').attr("size", largoNombreCurso);
			$("#nombre_curso_label").css("border", "none");
			$('#nombre_curso_label').attr("readonly", true);
		
			if ($("#nombre_curso_label").val() == ""){
				$("#nombre_curso_label").val($("#seleccionar_curso :selected").text());
			}
			$("#menuPrograma").addClass('btnPrograma_activo');
			$("#menuPrograma").next().addClass('textoActivo');
			$("#puntoPrograma").addClass('Activo');
		
		
			$('#btn_crear_di').click(function () { 
				tamTracking("tda-gdi", "Paso_2_Seleccion_Crear", "Clic Botón");
				plan = $('#seleccionar_plan').val();	
				if(plan == "label") {
					plan = $('#resultados_plan_estudios').val();
				}
			
				var codigoTemp = $.trim($('#info_curso_body #resultados_funcion').text());
				if (codigoTemp == "") {
					codigoTemp = $("#seleccionar_curso :selected").val().split(".");
					codigoTemp = codigoTemp[0];
				}
				
				post("design", {
					opcion:1,
					di:-1,
					nombre_curso:$('#nombre_curso_label').val(),
					cantidad_sesiones:$('#cantidad_sesiones_asignar').val(),
					codigo:codigoTemp,
					escuela:$('#resultado_escuela').text(),
					plan:plan,
					es_di:"true", 
					nombreEscuela: $('#resultado_escuela').text()
				});
			 
					//Activar el botón de programa 
				$("#menuMatriz").addClass('btnMatriz_activo');
				$("#menuMatriz").next().addClass('textoActivo');
				$("#puntoMatriz").addClass('Activo');
			});
		}
	});
	
	$("#menuNuevo").parent().click(function() {
		$("#txtNuevo").addClass('txtSeleccion');
		$("#txtAbrir").removeClass('txtSeleccion');
		$("#seleccionar_curso").parent().parent().removeClass('oculto');
		$("#seleccionar_di").parent().parent().addClass('oculto');
		$("#form_seleccion_buscar_curso").removeClass('oculto');
		seleccionar_di_html.hide();
		seleccionar_curso_html.show();

		$('#info_di').hide();
		$('#menuCrearDI').hide();
		$('#index_botones1').removeClass('menuBotonesRight').addClass('menuBotones');     
		$('#div_buscar_otros').hide();
		$('#seleccionar_carrera, #seleccionar_plan, #seleccionar_materia').val('label');    
		seleccionar_curso.setActiveOption("etiqueta");
		tamTracking("tda-gdi", "Paso_2_Seleccion_Crear", "Clic Ícono");
	});
  
	$("#menuAbrir").parent().click(function() {
		$("#txtAbrir").addClass('txtSeleccion');
		$("#txtNuevo").removeClass('txtSeleccion');
		$("#seleccionar_curso").parent().parent().addClass('oculto');
		$("#form_seleccion_buscar_curso").addClass('oculto');
		$("#seleccionar_di").parent().parent().removeClass('oculto');
		// $("#seleccionar_di").removeClass('oculto');
		seleccionar_di_html.show();
		seleccionar_curso_html.hide();
		seleccionar_di.setActiveOption("etiqueta");
		
		$('#info_curso').hide();
		$('#menuCrearDI').hide();
		$('#index_botones1').removeClass('menuBotonesRight').addClass('menuBotones');    
			
		$('#seleccionar_di').val('etiqueta');
		$('#seleccionar_di').show();
		$('#div_buscar_otros').slideUp('fast');
		tamTracking("tda-gdi", "Paso_2_Seleccion_Abrir", "Clic Ícono");
	});
  
	//$("select#seleccionar_carrera")[0].selectedIndex = 0;
	//$("select#seleccionar_plan")[0].selectedIndex    = 0;
	//$("select#seleccionar_materia")[0].selectedIndex = 0; 
	
	//$("#seleccionar_carrera").change(function(){
	seleccionar_carrera.onChangeOption(function(){
		if (seleccionar_carrera.getSelectValue() == "label")
			alertDialog("Debe seleccionar una Escuela")
		else {
			$.ajax({
				type: 'POST',
				url: 'utilitarios_ajax/refrescar_formulario',
				data: 'tipo=plan&carrera='+seleccionar_carrera.getSelectValue(),
				dataType:'text', 
				success: function(data){
					seleccionar_plan.load(data);
			}});
		}
		tamTracking("tda-gdi", "Paso_2_Seleccion_Crear", "Selección Combobox");
	});

	//$("#seleccionar_plan").change(function(){
	seleccionar_plan.onChangeOption(function(){
		if (seleccionar_plan.getSelectValue() == "label")
			alertDialog("Debe seleccionar un Plan")
		else {
			console.log(seleccionar_plan.getSelectValue());
			$.ajax({
				type: 'POST',
				url: 'utilitarios_ajax/refrescar_formulario',
				data: 'tipo=materia&plan='+seleccionar_plan.getSelectValue(),
				dataType:'text', 
				success: function(data){
					seleccionar_materia.load(data);
					//workaround para agregar css a una opción del select 
					//seleccionar_materia_referencia = $('#div_buscar_otros').find('.tds-lib_form_select').last().find('div');
					//seleccionar_materia_referencia.children('span').last().addClass("select_index_otros");
					var seleccionar_materia_referencia = document.getElementsByClassName("tds-lib_form_select")[3];
					$(seleccionar_materia_referencia).find('span[value*="tPER"]').addClass('periodo');
					console.log($(seleccionar_materia_referencia).html());
				}});
			//$("#seleccionar_materia").load('utilitarios_ajax/refrescar_formulario?tipo=materia&plan='+$("#seleccionar_plan").val(), function() {
			//$('#seleccionar_materia option[value*="tPER"]').addClass('periodo');
		}
		//$("select#seleccionar_materia")[0].selectedIndex = 0;
		tamTracking("tda-gdi", "Paso_2_Seleccion_Crear", "Selección Combobox");
	});
	
	//$("#seleccionar_materia").change(function(){
	seleccionar_materia.onChangeOption(function(){
		if (seleccionar_materia.getSelectValue() == "label" || seleccionar_materia.getSelectValue() == "tPER") {
			alertDialog("Debe seleccionar una Materia");
			$("select#seleccionar_materia")[0].selectedIndex = 0;
		} else {
			$.ajax({
				type: 'POST',
				url: 'utilitarios_ajax/mostrar_datos_curso.tcl',
				data: { datosCurso: seleccionar_materia.getSelectValue(), tipoConsulta: 2},
				dataType:'text', 
				success: function(data){
					$('#info_curso #info_curso_body tr').remove();
					$('#info_curso #info_curso_body').append(data);
					$('#resultado_escuela').text(seleccionar_carrera.getSelectText());
			}});
			if (lenguaje == 0) 
				$('#menuCrearDI').attr('class', 'btnMakeID btnStyle tds-lib_form');
			else
				$('#menuCrearDI').attr('class', 'btnCrearDI btnStyle tds-lib_form'); 
			diExistente = false;
			$('#menuCrearDI').show();
			$('#info_curso').show('slow');
			$('#index_botones1').removeClass('menuBotones').addClass('menuBotonesRight');
			$('#info_di').hide();
			tamTracking("tda-gdi", "Paso_2_Seleccion_Crear", "Selección Combobox");
		}
	});
	
	// IMPLEMENTACION DE LOS CONTROLES Y FUNCIONALIDAD PARA EL MANEJO DE LAS SESIONES #form_crear_di_curso_inexistente
	var cantidad_sesiones = new tds_lib.Spinner(document.getElementsByClassName("tds-lib_form_spinner")[0]);
	cantidad_sesiones.setMaxValue(32);
	cantidad_sesiones.setMinValue(01);
	cantidad_sesiones.setSpinnerValue(01);


	var cantidad_sesiones_asignar = new tds_lib.Spinner(document.getElementsByClassName("tds-lib_form_spinner")[1]);
	cantidad_sesiones_asignar.setMaxValue(32);
	cantidad_sesiones_asignar.setMinValue(01);
	cantidad_sesiones_asignar.setSpinnerValue(01);
   
	// Redireccion al wizard Disennio instruccional 
	$('#btn_crear_di_inexistente').click(function(){
		tamTracking("tda-gdi", "Paso_2_Seleccion_Crear", "Clic Botón");
		if( tieneTexto($("#nombre_curso").val()) ){
			post("design", {
				opcion:3,
						di:-1,
						nombre_curso:$('#nombre_curso').val(),
						cantidad_sesiones:$('#cantidad_sesiones').val(),
						codigo:-1,
						plan:-1,
						escuela:-1,
						es_di:"true"
				});
		} else
			alertDialog("Inserte un valor para el Nombre del Curso");
	});
});

//Funcion para implementar una redireccion con paso de parametros por medio de un POST
// Utiliza el submit de un formulario temporal para el paso de las variables 
/*
Forma de uso:
post("example", { // o bien "http:example.com"
	param:"param",
	param_number:60,
	param_another:"anotherParam"
});
*/
function post(URL, PARAMS) {
	var temp=document.createElement("form");
	temp.action=URL;
	temp.method="POST";
	temp.style.display="none";
	for(var x in PARAMS) {
		var opt=document.createElement("textarea");
		opt.name=x;
		opt.value=PARAMS[x];
		temp.appendChild(opt);
	}
	document.body.appendChild(temp);
	temp.submit();
	return temp;
}

function clickPropiedadesDI(identificadorDI) {
	tamTracking("tda-gdi", "Paso_2_Seleccion_Abrir", "Clic Botón");
	$("#form_propiedades_documento").bPopup({
		modal: true
		, onOpen: function () {
			$("#tbl_propiedades_asociar tr > td").parent().remove(); 
			$.ajax({
				type: 'POST',
				url: 'utilitarios_ajax/obtenerPropiedadesDI.tcl',
				data: { idDi:  identificadorDI } , 
				dataType:'text', 
				success: function(data){
					console.log(data+" esos son los datos del data")
					var arregloData = data.split("*");
					$("#propiedades_nombre_di").val(arregloData[0]);
					$("#propiedades_nombre_di").attr("size",(arregloData[0].length+7));
					$("#propiedades_nombre_curso").val(arregloData[1]);
					$("#propiedades_nombre_curso").attr("size",(arregloData[1].length+10));
					
					if (arregloData[2]=="-1")
						$("#propiedades_escuela").val("No aplica");
					else {
						$("#propiedades_escuela").val(arregloData[2]);
						$("#propiedades_escuela").attr("size",(arregloData[2].length+7));
					}
					
					$("#propiedades_nombre_usuario").val(arregloData[3]);
					$("#propiedades_nombre_usuario").attr("size",(arregloData[3].length+7));
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
						$("#tbl_propiedades_asociar tr:last").after('<tr><td colspan="3"> Sin cursos asociados </td></tr>');
					}
					$("#txt_explicativo_propiedades").css("visibility","hidden");
				}
			});
		}
		, closeClass: 'propiedades_btn_cerrar'
		, modalColor: 'white'
	});
}

function tieneTexto(texto) {  
	for ( caracter = 0; caracter < texto.length; caracter++ ) {  
		if ( texto.charAt(caracter) != " " ) {  
			return true;  
		}  
	}  
	return false;
}  

tds_lib.Select.prototype.prepend = function(value,text){

	if(value!="" && text !=0){
		var spanNode=document.createElement("span");

		var valueAtt=document.createAttribute("value");
		valueAtt.value=value;
		spanNode.setAttributeNode(valueAtt);

		var textNode=document.createTextNode(text);
		spanNode.appendChild(textNode);

			/*To call a prototype function from a another prototype function
			 it is necessary to add the object "this". For Example "this.myFunction()"
			 In this case we call a prototype function from a event, so it's necessary
			 to "backup" the "this" object in the variable "self" to use it inside the event
			 because the object "this" in the event is the element that is associated to the event*/
			 var self = this;
			 spanNode.addEventListener("click",function(){
			 	/*Here we use "self" because it contains the "this" object that we need*/
			 	self.asignOptionValue(this);
			 },false);

			//this._element.children[2].appendChild(spanNode);
			this._element.children[2].insertBefore(spanNode, this._element.children[2].childNodes[0]);

				//if only cotains one option, set it as active.
				if(this._element.children[2].children){
					if(this._element.children[2].children.length==1){
						
						this.setActiveOption(value);

					}
				}
			}
		}


tds_lib.Select.prototype.load = function(json){
	var object = JSON.parse(json),
		length = Object.keys(object).length;
	this.removeAll();
	this.addOption("label",object.label);
	for (var key in object) {
  		if (object.hasOwnProperty(key)) {
  			if (key != "label" && object[key] != "tPER")
    			this.addOption(key,key+" - "+object[key]);
    		else if (object[key] == "tPER")
    			this.addOption(object[key],key);
  		}
	}
}


// ---------------------------------------------funciones jquery para pagina_principal --fin--
