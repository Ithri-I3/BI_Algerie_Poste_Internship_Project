CREATE TABLE Dim_Temps (
    id_temps nvarchar(8) PRIMARY KEY,
    jour INT,
    mois INT,
    annee INT,
    nom_mois NVACHAR(10)
);

WITH DateCTE AS (
    SELECT 
        CAST('2000-01-01' AS DATE) AS dt
    UNION ALL
    SELECT 
        DATEADD(DAY, 1, dt)
    FROM 
        DateCTE
    WHERE 
        dt < '2060-01-01'
)

INSERT INTO Dim_Temps (id_temps, jour, mois, annee, nom_mois)
SELECT 
    CONVERT(NVARCHAR(8), dt, 112) AS id_temps,
    DAY(dt) AS jour,
    MONTH(dt) AS mois,
    YEAR(dt) AS annee,
    CASE 
        WHEN MONTH(dt) = 1 THEN 'Janvier'
        WHEN MONTH(dt) = 2 THEN 'Février'
        WHEN MONTH(dt) = 3 THEN 'Mars'
        WHEN MONTH(dt) = 4 THEN 'Avril'
        WHEN MONTH(dt) = 5 THEN 'Mai'
        WHEN MONTH(dt) = 6 THEN 'Juin'
        WHEN MONTH(dt) = 7 THEN 'Juillet'
        WHEN MONTH(dt) = 8 THEN 'Août'
        WHEN MONTH(dt) = 9 THEN 'Septembre'
        WHEN MONTH(dt) = 10 THEN 'Octobre'
        WHEN MONTH(dt) = 11 THEN 'Novembre'
        ELSE 'Décembre'
    END AS nom_mois
FROM 
    DateCTE
OPTION (MAXRECURSION 0);







CREATE TABLE Dim_Pays (
    id_pays nvarchar(2) PRIMARY KEY,
    nom_pays NVARCHAR(20)
);

CREATE TABLE Dim_Type_Courrier (
    id_type_courrier nvarchar(1) PRIMARY KEY,
    nom_type_courrier NVARCHAR(20)
);

CREATE TABLE Dim_Zone (
    id_bureau smallint PRIMARY KEY,
    nom_bureau NVARCHAR(50),
    id_commune NVARCHAR(50),
    id_wilaya INT,
    nom_wilaya NVARCHAR(50),

);


CREATE TABLE Fact_Envoi_Postaux (
    id_bureau smallint,
    id_pays nvarchar(2),
    id_type_courrier nvarchar(1),
    id_temps_eve30 nvarchar(8),
    id_temps_eve32 nvarchar(8),
    id_temps_eve37 nvarchar(8),
    id_envoi uniqueidentifier,
    etat_event30 INT,
    etat_event32 INT,
    etat_event37 INT,
    delai_distribution INT,
    PRIMARY KEY (id_bureau, id_pays, id_type_courrier, id_temps_eve30, id_temps_eve32, id_temps_eve37, id_envoi),
    FOREIGN KEY (id_bureau) REFERENCES Dim_Zone(id_bureau),
    FOREIGN KEY (id_pays) REFERENCES Dim_Pays(id_pays),
    FOREIGN KEY (id_type_courrier) REFERENCES Dim_Type_Courrier(id_type_courrier),
    FOREIGN KEY (id_temps_eve30) REFERENCES Dim_Temps(id_temps),
    FOREIGN KEY (id_temps_eve32) REFERENCES Dim_Temps(id_temps),
    FOREIGN KEY (id_temps_eve37) REFERENCES Dim_Temps(id_temps)
);
   


ALTER TABLE nom_table
ADD id_nom_table INT IDENTITY(1,1);





