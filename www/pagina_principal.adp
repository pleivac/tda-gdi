<div id="tabs">

    <!--
     Este input permite el manejo de la internacionalizacion en la logica de lado del cliente. 
     Se destaca, que un valor 0 significa ingles y un valor 1 es utilizao para espannol.   
     -->
     <input id="language" type="text" value="#tda-gdi.lbenglishspanish#" style="display:none">
        
    <div id="paso_1">
        <label class="txtPaso">#tda-gdi.lbstep1#</label>
        <p class="txtDescripcion"> #tda-gdi.txtwelcome1#&nbsp;@profesor@,&nbsp;#tda-gdi.txtwelcome2#</p>
        <formtemplate class="txtLabelBox" id="form_bienvenida"></formtemplate>
    </div>
    
    <div id="paso_2" class="oculto">
        <label class="txtPaso">#tda-gdi.lbstep2#</label>
        <label id="txtTexto" class="txtDescripcion">#tda-gdi.txtwelcome3#</label>
        <div id="opciones" class="opciones">
         <label id="txtNuevo" class="txtTitulosList">#tda-gdi.txtnew#</label>
         <label id="txtAbrir" class="txtTitulosList">#tda-gdi.txtopen#</label>
         <div id="listBoxs" class="txtTitulos">
            <formtemplate id="form_seleccion"></formtemplate>
            <formtemplate id="form_seleccion_buscar_curso"></formtemplate>                   
        </div>
        </div>

        <div id="index_div_nuevo_inexistente" class="popup"> 
        	<p> #tda-gdi.txtpopuptitlenewcourse# </p>
            
            <label for="nombre_curso" class="tds-lib_form">#tda-gdi.lbcoursename#</label>
            <input id="nombre_curso" class="tds-lib_form tds-lib_form_long" type="text">
            <label for="nombre_curso" class="tds-lib_form">#tda-gdi.lbsesionquantity#</label>

            <div class="input-group tds-lib_form_spinner">
                <input id="cantidad_sesiones" type="text" class="form-control" value="10">
                <div class="input-group-btn-vertical">
                    <COMMENT><button class="tds-lib-icon-display"></button>
                    <button class="tds-lib-icon-display"></button></COMMENT>
                    <button class="tds-lib-icon-display"/><button class="tds-lib-icon-display"/>
                </div>
            </div>

        	<div class="btns_popup">
        	    <button type="button" class="boton_cerrar_popup btn">#tda-gdi.btnClose#</button>
        	    <button type="button" id="btn_crear_di_inexistente" class="btn">#tda-gdi.btncreateid#</button> 
        	</div>                     
        </div>

        <div id="index_div_mostrar_existente" class="popup"> 
        	<p> #tda-gdi.txtpopuptitleexistingcourse# </p>
            <label for="nombre_curso" class="tds-lib_form">#tda-gdi.lbcoursename#</label>
            <input id="nombre_curso_label" class="tds-lib_form tds-lib_form_long" type="text">
            <label for="nombre_curso" class="tds-lib_form">#tda-gdi.lbsesionquantity#</label>
            <div class="input-group tds-lib_form_spinner">
                <input id="cantidad_sesiones_asignar" type="text" class="form-control" value="10">
                <div class="input-group-btn-vertical">
                    <COMMENT><button class="tds-lib-icon-display"></button>
                    <button class="tds-lib-icon-display"></button></COMMENT>
                    <button class="tds-lib-icon-display"/><button class="tds-lib-icon-display"/>
                </div>
            </div>
        	
        	<div class="btns_popup">
        	    <button type="button" class="boton_cerrar_popup btn">#tda-gdi.btnClose#</button>
        	    <button type="button" id="btn_crear_di" class="btn"> #tda-gdi.btncreateid# </button> 
        	</div>                        
        </div>
        <div id="contenidoCONF">
    		<table id="info_curso" class="list-table" summary="Data for resultados" cellpadding="3" cellspacing="1">
    		    <thead id="info_curso_header" ><tr class="list-header">
		        <th class="list-table" id="resultados_funcion" align="center">
		            #tda-gdi.hdcodecourse#          
		        </th>
		        <th class="list-table" id="resultados_nombre" align="center">
		            #tda-gdi.lbcoursename#
		        </th>
		        <th class="list-table" id="id_curso" align="center">
		            #tda-gdi.lbslectdepartment#
		        </th>
		        <th class="list-table" style="display: none" id="resultados_grupo" align="center">
		            #tda-gdi.hdteachers#
		        </th>      
		        <th class="list-table" style="display: none" id="resultados_horario" align="center">
		            #tda-gdi.hdschedule#
		        </th>
    			</tr>
            </thead>
    		<tbody  id="info_curso_body">
            </tbody></table>
    		<table id="info_di" class="list-table" summary="Data for resultados" cellpadding="3" cellspacing="1">
    		    <thead id="info_di_header" ><tr class="list-header">
		        <th class="list-table" align="center">
		            #tda-gdi.hdcodecourse#      
		        </th>
		        <th class="list-table" align="center">
		            #tda-gdi.lbcoursename#
		        </th>
		        <th class="list-table" style="display:none" align="center">
		            #tda-gdi.lbslectplan#
		        </th>
		        <th class="list-table" align="center">
		            #tda-gdi.lbCreateDate#
		        </th>      
		        <th class="list-table" align="center">
		            #tda-gdi.lbModifiedDate#
		        </th>
		        <th class="list-table" align="center">
		            #tda-gdi.lbslectdepartment#
		        </th>
		        <th class="list-table" align="center">
		            #tda-gdi.lbmoredetails#
		        </th>
    			</tr>
            </thead>
    		<tbody  id="info_di_body">
            </tbody></table>
        </div>
        <div id="clear" class="clear"></div>
    </div>
</div>


<div id="index_botones1" class="menuBotones">
    <div id="menuDesplazamiento" value="s" class="btnSiguiente btn"></div>
    <!--
    <div id="menuCrearDI_div">
        <div id="menuCrearDI" value="c" class="btnCrearDI oculto btnBoton"></div>
    </div>
    -->
    <div id="menuCrearDI" value="c" class="menuCrearDI_div btnCrearDI oculto btnBoton"></div>
</div>

<div id="form_propiedades_documento">
    <div id="h2"> #tda-gdi.txtIdProperties# </div> <br>
    <div>
        #tda-gdi.lbIdName# :       <input type="text" id="propiedades_nombre_di" readonly> <br>
        #tda-gdi.lbCourseName#: <input type="text" id="propiedades_nombre_curso" readonly> <br>
        #tda-gdi.lbUser#: <input type="text" id="propiedades_nombre_usuario" readonly> <br>
        #tda-gdi.lbCreateDate#:   <input type="text" id="propiedades_fec_creacion" readonly> <br>
        #tda-gdi.lbModifiedDate#: <input type="text" id="propiedades_fec_alteracion" readonly> <br>
        #tda-gdi.lbAssociatedCourses#: <br>
        <div id="propiedades_space"> </div>
        <COMMENT><table id="tbl_propiedades_asociar" border="1">
            <tr>
                <th>#tda-gdi.lbCourseName#</th>
                <th>#tda-gdi.lbperiod#</th>
                <th>#tda-gdi.lbyear#</th>
            </tr>
        </table></COMMENT>
        <button type="button" class="propiedades_btn_cerrar btn"> #tda-gdi.btnClose# </button> <br>
    </div>
</div>