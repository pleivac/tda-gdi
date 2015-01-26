// ---------------------------------------------funciones jquery para todo el sitio --inicio--
/*retorna un arrey con los parámetros ej=  [hola=1 adios=0]*/
function obtener_parametros_url(){
    var url = $(location).attr('href');
    var decodedUrl = decodeURIComponent(url);
    var parametros = ((decodedUrl.split('?'))[1]).split('&');

    return parametros;
}
/*desbloquea una pantalla cuando ha mostrado un mensaje o notificación*/
function desbloquear(){
	$('#bloqueo').hide();
}
/*bloquea una pantalla, y muestra un mensaje de notificación*/
function bloquear(){
	$('#bloqueo').show();
}

/*permite la generación de un cuadro de diálogo*/
function alertDialog(message){
	//alert(message);
	$('body').append('<div id="dialog_popup" class="popup">\
						<p> Mensaje </p> \
						<span>'+message+'</span> \
					  	<div class="btns_popup">\
					  		<button class="tds-lib_form boton_cerrar_popup btn" type="button">Aceptar</button>\
						</div> </div>');
						

    $('#dialog_popup').bPopup({
    	modal: true,
    	modalColor: 'white',
    	closeClass:'boton_cerrar_popup',
    	onOpen: function() {/* se realiza para manejar el error del centrado en index (pagina principal) */ 
		    $('#dialog_popup').bPopup().close();
    	},	
		onClose: function() { $('#dialog_popup').remove(); }
	}, 
		function () {
		    // do something
		});
}

(function($)
{
    /**
* Auto-growing textareas; technique ripped from Facebook
*
* http://github.com/jaz303/jquery-grab-bag/tree/master/javascripts/jquery.autogrow-textarea.js
*/
    $.fn.autogrow = function(options)
    {
        return this.filter('textarea').each(function()
        {
            var self = this;
            var $self = $(self);
            // El valor por omision se modifica por 21 para el caso especifico de los text area
            //var minHeight = $self.height();
            var minHeight = 21;
            
            var noFlickerPad = $self.hasClass('autogrow-short') ? 0 : parseInt($self.css('lineHeight')) || 0;
            
            var shadow = $('<div></div>').css({
                position: 'absolute',
                top: -10000,
                left: -10000,
                width: $self.width(),
                fontSize: $self.css('fontSize'),
                fontFamily: $self.css('fontFamily'),
                fontWeight: $self.css('fontWeight'),
                lineHeight: $self.css('lineHeight'),
                resize: 'none',
     'word-wrap': 'break-word'
            }).appendTo(document.body);

            var update = function(event)
            {
                var times = function(string, number)
                {
                    for (var i=0, r=''; i<number; i++) r += string;
                    return r;
                };

                var val = self.value.replace(/</g, '&lt;')
                                    .replace(/>/g, '&gt;')
                                    .replace(/&/g, '&amp;')
                                    .replace(/\n$/, '<br/>&nbsp;')
                                    .replace(/\n/g, '<br/>')
                                    .replace(/ {2,}/g, function(space){ return times('&nbsp;', space.length - 1) + ' ' });

// Did enter get pressed? Resize in this keydown event so that the flicker doesn't occur.
                if (event && event.data && event.data.event === 'keydown' && event.keyCode === 13) {
                    val += '<br />';
                }

                shadow.css('width', $self.width());
                shadow.html(val + (noFlickerPad === 0 ? '...' : '')); // Append '...' to resize pre-emptively.
                $self.height(Math.max(shadow.height()-15 + noFlickerPad, minHeight));
            }

            $self.change(update).keyup(update).keydown({event:'keydown'},update);
            $(window).resize(update);

            update();
        });
    };
})(jQuery);
// ---------------------------------------------funciones jquery para todo el sitio --fin--








