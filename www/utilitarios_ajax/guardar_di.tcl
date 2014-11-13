ad_page_contract {
 	@param 
} {
    idDI
    di
    nombre
    cod_curso
    estados
    nombre_curso
    sesiones
    programaEstudio
    escuela
    clonar
    communityID
}

set usuario_id [ad_conn user_id]

if { $usuario_id eq 0 } {
    set data -1
} else {
        
    set data [gdi::salvarDI $idDI $di $programaEstudio $nombre  $cod_curso $sesiones $estados $nombre_curso $escuela]
        
    if { $data != "-1" } {
        if { $idDI == "-1" } {
        # REGISTRO para el Gestor de Recursos Docentes (GRD)
        # Creación de un nuevo DI
            grd::register_action -action_str "create"  -user_id $usuario_id  -app "di" -object_id $data
        # FIN registro para GRD
        } else {
        # REGISTRO para el Gestor de Recursos Docentes (GRD)
        # Edición de un DI
            grd::register_action -action_str "edit"  -user_id $usuario_id  -app "di" -object_id $data
        # FIN registro para GRD
        }
    }
    
    if {$clonar} {
        gdi::insertarCursoAsociado $data $communityID
    }
}
#puts $data
return $data
