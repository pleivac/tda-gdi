ad_page_contract {
 	@param 
} {
    idDi
}

if { $idDi != "-1" } {
	set nombreDI [gdi::obtenerNombreDI $idDi]
	array set diInfo [gdi::obtenerInformacionDI $idDi]
	set profesor [gdi::obtenerUsuario]
	set cursosAsociados [gdi::obtenerInformacionCursosAsociados $idDi]
	set result "$nombreDI*$diInfo(nombreCurso)*$diInfo(escuela)*$profesor*$diInfo(fecCreacion)*$diInfo(fecModificacion)*$cursosAsociados"
} else {
	set profesor [gdi::obtenerUsuario]
	set result "$profesor"
}
return $result
