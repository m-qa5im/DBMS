CREATE DATABASE CAMS
USE CAMS

-- Create Continent table
CREATE TABLE Continent (
    ContinentID INT PRIMARY KEY IDENTITY (1,1),
    ContinentName VARCHAR(255) NOT NULL
);

-- Stored procedure to insert values into Continent table
CREATE PROCEDURE InsertContinent
    @ContinentName VARCHAR(255)
AS
BEGIN
    INSERT INTO Continent (ContinentName)
    VALUES (@ContinentName);
END;

-- Insert data into Continent table
EXEC InsertContinent 'Asia'
EXEC InsertContinent 'Africa'
EXEC InsertContinent 'Europe'
EXEC InsertContinent 'North America'
EXEC InsertContinent 'South America'

SELECT * FROM Continent


-- Create Country table
CREATE TABLE Country (
    CountryID INT PRIMARY KEY IDENTITY (1,1),
    CountryName VARCHAR(255) NOT NULL,
    TotalPopulation INT,
    ContinentID INT,
    FOREIGN KEY (ContinentID) REFERENCES Continent(ContinentID)
);

-- Stored procedure to insert values into Country table
CREATE PROCEDURE InsertCountry
    @CountryName VARCHAR(255),
    @TotalPopulation INT,
    @ContinentID INT
AS
BEGIN
    INSERT INTO Country (CountryName, TotalPopulation, ContinentID)
    VALUES (@CountryName, @TotalPopulation, @ContinentID);
END


-- Insert data into Country table
EXEC InsertCountry 'China', 1444216107, 1;
EXEC InsertCountry 'Pakistan', 243087662, 1;
EXEC InsertCountry 'Nigeria', 211400708, 2;
EXEC InsertCountry 'South Africa', 60041930, 2;
EXEC InsertCountry 'Germany', 83132799, 3;
EXEC InsertCountry 'France', 65273511, 3;
EXEC InsertCountry 'United States', 332915073, 4;
EXEC InsertCountry 'Canada', 38115509, 4;
EXEC InsertCountry 'Brazil', 213993437, 5;
EXEC InsertCountry 'Argentina', 45785022, 5;
SELECT * FROM Country



CREATE TABLE Region (
    RegionID INT NOT NULL IDENTITY (1,1),
    RegionName VARCHAR(255) NOT NULL,
    Population INT,
    CountryID INT,
);

ALTER TABLE Region
ADD CONSTRAINT PK_Region PRIMARY KEY (RegionID)

ALTER TABLE Region
ADD CONSTRAINT FK_Region_Country FOREIGN KEY (CountryID) REFERENCES Country(CountryID)

-- Stored procedure to insert values into REGION table
CREATE PROCEDURE InsertRegion
    @RegionName VARCHAR(255),
    @Population INT,
    @CountryName VARCHAR(255)
AS
BEGIN
    DECLARE @CountryID INT;

    SELECT @CountryID = CountryID
    FROM Country
    WHERE CountryName = @CountryName;

    INSERT INTO Region (RegionName, Population, CountryID)
    VALUES (@RegionName, @Population, @CountryID);
END;

-- Insert regions for China
EXEC InsertRegion 'Beijing', 21542000, 'China';
EXEC InsertRegion 'Shanghai', 27058479, 'China';
EXEC InsertRegion 'Guangzhou', 14040528, 'China';

-- Insert regions for Pakistan
EXEC InsertRegion 'Karachi', 15741000, 'Pakistan';
EXEC InsertRegion 'Lahore', 12188000, 'Pakistan';
EXEC InsertRegion 'Islamabad', 1095064, 'Pakistan';

-- Insert regions for Nigeria
EXEC InsertRegion 'Lagos', 14040000, 'Nigeria';
EXEC InsertRegion 'Kano', 3666068, 'Nigeria';
EXEC InsertRegion 'Ibadan', 3389825, 'Nigeria';

-- Insert regions for South Africa
EXEC InsertRegion 'Johannesburg', 5796010, 'South Africa';
EXEC InsertRegion 'Cape Town', 4336884, 'South Africa';
EXEC InsertRegion 'Durban', 3442361, 'South Africa';

-- Insert regions for Germany
EXEC InsertRegion 'Berlin', 3769495, 'Germany';
EXEC InsertRegion 'Hamburg', 1841179, 'Germany';
EXEC InsertRegion 'Munich', 1471508, 'Germany';

-- Insert regions for France
EXEC InsertRegion 'Paris', 2140526, 'France';
EXEC InsertRegion 'Marseille', 863310, 'France';
EXEC InsertRegion 'Lyon', 515695, 'France';

-- Insert regions for the United States
EXEC InsertRegion 'New York', 19453561, 'United States';
EXEC InsertRegion 'Los Angeles', 12936097, 'United States';
EXEC InsertRegion 'Chicago', 2695598, 'United States';

-- Insert regions for Canada
EXEC InsertRegion 'Toronto', 2731571, 'Canada';
EXEC InsertRegion 'Montreal', 1829949, 'Canada';
EXEC InsertRegion 'Vancouver', 631486, 'Canada';

-- Insert regions for Brazil
EXEC InsertRegion 'Sao Paulo', 12252023, 'Brazil';
EXEC InsertRegion 'Rio de Janeiro', 6747815, 'Brazil';
EXEC InsertRegion 'Brasilia', 3055149, 'Brazil';

-- Insert regions for Argentina
EXEC InsertRegion 'Buenos Aires', 15354917, 'Argentina';
EXEC InsertRegion 'Cordoba', 1391007, 'Argentina';
EXEC InsertRegion 'Rosario', 1305201, 'Argentina';

SELECT * FROM Region

-- Create DailyCovid19Reports table
CREATE TABLE DailyCovid19Reports (
    ReportID INT NOT NULL IDENTITY (1,1),
    Date DATE NOT NULL,
    TotalCases INT,
    TotalDeaths INT,
    TotalRecoveries INT,
    RegionID INT
)

ALTER TABLE DailyCovid19Reports
ADD CONSTRAINT PK_DailyCovid19Reports PRIMARY KEY (ReportID)

ALTER TABLE DailyCovid19Reports
ADD CONSTRAINT FK_DailyCovid19Reports_Region FOREIGN KEY (RegionID) REFERENCES Region(RegionID)

-- Stored procedure to insert values into DailyCovid19Report table

CREATE PROCEDURE InsertDailyCovid19Report
    @Date DATE,
    @TotalCases INT,
    @TotalDeaths INT,
    @TotalRecoveries INT,
    @RegionName VARCHAR(255)
