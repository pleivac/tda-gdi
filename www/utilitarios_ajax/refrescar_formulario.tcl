ad_page_contract {
 	@param 
} {
    tipo
    {sede ""}
    {plan ""}
    {carrera ""}
}


switch $tipo {
    carrera { 
        set departamentos [gdi_utilitarios::obtenerDepartamentos $sede]
        set canDepartamentos [llength $departamentos]
        set temp ""
        for {set i 0} {$i < $canDepartamentos} {incr i} {
            set temp [concat $temp "<option value=\"[lindex [lindex $departamentos $i] 1]\">[lindex [lindex $departamentos $i] 0]</option>"]
        }
        set resultados $temp
    }
 materia { 
        set materias [gdi_utilitarios::obtenerMaterias $plan]
        set canMaterias [llength $materias]
        set temp ""
        for {set i 0} {$i < $canMaterias} {incr i} {
            set temp [concat $temp "<option value=\"[lindex [lindex $materias $i] 1]\">[lindex [lindex $materias $i] 0]</option>"]
        }
        set resultados $temp
    }
 plan { 
        set planes [gdi_utilitarios::obtenerPlanes $carrera ]
        set canPlanes [llength $planes]
        set temp ""
        for {set i 0} {$i < $canPlanes} {incr i} {
            set temp [concat $temp "<option value=\"[lindex [lindex $planes $i] 1]\">[lindex [lindex $planes $i] 0]</option>"]
        }
        set resultados $temp
    }
}
return resultados
