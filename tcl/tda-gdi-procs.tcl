ad_library {
Procedures in the evaluation namespace.
    
    @creation-date feb 20
    @author agustin.francesa@gmail.com
}

namespace eval gdi {}
namespace eval gdi_utilitarios {}
namespace eval gdi_api {}

################################################################--------existeUsuario
ad_proc -public gdi::existeUsuario {
} {

} {
set user_id [ad_conn user_id]
return [db_0or1row obtenerExisteUsuario {}]
}
################################################################--------obtenerUsuario
ad_proc -public gdi::obtenerUsuario {
} {
Obtiene el nombre del usuario, si es la primera vez que lo usa
presenta el nombre registrado.
} {
set user_id [ad_conn user_id]
set existe [gdi::existeUsuario]

if { $existe eq 0 } {
    set nombreCompleto [db_list_of_lists obtenerNombre {}]

    set nombre [lindex [lindex $nombreCompleto 0] 0]
    set apellido [lindex [lindex $nombreCompleto 0] 1]
    set nombreC "[string trim $nombre] [string trim $apellido]"
} else {
   set nombreC [lindex [db_list obtenerNombreExistente {}] 0]
}

return $nombreC
}
################################################################--------agregarrUsuario
ad_proc -public gdi::agregarUsuario {
nom_usuario
} {

} {
set user_id [ad_conn user_id]
set existe [gdi::existeUsuario]
if { $existe eq 0 } {
    if {[catch {db_dml agregarUsuario {*SQL*}} errmsg]} {
    	ns_log error $errmsg
    }
} else {
    if {[catch {db_dml actualizarUsuario {*SQL*}} errmsg]} {
    	ns_log error $errmsg
    }
}
return $errmsg
}
################################################################--------obtenerCursos
##ad_proc -public gdi::obtenerCursos {
##} {
##
##} {
##set user_id [ad_conn user_id]
##set cedula 1
##if {[catch {set cedula [db_list ObtenerCedulaUsuario {}]} errmsg]} {
##	ns_log error $errmsg
##}

##if {$cedula ne ""} {
##    set anno [clock format [clock seconds] -format %Y]
    #set cursos [lindex [lindex [wsPROFESORXCURSO_Buscar $anno "" "" "" "" $cedula ""] 3] 1]
##    set cursos ""
##    set size [llength $cursos]
##    set resultado {}
##    for {set i 0} {$i < $size} {incr i} {
##        set cursoActual [lindex $cursos $i]
##        set modalidad [lindex $cursoActual [expr {1+[lsearch $cursoActual IDE_MODALIDAD]}]]
##        set periodo [lindex $cursoActual [expr {1+[lsearch $cursoActual IDE_PER_MOD]}]]
        #set periodoActual [lindex [lindex [lindex [lindex [wsPERIODO_ACTUAL_Buscar $modalidad] 3] 1] 1] [expr {1+[lsearch [lindex [lindex [lindex [wsPERIODO_ACTUAL_Buscar $modalidad] 3] 1] 1] Periodo_Actual]}]]
##        set periodoActual ""
##        if {$periodo eq $periodoActual} {
##            set codigoCurso [lindex $cursoActual [expr {1+[lsearch $cursoActual IDE_MATERIA]}]]
##            set nombreCurso [lindex $cursoActual [expr {1+[lsearch $cursoActual DSC_MATERIA]}]]
##            set grupoCurso [lindex $cursoActual [expr {1+[lsearch $cursoActual IDE_GRUPO]}]]
##            set cursoCodigoNombre [concat \"$nombreCurso\" $codigoCurso\.$grupoCurso.$modalidad.$periodo]
##            lappend resultado $cursoCodigoNombre
##        }
##    }
##    set resultado [lsort -increasing $resultado]
##} else {
##    set resultado [list [concat "\"Sin cursos asociados en este momento.\"" 0]]
##}
##puts "--- $cedula -----------  $resultado"
##return $resultado
##}

