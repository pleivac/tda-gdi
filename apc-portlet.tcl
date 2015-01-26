# tds-apc-portlet/www/apc-portlet.tcl
#  Copyright (C) 2001 - 2011 tecDigital
#
#  This file is part of dotLRN.
#
#  dotLRN is free software; you can redistribute it and/or modify it under the
#  terms of the GNU General Public License as published by the Free Software
#  Foundation; either version 2 of the License, or (at your option) any later
#  version.
#
#  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
#  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
#  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
#  details.
#

ad_page_contract {
    shows import items
    @author Josue Viquez (jviquez@itcr.ac.cr), Laura Coto (lsarmiento@itcr.ac.cr), Agustín Francesa (agustin.francesa@gmail.com)
    @param
} {
  
    {codigo ""}
    {nombreEscuela ""}
    {plan ""}
    {nombreCurso ""}
    {es_di ""}

}

template::head::add_javascript -src "/resources/tda-apc/js/lib/jquery-1.5.1.min.js" -order 1
template::head::add_javascript -src "/resources/tda-apc/js/lib/jquery-ui-1.8.13.custom.min.js" -order 2

template::head::add_css -href "/resources/tds-apc-portlet/css/visualizador.css" -order 1
template::head::add_javascript -src "/resources/tds-apc-portlet/js/visualizador.js" -order 6

template::head::add_javascript -src "/resources/tds-apc-portlet/js/btn_agregar_paginas.js" -order 17

set community_id [dotlrn_community::get_community_id]



set existe 0




