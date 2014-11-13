ad_page_contract {
        create a new page on a community, according the instructional design and it course predefined content.
	Pedro Ignacio Leiva Chinchilla
	pedro.leiva.ch@gmail.com
} {
	portal_id
	id_di
	community_id
	return_url
	columnas
} -properties {
} -validate {
} -errors {
}

set retorno "La pestaña de Contenido DI fue creada"
set paginas [portal::list_pages_tcl_list -portal_id $portal_id]
set existe 0

## Se verifica que no se haya montado todavia la pestaña en creación
foreach id_pagina $paginas {
	set nombre [portal::get_page_pretty_name -page_id $id_pagina]
	if { $nombre eq "Contenido DI" } {
		set existe 1
		set retorno "Lo pestaña de Contenido DI ya existe en este portal"
	}
}

##----------------------------------------------------
#		ESTA FUNCIONALIDAD SE UTILIZA PARA 
#		verificar la existencia de una pestaña 
##----------------------------------------------------
##verificamos la existencia del applet de evaluaciones
##set existe_evaluation [lsearch [dotlrn_applet::list_applets] "dotlrn_evaluation"]

##if {[catch {
##    if { [dotlrn_community::applet_active_p -community_id $community_id -applet_key dotlrn_evaluation] == 0} {
##	    dotlrn_evaluation::add_applet_to_community $community_id
##	}
##} errmsg]} {
##	ns_log error "*** APC Error*: $errmsg"	
##}
##----------------------------------------------------
#		FIN 
##----------------------------------------------------

if { $existe eq 0} {
	# se crea la pestaña 
	set page_id [portal::page_create -portal_id $portal_id -pretty_name "Contenido DI" -accesskey "#ContenidoDI#"]
	set name [portal::get_name $portal_id]

	set paginas [portal::list_pages_tcl_list -portal_id $portal_id]
	set num_page [llength $paginas]

	# se actualiza la direccion de URL a la que se debe redireccionar
	set parseo [split $return_url "?"]
	set return_url "[lindex $parseo 0]?page_num=[expr $num_page - 1]"
	#set return_url "[lindex $parseo 0]?page_num=$num_page"

	# se asigna el portal_layout
	set layout_id ""
	if {$columnas eq 1} {
		set layout_id [portal::get_layout_id -layout_name "#theme-zen.Zen_1_column#" ]
	} else {
	# On portal_layouts's table appears this data. It's the page distribution (2 column - theme-zen)
		set layout_id [portal::get_layout_id -layout_name "#theme-zen.Zen_2_column#" ]
	}
	portal::set_layout_id -portal_id $portal_id -page_id $page_id -layout_id $layout_id

	set btn "tda-gdi/utilitarios_ajax/validar_admin?URL=$return_url&portal_id=$portal_id"
	
	set cantidadSesiones [gdi::obtenerSesionesDi $id_di]

	for {set sesion 1} {$sesion <= $cantidadSesiones} {incr sesion} {
	
		set tituloSesion [lindex [lindex [gdi::obtenerTituloSesion $id_di $sesion] 0] 0]
		
		set objetivosSesion [gdi::obtenerObjetivoAprendizaje $id_di $sesion]
		set objetivos ""
		for {set j 0} {$j < [llength $objetivosSesion]} {incr j} {
			set objetivos "$objetivos <li> [lindex [lindex $objetivosSesion $j] 0]</li>"
		}
		
		set contenidosSesion [gdi::obtenerModuloContenido $id_di $sesion]
		set contenidos ""
		for {set j 0} {$j < [llength $contenidosSesion]} {incr j} {
			set contenidos "$contenidos <li> [lindex [lindex $contenidosSesion $j] 0]</li>"
		}
		
		set actividadesSesion [gdi::obtenerActividadAprendizaje $id_di $sesion]
		set actividades ""
		for {set j 0} {$j < [llength $contenidosSesion]} {incr j} {
			set actividades "$actividades <li> [lindex [lindex $actividadesSesion $j] 0] </li>"
		}
		
		set materialesSesion [gdi::obtenerMediosMateriales $id_di $sesion]
		set materiales ""
		for {set j 0} {$j < [llength $materialesSesion]} {incr j} {
			set materiales "$materiales <li> [lindex [lindex $materialesSesion $j] 0] </li>"
		}
		
		set evaluacionesSesion [gdi::obtenerEvaluaciones $id_di $sesion]
		set evaluaciones ""
		for {set j 0} {$j < [llength $evaluacionesSesion]} {incr j} {
			set evaluaciones "$evaluaciones <li> [lindex [lindex $evaluacionesSesion $j] 0]</li>"
		}
		
		set htmlcompleto "<div>\
			<h2>Título: $tituloSesion </h2>\
	    	<h3> Objetivos de Aprendizaje </h3>\
    		<ol>\
        		$objetivos\
	    	</ol>\
    		<h3> Módulos de Contenidos </h3>\
    		<ol>\
        		$contenidos\
	    	</ol>\
			<div style='border-style: solid; border-width: 1px ;height:300px;width: 550px'>\
				<p style='line-height: 230px; text-align: center; font-size: 10pt; font-style: italic;'>\"Inserte sus presentaciones aquí\"\
			</p></div>\
			<h3> Actividades de Aprendizaje </h3>\
    		<ol>\
   		     	$actividades\
    		</ol>\
    		<h3> Medios/Materiales a utilizar  </h3>\
    		<ol>\
        		$materiales\
        	</ol>\
	    	<h3> Evaluación de Aprendizajes </h3>\
    		<ol>\
        		$evaluaciones\
	    	</ol>\
		</div>"
		
		puts "$htmlcompleto"
		#insersión del portlet
		if {$columnas == 2} { 
			if { [expr {($sesion % 2) == 0}] } {	
				gdi::crear_Portlets_automaticos $portal_id $community_id $page_id "Sesion $sesion - $tituloSesion" $htmlcompleto $btn 2
			} else {
				gdi::crear_Portlets_automaticos $portal_id $community_id $page_id "Sesion $sesion - $tituloSesion" $htmlcompleto $btn 1
			}
		} else {
			gdi::crear_Portlets_automaticos $portal_id $community_id $page_id "Sesion $sesion - $tituloSesion" $htmlcompleto $btn 3
		}
	}
	ad_return_template
} 

