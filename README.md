# Baza danych aukcji internetowych

## Opis projektu
Projekt obejmuje utworzenie bazy danych dla sklepu internetowego zajmującego się aukcjami. Baza danych przechowuje informacje o kupujących, produktach, koszykach zakupowych oraz dostawcach. Zawiera również wyzwalacze i procedury, które automatyzują pewne operacje na danych.

## Struktura bazy danych

### Tabela `Kupujacy`
Przechowuje dane o zarejestrowanych kupujących. Każdy kupujący może, ale nie musi, dokonać transakcji.

- `id`: Identyfikator kupującego
- `imie`: Imię kupującego
- `nazwisko`: Nazwisko kupującego
- `adres`: Adres kupującego
- `miasto`: Miasto, w którym mieszka kupujący
- `email`: Adres e-mail kupującego

### Tabela `Koszyki`
Przechowuje informacje o koszykach zakupowych powiązanych z kupującymi.

- `koszyk_numer`: Identyfikator koszyka
- `zam_data`: Data zamówienia
- `id_klienta`: Identyfikator klienta, który utworzył koszyk

### Tabela `Elementy_Koszyka`
Zawiera informacje o produktach znajdujących się w koszykach zakupowych.

- `id_elementu`: Identyfikator elementu w koszyku
- `koszyk_numer`: Identyfikator koszyka
- `prod_id`: Identyfikator produktu
- `ilosc`: Ilość produktów w koszyku

### Tabela `Produkty`
Zawiera informacje o produktach dostępnych w sklepie.

- `prod_id`: Identyfikator produktu
- `prod_nazwa`: Nazwa produktu
- `prod_cena`: Cena produktu
- `prod_opis`: Opis produktu (opcjonalnie)
- `id_dostawcy`: Identyfikator dostawcy produktu

### Tabela `Dostawcy`
Przechowuje informacje o dostawcach produktów.

- `id_dostawcy`: Identyfikator dostawcy
- `dost_nazwa`: Nazwa dostawcy
- `kraj_dostawy`: Kraj, z którego pochodzi dostawca

### Tabela `Sposob_Dostawy`
Przechowuje informacje o sposobach dostawy wybranych przez klientów.

- `id_zamowienia`: Identyfikator zamówienia
- `id_dostawcy`: Identyfikator dostawcy
- `przewoznik`: Przewoźnik dostarczający zamówienie

## Widoki

- `kupujacy_w_miastach`: Wyświetla liczbę kupujących w poszczególnych miastach.
- `sprzedaz_produktow`: Wyświetla sumaryczną ilość i wartość sprzedaży produktów.
- `przewoznicy_ilosc_produkt`: Wyświetla liczbę zamówień i produktów dla poszczególnych przewoźników.

## Wyzwalacz
- `AktualizacjaPrzewoznika`: Automatycznie zmienia przewoźnika na "Kurier" w przypadku, gdy ilość produktów w koszyku przekracza 5 sztuk.

## Procedura
- `AktualizujelubDodajeKupujacego`: Dodaje nowego kupującego lub aktualizuje dane istniejącego kupującego.

## Instrukcja uruchomienia

1. Skopiuj zawartość pliku SQL do środowiska SQL.
2. Wykonaj skrypt, aby utworzyć strukturę bazy danych i wprowadzić przykładowe dane.
3. Używaj zapytań SQL, aby zarządzać danymi w bazie.

## Wymagania
- SQL Server lub inne kompatybilne środowisko SQL
- Podstawowa znajomość SQL

