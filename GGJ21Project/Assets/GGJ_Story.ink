VAR dias_duracion_historia = 20
VAR max_preguntas_dia = 6

VAR dias_transcurridos = 0
VAR preguntas_realizadas = 0

VAR cambio_personaje = true
VAR novia = false

-> agenda

== agenda ==

+ [Patrick] -> patrick
+ [Jennifer] -> jennifer
+ [Josh] -> josh



== patrick ==
~ cambio_personaje = false

- Quién iba a decir que iba a aparecer...
-> interrogatorio

= interrogatorio
{ 
    - preguntas_realizadas < max_preguntas_dia:
        * [No se le ve muy afectado, la verdad.] -> afectado
        * [¿Problemas en la relación quizás?] -> relacion
        * [¿Mantendrán el contacto?] -> ultima_vez
        * {relacion} [¿Cómo de intensa sería su relación?] -> relacion_intensa
        * {josh.sueldo} [¿Diría Josh la verdad respecto al sueldo de Marie?] -> sueldo
        * {sueldo and jennifer.sueldo and (not jennifer.infidelidad)} [¿Por qué no coinciden las opiniones de Jennifer y Patrick?] -> opiniones_sueldo
        // TODO + {relacion} [Es momento de sacar el tema del embarazo] -> embarazo
        + [No tengo nada más que preguntarle] -> nada_mas
    - else:
        + [Se me está haciendo tarde...] -> fin_dia
}


= afectado
~ preguntas_realizadas++
- No pareces muy afectado... # catherine
- Ya, lo sé, es que ya ni me acordaba de ella. No tuvimos una buena relación, era todo muy tóxico y yo ya no la aguantaba más
-> interrogatorio


= relacion
~ preguntas_realizadas++
- ¿Me puedes hablar de vuestra relación? # catherine
- Empezamos a salir después de estar varias noches de borrachera. Era una relación muy tormentosa, siempre estábamos peleando por cualquier cosa, pero yo nunca le haría daño.
-> interrogatorio


= ultima_vez
~ preguntas_realizadas++
- ¿Cuándo fue la última vez que hablaste con ella? # catherine
- Es que ya no me acuerdo. Seguramente hace un mes, cuando me llamó borracha porque me echaba de menos. Colgué en cuanto la escuché, es una dramática
-> interrogatorio


= relacion_intensa // necesita "relación" (1)
~ preguntas_realizadas++
- ¿Cuánto tiempo estuvisteis juntos? ¿Le viste futuro en algún momento? # catherine
- Pues la verdad es que no sabría decirte exactamente, pero llegamos a estar más de un año juntos. Al principio tenía cierta esperanza en que lo nuestro podía funcionar, pero con el paso de los meses la ilusión se fue perdiendo y las últimas semanas apenas si nos veíamos... 
+ [Sigamos insistiendo] ¿Y eso? ¿La relación se fue enfriando? # catherine
    Sí, esa fue una de las causas. Además, como era la época de verano, Marie cada vez pasaba más tiempo en el trabajo, con lo cual nos era aún más difícil vernos.
    -> interrogatorio


= sueldo // necesita "josh.sueldo" (1)
~ preguntas_realizadas++
- Josh me dijo que los sueldos en su cafetería son buenos, ¿sabes si es cierto eso? # catherine
- ¿Buenos? Se referirá al suyo, porque la pobre de Marie siempre llegaba justa a fin de mes. Yo le ayudaba con todos los temas de Hacienda y daba pena ver la nómina que tenía... Es cierto que le solían dar un plus en negro, pero no compensaba.
-> interrogatorio


= opiniones_sueldo // necesita "sueldo" y "jennifer.sueldo" (3) - prohibido "jennifer.infidelidad"
~ preguntas_realizadas++
- Pregunté a Jennifer también por el sueldo de Marie y su respuesta fue distinta a la tuya... ¿A qué crees que se debe? # catherine
- Eso tendrías que preguntárselo a ella. Yo ya te digo que su sueldo era una miseria teniendo en cuenta todo lo que trabajaba.
-> interrogatorio


= infidelidad // necesita "jennifer.infidelidad" (9)
~ preguntas_realizadas++
// josh tiene familia
->interrogatorio


= amiga_jennifer // necesita "jennifer.sufrimiento_patrick" (11)
~ preguntas_realizadas++
// un poco de acoso
-> interrogatorio


