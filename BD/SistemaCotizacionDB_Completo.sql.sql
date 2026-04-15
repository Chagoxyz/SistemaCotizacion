/* =========================================================
   PROYECTO: Sistema de Cotización APF
   MOTOR: SQL Server
   DESCRIPCIÓN:
   Script maestro para:
   1. Crear la base de datos
   2. Crear tablas
   3. Crear relaciones
   4. Insertar datos iniciales
   5. Crear stored procedures
   6. Consultas de verificación
   ========================================================= */

------------------------------------------------------------
-- 1. CREACIÓN DE LA BASE DE DATOS
------------------------------------------------------------
IF DB_ID('SistemaCotizacionDB') IS NULL
BEGIN
    CREATE DATABASE SistemaCotizacionDB;
END;
GO

USE SistemaCotizacionDB;
GO

------------------------------------------------------------
-- 2. ELIMINAR TABLAS SI EXISTEN (OPCIONAL PARA RECREAR)
--    Si no quieres borrar nada, comenta esta sección.
------------------------------------------------------------
IF OBJECT_ID('DetalleCotizacion', 'U') IS NOT NULL DROP TABLE DetalleCotizacion;
IF OBJECT_ID('Cotizacion', 'U') IS NOT NULL DROP TABLE Cotizacion;
IF OBJECT_ID('Tasa', 'U') IS NOT NULL DROP TABLE Tasa;
IF OBJECT_ID('Producto', 'U') IS NOT NULL DROP TABLE Producto;
IF OBJECT_ID('Plazo', 'U') IS NOT NULL DROP TABLE Plazo;
IF OBJECT_ID('Moneda', 'U') IS NOT NULL DROP TABLE Moneda;
IF OBJECT_ID('Cliente', 'U') IS NOT NULL DROP TABLE Cliente;
IF OBJECT_ID('Usuario', 'U') IS NOT NULL DROP TABLE Usuario;
IF OBJECT_ID('Rol', 'U') IS NOT NULL DROP TABLE Rol;
GO

------------------------------------------------------------
-- 3. CREACIÓN DE TABLAS
------------------------------------------------------------

-- Tabla de roles del sistema
CREATE TABLE Rol (
    IdRol INT IDENTITY(1,1) PRIMARY KEY,
    NombreRol VARCHAR(50) NOT NULL,
    Descripcion VARCHAR(150) NULL,
    Estado VARCHAR(20) NOT NULL DEFAULT 'Activo'
);
GO

-- Tabla de usuarios del sistema
CREATE TABLE Usuario (
    IdUsuario INT IDENTITY(1,1) PRIMARY KEY,
    NombreCompleto VARCHAR(150) NOT NULL,
    NombreUsuario VARCHAR(100) NOT NULL UNIQUE,
    Contrasena VARCHAR(100) NOT NULL,
    IdRol INT NOT NULL,
    Estado VARCHAR(20) NOT NULL DEFAULT 'Activo',
    CONSTRAINT FK_Usuario_Rol FOREIGN KEY (IdRol) REFERENCES Rol(IdRol)
);
GO

-- Tabla de clientes
CREATE TABLE Cliente (
    IdCliente INT IDENTITY(1,1) PRIMARY KEY,
    Identificacion VARCHAR(50) NOT NULL,
    NombreCompleto VARCHAR(150) NOT NULL,
    Telefono VARCHAR(50) NOT NULL,
    Correo VARCHAR(120) NOT NULL
);
GO

-- Tabla de monedas
CREATE TABLE Moneda (
    IdMoneda INT IDENTITY(1,1) PRIMARY KEY,
    CodigoMoneda VARCHAR(10) NOT NULL,
    NombreMoneda VARCHAR(50) NOT NULL,
    Simbolo VARCHAR(10) NOT NULL,
    Estado VARCHAR(20) NOT NULL DEFAULT 'Activo'
);
GO

-- Tabla de plazos
CREATE TABLE Plazo (
    IdPlazo INT IDENTITY(1,1) PRIMARY KEY,
    Descripcion VARCHAR(50) NOT NULL,
    Cantidad INT NOT NULL,
    Tipo VARCHAR(20) NOT NULL, -- Dias / Meses
    Estado VARCHAR(20) NOT NULL DEFAULT 'Activo'
);
GO