AS
BEGIN
    DECLARE @RegionID INT;

    -- Get the RegionID based on the provided RegionName
    SELECT @RegionID = RegionID
    FROM Region
    WHERE RegionName = @RegionName;

    -- Insert into DailyCovid19Reports table
    INSERT INTO DailyCovid19Reports (Date, TotalCases, TotalDeaths, TotalRecoveries, RegionID)
    VALUES (@Date, @TotalCases, @TotalDeaths, @TotalRecoveries, @RegionID);
END;

-- Insert reports for Beijing (RegionID = 1)
EXEC InsertDailyCovid19Report '2023-02-01', 120, 7, 100, 'Beijing';
EXEC InsertDailyCovid19Report '2023-02-02', 130, 8, 110, 'Beijing';
EXEC InsertDailyCovid19Report '2023-02-03', 140, 9, 120, 'Beijing';
EXEC InsertDailyCovid19Report '2023-02-04', 150, 10, 130, 'Beijing';
EXEC InsertDailyCovid19Report '2023-02-05', 160, 11, 140, 'Beijing';
-- Insert reports for Shanghai (RegionID = 2)
EXEC InsertDailyCovid19Report '2023-02-01', 45, 3, 40, 'Shanghai';
EXEC InsertDailyCovid19Report '2023-02-02', 50, 4, 45, 'Shanghai';
EXEC InsertDailyCovid19Report '2023-02-03', 55, 5, 50, 'Shanghai';
EXEC InsertDailyCovid19Report '2023-02-04', 60, 6, 55, 'Shanghai';
EXEC InsertDailyCovid19Report '2023-02-05', 65, 7, 60, 'Shanghai';
-- Insert reports for Guangzhou (RegionID = 3)
EXEC InsertDailyCovid19Report '2023-02-01', 75, 4, 70, 'Guangzhou';
EXEC InsertDailyCovid19Report '2023-02-02', 80, 5, 75, 'Guangzhou';
EXEC InsertDailyCovid19Report '2023-02-03', 85, 6, 80, 'Guangzhou';
EXEC InsertDailyCovid19Report '2023-02-04', 90, 7, 85, 'Guangzhou';
EXEC InsertDailyCovid19Report '2023-02-05', 95, 8, 90, 'Guangzhou';
-- Insert reports for Karachi (RegionID = 4)
EXEC InsertDailyCovid19Report '2023-02-01', 55, 2, 50, 'Karachi';
EXEC InsertDailyCovid19Report '2023-02-02', 60, 3, 55, 'Karachi';
EXEC InsertDailyCovid19Report '2023-02-03', 65, 4, 60, 'Karachi';
EXEC InsertDailyCovid19Report '2023-02-04', 70, 5, 65, 'Karachi';
EXEC InsertDailyCovid19Report '2023-02-05', 75, 6, 70, 'Karachi';

-- Insert reports for Lahore (RegionID = 5)
EXEC InsertDailyCovid19Report '2023-02-01', 85, 5, 80, 'Lahore';
EXEC InsertDailyCovid19Report '2023-02-02', 90, 6, 85, 'Lahore';
EXEC InsertDailyCovid19Report '2023-02-03', 95, 7, 90, 'Lahore';
EXEC InsertDailyCovid19Report '2023-02-04', 100, 8, 95, 'Lahore';
EXEC InsertDailyCovid19Report '2023-02-05', 105, 9, 100, 'Lahore';

-- Insert reports for Islamabad (RegionID = 6)
EXEC InsertDailyCovid19Report '2023-02-01', 65, 3, 60, 'Islamabad';
EXEC InsertDailyCovid19Report '2023-02-02', 70, 4, 65, 'Islamabad';
EXEC InsertDailyCovid19Report '2023-02-03', 75, 5, 70, 'Islamabad';
EXEC InsertDailyCovid19Report '2023-02-04', 80, 6, 75, 'Islamabad';
EXEC InsertDailyCovid19Report '2023-02-05', 85, 7, 80, 'Islamabad';
-- Insert reports for Lagos (RegionID = 7)
EXEC InsertDailyCovid19Report '2023-02-01', 75, 4, 70, 'Lagos';
EXEC InsertDailyCovid19Report '2023-02-02', 80, 5, 75, 'Lagos';
EXEC InsertDailyCovid19Report '2023-02-03', 85, 6, 80, 'Lagos';
EXEC InsertDailyCovid19Report '2023-02-04', 90, 7, 85, 'Lagos';
EXEC InsertDailyCovid19Report '2023-02-05', 95, 8, 90, 'Lagos';

-- Insert reports for Kano (RegionID = 8)
EXEC InsertDailyCovid19Report '2023-02-01', 55, 3, 50, 'Kano';
EXEC InsertDailyCovid19Report '2023-02-02', 60, 4, 55, 'Kano';
EXEC InsertDailyCovid19Report '2023-02-03', 65, 5, 60, 'Kano';
EXEC InsertDailyCovid19Report '2023-02-04', 70, 6, 65, 'Kano';
EXEC InsertDailyCovid19Report '2023-02-05', 75, 7, 70, 'Kano';

-- Insert reports for Ibadan (RegionID = 9)
EXEC InsertDailyCovid19Report '2023-02-01', 45, 2, 40, 'Ibadan';
EXEC InsertDailyCovid19Report '2023-02-02', 50, 3, 45, 'Ibadan';
EXEC InsertDailyCovid19Report '2023-02-03', 55, 4, 50, 'Ibadan';
EXEC InsertDailyCovid19Report '2023-02-04', 60, 5, 55, 'Ibadan';
EXEC InsertDailyCovid19Report '2023-02-05', 65, 6, 60, 'Ibadan';

-- Insert reports for Johannesburg (RegionID = 10)
EXEC InsertDailyCovid19Report '2023-02-01', 110, 6, 100, 'Johannesburg';
EXEC InsertDailyCovid19Report '2023-02-02', 120, 7, 110, 'Johannesburg';
EXEC InsertDailyCovid19Report '2023-02-03', 130, 8, 120, 'Johannesburg';
EXEC InsertDailyCovid19Report '2023-02-04', 140, 9, 130, 'Johannesburg';
EXEC InsertDailyCovid19Report '2023-02-05', 150, 10, 140, 'Johannesburg';

-- Insert reports for Cape Town (RegionID = 11)
EXEC InsertDailyCovid19Report '2023-02-01', 70, 4, 65, 'Cape Town';
EXEC InsertDailyCovid19Report '2023-02-02', 75, 5, 70, 'Cape Town';
EXEC InsertDailyCovid19Report '2023-02-03', 80, 6, 75, 'Cape Town';
EXEC InsertDailyCovid19Report '2023-02-04', 85, 7, 80, 'Cape Town';
EXEC InsertDailyCovid19Report '2023-02-05', 90, 8, 85, 'Cape Town';