= embarazo // necesita "infidelidad" y "jennifer.enfado_josh_infidelidad" (12)
~ preguntas_realizadas++
- Según tengo entendido, Marie se quedó embarazada unos meses antes de su desaparición, ¿no es así? # catherine
- Sí, así es. Se quedó embarazada. La verdad que fue una situación difícil porque, como te dije, nuestra relación no era lo que se dice idílica, y, como no fue algo buscado, tuvimos alguna que otra discusión más fuerte de lo habitual.
+ [¿Más fuerte de lo habitual?] -> pelea_embarazo
+ [No creo que vaya a sacar nada interesante de esto.] -> interrogatorio


= pelea_embarazo
- ¿A qué te refieres con eso último? ¿Llegásteis a las manos? # catherine
- No no... Jamás le pondría la mano encima... Lo juro... Es solo que las voces se nos fueron un poco de las manos y un vecino llamó a la policía. Pero de verdad que no le hice daño...
+ [Esconde algo, pero con lo que sé hasta ahora veo difícil conseguir algo más] -> interrogatorio


/* 
    Fin conversación Patrick
*/



== jennifer ==
~ cambio_personaje = false

- Pobre Marie. Aún me parece increíble que haya aparecido así, sin más. Qué fuerte...
-> interrogatorio

= interrogatorio
{ 
    - preguntas_realizadas < max_preguntas_dia:
        * [¿Cómo le habrá afectado la aparición de su amiga?] -> afectada
        * [Ya se sabe que hasta entre los mejores amigos hay piques de vez en cuando.] -> relacion
        * [¿Saldrían mucho de fiesta?] -> fiesta
        * {josh.sueldo} [¿Diría Josh la verdad respecto al sueldo de Marie?] -> sueldo
        * {sueldo and patrick.sueldo} [¿Por qué no coinciden las opiniones de Jennifer y Patrick?] -> opiniones_sueldo
        * {josh.simpatica} [Veamos si Jennifer sabe de algún cliente que sobrepasara el límite...] -> clientes
        * {opiniones_sueldo and clientes} [Hmm... Creo que Marie se llevaba demasiado bien con Josh para ser su jefe...] -> infidelidad
        * {infidelidad} [¿Sabría Patrick algo sobre la infidelidad de Marie?] -> patrick_cuernos
        * {patrick_cuernos} [Parece que la infidelidad fue algo más que un simple desliz.] -> infidelidad_completa
        * {patrick_cuernos} [¿Cómo de sufrida sería esta relación para Patrick?] -> sufrimiento_patrick
        + [No tengo nada más que preguntarle] -> nada_mas
    - else:
        + [Se me está haciendo tarde...] -> fin_dia
}


= afectada
~ preguntas_realizadas++
- Tu amiga está aún muy delicada, ¿estás bien? # catherine
- Es que... aún no me lo creo. Cuando me enteré de lo que sucedió, pensé que simplemente se habría escapado con alguien... Pero ha vuelto, y no sabemos qué secuelas tendrá... Ay, pobrecilla...
-> interrogatorio


= relacion
~ preguntas_realizadas++
- ¿Cómo era vuestra relación?¿Teníais discusiones o similar? # catherine
- Marie y yo siempre íbamos juntas a todos lados, inseparables, pero totalmente. Es la mejor amiga que he tenido en mi vida y siempre me contaba todas sus cosas, al igual que yo le contaba las mías. Me da miedo pensar cómo habrá cambiado después de esto...
-> interrogatorio


= fiesta
~ preguntas_realizadas++
- ¿Solíais salir de fiesta juntas? ¿Los chicos qué tal? # catherine
- Sí, a Marie le gustaba mucho la fiesta... le GUSTA la fiesta... Perdón, es que aún estoy intentando asimilarlo. 
+ [Hmm... ¿tendrían algún problema con los chicos?] ¿Y qué tal con los chicos? ¿Alguna mala experiencia? # catherine
    Pues sí, íbamos de fiesta a beber casi cada fin de semana, y muchas veces tenía que sacarla de más de un apuro con algún chico, porque se sobrepasaban con ella. Ya sabes, una chica guapa, borracha... Así que yo bebía menos de ella para poder cuidarla.
    ~ preguntas_realizadas++
    -> interrogatorio
+ [Mejor no seguir indagando por aquí] -> interrogatorio


= sueldo // necesita "josh.sueldo" (1)
~ preguntas_realizadas++
- Josh me dijo que los sueldos en su cafetería son buenos, ¿sabes si es cierto eso? # catherine
- Hasta donde yo sé, creo que son muy similares al resto de cafeterías. Aunque también es cierto que Marie nunca se quejó de ello delante mía.
-> interrogatorio


