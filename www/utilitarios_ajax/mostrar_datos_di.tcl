ad_page_contract {
 	@param tipo_busqueda	indica cual busqueda se esta realizando, si simple o avanzada
} {
    datosDI
}



array set diInfo [gdi::obtenerInformacionDI $datosDI]


if { $diInfo(fecCreacion) ne "" } {
	if {$diInfo(codigoCurso) < 0} {
		set diInfo(codigoCurso) "#tda-gdi.infnoapply#"
	}
	
	if {$diInfo(plan) < 0} {
		set diInfo(plan) "#tda-gdi.infnoapply#"
	}
	
	if {$diInfo(escuela) < 0} {
		if {[llength $diInfo(escuela)] eq 1} {
			set diInfo(escuela) "#tda-gdi.infnoapply#"
		}
	}
set datos "\
<tr> \
<td class=\"list-table\" align=\"center\"> \
    $diInfo(codigoCurso) \
</td> \
<td class=\"list-table\" align=\"center\"> \
    $diInfo(nombreCurso) \
</td> \
<td class=\"list-table\" style=\"display:none\" align=\"center\"> \
    $diInfo(plan) \
</td> \
<td class=\"list-table\" align=\"center\"> \
    $diInfo(fecCreacion) \
</td> \
<td class=\"list-table\" align=\"center\"> \
    $diInfo(fecModificacion) \
</td> \
<td class=\"list-table\" align=\"center\"> \
    $diInfo(escuela) \
</td> \
<td class=\"list-table\" align=\"center\"> \
    <span class=\"mas_detalles\" onclick=\"clickPropiedadesDI($datosDI)\">#tda-gdi.tbmoredetails#</span> \
</td> \
</tr>"
} else {
set datos "<tr> \
<td class=\"list-table\" align=\"center\"> \
    #tda-gdi.tbwithoutdata#\
</td> \
</tr>"

}
