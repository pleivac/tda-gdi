ad_page_contract {
 	@param 
} {
    respuestas_contexto
}



##puts "$di $programaEstudio $nombre  $cod_curso $sesiones $estados $nombre_curso"
set listaRespuestasGuardar [split $respuestas_contexto "~"]
set cantidadRespuestasGuardar [expr {[llength $listaRespuestasGuardar] - 1}]
for {set i 1} {$i <= $cantidadRespuestasGuardar} {incr i} {
    set nodoActual [split [lindex $listaRespuestasGuardar $i] "|"]
    gdi::insertarRespuestaContextoDI $nodoActual

} 
    
set data "Hola mundo"
return $data
