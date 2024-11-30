CREATE TABLE Dim_Zone (
    id_bureau smallint PRIMARY KEY,
    nom_bureau VARCHAR(50),
    id_commune NVARCHAR(50),
    id_wilaya INT,
    nom_wilaya VARCHAR(50),
);



CREATE TABLE Dim_Type_Event (
    id_event nvarchar(8) PRIMARY KEY,
    event_description NVARCHAR(64)
);


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



CREATE TABLE Fact_Dhabia (
    id_bureau smallint,
    event2_cd nvarchar(8) ,
    id_carte uniqueidentifier,
    date_event_1 nvarchar(8),
    date_event_2 nvarchar(8),
    duree INT,
    PRIMARY KEY (id_carte,id_bureau, event2_cd, date_event_1,date_event_2),
    FOREIGN KEY (id_bureau) REFERENCES Dim_Zone(id_bureau),
    FOREIGN KEY (event2_cd) REFERENCES Dim_Type_Event(id_event),
    FOREIGN KEY (date_event_1) REFERENCES Dim_Temps(id_temps),
    FOREIGN KEY (date_event_2) REFERENCES Dim_Temps(id_temps),  
);


insert into Dim_Type_Event values ('--', 'None')
insert into Dim_Temps values ('0', 0, 0,0)
insert into Dim_Zone(id_bureau) values ('0000000')


ALTER TABLE nom_table
ADD id_nom_table INT IDENTITY(1,1);