= opiniones_sueldo // necesita "sueldo" y "patrick.sueldo" (3)
~ preguntas_realizadas++
- Pregunté a Patrick también por el sueldo de Marie y su respuesta fue distinta a la tuya... ¿A qué crees que se debe? # catherine
- Pues no sé, la verdad. Ya te dije que Marie nunca se quejaba. Quizás le ocultaba parte del dinero que ganaba.
+ [¿Ocultarle parte del sueldo?] ¿Por qué iba a ocultárselo? # catherine
    - Bueno, la relación que tenían no era especialmente buena y Marie no confiaba del todo en Patrick. Como te he dicho, me extrañaría mucho que no cobrara bien teniendo en cuenta su buena relación con Josh...
-> interrogatorio


= clientes // necesita "josh.simpatica" (4)
~ preguntas_realizadas++
- ¿Sabes si en el trabajo alguna vez tuvo problemas con algún cliente? # catherine
- Bueno... no más de los habituales que puede tener una chica como ella atendiendo en una cafetería. Pero nunca llegó muy lejos porque Josh siempre estaba ahí pendiente de protegerla.
-> interrogatorio


= infidelidad // necesita "opiniones_sueldo" y "clientes" (8)
~ preguntas_realizadas++
- Por lo que me has dicho hasta ahora, la relación entre Marie y Josh parece que era muy buena, ¿no? # catherine
- Si, maravillosa, ya me gustaría a mí tener una relación con mi jefe... Bueno, quizás no tanto.
+ [Parece que he encontrado algo...] ¿Una relación excesivamente buena dices? # catherine
    - Si, bueno... A ver... Es que al final un jefe no deja de serlo por mucho cariño que le tengas... No sé...
    + [¿Tenerle cariño a tu jefe? Eso desde luego no es habitual] ¿Cariño dices? # catherine
        - Si... O sea, siempre se ha dicho que el roce hace el cariño... Y, bueno, ellos... No pudieron evitarlo. Surgió algo y tuvieron algún desliz, si.
-> interrogatorio


= patrick_cuernos // necesita "infidelidad" (9)
~ preguntas_realizadas++
- ¿Sabes si Patrick tenía constancia de la relación entre Marie y Josh? # catherine
- El pobre sí que sabía algo, sí. De hecho, alguna que otra discusión tuvieron tuvieron por el tema. Aunque yo creo que nunca llegó a enterarse de la historia al completo... Y diría que mejor así, tampoco merecía más sufrimiento.
-> interrogatorio


= infidelidad_completa // necesita "patrick_cuernos" (10)
~ preguntas_realizadas++
- ¿Cómo de grave fue la infidelidad de Marie? ¿Algo más allá de un encuentro casual? # catherine
- Oh, si, hubo más de uno... y más de diez. Aunque no sé exactamente cuánto tiempo lo mantuvieron. Marie era de lo único que apenas me hablaba, aunque luego cuando salíamos de fiesta y bebía más de la cuenta sí que se iba de la lengua. Y a Josh evidentemente era algo que no le gustaba.
->interrogatorio


= sufrimiento_patrick // necesita "patrick_cuernos" (10)
~ preguntas_realizadas++
- ¿Patrick sufrió mucho con esta relación? # catherine
- No lo pasó nada bien, no. Diría que casi desde el principio fue un tormento para él. Yo le decía a Marie que debía cuidar más de él, que era muy buen chico, atractivo... Pero ella nunca lo supo valorar. Una pena que lo dejara escapar, porque es todo un partidazo
->interrogatorio


= enfado_josh_infidelidad // necesita "infidelidad_completa" (11)
~ preguntas_realizadas++
// josh le paga a Marie; Marie estaba embarazada
->interrogatorio


= padre_desconocido
~ preguntas_realizadas++
// no sabe de quién es el hijo
->interrogatorio


// Fin conversación Jennifer



== josh ==
~ cambio_personaje = false

- Vaya... quién iba a decir que el asunto acabaría así...
-> interrogatorio

= interrogatorio
{ 
    - preguntas_realizadas < max_preguntas_dia:
        * [¿Qué le habrá parecido la aparición de Marie?] -> afectado
        * [Es posible que tuviera algún problema personal...] -> problemas_personales
        * [¿Estaría Marie contenta con su sueldo?] -> sueldo
        * {patrick.relacion_intensa} [¿Quizás notó algo ese verano que estuvo trabajando más?] -> trabajo_verano
        * {trabajo_verano} [¿Su simpatía le jugaría alguna mala pasada en algún momento?] -> simpatica
        + [No tengo nada más que preguntarle] -> nada_mas
    - else:
        + [Se me está haciendo tarde...] -> fin_dia
}


