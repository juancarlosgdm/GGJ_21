VAR dias_duracion_historia = 20
VAR max_preguntas_dia = 6

VAR dias_transcurridos = 0
VAR preguntas_realizadas = 0

-> agenda

== agenda ==
+ [Patrick] -> patrick
+ [Jennifer] -> jennifer
+ [Josh] -> josh



== patrick ==

- Quién iba a decir que iba a aparecer...
-> interrogatorio

= interrogatorio
{ 
    - preguntas_realizadas < max_preguntas_dia:
        + [No se le ve muy afectado, la verdad.] -> afectado
        + [¿Problemas en la relación quizás?] -> relacion
        + [¿Mantendrán el contacto?] -> ultima_vez
        + {relacion} [¿Cómo de intensa sería su relación?] -> relacion_intensa
        + {josh.sueldo} [¿Diría Josh la verdad respecto al sueldo de Marie?] -> sueldo
        + {sueldo and jennifer.sueldo and (not jennifer.infidelidad)} [¿Por qué no coinciden las opiniones de Jennifer y Patrick?] -> opiniones_sueldo
        // TODO + {relacion} [Es momento de sacar el tema del embarazo] -> embarazo
        + [No tengo nada más que preguntarle] -> nada_mas
    - else:
        + [Se me está haciendo tarde...] -> fin_dia
}


= afectado
~ preguntas_realizadas++
- No pareces muy afectado...
- Ya, lo sé, es que ya ni me acordaba de ella. No tuvimos una buena relación, era todo muy tóxico y yo ya no la aguantaba más
-> interrogatorio


= relacion
~ preguntas_realizadas++
- ¿Me puedes hablar de vuestra relación?
- Empezamos a salir después de estar varias noches de borrachera. Era una relación muy tormentosa, siempre estábamos peleando por cualquier cosa, pero yo nunca le haría daño.
-> interrogatorio


= ultima_vez
~ preguntas_realizadas++
- ¿Cuándo fue la última vez que hablaste con ella?
- Es que ya no me acuerdo. Seguramente hace un mes, cuando me llamó borracha porque me echaba de menos. Colgué en cuanto la escuché, es una dramática
-> interrogatorio


= relacion_intensa // necesita "relación" (1)
~ preguntas_realizadas++
- ¿Cuánto tiempo estuvisteis juntos? ¿Le viste futuro en algún momento?
- Pues la verdad es que no sabría decirte exactamente, pero llegamos a estar más de un año juntos. Al principio tenía cierta esperanza en que lo nuestro podía funcionar, pero con el paso de los meses la ilusión se fue perdiendo y las últimas semanas apenas si nos veíamos... 
+ [Sigamos insistiendo] ¿Y eso? ¿La relación se fue enfriando?
    Sí, esa fue una de las causas. Además, como era la época de verano, Marie cada vez pasaba más tiempo en el trabajo, con lo cual nos era aún más difícil vernos.
    -> interrogatorio


= sueldo // necesita "josh.sueldo" (1)
~ preguntas_realizadas++
- Josh me dijo que los sueldos en su cafetería son buenos, ¿sabes si es cierto eso?
- ¿Buenos? Se referirá al suyo, porque la pobre de Marie siempre llegaba justa a fin de mes. Yo le ayudaba con todos los temas de Hacienda y daba pena ver la nómina que tenía... Es cierto que le solían dar un plus en negro, pero no compensaba.
-> interrogatorio


= opiniones_sueldo // necesita "sueldo" y "jennifer.sueldo" (3) - prohibido "jennifer.infidelidad"
~ preguntas_realizadas++
- Pregunté a Jennifer también por el sueldo de Marie y su respuesta fue distinta a la tuya... ¿A qué crees que se debe?
- Eso tendrías que preguntárselo a ella. Yo ya te digo que su sueldo era una miseria teniendo en cuenta todo lo que trabajaba.
-> interrogatorio


= embarazo
~ preguntas_realizadas++
- Según tengo entendido, Marie se quedó embarazada unos meses antes de su desaparición, ¿no es así?
- Sí, así es. Se quedó embarazada. La verdad que fue una situación difícil porque, como te dije, nuestra relación no era lo que se dice idílica, y, como no fue algo buscado, tuvimos alguna que otra discusión más fuerte de lo habitual.
+ [¿Más fuerte de lo habitual?] -> pelea_embarazo
+ [No creo que vaya a sacar nada interesante de esto.] -> interrogatorio