-- Tabla de productos
CREATE TABLE Producto (
    IdProducto INT IDENTITY(1,1) PRIMARY KEY,
    CodigoProducto VARCHAR(10) NOT NULL UNIQUE,
    NombreProducto VARCHAR(100) NOT NULL,
    IdMoneda INT NOT NULL,
    Estado VARCHAR(20) NOT NULL DEFAULT 'Activo',
    CONSTRAINT FK_Producto_Moneda FOREIGN KEY (IdMoneda) REFERENCES Moneda(IdMoneda)
);
GO

-- Tabla de tasas
CREATE TABLE Tasa (
    IdTasa INT IDENTITY(1,1) PRIMARY KEY,
    IdProducto INT NOT NULL,
    IdPlazo INT NOT NULL,
    TasaAnual DECIMAL(6,4) NOT NULL,
    Estado VARCHAR(20) NOT NULL DEFAULT 'Activo',
    CONSTRAINT FK_Tasa_Producto FOREIGN KEY (IdProducto) REFERENCES Producto(IdProducto),
    CONSTRAINT FK_Tasa_Plazo FOREIGN KEY (IdPlazo) REFERENCES Plazo(IdPlazo)
);
GO

-- Tabla de cotizaciones
CREATE TABLE Cotizacion (
    IdCotizacion INT IDENTITY(1,1) PRIMARY KEY,
    NumeroCotizacion INT NOT NULL UNIQUE,
    IdCliente INT NOT NULL,
    IdProducto INT NOT NULL,
    IdPlazo INT NOT NULL,
    IdTasa INT NOT NULL,
    Monto DECIMAL(18,2) NOT NULL,
    TasaAnual DECIMAL(6,4) NOT NULL,
    TotalInteresBruto DECIMAL(18,2) NOT NULL,
    TotalImpuesto DECIMAL(18,2) NOT NULL,
    TotalNeto DECIMAL(18,2) NOT NULL,
    FechaCotizacion DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Cotizacion_Cliente FOREIGN KEY (IdCliente) REFERENCES Cliente(IdCliente),
    CONSTRAINT FK_Cotizacion_Producto FOREIGN KEY (IdProducto) REFERENCES Producto(IdProducto),
    CONSTRAINT FK_Cotizacion_Plazo FOREIGN KEY (IdPlazo) REFERENCES Plazo(IdPlazo),
    CONSTRAINT FK_Cotizacion_Tasa FOREIGN KEY (IdTasa) REFERENCES Tasa(IdTasa)
);
GO

-- Tabla de detalle mensual de la cotización
CREATE TABLE DetalleCotizacion (
    IdDetalle INT IDENTITY(1,1) PRIMARY KEY,
    IdCotizacion INT NOT NULL,
    Mes INT NOT NULL,
    Monto DECIMAL(18,2) NOT NULL,
    InteresBruto DECIMAL(18,2) NOT NULL,
    Impuesto DECIMAL(18,2) NOT NULL,
    InteresNeto DECIMAL(18,2) NOT NULL,
    CONSTRAINT FK_DetalleCotizacion_Cotizacion FOREIGN KEY (IdCotizacion) REFERENCES Cotizacion(IdCotizacion)
);
GO

------------------------------------------------------------
-- 4. INSERTS INICIALES
------------------------------------------------------------

-- Roles
INSERT INTO Rol (NombreRol, Descripcion, Estado)
VALUES
('Administrador', 'Acceso completo al sistema', 'Activo'),
('Usuario', 'Acceso general al sistema', 'Activo');
GO

-- Usuarios iniciales
INSERT INTO Usuario (NombreCompleto, NombreUsuario, Contrasena, IdRol, Estado)
VALUES
('Administrador General', 'admin', '1234', 1, 'Activo'),
('Usuario General', 'usuario', '1234', 2, 'Activo');
GO

-- Clientes de prueba
INSERT INTO Cliente (Identificacion, NombreCompleto, Telefono, Correo)
VALUES
('01-1234-5678', 'Maria Fernanda Borbon Granados', '8721-8721', 'mfbg@ice.go.cr'),
('ASF589DDF', 'Adrian Jose Hernandez Moncada', '61616969', 'ajhm@hotmail.com'),
('3-101-123456', 'Cooperativa de Ahorro Estudiantes CR', '2785-2785', 'coopeahorroestudiantescr@estudiantescr.com'),
('123456789012', 'Alexandrine De La Rochefoucauld', '33470023030', 'alexadlr20.1@gmail.com');
GO

-- Monedas
INSERT INTO Moneda (CodigoMoneda, NombreMoneda, Simbolo, Estado)
VALUES
('CRC', 'Colones', '₡', 'Activo'),
('USD', 'Dólares', '$', 'Activo');
GO

