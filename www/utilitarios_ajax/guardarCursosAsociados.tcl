ad_page_contract {
 	@param 
} {
    idDi
    arregloCommunityIds
}
## Este archivo se ejecuta para almacenar las asociaciones de cursos a DI en la BD.
set arregloCommunityIds [split $arregloCommunityIds "*"]
set largo [llength $arregloCommunityIds]

gdi::borrarCursosAsociados $idDi

for {set i 1} {$i < $largo} {incr i} {
    set communityId [lindex $arregloCommunityIds $i]
    
	gdi::insertarCursoAsociado $idDi $communityId

} 
    
set data "Exito"
return $data
