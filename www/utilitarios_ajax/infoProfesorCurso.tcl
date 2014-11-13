ad_page_contract {
 	
} {
    di
    cod_curso   
}

set nombreCurso [gdi::obtenerNombreCurso $di]
set nombreProfesor [gdi::obtenerUsuario]

set respuesta "$nombreCurso&$nombreProfesor"