-- Insert reports for Durban (RegionID = 12)
EXEC InsertDailyCovid19Report '2023-02-01', 50, 2, 45, 'Durban';
EXEC InsertDailyCovid19Report '2023-02-02', 55, 3, 50, 'Durban';
EXEC InsertDailyCovid19Report '2023-02-03', 60, 4, 55, 'Durban';
EXEC InsertDailyCovid19Report '2023-02-04', 65, 5, 60, 'Durban';
EXEC InsertDailyCovid19Report '2023-02-05', 70, 6, 65, 'Durban';

-- Insert reports for Berlin (RegionID = 13)
EXEC InsertDailyCovid19Report '2023-02-01', 65, 4, 60, 'Berlin';
EXEC InsertDailyCovid19Report '2023-02-02', 70, 5, 65, 'Berlin';
EXEC InsertDailyCovid19Report '2023-02-03', 75, 6, 70, 'Berlin';
EXEC InsertDailyCovid19Report '2023-02-04', 80, 7, 75, 'Berlin';
EXEC InsertDailyCovid19Report '2023-02-05', 85, 8, 80, 'Berlin';

-- Insert reports for Hamburg (RegionID = 14)
EXEC InsertDailyCovid19Report '2023-02-01', 100, 7, 90, 'Hamburg';
EXEC InsertDailyCovid19Report '2023-02-02', 110, 8, 100, 'Hamburg';
EXEC InsertDailyCovid19Report '2023-02-03', 120, 9, 110, 'Hamburg';
EXEC InsertDailyCovid19Report '2023-02-04', 130, 10, 120, 'Hamburg';
EXEC InsertDailyCovid19Report '2023-02-05', 140, 11, 130, 'Hamburg';

-- Insert reports for Munich (RegionID = 15)
EXEC InsertDailyCovid19Report '2023-02-01', 60, 3, 55, 'Munich';
EXEC InsertDailyCovid19Report '2023-02-02', 65, 4, 60, 'Munich';
EXEC InsertDailyCovid19Report '2023-02-03', 70, 5, 65, 'Munich';
EXEC InsertDailyCovid19Report '2023-02-04', 75, 6, 70, 'Munich';
EXEC InsertDailyCovid19Report '2023-02-05', 80, 7, 75, 'Munich';
-- Insert reports for Paris (RegionID = 16)
EXEC InsertDailyCovid19Report '2023-02-01', 85, 5, 80, 'Paris';
EXEC InsertDailyCovid19Report '2023-02-02', 90, 6, 85, 'Paris';
EXEC InsertDailyCovid19Report '2023-02-03', 95, 7, 90, 'Paris';
EXEC InsertDailyCovid19Report '2023-02-04', 100, 8, 95, 'Paris';
EXEC InsertDailyCovid19Report '2023-02-05', 105, 9, 100, 'Paris';

-- Insert reports for Marseille (RegionID = 17)
EXEC InsertDailyCovid19Report '2023-02-01', 60, 3, 55, 'Marseille';
EXEC InsertDailyCovid19Report '2023-02-02', 65, 4, 60, 'Marseille';
EXEC InsertDailyCovid19Report '2023-02-03', 70, 5, 65, 'Marseille';
EXEC InsertDailyCovid19Report '2023-02-04', 75, 6, 70, 'Marseille';
EXEC InsertDailyCovid19Report '2023-02-05', 80, 7, 75, 'Marseille';

-- Insert reports for Lyon (RegionID = 18)
EXEC InsertDailyCovid19Report '2023-02-01', 80, 5, 70, 'Lyon';
EXEC InsertDailyCovid19Report '2023-02-02', 85, 6, 75, 'Lyon';
EXEC InsertDailyCovid19Report '2023-02-03', 90, 7, 80, 'Lyon';
EXEC InsertDailyCovid19Report '2023-02-04', 95, 8, 85, 'Lyon';
EXEC InsertDailyCovid19Report '2023-02-05', 100, 9, 90, 'Lyon';

-- Insert reports for New York (RegionID = 19)
EXEC InsertDailyCovid19Report '2023-02-01', 55, 2, 50, 'New York';
EXEC InsertDailyCovid19Report '2023-02-02', 60, 3, 55, 'New York';
EXEC InsertDailyCovid19Report '2023-02-03', 65, 4, 60, 'New York';
EXEC InsertDailyCovid19Report '2023-02-04', 70, 5, 65, 'New York';
EXEC InsertDailyCovid19Report '2023-02-05', 75, 6, 70, 'New York';

-- Insert reports for Los Angeles (RegionID = 20)
EXEC InsertDailyCovid19Report '2023-02-01', 65, 4, 60, 'Los Angeles';
EXEC InsertDailyCovid19Report '2023-02-02', 70, 5, 65, 'Los Angeles';
EXEC InsertDailyCovid19Report '2023-02-03', 75, 6, 70, 'Los Angeles';
EXEC InsertDailyCovid19Report '2023-02-04', 80, 7, 75, 'Los Angeles';
EXEC InsertDailyCovid19Report '2023-02-05', 85, 8, 80, 'Los Angeles';

-- Insert reports for Chicago (RegionID = 21)
EXEC InsertDailyCovid19Report '2023-02-01', 95, 8, 85, 'Chicago';
EXEC InsertDailyCovid19Report '2023-02-02', 100, 9, 90, 'Chicago';
EXEC InsertDailyCovid19Report '2023-02-03', 105, 10, 95, 'Chicago';
EXEC InsertDailyCovid19Report '2023-02-04', 110, 11, 100, 'Chicago';
EXEC InsertDailyCovid19Report '2023-02-05', 115, 12, 105, 'Chicago';

-- Insert reports for Toronto (RegionID = 22)
EXEC InsertDailyCovid19Report '2023-02-01', 60, 3, 55, 'Toronto';
EXEC InsertDailyCovid19Report '2023-02-02', 65, 4, 60, 'Toronto';
EXEC InsertDailyCovid19Report '2023-02-03', 70, 5, 65, 'Toronto';
EXEC InsertDailyCovid19Report '2023-02-04', 75, 6, 70, 'Toronto';
EXEC InsertDailyCovid19Report '2023-02-05', 80, 7, 75, 'Toronto';

-- Insert reports for Montreal (RegionID = 23)
EXEC InsertDailyCovid19Report '2023-02-01', 85, 7, 80, 'Montreal';
EXEC InsertDailyCovid19Report '2023-02-02', 90, 8, 85, 'Montreal';
EXEC InsertDailyCovid19Report '2023-02-03', 95, 9, 90, 'Montreal';
EXEC InsertDailyCovid19Report '2023-02-04', 100, 10, 95, 'Montreal';
EXEC InsertDailyCovid19Report '2023-02-05', 105, 11, 100, 'Montreal';

