ad_page_contract {
    Shows a button to admin users. It allow them to create a new page for each content defined on APC.
    @author Pedro Leiva Chinchilla(pedro.leiva.ch@gmail.com)
    @param
} {
	codigo_curso:optional
	community_id:optional
	ruta_url:optional
}

   if { ![exists_and_not_null codigo_curso] } { 
	set codigo_curso ""
   }
   ## Create a new page on community portal
    if { ![exists_and_not_null community_id] } { 
    	set community_id [dotlrn_community::get_community_id]
    }
	if { ![exists_and_not_null ruta_url] } { 
    	set ruta_url "[ad_conn url]?[ns_conn query]"
    }
    set portal_id [dotlrn_community::get_portal_id -community_id "$community_id"]

    if { [dotlrn::admin_p] eq 1} {
		set test ""
    } else {
		set test "style='background: transparent;border: none !important;font-size:0;'"
    }
