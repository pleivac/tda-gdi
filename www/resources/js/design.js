// ---------------------------------------------funciones jquery para design --inicio--

$(document).ready(function(){
	menuAnterior = 0;
	accionadoIconoMenu = true;
    //Controla el menú
	$("ul.menu li span").click(function() {
		tamTracking("tda-gdi", "Paso_3_Edicion_Menu", "Clic Ícono");
	    accionadoIconoMenu = false;
	    $("ul.menu li span").parent().find("ul.menu_items_menu").slideUp('fast')
		$(this).parent().find("ul.menu_items_menu").slideDown('fast').show();
		actualizarMenu(0);
		
		//$(this).parent().mousemove(function( event ) {
		$("#marco").mousemove(function( event ) {
			var offset = $( ".menu_items_menu" ).offset();
			var anchoMenu = $( ".menu_items_menu" ).width();
			var largoMenu = $( ".menu_items_menu" ).height();
			
			if ( ((offset.left - 2) > event.pageX || event.pageX > (offset.left + anchoMenu + 5)) 
					|| ((offset.top - 80) > event.pageY || event.pageY > (offset.top + largoMenu + 2))) {
				//alert("Sale Marco " + "( x = " + event.pageX + ", y = " + event.pageY + " )");
				window.setTimeout(function(){ actualizarMenu(menuAnterior)},180);
	
				$("ul.menu li span").parent().find("ul.menu_items_menu").slideUp('slow');
			}
		});
	});
	
	$().click(function() {
		$("#marco").mousemove(function( event ) {
			var offset = $( ".menu_items_menu" ).offset();
			var anchoMenu = $( ".menu_items_menu" ).width();
			var largoMenu = $( ".menu_items_menu" ).height();
			
			if ( ((offset.left - 2) > event.pageX || event.pageX > (offset.left + anchoMenu + 5)) 
					|| ((offset.top - 80) > event.pageY || event.pageY > (offset.top + largoMenu + 2))) {
				//alert("Sale Marco " + "( x = " + event.pageX + ", y = " + event.pageY + " )");
				$("ul.menu li span").parent().find("ul.menu_items_menu").slideUp('slow');
			}
		});
	});


	
    /// hace al usuario confirmar si sale o no del sitio.
    $(window).bind("beforeunload",function(event) {
       return "Nota: utilice únicamente los menús de la plataforma para navegar sobre ella... Si es el caso, guarde su trabajo antes de salir.";
    });
    

    //Menu, asigna la acción de cada uno. 
    $('#menu_nuevo').click(function(){
        window.location='index?opcion=0';
    });
    $('#menu_abrir').click(function(){
        window.location='index?opcion=1';
    });
    $('#menu_cerrar').click(function(){
        window.location='index';
    });
    $('#menu_guardar').click(function(){        
    });
    $('#menu_guardar_como').click(function(){
    });
    $('#menu_propiedades_documento').click(function(){
    });

// -------------Funcionalidad para activar los botones del index
    $("#menuMenu").parent().click(function() {
    	actualizarMenu(0);
    });
    
    
    $("#menuExportar").parent().click(function() {
    	$("ul.menu li span").parent().find("ul.menu_items_menu").slideUp('slow');
    	actualizarMenu(1);
	    // Volver menuAnterior;
	    window.setTimeout(function(){ actualizarMenu(menuAnterior)},385);
    });
    
	$("#menuPrograma").parent().click(function() {
		$("ul.menu li span").parent().find("ul.menu_items_menu").slideUp('slow');
     	actualizarMenu(2);
	    menuAnterior = 2;	    
    });
    
    
	$("#menuContexto").parent().click(function() {
		$("ul.menu li span").parent().find("ul.menu_items_menu").slideUp('slow');
     	actualizarMenu(3);
	    menuAnterior = 3;
    });
    
    $("#menuMatriz").parent().click(function() {
     	actualizarMenu(4);
	    menuAnterior = 4;
    });
    
	$("#marco #menu #menuAyuda").parent().click(function() {
		actualizarMenu(5);
		menuAnterior = 5;
	});
    
});

/* Funcion para mantener actualizadas los estados activos e inactivos, de los 
   elementos del menu principal 
   Los valores del menuSeleccionado deberian ser los siguientes:
		- 0: menuMenu
		- 1: menuExportar
		- 2: menuPrograma
		- 3: menuContexto
		- 4: menuMatriz
		- 5: menuAyuda
*/
function actualizarMenu(menuSeleccionado){
		// Inicialmente se desactivan todos los elementos -y subelementos asociados- del menu 	
			// Subelementos del menu principal
		$("#menuMenu").removeClass('btnMenu_activo');
	    $("#puntoMenu").removeClass('Activo');
	    $("#menuMenu").next().removeClass('textoActivo');
		    // Subelementos del menu para exportar el DI
	    $("#menuExportar").removeClass('btnExportar_activo');
	    $("#puntoExportar").removeClass('Activo');
	    $("#menuExportar").next().removeClass('textoActivo');
		    // Subelementos del menu para acceder al programa de curso asociado al curso
	    $("#menuPrograma").removeClass('btnPrograma_activo');
	    $("#puntoPrograma").removeClass('Activo');
	    $("#menuPrograma").next().removeClass('textoActivo');
		    // Subelementos del menu para acceder al contexto del DI
	    $("#menuContexto").removeClass('btnContexto_activo');
	    $("#puntoContexto").removeClass('Activo');
	    $("#menuContexto").next().removeClass('textoActivo');
	        // Subelementos del menu para acceder a la matriz del DI
	    $("#menuMatriz").removeClass('btnMatriz_activo');
	    $("#puntoMatriz").removeClass('Activo');
	    $("#menuMatriz").next().removeClass('textoActivo');
	        // Subelementos del menu para acceder a las ayudas del contexto
	    $("#menuAyuda").removeClass('btnAyuda_activo');
	    $("#puntoAyuda").removeClass('Activo');
	    $("#menuAyuda").next().removeClass('textoActivo');
	    
	    // Se activa el elemento (sus subelementos) pasado como parametro
	    switch(menuSeleccionado) {
	    	case 0:
	    		$("#menuMenu").addClass('btnMenu_activo');
	    		$("#menuMenu").next().addClass('textoActivo');
	    		$("#puntoMenu").addClass('Activo');
	    		break;
	    	case 1:
	    		$("#menuExportar").addClass('btnExportar_activo');
			    $("#menuExportar").next().addClass('textoActivo');
	    		$("#puntoExportar").addClass('Activo');
	    		break;
	    	case 2:
	    		$("#menuPrograma").addClass('btnPrograma_activo');
			    $("#menuPrograma").next().addClass('textoActivo');
	    		$("#puntoPrograma").addClass('Activo');
	    		break;
	    	case 3:
	    		$("#menuContexto").addClass('btnContexto_activo');
			    $("#menuContexto").next().addClass('textoActivo');
	    		$("#puntoContexto").addClass('Activo');
	    		break;
	    	case 4:
	    		$("#menuMatriz").addClass('btnMatriz_activo');
			    $("#menuMatriz").next().addClass('textoActivo');
	    		$("#puntoMatriz").addClass('Activo');
	    		break;
	    	case 5:
	    		$("#menuAyuda").addClass('btnAyuda_activo');
			    $("#menuAyuda").next().addClass('textoActivo');
	    		$("#puntoAyuda").addClass('Activo');
	    		break;
	    }
	    	
}
// ---------------------------------------------funciones jquery para design --fin--