-- Insert reports for Vancouver (RegionID = 24)
EXEC InsertDailyCovid19Report '2023-02-01', 110, 8, 100, 'Vancouver';
EXEC InsertDailyCovid19Report '2023-02-02', 120, 9, 110, 'Vancouver';
EXEC InsertDailyCovid19Report '2023-02-03', 130, 10, 120, 'Vancouver';
EXEC InsertDailyCovid19Report '2023-02-04', 140, 11, 130, 'Vancouver';
EXEC InsertDailyCovid19Report '2023-02-05', 150, 12, 140, 'Vancouver';

-- Insert reports for Sao Paulo (RegionID = 25)
EXEC InsertDailyCovid19Report '2023-02-01', 70, 5, 65, 'Sao Paulo';
EXEC InsertDailyCovid19Report '2023-02-02', 75, 6, 70, 'Sao Paulo';
EXEC InsertDailyCovid19Report '2023-02-03', 80, 7, 75, 'Sao Paulo';
EXEC InsertDailyCovid19Report '2023-02-04', 85, 8, 80, 'Sao Paulo';
EXEC InsertDailyCovid19Report '2023-02-05', 90, 9, 85, 'Sao Paulo';

-- Insert reports for Rio de Janeiro (RegionID = 26)
EXEC InsertDailyCovid19Report '2023-02-01', 100, 7, 90, 'Rio de Janeiro';
EXEC InsertDailyCovid19Report '2023-02-02', 110, 8, 100, 'Rio de Janeiro';
EXEC InsertDailyCovid19Report '2023-02-03', 120, 9, 110, 'Rio de Janeiro';
EXEC InsertDailyCovid19Report '2023-02-04', 130, 10, 120, 'Rio de Janeiro';
EXEC InsertDailyCovid19Report '2023-02-05', 140, 11, 130, 'Rio de Janeiro';

-- Insert reports for Brasilia (RegionID = 27)
EXEC InsertDailyCovid19Report '2023-02-01', 60, 4, 55, 'Brasilia';
EXEC InsertDailyCovid19Report '2023-02-02', 65, 5, 60, 'Brasilia';
EXEC InsertDailyCovid19Report '2023-02-03', 70, 6, 65, 'Brasilia';
EXEC InsertDailyCovid19Report '2023-02-04', 75, 7, 70, 'Brasilia';
EXEC InsertDailyCovid19Report '2023-02-05', 80, 8, 75, 'Brasilia';

-- Insert reports for Buenos Aires (RegionID = 28)
EXEC InsertDailyCovid19Report '2023-02-01', 90, 6, 80, 'Buenos Aires';
EXEC InsertDailyCovid19Report '2023-02-02', 95, 7, 85, 'Buenos Aires';
EXEC InsertDailyCovid19Report '2023-02-03', 100, 8, 90, 'Buenos Aires';
EXEC InsertDailyCovid19Report '2023-02-04', 105, 9, 95, 'Buenos Aires';
EXEC InsertDailyCovid19Report '2023-02-05', 110, 10, 100, 'Buenos Aires';

-- Insert reports for Cordoba (RegionID = 29)
EXEC InsertDailyCovid19Report '2023-02-01', 50, 3, 45, 'Cordoba';
EXEC InsertDailyCovid19Report '2023-02-02', 55, 4, 50, 'Cordoba';
EXEC InsertDailyCovid19Report '2023-02-03', 60, 5, 55, 'Cordoba';
EXEC InsertDailyCovid19Report '2023-02-04', 65, 6, 60, 'Cordoba';
EXEC InsertDailyCovid19Report '2023-02-05', 70, 7, 65, 'Cordoba';

-- Insert reports for Rosario (RegionID = 30)
EXEC InsertDailyCovid19Report '2023-02-01', 80, 5, 70, 'Rosario';
EXEC InsertDailyCovid19Report '2023-02-02', 85, 6, 75, 'Rosario';
EXEC InsertDailyCovid19Report '2023-02-03', 90, 7, 80, 'Rosario';
EXEC InsertDailyCovid19Report '2023-02-04', 95, 8, 85, 'Rosario';
EXEC InsertDailyCovid19Report '2023-02-05', 100, 9, 90, 'Rosario';

SELECT * FROM DailyCovid19Reports;


CREATE TABLE VaccinationData (
    VaccinationID INT PRIMARY KEY IDENTITY(1,1),
    Date DATE NOT NULL,
    TotalVaccinations INT,
    RegionID INT,
    FOREIGN KEY (RegionID) REFERENCES Region(RegionID)
);

-- Stored procedure to insert values into VaccinationData  table
CREATE PROCEDURE InsertVaccinationData
    @Date DATE,
    @TotalVaccinations INT,
    @RegionName VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @RegionID INT;

    SELECT @RegionID = RegionID
    FROM Region
    WHERE RegionName = @RegionName;

    INSERT INTO VaccinationData (Date, TotalVaccinations, RegionID)
    VALUES (@Date, @TotalVaccinations, @RegionID);
END;

-- Insert data for RegionID = 1
EXEC InsertVaccinationData '2023-02-01', 1200, 'Beijing';
EXEC InsertVaccinationData '2023-02-02', 1600, 'Beijing';
EXEC InsertVaccinationData '2023-02-03', 2000, 'Beijing';

-- Insert data for RegionID = 2
EXEC InsertVaccinationData '2023-02-01', 1700, 'Shanghai';
EXEC InsertVaccinationData '2023-02-02', 2100, 'Shanghai';
EXEC InsertVaccinationData '2023-02-03', 2500, 'Shanghai';

-- Insert data for RegionID = 3
EXEC InsertVaccinationData '2023-02-01', 2200, 'Guangzhou';
EXEC InsertVaccinationData '2023-02-02', 2600, 'Guangzhou';
EXEC InsertVaccinationData '2023-02-03', 3000, 'Guangzhou';

-- Insert data for RegionID = 4
EXEC InsertVaccinationData '2023-02-01', 2800, 'Karachi';
EXEC InsertVaccinationData '2023-02-02', 3200, 'Karachi';
EXEC InsertVaccinationData '2023-02-03', 3600, 'Karachi';

-- Insert data for RegionID = 5
EXEC InsertVaccinationData '2023-02-01', 3300, 'Lahore';
EXEC InsertVaccinationData '2023-02-02', 3700, 'Lahore';
EXEC InsertVaccinationData '2023-02-03', 4100, 'Lahore';

