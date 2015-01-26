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
        set resultados [util::json::gen [util::json::object::create $departamentos]]
    }
 materia { 
        set materias [gdi_utilitarios::obtenerMaterias $plan]
        set resultados [util::json::gen [util::json::object::create $materias]]
    }
 plan { 
        set planes [gdi_utilitarios::obtenerPlanes $carrera ]
        set resultados  [util::json::gen [util::json::object::create $planes]]
    }
}
return resultados
