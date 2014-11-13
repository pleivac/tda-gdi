ad_page_contract {

} {
	{opcion 0}
	di
	{nombre_curso ""}
	{cantidad_sesiones 0}
	{codigo "-1"}
	{plan ""}
	{escuela ""}
	{es_di "true"}
}

if { $nombre_curso eq "" && $opcion eq 0 } {
  array set informacionDI [gdi::obtenerInformacionDI $di]
  set nombre_curso $informacionDI(nombreCurso)
  set cantidad_sesiones [gdi::obtenerSesionesDI $di]
  set codigo $informacionDI(codigoCurso)
  set plan $informacionDI(plan)
  set escuela $informacionDI(escuela)
}

#set programa_curso "Este es el programa del curso... aquí se despliega el programa del curso"
##mismo proc de wizard.tcl
set componentes {"#tda-gdi.compsession#" "#tda-gdi.comptitle#" "#tda-gdi.compobjectives#" "#tda-gdi.compsubject#" "#tda-gdi.compactivities#" "#tda-gdi.compmaterials#" "#tda-gdi.compevaluation#"}

set sesiones $cantidad_sesiones

set nombreEscuela $escuela

set componentes_programa_curso {"Justificación" "Contenido" "Objetivos" "Bibliografía" "Horario" "Evaluación" "Tipo curso"}
set contenido_programa_curso {"Justificación 2" "Contenido" "Objetivos" "Bibliografía" "Horario" "Evaluación" "Tipo curso"}

##set componentes_ayuda 0
##set contenido_ayuda 0

set ayudas [gdi::obtenerAyuda]

##set componentes_ayuda [lindex [lindex $ayudas 0] 0]
##set contenido_ayuda [lindex [lindex $ayudas 0] 1]

for {set i 0} {$i < [llength $ayudas]} {incr i} {
	lappend componentes_ayuda [lindex [lindex $ayudas $i] 0]
	lappend contenido_ayuda [lindex [lindex $ayudas $i] 1]
}


set componentes_contexto [gdi::obtenerPreguntasContexto]
set contenido_contexto [gdi::obtenerPreguntasContexto]

set siguiente "Siguiente"
set anterior "Anterior"

set Universidad "Instituto Tecnológico de Costa Rica"
set varNombreDI "Nombre del Diseño Instruccional: "
set varNombreAutor "Autor: "
set varNombreCurso "Curso: "

####Genera el menú y el contenido del programa del curso
###################################################################################################
set ul_programa_curso "<ul>"
for {set i 0} {$i < [llength $componentes_programa_curso]} {incr i} {
    set ul_programa_curso "$ul_programa_curso\
                           <li><a href=\"#programa_paso_$i\" title=\"explicación\">[lindex $componentes_programa_curso $i]</a></li>"                      
}
set ul_programa_curso "$ul_programa_curso</ul>"
#################################
set divs_programa_curso ""
for {set i 0} {$i < [llength $componentes_programa_curso]} {incr i} {
    set divs_programa_curso "$divs_programa_curso\
                           <div id=\"programa_paso_$i\">[lindex $contenido_programa_curso $i]</div>"                      
}
###################################################################################################
####Genera el menú y el contenido de la ayuda
###################################################################################################
set ul_ayuda "<ul>"
for {set i 0} {$i < [llength $componentes_ayuda]} {incr i} {
    set ul_ayuda "$ul_ayuda\
                           <li><a href=\"#programa_paso_$i\">[lindex $componentes_ayuda $i]</a></li>"                      
}
set ul_ayuda "$ul_ayuda</ul>"
#################################
set divs_ayuda ""
for {set i 0} {$i < [llength $contenido_ayuda]} {incr i} {
    set divs_ayuda "$divs_ayuda\
                           <div id=\"programa_paso_$i\">[lindex $contenido_ayuda $i]</div>"                      
}
###################################################################################################
####Genera el menú y el contenido del contexto del DI
###################################################################################################
set ul_contexto "<ul>"
for {set i 0} {$i < [llength $componentes_contexto]} {incr i} {
    set id_pregunta [lindex [lindex $componentes_contexto $i] 0]
    set ul_contexto "$ul_contexto\
                           <li><a href=\"#programa_paso_$id_pregunta \" title=\"explicación\">[lindex [lindex $componentes_contexto $i] 1]</a></li>"                      
}
set ul_contexto "$ul_contexto</ul>"
#################################
set divs_contexto ""
for {set i 0} {$i < [llength $contenido_contexto]} {incr i} {
    set id_pregunta [lindex [lindex $componentes_contexto $i] 0]
    set ayuda_pregunta [lindex [lindex $componentes_contexto $i] 2]
    set respuesta ""
    set estado ""
    if {$di>=0} {
    	set respuesta [lindex [lindex [gdi::obtenerRespuestaContexto $di $id_pregunta] 0] 0]
    	set estado [lindex [lindex [gdi::obtenerRespuestaContexto $di $id_pregunta] 0] 1]
    } 
    
    
    if { $estado != "1"} {
        set divs_contexto "$divs_contexto\
        	<div id='programa_paso_$id_pregunta'><p>$ayuda_pregunta</p><textarea id='textarea_contexto_di_$id_pregunta' cols='80' rows='10' placeholder='#tda-gdi.placeholderdesc#'>$respuesta</textarea>\
        		<div id='ctxt_estado_$id_pregunta' class='ctxt_estados'>\
        			#tda-gdi.txtestadoseccion#\
        			<div>\
       			 		<div class='ctxt_estado inline'> </div>\
       			 		<div class='inline inline_text'> #tda-gdi.txtestadoseccionyes# </div>\
       			 		<div class='ctxt_estado llenarEstado inline'> </div>\
       			 		<div class='inline inline_text'> #tda-gdi.txtestadoseccionno# </div>\
       			 	</div>\
       			 </div>\
       	 	</div>"
    } else {
        set divs_contexto "$divs_contexto\
        	<div id='programa_paso_$id_pregunta'><p>$ayuda_pregunta</p><textarea id='textarea_contexto_di_$id_pregunta' cols='80' rows='10' placeholder='#tda-gdi.placeholderdesc#'>$respuesta</textarea>\
        		<div id='ctxt_estado_$id_pregunta' class='ctxt_estados'>\
        			#tda-gdi.txtestadoseccion#\
        			<div>\
       			 		<div class='ctxt_estado llenarEstado inline'> </div>\
       			 		<div class='inline inline_text'> #tda-gdi.txtestadoseccionyes# </div>\
       			 		<div class='ctxt_estado inline'> </div>\
       			 		<div class='inline inline_text'> #tda-gdi.txtestadoseccionno# </div>\
       			 	</div>\
       			 </div>\
       	 	</div>"
    }  	                      
}
###################################################################################################


