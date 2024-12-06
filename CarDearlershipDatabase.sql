# ---------------------------------------------------------------------- #
# Target DBMS:           MySQL                                           #
# Project name:          CarDealership                                   #
# ---------------------------------------------------------------------- #
DROP DATABASE IF EXISTS carDearlership;

CREATE DATABASE IF NOT EXISTS carDealership;

USE carDealership;

# ---------------------------------------------------------------------- #
# Tables                                                                 #
# ---------------------------------------------------------------------- #
# ---------------------------------------------------------------------- #
# Add table "dealerships"                                               #
# ---------------------------------------------------------------------- #

CREATE TABLE `dealerships` (
    `dealershipID` INTEGER  NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `address` VARCHAR(50) NOT NULL,
    `phone` VARCHAR(12) NOT NULL,
    CONSTRAINT `PK_dealerships` PRIMARY KEY (`dealershipID`)
    );

# Sample data for dealerships
TRUNCATE TABLE dealerships;
INSERT INTO `dealerships` (`name`, `address`, `phone`) VALUES
('Super Cars', '123 Main St, Tampa, FL', '555-1234'),
('Luxury Motors', '456 Elite Rd, Clearwater, FL', '555-5678'),
('City Motors', '789 Downtown Ave, Miami, FL', '555-6789'),
('Affordable Auto', '101 Park Blvd, Orlando, FL', '555-2345'),
('Prime Motors', '202 Prestige St, Fort Lauderdale, FL', '555-3456');


# ---------------------------------------------------------------------- #
# Add table "vehicles"                                                   #
# ---------------------------------------------------------------------- #

CREATE TABLE `vehicles` (
    `vin` VARCHAR(17) NOT NULL ,
    `year` INTEGER NOT NULL ,
    `make` VARCHAR(15),
    `model` VARCHAR(15),
    `vehicleType` VARCHAR(15),
    `color` VARCHAR(15),
    `odometer` INTEGER ,
    `price` DECIMAL(10,2) DEFAULT 0,
    `sold` BOOLEAN,
    CONSTRAINT `PK_vehicles` PRIMARY KEY (`vin`)
);

# Sample data for vehicles
TRUNCATE TABLE vehicles;
INSERT INTO `vehicles` (`vin`, `year`, `make`, `model`, `vehicleType`, `color`, `odometer`, `price`, `sold`) VALUES
('1HGCM82633A123456', 2022, 'Honda', 'Civic', 'Sedan', 'Blue', 12000, 22000.00, FALSE),
('2FTRX18W8XCA98765', 2021, 'Ford', 'F-150', 'Truck', 'Red', 8000, 35000.00, FALSE),
('3C6UR5FL4KK123456', 2023, 'Chrysler', 'Pacifica', 'Van', 'White', 8000, 45000.00, FALSE),
('4S3BNAP68J3000001', 2020, 'Subaru', 'Outback', 'SUV', 'Green', 20000, 27000.00, FALSE),
('5YJ3E1EA4KF321987', 2021, 'Tesla', 'Model 3', 'Sedan', 'Black', 12000, 42000.00, FALSE),
('1C4RJFBG5LC123456', 2020, 'Jeep', 'Grand Cherokee', 'SUV', 'Silver', 18000, 35000.00, TRUE),
('2G1FA1E34J9205678', 2019, 'Chevrolet', 'Camaro', 'Coupe', 'Yellow', 22000, 28000.00, FALSE),
('3LN6L5D97FR801234', 2021, 'Lincoln', 'MKZ', 'Sedan', 'Blue', 15000, 38000.00, FALSE),
('5FNRL6H7XLB123456', 2022, 'Honda', 'Odyssey', 'Van', 'Red', 10000, 45000.00, FALSE),
('1FA6P8TH8J5143210', 2020, 'Ford', 'Mustang', 'Coupe', 'White', 3000, 37000.00, FALSE);

# ---------------------------------------------------------------------- #
# Add table "inventory"                                                  #
# ---------------------------------------------------------------------- #

