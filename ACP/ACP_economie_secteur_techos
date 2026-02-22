clear all

%lecture des données
Matrice_data = load("techno_info.txt");

%la matrice data contient des valeurs -1 correspondant à une absence des données
%les valeurs manquantes sont remplacées par la moyenne de la variable correspondate
%afin de ne pas biaiaser les calculs statistiques

for j = 1:size(Matrice_data,2)
    col = Matrice_data(:,j);
    col(col == -1) = mean(col(col ~= -1));
    Matrice_data(:,j) = col;
end

%centrage des données
%chaque variable est recentrée pour avoir une moyenne nulle
Xc= Matrice_data - mean(Matrice_data);


%standardisation (centrage + réduction)
%les variables sont rendues sans dimension avec une variance égale à 1
Xs = Xc ./ std(Xc);

%calcul de M (matrice de variance-covariance)
n = size(Xs,1);
M = (Xs' * Xs)/(n-1);

% Diagonalisation de M : E= matrice des vecteurs propres et D matirce des valeurs propres
[E,D] = eig(M);


%Tri des valeurs propres par ordre decroissant afin d'identifier les axes principaux de l'ACP
[valeurs_propres, ordre] = sort(diag(D), 'descend');
D = diag(valeurs_propres);
E = E(:, ordre);

%calcul de la matrice de passage P
%dans le but de projeter
P=Xs * E;

% Representation du plan factoriel (axes 1 et 2)
plot(P(:,1), P(:,2), 'o');
xlabel('Axe 1');
ylabel('Axe 2');
title('ACP – Économie du secteur des technologies de l’information');
grid on