-- Insert data for RegionID = 6
EXEC InsertVaccinationData '2023-02-01', 1800, 'Islamabad';
EXEC InsertVaccinationData '2023-02-02', 2200, 'Islamabad';
EXEC InsertVaccinationData '2023-02-03', 2600, 'Islamabad';

-- Insert data for RegionID = 7
EXEC InsertVaccinationData '2023-02-01', 2400, 'Lagos';
EXEC InsertVaccinationData '2023-02-02', 2800, 'Lagos';
EXEC InsertVaccinationData '2023-02-03', 3200, 'Lagos';

-- Insert data for RegionID = 8
EXEC InsertVaccinationData '2023-02-01', 3000, 'Kano';
EXEC InsertVaccinationData '2023-02-02', 3400, 'Kano';
EXEC InsertVaccinationData '2023-02-03', 3800, 'Kano';
-- Insert data for Ibadan (RegionID = 9)
EXEC InsertVaccinationData '2023-02-01', 1000, 'Ibadan';
EXEC InsertVaccinationData '2023-02-02', 1500, 'Ibadan';
EXEC InsertVaccinationData '2023-02-03', 2000, 'Ibadan';

-- Insert data for Johannesburg (RegionID = 10)
EXEC InsertVaccinationData '2023-02-01', 2000, 'Johannesburg';
EXEC InsertVaccinationData '2023-02-02', 2500, 'Johannesburg';
EXEC InsertVaccinationData '2023-02-03', 3000, 'Johannesburg';

-- Insert data for Cape Town (RegionID = 11)
EXEC InsertVaccinationData '2023-02-01', 1500, 'Cape Town';
EXEC InsertVaccinationData '2023-02-02', 1800, 'Cape Town';
EXEC InsertVaccinationData '2023-02-03', 2200, 'Cape Town';

-- Insert data for Durban (RegionID = 12)
EXEC InsertVaccinationData '2023-02-01', 1200, 'Durban';
EXEC InsertVaccinationData '2023-02-02', 1700, 'Durban';
EXEC InsertVaccinationData '2023-02-03', 2100, 'Durban';

-- Insert data for Berlin (RegionID = 13)
EXEC InsertVaccinationData '2023-02-01', 1800, 'Berlin';
EXEC InsertVaccinationData '2023-02-02', 2200, 'Berlin';
EXEC InsertVaccinationData '2023-02-03', 2600, 'Berlin';

-- Insert data for Hamburg (RegionID = 14)
EXEC InsertVaccinationData '2023-02-01', 2500, 'Hamburg';
EXEC InsertVaccinationData '2023-02-02', 2900, 'Hamburg';
EXEC InsertVaccinationData '2023-02-03', 3300, 'Hamburg';

-- Insert data for Munich (RegionID = 15)
EXEC InsertVaccinationData '2023-02-01', 1400, 'Munich';
EXEC InsertVaccinationData '2023-02-02', 1800, 'Munich';
EXEC InsertVaccinationData '2023-02-03', 2200, 'Munich';

-- Insert data for Paris (RegionID = 16)
EXEC InsertVaccinationData '2023-02-01', 2000, 'Paris';
EXEC InsertVaccinationData '2023-02-02', 2400, 'Paris';
EXEC InsertVaccinationData '2023-02-03', 2800, 'Paris';

-- Insert data for Marseille (RegionID = 17)
EXEC InsertVaccinationData '2023-02-01', 1200, 'Marseille';
EXEC InsertVaccinationData '2023-02-02', 1600, 'Marseille';
EXEC InsertVaccinationData '2023-02-03', 2000, 'Marseille';

-- Insert data for Lyon (RegionID = 18)
EXEC InsertVaccinationData '2023-02-01', 1700, 'Lyon';
EXEC InsertVaccinationData '2023-02-02', 2100, 'Lyon';
EXEC InsertVaccinationData '2023-02-03', 2500, 'Lyon';

-- Insert data for New York (RegionID = 19)
EXEC InsertVaccinationData '2023-02-01', 2200, 'New York';
EXEC InsertVaccinationData '2023-02-02', 2600, 'New York';
EXEC InsertVaccinationData '2023-02-03', 3000, 'New York';

-- Insert data for Los Angeles (RegionID = 20)
EXEC InsertVaccinationData '2023-02-01', 2800, 'Los Angeles';
EXEC InsertVaccinationData '2023-02-02', 3200, 'Los Angeles';
EXEC InsertVaccinationData '2023-02-03', 3600, 'Los Angeles';

-- Insert data for Chicago (RegionID = 21)
EXEC InsertVaccinationData '2023-02-01', 3300, 'Chicago';
EXEC InsertVaccinationData '2023-02-02', 3700, 'Chicago';
EXEC InsertVaccinationData '2023-02-03', 4100, 'Chicago';

-- Insert data for Toronto (RegionID = 22)
EXEC InsertVaccinationData '2023-02-01', 1800, 'Toronto';
EXEC InsertVaccinationData '2023-02-02', 2200, 'Toronto';
EXEC InsertVaccinationData '2023-02-03', 2600, 'Toronto';

-- Insert data for Montreal (RegionID = 23)
EXEC InsertVaccinationData '2023-02-01', 2400, 'Montreal';
EXEC InsertVaccinationData '2023-02-02', 2800, 'Montreal';
EXEC InsertVaccinationData '2023-02-03', 3200, 'Montreal';

-- Insert data for Vancouver (RegionID = 24)
EXEC InsertVaccinationData '2023-02-01', 3000, 'Vancouver';
EXEC InsertVaccinationData '2023-02-02', 3400, 'Vancouver';
EXEC InsertVaccinationData '2023-02-03', 3800, 'Vancouver';

-- Insert data for Sao Paulo (RegionID = 25)
EXEC InsertVaccinationData '2023-02-01', 2000, 'Sao Paulo';
EXEC InsertVaccinationData '2023-02-02', 2400, 'Sao Paulo';
EXEC InsertVaccinationData '2023-02-03', 2800, 'Sao Paulo';

-- Insert data for Rio de Janeiro (RegionID = 26)
EXEC InsertVaccinationData '2023-02-01', 2600, 'Rio de Janeiro';
EXEC InsertVaccinationData '2023-02-02', 3000, 'Rio de Janeiro';
EXEC InsertVaccinationData '2023-02-03', 3400, 'Rio de Janeiro';

-- Insert data for Brasilia (RegionID = 27)
EXEC InsertVaccinationData '2023-02-01', 1500, 'Brasilia';
EXEC InsertVaccinationData '2023-02-02', 1900, 'Brasilia';
EXEC InsertVaccinationData '2023-02-03', 2300, 'Brasilia';

