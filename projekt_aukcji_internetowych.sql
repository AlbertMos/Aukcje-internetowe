-- Tytuł: Baza danych aukcji internetowych
-- Opis: Baza zawiera informacje o aukcjach sklepu internetowego. Każdy zarejestrowany kupujący znajduje się w tabeli z kupującymi. Nie każdy kupujący musiał zrobić już jakąś transakcję (mógł się tylko zarejestrować).

/* Tabela Kupujący */
CREATE TABLE Kupujacy 
( 
  id char(10) NOT NULL, 
  imie char(50) NOT NULL,
  nazwisko char(50) NOT NULL, 
  adres char(50), 
  miasto char(50), 
  email char(255) CHECK (email LIKE '%@%'),
  PRIMARY KEY (id)
);

/* Tabela Koszyki */
CREATE TABLE Koszyki 
( 
  koszyk_numer int NOT NULL, 
  zam_data date NOT NULL CHECK (zam_data > '2020-01-01'), 
  id_klienta char(10) NOT NULL,
  PRIMARY KEY (koszyk_numer)
);
ALTER TABLE Koszyki
ADD CONSTRAINT fk_koszyk_kupujacy FOREIGN KEY (id_klienta) REFERENCES Kupujacy(id);

/* Tabela Elementy Koszyka */
CREATE TABLE Elementy_Koszyka 
( 
  id_elementu int NOT NULL,
  koszyk_numer int NOT NULL, 
  prod_id int NOT NULL, 
  ilosc int NOT NULL,
  PRIMARY KEY (id_elementu)
);
ALTER TABLE Elementy_Koszyka
ADD CONSTRAINT fk_koszyk_element FOREIGN KEY (koszyk_numer) REFERENCES Koszyki(koszyk_numer);

/* Tabela Produkty */
CREATE TABLE Produkty 
( 
  prod_id int NOT NULL, 
  prod_nazwa char(255) NOT NULL, 
  prod_cena decimal(8,2) NOT NULL, 
  prod_opis varchar(1000),
  id_dostawcy int NOT NULL,
  PRIMARY KEY (prod_id)
);
ALTER TABLE Elementy_Koszyka
ADD CONSTRAINT fk_element_produkt FOREIGN KEY (prod_id) REFERENCES Produkty(prod_id);

/* Tabela Dostawcy */
CREATE TABLE Dostawcy 
( 
  id_dostawcy int NOT NULL, 
  dost_nazwa char(255) NOT NULL, 
  kraj_dostawy char(255) NOT NULL,
  PRIMARY KEY (id_dostawcy)
);
ALTER TABLE Produkty
ADD CONSTRAINT fk_dostawca_produkt FOREIGN KEY (id_dostawcy) REFERENCES Dostawcy(id_dostawcy);

/* Tabela Sposób Dostawy */
CREATE TABLE Sposob_Dostawy 
(
  id_zamowienia int NOT NULL,
  id_dostawcy int NOT NULL, 
  przewoznik char(255) NOT NULL,
  PRIMARY KEY (id_zamowienia)
);
ALTER TABLE Sposob_Dostawy
ADD CONSTRAINT fk_zamowienia_dostawa FOREIGN KEY (id_zamowienia) REFERENCES Koszyki(koszyk_numer);
ALTER TABLE Sposob_Dostawy
ADD CONSTRAINT fk_dostawcy FOREIGN KEY (id_dostawcy) REFERENCES Dostawcy(id_dostawcy);

/* Przykładowe dane dla tabel */
-- Wstawianie danych do tabeli Kupujący
INSERT INTO Kupujacy(id, imie, nazwisko, adres, miasto, email) VALUES
('1', 'Marcelina', 'Nowak', 'Kwiatowa 17', 'Kraków', 'marcelina.nowak@example.com'),
('2', 'Kacper', 'Kowalski', 'Słoneczna 23', 'Poznań', 'kacper.kowalski@email.pl'),
('3', 'Zofia', 'Jankowska', 'Leśna 8', 'Kraków', 'zofia.jankowska@mail.net'),
('4', 'Oskar', 'Nowicki', 'Rynkowy 12', 'Nowy Sącz', 'oscar_nowicki@example.net'),
('5', 'Alicja', 'Wojciechowska', 'Zielona 5', 'Pułtusk', 'alicja.wojciechowska@email.com'),
('6', 'Bartosz', 'Kaczmarek', 'Dmuchawy 2', 'Bydgoszcz', 'bartosz.kaczmarek@example.pl'),
('7', 'Wiktoria', 'Kowalczyk', 'Parkowa 31', 'Warszawa', 'wiktoria_kowalczyk@mail.net'),
('8', 'Filip', 'Adamczyk', 'Miodowa 7', 'Kraków', 'filip.adamczyk@email.com'),
('9', 'Martyna', 'Szymańska', 'Dębowa 3', 'Szczecin', 'martyna.szymanska@example.pl'),
('10', 'Dawid', 'Pawlak', 'Kwiatowy 14', 'Poznań', 'dawid.pawlak@mail.net');

-- Wstawianie danych do tabeli Koszyki
INSERT INTO Koszyki(koszyk_numer, zam_data, id_klienta) VALUES
(20005, '2023-05-01', '1'),
(20006, '2021-02-11', '2'),
(20007, '2022-02-11', '3'),
(20008, '2023-06-12', '5');

-- Wstawianie danych do tabeli Dostawcy
INSERT INTO Dostawcy(id_dostawcy, dost_nazwa, kraj_dostawy) VALUES
(1, 'WZS', 'Polska'),
(2, 'ABC', 'Holandia');