-- Plazos
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

-- Productos
INSERT INTO Producto (CodigoProducto, NombreProducto, IdMoneda, Estado)
VALUES
('CC', 'Colón Crece', 1, 'Activo'),
('CF', 'Colón Futuro Plus', 1, 'Activo'),
('DS', 'Dólar Seguro', 2, 'Activo'),
('DV', 'Dólar Visión', 2, 'Activo');
GO

------------------------------------------------------------
-- 5. INSERT DE TASAS
------------------------------------------------------------

-- Colón Crece (CC)
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

-- Colón Futuro Plus (CF)
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

-- Dólar Seguro (DS)
INSERT INTO Tasa (IdProducto, IdPlazo, TasaAnual, Estado) VALUES
(3, 2, 1.0000, 'Activo'),
(3, 3, 1.2500, 'Activo'),
(3, 4, 1.5000, 'Activo'),
(3, 5, 1.6500, 'Activo'),
(3, 6, 1.8000, 'Activo'),
(3, 7, 2.0000, 'Activo'),
(3, 8, 2.1500, 'Activo'),
(3, 9, 2.3000, 'Activo'),
(3, 10, 2.4500, 'Activo'),
(3, 11, 2.6000, 'Activo'),
(3, 12, 2.7500, 'Activo'),
(3, 13, 2.9000, 'Activo'),
(3, 14, 3.0000, 'Activo'),
(3, 15, 3.1000, 'Activo'),
(3, 16, 3.2000, 'Activo'),
(3, 17, 3.3000, 'Activo'),
(3, 18, 3.4000, 'Activo'),
(3, 19, 3.5500, 'Activo'),
(3, 20, 3.7000, 'Activo'),
(3, 21, 3.8500, 'Activo'),
(3, 22, 4.0000, 'Activo'),
(3, 23, 4.1500, 'Activo'),
(3, 24, 4.3000, 'Activo'),
(3, 25, 4.4500, 'Activo');
GO

-- Dólar Visión (DV)
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

------------------------------------------------------------
-- 6. STORED PROCEDURES
------------------------------------------------------------

-- Login
CREATE OR ALTER PROCEDURE dbo.sp_Login_Validar
    @NombreUsuario VARCHAR(100),
    @Contrasena VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT IdUsuario, NombreCompleto, NombreUsuario, IdRol, Estado
    FROM Usuario
    WHERE NombreUsuario = @NombreUsuario
      AND Contrasena = @Contrasena
      AND Estado = 'Activo';
END;
GO

-- Roles
CREATE OR ALTER PROCEDURE dbo.sp_Rol_Listar
AS
BEGIN
    SET NOCOUNT ON;

    SELECT IdRol, NombreRol, Descripcion, Estado
    FROM Rol
    ORDER BY NombreRol;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Rol_ObtenerIdPorNombre
    @NombreRol VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT IdRol
    FROM Rol
    WHERE NombreRol = @NombreRol;
END;
GO

-- Usuarios
CREATE OR ALTER PROCEDURE dbo.sp_Usuario_Listar
AS
BEGIN
    SET NOCOUNT ON;

    SELECT u.IdUsuario,
           u.NombreCompleto,
           u.NombreUsuario,
           r.NombreRol AS Rol,
           u.Estado
    FROM Usuario u
    INNER JOIN Rol r ON u.IdRol = r.IdRol
    ORDER BY u.IdUsuario;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Usuario_Insertar
    @NombreCompleto VARCHAR(150),
    @NombreUsuario VARCHAR(100),
    @Contrasena VARCHAR(100),
    @IdRol INT,
    @Estado VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Usuario (NombreCompleto, NombreUsuario, Contrasena, IdRol, Estado)
    VALUES (@NombreCompleto, @NombreUsuario, @Contrasena, @IdRol, @Estado);
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Usuario_Actualizar
    @NombreCompleto VARCHAR(150),
    @NombreUsuario VARCHAR(100),
    @Contrasena VARCHAR(100),
    @IdRol INT,
    @Estado VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Usuario
    SET NombreCompleto = @NombreCompleto,
        Contrasena = @Contrasena,
        IdRol = @IdRol,
        Estado = @Estado
    WHERE NombreUsuario = @NombreUsuario;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Usuario_Eliminar
    @NombreUsuario VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM Usuario
    WHERE NombreUsuario = @NombreUsuario;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Usuario_ObtenerPorId
    @IdUsuario INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT IdUsuario, NombreCompleto, NombreUsuario, Contrasena, IdRol, Estado
    FROM Usuario
    WHERE IdUsuario = @IdUsuario;
