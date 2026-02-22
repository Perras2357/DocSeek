\## Moteur de recherche basé sur PageRank



\### Objectif :

Implémenter le moteur de recherche de \*\*Google\*\* utilisant :

\* Documents interconnectés

\* Matrice de transition

\* Matrice Google



\### Structure du projet et des données



\#### Aborescence des repertoires

&nbsp;   src/            <---- Repertoire des différentes fonctions

&nbsp;       chargerFichiers.m

&nbsp;       construireOutLinks.m

&nbsp;       construireMatriceTransition.m

&nbsp;       construireMatriceGoogle.m

&nbsp;       calculerPageRank.m

&nbsp;       rechercherEtClasser.m

&nbsp;       extraireFragmant.m

&nbsp;       tokeniserTexte.m

&nbsp;   data/           <---- Repertoire à créer pour mettre les fichiers avec pour extension txt

&nbsp;   main.m          <---- Fichier principal

&nbsp;   logique.m       <---- Fichier d'établissement de la logique de calculs



\#### Structure des fichiers

Les fichiers se trouvant dans `data/` doivent avoir pour extension `txt` avec pour encodage \*\*UTF-8\*\*. Ils sont liés par cette nommenclature : `\[pointeur](nom\_fichier\_pointé)`



\#### Chaîne d'appels principale



```mermaid

sequenceDiagram

&nbsp;   participant A as main

&nbsp;   participant B as chargerFichiers

&nbsp;   participant C as construireOutLinks

&nbsp;   participant D as construireMatriceTransition

&nbsp;   participant E as construireMatriceGoogle 

&nbsp;   participant F as calculerPageRank

&nbsp;   participant G as tokeniserTexte

&nbsp;   participant H as rechercherEtClasser

&nbsp;   participant I as extraireFragmant





&nbsp;   A->>B: appel(data\_dir)

&nbsp;   B-->>A: retour(files,contents)

&nbsp;   A->>C: appel(files,contents)

&nbsp;   C-->>A: retourn(outLink,indexMap)

&nbsp;   A->>D: appel(outLinks, numel(files))

&nbsp;   D-->>A: retourn(M)

&nbsp;   A->>E: appel(M, d)

&nbsp;   E-->>A: retourn(G)

&nbsp;   A->>F: appel(G)

&nbsp;   F-->>A: retourn(r)

&nbsp;   H->>G: appel(contents{i})

&nbsp;   G-->>H: retourn(docTokens)

&nbsp;   A->>H: appel(files, contents, r, query)

&nbsp;   H-->>A: retourn(\[ranked, matchCount, bestMatchedTokens])

&nbsp;   A->>I: appel(contents{i}, matchedTokensDoc, 17)

&nbsp;   I-->>A: retourn(texte)

```





\### Pipeline détaillé 



1\) Indexation des documents



\* Scan des fichiers `.txt`

\* Création de la matrice de transition



2\) Calcul de la popularité : 



\*G = dM + (1-d)\*\*1\*\*/N\*



où :

\- M = matrice de transition

\- d = facteur d’amortissement (0.85)

\- N = nombre de documents

\- \*\*1\*\* = Matrice Unitaire



3\) Recherche multi-mots



La requête utilisateur est :

\- Tokenisée (tokeniserTexte)

\- Comparée document par document

\- Score = nombre de mots distincts matchés



Classement final :



a. Pertinence (nb mots matchés)



b. PageRank (tie-break)



4\) Snippet intelligent



Pour le meilleur résultat :

\- Extraction d’une fenêtre de texte

\- Mise en évidence des mots trouvés :





























