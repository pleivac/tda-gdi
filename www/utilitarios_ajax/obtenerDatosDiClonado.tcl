ad_page_contract {
 	@param 
} {
	communityId
}
## Este archivo se ejecuta cuando se abre el popup para asociar
## el DI a nuevos cursos, o bien clonarlos.

set resultado [gdi::abrirCursoEnDI $communityId]

return $resultado
