USE SistemaCotizacionDB;
GO

-- ROLES
INSERT INTO Rol (NombreRol, Descripcion, Estado)
VALUES 
('Administrador', 'Control total del sistema', 'Activo'),
('Usuario', 'Uso general del sistema', 'Activo');
GO

-- MONEDAS
INSERT INTO Moneda (CodigoMoneda, NombreMoneda, Simbolo, Estado)
VALUES
('CRC', 'Colones', '₡', 'Activo'),
('USD', 'Dólares', '$', 'Activo');
GO

-- PRODUCTOS
INSERT INTO Producto (CodigoProducto, NombreProducto, IdMoneda, Estado)
VALUES
('CC', 'Colón Crece', 1, 'Activo'),
('CF', 'Colón Futuro Plus', 1, 'Activo'),
('DS', 'Dólar Seguro', 2, 'Activo'),
('DV', 'Dólar Visión', 2, 'Activo');
GO

-- PLAZOS
INSERT INTO Plazo (Descripcion, Cantidad, Tipo, Estado)
VALUES
('15 días', 15, 'Dias', 'Activo'),
('1 mes', 1, 'Meses', 'Activo'),
('2 meses', 2, 'Meses', 'Activo'),
('3 meses', 3, 'Meses', 'Activo'),
('4 meses', 4, 'Meses', 'Activo'),
('5 meses', 5, 'Meses', 'Activo'),
('6 meses', 6, 'Meses', 'Activo'),
('7 meses', 7, 'Meses', 'Activo'),
('8 meses', 8, 'Meses', 'Activo'),
('9 meses', 9, 'Meses', 'Activo'),
('10 meses', 10, 'Meses', 'Activo'),
('11 meses', 11, 'Meses', 'Activo'),
('12 meses', 12, 'Meses', 'Activo'),
('13 meses', 13, 'Meses', 'Activo'),
('14 meses', 14, 'Meses', 'Activo'),
('15 meses', 15, 'Meses', 'Activo'),
('16 meses', 16, 'Meses', 'Activo'),
('17 meses', 17, 'Meses', 'Activo'),
('18 meses', 18, 'Meses', 'Activo'),
('19 meses', 19, 'Meses', 'Activo'),
('20 meses', 20, 'Meses', 'Activo'),
('21 meses', 21, 'Meses', 'Activo'),
('22 meses', 22, 'Meses', 'Activo'),
('23 meses', 23, 'Meses', 'Activo'),
('24 meses', 24, 'Meses', 'Activo');
GO

---------------------------------------------------------------------------------------------

USE SistemaCotizacionDB;
GO

INSERT INTO Rol (NombreRol, Descripcion, Estado)
VALUES
('Administrador', 'Acceso completo al sistema', 'Activo'),
('Usuario', 'Acceso general al sistema', 'Activo');
GO

INSERT INTO Usuario (NombreCompleto, NombreUsuario, Contrasena, IdRol, Estado)
VALUES
('Administrador General', 'admin', '1234', 1, 'Activo'),
('Usuario General', 'usuario', '1234', 2, 'Activo');
GO

INSERT INTO Cliente (Identificacion, NombreCompleto, Telefono, Correo)
VALUES
('01-1234-5678', 'Maria Fernanda Borbon Granados', '8721-8721', 'mfbg@ice.go.cr'),
('ASF589DDF', 'Adrian Jose Hernandez Moncada', '61616969', 'ajhm@hotmail.com'),
('3-101-123456', 'Cooperativa de Ahorro Estudiantes CR', '2785-2785', 'coopeahorroestudiantescr@estudiantescr.com'),
('123456789012', 'Alexandrine De La Rochefoucauld', '33470023030', 'alexadlr20.1@gmail.com');
GO

INSERT INTO Moneda (CodigoMoneda, NombreMoneda, Simbolo, Estado)
VALUES
('CRC', 'Colones', '₡', 'Activo'),
('USD', 'Dólares', '$', 'Activo');
GO

INSERT INTO Producto (CodigoProducto, NombreProducto, IdMoneda, Estado)
VALUES
('CC', 'Colón Crece', 1, 'Activo'),
('CF', 'Colón Futuro Plus', 1, 'Activo'),
('DS', 'Dólar Seguro', 2, 'Activo'),
('DV', 'Dólar Visión', 2, 'Activo');
GO