END;
GO

-- Monedas
CREATE OR ALTER PROCEDURE dbo.sp_Moneda_Listar
AS
BEGIN
    SET NOCOUNT ON;

    SELECT IdMoneda,
           CodigoMoneda AS Codigo,
           NombreMoneda AS Nombre,
           Simbolo,
           Estado
    FROM Moneda
    ORDER BY IdMoneda;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Moneda_ListarActivas
AS
BEGIN
    SET NOCOUNT ON;

    SELECT IdMoneda, NombreMoneda
    FROM Moneda
    WHERE Estado = 'Activo'
    ORDER BY NombreMoneda;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Moneda_Insertar
    @CodigoMoneda VARCHAR(10),
    @NombreMoneda VARCHAR(50),
    @Simbolo VARCHAR(10),
    @Estado VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Moneda (CodigoMoneda, NombreMoneda, Simbolo, Estado)
    VALUES (@CodigoMoneda, @NombreMoneda, @Simbolo, @Estado);
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Moneda_Actualizar
    @CodigoMoneda VARCHAR(10),
    @NombreMoneda VARCHAR(50),
    @Simbolo VARCHAR(10),
    @Estado VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Moneda
    SET NombreMoneda = @NombreMoneda,
        Simbolo = @Simbolo,
        Estado = @Estado
    WHERE CodigoMoneda = @CodigoMoneda;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Moneda_Eliminar
    @CodigoMoneda VARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM Moneda
    WHERE CodigoMoneda = @CodigoMoneda;
END;
GO

-- Plazos
CREATE OR ALTER PROCEDURE dbo.sp_Plazo_Listar
AS
BEGIN
    SET NOCOUNT ON;

    SELECT IdPlazo, Descripcion, Cantidad, Tipo, Estado
    FROM Plazo
    ORDER BY IdPlazo;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Plazo_ListarActivos
AS
BEGIN
    SET NOCOUNT ON;

    SELECT IdPlazo, Descripcion
    FROM Plazo
    WHERE Estado = 'Activo'
    ORDER BY IdPlazo;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Plazo_Insertar
    @Descripcion VARCHAR(50),
    @Cantidad INT,
    @Tipo VARCHAR(20),
    @Estado VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Plazo (Descripcion, Cantidad, Tipo, Estado)
    VALUES (@Descripcion, @Cantidad, @Tipo, @Estado);
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Plazo_Actualizar
    @Descripcion VARCHAR(50),
    @Cantidad INT,
    @Tipo VARCHAR(20),
    @Estado VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Plazo
    SET Cantidad = @Cantidad,
        Tipo = @Tipo,
        Estado = @Estado
    WHERE Descripcion = @Descripcion;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Plazo_Eliminar
    @Descripcion VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM Plazo
    WHERE Descripcion = @Descripcion;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Plazo_ObtenerIdPorDescripcion
    @Descripcion VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT IdPlazo
    FROM Plazo
    WHERE Descripcion = @Descripcion;
END;
GO

-- Productos
CREATE OR ALTER PROCEDURE dbo.sp_Producto_Listar
AS
BEGIN
    SET NOCOUNT ON;

    SELECT p.IdProducto,
           p.CodigoProducto,
           p.NombreProducto,
           m.NombreMoneda AS Moneda,
           p.Estado
    FROM Producto p
    INNER JOIN Moneda m ON p.IdMoneda = m.IdMoneda
    ORDER BY p.IdProducto;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Producto_ListarActivos
AS
BEGIN
    SET NOCOUNT ON;

    SELECT IdProducto, CodigoProducto, NombreProducto
    FROM Producto
    WHERE Estado = 'Activo'
    ORDER BY NombreProducto;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Producto_Insertar
    @CodigoProducto VARCHAR(10),
    @NombreProducto VARCHAR(100),
    @IdMoneda INT,
    @Estado VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Producto (CodigoProducto, NombreProducto, IdMoneda, Estado)
    VALUES (@CodigoProducto, @NombreProducto, @IdMoneda, @Estado);
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Producto_Actualizar
    @CodigoProducto VARCHAR(10),
    @NombreProducto VARCHAR(100),
    @IdMoneda INT,
    @Estado VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Producto
    SET NombreProducto = @NombreProducto,
        IdMoneda = @IdMoneda,
        Estado = @Estado
    WHERE CodigoProducto = @CodigoProducto;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Producto_Eliminar
    @CodigoProducto VARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM Producto
    WHERE CodigoProducto = @CodigoProducto;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Producto_ObtenerIdPorCodigo
    @CodigoProducto VARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT IdProducto
    FROM Producto
    WHERE CodigoProducto = @CodigoProducto;
