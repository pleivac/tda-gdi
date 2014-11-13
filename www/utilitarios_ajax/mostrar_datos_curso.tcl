ad_page_contract {
 	@param tipo_busqueda	indica cual busqueda se esta realizando, si simple o avanzada
} {
    datosCurso
    {tipoConsulta 0}
}

	set datosCursoArray [split $datosCurso "."]
	if { [string length [lindex $datosCursoArray 1] ] != 1 && [lindex $datosCursoArray 1] != "" } {
		set tipoConsulta 1		
	}
	array set cursoInfo [gdi::obtenerInformacionCurso $datosCurso $tipoConsulta]
	
	if { $cursoInfo(codigoCurso) ne "" } {
		set datos "\
		<tr> \
			<td class=\"list-table\" id=\"resultados_funcion\" align=\"center\"> \
    			$cursoInfo(codigoCurso) \
			</td> \
			<td class=\"list-table\" id=\"resultados_nombre\" align=\"center\"> \
    			$cursoInfo(nombreCurso) \
			</td> \
			<td class=\"list-table\" id=\"resultado_escuela\" align=\"center\"> \
    			$cursoInfo(nombreCarrera) \
			</td> \
			<td class=\"list-table\" style=\"display: none\" id=\"resultados_grupo\" align=\"center\"> \
    			$cursoInfo(profesores) \
			</td> \
			<td class=\"list-table\" style=\"display: none\" id=\"resultados_horario\" align=\"center\"> \
    			$cursoInfo(horario) \
			</td> \
		</tr> \
		<tr style=\"display: none\"> \
			<td> \
		        <input id=\"resultados_plan_estudios\" value=\"$cursoInfo(plan)\" > \
		    </td> \
		</tr>"
	} else {
		set datos "<tr> \
			<td class=\"list-table\" align=\"center\"> \
    			#tda-gdi.tbwithoutdata#\
			</td> \
		</tr>"
	}