INSERT INTO Plazo (Descripcion, Cantidad, Tipo, Estado)
VALUES
('15 días', 15, 'Dias', 'Activo'),
('1 mes', 1, 'Meses', 'Activo'),
('2 meses', 2, 'Meses', 'Activo'),
('3 meses', 3, 'Meses', 'Activo'),
('4 meses', 4, 'Meses', 'Activo'),
('5 meses', 5, 'Meses', 'Activo'),
('6 meses', 6, 'Meses', 'Activo'),
('7 meses', 7, 'Meses', 'Activo'),
('8 meses', 8, 'Meses', 'Activo'),
('9 meses', 9, 'Meses', 'Activo'),
('10 meses', 10, 'Meses', 'Activo'),
('11 meses', 11, 'Meses', 'Activo'),
('12 meses', 12, 'Meses', 'Activo'),
('13 meses', 13, 'Meses', 'Activo'),
('14 meses', 14, 'Meses', 'Activo'),
('15 meses', 15, 'Meses', 'Activo'),
('16 meses', 16, 'Meses', 'Activo'),
('17 meses', 17, 'Meses', 'Activo'),
('18 meses', 18, 'Meses', 'Activo'),
('19 meses', 19, 'Meses', 'Activo'),
('20 meses', 20, 'Meses', 'Activo'),
('21 meses', 21, 'Meses', 'Activo'),
('22 meses', 22, 'Meses', 'Activo'),
('23 meses', 23, 'Meses', 'Activo'),
('24 meses', 24, 'Meses', 'Activo');
GO

-- TASAS CC
INSERT INTO Tasa (IdProducto, IdPlazo, TasaAnual, Estado)
VALUES
(1, 1, 3.1500, 'Activo'),
(1, 2, 3.2500, 'Activo'),
(1, 3, 3.4000, 'Activo'),
(1, 4, 3.6000, 'Activo'),
(1, 7, 4.1000, 'Activo'),
(1, 13, 5.0000, 'Activo'),
(1, 25, 6.5500, 'Activo');

-- TASAS CF
INSERT INTO Tasa (IdProducto, IdPlazo, TasaAnual, Estado)
VALUES
(2, 4, 3.8500, 'Activo'),
(2, 7, 4.3500, 'Activo'),
(2, 13, 5.3000, 'Activo'),
(2, 25, 6.9000, 'Activo');

-- TASAS DS
INSERT INTO Tasa (IdProducto, IdPlazo, TasaAnual, Estado)
VALUES
(3, 2, 1.0000, 'Activo'),
(3, 3, 1.2500, 'Activo'),
(3, 4, 1.5000, 'Activo'),
(3, 7, 2.0000, 'Activo'),
(3, 13, 2.9000, 'Activo'),
(3, 25, 4.4500, 'Activo');

-- TASAS DV
INSERT INTO Tasa (IdProducto, IdPlazo, TasaAnual, Estado)
VALUES
(4, 4, 2.7500, 'Activo'),
(4, 7, 3.2500, 'Activo'),
(4, 13, 4.2000, 'Activo'),
(4, 25, 6.8500, 'Activo');
GO

INSERT INTO Tasa (IdProducto, IdPlazo, TasaAnual, Estado) VALUES
(1, 1, 3.1500, 'Activo'),
(1, 2, 3.2500, 'Activo'),
(1, 3, 3.4000, 'Activo'),
(1, 4, 3.6000, 'Activo'),
(1, 5, 3.7500, 'Activo'),
(1, 6, 3.9000, 'Activo'),
(1, 7, 4.1000, 'Activo'),
(1, 8, 4.2500, 'Activo'),
(1, 9, 4.4000, 'Activo'),
(1, 10, 4.5500, 'Activo'),
(1, 11, 4.7000, 'Activo'),
(1, 12, 4.8500, 'Activo'),
(1, 13, 5.0000, 'Activo'),
(1, 14, 5.1000, 'Activo'),
(1, 15, 5.2000, 'Activo'),
(1, 16, 5.3000, 'Activo'),
(1, 17, 5.4000, 'Activo'),
(1, 18, 5.5000, 'Activo'),
(1, 19, 5.6500, 'Activo'),
(1, 20, 5.8000, 'Activo'),
(1, 21, 5.9500, 'Activo'),
(1, 22, 6.1000, 'Activo'),
(1, 23, 6.2500, 'Activo'),
(1, 24, 6.4000, 'Activo'),
(1, 25, 6.5500, 'Activo');
GO