= afectado
~ preguntas_realizadas++
- ¿Cómo te sientes con la reaparición de Marie? # catherine
- Pues estoy contento, ¿por qué no iba a estarlo? Era muy trabajadora y atenta con los clientes, la cafetería siempre era un lugar alegre con ella alrededor. Siempre comentaba que le encantaba el sitio. Ahora no sé qué va a pasar, pero me alegro de que haya aparecido.
-> interrogatorio


= problemas_personales
~ preguntas_realizadas++
- ¿Sabes si tenía problemas personales? # catherine
- Hasta donde yo sé, ella hablaba mucho de sus amigos, especialmente de su amiga Jennifer. Sé que hacía un tiempo andaba soltera, le costó mucho recuperarse de aquella ruptura pero en el trabajo encontró un gran apoyo emocional y, al estar productiva, evitó la depresión. 
-> interrogatorio


= sueldo
~ preguntas_realizadas++
- ¿Había quejas en el sentido económico?¿Cómo se sentía con respecto a su sueldo en la cafetería? # catherine
- Con respecto al tema económico, los sueldos de mis empleados son muy buenos y, en todo caso, de necesitar ayuda económica, ella sabía que me lo podía pedir sin problemas. Teníamos una relación de confianza.
-> interrogatorio


= trabajo_verano // necesita "relacion_intensa" de Patrick (2)
~ preguntas_realizadas++
- Si no me equivoco, el verano antes de la desaparición, Marie estuvo echando horas extra en la cafetería. ¿Notó usted algo raro? # catherine
- No, nada. Sé que no estaba atravesando un buen momento con el chico con el que estaba saliendo, pero nunca dejó que eso te interpusiera en su camino. Siempre sacaba su mejor sonrisa y era capaz de embelesar a cualquiera.
-> interrogatorio


= simpatica // necesita "trabajo_verano" (3)
~ preguntas_realizadas++
- Como Marie era tan simpática con los clientes, no sería extraño que en algún momento alguno de ellos intentase acercarse más de lo debido... usted ya me entiende. # catherine
- Si, si, sé a qué se refiere. Y puedo asegurarle que no. Desde que estoy al mando, esta cafetería siempre ha sido segura en ese aspecto y así seguirá siendo. Evidentemente ha habido algún cliente que ha mostrado alguna intención, pero siempre lo hemos cortado de raíz. Jamás permitiría algo así. 
-> interrogatorio


= amiga_jennifer // necesita "jennifer.sufrimiento_patrick" (11)
~ preguntas_realizadas++
- ¿Qué me puede decir de la relación de Jennifer con Marie? # catherine
- Pues diría que eran unas grandísimas amigas y que prácticamente se contaban todo lo que les pasaba en la vida. Sí que recuerdo que una vez tuvieron en la cafetería una pequeña discusión, pero al final eso también viene incluido hasta en las mejores amistades.
+ [Intentemos sacar algo sobre esa discusión...] ¿Recuerda el motivo de aquella discusión? # catherine
    Pues siento decirle que no mucho, aunque quiero recordar que estaba relacionado con el chico con el que salía, un tal Patrick. Creo que Jennifer había intentado algo con él antes de salir con Marie y por algo de eso discutieron.
-> interrogatorio


= novio_patrick // necesita "amiga_jennifer" (12)
~ preguntas_realizadas++
// dice que no conoce a Patrick
-> interrogatorio


= mentira_patrick
~ preguntas_realizadas++
// confirma que conocía a Patrick por la pelea que tuvo 
-> interrogatorio



// Fin conversación Josh



== nada_mas ==
~ cambio_personaje = true

- Con esto es suficiente, muchas gracias por tu tiempo. # catherine
-> agenda


== fin_dia ==
~ novia = true

- Ya es tarde, no quiero molestar más. Muchas gracias por su tiempo. # catherine
~ dias_transcurridos++
{
    - dias_transcurridos < dias_duracion_historia:
        + [...] -> novia_dia
    - else:
        -> END
}



== novia_dia ==
+ Pregunta 1
    Respuesta 1
    -> nuevo_dia
+ Pregunta 2
    Respuesta 2
    -> nuevo_dia



== nuevo_dia ==
~ preguntas_realizadas = 0
~ cambio_personaje = true
~ novia = false
+ [...] -> agenda
        
        
        
        