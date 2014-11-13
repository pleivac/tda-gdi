// ---------------------------------------------funciones jquery para index --inicio--
$(document).ready(function(){
	// INTEGRACION RATINGS
    var elemt_rating = $(".tda-ratings-paquetes");
    tamTracking(elemt_rating.attr('package_key'), elemt_rating.attr('instance_name'), elemt_rating.attr('subsector_visitado')) ;
    elemt_rating.calificar_paquete();
    // FIN INTEGRACION RATINGS

    //Controla el menú
	$("ul.menu li span").click(function() {
		$(this).parent().find("ul.menu_items_menu").slideDown('fast').show();
		$(this).parent().hover(  function() {}, function() {$(this).parent().find("ul.menu_items_menu").slideUp('slow'); }  );
		tamTracking("tda-gdi", "Paso_1", "Clic Ícono");

	});


    //Muestra los botones específicos de la pantalla
     $("#menuMenu").parent().parent().removeClass('oculto');
     $("#menuAyuda").parent().removeClass('oculto');

    

    //Menu, cambia los links que está habilitados o no.
    $('#menu_nuevo').click(function(){
        window.location='index?opcion=0';
    });
    $('#menu_abrir').click(function(){
        window.location='index?opcion=1';
    });
    
    $('#compartir').hide();
	$( "#progressbar" ).progressbar({
	    value: 0
	});
	

// -------------Funcionalidad para activar los botones del index

 //Funcionamiento del botón de Menu del menú principal
    $("#menuMenu").parent().click(function() {
	    $("#menuMenu").addClass('btnMenu_activo');
	    $("#menuMenu").next().addClass('textoActivo');
	    $("#puntoMenu").addClass('Activo');
   //Desactiva los siguientes elementos	        
	    $("#menuAyuda").removeClass('btnAyuda_activo');
	    $("#puntoAyuda").removeClass('Activo');    
	    $("#menuAyuda").next().removeClass('textoActivo');
	    $("#menuAbrir").removeClass('btnAbrir_activo');
	    $("#puntoAbrir").removeClass('Activo');    
	    $("#menuAbrir").next().removeClass('textoActivo');
 	    $("#menuNuevo").removeClass('btnNuevo_activo');
	    $("#puntoNuevo").removeClass('Activo');    
	    $("#menuNuevo").next().removeClass('textoActivo');
    });
    
    
 //Funcionamiento del botón de Ayuda del menú principal
    $("#menuAyuda").parent().hide();
    $("#menuAyuda").parent().click(function() {
    
    //Activa los siguientes elementos
	    $("#menuAyuda").addClass('btnAyuda_activo');
	    $("#menuAyuda").next().addClass('textoActivo');
	    $("#puntoAyuda").addClass('Activo');
	    $('#contenedor #div_ayuda_di').show(); //NO ESTA MOSTRANDO ESTA OPCION ..............................
	    
   //Desactiva los siguientes elementos    
	    $("#menuMenu").removeClass('btnMenu_activo');
	    $("#puntoMenu").removeClass('Activo');    
	    $("#menuMenu").next().removeClass('textoActivo');
	    $("#menuAbrir").removeClass('btnAbrir_activo');
	    $("#puntoAbrir").removeClass('Activo');    
	    $("#menuAbrir").next().removeClass('textoActivo');
	    $("#menuNuevo").removeClass('btnNuevo_activo');
	    $("#puntoNuevo").removeClass('Activo');    
	    $("#menuNuevo").next().removeClass('textoActivo');	  

    });
 //Funcionamiento del botón de Nuevo del menú principal
    $("#menuNuevo").parent().click(function() {
    
    //Activa los siguientes elementos
	    $("#menuNuevo").addClass('btnNuevo_activo');
	    $("#menuNuevo").next().addClass('textoActivo');
	    $("#puntoNuevo").addClass('Activo');
	    
	    $("#txtNuevo").addClass('txtSeleccion');
	    $("#txtAbrir").removeClass('txtSeleccion');
	    $("#seleccionar_curso").parent().parent().removeClass('oculto');
    	    $("#seleccionar_di").parent().parent().addClass('oculto');
    	    $("#form_seleccion_buscar_curso").removeClass('oculto');
    	    
    	    $("#txtNuevo").removeClass('oculto');
	    $("#txtAbrir").addClass('oculto');
	    
   //Desactiva los siguientes elementos    
	    $("#menuMenu").removeClass('btnMenu_activo');
	    $("#puntoMenu").removeClass('Activo');    
	    $("#menuMenu").next().removeClass('textoActivo');
	    $("#menuAyuda").removeClass('btnAyuda_activo');
	    $("#puntoAyuda").removeClass('Activo');    
	    $("#menuAyuda").next().removeClass('textoActivo');
	    $("#menuAbrir").removeClass('btnAbrir_activo');
	    $("#puntoAbrir").removeClass('Activo');    
	    $("#menuAbrir").next().removeClass('textoActivo');

	    tamTracking("tda-gdi", "Paso_2_Seleccion_Crear", "Clic Ícono");    
    });
 
    //Funcionamiento del botón de Abrir del menú principal
    $("#menuAbrir").parent().click(function() {
    //Activa los siguientes elementos
	    $("#menuAbrir").addClass('btnAbrir_activo');
	    $("#menuAbrir").next().addClass('textoActivo');
	    $("#puntoAbrir").addClass('Activo');
	    
	    $("#txtAbrir").addClass('txtSeleccion');
	    $("#txtNuevo").removeClass('txtSeleccion');
	    $("#seleccionar_curso").parent().parent().addClass('oculto');
	    $("#form_seleccion_buscar_curso").addClass('oculto');
	    $("#seleccionar_di").parent().parent().removeClass('oculto');
	    $("#seleccionar_di").removeClass('oculto');
	    
	    $("#txtAbrir").removeClass('oculto');
	    $("#txtNuevo").addClass('oculto');   
   //Desactiva los siguientes elementos    
	    $("#menuMenu").removeClass('btnMenu_activo');
	    $("#puntoMenu").removeClass('Activo');    
	    $("#menuMenu").next().removeClass('textoActivo');
	    $("#menuAyuda").removeClass('btnAyuda_activo');
	    $("#puntoAyuda").removeClass('Activo');    
	    $("#menuAyuda").next().removeClass('textoActivo');
	    $("#menuNuevo").removeClass('btnNuevo_activo');
	    $("#puntoNuevo").removeClass('Activo');    
	    $("#menuNuevo").next().removeClass('textoActivo');	

	    tamTracking("tda-gdi", "Paso_2_Seleccion_Abrir", "Clic Ícono");
	    
    });
});
// ---------------------------------------------funciones jquery para index --fin--