END;
GO

-- Tasas
CREATE OR ALTER PROCEDURE dbo.sp_Tasa_Listar
AS
BEGIN
    SET NOCOUNT ON;

    SELECT t.IdTasa,
           p.NombreProducto AS Producto,
           m.NombreMoneda AS Moneda,
           pl.Descripcion AS Plazo,
           t.TasaAnual AS Tasa
    FROM Tasa t
    INNER JOIN Producto p ON t.IdProducto = p.IdProducto
    INNER JOIN Moneda m ON p.IdMoneda = m.IdMoneda
    INNER JOIN Plazo pl ON t.IdPlazo = pl.IdPlazo
    ORDER BY p.NombreProducto, pl.IdPlazo;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Tasa_Insertar
    @IdProducto INT,
    @IdPlazo INT,
    @TasaAnual DECIMAL(6,4),
    @Estado VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Tasa (IdProducto, IdPlazo, TasaAnual, Estado)
    VALUES (@IdProducto, @IdPlazo, @TasaAnual, @Estado);
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Tasa_Actualizar
    @IdProducto INT,
    @IdPlazo INT,
    @TasaAnual DECIMAL(6,4)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Tasa
    SET TasaAnual = @TasaAnual
    WHERE IdProducto = @IdProducto
      AND IdPlazo = @IdPlazo;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Tasa_Eliminar
    @IdProducto INT,
    @IdPlazo INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM Tasa
    WHERE IdProducto = @IdProducto
      AND IdPlazo = @IdPlazo;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Tasa_ObtenerPorProductoYPlazo
    @IdProducto INT,
    @IdPlazo INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT IdTasa, TasaAnual
    FROM Tasa
    WHERE IdProducto = @IdProducto
      AND IdPlazo = @IdPlazo;
END;
GO

-- Perfil
CREATE OR ALTER PROCEDURE dbo.sp_Perfil_Obtener
    @IdUsuario INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT IdUsuario, NombreCompleto, NombreUsuario, Contrasena
    FROM Usuario
    WHERE IdUsuario = @IdUsuario;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Perfil_Actualizar
    @IdUsuario INT,
    @NombreCompleto VARCHAR(150),
    @NombreUsuario VARCHAR(100),
    @Contrasena VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Usuario
    SET NombreCompleto = @NombreCompleto,
        NombreUsuario = @NombreUsuario,
        Contrasena = @Contrasena
    WHERE IdUsuario = @IdUsuario;
END;
GO

-- Clientes
CREATE OR ALTER PROCEDURE dbo.sp_Cliente_ObtenerPorIdentificacion
    @Identificacion VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT IdCliente
    FROM Cliente
    WHERE Identificacion = @Identificacion;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Cliente_Insertar
    @Identificacion VARCHAR(50),
    @NombreCompleto VARCHAR(150),
    @Telefono VARCHAR(50),
    @Correo VARCHAR(120)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Cliente (Identificacion, NombreCompleto, Telefono, Correo)
    VALUES (@Identificacion, @NombreCompleto, @Telefono, @Correo);

    SELECT SCOPE_IDENTITY() AS IdCliente;
END;
GO

-- Cotizaciones
CREATE OR ALTER PROCEDURE dbo.sp_Cotizacion_ObtenerSiguienteNumero
AS
BEGIN
    SET NOCOUNT ON;

    SELECT ISNULL(MAX(NumeroCotizacion), 0) + 1 AS SiguienteNumero
    FROM Cotizacion;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Cotizacion_Insertar
    @NumeroCotizacion INT,
    @IdCliente INT,
    @IdProducto INT,
    @IdPlazo INT,
    @IdTasa INT,
    @Monto DECIMAL(18,2),
    @TasaAnual DECIMAL(6,4),
    @TotalInteresBruto DECIMAL(18,2),
    @TotalImpuesto DECIMAL(18,2),
    @TotalNeto DECIMAL(18,2)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Cotizacion
    (
        NumeroCotizacion,
        IdCliente,
        IdProducto,
        IdPlazo,
        IdTasa,
        Monto,
        TasaAnual,
        TotalInteresBruto,
        TotalImpuesto,
        TotalNeto,
        FechaCotizacion
    )
    VALUES
    (
        @NumeroCotizacion,
        @IdCliente,
        @IdProducto,
        @IdPlazo,
        @IdTasa,
        @Monto,
        @TasaAnual,
        @TotalInteresBruto,
        @TotalImpuesto,
        @TotalNeto,
        GETDATE()
    );

    SELECT SCOPE_IDENTITY() AS IdCotizacion;