-- Insert data for Buenos Aires (RegionID = 28)
EXEC InsertVaccinationData '2023-02-01', 2100, 'Buenos Aires';
EXEC InsertVaccinationData '2023-02-02', 2500, 'Buenos Aires';
EXEC InsertVaccinationData '2023-02-03', 2900, 'Buenos Aires';

-- Insert data for Cordoba (RegionID = 29)
EXEC InsertVaccinationData '2023-02-01', 1200, 'Cordoba';
EXEC InsertVaccinationData '2023-02-02', 1600, 'Cordoba';
EXEC InsertVaccinationData '2023-02-03', 2000, 'Cordoba';

-- Insert data for Rosario (RegionID = 30)
EXEC InsertVaccinationData '2023-02-01', 1700, 'Rosario';
EXEC InsertVaccinationData '2023-02-02', 2100, 'Rosario';
EXEC InsertVaccinationData '2023-02-03', 2500, 'Rosario';

SELECT * FROM VaccinationData



-- Create TestingData table
CREATE TABLE TestingData (
    TestingID INT PRIMARY KEY IDENTITY (1,1),
    Date DATE NOT NULL,
    TotalTests INT,
    PositiveTests INT,
    RegionID INT,
    FOREIGN KEY (RegionID) REFERENCES Region(RegionID)
);

-- Create stored procedure for inserting data into TestingData

CREATE PROCEDURE InsertTestingData
    @Date DATE,
    @TotalTests INT,
    @PositiveTests INT,
    @RegionName VARCHAR(50)
AS
BEGIN
    DECLARE @RegionID INT;

    -- Get RegionID based on RegionName
    SELECT @RegionID = RegionID FROM Region WHERE RegionName = @RegionName;

    -- Insert data into TestingData
    INSERT INTO TestingData (Date, TotalTests, PositiveTests, RegionID)
    VALUES (@Date, @TotalTests, @PositiveTests, @RegionID);
END


-- Testing Data for Region 1 (China)
EXEC InsertTestingData '2023-02-01', 1000, 100, 'Beijing';
EXEC InsertTestingData '2023-02-02', 1200, 120, 'Beijing';

EXEC InsertTestingData '2023-02-01', 1100, 110, 'Shanghai';
EXEC InsertTestingData '2023-02-02', 1300, 130, 'Shanghai';

EXEC InsertTestingData '2023-02-01', 900, 90, 'Guangzhou';
EXEC InsertTestingData '2023-02-02', 1000, 100, 'Guangzhou';

-- Testing Data for Region 2 (Pakistan)
EXEC InsertTestingData '2023-02-01', 800, 80, 'Karachi';
EXEC InsertTestingData '2023-02-02', 900, 90, 'Karachi';

EXEC InsertTestingData '2023-02-01', 750, 75, 'Lahore';
EXEC InsertTestingData '2023-02-02', 850, 85, 'Lahore';

EXEC InsertTestingData '2023-02-01', 700, 70, 'Islamabad';
EXEC InsertTestingData '2023-02-02', 800, 80, 'Islamabad';

-- Testing Data for Region 3 (Nigeria)
EXEC InsertTestingData '2023-02-01', 600, 60, 'Lagos';
EXEC InsertTestingData '2023-02-02', 700, 70, 'Lagos';

EXEC InsertTestingData '2023-02-01', 550, 55, 'Kano';
EXEC InsertTestingData '2023-02-02', 650, 65, 'Kano';

EXEC InsertTestingData '2023-02-01', 500, 50, 'Ibadan';
EXEC InsertTestingData '2023-02-02', 600, 60, 'Ibadan';

-- Testing Data for Region 4 (South Africa)
EXEC InsertTestingData '2023-02-01', 1100, 110, 'Johannesburg';
EXEC InsertTestingData '2023-02-02', 1200, 120, 'Johannesburg';

EXEC InsertTestingData '2023-02-01', 1000, 100, 'Cape Town';
EXEC InsertTestingData '2023-02-02', 1100, 110, 'Cape Town';

EXEC InsertTestingData '2023-02-01', 900, 90, 'Durban';
EXEC InsertTestingData '2023-02-02', 1000, 100, 'Durban';

-- Testing Data for Region 5 (Germany)
EXEC InsertTestingData '2023-02-01', 800, 80, 'Berlin';
EXEC InsertTestingData '2023-02-02', 900, 90, 'Berlin';

EXEC InsertTestingData '2023-02-01', 700, 70, 'Hamburg';
EXEC InsertTestingData '2023-02-02', 800, 80, 'Hamburg';

EXEC InsertTestingData '2023-02-01', 600, 60, 'Munich';
EXEC InsertTestingData '2023-02-02', 700, 70, 'Munich';

-- Testing Data for Region 6 (France)
EXEC InsertTestingData '2023-02-01', 500, 50, 'Paris';
EXEC InsertTestingData '2023-02-02', 600, 60, 'Paris';

EXEC InsertTestingData '2023-02-01', 450, 45, 'Marseille';
EXEC InsertTestingData '2023-02-02', 550, 55, 'Marseille';

EXEC InsertTestingData '2023-02-01', 400, 40, 'Lyon';
EXEC InsertTestingData '2023-02-02', 500, 50, 'Lyon';

-- Testing Data for Region 7 (United States)
EXEC InsertTestingData '2023-02-01', 900, 90, 'New York';
EXEC InsertTestingData '2023-02-02', 1000, 100, 'New York';

EXEC InsertTestingData '2023-02-01', 800, 80, 'Los Angeles';
EXEC InsertTestingData '2023-02-02', 900, 90, 'Los Angeles';

EXEC InsertTestingData '2023-02-01', 700, 70, 'Chicago';
EXEC InsertTestingData '2023-02-02', 800, 80, 'Chicago';

-- Testing Data for Region 8 (Canada)
EXEC InsertTestingData '2023-02-01', 600, 60, 'Toronto';
EXEC InsertTestingData '2023-02-02', 700, 70, 'Toronto';

EXEC InsertTestingData '2023-02-01', 500, 50, 'Montreal';
EXEC InsertTestingData '2023-02-02', 600, 60, 'Montreal';

EXEC InsertTestingData '2023-02-01', 450, 45, 'Vancouver';
EXEC InsertTestingData '2023-02-02', 550, 55, 'Vancouver';

-- Testing Data for Region 9 (Brazil)
EXEC InsertTestingData '2023-02-01', 700, 70, 'Sao Paulo';
EXEC InsertTestingData '2023-02-02', 800, 80, 'Sao Paulo';

EXEC InsertTestingData '2023-02-01', 600, 60, 'Rio de Janeiro';
EXEC InsertTestingData '2023-02-02', 700, 70, 'Rio de Janeiro';