= pelea_embarazo
- ¿A qué te refieres con eso último? ¿Llegásteis a las manos?
- No no... Jamás le pondría la mano encima... Lo juro... Es solo que las voces se nos fueron un poco de las manos y un vecino llamó a la policía. Pero de verdad que no le hice daño...
+ [Esconde algo, pero con lo que sé hasta ahora veo difícil conseguir algo más] -> interrogatorio


/* 
    Fin conversación Patrick
*/



== jennifer ==

- Pobre Marie. Aún me parece increíble que haya aparecido así, sin más. Qué fuerte...
-> interrogatorio

= interrogatorio
{ 
    - preguntas_realizadas < max_preguntas_dia:
        + [¿Cómo le habrá afectado la aparición de su amiga?] -> afectada
        + [Ya se sabe que hasta entre los mejores amigos hay piques de vez en cuando.] -> relacion
        + [¿Saldrían mucho de fiesta?] -> fiesta
        + {josh.sueldo} [¿Diría Josh la verdad respecto al sueldo de Marie?] -> sueldo
        + {sueldo and patrick.sueldo} [¿Por qué no coinciden las opiniones de Jennifer y Patrick?] -> opiniones_sueldo
        + {josh.simpatica} [Veamos si Jennifer sabe de algún cliente que sobrepasara el límite...] -> clientes
        + {opiniones_sueldo and clientes} [Hmm... Creo que Marie se llevaba demasiado bien con Josh para ser su jefe...] -> infidelidad
        + [No tengo nada más que preguntarle] -> nada_mas
    - else:
        + [Se me está haciendo tarde...] -> fin_dia
}


= afectada
~ preguntas_realizadas++
- Tu amiga está aún muy delicada, ¿estás bien?
- Es que... aún no me lo creo. Cuando me enteré de lo que sucedió, pensé que simplemente se habría escapado con alguien... Pero ha vuelto, y no sabemos qué secuelas tendrá... Ay, pobrecilla...
-> interrogatorio


= relacion
~ preguntas_realizadas++
- ¿Cómo era vuestra relación?¿Teníais discusiones o similar?
- Marie y yo siempre íbamos juntas a todos lados, inseparables, pero totalmente. Es la mejor amiga que he tenido en mi vida y siempre me contaba todas sus cosas, al igual que yo le contaba las mías. Me da miedo pensar cómo habrá cambiado después de esto...
-> interrogatorio


= fiesta
~ preguntas_realizadas++
- ¿Solíais salir de fiesta juntas? ¿Los chicos qué tal?
- Sí, a Marie le gustaba mucho la fiesta... le GUSTA la fiesta... Perdón, es que aún estoy intentando asimilarlo. 
+ [Hmm... ¿tendrían algún problema con los chicos?] ¿Y qué tal con los chicos? ¿Alguna mala experiencia?
    Pues sí, íbamos de fiesta a beber casi cada fin de semana, y muchas veces tenía que sacarla de más de un apuro con algún chico, porque se sobrepasaban con ella. Ya sabes, una chica guapa, borracha... Así que yo bebía menos de ella para poder cuidarla.
    ~ preguntas_realizadas++
    -> interrogatorio
+ [Mejor no seguir indagando por aquí] -> interrogatorio


= sueldo // necesita "josh.sueldo" (1)
~ preguntas_realizadas++
- Josh me dijo que los sueldos en su cafetería son buenos, ¿sabes si es cierto eso?
- Hasta donde yo sé, creo que son muy similares al resto de cafeterías. Aunque también es cierto que Marie nunca se quejó de ello delante mía.
-> interrogatorio


= opiniones_sueldo // necesita "sueldo" y "patrick.sueldo" (3)
~ preguntas_realizadas++
- Pregunté a Patrick también por el sueldo de Marie y su respuesta fue distinta a la tuya... ¿A qué crees que se debe?
- Pues no sé, la verdad. Ya te dije que Marie nunca se quejaba. Quizás le ocultaba parte del dinero que ganaba.
+ [¿Ocultarle parte del sueldo?] ¿Por qué iba a ocultárselo?
    - Bueno, la relación que tenían no era especialmente buena y Marie no confiaba del todo en Patrick. Como te he dicho, me extrañaría mucho que no cobrara bien teniendo en cuenta su buena relación con Josh...
-> interrogatorio


= clientes // necesita "josh.simpatica" (4)
~ preguntas_realizadas++
- ¿Sabes si en el trabajo alguna vez tuvo problemas con algún cliente?
- Bueno... no más de los habituales que puede tener una chica como ella atendiendo en una cafetería. Pero nunca llegó muy lejos porque Josh siempre estaba ahí pendiente de protegerla.
-> interrogatorio


