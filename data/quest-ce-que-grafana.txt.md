Qu'est ce que Grafana

Présentation : 
 Grafana est un logiciel libre, qui permet d'interroger, de visualiser, de configurer des alertes et d'explorer les métriques, journaux et traces, quel que soit leur emplacement de stockage. 
 Les plugins de sources de données Grafana permettent d'interroger des sources de données telles que les bases de données de séries temporelles comme Prometheus et CloudWatch , les outils de journalisation comme Loki et Elasticsearch , les bases de données NoSQL/SQL comme Postgres , les outils CI/CD comme GitHub , et bien d'autres. Grafana fournit également des outils pour afficher ces données sur des tableaux de bord interactifs, avec des graphiques et des visualisations pertinents. 
 Prérequis : 
 Pour exécuter Grafana, il faut disposer d'un système d'exploitation compatible, d'un matériel répondant ou dépassant les exigences minimales, d'une base de données compatible et d'un navigateur compatible. 
 Systèmes d'exploitation pris en charge : 
 Grafana prend en charge les systèmes d'exploitation suivants : 
 
 Debian ou Ubuntu 
 RHEL ou Fedora 
 SUSE ou openSUSE 
 macOS 
 Windows 
 
 Note : 
 L'installation de Grafana sur d'autres systèmes d'exploitation est possible, mais n'est ni recommandée ni prise en charge. 
 Recommandations matérielles : 
 Grafana requiert les ressources système minimales suivantes : 
 
 Mémoire minimale recommandée : 512 Mo 
 Processeur minimum recommandé : 1 cœur 
 
 Certaines fonctionnalités peuvent nécessiter davantage de mémoire ou de processeurs, notamment : 
 
 rendu des images côté serveur 
 Alerte 
 proxy de source de données 
 
 Bases de données prises en charge : 
 Grafana nécessite une base de données pour stocker ses données de configuration, telles que les utilisateurs, les sources de données et les tableaux de bord. Les exigences exactes dépendent de la taille de l'installation Grafana et des fonctionnalités utilisées. 
 Grafana prend en charge les bases de données suivantes : 
 
 SQLite 3 
 MySQL 8.0+ 
 PostgreSQL 12+
Par défaut, Grafana utilise une base de données SQLite intégrée, stockée dans le répertoire d'installation de Grafana. 
 
 Note : 
 SQLite convient aux environnements de petite taille, mais son utilisation est déconseillée lorsque votre environnement s'agrandit.