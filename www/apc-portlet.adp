<a id="ver" name="Ver_APC"></a>
<div id="visualizador" class="ver">
</div>

<!-- put your templating stuff for the user portlet here -->
<div id="principal">
    <if @existe@ eq 1 >

    <!--Se coloca en tabla a solicitud de Don Mario, pues deberían haber solo 2 requisitos y 2 correquisitos para cada curso-->
    <!--Pero por ejemplo TRABAJO FINAL DE GRADUACION de ATI, tiene 22 requisitos actualmente; Mayo 2013-->

    <div id="encabezado">
        <br>@universidad@</br>
        @escuela@
        <br>@curso@</spam>
        <!-- <br>@curso@<spam id="apc_nombre_curso"></spam>-->
    </div>
    <div id="superior">
        <div id="superior_izquierdo">
            <spam class="titulos_superior">Código de curso:</spam>
            @codigo@
            <br>
            <spam class="titulos_superior" >Requisito(s):</spam>
            <label id="requisito">
                @requisito@
            </label>
            <!--<br>-->
            <spam class="titulos_superior" >Correquisito(s):</spam>
            <label id="correquisito">
                @correquisito@
            </label>
        </div>
        <div id="superior_derecho">
            <spam class="titulos_superior">Número de créditos:</spam>
            @creditos@
            <br><spam class="titulos_superior">Num. Hrs./semana:</spam>
            @num_horas_semana@
            <br><spam class="titulos_superior">Num. Hrs.extra clase/semana:</spam>
            @num_horas_extra_semana@
            <br><spam class="titulos_superior">Asistencia:</spam>
            @asistencia@
            <br><spam class="titulos_superior">Suceptible a reconocimiento:</spam>
            @reconocimiento@
            <br><spam class="titulos_superior">Suceptible a suficiencia:</spam>
            @suficiencia@
            <br><spam class="titulos_superior">Tipo de curso:</spam>
            @tipo@
        </div>
    </div>

    <div id="inferior">
        <hr >
        <div id="inferior_izquierdo">
            <h4>Descripción del curso:</h4>
            @descripcion@
            <h4>Objetivos generales:</h4>
            <div id="objetivos_generales">
                @objetivos_generales@
            </div>
            <h4>Objetivos específicos:</h4>
            <div id="objetivos_especificos">
                @objetivos_especificos@
            </div>
            <h4>Contenidos:</h4>
            <div id="contenidos">
                @contenidos@
            </div>
        </div>
        <div id="inferior_derecho">
            <h4>Metodología:</h4>
            @metodologia@
            <h4>Criterios de evaluación:</h4>
            <div id="evaluacion">
                @evaluacion@
            </div>
            <h4>Bibliografía del curso:</h4>
            <div id="bibliografia">
                @bibliografia@
            </div>
            <h4>Consideraciones generales:</h4>
            @consideraciones@
        </div>
    </div>
    
    </if>
    <if @existe@ eq 0>
        <p>@resultado@</p>
        <input type="hidden" id="variableExiste"  value="@existe@" />
    </if> 

</div>

