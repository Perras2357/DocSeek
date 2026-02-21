\## Modeur de recherche Google





\### Chaîne d'appels :



graph TD

&nbsp;   A(\[Script .m]) --> B\[chargerFichiers]

&nbsp;   B --> C\[construireOutLinks]

&nbsp;   C --> D\[construireMatriceTransition]

&nbsp;   D --> E\[construireMatriceGoogle]

&nbsp;   E --> F\[calculerPageRank]

