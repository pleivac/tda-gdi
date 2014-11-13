ad_page_contract {
    Validates an user connection before redirect it to edit portlet.
	Jacqueline Solis Cespedes
	jacsolis@itcr.ac.cr
	Pedro Leiva Chinchilla
	pedro.leiva.ch@gmail.com
} {
	URL
	content_id
	portal_id
} -properties {
} -validate {
} -errors {
}
set retorno ""

set URL [string map {"-admin" ""} $URL]

##agregado por afrancesa
set url [split [ad_conn url] "/"]
set community_key [lindex $url 5]
set community_id [info-general::get_community_id_by_community_key -community_key $community_key]
##fin del agregado
#if { [dotlrn::admin_p] eq "1"} 
if { [dotlrn::user_can_admin_community_p -user_id [ad_conn user_id] -community_id $community_id ] eq "1"} {
	# se hace la actualizacion de la ruta del boton
	# recuperamos todas las paginas del portal
	set paginas [portal::list_pages_tcl_list -portal_id $portal_id]
	foreach id_pagina $paginas {
	set nombre [portal::get_page_pretty_name -page_id $id_pagina]
	set page_id "0"
	if { $nombre eq "Contenido DI" } {
		set existe 1
		set page_id $id_pagina
		}
	}
	if {[catch { 
		#buscamos en la tabla de paginas, aquella que cumple con ese page_id
		set nueva_llave [db_string consulta {select sort_key from portal_pages where page_id = :page_id}]
		set parseo [split $URL "?"]
		set return_url "[lindex $parseo 0]?page_num=$nueva_llave"
	} errmsg]} {
		ns_log error "*** GDI Error al actualizar URL: $errmsg"

	}
	set retorno "/dotlrn/applets/static-portlet/element?portal_id=$portal_id&referer=$URL&content_id=$content_id"
	# en este caso, redireccionamos a la pagina de edicion del portlet
	ad_returnredirect $retorno

}
ad_returnredirect $URL