= infidelidad // necesita "opiniones_sueldo" y "clientes" (8)
~ preguntas_realizadas++
- Por lo que me has dicho hasta ahora, la relación entre Marie y Josh parece que era muy buena, ¿no?
- Si, maravillosa, ya me gustaría a mí tener una relación con mi jefe... Bueno, quizás no tanto.
+ [Parece que he encontrado algo...] ¿Una relación excesivamente buena dices?
    - Si, bueno... A ver... Es que al final un jefe no deja de serlo por mucho cariño que le tengas... No sé...
    + [¿Tenerle cariño a tu jefe? Eso desde luego no es habitual] ¿Cariño dices?
        - Si... O sea, siempre se ha dicho que el roce hace el cariño... Y, bueno, ellos... No pudieron evitarlo. Surgió algo y tuvieron más de un desliz, si.
-> interrogatorio


// Fin conversación Jennifer



== josh ==

- Vaya... quién iba a decir que el asunto acabaría así...
-> interrogatorio

= interrogatorio
{ 
    - preguntas_realizadas < max_preguntas_dia:
        + [¿Qué le habrá parecido la aparición de Marie?] -> afectado
        + [Es posible que tuviera algún problema personal...] -> problemas_personales
        + [¿Estaría Marie contenta con su sueldo?] -> sueldo
        + {patrick.relacion_intensa} [¿Quizás notó algo ese verano que estuvo trabajando más?] -> trabajo_verano
        + {trabajo_verano} [¿Su simpatía le jugaría alguna mala pasada en algún momento?] -> simpatica
        + [No tengo nada más que preguntarle] -> nada_mas
    - else:
        + [Se me está haciendo tarde...] -> fin_dia
}


= afectado
~ preguntas_realizadas++
- ¿Cómo te sientes con la reaparición de Marie?
- Pues estoy contento, ¿por qué no iba a estarlo? Era muy trabajadora y atenta con los clientes, la cafetería siempre era un lugar alegre con ella alrededor. Siempre comentaba que le encantaba el sitio. Ahora no sé qué va a pasar, pero me alegro de que haya aparecido.
-> interrogatorio


= problemas_personales
~ preguntas_realizadas++
- ¿Sabes si tenía problemas personales?
- Hasta donde yo sé, ella hablaba mucho de sus amigos, especialmente de su amiga Jennifer. Sé que hacía un tiempo andaba soltera, le costó mucho recuperarse de aquella ruptura pero en el trabajo encontró un gran apoyo emocional y, al estar productiva, evitó la depresión. 
-> interrogatorio


= sueldo
~ preguntas_realizadas++
- ¿Había quejas en el sentido económico?¿Cómo se sentía con respecto a su sueldo en la cafetería?
- Con respecto al tema económico, los sueldos de mis empleados son muy buenos y, en todo caso, de necesitar ayuda económica, ella sabía que me lo podía pedir sin problemas. Teníamos una relación de confianza.
-> interrogatorio


= trabajo_verano // necesita "relacion_intensa" de Patrick (2)
~ preguntas_realizadas++
- Si no me equivoco, el verano antes de la desaparición, Marie estuvo echando horas extra en la cafetería. ¿Notó usted algo raro?
- No, nada. Sé que no estaba atravesando un buen momento con el chico con el que estaba saliendo, pero nunca dejó que eso te interpusiera en su camino. Siempre sacaba su mejor sonrisa y era capaz de embelesar a cualquiera.
-> interrogatorio


= simpatica // necesita "trabajo_verano" (3)
~ preguntas_realizadas++
- Como Marie era tan simpática con los clientes, no sería extraño que en algún momento alguno de ellos intentase acercarse más de lo debido... usted ya me entiende.
- Si, si, sé a qué se refiere. Y puedo asegurarle que no. Desde que estoy al mando, esta cafetería siempre ha sido segura en ese aspecto y así seguirá siendo. Evidentemente ha habido algún cliente que ha mostrado alguna intención, pero siempre lo hemos cortado de raíz. Jamás permitiría algo así. 
-> interrogatorio


// Fin conversación Josh



== nada_mas ==
- Con esto es suficiente, muchas gracias por tu tiempo.
-> agenda


== fin_dia ==
- Ya es tarde, no quiero molestar más. Muchas gracias por su tiempo.
- [Conversación con la novia...]
~ dias_transcurridos++
{
    - dias_transcurridos < dias_duracion_historia:
        ~ preguntas_realizadas = 0
        Empieza un nuevo día. ¡Vamos allá!
        -> agenda
    - else:
        Hora de decidir quién ha sido el culpable...
        -> END
}