END;
GO

-- Detalle de cotización
CREATE OR ALTER PROCEDURE dbo.sp_DetalleCotizacion_Insertar
    @IdCotizacion INT,
    @Mes INT,
    @Monto DECIMAL(18,2),
    @InteresBruto DECIMAL(18,2),
    @Impuesto DECIMAL(18,2),
    @InteresNeto DECIMAL(18,2)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO DetalleCotizacion
    (IdCotizacion, Mes, Monto, InteresBruto, Impuesto, InteresNeto)
    VALUES
    (@IdCotizacion, @Mes, @Monto, @InteresBruto, @Impuesto, @InteresNeto);
END;
GO

-- Historial
CREATE OR ALTER PROCEDURE dbo.sp_HistorialCotizaciones_Buscar
    @Cliente VARCHAR(150) = '',
    @Producto VARCHAR(10) = ''
AS
BEGIN
    SET NOCOUNT ON;

    SELECT c.NumeroCotizacion,
           cl.NombreCompleto AS Cliente,
           p.CodigoProducto AS Producto,
           c.Monto,
           pl.Descripcion AS Plazo,
           c.FechaCotizacion AS Fecha
    FROM Cotizacion c
    INNER JOIN Cliente cl ON c.IdCliente = cl.IdCliente
    INNER JOIN Producto p ON c.IdProducto = p.IdProducto
    INNER JOIN Plazo pl ON c.IdPlazo = pl.IdPlazo
    WHERE (@Cliente = '' OR cl.NombreCompleto LIKE '%' + @Cliente + '%')
      AND (@Producto = '' OR p.CodigoProducto = @Producto)
    ORDER BY c.FechaCotizacion DESC;
END;
GO

-- Reportes
CREATE OR ALTER PROCEDURE dbo.sp_Reporte_PorUsuario
    @IdUsuario INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT u.NombreCompleto AS Usuario,
           COUNT(c.IdCotizacion) AS TotalCotizaciones
    FROM Usuario u
    LEFT JOIN Cotizacion c ON 1 = 1
    WHERE u.IdUsuario = @IdUsuario
    GROUP BY u.NombreCompleto;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Reporte_PorProducto
AS
BEGIN
    SET NOCOUNT ON;

    SELECT p.NombreProducto AS Producto,
           COUNT(c.IdCotizacion) AS TotalCotizaciones
    FROM Cotizacion c
    INNER JOIN Producto p ON c.IdProducto = p.IdProducto
    GROUP BY p.NombreProducto;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Reporte_PorFecha
AS
BEGIN
    SET NOCOUNT ON;

    SELECT CONVERT(DATE, FechaCotizacion) AS Fecha,
           COUNT(IdCotizacion) AS TotalCotizaciones
    FROM Cotizacion
    GROUP BY CONVERT(DATE, FechaCotizacion)
    ORDER BY Fecha;
END;
GO

------------------------------------------------------------
-- 7. CONSULTAS DE VERIFICACIÓN
------------------------------------------------------------

-- Ver tablas principales
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

-- Ver procedimientos almacenados
SELECT name
FROM sys.procedures
ORDER BY name;
GO

-- Ver solo procedimientos del proyecto
SELECT name
FROM sys.procedures
WHERE name LIKE 'sp_%'
ORDER BY name;
GO

-- Ver usuarios con su rol
SELECT 
    u.IdUsuario,
    u.NombreCompleto,
    u.NombreUsuario,
    u.Contrasena,
    r.NombreRol,
    u.Estado
FROM Usuario u
INNER JOIN Rol r ON u.IdRol = r.IdRol;
GO

-- Ver tasas por producto y plazo
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

------------------------------------------------------------
-- 8. CAMBIO DE ROL DE USUARIOS (EJEMPLOS)
------------------------------------------------------------

-- Poner admin como administrador
UPDATE Usuario
SET IdRol = 1
WHERE NombreUsuario = 'admin';
GO

-- Poner usuario como usuario normal
UPDATE Usuario
SET IdRol = 2
WHERE NombreUsuario = 'usuario';
GO