-- Wstawianie danych do tabeli Produkty
INSERT INTO Produkty(prod_id, prod_nazwa, prod_cena, id_dostawcy) VALUES
(5, 'Kanapa', 725.99, 1),
(12, 'Fotel', 25.99, 1),
(22, 'Lozko', 129.99, 2),
(25, 'Lampa', 2999.99, 1),
(123, 'Szafa', 999.99, 1),
(124, 'Kuchenka', 25.99, 2);

-- Wstawianie danych do tabeli Elementy_Koszyka
INSERT INTO Elementy_Koszyka(id_elementu, koszyk_numer, prod_id, ilosc) VALUES
(1, 20005, 123, 1),
(2, 20005, 124, 1),
(3, 20005, 12, 10),
(4, 20006, 22, 2),
(5, 20007, 22, 3),
(6, 20008, 25, 1),
(7, 20008, 5, 1);

-- Wstawianie danych do tabeli Sposob_Dostawy
INSERT INTO Sposob_Dostawy(id_zamowienia, id_dostawcy, przewoznik) VALUES
(20005, 1, 'Poczta Polska'),
(20006, 1, 'Paczkomat'),
(20007, 2, 'Kurier'),
(20008, 2, 'Paczkomat');

/* Widok: Miasto i liczba kupujących */
CREATE VIEW kupujacy_w_miastach AS
SELECT miasto, COUNT(*) AS liczba_kupujacych
FROM Kupujacy
GROUP BY miasto;

/* Widok: Sprzedaż produktów */
CREATE VIEW sprzedaz_produktow AS
SELECT prod_nazwa, SUM(ilosc) AS zamowiona_ilosc, SUM(prod_cena * ilosc) AS wart_sprzedazy
FROM Elementy_Koszyka ek
JOIN Produkty p ON ek.prod_id = p.prod_id
GROUP BY prod_nazwa;

/* Widok: Przewoźnicy i ilość produktów */
CREATE VIEW przewoznicy_ilosc_produkt AS
SELECT przewoznik, COUNT(DISTINCT id_zamowienia) AS ilosc_zamowien, COUNT(*) AS ilosc_produktow
FROM Sposob_Dostawy sd
JOIN Elementy_Koszyka ek ON sd.id_zamowienia = ek.koszyk_numer
GROUP BY przewoznik;

/* Wyzwalacz/Trigger */
CREATE OR ALTER TRIGGER AktualizacjaPrzewoznika
ON Elementy_Koszyka
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE sd
    SET sd.przewoznik = 'Kurier'
    FROM Sposob_Dostawy sd
    INNER JOIN inserted i ON sd.id_zamowienia = i.koszyk_numer
    WHERE i.ilosc > 5;
END;

/* Testowanie wyzwalacza */
INSERT INTO Koszyki (koszyk_numer, zam_data, id_klienta) VALUES (20009, '2023-05-01', '99');
INSERT INTO Sposob_Dostawy (id_zamowienia, id_dostawcy, przewoznik) VALUES (20009, 1, 'Paczkomat');
INSERT INTO Elementy_Koszyka (id_elementu, koszyk_numer, prod_id, ilosc) VALUES (8, 20009, 5, 55);
SELECT * FROM Sposob_Dostawy;

/* Funkcja: Dane kupującego */
CREATE FUNCTION daneKupujacego(@ID_kupujacego INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        k.id, k.imie, k.nazwisko, ko.zam_data, ek.koszyk_numer, ek.prod_id, ek.ilosc, sd.id_dostawcy, sd.przewoznik
    FROM Kupujacy k
    LEFT JOIN Koszyki ko ON k.id = ko.id_klienta
    LEFT JOIN Elementy_Koszyka ek ON ko.koszyk_numer = ek.koszyk_numer
    LEFT JOIN Sposob_Dostawy sd ON ek.koszyk_numer = sd.id_zamowienia
    WHERE k.id = @ID_kupujacego
);
-- Wywołanie funkcji
SELECT * FROM daneKupujacego(2);

/* Procedura: Aktualizuje lub dodaje kupującego */
CREATE OR ALTER PROCEDURE AktualizujelubDodajeKupujacego
(
    @ID_kupujacego INT,
    @NoweImie NVARCHAR(50),
    @NoweNazwisko NVARCHAR(50),
    @NowyAdres NVARCHAR(50),
    @NoweMiasto NVARCHAR(50),
    @NowyEmail NVARCHAR(100)
)
AS
BEGIN TRY
    BEGIN TRANSACTION;
        IF EXISTS (SELECT 1 FROM Kupujacy WHERE id = @ID_kupujacego)
        BEGIN
            UPDATE Kupujacy
            SET 
                imie = @NoweImie,
                nazwisko = @NoweNazwisko,
                adres = @NowyAdres,
                miasto = @NoweMiasto,
                email = @NowyEmail
            WHERE id = @ID_kupujacego;
        END
        ELSE
        BEGIN
            INSERT INTO Kupujacy (id, imie, nazwisko, adres, miasto, email)
            VALUES (@ID_kupujacego, @NoweImie, @NoweNazwisko, @NowyAdres, @NoweMiasto, @NowyEmail);
        END;
    COMMIT; 
END TRY
BEGIN CATCH
    ROLLBACK;
    SELECT
        ERROR_PROCEDURE() AS ErrorProcedure,
        ERROR_LINE() AS ErrorLine,
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_MESSAGE() AS ErrorMessage;
END CATCH;

-- Wywołanie procedury
EXEC AktualizujelubDodajeKupujacego 123, 'NoweImie', 'NoweNazwisko', 'NowyAdres', 'NoweMiasto', 'nowy@email.com';
-- Sprawdzenie zmian
SELECT * FROM Kupujacy;