EXEC InsertTestingData '2023-02-01', 500, 50, 'Brasilia';
EXEC InsertTestingData '2023-02-02', 600, 60, 'Brasilia';

-- Testing Data for Region 10 (Argentina)
EXEC InsertTestingData '2023-02-01', 400, 40, 'Buenos Aires';
EXEC InsertTestingData '2023-02-02', 500, 50, 'Buenos Aires';

EXEC InsertTestingData '2023-02-01', 350, 35, 'Cordoba';
EXEC InsertTestingData '2023-02-02', 450, 45, 'Cordoba';

EXEC InsertTestingData '2023-02-01', 300, 30, 'Rosario';
EXEC InsertTestingData '2023-02-02', 400, 40, 'Rosario';

SELECT * FROM TestingData

-- Create PublicHealthMeasures table
CREATE TABLE PublicHealthMeasures (
    MeasuresID INT PRIMARY KEY IDENTITY (1,1),
    MeasureType VARCHAR(255) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    RegionID INT,
    FOREIGN KEY (RegionID) REFERENCES Region(RegionID)
);

CREATE PROCEDURE InsertPublicHealthMeasures
    @MeasureType VARCHAR(255),
    @StartDate DATE,
    @EndDate DATE,
    @RegionName VARCHAR(255)
AS
BEGIN
    DECLARE @RegionID INT;

    -- Get the RegionID based on the RegionName
    SELECT @RegionID = RegionID
    FROM Region
    WHERE RegionName = @RegionName;

    -- Insert data into PublicHealthMeasures
    INSERT INTO PublicHealthMeasures (MeasureType, StartDate, EndDate, RegionID)
    VALUES (@MeasureType, @StartDate, @EndDate, @RegionID);
END;



-- Insert public health measures data for Beijing (RegionID = 1)
EXEC InsertPublicHealthMeasures 'Stay-at-Home Order', '2023-02-01', '2023-02-15', 'Beijing';
EXEC InsertPublicHealthMeasures 'Curfew', '2023-02-16', '2023-02-28', 'Beijing';

-- Insert public health measures data for Shanghai (RegionID = 2)
EXEC InsertPublicHealthMeasures 'Business Restrictions', '2023-02-01', '2023-02-15', 'Shanghai';
EXEC InsertPublicHealthMeasures 'Public Transportation Limits', '2023-02-16', '2023-02-28', 'Shanghai';

-- Insert public health measures data for Guangzhou (RegionID = 3)
EXEC InsertPublicHealthMeasures 'Outdoor Gathering Limits', '2023-02-01', '2023-02-15', 'Guangzhou';
EXEC InsertPublicHealthMeasures 'School Closures', '2023-02-16', '2023-02-28', 'Guangzhou';

-- Insert public health measures data for Karachi (RegionID = 4)
EXEC InsertPublicHealthMeasures 'Workplace Sanitization', '2023-02-01', '2023-02-15', 'Karachi';
EXEC InsertPublicHealthMeasures 'Telecommuting Mandate', '2023-02-16', '2023-02-28', 'Karachi';

-- Insert public health measures data for Lahore (RegionID = 5)
EXEC InsertPublicHealthMeasures 'Public Event Cancellations', '2023-02-01', '2023-02-15', 'Lahore';
EXEC InsertPublicHealthMeasures 'Remote Learning', '2023-02-16', '2023-02-28', 'Lahore';

-- Insert public health measures data for Islamabad (RegionID = 6)
EXEC InsertPublicHealthMeasures 'Travel Restrictions', '2023-02-01', '2023-02-15', 'Islamabad';
EXEC InsertPublicHealthMeasures 'Quarantine Protocols', '2023-02-16', '2023-02-28', 'Islamabad';

-- Insert public health measures data for Lagos (RegionID = 7)
EXEC InsertPublicHealthMeasures 'Essential Services Only', '2023-02-01', '2023-02-15', 'Lagos';
EXEC InsertPublicHealthMeasures 'Emergency Response Activation', '2023-02-16', '2023-02-28', 'Lagos';

-- Insert public health measures data for Kano (RegionID = 8)
EXEC InsertPublicHealthMeasures 'Public Awareness Campaigns', '2023-02-01', '2023-02-15', 'Kano';
EXEC InsertPublicHealthMeasures 'Mass Testing Campaign', '2023-02-16', '2023-02-28', 'Kano';

-- Insert public health measures data for Ibadan (RegionID = 9)
EXEC InsertPublicHealthMeasures 'Community Outreach Programs', '2023-02-01', '2023-02-15', 'Ibadan';
EXEC InsertPublicHealthMeasures 'Vaccination Drives', '2023-02-16', '2023-02-28', 'Ibadan';

-- Insert public health measures data for Johannesburg (RegionID = 10)
EXEC InsertPublicHealthMeasures 'Public Awareness Campaigns', '2023-02-01', '2023-02-15', 'Johannesburg';
EXEC InsertPublicHealthMeasures 'Social Distancing Mandate', '2023-02-16', '2023-02-28', 'Johannesburg';

-- Insert public health measures data for Cape Town (RegionID = 11)
EXEC InsertPublicHealthMeasures 'Quarantine Protocols', '2023-02-01', '2023-02-15', 'Cape Town';
EXEC InsertPublicHealthMeasures 'Outdoor Activity Restrictions', '2023-02-16', '2023-02-28', 'Cape Town';

-- Insert public health measures data for Durban (RegionID = 12)
EXEC InsertPublicHealthMeasures 'Public Event Cancellations', '2023-02-01', '2023-02-15', 'Durban';
EXEC InsertPublicHealthMeasures 'Remote Learning', '2023-02-16', '2023-02-28', 'Durban';

-- Insert public health measures data for Berlin (RegionID = 13)
EXEC InsertPublicHealthMeasures 'Workplace Sanitization', '2023-02-01', '2023-02-15', 'Berlin';
EXEC InsertPublicHealthMeasures 'Telecommuting Mandate', '2023-02-16', '2023-02-28', 'Berlin';

-- Insert public health measures data for Hamburg (RegionID = 14)
EXEC InsertPublicHealthMeasures 'Travel Restrictions', '2023-02-01', '2023-02-15', 'Hamburg';
EXEC InsertPublicHealthMeasures 'Quarantine Protocols', '2023-02-16', '2023-02-28', 'Hamburg';

-- Insert public health measures data for Munich (RegionID = 15)
EXEC InsertPublicHealthMeasures 'Essential Services Only', '2023-02-01', '2023-02-15', 'Munich';
EXEC InsertPublicHealthMeasures 'Emergency Response Activation', '2023-02-16', '2023-02-28', 'Munich';

