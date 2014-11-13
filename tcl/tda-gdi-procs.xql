<?xml version="1.0"?>

<queryset>

  <fullquery name="gdi::obtenerUsuario.obtenerNombre">
    <querytext>
	select first_names,last_name
        from persons
        where person_id = :user_id;
    </querytext>
  </fullquery>

  <fullquery name="gdi::obtenerUsuario.obtenerNombreExistente">
    <querytext>
	select nom_usuario
        from sch_gdi.td_di_usuarios
        where usuario_id = :user_id;
    </querytext>
  </fullquery>

  <fullquery name="gdi::existeUsuario.obtenerExisteUsuario">
    <querytext>
	    select nom_usuario
        from sch_gdi.td_di_usuarios
        where usuario_id = :user_id;
    </querytext>
  </fullquery>

  <fullquery name="gdi::agregarUsuario.agregarUsuario">
    <querytext>
	    insert into sch_gdi.td_di_usuarios (usuario_id, nom_usuario) 
	    values (:user_id, :nom_usuario);
    </querytext>
  </fullquery>

  <fullquery name="gdi::agregarUsuario.actualizarUsuario">
    <querytext>
	        update sch_gdi.td_di_usuarios
            set nom_usuario = :nom_usuario
            where usuario_id = :user_id;
    </querytext>
  </fullquery>

  <fullquery name="gdi::obtenerCursos.ObtenerCursosUsuario">
    <querytext>
	    select pretty_name, object_id_one
        from acs_rels 
        join dotlrn_communities_all on object_id_one = community_id 
        where rel_type = 'dotlrn_instructor_rel'
        and object_id_two = :user_id;
    </querytext>
  </fullquery>

  <fullquery name="gdi::obtenerCursos.ObtenerCedulaUsuario">
    <querytext>
	select ide_profesor
        from td_sch_admision.td_profesores  
        where user_id = :user_id;
    </querytext>
  </fullquery>

  <fullquery name="gdi::obtenerInformacionCurso.obtenerCodigo">
    <querytext>
	    select community_type
        from dotlrn_communities_all
        where community_id = :community_id;
    </querytext>
  </fullquery>

  <fullquery name="gdi::obtenerInformacionCurso.obtenerNombreCurso">
    <querytext>
	select nombre_curso
	from sch_gdi.td_disenno_instruccional
	where disenno_instruccional_id = :codDi;
    </querytext>
  </fullquery>

  <fullquery name="gdi::obtenerInformacionCurso.obtenerProfesores">
    <querytext>
	    select persons.first_names, persons.last_name
        from acs_rels
        join persons on person_id = object_id_two
        where object_id_one = :community_id and
        rel_type = 'dotlrn_instructor_rel';
    </querytext>
  </fullquery>

  <fullquery name="gdi::obtenerInformacionCurso.NombreCarrera">
    <querytext>
	    select pretty_name
        from dotlrn_communities_all
        where community_key = :codigoCarrera;
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::salvarDI.crearDI">
    <querytext>
	    insert into sch_gdi.td_disenno_instruccional 
	    (disenno_instruccional_id, programa_estudio_id, fec_creacion, fec_ultima_modificacion, cod_curso, sesiones, nombre_curso, nombre_escuela) 
	    values (DEFAULT, :programaCurso, now(), now(), :cod_curso, :sesiones, :nombre_curso, :escuela)
        returning disenno_instruccional_id;
    </querytext>
  </fullquery>

  <fullquery name="gdi::salvarDI.actualizarSesionesDI">
    <querytext>
      update sch_gdi.td_disenno_instruccional 
      set sesiones = :sesiones
      where disenno_instruccional_id = :idDI;
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::salvarDI.asociarDI">
    <querytext>
	    insert into sch_gdi.td_disenno_instruccional_x_usuario
	    (disenno_instruccional_id, usuario_id, nom_di) 
	    values (:idDI, :usuario_id, :nombreDI);
    </querytext>
  </fullquery>

  <fullquery name="gdi::cargarDI.obtenerTitulo">
    <querytext>
        select nom_titulo
        from sch_gdi.td_di_titulo
        where disenno_instruccional_id = :idDI
        and num_sesion = :sesion
        order by titulo_id asc;
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::cargarDI.obtenerObjetivoAprendizaje">
    <querytext>
        select nom_objetivo_aprendizaje
        from sch_gdi.td_di_objetivos_aprendizaje
        where disenno_instruccional_id = :idDI
        and num_sesion = :sesion
        order by objetivos_aprendizaje_id asc;
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::cargarDI.obtenerModuloContenido">
    <querytext>
        select nom_modulo_contenido
        from sch_gdi.td_di_modulos_contenidos
        where disenno_instruccional_id = :idDI
        and num_sesion = :sesion
        order by modulos_contenidos_id asc;
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::cargarDI.obtenerActividadAprendizaje">
    <querytext>
        select nom_actividad_aprendizaje
        from sch_gdi.td_di_actividades_aprendizaje
        where disenno_instruccional_id = :idDI
        and num_sesion = :sesion
        order by actividades_aprendizaje_id asc;
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::cargarDI.obtenerMedioMaterial">
    <querytext>
        select nom_medio_material
        from sch_gdi.td_di_medios_materiales
        where disenno_instruccional_id = :idDI
        and num_sesion = :sesion
        order by medios_materiales_id asc;
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::cargarDI.obtenerEvaluacion">
    <querytext>
        select nom_evaluacion
        from sch_gdi.td_di_evaluacion
        where disenno_instruccional_id = :idDI
        and num_sesion = :sesion
        order by evaluacion_id asc;
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::guardarDI.insertarTitulo">
    <querytext>
	    insert into sch_gdi.td_di_titulo
	    (disenno_instruccional_id, nom_titulo, num_sesion, estado) 
	    values (:idDI, :elemento, :numSesion, :estado);
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::guardarDI.insertarObjetivoAprendizaje">
    <querytext>
	    insert into sch_gdi.td_di_objetivos_aprendizaje
	    (disenno_instruccional_id, nom_objetivo_aprendizaje, num_sesion, estado) 
	    values (:idDI, :elemento, :numSesion, :estado);
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::guardarDI.insertarModuloContenido">
    <querytext>
	    insert into sch_gdi.td_di_modulos_contenidos
	    (disenno_instruccional_id, nom_modulo_contenido, num_sesion, estado) 
	    values (:idDI, :elemento, :numSesion, :estado);
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::guardarDI.insertarActividadAprendizaje">
    <querytext>
	    insert into sch_gdi.td_di_actividades_aprendizaje
	    (disenno_instruccional_id, nom_actividad_aprendizaje, num_sesion, estado) 
	    values (:idDI, :elemento, :numSesion, :estado);
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::guardarDI.insertarMedioMaterial">
    <querytext>
	    insert into sch_gdi.td_di_medios_materiales
	    (disenno_instruccional_id, nom_medio_material, num_sesion, estado) 
	    values (:idDI, :elemento, :numSesion, :estado);
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::guardarDI.insertarEvaluacion">
    <querytext>
	    insert into sch_gdi.td_di_evaluacion
	    (disenno_instruccional_id, nom_evaluacion, num_sesion, estado) 
	    values (:idDI, :elemento, :numSesion, :estado);
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::guardarDI.actualizarTitulo">
    <querytext>
        update sch_gdi.td_di_titulo
        set nom_titulo = :elemento, estado = :estado
        where titulo_id in
            (select titulo_id
            from sch_gdi.td_di_titulo
            where disenno_instruccional_id = :idDI
            and num_sesion = :numSesion
            order by titulo_id asc
            limit 1
            offset :posicion);
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::guardarDI.actualizarObjetivoAprendizaje">
    <querytext>
        update sch_gdi.td_di_objetivos_aprendizaje
        set nom_objetivo_aprendizaje = :elemento, estado = :estado
        where objetivos_aprendizaje_id in
            (select objetivos_aprendizaje_id
            from sch_gdi.td_di_objetivos_aprendizaje
            where disenno_instruccional_id = :idDI
            and num_sesion = :numSesion
            order by objetivos_aprendizaje_id asc
            limit 1
            offset :posicion);
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::guardarDI.actualizarModuloContenido">
    <querytext>
        update sch_gdi.td_di_modulos_contenidos
        set nom_modulo_contenido = :elemento, estado = :estado
        where modulos_contenidos_id in
            (select modulos_contenidos_id
            from sch_gdi.td_di_modulos_contenidos
            where disenno_instruccional_id = :idDI
            and num_sesion = :numSesion
            order by modulos_contenidos_id asc
            limit 1
            offset :posicion);
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::guardarDI.actualizarActividadAprendizaje">
    <querytext>
        update sch_gdi.td_di_actividades_aprendizaje
        set nom_actividad_aprendizaje = :elemento, estado = :estado
        where actividades_aprendizaje_id in
            (select actividades_aprendizaje_id
            from sch_gdi.td_di_actividades_aprendizaje
            where disenno_instruccional_id = :idDI
            and num_sesion = :numSesion
            order by actividades_aprendizaje_id asc
            limit 1
            offset :posicion);
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::guardarDI.actualizarMedioMaterial">
    <querytext>
        update sch_gdi.td_di_medios_materiales
        set nom_medio_material = :elemento, estado = :estado
        where medios_materiales_id in
            (select medios_materiales_id
            from sch_gdi.td_di_medios_materiales
            where disenno_instruccional_id = :idDI
            and num_sesion = :numSesion
            order by medios_materiales_id asc
            limit 1
            offset :posicion);
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::guardarDI.actualizarEvaluacion">
    <querytext>
        update sch_gdi.td_di_evaluacion
        set nom_evaluacion = :elemento, estado = :estado
        where evaluacion_id in
            (select evaluacion_id
            from sch_gdi.td_di_evaluacion
            where disenno_instruccional_id = :idDI
            and num_sesion = :numSesion
            order by evaluacion_id asc
            limit 1
            offset :posicion);
    </querytext>
  </fullquery>
  <fullquery name="gdi::guardarDI.eliminarTitulo">
    <querytext>
        delete
        from sch_gdi.td_di_titulo
        where titulo_id in
            (select titulo_id
            from sch_gdi.td_di_titulo
            where disenno_instruccional_id = :idDI
            and num_sesion = :numSesion
            order by titulo_id asc
            limit 1
            offset :posicionBorrado);
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::guardarDI.eliminarObjetivoAprendizaje">
    <querytext>
        delete
        from sch_gdi.td_di_objetivos_aprendizaje
        where objetivos_aprendizaje_id in
            (select objetivos_aprendizaje_id
            from sch_gdi.td_di_objetivos_aprendizaje
            where disenno_instruccional_id = :idDI
            and num_sesion = :numSesion
            order by objetivos_aprendizaje_id asc
            limit 1
            offset :posicionBorrado);
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::guardarDI.eliminarModuloContenido">
    <querytext>
        delete
        from sch_gdi.td_di_modulos_contenidos
        where modulos_contenidos_id in
            (select modulos_contenidos_id
            from sch_gdi.td_di_modulos_contenidos
            where disenno_instruccional_id = :idDI
            and num_sesion = :numSesion
            order by modulos_contenidos_id asc
            limit 1
            offset :posicionBorrado);
    </querytext>
  </fullquery>

  <fullquery name="gdi::guardarDI.eliminarActiviadAprendizaje">
    <querytext>
        delete
        from sch_gdi.td_di_actividades_aprendizaje
        where actividades_aprendizaje_id in
            (select actividades_aprendizaje_id
            from sch_gdi.td_di_actividades_aprendizaje
            where disenno_instruccional_id = :idDI
            and num_sesion = :numSesion
            order by actividades_aprendizaje_id asc
            limit 1
            offset :posicionBorrado);
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::guardarDI.eliminarMedioMaterial">
    <querytext>
        delete
        from sch_gdi.td_di_medios_materiales
        where medios_materiales_id in
            (select medios_materiales_id
            from sch_gdi.td_di_medios_materiales
            where disenno_instruccional_id = :idDI
            and num_sesion = :numSesion
            order by medios_materiales_id asc
            limit 1
            offset :posicionBorrado);
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::guardarDI.eliminarEvaluacion">
    <querytext>
        delete
        from sch_gdi.td_di_evaluacion
        where evaluacion_id in
            (select evaluacion_id
            from sch_gdi.td_di_evaluacion
            where disenno_instruccional_id = :idDI
            and num_sesion = :numSesion
            order by evaluacion_id asc
            limit 1
            offset :posicionBorrado);
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::obtenerDIusuario.obtenerDIusuario">
    <querytext>
	    select nom_di, disenno_instruccional_id
	    from sch_gdi.td_disenno_instruccional_x_usuario
	    where usuario_id = :usuario_id;
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::obtenerInformacionDI.obtenerInfoDI">
    <querytext>
	    select programa_estudio_id, cod_curso, fec_creacion, fec_ultima_modificacion, nombre_curso, nombre_escuela
        from sch_gdi.td_disenno_instruccional
        where disenno_instruccional_id = :datosDI;
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::salvarDI.obtenerDIxNombre">
    <querytext>
        select di.disenno_instruccional_id
        from sch_gdi.td_disenno_instruccional as di
        join sch_gdi.td_disenno_instruccional_x_usuario as diu
        on di.disenno_instruccional_id = diu.disenno_instruccional_id
        where di.cod_curso = :cod_curso
        and diu.usuario_id = :usuario_id
        and diu.nom_di = :nombreDI;
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::guardarDI.cantidadActualElementos">
    <querytext>
        Select
            case :numComponente 
              WHEN '0' THEN (select count(*)
	            from sch_gdi.td_di_titulo
	            where num_sesion = :numSesion
	            and disenno_instruccional_id = :idDI)
              WHEN '1' THEN (select count(*)
	            from sch_gdi.td_di_objetivos_aprendizaje
	            where num_sesion = :numSesion
	            and disenno_instruccional_id = :idDI)
              WHEN '2' THEN (select count(*)
	            from sch_gdi.td_di_modulos_contenidos
	            where num_sesion = :numSesion
	            and disenno_instruccional_id = :idDI)
              WHEN '3' THEN (select count(*)
	            from sch_gdi.td_di_actividades_aprendizaje
	            where num_sesion = :numSesion
	            and disenno_instruccional_id = :idDI)
              WHEN '4' THEN (select count(*)
	            from sch_gdi.td_di_medios_materiales
	            where num_sesion = :numSesion
	            and disenno_instruccional_id = :idDI)
              WHEN '5' THEN (select count(*)
	            from sch_gdi.td_di_evaluacion
                where num_sesion = :numSesion
	            and disenno_instruccional_id = :idDI)
        end;
    </querytext>
  </fullquery>  


  
  <fullquery name="gdi::salvarDI.borrarTodoDependendencias">
    <querytext>
        delete
        from sch_gdi.td_di_actividades_aprendizaje
        where disenno_instruccional_id = :idDI;

        delete
        from sch_gdi.td_di_cursos_asociados
        where disenno_instruccional_id = :idDI;

        delete
        from sch_gdi.td_di_evaluacion
        where disenno_instruccional_id = :idDI;

        delete
        from sch_gdi.td_di_medios_materiales
        where disenno_instruccional_id = :idDI;

        delete
        from sch_gdi.td_di_objetivos_aprendizaje
        where disenno_instruccional_id = :idDI;

        delete
        from sch_gdi.td_di_titulo
        where disenno_instruccional_id = :idDI;
    </querytext>
  </fullquery>  
  
  <fullquery name="gdi::cargarEstados.obtenerEstado">
    <querytext>
          Select
            case :componente 
              WHEN '0' THEN (select estado
	            from sch_gdi.td_di_titulo
	            where num_sesion = :sesion
	            and disenno_instruccional_id = :idDI
	            limit 1)
              WHEN '1' THEN (select estado
	            from sch_gdi.td_di_objetivos_aprendizaje
	            where num_sesion = :sesion
	            and disenno_instruccional_id = :idDI
	            limit 1)
              WHEN '2' THEN (select estado
	            from sch_gdi.td_di_modulos_contenidos
	            where num_sesion = :sesion
	            and disenno_instruccional_id = :idDI
	            limit 1)
              WHEN '3' THEN (select estado
	            from sch_gdi.td_di_actividades_aprendizaje
	            where num_sesion = :sesion
	            and disenno_instruccional_id = :idDI
	            limit 1)
              WHEN '4' THEN (select estado
	            from sch_gdi.td_di_medios_materiales
	            where num_sesion = :sesion
	            and disenno_instruccional_id = :idDI
	            limit 1)
              WHEN '5' THEN (select estado
	            from sch_gdi.td_di_evaluacion
                    where num_sesion = :sesion
	            and disenno_instruccional_id = :idDI
	            limit 1)
        end;
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::obtenerNombreDI.obtenerNombreDI">
    <querytext>
        select nom_di
        from sch_gdi.td_disenno_instruccional_x_usuario
        where disenno_instruccional_id = :di
        and usuario_id = :usuario_id;
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::obtenerSesionesDI.obtenerSesionesDI">
    <querytext>
        select sesiones
	from sch_gdi.td_disenno_instruccional
	inner join sch_gdi.td_disenno_instruccional_x_usuario
	on sch_gdi.td_disenno_instruccional.disenno_instruccional_id=sch_gdi.td_disenno_instruccional_x_usuario.disenno_instruccional_id
	where sch_gdi.td_disenno_instruccional.disenno_instruccional_id=:di
	and sch_gdi.td_disenno_instruccional_x_usuario.usuario_id=:usuario_id;
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::salvarDI.actualizarFecha">
    <querytext>
        update sch_gdi.td_disenno_instruccional
        set fec_ultima_modificacion = now()
        where disenno_instruccional_id = :idDI;
    </querytext>
  </fullquery>

 <fullquery name="gdi::obtenerAyudaWizard.obtenerAyudaWizard">
    <querytext>
	select nom_material_apoyo
	from sch_gdi.td_material_apoyo
	where tipo_material_apoyo_id = 1
	order by material_apoyo_id;
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::obtenerNombreCurso.obtenerNombreCurso">
   <querytext>
        select nombre_curso
	from sch_gdi.td_disenno_instruccional
	where disenno_instruccional_id = :codDi;
   </querytext>
 </fullquery>

  <fullquery name="gdi::obtenerPreguntasContexto.obtenerPreguntasContexto">
   <querytext>
       select pregunta_id, desc_pregunta, ayuda_pregunta
       from sch_gdi.td_di_preguntas_contexto
       where pregunta_habilitada = 'true';
   </querytext>
 </fullquery>
 
 <fullquery name="gdi::insertarRespuestaContextoDI.insertarRespuestaContextoDI">
    <querytext>
       insert into sch_gdi.td_di_respuestas_contexto
       	(desc_respuesta, pregunta_id, disenno_instruccional_id, estado_respuesta)
       values
        (:desc_respuesta, :pregunta_id, :disenno_instruccional_id, :estado_respuesta)
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::insertarRespuestaContextoDI.obtenerExisteRespuesta">
    <querytext>
        select pregunta_id, disenno_instruccional_id
        from sch_gdi.td_di_respuestas_contexto
        where pregunta_id = :pregunta_id
        and disenno_instruccional_id = :disenno_instruccional_id;
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::insertarRespuestaContextoDI.actualizarRespuesta">
    <querytext>
    	update sch_gdi.td_di_respuestas_contexto
        set desc_respuesta = :desc_respuesta, estado_respuesta = :estado_respuesta
        where pregunta_id = :pregunta_id
        and disenno_instruccional_id = :disenno_instruccional_id;
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::insertarRespuestaContextoDI.borrarRespuestaContexto">
    <querytext>
    	delete 
		from sch_gdi.td_di_respuestas_contexto
		where pregunta_id = :pregunta_id
		and disenno_instruccional_id = :disenno_instruccional_id;
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::obtenerRespuestaContexto.obtenerRespuestaContexto">
    <querytext>
    	select desc_respuesta, estado_respuesta
		from sch_gdi.td_di_respuestas_contexto
		where pregunta_id = :idPregunta
		and disenno_instruccional_id = :di;
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::obtenerAyuda.obtenerAyuda">
    <querytext>
    	select titulo_material_apoyo, nom_material_apoyo
  	  	from sch_gdi.td_material_apoyo
  	  	where tipo_material_apoyo_id = 2
  	  	order by orden_presentacion;  
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::obtenerCursos.tieneCursos">
    <querytext>
    	select distinct(ty.community_type), ty.pretty_name
	  	from dotlrn_member_rels_approved as re
	  	join dotlrn_communities_all co on re.community_id = co.community_id
	  	join dotlrn_community_types ty on ty.community_type = co.community_type
	  	where user_id = :user_id and 
          	re.rel_type not in ('dotlrn_member_rel','dotlrn_student_rel') and
          	ty.community_type not in ('dotlrn_club', 'dotlrn_class_instance', 'dotlrn_community')
        LIMIT 1;
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::obtenerCursos.obtenerExisteCursos">
    <querytext>
  select distinct(ty.community_type), ty.pretty_name, co.pretty_name, co.community_key
  from dotlrn_member_rels_approved as re
  join dotlrn_communities_all co on re.community_id = co.community_id
  join dotlrn_community_types ty on ty.community_type = co.community_type
  where user_id = :user_id and 
  ( co.community_key like :nodoBusquedaAnual || '.%'  or 
   co.community_key like :nodoBusquedaBimestre || '.%' or
     co.community_key like :nodoBusquedaCuatrimestre || '.%' or
     co.community_key like :nodoBusquedaCentrosDeFormacion || '.%' or
     co.community_key like :nodoBusquedaIntensivo || '.%' or
     co.community_key like :nodoBusquedaMensual || '.%' or
       co.community_key like :nodoBusquedaSemestre || '.%' or
     co.community_key like :nodoBusquedaTrimestre || '.%' or 
     co.community_key like :nodoBusquedaVerano || '.%' or 
     co.community_key not like 'A-%' or 
   co.community_key not like 'B-%' or 
   co.community_key not like 'C-%' or 
   co.community_key not like 'H-%' or 
     co.community_key not like 'I-%' or
     co.community_key not like 'M-%' or
     co.community_key not like 'S-%' or
     co.community_key not like 'T-%' or
     co.community_key not like 'V-%'
   ) 
  and re.rel_type not in ('dotlrn_member_rel','dotlrn_student_rel') and
  ty.community_type not in ('dotlrn_club', 'dotlrn_class_instance', 'dotlrn_community')
      group by ty.community_type, ty.pretty_name, co.pretty_name, co.community_key;
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::obtenerInformacionCurso.obtenerInformacionCursoPlataforma">
    <querytext>
		select ty.pretty_name
		from dotlrn_member_rels_approved as re
		join dotlrn_communities_all co on re.community_id = co.community_id
		join dotlrn_community_types ty on ty.community_type = co.community_type
		where user_id =  :user_id and
			ty.community_type = :datosCurso;
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::obtenerCursosUsuario.obtenerCursosUsuario">
    <querytext>
		select  distinct(co.pretty_name), co.community_id, te.term_name, te.term_year, re.rel_type
		from dotlrn_member_rels_approved as re
		join dotlrn_communities_all co on re.community_id = co.community_id
		join dotlrn_community_types ty on ty.community_type = co.community_type
		left outer join dotlrn_terms te on co.active_end_date = te.end_date and co.active_start_date = te.start_date
		where user_id = :usuario_id and 
			re.rel_type not in ('dotlrn_member_rel','dotlrn_student_rel') and
			ty.community_type not in ('dotlrn_club', 'dotlrn_class_instance', 'dotlrn_community');
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::borrarCursosAsociados.borrarCursosAsociados">
    <querytext>
		delete
		from sch_gdi.td_di_cursos_asociados
		where disenno_instruccional_id = :disenno_instruccional_id;
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::insertarCursoAsociado.insertarCursoAsociado">
    <querytext>
		insert into sch_gdi.td_di_cursos_asociados
			(community_id, disenno_instruccional_id)
		values (:community_id, :disenno_instruccional_id)
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::obtenerCursosAsociados.obtenerCursosAsociados">
    <querytext>
		select community_id 
		from sch_gdi.td_di_cursos_asociados
		where disenno_instruccional_id = :disenno_instruccional_id;
    </querytext>
  </fullquery>

  <fullquery name="gdi::obtenerInformacionCursosAsociados.obtenerInformacionCursoAsociado">
    <querytext>
		select distinct(co.pretty_name), te.term_name, te.term_year
		from dotlrn_member_rels_approved as re
		join dotlrn_communities_all co on re.community_id = co.community_id
		join dotlrn_community_types ty on ty.community_type = co.community_type
		left outer join dotlrn_terms te on co.active_end_date = te.end_date and co.active_start_date = te.start_date
		where co.community_id = :community_id_actual and
			re.rel_type not in ('dotlrn_member_rel','dotlrn_student_rel') and
			ty.community_type not in ('dotlrn_club', 'dotlrn_class_instance', 'dotlrn_community');
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::abrirCursoEnDI.obtenerNombreEscuela">
    <querytext>
		select pretty_name
        from dotlrn_community_types as dct, 
            (select distinct(substring( ty.community_type from 1 for 3)) as escuela
                from dotlrn_member_rels_approved as re
                join dotlrn_communities_all co on re.community_id = co.community_id
                join dotlrn_community_types ty on ty.community_type = co.community_type
                where co.community_id = :communityId
            ) as tct
        where (dct.community_type = tct.escuela 
            or dct.community_type = substring( tct.escuela from 1 for 1)
            or dct.community_type = substring( tct.escuela from 1 for 2))
              and supertype = 'dotlrn_class_instance';
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::abrirCursoEnDI.obtenerCodigoCurso">
    <querytext>
		select distinct(split_part(ty.community_type, '.', 2))
		from dotlrn_member_rels_approved as re
		join dotlrn_communities_all co on re.community_id = co.community_id
		join dotlrn_community_types ty on ty.community_type = co.community_type
			where co.community_id = :communityId;
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::eliminarDI.eliminarDI">
    <querytext>
        delete
        from sch_gdi.td_disenno_instruccional_x_usuario
        where disenno_instruccional_id = :idDi; 

        delete
        from sch_gdi.td_di_titulo
        where disenno_instruccional_id = :idDi;

        delete
        from sch_gdi.td_di_respuestas_contexto
        where disenno_instruccional_id = :idDi;

        delete
        from sch_gdi.td_di_objetivos_aprendizaje
        where disenno_instruccional_id = :idDi;

        delete
        from sch_gdi.td_di_modulos_contenidos
        where disenno_instruccional_id = :idDi;

        delete
        from sch_gdi.td_di_medios_materiales
        where disenno_instruccional_id = :idDi;

        delete
        from sch_gdi.td_di_evaluacion
        where disenno_instruccional_id = :idDi;

        delete
        from sch_gdi.td_di_cursos_asociados
        where disenno_instruccional_id = :idDi;

        delete
        from sch_gdi.td_di_actividades_aprendizaje
        where disenno_instruccional_id = :idDi;
        
        delete
        from sch_gdi.td_disenno_instruccional
        where disenno_instruccional_id = :idDi;
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::obtenerSesionesDi.obtenerCantidadSesiones">
    <querytext>
  		select di.sesiones
  		from  sch_gdi.td_disenno_instruccional as di
  		where di.disenno_instruccional_id = :idDi
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::obtenerTituloSesion.obtenerTituloSesion">
    <querytext>
  		select nom_titulo
  		from sch_gdi.td_di_titulo
  		where disenno_instruccional_id = :idDi
  		and num_sesion = :num_sesion
      order by titulo_id asc;
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::obtenerObjetivoAprendizaje.obtenerObjetivoAprendizaje">
    <querytext>
  		select nom_objetivo_aprendizaje
  		from sch_gdi.td_di_objetivos_aprendizaje
  		where disenno_instruccional_id = :idDi 
  		and num_sesion = :num_sesion
      order by objetivos_aprendizaje_id asc;
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::obtenerModuloContenido.obtenerModuloContenido">
    <querytext>
  		select nom_modulo_contenido
  		from sch_gdi.td_di_modulos_contenidos
  		where disenno_instruccional_id = :idDi 
  		and num_sesion = :num_sesion
      order by modulos_contenidos_id asc;
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::obtenerActividadAprendizaje.obtenerActividadAprendizaje">
    <querytext>
		select nom_actividad_aprendizaje
		from sch_gdi.td_di_actividades_aprendizaje
		where disenno_instruccional_id = :idDi 
		and num_sesion = :num_sesion
    order by actividades_aprendizaje_id asc;
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::obtenerMediosMateriales.obtenerMediosMateriales">
    <querytext>
  		select nom_medio_material 
  		from sch_gdi.td_di_medios_materiales
  		where disenno_instruccional_id = :idDi 
  		and num_sesion = :num_sesion
      order by medios_materiales_id asc;
    </querytext>
  </fullquery>
  
  <fullquery name="gdi::obtenerEvaluaciones.obtenerEvaluaciones">
    <querytext>
  		select nom_evaluacion
  		from sch_gdi.td_di_evaluacion
  		where disenno_instruccional_id = :idDi 
  		and num_sesion = :num_sesion
      order by evaluacion_id asc;
    </querytext>
  </fullquery>

  <fullquery name="gdi_api::obtenerInfoDisenoInstruccional.obtenerInfoDisenoInstruccional">
    <querytext>
      select nom_di, usuario_id
      from sch_gdi.td_disenno_instruccional_x_usuario
      where disenno_instruccional_id = :di_id;
    </querytext>
  </fullquery>

  <fullquery name="gdi::existeDI.obtenerExisteDI">
    <querytext>
      select *
      from sch_gdi.td_disenno_instruccional
      where disenno_instruccional_id = :idDi;
    </querytext>
  </fullquery>

</queryset>
