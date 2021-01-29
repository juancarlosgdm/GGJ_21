VAR dias_duracion_historia = 3
VAR max_preguntas_dia = 2

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
        + [Hasta entre los mejores amigos suelen haber piques de vez en cuando...] -> relacion
        + [¿Saldrían mucho de fiesta?] -> fiesta
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

// Fin conversación Josh



== nada_mas ==
- Con esto es suficiente, muchas gracias por tu tiempo.
-> agenda


== fin_dia ==
- Ya es tarde, no quiero molestar más. Muchas gracias por su tiempo.
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