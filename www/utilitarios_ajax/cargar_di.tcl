ad_page_contract {
 	@param 
} {
    di
    cantidadSesiones
}
set resultado [gdi::cargarDI $di $cantidadSesiones]
return "$resultado"
