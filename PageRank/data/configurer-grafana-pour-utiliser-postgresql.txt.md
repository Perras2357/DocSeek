Configurer Grafana pour utiliser PostgreSQL

Création de la base de données : 
 Nous supposons que postgres est installé si non se reférer à la documentation de son instalation : Postgres installation . 
 Créer une base de donnée postgres avec comme informations : 
 
 name data base : grafana_db 
 user data base : grafana 
 
 Le quide de création de la base de données, utilisateurs et d'accord de droits se trouve dans : Create data base . 
 Configuration de Grafana : 
 
 
 localiser le fichier grafana.ini , généralement situé dans /etc/grafana/ ou /usr/local/etc/grafana/ 
 
 
 Modifier la section [database] pour établir la connexion à postgreSQL : 
 [database]
#my configuration
;type = postgres
;host = localhost:5432
;name = grafana_db
;user = grafana
;password = mdp_grafana
 
 NB : remplacer les valeurs des entrées ou commenter celles existantes et ajouter les votres car la configuration de base est faite pour une base de données SQLite . 
 
 
 Démarrer Grafana : 
 Démarrer le serveur Grafana : 
 sudo systemctl start grafana-server
 sudo systemctl enable grafana-server
 
 Accéder à Grafana : 
 Ouvrir Grafana dans un navigateur :
Accédez à http://localhost:3000 (ou à l'adresse IP de votre serveur) dans un navigateur Web.
Connectez-vous avec les identifiants par défaut ( admin / admin ) et changez le mot de passe lorsque vous y êtes invité. 
 Ajouter PostgreSQL comme source de données : 
 Configurer la source de données :
Une fois connecté, accédez à Configuration > Data Sources .
Cliquez sur Add data source et sélectionnez PostgreSQL .
Saisissez les informations de connexion à votre instance PostgreSQL et enregistrez la source de données.