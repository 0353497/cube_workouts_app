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

