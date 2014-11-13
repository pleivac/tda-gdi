ad_page_contract {
 	@param 
} {
    idDi
}
## Este archivo se ejecuta cuando se abre el popup para asociar
## el DI a nuevos cursos, o bien clonarlos.

set cursos [gdi::obtenerCursosUsuario]
set asociados [gdi::obtenerCursosAsociados $idDi]

set resultado ""
if {[llength $cursos] > 0} {
	for {set i 0} {$i < [llength $cursos]} {incr i} {
	    set estaAsociado "false"
		for {set j 0} {$j < [llength $asociados]} {incr j} {
			set estaAsociado [lsearch [lindex $cursos $i] [lindex $asociados $j]]
			if {$estaAsociado ne -1} {
				set estaAsociado "true"
				break
			}
		}
		if {$estaAsociado eq -1} {
			set estaAsociado "false"
		}
		
		set resultado "$resultado[lindex [lindex $cursos $i] 0]*[lindex [lindex $cursos $i] 1]*[lindex [lindex $cursos $i] 2]*[lindex [lindex $cursos $i] 3]*$estaAsociado%"
	}
} else {
	set resultado "%"
}
return $resultado