# Versión nueva del procedimiento para buscar los cursos asignados pero desde la plataforma
# y no de un web service. Alternativa al procedimiento -comentado- anterior.
ad_proc -public gdi::obtenerCursos {
} {

} {
     set user_id [ad_conn user_id]
     set listaModalidades {A B C H I M S T V}
     set stringBusqueda {}
     set periodoActual [admision::PERIODO_ACTUAL_Buscar A]
     set annio [lindex [lindex $periodoActual 0] [expr {1+[lsearch [lindex $periodoActual 0] Anno_Actual]}]]
      
     #set annio 2012
     
     for {set i 0} { $i < 9 } {incr i} {
	set periodoActual [admision::PERIODO_ACTUAL_Buscar [lindex $listaModalidades $i]]
        set numeroPeriodo [lindex [lindex $periodoActual 0] [expr {1+[lsearch [lindex $periodoActual 0] Periodo_Actual]}]]     
        
        set nodoBusqueda [list [concat "[lindex $listaModalidades $i]-$numeroPeriodo-$annio"]]
        lappend stringBusqueda $nodoBusqueda
     }
     

     set nodoBusquedaAnual [lindex $stringBusqueda 0]
     
     set nodoBusquedaBimestre [lindex $stringBusqueda 1]
     
     set nodoBusquedaCuatrimestre [lindex $stringBusqueda 2]
     
     set nodoBusquedaCentrosDeFormacion [lindex $stringBusqueda 3]
     
     set nodoBusquedaIntensivo [lindex $stringBusqueda 4]
     
     set nodoBusquedaMensual [lindex $stringBusqueda 5]
     
     set nodoBusquedaSemestre [lindex $stringBusqueda 6]
     
     #set nodoBusquedaSemestre "S-2-2013"
     set nodoBusquedaTrimestre [lindex $stringBusqueda 7]
     
     set nodoBusquedaVerano [lindex $stringBusqueda 8]
     
     
     set cursos [db_list_of_lists obtenerExisteCursos {}]

     set iteraciones [llength $cursos]
     
     if { $iteraciones > 0 } {
     	for {set i 0} { $i < $iteraciones } {incr i} {
     		set curso [lindex $cursos $i]

     		set nombreCurso [lindex $curso 1]
     		set codigoCurso [lindex [split [lindex $curso 0] "."] 1]
     		set grupo [lindex [split [lindex $curso 2] "."] 3]
     		#set grupo [lindex [lindex $curso 2] [expr {[llength [lindex $curso 2]] - 1} ]]

     		#set modalidad [lindex [split [lindex $curso 3] "-"] 0]
     		set modalidad [lindex [split [lindex [split [lindex $curso 2] "."] 0] "-"] 0]

     		if { [string length $modalidad ] != 1 } {
     		    set codigoCursoPlataforma [lindex $curso 0]
     			set cursoCodigoNombre [concat \"$nombreCurso\" $codigoCursoPlataforma] 
     		} else {
     			set cursoCodigoNombre [concat \"$nombreCurso\" $codigoCurso.$grupo.$modalidad]
     		}

     		lappend resultado $cursoCodigoNombre
     	}
     } else {
#     	set resultado [list [concat "\"Sin cursos asociados en este momento.\"" 0]]
     	set resultado [list [concat "\" [_ tda-gdi.optwithoutcourses]\"" 0]]
     }

     return $resultado
}
################################################################--------obtenerInformacionCurso
ad_proc -public gdi::obtenerInformacionCurso {
    datosCurso
    tipoConsulta
} {


} {

#set user_id [ad_conn user_id]
#set community_type [split [lindex [db_list obtenerCodigo {}] 0] "."]
#set codigoCarrera "Com.[lindex $community_type 0]"
#set listaProfesores [db_list_of_lists obtenerProfesores {}]
#set iteraciones [llength $listaProfesores]
#set profesores "[lindex $listaProfesores 0]"
#for {set i 1} {$i < $iteraciones} {incr i} {
#    set profesor [lindex $listaProfesores $i]
#    set profesores "$profesores<br>$profesor"
#}
#set cursoInfo(nombreCarrera) "[lindex [db_list NombreCarrera {}]]"
#set cursoInfo(codigoCurso) "[lindex $community_type 1]"
#set cursoInfo(nombreCurso) "[lindex [db_list obtenerNombreCurso {}] 0]"
#set cursoInfo(profesores) $profesores
#return [array get cursoInfo]
    if { $tipoConsulta eq 0} {

        set codigo [lindex [split $datosCurso "."] 0]
        set grupo [lindex [split $datosCurso "."] 1]
        set modalidad [lindex [split $datosCurso "."] 2]
        set periodo [lindex [split $datosCurso "."] 3]
        set anno [clock format [clock seconds] -format %Y]
        set guia [lindex [lindex [wsIESCCARGAGUIAHORARIOS_Buscar $anno "" "" "" "" "$codigo" ""] 3] 1]
        
        
        # PARTE AGREGADA POR PEDRO
        set escuela [lindex [lindex $guia 0] [expr {1+[lsearch [lindex $guia 0] IDE_DEPTO]}]]
		set planes [lindex [lindex [wsPLANES_Buscar "" "" $escuela ""] 3] 1]
		set planesLargo [llength $planes]
		set plan [lindex [lindex $planes [expr {$planesLargo - 1}]] [expr {1 + [lsearch [lindex $planes [expr {$planesLargo - 1}]] IDE_PLAN]}]]
		# -- FIN PARTE PEDRO

        if { $guia ne "" } {

            set size [llength $guia]
            set resultado {}
            for {set i 0} {$i < $size} {incr i} {
            	set cursoActual ""

            	if {[lindex $guia $i] eq "IESCCARGAGUIAHORARIOS"} {
                	set cursoActual [lindex [ lindex $guia 1 ] $i]

                } else {
                	set cursoActual [ lindex $guia $i ]
                }
                
                set grupoCurso [lindex $cursoActual [expr {1+[lsearch $cursoActual IDE_GRUPO ]}]]
                set grupo [expr {1 * $grupo}]

                set grupoCurso [string trimleft $grupoCurso "0"]

                ## OJO ESTA VALIDACIÓN
                ## ---------------------------------------------
                #if {$grupo eq $grupoCurso} {}
                if {[string is integer -strict $grupoCurso]} {

                    set horario ""
                    set cursoInfo(codigoCurso) [lindex $cursoActual [expr {1+[lsearch $cursoActual IDE_MATERIA ]}]]


                    set cursoInfo(nombreCurso) [lindex $cursoActual [expr {1+[lsearch $cursoActual DSC_MATERIA ]}]]
                    set cursoInfo(nombreCarrera) [lindex $cursoActual [expr {1+[lsearch $cursoActual DSC_DEPTO ]}]]

                    set diaCurso [obtenerLetraDia [lindex $cursoActual [expr {1+[lsearch $cursoActual COD_DIA ]}]]]
                    set horaInicioCurso [lindex $cursoActual [expr {1+[lsearch $cursoActual NUM_HORA_INICIO ]}]]
                    set horaFinCurso [lindex $cursoActual [expr {1+[lsearch $cursoActual NUM_HORA_FIN ]}]]
                    set idProfesor [lindex $cursoActual [expr {1+[lsearch $cursoActual IDE_PROFESOR ]}]]
                    set horarioAnt "$diaCurso $horaInicioCurso-$horaFinCurso"
                    append horario $horarioAnt
                    append listaDiasClasesCurso $horario
            ## aqui verfica si el curso es en 2 días o más, para obtener su horario o si tiene varios profesores, que los agregue
                    if {$i <= [expr {$size - 1}]} {
                        set salga 0
                        set profesores [gdi::obtenerUsuario]
                        set idProfesores [list idProfesor]
                        while {$salga == 0 } {    
                            set cursoSiguiente [ lindex $guia [expr {1+$i}]]
                            set grupoCursoSiguiente [lindex $cursoSiguiente [expr {1+[lsearch $cursoSiguiente IDE_GRUPO ]}]]
                            set codigoCursoSiguiente [lindex $cursoSiguiente [expr {1+[lsearch $cursoSiguiente IDE_MATERIA ]}]]
                            set diaCursoSiguiente [obtenerLetraDia [lindex $cursoSiguiente [expr {1+[lsearch $cursoSiguiente COD_DIA ]}]]]
                            set horaInicioCursoSiguiente [lindex $cursoSiguiente [expr {1+[lsearch $cursoSiguiente NUM_HORA_INICIO ]}]]
                            set horaFinCursoSiguiente [lindex $cursoSiguiente [expr {1+[lsearch $cursoSiguiente NUM_HORA_FIN ]}]]
                            set idProfesorCursoSiguiente [lindex $cursoSiguiente [expr {1+[lsearch $cursoSiguiente IDE_PROFESOR ]}]]
                ##verifica si es el mismo curso, para añadirle el siguiente horario y profesor de ser el caso
	                    	if {$grupoCurso == $grupoCursoSiguiente && $codigoCursoSiguiente == $cursoInfo(codigoCurso)} {
	                        	set horarioTemp  "$diaCursoSiguiente $horaInicioCursoSiguiente-$horaFinCursoSiguiente"
                #si tiene el mismo horario, quiere decir que tiene un profesor nuevo
		                		if { $horarioTemp == $horarioAnt } { 
                #verifica que no sea el mismo profesor
                                    set existe [lsearch $idProfesores $idProfesorCursoSiguiente]
			            				if { $existe < 0} {
			                				lappend profesores [lindex $cursoSiguiente [expr {1+[lsearch $cursoSiguiente IDE_PROFESOR ]}]]
			            				}
	                        	} else {
                                	append horario "<br>$horarioTemp"
			            			set horarioAnt $horarioTemp
		                		}
		                		
		                		set i [expr {1+$i}]
                            
                            	} else {
	                        		set salga 1
                            	}
                        }
                    }
                    set cursoInfo(profesores) "$profesores"
                    set cursoInfo(horario) "$horario"
                    ## funcionalidad para obtener el plan al cual el curso esta asociado. Actualmente se obtiene el ultimo plan.
                    set escuela ""
                    if {[lindex $guia 0] eq "IESCCARGAGUIAHORARIOS"} {
                        set escuela [lindex [lindex $guia 1] [expr {1+[lsearch [lindex $guia 1] IDE_DEPTO]}]]
                    } else {
                        set escuela [lindex [lindex $guia 0] [expr {1+[lsearch [lindex $guia 0] IDE_DEPTO]}]]
                    }

					set planes [lindex [lindex [wsPLANES_Buscar "" "" $escuela ""] 3] 1]
					set planesLargo [llength $planes]
					set cursoInfo(plan) [lindex [lindex $planes [expr {$planesLargo - 1}]] [expr {1 + [lsearch [lindex $planes [expr {$planesLargo - 1}]] IDE_PLAN]}]]
                }
            }
        } else {
            set cursoInfo(codigoCurso) ""
        }
    ## se ejecuta si el curso en cuestion fue creado en la plataforma y no existe en un plan normal del ITCR
    } elseif { $tipoConsulta eq 1 } {
        set user_id [ad_conn user_id]
        set guia [db_list_of_lists obtenerInformacionCursoPlataforma {}]
        #set cursoInfo(codigoCurso) "No aplica" [_ tda-gdi.infnoapply]
        set cursoInfo(codigoCurso) "[_ tda-gdi.infnoapply]"
        set cursoInfo(nombreCurso) [lindex [lindex $guia 0] 0]
        #set cursoInfo(nombreCarrera) "No aplica"
        set cursoInfo(nombreCarrera) "[_ tda-gdi.infnoapply]"
        set cursoInfo(profesores) [gdi::obtenerUsuario]
        #set cursoInfo(horario) "No aplica"
        set cursoInfo(horario) "[_ tda-gdi.infnoapply]"
        #set cursoInfo(plan) "No aplica"
        set cursoInfo(plan) "[_ tda-gdi.infnoapply]"
    }  else {      
        set guia [lindex [lindex [wsMATERIAS_Buscar $datosCurso "" ""] 3] 1]
        set cursoInfo(codigoCurso) $datosCurso
        set cursoInfo(nombreCurso) [lindex [lindex $guia 1] 3]
        #set cursoInfo(nombreCarrera) "No aplica"
        set cursoInfo(nombreCarrera) "[_ tda-gdi.infnoapply]"
        #set cursoInfo(profesores) "No aplica"
        set cursoInfo(profesores) "[_ tda-gdi.infnoapply]"
        #set cursoInfo(horario) "No aplica"
        set cursoInfo(horario) "[_ tda-gdi.infnoapply]"
        set cursoInfo(plan) ""
    }
    return [array get cursoInfo]
}


ad_proc -public gdi::obtenerInformacionDI {
    datosDI
} {

} {
set usuario_id [ad_conn user_id]

if {[catch { set infoDI [db_list_of_lists obtenerInfoDI {}]} errmsg]} {
    ns_log error $errmsg
}


#programa_estudio_id, curso_id, fec_creacion, fec_ultima_modificacion
set diInfo(nombreCurso) [string trim [lindex [lindex $infoDI 0] 4] '{}'] 
set diInfo(codigoCurso) "[lindex [lindex $infoDI 0] 1]"
set diInfo(plan) "[lindex [lindex $infoDI 0] 0]" 
set diInfo(fecCreacion) "[lindex [lindex [lindex $infoDI 0] 2] 0]" 
set diInfo(fecModificacion) "[lindex [lindex [lindex $infoDI 0] 3] 0]"
#set diInfo(escuela) "[lindex [lindex [lindex $infoDI 0] 5] 0]"
set diInfo(escuela) "[lindex [lindex $infoDI 0] 5]" 
#puts $diInfo(nombreCurso)
#puts $diInfo(codigoCurso)
#puts $diInfo(plan)
#puts $diInfo(fecCreacion)
#puts $diInfo(fecModificacion)
#puts $diInfo(escuela)
return [array get diInfo]
}


















################################################################--------obtenerPlanes
ad_proc -public gdi_utilitarios::obtenerPlanes {
    id_departamento
} {
procesa un web service, para que muestre el nombre y el código de los planes segun un departamento dado
los web service devuelven una lista con el nombre_atributo valor_atributo, por lo tanto
se busca dicho nombre y se le suma 1 a su posición, para así obtener su valor
se contatena de esa manera, porque es el formato del combo box
} {
    set planes [lindex [lindex [wsPLANES_Buscar "" "" $id_departamento ""] 3] 1]
    #set planes ""
    set size [llength $planes]
    set resultado {}
    for {set i 0} {$i < $size} {incr i} {

        set planActual [lindex $planes $i]

        set codigoPlan [lindex $planActual [expr {1+[lsearch $planActual IDE_PLAN]}]]
        set nombrePlan [lindex $planActual [expr {1+[lsearch $planActual DSC_PLAN]}]]

        set planCodigoNombre [concat "\"" $codigoPlan " - " $nombrePlan "\"" $codigoPlan]

        if {$codigoPlan != "PLANES"} {
            # lappend resultado $planCodigoNombre
            lappend resultado $codigoPlan $nombrePlan
        }
    }
     
    # # if { [ llength $resultado ] == 0 } {
    # # 	set etiqueta [concat "\" [_ tda-gdi.optselectanoption] \"" "label"]
    # # } else {
    # 	set etiqueta [concat "\" [_ tda-gdi.optselectanoption] \"" "label"]
    # # }
    set resultado  [linsert $resultado 0 "[_ tda-gdi.optselectanoption]"]
    set resultado  [linsert $resultado 0 "label"]
    return $resultado
}
################################################################--------obtenerDepartamentos
ad_proc -public gdi_utilitarios::obtenerDepartamentos {
 	id_sede
} {
procesa un web service, para que muestre el nombre y el código del departamento sin distinción de sede
adicionalmente verifica que el web service no traiga basura como IEPEFDEPTOS, además
de que el el tipo de departamento IDE_TIP_DEP sea 2 o 3, que son los del área académica.
} {
    set departamentos [lindex [lindex [wsIEPEFDEPTOS_Buscar "" "" ""] 3] 1]
    #set departamentos ""
    set size [llength $departamentos]
    set resultado {}

    for {set i 0} {$i < $size} {incr i} {
        set departamentoActual [ lindex $departamentos $i ]
        set codigoDepartamento [lindex $departamentoActual [expr {1+[lsearch $departamentoActual IDE_DEPTO ]}]]
        set planes [apc::obtenerPlanes $codigoDepartamento]

        if { $departamentoActual != "IEPEFDEPTOS" && $planes != "" } {

            set PostipoDepartamento [lsearch $departamentoActual IDE_TIP_DEP ]
            set tipoDepartmento [lindex $departamentoActual [expr {1+$PostipoDepartamento}]]

            if { $tipoDepartmento == 3 || $tipoDepartmento == 2} {

                set codigoDepartamento [lindex $departamentoActual [expr {1+[lsearch $departamentoActual IDE_DEPTO ]}]]
                set nombreDepartamento [lindex $departamentoActual [expr {1+[lsearch $departamentoActual DSC_DEPTO ]}]]
                set departamentoCodigoNombre [concat "\"" $nombreDepartamento "\" " $codigoDepartamento]

                if { [lsearch $resultado $departamentoCodigoNombre] == -1 && $codigoDepartamento != "SE"} {
                    lappend resultado $departamentoCodigoNombre
                }
            }
        }
    }

    set resultado [lsort -increasing $resultado]

    # set etiqueta [concat "\" [_ tda-gdi.optselectanoption] \"" "label"]
    # set resultado  [linsert $resultado 0 "[_ tda-gdi.optselectanoption]"]
    # set resultado  [linsert $resultado 0 "label"]

    return $resultado
}
################################################################--------obtenerMaterias
ad_proc -public gdi_utilitarios::obtenerMaterias {
	id_plan
} {
procesa un web service, para que muestre el nombre y el código de los cursos segun un plan dado
los web service devuelven una lista con el nombre_atributo valor_atributo, por lo tanto
se busca dicho nombre y se le suma 1 a su posición, para así obtener su valor
se contatena de esa manera, porque es el formato del combo box
} {

set materias [lindex [lindex [wsIEPEFMATE_PLAN_Buscar $id_plan] 3] 1]
set size [llength $materias]
set resultado {}
set periodo 1
for {set i 0} {$i < $size} {incr i} {
	set materiaActual [lindex $materias $i]
	set nivelMateria [lindex $materiaActual [expr {1+[lsearch $materiaActual NUM_NIVEL]}]]
	if {$periodo == $nivelMateria} {
		set codigoMateriaTemp tPER
        puts $codigoMateriaTemp
		set nombreMateriaTemp [concat "Periodo $nivelMateria"]
        puts $nombreMateriaTemp
		set materiaCodigoNombreTemp [concat "\"$nombreMateriaTemp\"" $codigoMateriaTemp]
		lappend resultado $nombreMateriaTemp $codigoMateriaTemp
		set periodo [expr {$periodo + 1}] 
	}
	set codigoMateria [lindex $materiaActual [expr {1+[lsearch $materiaActual IDE_MATERIA]}]]
	set nombreMateria [lindex $materiaActual [expr {1+[lsearch $materiaActual DSC_MATERIA]}]]
	# set materiaCodigoNombre [concat "\"" "<div><span>" $nombreMateria "</span><span>" $codigoMateria "</span></div>" "\"" $codigoMateria]
	
	lappend resultado $codigoMateria $nombreMateria
}
# if { [ llength $resultado ] == 0 } {
	# set etiqueta [concat "\" [_ tda-gdi.optselectanoption] \"" "label"]
	# } else {
	# set etiqueta [concat "\" [_ tda-gdi.optselectanoption] \"" "label"]
	# }
set resultado  [linsert $resultado 0 "[_ tda-gdi.optselectanoption]"]
set resultado  [linsert $resultado 0 "label"]
return $resultado
}
################################################################--------obtenerPeriodos
ad_proc -public gdi_utilitarios::obtenerPeriodos {
 	id_modalidad
} {
según la modalidad, muestra el número exacto de periodos
su código es el mismo que el periodo.
} {
set max 0
set resultado {}
switch $id_modalidad {
 A { set max 1 }
 B { set max 7 }
 C { set max 3 }
 I { set max 2 }
 M { set max 12 }
 S { set max 2 }
 T { set max 4 }
 V { set max 1 }
 default { set max 100 }
}
if { $max == 100 } {
   lappend resultado [concat "\"No aplica\" " 100] 
} else {
 for {set i 1} {$i <= $max} {incr i} {
    set periodo [concat "\"" $i "\" " $i]
    lappend resultado $periodo
 }
}
return $resultado
}
################################################################--------obtenerANos
ad_proc -public gdi_utilitarios::obtenerANos {
} {
muestra los años decrecientemente, del año actual hasta 1977
} {
set mes [obtenerMesActual]
set aNo_Actual [obtenerAnnoActual]
if { $mes == 12 || $mes == 11 } {
	set aNo_Actual [expr {1 + $aNo_Actual}]
}
set resultado {}
for {set i $aNo_Actual} {$i >= 1977} {decr i} {
    set aNo [concat \"$i\" $i]
    lappend resultado $aNo
}
return $resultado
}
################################################################--------obtenerModalidades
ad_proc -public gdi_utilitarios::obtenerModalidades {
} {
procesa un web service, para que muestre el nombre y el código de las modalidades.
} {
    set modalidades [lindex [lindex [wsIEPEFMODALIDADES_SeleccionarTodos] 3] 1]
    set size [llength $modalidades]
    set resultado {}
    for {set i 0} {$i < $size} {incr i} {
        set modalidadActual [lindex $modalidades $i]
        set codigoModalidad [lindex $modalidadActual [expr {1+[lsearch $modalidadActual IDE_MODALIDAD]}]]
        set nombreModalidad [lindex $modalidadActual [expr {1+[lsearch $modalidadActual DSC_MODALIDAD]}]]
        set modalidadCodigoNombre [concat \"$nombreModalidad\" $codigoModalidad]
        lappend resultado $modalidadCodigoNombre
    }
    set resultado [lsort -increasing $resultado]
    return $resultado
}




ad_proc -public gdi::salvarDI {
    idDI
    di
    programaCurso
    nombreDI
    cod_curso
    sesiones
    estados
    nombre_curso
    escuela
} {

} {
    #puts "tda-gdi_di-log"
    #puts "idDI $idDI"
    #puts "di $di"
    #puts "programaCurso $programaCurso"
    #puts "nombreDI $nombreDI" 
    #puts "cod_curso $cod_curso"
    #puts "sesiones $sesiones"
    #puts "estados $estados"
    #puts "nombre_curso $nombre_curso"
    #puts "nombre_escuela $escuela"
    set usuario_id [ad_conn user_id]
    #puts "id de usuario $usuario_id"
    #puts "Nombre del Disennio Instruccional  $nombreDI" 

           
#quiere decir que no existe ese DI para usuario y curso
    if {$idDI eq "-1"} {
###Crear el id en del diseño instruccional en la tabla
        if {[catch {set idDI [db_list crearDI {}]} errmsg]} {
	        ns_log error $errmsg
        }
###Asocia el diseño instruccional al usuario.
        if {[catch {db_dml asociarDI {*SQL*}} errmsg]} {
	        ns_log error $errmsg
        }
    } else {
        if {[catch [db_dml actualizarSesionesDI {}] errmsg]} {
            ns_log error $errmsg
        }
    }    
    if {[catch [db_dml actualizarFecha {}] errmsg]} {
        ns_log error $errmsg
    }
    #set fecha [db_dml actualizarFecha {}]
    set sesiones [split "$di" "`"]
    set cantidadSesiones [llength $sesiones]
    set estados [split "$estados" "-"]

    #if {[catch {db_dml borrarTodoDependendencias {*SQL*}} errmsg]} {
    #                 ns_log error $errmsg }

    for {set numSesion 1} {$numSesion <= $cantidadSesiones} {incr numSesion} {
        set sesion [lindex $sesiones [expr {$numSesion - 1}]]
        set componentes [split "$sesion" "^"]
        set cantidadComponentes [llength $componentes]
        for {set numComponente 0} {$numComponente < $cantidadComponentes} {incr numComponente} {
            set componente [lindex $componentes $numComponente]
            set estado [lindex $estados [expr {[expr {6 * [expr {$numSesion - 1}]}] + $numComponente}]]
               
            gdi::guardarDI $numComponente $componente $idDI $numSesion $estado $nombre_curso
        }
    }
    return $idDI
}



ad_proc gdi::guardarDI {
    numComponente
    componente
    idDI
    numSesion
    estado
    nombre_curso
} {

} {
    
    set queryCantidad "cantidadActualElementos"
    switch $numComponente {
        0 { set queryInsertar "insertarTitulo"
            set queryActualizar "actualizarTitulo"
            set queryBorrar "eliminarTitulo" }
        1 { set queryInsertar "insertarObjetivoAprendizaje"
            set queryActualizar "actualizarObjetivoAprendizaje"
            set queryBorrar "eliminarObjetivoAprendizaje" }
        2 { set queryInsertar "insertarModuloContenido"
            set queryActualizar "actualizarModuloContenido"
            set queryBorrar "eliminarModuloContenido" }
        3 { set queryInsertar "insertarActividadAprendizaje"
            set queryActualizar "actualizarActividadAprendizaje"
            set queryBorrar "eliminarActiviadAprendizaje" }
        4 { set queryInsertar "insertarMedioMaterial"
            set queryActualizar "actualizarMedioMaterial"
            set queryBorrar "eliminarMedioMaterial" }
        5 { set queryInsertar "insertarEvaluacion"
            set queryActualizar "actualizarEvaluacion"
            set queryBorrar "eliminarEvaluacion" }
    }
    set elementos [split "$componente" "\\"]
    #puts "Iteración en fila de la matriz -----------"
    #puts "Componente: $numComponente"
    #puts "elementos: $elementos"
    set cantidadActualElementos [llength $elementos]
    set cantidadBdElementos 0
    if {[catch {set cantidadBdElementos [db_list $queryCantidad {}]} errmsg]} {
        ns_log error $errmsg }
    #puts "cantidadActualElementos <= cantidadBdElementos: $cantidadActualElementos <= $cantidadBdElementos"
    if { $cantidadActualElementos <= $cantidadBdElementos } {
        set final [expr {$cantidadBdElementos - 1}]
        ###### hay más en la lista. Primero, actualiza
        #como hay más en la BD se hace el ciclo con 
        #base en eso, pero, se actualiza hasta la cantidad
        #de la lista en memoria

        set pivoteBorrado 0
        for {set posicion 0} {$posicion < $cantidadBdElementos} {incr posicion} {
            #puts " posicion ---- $posicion  $final"
            set elemento [lindex $elementos $posicion]
            #puts "Actualizando elementos en ... $posicion < $cantidadActualElementos ..."
            if {$posicion < $cantidadActualElementos} {
                if {[catch {db_dml $queryActualizar {*SQL*}} errmsg]} {
                     ns_log error $errmsg }
                #puts "... actualizando la posición $posicion con estado $estado"
                #luego borra los que sobran en la base de datos
            } else {
                #puts "*************" 
                
                #puts "numComponente $numComponente"
                #puts "componente $componente"
                #puts "numSesion $numSesion"
                #puts "estado $estado"
                #puts "nombre_curso $nombre_curso"
                #puts "*** FIN"
                set posicionBorrado [expr {$posicion - $pivoteBorrado}]
                #puts "posicion - pivoteBorrado: $posicion - $pivoteBorrado"
                #puts "Eliminando la posicion $posicionBorrado"
                if {[catch {db_dml $queryBorrar {*SQL*}} errmsg]} {
                     ns_log error $errmsg }
#                puts "... borra --- B $posicion  estado $estado"
                set pivoteBorrado [expr {$pivoteBorrado + 1}]

            }
        }
    } else {
        ###### hay más en la memoria, entonces se
        #hace lo contrario del paso anterior. Primero, actualiza
        for {set posicion 0} {$posicion < $cantidadActualElementos} {incr posicion} {
            set elemento [lindex $elementos $posicion]
            if {$posicion < $cantidadBdElementos} {
                if {[catch {db_dml $queryActualizar {*SQL*}} errmsg]} {
                     ns_log error $errmsg }
#                puts "... actualiza --- I  estado $estado"
                #luego agrega los que faltan en la base de datos
            } else {
                if {[catch {db_dml $queryInsertar {*SQL*}} errmsg]} {
                     ns_log error $errmsg }
#                puts "... agrega --- I  estado $estado"
            }
        }
    }
}






ad_proc -public gdi::obtenerNombreDI {
    di
} {

} {
set usuario_id [ad_conn user_id]
if {[catch { set nombreDI [db_exec_plsql obtenerNombreDI {}]} errmsg]} {
    ns_log error $errmsg
}
return "$nombreDI"
}


ad_proc -public gdi::obtenerSesionesDI {
    di
} {

} {
set usuario_id [ad_conn user_id]
#set sesionesDI "prueba"
if {[catch { set sesionesDI [db_exec_plsql obtenerSesionesDI {}]} errmsg]} {
    ns_log error $errmsg
}
return "$sesionesDI"
}

ad_proc -public gdi::cargarDI {
    idDI
    cantidadSesiones
} {

} {
set respuesta ""
for {set sesion 1} {$sesion <= $cantidadSesiones} {incr sesion} {
#puts "sesion $sesion"
    for {set componente 0} {$componente <= 5} {incr componente} {
#puts "componente $componente"
        switch $componente {
            0 { set valores [db_list_of_lists obtenerTitulo {}] }  
            1 { set valores [db_list_of_lists obtenerObjetivoAprendizaje {}] }
            2 { set valores [db_list_of_lists obtenerModuloContenido {}] }  
            3 { set valores [db_list_of_lists obtenerActividadAprendizaje {}] }  
            4 { set valores [db_list_of_lists obtenerMedioMaterial {}] }  
            5 { set valores [db_list_of_lists obtenerEvaluacion {}] }  
        }
        set respuesta "$respuesta[string trim [lindex $valores 0] "{}"]"
        for {set i 1} {$i < [llength $valores]} {incr i} {
            set respuesta "$respuesta\\[string trim [lindex $valores $i] "{}"]"
        }
        if {$componente != 5} {
            set respuesta "$respuesta^" 
        }
    }
    if {$sesion != $cantidadSesiones} {
        set respuesta "$respuesta`"
    }
}

return "$respuesta"
}




ad_proc -public gdi::cargarEstados {
    idDI
    cantidadSesiones
} {

} {
set respuesta ""
for {set sesion 1} {$sesion <= $cantidadSesiones} {incr sesion} {
    for {set componente 0} {$componente <= 5} {incr componente} {
        set valores [db_exec_plsql obtenerEstado {}]
        if {[lindex $valores 0] == "" } {
            set respuesta  "$respuesta[string trim "0"]-"
        } else {
            set respuesta "$respuesta[lindex $valores 0]-"
        }
    }
}
#puts "----- $respuesta"
return "[string trim $respuesta "-"]"
}





ad_proc -public gdi::obtenerDIusuario {
    {usuario_id -1}
} {

} {
    if {$usuario_id eq -1} {
        set usuario_id [ad_conn user_id]
    }

    set listaDI ""
    if {[catch { set listaDI [db_list_of_lists obtenerDIusuario {}]} errmsg]} {
        ns_log error $errmsg
    }
#    puts "----´ $listaDI"
    if {$listaDI == ""} {
        set listaDI {{"No posee DI" 0}}
    }
    return $listaDI
}





proc obtenerLetraDia {
	id_dia
} {
    set letraDia "°°"
    switch $id_dia {
         1 { set letraDia "L" }
         2 { set letraDia "K" }
         3 { set letraDia "M" }
         4 { set letraDia "J" }
         5 { set letraDia "V" }
         6 { set letraDia "S" }
         default { set letraDia "D" }
    }
    return $letraDia
}


################################################################--------obtenerAyuda
ad_proc -public gdi::obtenerAyudaWizard {
} {
Obtiene la descripcion de la ayuda de la seccion correspondiente. 
} {
return [db_list obtenerAyudaWizard {}]
}
################################################################--------obtenerNombreCurso
ad_proc -public gdi::obtenerNombreCurso {
codDi
} {

} {
   set nombre ""
   set codDi "$codDi"
   if {[catch { set nombre [db_string obtenerNombreCurso {}]} errmsg]} {
       ns_log error $errmsg
   }
   return $nombre
   ##select pretty_name
   ##from dotlrn_communities_all
   ##where community_id = :community_id;
}
###############################################################---------obtenerPreguntasContexto
ad_proc -public gdi::obtenerPreguntasContexto {
} {
Obtiene la descripcion de las preguntas a ser mostradas en el contexto del disenno instruccional. 
} {
return [db_list_of_lists obtenerPreguntasContexto {}]
}
#############################################################-----------insertarRespuestasContexto
ad_proc -public gdi::insertarRespuestaContextoDI {
respuestaContextoDI
} {
Almacena las respuestas del contexto del disenno instruccional.
} {
	set desc_respuesta [lindex $respuestaContextoDI 1]
	set pregunta_id [lindex $respuestaContextoDI 0]
	set disenno_instruccional_id [lindex $respuestaContextoDI 2]
	set estado_respuesta [lindex $respuestaContextoDI 3]
	set existe [db_0or1row obtenerExisteRespuesta {}]
	if {$existe && $desc_respuesta!={}} {
		if {[catch { db_dml actualizarRespuesta {*SQL*} } errmsg]} {
        		ns_log error $errmsg
    		}
	} elseif {$desc_respuesta=={}} {
		if {[catch {db_dml borrarRespuestaContexto {*SQL*}} errmsg]} {
                	ns_log error $errmsg }
	} else {
		if {[catch { db_dml insertarRespuestaContextoDI {*SQL*} } errmsg]} {
        		ns_log error $errmsg
    		} 	 
    	}
}
###############################################################---------obtenerPreguntasContexto
ad_proc -public gdi::obtenerRespuestaContexto {
di 
idPregunta
} {
Presenta la respuesta de la pregunta especifica solicitada por el idPregunta para el DI.
} {
	return [db_list_of_lists obtenerRespuestaContexto {}]
}

###############################################################---------obtenerAyuda
ad_proc -public gdi::obtenerAyuda {
} {
Presenta la respuesta de la pregunta especifica solicitada por el idPregunta para el DI.
} {
	return [db_list_of_lists obtenerAyuda {}]
}

###############################################################---------obtenerCursosUsuario
ad_proc -public gdi::obtenerCursosUsuario {
} {
Obtiene todos los cursos a los que un profesor (Usuario) esta asociado en la plataforma. 
Entradas: ninguna
Salidas: lista de cursos a los que el usuario esta asociado, con el respectivo codigo
} {
    set usuario_id [ad_conn user_id]
    ##set usuario_id 328135
	return [db_list_of_lists obtenerCursosUsuario {}]
}

###############################################################---------insertarCursoAsociado
ad_proc -public gdi::insertarCursoAsociado {
	idDi
    communityId
} {
Almacena la asociacion de los cursos y un DI en Base de Datos
Entradas: el id del disenno instruccional en cuestion, y un arreglo de community_id
Salidas: ninguna. Cursos almacenados en BD.
} {
	set disenno_instruccional_id $idDi
	set community_id $communityId
	
	if {[catch {db_dml insertarCursoAsociado {*SQL*}} errmsg]} {
    	ns_log error $errmsg }
} 

###############################################################---------borrarCursosAsociados
ad_proc -public gdi::borrarCursosAsociados {
	idDi
} {
Elimina la asociacion de los cursos y un DI en Base de Datos
Entradas: el id del disenno instruccional en cuestion
Salidas: ninguna. Cambios en BD.
} {
	set disenno_instruccional_id $idDi
	
    if {[catch {db_dml borrarCursosAsociados {*SQL*}} errmsg]} { 
    	ns_log error $errmsg }
}

###############################################################---------obtenerCursosAsociados
ad_proc -public gdi::obtenerCursosAsociados {
	idDi
} {
Retorna los cursos asociados a un DI
Entradas: el id del disenno instruccional en cuestion
Salidas: los community_id de los cursos asocuados al DI
} {
	set disenno_instruccional_id $idDi
	
    set cursosAsociados [db_list_of_lists obtenerCursosAsociados {}]
    	
    return $cursosAsociados
}

###############################################################---------obtenerInformacionCursosAsociados
ad_proc -public gdi::obtenerInformacionCursosAsociados {
	idDi
} {
Retorna la informacion de los cursos asociados a un DI
Entradas: el id del disenno instruccional en cuestion
Salidas: una lista de listas con el nombre, el periodo y el annio del curso. 
} {
	set disenno_instruccional_id $idDi
	set arregloCommunityIds [gdi::obtenerCursosAsociados $idDi]
	set resultado ""
	set usuario_id [ad_conn user_id]
	for {set i 0} {$i < [llength $arregloCommunityIds]} {incr i} {
		set community_id_actual [lindex $arregloCommunityIds $i]
		set informacionCursoActual [db_list_of_lists obtenerInformacionCursoAsociado {}]
		set resultado "$resultado%[lindex [lindex $informacionCursoActual 0] 0]@[lindex [lindex $informacionCursoActual 0] 1]@[lindex [lindex $informacionCursoActual 0] 2]"
	}
    
    if {$resultado eq ""} {
    	set resultado "@%"
    }	
    return $resultado
}

###############################################################---------abrirCursoEnDI
ad_proc -public gdi::abrirCursoEnDI {
	communityId
} {
Retorna la informacion de los cursos asociados a un DI
Entradas: el id del disenno instruccional en cuestion
Salidas: una lista de listas con el nombre, el periodo y el annio del curso. 
} {
	set escuela [lindex [db_list obtenerNombreEscuela {}] 0]
	set codigoCurso [db_list obtenerCodigoCurso {}]
	
	
	if { $escuela eq "" } {
		set escuela -1
		set codigoCurso -1
	}	
	
	set resultado "$escuela#$codigoCurso"
    return $resultado
}


###############################################################---------eliminarDI
ad_proc -public gdi::eliminarDI {
	idDi
} {
Elimina todos los datos de un DI
Entradas: el id del disenno instruccional en cuestion
} {
    set resultado "ok"
	if {[catch {db_dml eliminarDI {*SQL*}} errmsg]} {
                     ns_log error $errmsg 
                     set resultado -1
                 }

    return $resultado
}

###############################################################---------crear_Portlets_automaticos
ad_proc -public gdi::crear_Portlets_automaticos {
	portal_id
	community_id
	page_id
	titulo
	contenido
	btn2
	col
} {
	Crea un portlet en una pagina especifica. Los parametros de entrada indican:
		portal_id: el portal donde se debe crear la pagina
		community_id: identificador de la comunidad a la que esta asociado el portal
		page_id: id de la pagina donde se creara el portlet
		titulo: titulo que se incluira en el encabezado del portlet (como texto sencillo)
		contenido: Html correspondiente al cuerpo del portlet. Puede ser texto sencillo.
		btn2: href para contruir el boton que se adjuntara al inicio del portlet.
			Para GDI, este parametro recibe informacion en el siguiente formato: '/tda-gdi/ajax/validar_admin?URL=X&portal_id=X', 
			donde : URL es la direccion de retorno,
				portal_id: portal en el que se esta trabajando.
	Este codigo fue hecho para interactuar con la creacion dinamica de elementos desde apc.
} {
	if {[catch { 
	    set titulo [string range $titulo 0 99]
		db_transaction {
			set new_content_id [static_portal_content::new \
				-package_id $community_id \
				-content $contenido \
			    	-pretty_name "$titulo" ]

			set new_element_id [static_portal_content::add_to_portal \
				-portal_id $portal_id \
			    	-package_id $community_id  \
			    	-content_id $new_content_id]
			
			if {$col == 3} {
				portal::move_element_to_page -page_id $page_id -element_id $new_element_id
			} else {
				portal::move_element_to_page -page_id $page_id -element_id $new_element_id -region $col
			}
    	}
    		
		db_transaction {
    			#set boton2 "<div id='boton' style='height: 30px; float:right;padding-bottom:5px;'>\
    			#	    <a style='padding-top:5px;height:77px; position:relative; \
    			#	    display:block; width:100px;\
    			#	    text-align:center;background-color:#FFFFFF;border-radius: 5px; \
    			#	    border: 1px solid #D0D2D3;text-decoration:none;height:2em;' \
    			#	    href='$btn2&content_id=$new_content_id'>Editar</a></div>"
    			set boton2 "<div id='boton' style='height: 30px; float:right;padding-bottom:5px;'>\
    				    <a style='background-color: #FFFFFF; border: 1px solid #D0D2D3; border-radius: 3px; display: block; font-size: 9pt; height: 20px ; padding-top: 3px; position: relative; text-align: center; text-decoration: none; width: 80px;' \
    				    href='$btn2&content_id=$new_content_id'>Editar</a></div>"
			set nuevo_contenido "$boton2$contenido"
			
			
			
			static_portal_content::update \
		        -portal_id $portal_id \
		        -content_id $new_content_id \
		        -pretty_name "$titulo" \
		        -content $nuevo_contenido
    	}

	} errmsg]} {
		ns_log error "*** APC Error en tcl: $errmsg"
	
	}
}
###############################################################---------obtenerSesionesDi
ad_proc -public gdi::obtenerSesionesDi {
	idDi
} {
Retorna la cantidad de sesiones asiciadas a un DI particular
Entradas: el id del disenno instruccional en cuestion
Salidas: la cantidad de sesiones del DI 
} {
	set cantidadSesiones [lindex [db_list obtenerCantidadSesiones {}] 0]
	return $cantidadSesiones
}


###############################################################---------obtenerTituloSesion
ad_proc -public gdi::obtenerTituloSesion {
	idDi
	num_sesion
} {
Retorna el titulo de una sesion
Entradas: el id del disenno instruccional en cuestion, sesion. 
} {
	set tituloSesion [db_list_of_lists obtenerTituloSesion {}]
	return $tituloSesion
}

###############################################################---------obtenerObjetivoAprendizaje
ad_proc -public gdi::obtenerObjetivoAprendizaje {
	idDi
	num_sesion
} {
Retorna el objetivo de una sesion
Entradas: el id del disenno instruccional en cuestion, sesion. 
} {
	set objetivoSesion [db_list_of_lists obtenerObjetivoAprendizaje {}]
	return $objetivoSesion
}

###############################################################---------obtenerModuloContenido
ad_proc -public gdi::obtenerModuloContenido {
	idDi
	num_sesion
} {
Retorna los contenidos de una sesion
Entradas: el id del disenno instruccional en cuestion, sesion. 
} {
	set contenidoSesion [db_list_of_lists obtenerModuloContenido {}]
	return $contenidoSesion
}

###############################################################---------obtenerActividadAprendizaje
ad_proc -public gdi::obtenerActividadAprendizaje {
	idDi
	num_sesion
} {
Retorna las actividades de una sesion
Entradas: el id del disenno instruccional en cuestion, sesion. 
} {
	set actividadSesion [db_list_of_lists obtenerActividadAprendizaje {}]
	return $actividadSesion
}

###############################################################---------obtenerMediosMateriales
ad_proc -public gdi::obtenerMediosMateriales {
	idDi
	num_sesion
} {
Retorna los medios y materiales de una sesion
Entradas: el id del disenno instruccional en cuestion, sesion. 
} {
	set materialesSesion [db_list_of_lists obtenerMediosMateriales {}]
	return $materialesSesion
}

###############################################################---------obtenerEvaluaciones
ad_proc -public gdi::obtenerEvaluaciones {
	idDi
	num_sesion
} {
Retorna los medios y materiales de una sesion
Entradas: el id del disenno instruccional en cuestion, sesion. 
} {
	set evaluacionesSesion [db_list_of_lists obtenerEvaluaciones {}]
	return $evaluacionesSesion
}

###############################################################---------existeDI
ad_proc -public gdi::existeDI {
    idDi
} {
Retorna true si el DI existe o false si no.
Entradas: el id del disenno instruccional. 
} {
    return [db_0or1row obtenerExisteDI {}]
}

###############################################################
# API para integración con otros sistemas
###############################################################


###############################################################---------obtenerDisenosInstruccionales
ad_proc -public gdi_api::obtenerDisenosInstruccionales {
    user_id
} {
Retorna: una lista con el identificador del Diseno Instruccional y el user_id asociado al DI.  
Entradas: user_id 
} {
    #set evaluacionesSesion [db_list_of_lists obtenerEvaluaciones {}]
    set lista_di [gdi::obtenerDIusuario $user_id]
    set resultado ""
    if {[lindex [lindex $lista_di 0] 0] ne "No posee DI"} {
        set nodo ""
        for {set i 0} {$i < [llength $lista_di]} {incr i} {
            set object_id [lindex [lindex $lista_di $i] 1]
            set object_name [lindex [lindex $lista_di $i] 0]
            set resultado [lappend resultado [list $object_id $object_name $user_id]]
        }
    }

    return $resultado
}


###############################################################---------obtenerInfoDisenoInstruccional
ad_proc -public gdi_api::obtenerInfoDisenoInstruccional {
    di_id
} {
Retorna: una lista con el nombre del Diseno Instruccional y el user_id asociado al DI.  
Entradas: id_di (identificador del Diseno Instruccional) 
} {
    set resultado [db_list_of_lists obtenerInfoDisenoInstruccional {}]
    return $resultado
}

###############################################################---------eliminarDisenosInstruccionales
ad_proc -public gdi_api::eliminarDisenoInstruccional {
    di_id
} {
Retorna: un "ok" si se elimina el DI o un -1 si hay algun problema con el proceso.  
Entradas: id_di (identificador del Diseno Instruccional) a eliminar.  
} {
    set resultado [gdi::eliminarDI $di_id]
    return $resultado
}