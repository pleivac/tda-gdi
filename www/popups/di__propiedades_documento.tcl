ad_page_contract {

} {

}


############ add css and javascript files...
template::head::add_css -href "/resources/tda-gdi/css/gdi_mensajes_estilos.css" -order 1



##variables del mensaje
set hl_curso "Curso: "
set dsc_curso "Curso ejemplo"
set hl_profesor "Profesor: "
set dsc_profesor "Profesor Prueba"
set hl_fecha_inicio "Fecha de inicio: "
set dsc_fecha_inicio "20/05/2011"
set hl_ultima_actualizacion "Última actualización: "
set dsc_ultima_actualizacion "20/05/2011"
set hl_fecha_conclusion "Fecha de conclusión: "
set dsc_fecha_conclusion "-"
set hl_compartido_con "Compartido con: "
set dsc_compartido_con "Profesor prueba 2"


set mensaje_contenido_texto "<div id=\"propiedades_documento\"> \
                                <ul class=\"menu_items_menu\"> \
                                    <li><h4>$hl_curso</h4> $dsc_curso</li> \
                                    <li><h4>$hl_profesor</h4> $dsc_profesor</li> \
                                    <li><h4>$hl_fecha_inicio</h4> $dsc_fecha_inicio</li> \
                                    <li><h4>$hl_ultima_actualizacion</h4> $dsc_ultima_actualizacion</li> \
                                    <li><h4>$hl_fecha_conclusion</h4> $dsc_fecha_conclusion</li> \
                                    <li><h4>$hl_compartido_con</h4> $dsc_compartido_con</li> \
                                </ul> \
                            </div>"