CREATE TABLE `inventory` (
    `dealershipID` INTEGER NOT NULL,
    `vin` VARCHAR(17) NOT NULL,
    CONSTRAINT `PK_inventory` PRIMARY KEY (`dealershipID`, `vin`),
    CONSTRAINT `FK_inventory_dealership` FOREIGN KEY (`dealershipID`) REFERENCES `dealerships` (`dealershipID`),
    CONSTRAINT `FK_inventory_vehicle` FOREIGN KEY (`vin`) REFERENCES `vehicles` (`vin`)
);

# Sample data for inventory
INSERT INTO `inventory` (`dealershipID`, `vin`) VALUES
(1, '1HGCM82633A123456'),
(2, '2FTRX18W8XCA98765'),
(3, '3C6UR5FL4KK123456'),
(4, '4S3BNAP68J3000001'),
(5, '5YJ3E1EA4KF321987'),
(1, '1C4RJFBG5LC123456'),
(2, '2G1FA1E34J9205678'),
(3, '3LN6L5D97FR801234'),
(4, '5FNRL6H7XLB123456'),
(5, '1FA6P8TH8J5143210');

# ---------------------------------------------------------------------- #
# Add table "contract"                                                   #
# ---------------------------------------------------------------------- #

CREATE TABLE `contract` (
	`contractID` INTEGER NOT NULL ,
    `dateOfContract` DATE NOT NULL,
    `customerName` VARCHAR(30),  
    `customerEmail` VARCHAR(30),  
    `vin` VARCHAR(17) NOT NULL, 
    CONSTRAINT `PK_contract` PRIMARY KEY (`contractID`),
    CONSTRAINT `FK_contract_vin` FOREIGN KEY (`vin`) REFERENCES `vehicles` (`vin`)  
);

# Sample data for contract
TRUNCATE TABLE contract;
INSERT INTO `contract` (`contractID`, `dateOfContract`, `customerName`, `customerEmail`, `vin`) VALUES
(1, '2024-11-21', 'John Doe', 'johndoe@email.com', '1HGCM82633A123456'),
(2, '2024-11-22', 'Jane Smith', 'janesmith@email.com', '2FTRX18W8XCA98765'),
(3, '2024-11-23', 'Michael Johnson', 'michaelj@email.com', '3C6UR5FL4KK123456'),
(4, '2024-11-24', 'Emily Brown', 'emilyb@email.com', '4S3BNAP68J3000001'),
(5, '2024-11-25', 'David Williams', 'davidw@email.com', '5YJ3E1EA4KF321987'),
(6, '2024-11-26', 'Sarah Davis', 'sarahd@email.com', '1C4RJFBG5LC123456'),
(7, '2024-11-27', 'James Wilson', 'jamesw@email.com', '2G1FA1E34J9205678'),
(8, '2024-11-28', 'Olivia Moore', 'oliviam@email.com', '3LN6L5D97FR801234'),
(9, '2024-11-29', 'Sophia Taylor', 'sophiat@email.com', '5FNRL6H7XLB123456'),
(10, '2024-11-30', 'Liam Anderson', 'liama@email.com', '1FA6P8TH8J5143210');

# ---------------------------------------------------------------------- #
# Add table "sales_contract"                                             #
# ---------------------------------------------------------------------- #

CREATE TABLE `sales_contracts` (
    `contractID` INTEGER NOT NULL,                                      
    `salesTax` DECIMAL(10, 2) NOT NULL DEFAULT 0,                       
    `recordingFee` DECIMAL(10, 2),                                      
    `processingFee` DECIMAL(10, 2),                                     
    `isFinance` BOOLEAN,
    `vin` VARCHAR(17) NOT NULL, 
    CONSTRAINT `PK_sales_contract` PRIMARY KEY (`contractID`),         
    CONSTRAINT `FK_sales_contracts_vin` FOREIGN KEY (`vin`) REFERENCES `vehicles` (`vin`),  
    CONSTRAINT `FK_sales_contracts_contractID` FOREIGN KEY (`contractID`) REFERENCES `contract` (`contractID`)  
);