INSERT INTO Tasa (IdProducto, IdPlazo, TasaAnual, Estado) VALUES
(2, 4, 3.8500, 'Activo'),
(2, 5, 4.0000, 'Activo'),
(2, 6, 4.1500, 'Activo'),
(2, 7, 4.3500, 'Activo'),
(2, 8, 4.5000, 'Activo'),
(2, 9, 4.6500, 'Activo'),
(2, 10, 4.8000, 'Activo'),
(2, 11, 4.9500, 'Activo'),
(2, 12, 5.1000, 'Activo'),
(2, 13, 5.3000, 'Activo'),
(2, 14, 5.4000, 'Activo'),
(2, 15, 5.5000, 'Activo'),
(2, 16, 5.6000, 'Activo'),
(2, 17, 5.7000, 'Activo'),
(2, 18, 5.8000, 'Activo'),
(2, 19, 5.9500, 'Activo'),
(2, 20, 6.1000, 'Activo'),
(2, 21, 6.2500, 'Activo'),
(2, 22, 6.4000, 'Activo'),
(2, 23, 6.5500, 'Activo'),
(2, 24, 6.7000, 'Activo'),
(2, 25, 6.9000, 'Activo');
GO

INSERT INTO Tasa (IdProducto, IdPlazo, TasaAnual, Estado) VALUES
(2, 4, 3.8500, 'Activo'),
(2, 5, 4.0000, 'Activo'),
(2, 6, 4.1500, 'Activo'),
(2, 7, 4.3500, 'Activo'),
(2, 8, 4.5000, 'Activo'),
(2, 9, 4.6500, 'Activo'),
(2, 10, 4.8000, 'Activo'),
(2, 11, 4.9500, 'Activo'),
(2, 12, 5.1000, 'Activo'),
(2, 13, 5.3000, 'Activo'),
(2, 14, 5.4000, 'Activo'),
(2, 15, 5.5000, 'Activo'),
(2, 16, 5.6000, 'Activo'),
(2, 17, 5.7000, 'Activo'),
(2, 18, 5.8000, 'Activo'),
(2, 19, 5.9500, 'Activo'),
(2, 20, 6.1000, 'Activo'),
(2, 21, 6.2500, 'Activo'),
(2, 22, 6.4000, 'Activo'),
(2, 23, 6.5500, 'Activo'),
(2, 24, 6.7000, 'Activo'),
(2, 25, 6.9000, 'Activo');
GO

INSERT INTO Tasa (IdProducto, IdPlazo, TasaAnual, Estado) VALUES
(4, 4, 2.7500, 'Activo'),
(4, 5, 2.9000, 'Activo'),
(4, 6, 3.0500, 'Activo'),
(4, 7, 3.2500, 'Activo'),
(4, 8, 3.4000, 'Activo'),
(4, 9, 3.5500, 'Activo'),
(4, 10, 3.7000, 'Activo'),
(4, 11, 3.8500, 'Activo'),
(4, 12, 4.0000, 'Activo'),
(4, 13, 4.2000, 'Activo'),
(4, 14, 4.3000, 'Activo'),
(4, 15, 4.4000, 'Activo'),
(4, 16, 4.5000, 'Activo'),
(4, 17, 4.6000, 'Activo'),
(4, 18, 4.7000, 'Activo'),
(4, 19, 4.8500, 'Activo'),
(4, 20, 5.0000, 'Activo'),
(4, 21, 5.1500, 'Activo'),
(4, 22, 5.3000, 'Activo'),
(4, 23, 5.4500, 'Activo'),
(4, 24, 5.6000, 'Activo'),
(4, 25, 6.8500, 'Activo');
GO




SELECT * FROM Rol;
SELECT * FROM Usuario;
SELECT * FROM Cliente;
SELECT * FROM Moneda;
SELECT * FROM Plazo;
SELECT * FROM Producto;
SELECT * FROM Tasa;
SELECT * FROM Cotizacion;
SELECT * FROM DetalleCotizacion;
GO

SELECT 
    p.CodigoProducto,
    p.NombreProducto,
    pl.Descripcion AS Plazo,
    t.TasaAnual
FROM Tasa t
INNER JOIN Producto p ON t.IdProducto = p.IdProducto
INNER JOIN Plazo pl ON t.IdPlazo = pl.IdPlazo
ORDER BY p.CodigoProducto, pl.IdPlazo;
GO