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
//todo workout kopieren
//todo drag en drop in bloc state reorablelistveiw
//undo-redo van repo (word een uitdaging)
//animated transisties (goed te doen)