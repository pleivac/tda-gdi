ad_page_contract {

   Propósito: Filtrar el tipo de acciones entre GRD y GDI para la gestión de un DI.
   @create_date 16/10/2014
   @author Jose Vega

} {	
{id_di 0}
}

switch $id_di {
 0 {
 	ad_returnredirect "index?opcion=0"
  }
  
  default {
  	ad_returnredirect "design?di=$id_di"
  }
}