-- Insert public health measures data for Paris (RegionID = 16)
EXEC InsertPublicHealthMeasures 'Public Awareness Campaigns', '2023-02-01', '2023-02-15', 'Paris';
EXEC InsertPublicHealthMeasures 'Social Distancing Mandate', '2023-02-16', '2023-02-28', 'Paris';

-- Insert public health measures data for Marseille (RegionID = 17)
EXEC InsertPublicHealthMeasures 'Quarantine Protocols', '2023-02-01', '2023-02-15', 'Marseille';
EXEC InsertPublicHealthMeasures 'Outdoor Activity Restrictions', '2023-02-16', '2023-02-28', 'Marseille';

-- Insert public health measures data for Lyon (RegionID = 18)
EXEC InsertPublicHealthMeasures 'Public Event Cancellations', '2023-02-01', '2023-02-15', 'Lyon';
EXEC InsertPublicHealthMeasures 'Remote Learning', '2023-02-16', '2023-02-28', 'Lyon';

-- Insert public health measures data for New York (RegionID = 19)
EXEC InsertPublicHealthMeasures 'Workplace Sanitization', '2023-02-01', '2023-02-15', 'New York';
EXEC InsertPublicHealthMeasures 'Telecommuting Mandate', '2023-02-16', '2023-02-28', 'New York';

-- Insert public health measures data for Los Angeles (RegionID = 20)
EXEC InsertPublicHealthMeasures 'Travel Restrictions', '2023-02-01', '2023-02-15', 'Los Angeles';
EXEC InsertPublicHealthMeasures 'Quarantine Protocols', '2023-02-16', '2023-02-28', 'Los Angeles';

-- Insert public health measures data for Chicago (RegionID = 21)
EXEC InsertPublicHealthMeasures 'Essential Services Only', '2023-02-01', '2023-02-15', 'Chicago';
EXEC InsertPublicHealthMeasures 'Emergency Response Activation', '2023-02-16', '2023-02-28', 'Chicago';

-- Insert public health measures data for Toronto (RegionID = 22)
EXEC InsertPublicHealthMeasures 'Public Awareness Campaigns', '2023-02-01', '2023-02-15', 'Toronto';
EXEC InsertPublicHealthMeasures 'Social Distancing Mandate', '2023-02-16', '2023-02-28', 'Toronto';

-- Insert public health measures data for Montreal (RegionID = 23)
EXEC InsertPublicHealthMeasures 'Quarantine Protocols', '2023-02-01', '2023-02-15', 'Montreal';
EXEC InsertPublicHealthMeasures 'Outdoor Activity Restrictions', '2023-02-16', '2023-02-28', 'Montreal';

-- Insert public health measures data for Vancouver (RegionID = 24)
EXEC InsertPublicHealthMeasures 'Public Event Cancellations', '2023-02-01', '2023-02-15', 'Vancouver';
EXEC InsertPublicHealthMeasures 'Remote Learning', '2023-02-16', '2023-02-28', 'Vancouver';

-- Insert public health measures data for Sao Paulo (RegionID = 25)
EXEC InsertPublicHealthMeasures 'Workplace Sanitization', '2023-02-01', '2023-02-15', 'Sao Paulo';
EXEC InsertPublicHealthMeasures 'Telecommuting Mandate', '2023-02-16', '2023-02-28', 'Sao Paulo';

-- Insert public health measures data for Rio de Janeiro (RegionID = 26)
EXEC InsertPublicHealthMeasures 'Travel Restrictions', '2023-02-01', '2023-02-15', 'Rio de Janeiro';
EXEC InsertPublicHealthMeasures 'Quarantine Protocols', '2023-02-16', '2023-02-28', 'Rio de Janeiro';

-- Insert public health measures data for Brasilia (RegionID = 27)
EXEC InsertPublicHealthMeasures 'Essential Services Only', '2023-02-01', '2023-02-15', 'Brasilia';
EXEC InsertPublicHealthMeasures 'Emergency Response Activation', '2023-02-16', '2023-02-28', 'Brasilia';

-- Insert public health measures data for Buenos Aires (RegionID = 28)
EXEC InsertPublicHealthMeasures 'Public Awareness Campaigns', '2023-02-01', '2023-02-15', 'Buenos Aires';
EXEC InsertPublicHealthMeasures 'Social Distancing Mandate', '2023-02-16', '2023-02-28', 'Buenos Aires';

-- Insert public health measures data for Cordoba (RegionID = 29)
EXEC InsertPublicHealthMeasures 'Quarantine Protocols', '2023-02-01', '2023-02-15', 'Cordoba';
EXEC InsertPublicHealthMeasures 'Outdoor Activity Restrictions', '2023-02-16', '2023-02-28', 'Cordoba';

-- Insert public health measures data for Rosario (RegionID = 30)
EXEC InsertPublicHealthMeasures 'Public Event Cancellations', '2023-02-01', '2023-02-15', 'Rosario';
EXEC InsertPublicHealthMeasures 'Remote Learning', '2023-02-16', '2023-02-28', 'Rosario';

SELECT * FROM PublicHealthMeasures
SELECT * FROM Continent
SELECT * FROM Country
SELECT * FROM DailyCovid19Reports
SELECT * FROM Region
SELECT * FROM TestingData
SELECT * FROM VaccinationData



CREATE PROCEDURE DropAllTables
AS
BEGIN
    -- Drop PublicHealthMeasures table
    IF OBJECT_ID('PublicHealthMeasures', 'U') IS NOT NULL
        DROP TABLE PublicHealthMeasures;

    -- Drop TestingData table
    IF OBJECT_ID('TestingData', 'U') IS NOT NULL
        DROP TABLE TestingData;

    -- Drop VaccinationData table
    IF OBJECT_ID('VaccinationData', 'U') IS NOT NULL
        DROP TABLE VaccinationData;

    -- Drop DailyCovid19Reports table
    IF OBJECT_ID('DailyCovid19Reports', 'U') IS NOT NULL
        DROP TABLE DailyCovid19Reports;

    -- Drop Region table
    IF OBJECT_ID('Region', 'U') IS NOT NULL
        DROP TABLE Region;

    -- Drop Country table
    IF OBJECT_ID('Country', 'U') IS NOT NULL
        DROP TABLE Country;

    -- Drop Continent table
    IF OBJECT_ID('Continent', 'U') IS NOT NULL
        DROP TABLE Continent;
END;

-- Execute the stored procedure to drop tables
EXEC DropAllTables;

-- Caution: This drops the entire database along with all its objects (tables, procedures, etc.)
DROP DATABASE IF EXISTS CAMS;

