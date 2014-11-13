ad_page_contract {

} {

}

############ add css and javascript files...
template::head::add_css -href "/resources/tda-gdi/css/gdi_mensajes_estilos.css" -order 1

set tab1 "Paso 1: compartir"
set tab2 "Paso 2: permisos"



##form para compartir a los compañeros de la misma escuela compañeros
ad_form \
-name form_compartir_persona \
-form {

	{seleccionar_persona:text(select),optional {label "Seleccione con quién desea compartir el DI: "}
	{options { 
		   {"Compañero 1" 1}
		   {"Compañero" 2}
         }}
    	{html {class "selectbox"}}}
}



##form para buscar compañeros de diferentes escuelas.
ad_form \
-name form_compartir_buscar_persona \
-has_submit 1 \
-form {
	{seleccionar_sede:text(select),optional {label "Sede*: "}
	{options { 
		   {"Cartago" bd}
		   {"Santa Clara" ia}
         }}
    	{html {class "selectbox selectbox_oculto"}}}
    
	{seleccionar_escuela:text(select),optional {label "Escuela*: "}
	{options { 
		   {"Compu" bd}
		   {"Produ" ia}
         }}
    	{html {class "selectbox selectbox_oculto"}}}
    
	{seleccionar_carrera:text(select),optional {label "Carrera*: "}
	{options { 
		   {"Compu" bd}
		   {"Produ" ia}
         }}
    	{html {class "selectbox selectbox_oculto"}}}
    
	{seleccionar_otra_persona:text(select),optional {label "Compañero*: "}
	{options { 
		   {"Compañero de otra escuela 1" coe1}
		   {"Compañero de otra escuela 2" coe2}
         }}
    	{html {class "selectbox selectbox_oculto"}}}
}
