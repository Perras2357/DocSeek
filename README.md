# ACP
ACP : L’économie du secteur des technologies de l’information
Ce script réalise une Analyse en Composantes Principales (ACP)
à partir du fichier `techno_info.txt`.

Contenu du script :
- Lecture des données
- Remplacement des valeurs manquantes (-1)
- Standardisation des variables
- Calcul de la matrice de variance-covariance
- Diagonalisation avec eig
- Tri des valeurs propres
- Projection des secteurs
  
L’ACP met en évidence :
Une forte structuration par un facteur principal lié à la taille économique des secteurs (chiffre d’affaires, effectifs, investissements).
Un secteur dominant (InC – Conseil en systèmes et logiciels) qui se distingue nettement des autres.
Un regroupement important de plusieurs secteurs présentant des profils économiques similaires.
Une stabilité de la structure après traitement des valeurs manquantes et réduction des variables.

Les différentes versions de l’ACP conduisent à des plans factoriels très proches, ce qui montre que la structure économique du secteur est robuste.
