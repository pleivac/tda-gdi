ad_page_contract {

} {
    
}

## variables de texto, para la i18n ---inicio---
set page_title "Bienvenido a GDI"
set profesor [gdi::obtenerUsuario]
set error_usuario [gdi::agregarUsuario $profesor]

#set index_texto_bienvenida "Bienvenido $profesor, esta herramienta le guiará en el proceso de creación \
#                            de su diseño instruccional."
#set tab1 "Paso 1: Bienvenida"
#set tab2 "Paso 2: Selección"
## variables de texto, para la i18n ---fin---



set cursos [lsort -dictionary [gdi::obtenerCursos]]
set listaDI [gdi::obtenerDIusuario]
set departamentos [gdi_utilitarios::obtenerDepartamentos ""]
set planes [gdi_utilitarios::obtenerPlanes "vacio"]
set materias [gdi_utilitarios::obtenerMaterias 0]




## Form#1 Paso1: bienvenida
ad_form \
-name form_bienvenida \
-has_submit 1 \
-form {

	{nombre_profesor:text,optional 
	    {label "#tda-gdi.lbwelcome4#:"}
	    {value $profesor}
    	{html {class "claseprueba tds-lib_form tds-lib_form_long"}}}
}

## Form#2 Paso2: Selección
ad_form \
-name form_seleccion \
-has_submit 1 \
-form {
#	{seleccionar_curso:text(select),optional {label ""}
#	{options { 
#		   $cursos
 #        }}
  #  	{html {class "selectbox"}}}
    
         
	# {seleccionar_di:text(select),optional {label ""}
	# {options { 
	# 	   $listaDI
 #         }}
 #    	{html {class "selectbox oculto"}}}
}


## Form#3 Paso 2: Selección buscar curso
#ad_form \
-name form_seleccion_buscar_curso \
-has_submit 1 \
-form {

    
#	{seleccionar_carrera:text(select),optional {label "#tda-gdi.lbslectdepartment#*: "}
#	{options { 
#		   [gdi_utilitarios::obtenerDepartamentos ""]
#         }}
#    	{html {class "selectbox selectbox_oculto"}}}

    
#	{seleccionar_plan:text(select),optional {label "#tda-gdi.lbslectplan#*: "}
#	{options { 
#		   [gdi_utilitarios::obtenerPlanes "vacio"]
#         }}
#    	{html {class "selectbox selectbox_oculto"}}}
    	
#	{seleccionar_materia:text(select),optional {label "#tda-gdi.lbslectterm#*: "}
#	{options { 
#		   [gdi_utilitarios::obtenerMaterias 0]
#         }}
#    	{html {class "selectbox selectbox_oculto"}}}
#}

