<master>
<comment># Agregado para Ratings Paquetes #</comment>
<div class='tda-ratings-paquetes' package_key='<%= [ad_conn package_key] %>' subsector_visitado='#tda-ratings-paquetes.pagina_principal# <%= [ad_conn  instance_name]%>' instance_name='#tda-ratings-paquetes.carga_inicial#'></div>
<div class="yui-skin-sam">
    <div id="marco" class="marco">
	
	
	    <div id="bloqueo">
	    </div>


        <div id="menu">
           <ul class="menu">
              
			<li class="menu_opcion menuPrincipal txtBoton oculto" style="display:none"> <span class=" "> <div id="menuMenu" class="btnMenu"></div><label class="txtLabel">Menú</label> </span> <span id="puntoMenu"> </span> @menu;noquote@ </li>
			 
			<li class="menuPrincipal txtBoton oculto"> <div id="menuNuevo" class="btnNuevo"></div><label class="txtLabel">#tda-gdi.lbnew#</label><span id="puntoNuevo"> </span> </li>
			 
			<li class="menuPrincipal txtBoton oculto"> <div id="menuAbrir" class="btnAbrir"></div><label class="txtLabel">#tda-gdi.lbopen#</label> <span id="puntoAbrir"> </span> </li>
			
			<li class="menuPrincipal txtBoton oculto"> <div id="menuAyuda" class="btnAyuda"></div><label class="txtLabel">Ayuda</label> <span id="puntoAyuda"> </span> </li>
				
		</ul>
  		</div>
		
	</ul> 
      </div>
		
 	
        <div id="contenedor">
            <include src="pagina_principal">
        </div>
            
            
    </div>
</div>
