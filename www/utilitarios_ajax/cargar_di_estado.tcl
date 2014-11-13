ad_page_contract {
 	@param 
} {
    di
    cantidadSesiones
}
set resultado [gdi::cargarEstados $di $cantidadSesiones]
return "$resultado"
