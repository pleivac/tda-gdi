<?xml version="1.0"?>

<queryset>

 <!-- Esta es la llamada a Base de Datos para determinar el codigo del curso; Editado por Josue Viquez -->

 <fullquery name="apc-portlet::obtenerCodigoCurso.obtenerCodigoCurso">
    <querytext>
	select community_key
	from dotlrn_communities_all
	where community_id = :com_id
    </querytext>
  </fullquery>

 <fullquery name="apc-portlet::obtenerIdProgramaCurso.obtenerIdProgramaCurso">
    <querytext>
	select programa_curso_id
	from sch_apc.td_programa_curso AS pc
	where pc.curso_id = :id_materia
	limit 1;
    </querytext>
  </fullquery>
  
   <fullquery name="apc_portlet::existeProgramaDeCurso.existeProgramaDeCurso">
    <querytext>
	select programa_curso_id
	from sch_apc.td_programa_curso AS pc
	where pc.curso_id = :id_materia
    </querytext>
  </fullquery>
  
  
</queryset>
