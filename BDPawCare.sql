CREATE DATABASE BDPawCare;
GO

USE BDPawCare;
GO


CREATE TABLE Mascotas
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    NombreMascota VARCHAR(100) NOT NULL,
    NombreDueno VARCHAR(100) NOT NULL,
    Tipo VARCHAR(20) NOT NULL,
    Edad INT NOT NULL,
    Telefono VARCHAR(15) NOT NULL,
    Observaciones VARCHAR(500) NULL
);
GO


INSERT INTO Mascotas (NombreMascota, NombreDueno, Tipo, Edad, Telefono, Observaciones)
VALUES 
('Fiddo', 'Carlos Mendoza', 'Perro', 3, '987654321', 'Vacunación al día'),
('Michi', 'Ana Torres', 'Gato', 2, '912345678', 'Control general'),
('Thor', 'Roberto Sánchez', 'Perro', 5, '945612378', 'Sensibilidad alimentaria'),
('Luna', 'María Fernández', 'Gato', 1, '932165498', 'Esterilizada recientemente'),
('Max', 'Diego Gómez', 'Perro', 8, '915935724', 'Chequeo de articulaciones por edad');
GO


CREATE PROCEDURE spListarMascotas
AS
BEGIN
    SET NOCOUNT ON;
    SELECT Id, NombreMascota, NombreDueno, Tipo, Edad, Telefono, ISNULL(Observaciones, '-') AS Observaciones
    FROM Mascotas
    ORDER BY Id DESC;
END;
GO


CREATE PROCEDURE spInsertarMascota
    @NombreMascota VARCHAR(100),
    @NombreDueno VARCHAR(100),
    @Tipo VARCHAR(20),
    @Edad INT,
    @Telefono VARCHAR(15),
    @Observaciones VARCHAR(500) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO Mascotas (NombreMascota, NombreDueno, Tipo, Edad, Telefono, Observaciones)
    VALUES (@NombreMascota, @NombreDueno, @Tipo, @Edad, @Telefono, @Observaciones);
END;
GO