ad_page_contract {

} {
}

# Importado de los fuentes CSS
# ----------------------------
# ----------------------------
# BIBLIOTECAS 
# ----------
#Biblioteca Ratings Paquetes
template::head::add_css -href "/resources/tda-ratings-paquetes/css/jRating.jquery.css" -order 1 
template::head::add_css -href "/resources/tda-ratings-paquetes/css/paquete.rating.css" -order 2 
#Biblioteca estándar GUI TEC-Digital
template::head::add_css -href "/resources/tds-lib/css/tds-lib.css" -order 3
template::head::add_css -href "/resources/tds-lib/css/tds-fonts.css" -order 4
# DESARROLLO
# ----------
template::head::add_css -href "/resources/tda-gdi/css/gdi_estilos.css" -order 5
template::head::add_css -href "/resources/tda-gdi/css/pagina_principal.css" -order 6

# Importado de los fuentes JS
# ---------------------------
# ---------------------------
# BIBLIOTECAS
# -----------
template::head::add_javascript -src "http://code.jquery.com/jquery-2.0.3.min.js" -order 1 
template::head::add_javascript -src "/resources/tds-lib/js/tds-lib.js" -order 2
template::head::add_javascript -src "/resources/tda-gdi/js/lib/jquery-ui-1.10.3.js" -order 3
template::head::add_javascript -src "/resources/tda-gdi/js/lib/jquery.bpopup.min.js" -order 4
template::head::add_javascript -src "/resources/tda-gdi/js/pagina_principal.js" -order 5
template::head::add_javascript -src "/resources/tda-gdi/js/lib/globalize.js" -order 6
#Biblioteca TAM
template::head::add_javascript -src "/resources/tam/js/tam-tracking.js" -order 7
#Biblioteca Ratings Paquetes
template::head::add_javascript -src "/resources/tda-ratings-paquetes/js/jRate.js" -order 8 
template::head::add_javascript -src "/resources/tda-ratings-paquetes/js/paquete.rating.js" -order 9
# DESARROLLO
# ----------
template::head::add_javascript -src "/resources/tda-gdi/js/gdi_funciones.js" -order 10
template::head::add_javascript -src "/resources/tda-gdi/js/index.js" -order 11

auth::require_login

set menu_items {"Nuevo" "Abrir" "Salir"}


set menu "<ul class=\"menu_items_menu\"> \
            <li><a id=\"menu_nuevo\">[lindex $menu_items 0]</a></li> \
            <li><a id=\"menu_abrir\">[lindex $menu_items 1]</a></li> \
            <li><a id=\"menu_cerrar\">[lindex $menu_items 2]</a></li> \
        </ul>"
