
CREATE TABLE Numeric_ReachTest (
    ID INT PRIMARY KEY,
    Region VARCHAR(50),
    SignalStrength NUMERIC(5,2),
    ReachInKM NUMERIC(6,2),
    PopulationCovered BIGINT,
    NoiseLevel NUMERIC(3,2),
    QualityScore NUMERIC(5,2),
    CostEstimate NUMERIC(10,2)
);

INSERT INTO Numeric_ReachTest (ID, Region, SignalStrength, ReachInKM, PopulationCovered, NoiseLevel, QualityScore, CostEstimate) VALUES
(1, 'North', 87.5, 120.3, 500000, 0.2, 89.6, 12500.00),
(2, 'South', 65.4, 89.6, 300000, 0.8, 78.3, 9800.00),
(3, 'East', 90.0, 140.7, 700000, 0.1, 92.5, 15000.50),
(4, 'West', 55.8, 45.2, 120000, 1.2, 60.9, 5600.00),
(5, 'Central', 75.1, 100.0, 400000, 0.5, 85.0, 11200.25),
(6, 'Northwest', 42.3, 32.6, 80000, 1.5, 52.0, 4200.75),
(7, 'Southeast', 93.4, 160.2, 900000, 0.1, 95.0, 16700.00),
(8, 'Northeast', 88.2, 110.5, 600000, 0.3, 88.7, 13000.00),
(9, 'Southwest', 60.9, 78.9, 250000, 0.9, 70.4, 8700.00),
(10, 'Midlands', 70.0, 95.0, 350000, 0.4, 82.1, 10400.00);
