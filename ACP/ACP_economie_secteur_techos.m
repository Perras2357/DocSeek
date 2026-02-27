clear all
% ==============================
% Lecture des donnees
% ==============================

X = load("techno_info.txt");

% Noms des 15 secteurs (donné dans l'exercice)
secteurs = {
    "InP"
    "InC"
    "InG"
    "InA"
    "Tfi"
    "TSF"
    "Tsa"
    "Taa"
    "Wth"
    "Wpi"
    "Wap"
    "Wau"
    "Roe"
    "Rec"
    "Rgp"
};

% ==============================
% ACP 1 : Donnees brutes 
% ==============================

Xc = X - mean(X);          % centrage
Xs = Xc ./ std(Xc);        % reduction

n = size(Xs,1);            % nombre d'observations
M = (Xs' * Xs)/(n-1);      % matrice de covariance

[E,D] = eig(M);            % valeurs/vecteurs propres
[valeurs_propres, ordre] = sort(diag(D),"descend");
E = E(:,ordre);

P1 = Xs * E;               % projection

figure
scatter(P1(:,1),P1(:,2),60,"filled")
hold on
for i=1:length(secteurs)
    text(P1(i,1)+0.2,P1(i,2),secteurs{i})
end
title("ACP 1 - Donnees brutes")
xlabel("Axe 1")
ylabel("Axe 2")
grid on
hold off


% ==============================
% ACP 2 : Apres remplacement des -1
% ==============================

X_corr = X;

for j=1:size(X_corr,2)
    col = X_corr(:,j);
    if any(col == -1)
        col(col == -1) = mean(col(col ~= -1));
    end
    X_corr(:,j) = col;
end

Xc = X_corr - mean(X_corr);
Xs = Xc ./ std(Xc);

n = size(Xs,1);
M = (Xs' * Xs)/(n-1);

[E,D] = eig(M);
[valeurs_propres, ordre] = sort(diag(D),"descend");
E = E(:,ordre);

P2 = Xs * E;

figure
scatter(P2(:,1),P2(:,2),60,"filled")
hold on
for i=1:length(secteurs)
    text(P2(i,1)+0.2,P2(i,2),secteurs{i})
end
title("ACP 2 - Apres traitement des -1")
xlabel("Axe 1")
ylabel("Axe 2")
grid on
hold off


% ==============================
% ACP 3 : Apres suppression des variables redondantes
% ==============================

% matrice de correlation pour detection redondance
R = corrcoef(Xs);

% ici on ne supprime rien par defaut
colonnes_a_supprimer = [];

X_reduit = Xs;
X_reduit(:,colonnes_a_supprimer) = [];

n = size(X_reduit,1);
M = (X_reduit' * X_reduit)/(n-1);

[E,D] = eig(M);
[valeurs_propres, ordre] = sort(diag(D),"descend");
E = E(:,ordre);

P3 = X_reduit * E;

figure
scatter(P3(:,1),P3(:,2),60,"filled")
hold on
for i=1:length(secteurs)
    text(P3(i,1)+0.2,P3(i,2),secteurs{i})
end
title("ACP 3 - Apres reduction des variables")
xlabel("Axe 1")
ylabel("Axe 2")
grid on
hold off
