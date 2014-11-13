ad_page_contract {
 	@param 
} {
    texto
}


set user_id [ad_conn user_id]


set xls [open "/usr/share/dotlrn/packages/dotlrn/www/archivos/$user_id-datos.xls" w]

set texto [string map {ñ &ntilde; ?^? &Ntilde; á &acute; é &eacute; í &iacute; ó &oacute; ú &uacute;  ?^? &Aacute; ?^? &Eacute; ?^? &Iacute; ?^? &Oacute; ?^? &Uacute; . ,} $texto]

#puts $xls "texto"   

close $xls

