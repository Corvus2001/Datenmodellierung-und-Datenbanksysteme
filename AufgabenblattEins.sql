/* SQL01 - Filterung
Bestellungen mit Bestelldatum 23.09.2019 und KID kleiner als 10700.
Sortiert nach BID */
SELECT BID, KID
FROM Bestellung
WHERE Bestelldatum = TO_DATE('2019-09-23', 'YYYY-MM-DD') AND KID < 10700
ORDER BY BID;
/* Preise der Preisliste PLID=1, deren Betrag größer als 70 Euro ist.
Sortiert nach Betrag.*/
SELECT PID, Betrag
FROM Preis
WHERE PLID = 1 AND Betrag  > 70
ORDER BY Betrag;

/*SQL02 - Null
Alle Produkte, die keine Längenangabe haben.
Sortiert nach Bez.*/
SELECT PID, BEZ, LAENGE, BREITE
FROM PRODUKT
WHERE Laenge IS Null
ORDER BY BEZ;

/*Alle Verkaufsgebiete, die keine Obergebiete haben.*/
SELECT VGID, OBERGEBIET, BEZ, EBENE
FROM VERKAUFSGEBIET
WHERE OBERGEBIET IS NULL;


/*CASE
Verkaufsgebiete und Kennzeichnung, ob ein Gebiet Wurzel der Hierarchie ist,
innerer Knoten oder Blatt.*/
--Mit hilfe von ChatGPT also mit voricht
SELECT VGID, BEZ,
CASE
  WHEN OBERGEBIET IS NULL THEN 'Wurzel'
  WHEN VGID IN (SELECT DISTINCT OBERGEBIET FROM Verkaufsgebiet WHERE OBERGEBIET IS NOT NULL) THEN 'Innerer Knoten'
  ELSE 'Blatt'
END AS KNOTENART
FROM Verkaufsgebiet
ORDER BY VGID;


