CREATE DATABASE SistemaCotizacionDB;
GO

USE SistemaCotizacionDB;
GO

-- =========================
-- TABLA ROL
-- =========================
CREATE TABLE Rol (
    IdRol INT IDENTITY(1,1) PRIMARY KEY,
    NombreRol VARCHAR(50) NOT NULL,
    Descripcion VARCHAR(150) NULL,
    Estado VARCHAR(20) NOT NULL DEFAULT 'Activo'
);
GO

-- =========================
-- TABLA USUARIO
-- =========================
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

-- =========================
-- TABLA CLIENTE
-- =========================
CREATE TABLE Cliente (
    IdCliente INT IDENTITY(1,1) PRIMARY KEY,
    Identificacion VARCHAR(50) NOT NULL,
    NombreCompleto VARCHAR(150) NOT NULL,
    Telefono VARCHAR(50) NOT NULL,
    Correo VARCHAR(120) NOT NULL
);
GO

-- =========================
-- TABLA MONEDA
-- =========================
CREATE TABLE Moneda (
    IdMoneda INT IDENTITY(1,1) PRIMARY KEY,
    CodigoMoneda VARCHAR(10) NOT NULL,
    NombreMoneda VARCHAR(50) NOT NULL,
    Simbolo VARCHAR(10) NOT NULL,
    Estado VARCHAR(20) NOT NULL DEFAULT 'Activo'
);
GO

-- =========================
-- TABLA PLAZO
-- =========================
CREATE TABLE Plazo (
    IdPlazo INT IDENTITY(1,1) PRIMARY KEY,
    Descripcion VARCHAR(50) NOT NULL,
    Cantidad INT NOT NULL,
    Tipo VARCHAR(20) NOT NULL, -- Dias / Meses
    Estado VARCHAR(20) NOT NULL DEFAULT 'Activo'
);
GO

-- =========================
-- TABLA PRODUCTO
-- =========================
CREATE TABLE Producto (
    IdProducto INT IDENTITY(1,1) PRIMARY KEY,
    CodigoProducto VARCHAR(10) NOT NULL UNIQUE,
    NombreProducto VARCHAR(100) NOT NULL,
    IdMoneda INT NOT NULL,
    Estado VARCHAR(20) NOT NULL DEFAULT 'Activo',
    CONSTRAINT FK_Producto_Moneda FOREIGN KEY (IdMoneda) REFERENCES Moneda(IdMoneda)
);
GO

-- =========================
-- TABLA TASA
-- =========================
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

-- =========================
-- TABLA COTIZACION
-- =========================
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

-- =========================
-- TABLA DETALLE COTIZACION
-- =========================
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