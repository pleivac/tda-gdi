ad_page_contract {
 	@param 
} {
    
}
set elementos [gdi::obtenerAyudaWizard]
set resultado ""


foreach elemento $elementos {
	set resultado "$resultado&$elemento"
}
set resultado [string trim $resultado '&'] 

return "$resultado"
