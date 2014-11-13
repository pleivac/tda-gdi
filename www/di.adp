
<div id="paso_3">
        <label class="txtPaso"> #tda-gdi.lbstep3#</label>
</div>

<div id="di">
	@tabla;noquote@
    <button type="button" id="boton_anterior" class="btn boton"> #tda-gdi.btnback# </button>
</div>


<div id="div_programa_curso">
    <h2>#tda-gdi.h2courseprogram#</h2>
        <include src="/packages/tds-apc-portlet/www/apc-portlet">
    <div id="clear" class="clear"> </div>
    <button type="button" id="boton_siguiente" class="btn boton"> #tda-gdi.btnnext# </button>
    <div id="clear" class="clear"> </div>
</div>



<div id="div_contexto_di">
    <h2>#tda-gdi.h2idcontext#</h2>
    <div id="tabs">
        @ul_contexto;noquote@
        <div id="contenido">
            @divs_contexto;noquote@
        </div>
    </div>
    <div id="clear" class="clear"></div>
    <button type="button" id="boton_anterior" class="btn boton"> #tda-gdi.btnback# </button>
    <button type="button" id="boton_siguiente" class="btn boton"> #tda-gdi.btnnext# </button>
    <div id="clear" class="clear"></div>
</div>


<div id="div_ayuda_di">
    <h2>#tda-gdi.h2help#</h2>
    <div id="tabs">
        @ul_ayuda;noquote@
        <div id="contenido">
            @divs_ayuda;noquote@
        </div>
    </div>
</div>


<include src="popups/wizard">
<!--include src="popups/compartir"-->
<include src="popups/di__propiedades_documento">
<include src="popups/guardar">
<include src="popups/eliminar">


<div id="DIvistaCompleta" style="display:none;">
   <div name="caption" id="caption" class="caption">
       <spam id="vistaUniversidad">@Universidad@</spam>
       <br>
       @varNombreDI@<spam id="vistaDI"></spam>
       <br>
       @varNombreCurso@<spam id="vistaCurso"></spam>
       <br>
       @varNombreAutor@<spam id="vistaProfesor"></spam>
       <br>
       <br>
   </div>
@tablaVisualizar;noquote@
</div>
<div id="form_propiedades_documento">
        <div id="h2"> #tda-gdi.txtIdProperties# </div> <br>
        <div>
	#tda-gdi.lbIdName#:       <input type="text" id="propiedades_nombre_di" readonly> <br>
	#tda-gdi.lbCourseName#:    <input type="text" id="propiedades_nombre_curso" readonly> <br>
	#tda-gdi.lbslectdepartment#:             <input type="text" id="propiedades_escuela" readonly> <br>
	#tda-gdi.lbUser#:             <input type="text" id="propiedades_nombre_usuario" readonly> <br>
	#tda-gdi.lbCreateDate#:   <input type="text" id="propiedades_fec_creacion" readonly> <br>
	#tda-gdi.lbModifiedDate#: <input type="text" id="propiedades_fec_alteracion" readonly> <br>
	<div id="propiedades_space"> </div>
	#tda-gdi.lbcoursesassociated#: <br>
	<table id="tbl_propiedades_asociar" border="1">
		<tr>
			<th>#tda-gdi.lbCourseName#</th>
			<th>#tda-gdi.lbperiod#</th>
			<th>#tda-gdi.lbyear#</th>
		</tr>
	</table>
	<div id="txt_explicativo_propiedades"> *#tda-gdi.txtexplaination#. </div> <br>
	<button type="button" class="propiedades_btn_cerrar btn"> #tda-gdi.btnClose# </button> <br>
</div>

<div id="form_asociar_di">
    <div id="h2"> #tda-gdi.txtassociatedi# </div> <br>
    <div>
    #tda-gdi.txtassociateexplanation#
    <br>
		<table id="tbl_asociar_di" border="1">
			<tr>
				<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
				<th>#tda-gdi.lbcoursename#</th>
				<th>#tda-gdi.lbperiod#</th>
				<th>#tda-gdi.lbyear#</th>
			</tr>
		</table>
	<div id="asociar_btns">
 		<button type="button" id="btn_cerrar_asociar" class="btn"> #tda-gdi.btncancel# </button> <br>
		<button type="button" id="btn_guardar_asociar" class="btn"> #tda-gdi.btnsave# </button> <br>
	</div>
</div>


<div id="form_clonar_di">
    <div id="h2"> #tda-gdi.txtclonedi# </div> <br>
    <div> #tda-gdi.txtcloneexplanation#
	<br>
		<table id="tbl_clonar_di" border="1">
			<tr>
				<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
				<th>#tda-gdi.lbcoursename#</th>
				<th>#tda-gdi.lbperiod#</th>
				<th>#tda-gdi.lbyear#</th>
			</tr>
		</table>
	<div id="clonar_btns">
		<button type="button" id="btn_cerrar_clonar" class="btn"> #tda-gdi.btncancel# </button> <br>
		<button type="button" id="btn_guardar_clonar" class="btn"> #tda-gdi.btnsave# </button> <br>
	</div>
</div>

<div id="agregar_sesiones_form" class="sesiones_popup">
    <h2> Agregar sesiones </h2> <br>
    <div> Cantidad de sesiones a agregar al DI </div>
	<br><COMMENT>
	<input type="text" id="agregar_sesiones_spinner" /></COMMENT>

	<div class="input-group tds-lib_form_spinner">
    	<input id="agregar_sesiones_spinner" type="text" class="form-control" value="10">
        <div class="input-group-btn-vertical">
        	<button class="tds-lib-icon-display"></button>
            <button class="tds-lib-icon-display"></button>
        </div>
    </div>
	<div>
		<button type="button" class="cancelar btn"> #tda-gdi.btncancel# </button>
		<button type="button" class="agregar btn"> Aceptar </button>
	</div>
</div>

<div id="eliminar_sesiones_form" class="sesiones_popup">
    <h2> Eliminar Sesión </h2> <br>
    <div> Digite o seleccione el número de la sesión que desea eliminar </div>
	<br>
	<div class="input-group tds-lib_form_spinner">
    	<input id="eliminar_sesiones_spinner" type="text" class="form-control" value="10">
        <div class="input-group-btn-vertical">
        	<button class="tds-lib-icon-display"></button>
            <button class="tds-lib-icon-display"></button>
        </div>
    </div>
	<div>
		<button type="button" class="cancelar btn"> #tda-gdi.btncancel# </button>
		<button type="button" class="eliminar btn"> Aceptar </button>
	</div>
</div>

<div id="datos_obtenidos_post" style="display:none">
	<input type="text" id="opcion_param_post" value="@opcion@">
	<input type="text" id="di_param_post" value="@di@">
	<input type="text" id="nombre_curso_param_post" value="@nombre_curso@">
	<input type="text" id="cantidad_sesiones_param_post" value="@cantidad_sesiones@">
	<input type="text" id="curso_param_post" value="@codigo@">
	<input type="text" id="plan_param_post" value="@plan@">
	<input type="text" id="escuela_param_post" value="@escuela@">
</div>