### Construccion de la matriz del DI.-------------------------------------------INICIO----------
set tabla "<table id=\"instructional_design\" class=\"list-table\" cellpadding=\"3\" cellspacing=\"1\"><thead><tr class=\"list-header\">"
set size_componentes [llength $componentes]
for {set i 0} {$i < $size_componentes} {incr i} {
    set temp [lindex $componentes $i]
    set tabla "$tabla<th class=\"list-table\" align=\"center\"><span>$temp</span></th>"
}
## cierro la fila del encabezado
set tabla "$tabla</tr></thead><tbody>"
### inicia con el contenido de la tabla

set sesiones [string trimleft $sesiones "0"]
for {set i 1} {[expr {$i <= "9"}]} {incr i} {
  puts "evaluando $i"
}
for {set i 1} {$i <= $sesiones} {incr i} {
##segun la fial, agrega la clase correspondiente
    if { [expr {$i % 2} ] == 0} {
        if { $i == $sesiones } {
            set tabla "$tabla<tr class=\"even last\">"
        } else {
            set tabla "$tabla<tr class=\"even\">"
        }
    } else {
        if { $i == $sesiones } {
            set tabla "$tabla<tr class=\"odd\">"
        } else {
            set tabla "$tabla<tr class=\"odd\">"
        }
    }
### agrega el contenido de la fila en la columna 0, ya que es especial
    set tabla "$tabla<td class=\"list-table\" align=\"center\"><span class=\"sesion\">$i</span></td>"
### agrega el contenido de la fila en la columna 1, ya que es especial, lleva el title para ver el título del DI.
    set tabla "$tabla<td title=\"\"class=\"list-table\" id=\"1\" align=\"center\"><div id=\"$i-1\" class=\"bolita bolita_vacia\" /></td>"
### agrega el contenido de la fila en el resto de columnas   
    for {set column 2} {$column < $size_componentes} {incr column} {
        set tabla "$tabla<td class=\"list-table\" id=\"$column\" align=\"center\"><div id=\"$i-$column\" class=\"bolita bolita_vacia\" /></td>"
    }
## cierro la fila
    set tabla "$tabla</tr>"
}
## cierro la tabla
set tabla "$tabla</tbody></table>"
### Construccion de la matriz del DI.-------------------------------------------FIN----------


















### Construccion de la matriz del DI.-------------------------------------------INICIO----------
set tablaVisualizar "<table id=\"DI_visualizar\" class=\"list-table\" cellpadding=\"3\" cellspacing=\"1\"><tbody><tr class=\"list-header\">"
set size_componentes [llength $componentes]
for {set i 0} {$i < $size_componentes} {incr i} {
    set temp [lindex $componentes $i]
    set tablaVisualizar "$tablaVisualizar<th class=\"list-table\" align=\"center\">$temp</th>"
}
## cierro la fila del encabezado
set tablaVisualizar "$tablaVisualizar</tr>"
### inicia con el contenido de la tablaVisualizar
for {set i 1} {$i <= $sesiones} {incr i} {
##segun la fial, agrega la clase correspondiente
    if { [expr {$i % 2} ] == 0} {
        if { $i == $sesiones } {
            set tablaVisualizar "$tablaVisualizar<tr class=\"even last\">"
        } else {
            set tablaVisualizar "$tablaVisualizar<tr class=\"even\">"
        }
    } else {
        if { $i == $sesiones } {
            set tablaVisualizar "$tablaVisualizar<tr class=\"odd\">"
        } else {
            set tablaVisualizar "$tablaVisualizar<tr class=\"odd\">"
        }
    }
### agrega el contenido de la fila en la columna 0, ya que es especial
    set tablaVisualizar "$tablaVisualizar<td class=\"list-table\" align=\"center\"><span class=\"sesion\">$i</span></td>"
### agrega el contenido de la fila en la columna 1, ya que es especial, lleva el title para ver el título del DI.
    set tablaVisualizar "$tablaVisualizar<td title=\"\" class=\"list-table\" id=\"1\" align=\"center\"> </td>"
### agrega el contenido de la fila en el resto de columnas   
    for {set column 2} {$column < $size_componentes} {incr column} {
        set tablaVisualizar "$tablaVisualizar<td class=\"list-table\" id=\"$column\" align=\"center\"> </td>"
    }
## cierro la fila
    set tablaVisualizar "$tablaVisualizar</tr>"
}
## cierro la tablaVisualizar
set tablaVisualizar "$tablaVisualizar</tbody></table>"
### Construccion de la matriz del DI.-------------------------------------------FIN----------
set codigoMatriz "01" 

set curso1 "Prueba"

