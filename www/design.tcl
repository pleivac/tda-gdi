ad_page_contract {

} {

}

# Importado de los fuentes CSS
#BIBLIOTECAS
template::head::add_css -href "/resources/tds-lib/css/tds-lib.css" -order 1
template::head::add_css -href "/resources/tds-lib/css/tds-fonts.css" -order 2
# DESARROLLO
template::head::add_css -href "/resources/tda-gdi/css/gdi_estilos.css" -order 3
template::head::add_css -href "/resources/tda-gdi/css/di.css" -order 4

# Importado de los fuentes de javascript
# BIBLIOTECAS
template::head::add_javascript -src "/resources/tda-gdi/js/lib/jquery-2.0.3.min.js" -order 5
template::head::add_javascript -src "/resources/tda-gdi/js/lib/jquery.autosize.min.js" -order 6
template::head::add_javascript -src "/resources/tda-gdi/js/lib/jquery-ui-1.10.3.js" -order 7
template::head::add_javascript -src "/resources/tds-lib/js/tds-lib.js" -order 8
template::head::add_javascript -src "/resources/tda-gdi/js/lib/jquery.bpopup.0.9.4.min.js" -order 9
template::head::add_javascript -src "/resources/tda-gdi/js/lib/jquery.fixheadertable.min.js" -order 10
template::head::add_javascript -src "/resources/tam/js/tam-tracking.js" -order 11
# DESARROLLO 
template::head::add_javascript -src "/resources/tda-gdi/js/gdi_funciones.js" -order 12
template::head::add_javascript -src "/resources/acs-templating/js/funcionesUtiles.js" -order 13
template::head::add_javascript -src "/resources/tda-gdi/js/design.js" -order 14
template::head::add_javascript -src "/resources/tda-gdi/js/di.js" -order 15
template::head::add_javascript -src "/resources/tda-gdi/js/gdi_funciones.js" -order 16


set menu_items {"#tda-gdi.mnew#" "#tda-gdi.mope#" "#tda-gdi.msave#" "#tda-gdi.msaveas#" "#tda-gdi.mproperties#" "#tda-gdi.massociate#" "#tda-gdi.mclone#" "#tda-gdi.mdelete#" "#tda-gdi.mgenerate#" "#tda-gdi.mexit#"}


set menu "<ul class=\"menu_items_menu\"> \
            <li><a id=\"menu_nuevo\">[lindex $menu_items 0]</a></li> \
            <li><a id=\"menu_abrir\">[lindex $menu_items 1]</a></li> \
            <li><a class=\"deshabilitados\"  id=\"menu_guardar\">[lindex $menu_items 2]</a></li> \
            <li><a class=\"deshabilitados\"  id=\"menu_guardar_como\">[lindex $menu_items 3]</a></li> \
            <li><a class=\"deshabilitados\"  id=\"menu_propiedades_documento\">[lindex $menu_items 4]</a></li> \
            <li><a class=\"deshabilitados\"  id=\"menu_asociar\">[lindex $menu_items 5]</a></li> \
            <li><a class=\"deshabilitados\"  id=\"menu_clonar\">[lindex $menu_items 6]</a></li> \
            <li><a class=\"deshabilitados\"  id=\"menu_eliminar\">[lindex $menu_items 7]</a></li> \
            <li><a class=\"deshabilitados\"  id=\"menu_cerrar\">[lindex $menu_items 9]</a></li>\
        </ul>"
