
//SQL01: Bestellungen mit Bestelldatum 23.09.2019 und KID kleiner als 10700.
//Sortiert nach BID
SELECT * 
FROM Bestellungen 
WHERE Bestelldatum = '2019-09-23' AND KID < 10700
ORDER BY BID;


//SQl01: Preise der Preisliste PLID=1, deren Betrag größer als 70 Euro ist.
//Sortiert nach Betrag.
SELECT * 
FROM PID
WHERE PLID = 1 AND Betrag > 70
ORDER BY Betrag;



//SQL02: Alle Produkte, die keine Längenangabe haben.
//Sortiert nach Bez.
SELECT *
FROM Produkte
WHERE Länge IS NULL OR Länge = ''
ORDER BY Bez;

//SQL02: Alle Verkaufsgebiete, die keine Obergebiete haben.
SELECT *
FROM Verkaufsgebiete
WHERE Obergebiet IS NULL;




//SQLCase : Verkaufsgebiete und Kennzeichnung, ob ein Gebiet Wurzel der Hierarchie ist,
//innerer Knoten oder Blatt

SELECT vgid, bez
 CASE
WHEN knotenart = 'Wurzel'
  WHEN knotenart = 'innerer Knoten'
  ELSE 'Blatt'
 END AS knotenart
from verkaufsgebiet;



//Verkaufsgebiethierarchie mit Einrückungen entsprechend der Ebene.
//Sortiert nach VGID.???

//Produktkategoriehierarchie mit Einrückungen entsprechend der Ebene.
//Sortiert nach KID????



//Datenfehler: Bestellpositionen mit fehlerhaftem Einzelpreis
//D.h., der Einzelpreis stimmt nicht mit dem Betrag aus der zum Zeitpunkt gültigen Preisliste überein.
//Sortiert nach BID und PID.
SELECT BID, PID, Einzelpreis
FROM Bestellpositionen 
JOIN Preisliste ON PID = PID
WHERE Einzelpreis != Preis
ORDER BY BID, PID;



//SelfJoin: Produktkategorien mit Unter- und Unter-Unterkategorien.
//Sortiert nach KID.

SELECT 
    K1.Kategorie AS Kategorie,
    K2.Unterkategorie AS Unterkategorie,
    K3.UnterUnterKategorie AS UnterUnterKategorie
FROM 
    Produktkategorien AS K1
LEFT JOIN 
    Produktkategorien AS K2 ON K1.KID = K2.KID
LEFT JOIN 
    Produktkategorien AS K3 ON K2.KID = K3.KID
ORDER BY 
    K1.KID, K2.KID, K3.KID;


//SelfJoin: Verkaufsgebietshierarchie mit allen Ebenen.
//Sortiert nach VGID von Ebene 1 bis 4 
SELECT 
    E1.Ebene1 AS Ebene1,
    E2.Ebene2 AS Ebene2,
    E3.Ebene3 AS Ebene3,
    E4.Ebene4 AS Ebene4
FROM 
    Verkaufsbeietshierachie AS E1
LEFT JOIN 
    Verkaufsbeietshierachie AS E2 ON E1.VGID = E2.VGID
LEFT JOIN 
    Verkaufsbeietshierachie AS E3 ON E2.VGID = E3.VGID
LEFT JOIN 
    Verkaufsbeietshierachie AS E4 ON E3.VGID = E4.VGID
ORDER BY 
    E1.VGID, E2.VGID, E3.VGID, E4.VGID;



//LeftJoin: Kunden aus Verkaufsgebiet 2220 ohne Bestellungen.
//Sortiert nach KID

SELECT Kunden.KID, Kunden.Name
FROM Kunden
LEFT JOIN Bestellungen ON Kunden.KID = Bestellungen.KID
WHERE Kunden.Verkaufsgebiet = 2220
AND Bestellungen.KID IS NULL
ORDER BY Kunden.KID;

//LeftJoin: Produkte ohne Bestellungen.
//Sortiert nach PID.
SELECT Produkte.pid, Produkte.bez
FROM Produkte
LEFT JOIN Bestellungen ON Produkte.pid = Bestellungen.pid
WHERE Bestellungen.pid IS NULL
ORDER BY Produkte.pid;



//Anzahl: Anzahl Bestellungen pro Verkaufsgebiet der Ebene 3.
//Es sollen nur solche Verkaufsgebiete ausgegeben werden, die mehr als 2000 Bestellungen haben.
//Sortiert nach VGID.
SELECT vgid, bez, anzahl_bestellungen
FROM Verkaufsgebiete
WHERE ebene = 3 
AND anzahl_bestellungen > 2000
ORDER BY vgid;

//Anzahl: Anzahl Bestellungpositionen pro Kategorie der Ebene 2.
//Es sollen nur solche Kategorien ausgegeben werden, die mehr als 20000 Bestellungen haben.
//Sortiert nach KID.
SELECT kid, bez, anzahl_bestellungen
FROM ProduktKategorien
WHERE ebene = 2
AND anzahl_bestellungen > 20000
ORDER BY kid;



//monatsweiser Umsatz: Umsatz 'Lima Gartensessel' über alle Monate des Jahres 2019.
//Umsatz ist Summe Gesamtpreise der Bestellungen.
//Absteigend sortiert nach Umsatz.


SELECT SUM(Umsatz) AS Gesamtumsatz
FROM Produkte
WHERE Jahr = 2019 AND Produktname = 'Lima Gartensessel'
GROUP BY Jahr, Monat
ORDER BY Gesamtumsatz DESC;

//monatsweiser Umsatz: Umsatz im Verkaufsgebiet 'Nordwest' über alle Monate des Jahres 2019.
//Umsatz ist Summe Gesamtpreise der Bestellungen.
//Absteigend sortiert nach Umsatz.
SELECT SUM(Umsatz) AS Gesamtumsatz
FROM Verkaufgebiete
WHERE Verkaufsgebiet = 'Nordwest'
AND YEAR = 2019
GROUP BY YEAR, Monat
ORDER BY Gesamtumsatz DESC;



//zweidimensionaler Umsatz: Umsatz pro Jahr und Verkaufsgebiet für die Jahre 2018 und 2019.
//Umsatz ist Summe Gesamtpreise der Bestellungen.
//Sortiert nach Jahr und Verkaufsgebietbezeichnung.


SELECT Jahr, Verkaufsgebiet, SUM(Umsatz) AS Gesamtumsatz
FROM verkaufsgebiete
WHERE Jahr IN (2018, 2019)
GROUP BY Jahr, Verkaufsgebiet
ORDER BY Jahr, Verkaufsgebiet;


//Umsatz pro Jahr und Kategorie für die Jahre 2018 und 2019.
//Es sollen nur Produkte der Kategorien der Ebene 3 betrachtet werden.
//Umsatz ist Summe Gesamtpreise der Bestellungen.
//In die Berechnung darf jedes Produkt nur bzgl. der Hauptkategorie einbezogen werden.
//Sortiert nach Jahr und Produktbezeichnung.???


















