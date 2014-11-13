<div id="wizard" class="">
    
    <div id="encabezado">
            <div class="anterior"> </div>
            <span id="encabezado_sesion"></span> 
            <span id="encabezado_num_sesion"></span> 
            <span id="encabezado_act_sesion"></span>
            <div class="siguiente"> </div>
    </div> 
    <div id="menu_wizard">
        <div id="menu_nav">
            @ullist;noquote@
        </div>
    </div>
    
    <div id="contenido_wizard">
        <div id="contenedor_agregar">
        	<div id="agregar"> </div>
        	<label id="agregar_texto">#tda-gdi.btnadd#</label>
        </div>
        
        <div id="info">
            informacion
        </div>
        <div id="area_trabajo">
            <!--formtemplate id="area_trabajo_widget"></formtemplate-->
            <div id="observaciones">
                <div>
                    <textarea type="text" id="wizard_observaciones_1" name="txt_observaciones" rows="1" class="wizard_observaciones text_area" placeholder="#tda-gdi.placeholderdesc#" maxlength=1000></textarea>
                </div>
            </div>
            <div class=\"clear\"></div>
            
            
            <div class=\"clear\"></div>
            <div id="estado_seccion">
            	#tda-gdi.txtestadoseccion#
            	<div id="seleccion_estado">
            		<div id="img_completo" class="anterior inline" value="c" > </div> <div id="completo" class="inline inline_text"> #tda-gdi.txtestadoseccionyes# </div>
            		<div id="img_incompleto" class="anterior inline" value="i" > </div> <div id="incompleto" class="inline inline_text"> #tda-gdi.txtestadoseccionno# </div>
            	</div>
            </div>
            <div id="cerrar" class="btn">
            #tda-gdi.btnClose#
            </div>
        </div>
    </div>
        
    
</div>

<div id="arrow"/>
