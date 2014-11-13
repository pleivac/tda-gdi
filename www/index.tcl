ad_page_contract {

} {
}

# Importado de los fuentes CSS
#BIBLIOTECAS
template::head::add_css -href "/resources/tda-gdi/css/gdi_estilos.css" -order 1
template::head::add_javascript -src "http://code.jquery.com/jquery-2.0.3.min.js" -order 1 
#Biblioteca Ratings Paquetes
template::head::add_css -href "/resources/tda-ratings-paquetes/css/jRating.jquery.css" -order 12 
template::head::add_css -href "/resources/tda-ratings-paquetes/css/paquete.rating.css" -order 13 

# Importado de los fuentes de javascript
# BIBLIOTECAS
#Biblioteca TAM
template::head::add_javascript -src "/resources/tam/js/tam-tracking.js" -order 1
#Biblioteca Ratings Paquetes
template::head::add_javascript -src "/resources/tda-ratings-paquetes/js/jRating.jquery.js" -order 10 
template::head::add_javascript -src "/resources/tda-ratings-paquetes/js/paquete.rating.js" -order 11 
# DESARROLLO 
template::head::add_javascript -src "/resources/tda-gdi/js/gdi_funciones.js" -order 8
template::head::add_javascript -src "/resources/tda-gdi/js/index.js" -order 9
 

auth::require_login

set menu_items {"Nuevo" "Abrir" "Salir"}


set menu "<ul class=\"menu_items_menu\"> \
            <li><a id=\"menu_nuevo\">[lindex $menu_items 0]</a></li> \
            <li><a id=\"menu_abrir\">[lindex $menu_items 1]</a></li> \
            <li><a id=\"menu_cerrar\">[lindex $menu_items 2]</a></li> \
        </ul>"
