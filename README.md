# cube_workouts

## project structuur
- Gekozen structuur optie B Layer first
Je bent vrij om je eigen structuur te kiezen. Twee gangbare opties:
Optie B: Layer-first
lib/
    core/
    data/
        repositories/
        models (dto)/
    domain/
        models/
        bloc/
    presentation/
        screens/
        widgets/

Ik heb dit gekozen omdat de workout app relatief klein is en er niet veel lagen zijn. In deze situatie vind ik het logischer om de lagen te scheiden op basis van hun functie (data, domain, presentation) in plaats van op basis van features. Ook kies ik dit omdat meer lijkt op mijn huidige structuur waar ik mee werk en is, ook al is dat kleinschaliger (models, services, widgets, pages). Ook invergelijking met feature first vind ik deze logischer want waar zou ik dan herbruikbare code moeten plaatsen? Dan zou de core heel erg vol worden, en ik weet niet hoe ik dat zou moeten aan pakken.

## Bonus
- Lokale opslag met Hive
ik heb gekozen voor Hive omdat ik al ervaring heb met Hive vanwege flutter en wou ik geen in memory opslag gebruiken voor de workouts. 


- do zoekfunctie + 300ms debounce
heb een zoekfunctie toegevoegd aan de workout lijst, zodat je workouts kan zoeken op naam. Ik heb een debounce van 300ms toegevoegd om te voorkomen dat er te veel zoekopdrachten worden uitgevoerd terwijl de gebruiker typt.
- workout kopieren
de kopieer functie werkt door de huidige workout te kopieren met een nieuwe id gegeneerd door de datetime, daarna wordt door de lijst van exercises geloopt om daar ook de id te genereren met datetime + index, zodat ze sowiezo uniek zijn. Daarna wordt de gekopieerde workout toegevoegd aan de lijst van workouts in de repository.
-  drag en drop in bloc state reorablelistveiw
de drag en drop functionaliteit is toegevoegd aan de workout lijst, zodat je workouts kan herschikken. Dit is gedaan door gebruik te maken van de ReorderableListView, niet door een package. De nieuwe volgorde van de workouts wordt opgeslagen in de bloc state, zodat deze behouden blijft bij het navigeren tussen schermen.
- undo-redo van repo (word een uitdaging)
heb besloten deze niet te doen. omdat ik al veel tijd heb besteed aan de andere features en ik ook niet een direct beeld bij heb over hoe ik dit zou moeten implementeren. via de repositories. 
- animated transisties 
er zijn geen geavenceerde animaties met animationcontrollers of tweens, maar wel animaties zoals dissmisable. maar dat telt niet echt.



## packages
- flutter_bloc: voor state management
- freezed_annotation: voor het genereren van immutable classes en union types
- go_router: voor het navigeren tussen schermen
- hive: voor lokale opslag van workouts
- image_picker: voor het selecteren van afbeeldingen voor workouts
- json_annotation: voor het genereren van json serializable code
- path_provider: voor het vinden van de juiste paden op het apparaat
- build_runner: voor het genereren van code
- freezed: voor het genereren van immutable classes en union types




## extra

ik zat nog te denken om de id's om te zetten naar een string zodat ik de uuid package kan gebruiken, maar anders zou er nog veel moeten worden aangepast, en dat is op dit moment niet nodig, en ik wil de initial data niet zomaar aanpassen. Dus ik heb ervoor gekozen om de id's als int te laten en een timestamp te gebruiken als id generator, dat is ook uniek genoeg voor deze app.


Ook ben ik wel over de tijd, dit kwam doordat ik onderzoek moest doen over de structuur van de code en packages, bijvoorbeeld,
hoe werkt bloc, go router, freezed en wat is een repository. Ik had met stage bij yellowQ wel ervaring met repositories. maar werd nooit uitgelegd wat het is en hoe het werkt. aangezien die developer alleen uit nepal kwam. Maar ik hoop dat ik nu de structuur goed heb. anders graag feedback hierover.

ik zat ook nog te denken over hoe ik de data zou syncen tussen repositories, local, memory/remote. maar dat werd niet beschreven de opdracht. dus heb ook niet toegevoed.