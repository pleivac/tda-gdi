ad_page_contract {
    @param
} {
        texto
} 



set user_id [ad_conn user_id]

#set xls [open "/var/lib/aolserver4/dotlrn/packages/dotlrn/www/archivos/$user_id-texto.xls" w]

#Modificacion hecha por Mauricio Ramirez 21/02/2012
#Adaptacion a la plataforma de dotlrn 2.5
set xls [open "/home/tec-digital/$user_id.txt" w]

set texto [string map {ñ &ntilde; ?^? &Ntilde; á &acute; é &eacute; í &iacute; ó &oacute; ú &uacute;  ?^? &Aacute; ?^? &Eacute; ?^? &Iacute; ?^? &Oacute; ?^? &Uacute; . ,} $texto]

#puts $xls "hola mundo"   

close $xls