# Sample data for sales_contracts
TRUNCATE TABLE sales_contracts;
INSERT INTO `sales_contracts` (`contractID`, `salesTax`, `recordingFee`, `processingFee`, `isFinance`, `vin`) VALUES
(1, 1500.00, 100.00, 50.00, TRUE, '1HGCM82633A123456'),
(2, 2100.00, 150.00, 75.00, FALSE, '2FTRX18W8XCA98765'),
(3, 1600.00, 110.00, 55.00, TRUE, '3C6UR5FL4KK123456'),
(4, 1800.00, 120.00, 60.00, FALSE, '4S3BNAP68J3000001'),
(5, 2000.00, 130.00, 65.00, TRUE, '5YJ3E1EA4KF321987'),
(6, 1700.00, 140.00, 70.00, FALSE, '1C4RJFBG5LC123456'),
(7, 2200.00, 150.00, 80.00, TRUE, '2G1FA1E34J9205678'),
(8, 1900.00, 160.00, 90.00, FALSE, '3LN6L5D97FR801234'),
(9, 2100.00, 170.00, 95.00, TRUE, '5FNRL6H7XLB123456'),
(10, 2300.00, 180.00, 100.00, FALSE, '1FA6P8TH8J5143210');dealershipsvehicles

# ---------------------------------------------------------------------- #
# Add table "lease_contracts"                                            #
# ---------------------------------------------------------------------- #

CREATE TABLE `lease_contracts` (
    `contractID` INTEGER NOT NULL,                                      
    `expectingEndingValuePercentage` DECIMAL(10, 2) NOT NULL DEFAULT 0,  
    `leaseFee` DECIMAL(10, 2),                                          
    `vin` VARCHAR(17) NOT NULL,                                         
    CONSTRAINT `PK_lease_contract` PRIMARY KEY (`contractID`),         
    CONSTRAINT `FK_lease_contracts_vin` FOREIGN KEY (`vin`) REFERENCES `vehicles` (`vin`), 
    CONSTRAINT `FK_lease_contracts_contractID` FOREIGN KEY (`contractID`) REFERENCES `contract` (`contractID`)  
);

# Sample data for lease_contracts
TRUNCATE TABLE lease_contracts;
INSERT INTO `lease_contracts` (`contractID`, `expectingEndingValuePercentage`, `leaseFee`, `vin`) VALUES
(1, 15.00, 300.00, '1HGCM82633A123456'),
(2, 10.00, 500.00, '2FTRX18W8XCA98765'),
(3, 18.00, 350.00, '3C6UR5FL4KK123456'),
(4, 12.00, 400.00, '4S3BNAP68J3000001'),
(5, 20.00, 450.00, '5YJ3E1EA4KF321987'),
(6, 14.00, 500.00, '1C4RJFBG5LC123456'),
(7, 22.00, 550.00, '2G1FA1E34J9205678'),
(8, 16.00, 600.00, '3LN6L5D97FR801234'),
(9, 13.00, 650.00, '5FNRL6H7XLB123456'),
(10, 19.00, 700.00, '1FA6P8TH8J5143210');

# ---------------------------------------------------------------------- #
# Indexes for performance                                                #
# ---------------------------------------------------------------------- #

# Index on foreign key `vin` in `sales_contracts`, `lease_contracts`, and `contract`
CREATE INDEX idx_sales_contracts_vin ON `sales_contracts` (`vin`);
CREATE INDEX idx_lease_contracts_vin ON `lease_contracts` (`vin`);
CREATE INDEX idx_contract_vin ON `contract` (`vin`);

# Index on `customerEmail` in `contract` for faster lookups
CREATE INDEX idx_contract_customerEmail ON `contract` (`customerEmail`);

# Index on `customerName` in `contract` for faster lookups
CREATE INDEX idx_contract_customerName ON `contract` (`customerName`);

# Index on `year` in `vehicles` for faster lookups
CREATE INDEX idx_vehicles_year ON `vehicles` (`year`);