if { ![exists_and_not_null community_id ] && $es_di ne "true"} { 
    set community_id "-1"
} else {
	if { $es_di ne "true" } {
    	#puts "community_id es> $community_id"
    	set portal_id [dotlrn_community::get_portal_id -community_id $community_id]
    	#puts "portal_id> $portal_id"
    	set escuela [dotlrn_community::get_community_id]
    	#puts "escuela inicial es> $escuela" 
	}

    	#Obtengo el código del curso al separar el URL mediante el comando anterior(estrategia 1) o por medio del parámetro que ingresa(estrategia 2).
    set urlCompleto [ad_conn url]
    set url [split $urlCompleto "/"]

    #Si no se recibe el código por parámetro, obtenga el código del curso que se encuentra en la cuarta posición del URL
    set resultado "No existe un Programa de Curso para este curso"
	
    if {$codigo == "" } {
    	set codigo [lindex $url 4]

   	    set resultado "No existe un Programa de Curso para la materia solicitada"
   	    #detalle sería algo así> S-1-2012.CA.IC5820.1 para un CA
    	set detalle [lindex $url 5]
   	    set esCodigo [regexp {^[A-Z]{2}[0-9]{4}} $codigo match]
    	set esDetalle [regexp {^[A-Z]{1}[-]{1}[0-9]{1}[-]{1}[0-9]{4}[.]{1}[A-Z]{2,3}[.]{1}[A-Z]{2}[0-9]{4}[.]{1}[0-9]{1,}$} $detalle match]
   	    set codigoDelDetalle [split $detalle "."]
    	set codigoDelDetalle [lindex [split $detalle "."] 2]
    	#puts "codigoDelDetalle> $codigoDelDetalle"
    } else {
        #si se obtuvo el código por parámetro entonces...
    	set codigoDelDetalle $codigo
        set detalle ""
        set esCodigo 1
        set esDetalle 1
    }
    
    set universidad "Instituto Tecnológico de Costa Rica"
    
    set esCursoAsociado 0
    
    #determina el tipo de curso que es para solicitar la información respectiva que es ...
    if {$codigo==$codigoDelDetalle && $esCodigo==1 && $esDetalle==1} {
        set esCursoAsociado 1
        #puts "es un curso asociado"  
        
        #Averigua el nombre de la escuela para el curso asociado 
        if {$nombreEscuela == "" && $es_di ne "true"} {  
            #puts "community_id $community_id"
            set comunidad [db_string prueba {select community_type from dotlrn_communities_all where community_id = :community_id}]
            #puts "comunidad $comunidad"
            set escuelaN [string trim [lindex [split $comunidad .] 0]]
            set escuelaN "Com.$escuelaN"
            #puts " escuelaN $escuelaN"
            set temporal "Escuela no identificada"
            set nombreN [db_string temporal {select pretty_name from dotlrn_communities_all where community_key = :escuelaN}]
            set escuela $nombreN
        } else {
            #se coloca el nombre de la escuela que viene por parámetro
            set escuela $nombreEscuela
        }
        set escuela "Escuela de : $escuela" 
        #puts "Escuela de > $escuela"

        #Averigua el nombre del curso asociado, por medio de la comunidad
        if {$nombreCurso == "" } { 
            set curso "Nombre del curso: [lindex [lindex [admision::MATERIAS_Buscar $codigo "" ""] 0] 3]"
            #puts "codigo> $codigo, curso>"
            set codigo "$codigo"
        } else {
            set curso $nombreCurso
        }
        
        set codigo "$codigo"
        set buscoCodigo $codigo
        
    } else {
        #puts "es un CURSO NO ASOCIADO (CNA)"

        #Averigua el nombre de la escuela del curso no asociado
        if {$nombreEscuela == "" } {  
            set padre [db_0or1row consulta {select parent_community_id, community_type from dotlrn_communities_all where community_id = :escuela}]
            #puts "padre> $padre"
            while {$padre != 0 } {
                set padre [db_0or1row consulta {select parent_community_id, community_type from dotlrn_communities_all where community_id = :parent_community_id}]
                #puts "padre> $padre"
            }
            set nombreEscuela [lindex [split $community_type "."] 0]
            #puts "nombreEscuela> $nombreEscuela"
            set escuela $nombreEscuela

        } else {
            set escuela $nombreEscuela
        }
        set escuela "Escuela de : $escuela" 
        #puts "Escuela de > $escuela"
       
        #Averigua el nombre del curso NO ASOCIADO
        if {$nombreCurso == "" } { 
            set cursoNoAsociado [db_string curso2 {select pretty_name from dotlrn_communities_all where community_id = :community_id}]
            set curso $cursoNoAsociado
            #puts  "curso> $curso"
        } else {
            set curso $nombreCurso
        }
        set curso "Nombre del curso: $curso"
        #puts "$curso"   
    
    
	    set listaDetalle [split $detalle "."];
        set largoDetalle [llength $listaDetalle]  
        #se obtiene el Codigo, pero como es muy largo mejor se dice NA
        set codigo [lindex  $listaDetalle [expr $largoDetalle-1]] 
        #puts "codigo del Curso No Asociado> $codigo"
        #####set id_programa_curso [apc-portlet::obtenerIdProgramaCurso $codigo]
        #puts "id_programa_curso> $id_programa_curso"
        ####set existe 1 
        #El Codigo de un CNA(curso no asociado) puede ser es muy largo mejor se dice NA
        set codigo_na $codigo
        set buscoCodigo $codigo
        set codigo "NA"
    }
    
    #Averiga el código de la versión activa, pues es la única que puede mostrarse
    set id_programa_curso [apc_portlet::codigoPCVersionActiva $buscoCodigo]
    if {$id_programa_curso != 0} {
        #Existe el programa de curso activo
        set existe 1
    } else {
        #no existe el programa de curso
        set existe 0
    }
    set id_version [apc_portlet::codigoVersionActiva $buscoCodigo]
    puts "id_version> $id_version"
    puts "*****Va a crear el portlet del curso buscoCodigo> $buscoCodigo con el id_version> $id_version******"
    
    set hayVersionActiva [apc_portlet::averiguaSiHayVersionActiva $buscoCodigo]
    #puts "hayVersionActiva> $hayVersionActiva"
    #existe debe ser igual a 1 para ingresar
    if {$existe && $hayVersionActiva == 1} {
        #puts "entra, pues existe y hay versión activa>$hayVersionActiva"
        
            #si es un Curso Asociado (CA) se busca el requisito
            if {$esCursoAsociado ==1} {
                set requisito "[apc::obtenerRequisitos $id_programa_curso]"
                #puts "El requisito es> $requisito"
                if {$requisito == ""} { 
                    set requisito "NA"
                }
            } else {
                set requisito "NA"
            }
             
            #si es un Curso Asociado (CA) se busca el requisito
            if {$esCursoAsociado ==1} {
                set correquisito "[apc::obtenerCorrequisitos $id_programa_curso]"
                #puts "El correquisito es> $correquisito"
                if {$correquisito == ""} { 
                set correquisito "NA"
                } 
            } else {
                set correquisito "NA"    
            }

            set creditos "[apc::obtenerCreditos $id_programa_curso]"
            set num_horas_semana "[apc::obtenerHrsSemana $id_programa_curso]"
            set num_horas_extra_semana "[apc::obtenerHrsExtraClaseSemana $id_programa_curso]"
            set asistencia "[lindex [apc::obtenerAsistencia $id_programa_curso] 0 ]"

            set reconocimiento "[apc::obtenerReconocimiento $id_programa_curso]"
            if {$reconocimiento == ""} { 
            set reconocimiento ""
            } else {
                   if {$reconocimiento == "f"} { 
                        set reconocimiento "NO"
                   } else {
                        set reconocimiento "SI"
                   }
            }

            set suficiencia "[apc::obtenerSuficiencia $id_programa_curso]"
            if {$suficiencia == ""} { 
            set suficiencia ""
            } else { 
                   if {$suficiencia == "f"} { 
                        set suficiencia "NO"
                   } else {
                        set suficiencia "SI"
                   }
            }
            set tipo "[apc::obtenerTipoCurso $id_programa_curso]"
            set descripcion "[lindex [apc::obtenerDescripcion $id_programa_curso] 0 ]"
            set objetivos_generales "[apc::prepararLista [apc::obtenerObjetivosGenerales $id_programa_curso]]"
            set objetivos_especificos "[apc::prepararLista [apc::obtenerObjetivosEspecificos $id_programa_curso]]"
            set contenidos "[apc-portlet::prepararListaContenidos [apc::obtenerContenidosUyE  $id_programa_curso]]"
            set metodologia "[lindex [apc::obtenerMetodologia $id_programa_curso] 0]"

            set evaluacion1 [apc::obtenerEvaluaciones $id_programa_curso]
            set evaluacion [apc-portlet::prepararListaEvaluaciones $evaluacion1]

            set bibliografia "[apc::prepararLista [apc::obtenerBibliografia $id_programa_curso]]"
            set consideraciones "[lindex [apc::obtenerConsideracionesGenerales $id_programa_curso] 0]"
            #agregado por jacsolis 9/8/2013
            if {$codigo eq "NA"} {
                set codigo $codigo_na
            }
            set return_url "[ad_conn url]?[ns_conn query]"
    } else {
      	 set existe 0
	  set resultado "No existe aún un programa de curso vigente para este curso."
        #puts "resultado> $resultado"
    }
}
ad_return_template


