ad_page_contract {

} {

}

############ add css and javascript files...
template::head::add_css -href "/resources/tda-gdi/css/gdi_mensajes_estilos.css" -order 1

set wizard "wizard"
###mismo proc de di.tcl
#set componentes {"Sesión" "Título" "Objetivos de aprendizaje" "Módulos de contenidos" "Actividades de aprendizaje" "Medios/materiales por utilizar" "Evaluación de los aprendizajes"}
set componentes {"#tda-gdi.compsession#" "#tda-gdi.comptitle#" "#tda-gdi.compobjectives#" "#tda-gdi.compsubject#" "#tda-gdi.compactivities#" "#tda-gdi.compmaterials#" "#tda-gdi.compevaluation#"}


#### se crea la lista del wizard con la lista de componentes
set ullist "<ul id=\"menu_opciones\">"
set ullist "$ullist<li class=\"menu_wizard_item seleccionado\" id=\"1\"><span id=\"1\" class=\"menu_wizard_item_texto\">[lindex $componentes 1]</span></li></th>"
set size_componentes [llength $componentes]
for {set i 2} {$i < $size_componentes} {incr i} {
    set temp [lindex $componentes $i]
    set ullist "$ullist<li class=\"menu_wizard_item\" id=\"$i\"><span id=\"$i\" class=\"menu_wizard_item_texto\">$temp</span></li></th>"
}
#cierra la lista
set ullist "$ullist</ul>"


