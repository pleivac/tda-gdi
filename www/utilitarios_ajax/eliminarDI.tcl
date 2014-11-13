ad_page_contract {
 	@param 
} {
    di
}
set eliminado [gdi::eliminarDI $di]
set usuario_id [ad_conn user_id]
# REGISTRO para el Gestor de Recursos Docentes (GRD)
# Borrado de un DI
grd::register_action -action_str "delete"  -user_id $usuario_id  -app "di" -object_id $di
# FIN registro para GRD
set exito "true"
return exito
