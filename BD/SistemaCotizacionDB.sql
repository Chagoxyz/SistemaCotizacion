/*
==============================================================
 SISTEMA DE COTIZACIÓN APF
 SCRIPT MAESTRO LIMPIO Y COMENTADO
 MOTOR: SQL SERVER

 PROPÓSITO
 1. Crear la base de datos.
 2. Crear tablas y relaciones finales del proyecto.
 3. Insertar catálogos y datos base.
 4. Insertar tasas completas.
 5. Crear todos los stored procedures utilizados por el sistema.
 6. Dejar la base lista para ejecutar el proyecto en otra computadora.

 NOTAS
 - Este script está preparado para ejecutarse varias veces.
 - Si la base ya existe, recrea las tablas y procedimientos.
 - NO crea tablas de respaldo ni scripts de prueba temporales.
==============================================================
*/

/*=============================================================
 1) CREACIÓN / SELECCIÓN DE LA BASE DE DATOS
=============================================================*/
IF DB_ID('SistemaCotizacionDB') IS NULL
BEGIN
    CREATE DATABASE SistemaCotizacionDB;
END;
GO

USE SistemaCotizacionDB;
GO

/*=============================================================
 2) ELIMINAR PROCEDIMIENTOS SI EXISTEN
=============================================================*/
IF OBJECT_ID('dbo.sp_Reporte_CotizacionesPorCliente', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Reporte_CotizacionesPorCliente;
IF OBJECT_ID('dbo.sp_HistorialCotizaciones_Buscar', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_HistorialCotizaciones_Buscar;
IF OBJECT_ID('dbo.sp_DetalleCotizacion_Insertar', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_DetalleCotizacion_Insertar;
IF OBJECT_ID('dbo.sp_Cotizacion_ObtenerSiguienteNumero', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Cotizacion_ObtenerSiguienteNumero;
IF OBJECT_ID('dbo.sp_Cotizacion_Insertar', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Cotizacion_Insertar;
IF OBJECT_ID('dbo.sp_Cliente_Insertar', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Cliente_Insertar;
IF OBJECT_ID('dbo.sp_Cliente_ObtenerPorIdentificacion', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Cliente_ObtenerPorIdentificacion;
IF OBJECT_ID('dbo.sp_Login_Validar', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Login_Validar;
IF OBJECT_ID('dbo.sp_Perfil_Obtener', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Perfil_Obtener;
IF OBJECT_ID('dbo.sp_Perfil_Actualizar', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Perfil_Actualizar;
IF OBJECT_ID('dbo.sp_Rol_Listar', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Rol_Listar;
IF OBJECT_ID('dbo.sp_Rol_ObtenerIdPorNombre', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Rol_ObtenerIdPorNombre;
IF OBJECT_ID('dbo.sp_Usuario_Listar', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Usuario_Listar;
IF OBJECT_ID('dbo.sp_Usuario_ObtenerPorId', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Usuario_ObtenerPorId;
IF OBJECT_ID('dbo.sp_Usuario_Insertar', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Usuario_Insertar;
IF OBJECT_ID('dbo.sp_Usuario_Actualizar', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Usuario_Actualizar;
IF OBJECT_ID('dbo.sp_Usuario_Eliminar', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Usuario_Eliminar;
IF OBJECT_ID('dbo.sp_Moneda_Listar', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Moneda_Listar;
IF OBJECT_ID('dbo.sp_Moneda_ListarActivas', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Moneda_ListarActivas;
IF OBJECT_ID('dbo.sp_Moneda_Insertar', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Moneda_Insertar;
IF OBJECT_ID('dbo.sp_Moneda_Actualizar', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Moneda_Actualizar;
IF OBJECT_ID('dbo.sp_Moneda_Eliminar', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Moneda_Eliminar;
IF OBJECT_ID('dbo.sp_Plazo_Listar', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Plazo_Listar;
IF OBJECT_ID('dbo.sp_Plazo_ListarActivos', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Plazo_ListarActivos;
IF OBJECT_ID('dbo.sp_Plazo_ListarPorProducto', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Plazo_ListarPorProducto;
IF OBJECT_ID('dbo.sp_Plazo_ObtenerIdPorDescripcion', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Plazo_ObtenerIdPorDescripcion;
IF OBJECT_ID('dbo.sp_Plazo_Insertar', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Plazo_Insertar;
IF OBJECT_ID('dbo.sp_Plazo_Actualizar', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Plazo_Actualizar;
IF OBJECT_ID('dbo.sp_Plazo_Eliminar', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Plazo_Eliminar;
IF OBJECT_ID('dbo.sp_Producto_Listar', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Producto_Listar;
IF OBJECT_ID('dbo.sp_Producto_ListarActivos', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Producto_ListarActivos;
IF OBJECT_ID('dbo.sp_Producto_ObtenerIdPorCodigo', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Producto_ObtenerIdPorCodigo;
IF OBJECT_ID('dbo.sp_Producto_ObtenerMonedaPorCodigo', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Producto_ObtenerMonedaPorCodigo;
IF OBJECT_ID('dbo.sp_Producto_Insertar', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Producto_Insertar;
IF OBJECT_ID('dbo.sp_Producto_Actualizar', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Producto_Actualizar;
IF OBJECT_ID('dbo.sp_Producto_Eliminar', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Producto_Eliminar;
IF OBJECT_ID('dbo.sp_Tasa_Listar', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Tasa_Listar;
IF OBJECT_ID('dbo.sp_Tasa_ObtenerPorProductoYPlazo', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Tasa_ObtenerPorProductoYPlazo;
IF OBJECT_ID('dbo.sp_Tasa_Insertar', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Tasa_Insertar;
IF OBJECT_ID('dbo.sp_Tasa_Actualizar', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Tasa_Actualizar;
IF OBJECT_ID('dbo.sp_Tasa_Eliminar', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Tasa_Eliminar;
IF OBJECT_ID('dbo.sp_Reporte_PorUsuario', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Reporte_PorUsuario;
IF OBJECT_ID('dbo.sp_Reporte_PorProducto', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Reporte_PorProducto;
IF OBJECT_ID('dbo.sp_Reporte_PorFecha', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Reporte_PorFecha;
GO

/*=============================================================
 3) ELIMINAR TABLAS SI EXISTEN
    Se eliminan en orden de dependencia.
=============================================================*/
IF OBJECT_ID('dbo.DetalleCotizacion', 'U') IS NOT NULL DROP TABLE dbo.DetalleCotizacion;
IF OBJECT_ID('dbo.Cotizacion', 'U') IS NOT NULL DROP TABLE dbo.Cotizacion;
IF OBJECT_ID('dbo.Tasa', 'U') IS NOT NULL DROP TABLE dbo.Tasa;
IF OBJECT_ID('dbo.Producto', 'U') IS NOT NULL DROP TABLE dbo.Producto;
IF OBJECT_ID('dbo.Plazo', 'U') IS NOT NULL DROP TABLE dbo.Plazo;
IF OBJECT_ID('dbo.Moneda', 'U') IS NOT NULL DROP TABLE dbo.Moneda;
IF OBJECT_ID('dbo.Usuario', 'U') IS NOT NULL DROP TABLE dbo.Usuario;
IF OBJECT_ID('dbo.Cliente', 'U') IS NOT NULL DROP TABLE dbo.Cliente;
IF OBJECT_ID('dbo.Rol', 'U') IS NOT NULL DROP TABLE dbo.Rol;
GO

/*=============================================================
 4) CREACIÓN DE TABLAS FINALES
=============================================================*/

-- Tabla de roles del sistema.
CREATE TABLE dbo.Rol
(
    IdRol INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    NombreRol VARCHAR(50) NOT NULL,
    Descripcion VARCHAR(150) NULL,
    Estado VARCHAR(20) NOT NULL CONSTRAINT DF_Rol_Estado DEFAULT ('Activo')
);
GO

-- Tabla de clientes.
CREATE TABLE dbo.Cliente
(
    IdCliente INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Identificacion VARCHAR(50) NOT NULL,
    NombreCompleto VARCHAR(150) NOT NULL,
    Telefono VARCHAR(50) NOT NULL,
    Correo VARCHAR(120) NOT NULL,
    CONSTRAINT UQ_Cliente_Identificacion UNIQUE (Identificacion)
);
GO

-- Tabla de usuarios del sistema.
-- IdCliente permite ligar un usuario-cliente a su registro real de cliente.
CREATE TABLE dbo.Usuario
(
    IdUsuario INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    NombreCompleto VARCHAR(150) NOT NULL,
    NombreUsuario VARCHAR(100) NOT NULL,
    Contrasena VARCHAR(100) NOT NULL,
    IdRol INT NOT NULL,
    IdCliente INT NULL,
    Estado VARCHAR(20) NOT NULL CONSTRAINT DF_Usuario_Estado DEFAULT ('Activo'),
    CONSTRAINT UQ_Usuario_NombreUsuario UNIQUE (NombreUsuario),
    CONSTRAINT FK_Usuario_Rol FOREIGN KEY (IdRol) REFERENCES dbo.Rol(IdRol),
    CONSTRAINT FK_Usuario_Cliente FOREIGN KEY (IdCliente) REFERENCES dbo.Cliente(IdCliente)
);
GO

-- Catálogo de monedas.
CREATE TABLE dbo.Moneda
(
    IdMoneda INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    CodigoMoneda VARCHAR(10) NOT NULL,
    NombreMoneda VARCHAR(50) NOT NULL,
    Simbolo VARCHAR(10) NOT NULL,
    Estado VARCHAR(20) NOT NULL CONSTRAINT DF_Moneda_Estado DEFAULT ('Activo'),
    CONSTRAINT UQ_Moneda_Codigo UNIQUE (CodigoMoneda)
);
GO

-- Catálogo de plazos.
CREATE TABLE dbo.Plazo
(
    IdPlazo INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Descripcion VARCHAR(50) NOT NULL,
    Cantidad INT NOT NULL,
    Tipo VARCHAR(20) NOT NULL,
    Estado VARCHAR(20) NOT NULL CONSTRAINT DF_Plazo_Estado DEFAULT ('Activo'),
    CONSTRAINT UQ_Plazo_Descripcion UNIQUE (Descripcion)
);
GO

-- Catálogo de productos APF.
CREATE TABLE dbo.Producto
(
    IdProducto INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    CodigoProducto VARCHAR(10) NOT NULL,
    NombreProducto VARCHAR(100) NOT NULL,
    IdMoneda INT NOT NULL,
    Estado VARCHAR(20) NOT NULL CONSTRAINT DF_Producto_Estado DEFAULT ('Activo'),
    CONSTRAINT UQ_Producto_Codigo UNIQUE (CodigoProducto),
    CONSTRAINT FK_Producto_Moneda FOREIGN KEY (IdMoneda) REFERENCES dbo.Moneda(IdMoneda)
);
GO

-- Tabla de tasas por producto y plazo.
CREATE TABLE dbo.Tasa
(
    IdTasa INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    IdProducto INT NOT NULL,
    IdPlazo INT NOT NULL,
    TasaAnual DECIMAL(6,4) NOT NULL,
    Estado VARCHAR(20) NOT NULL CONSTRAINT DF_Tasa_Estado DEFAULT ('Activo'),
    CONSTRAINT FK_Tasa_Producto FOREIGN KEY (IdProducto) REFERENCES dbo.Producto(IdProducto),
    CONSTRAINT FK_Tasa_Plazo FOREIGN KEY (IdPlazo) REFERENCES dbo.Plazo(IdPlazo),
    CONSTRAINT UQ_Tasa_IdProducto_IdPlazo UNIQUE (IdProducto, IdPlazo)
);
GO

-- Tabla principal de cotizaciones.
CREATE TABLE dbo.Cotizacion
(
    IdCotizacion INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    NumeroCotizacion INT NOT NULL,
    IdCliente INT NOT NULL,
    IdProducto INT NOT NULL,
    IdPlazo INT NOT NULL,
    IdTasa INT NOT NULL,
    IdUsuario INT NOT NULL,
    Monto DECIMAL(18,2) NOT NULL,
    TasaAnual DECIMAL(6,4) NOT NULL,
    TotalInteresBruto DECIMAL(18,2) NOT NULL,
    TotalImpuesto DECIMAL(18,2) NOT NULL,
    TotalNeto DECIMAL(18,2) NOT NULL,
    FechaCotizacion DATETIME NOT NULL CONSTRAINT DF_Cotizacion_Fecha DEFAULT (GETDATE()),
    CONSTRAINT UQ_Cotizacion_Numero UNIQUE (NumeroCotizacion),
    CONSTRAINT FK_Cotizacion_Cliente FOREIGN KEY (IdCliente) REFERENCES dbo.Cliente(IdCliente),
    CONSTRAINT FK_Cotizacion_Producto FOREIGN KEY (IdProducto) REFERENCES dbo.Producto(IdProducto),
    CONSTRAINT FK_Cotizacion_Plazo FOREIGN KEY (IdPlazo) REFERENCES dbo.Plazo(IdPlazo),
    CONSTRAINT FK_Cotizacion_Tasa FOREIGN KEY (IdTasa) REFERENCES dbo.Tasa(IdTasa),
    CONSTRAINT FK_Cotizacion_Usuario FOREIGN KEY (IdUsuario) REFERENCES dbo.Usuario(IdUsuario)
);
GO

-- Detalle mensual de la cotización.
CREATE TABLE dbo.DetalleCotizacion
(
    IdDetalle INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    IdCotizacion INT NOT NULL,
    Mes INT NOT NULL,
    Monto DECIMAL(18,2) NOT NULL,
    InteresBruto DECIMAL(18,2) NOT NULL,
    Impuesto DECIMAL(18,2) NOT NULL,
    InteresNeto DECIMAL(18,2) NOT NULL,
    CONSTRAINT FK_DetalleCotizacion_Cotizacion FOREIGN KEY (IdCotizacion) REFERENCES dbo.Cotizacion(IdCotizacion)
);
GO

/*=============================================================
 5) DATOS BASE DEL SISTEMA
=============================================================*/

-- Roles.
INSERT INTO dbo.Rol (NombreRol, Descripcion, Estado)
VALUES
('Administrador', 'Acceso completo al sistema', 'Activo'),
('Usuario', 'Acceso general del sistema', 'Activo');
GO

-- Monedas.
INSERT INTO dbo.Moneda (CodigoMoneda, NombreMoneda, Simbolo, Estado)
VALUES
('CRC', 'Colones', '₡', 'Activo'),
('USD', 'Dólares', '$', 'Activo');
GO

-- Plazos.
INSERT INTO dbo.Plazo (Descripcion, Cantidad, Tipo, Estado)
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

-- Productos.
INSERT INTO dbo.Producto (CodigoProducto, NombreProducto, IdMoneda, Estado)
VALUES
('CC', 'Colón Crece', 1, 'Activo'),
('CF', 'Colón Futuro Plus', 1, 'Activo'),
('DS', 'Dólar Seguro', 2, 'Activo'),
('DV', 'Dólar Visión', 2, 'Activo');
GO

/*=============================================================
 6) CLIENTES Y USUARIOS DE EJEMPLO
     Se insertan algunos registros para poder probar el proyecto.
=============================================================*/

-- Clientes de prueba.
INSERT INTO dbo.Cliente (Identificacion, NombreCompleto, Telefono, Correo)
VALUES
('01-1234-5678', 'Maria Fernanda Borbon Granados', '8721-8721', 'mfbg@ice.go.cr'),
('ASF589DDF', 'Adrian Jose Hernandez Moncada', '61616969', 'ajhm@hotmail.com'),
('3-101-123456', 'Cooperativa de Ahorro Estudiantes CR', '2785-2785', 'coopeahorroestudiantescr@estudiantescr.com'),
('123456789012', 'Alexandrine De La Rochefoucauld', '33470023030', 'alexadlr20.1@gmail.com'),
('119000912', 'shelly', '77777777', 'kendall@gmail.com'),
('119000950', 'robert', '89652450', 'robertoaiza@gmail.com'),
('119000980', 'maylena', '88888888', 'maylena@gmail.com');
GO

-- Usuarios base.
-- El administrador no necesita IdCliente.
INSERT INTO dbo.Usuario (NombreCompleto, NombreUsuario, Contrasena, IdRol, IdCliente, Estado)
VALUES
('Administrador General', 'admin', '1234', 1, NULL, 'Activo'),
('Usuario General', 'usuario', '1234', 2, NULL, 'Activo'),
('shelly', 'she', '1234', 2, (SELECT IdCliente FROM dbo.Cliente WHERE Identificacion = '119000912'), 'Activo'),
('robert', 'ro', '1234', 2, (SELECT IdCliente FROM dbo.Cliente WHERE Identificacion = '119000950'), 'Activo'),
('maylena', 'may', '1234', 2, (SELECT IdCliente FROM dbo.Cliente WHERE Identificacion = '119000980'), 'Activo');
GO

/*=============================================================
 7) TASAS COMPLETAS SEGÚN LA MATRIZ FINAL DEL PROYECTO
=============================================================*/

-- Colón Crece (CC).
INSERT INTO dbo.Tasa (IdProducto, IdPlazo, TasaAnual, Estado) VALUES
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

-- Colón Futuro Plus (CF).
INSERT INTO dbo.Tasa (IdProducto, IdPlazo, TasaAnual, Estado) VALUES
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

-- Dólar Seguro (DS).
INSERT INTO dbo.Tasa (IdProducto, IdPlazo, TasaAnual, Estado) VALUES
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

-- Dólar Visión (DV).
INSERT INTO dbo.Tasa (IdProducto, IdPlazo, TasaAnual, Estado) VALUES
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

/*=============================================================
 8) STORED PROCEDURES DE CLIENTE
=============================================================*/
CREATE OR ALTER PROCEDURE dbo.sp_Cliente_Insertar
    @Identificacion VARCHAR(50),
    @NombreCompleto VARCHAR(150),
    @Telefono VARCHAR(50),
    @Correo VARCHAR(120)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.Cliente (Identificacion, NombreCompleto, Telefono, Correo)
    VALUES (@Identificacion, @NombreCompleto, @Telefono, @Correo);

    SELECT SCOPE_IDENTITY() AS IdCliente;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Cliente_ObtenerPorIdentificacion
    @Identificacion VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT IdCliente
    FROM dbo.Cliente
    WHERE Identificacion = @Identificacion;
END;
GO

/*=============================================================
 9) STORED PROCEDURES DE LOGIN Y PERFIL
=============================================================*/
CREATE OR ALTER PROCEDURE dbo.sp_Login_Validar
    @NombreUsuario VARCHAR(100),
    @Contrasena VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT IdUsuario, NombreCompleto, NombreUsuario, IdRol, Estado
    FROM dbo.Usuario
    WHERE NombreUsuario = @NombreUsuario
      AND Contrasena = @Contrasena
      AND Estado = 'Activo';
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Perfil_Obtener
    @IdUsuario INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT IdUsuario, NombreCompleto, NombreUsuario, Contrasena
    FROM dbo.Usuario
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

    UPDATE dbo.Usuario
    SET NombreCompleto = @NombreCompleto,
        NombreUsuario = @NombreUsuario,
        Contrasena = @Contrasena
    WHERE IdUsuario = @IdUsuario;
END;
GO

/*=============================================================
 10) STORED PROCEDURES DE ROL Y USUARIO
=============================================================*/
CREATE OR ALTER PROCEDURE dbo.sp_Rol_Listar
AS
BEGIN
    SET NOCOUNT ON;

    SELECT IdRol, NombreRol, Descripcion, Estado
    FROM dbo.Rol
    ORDER BY NombreRol;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Rol_ObtenerIdPorNombre
    @NombreRol VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT IdRol
    FROM dbo.Rol
    WHERE NombreRol = @NombreRol;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Usuario_Listar
AS
BEGIN
    SET NOCOUNT ON;

    SELECT u.IdUsuario,
           u.NombreCompleto,
           u.NombreUsuario,
           r.NombreRol AS Rol,
           u.Estado
    FROM dbo.Usuario u
    INNER JOIN dbo.Rol r ON u.IdRol = r.IdRol
    ORDER BY u.IdUsuario;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Usuario_ObtenerPorId
    @IdUsuario INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT IdUsuario, NombreCompleto, NombreUsuario, Contrasena, IdRol, IdCliente, Estado
    FROM dbo.Usuario
    WHERE IdUsuario = @IdUsuario;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Usuario_Insertar
    @NombreCompleto VARCHAR(150),
    @NombreUsuario VARCHAR(100),
    @Contrasena VARCHAR(100),
    @IdRol INT,
    @IdCliente INT,
    @Estado VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.Usuario (NombreCompleto, NombreUsuario, Contrasena, IdRol, IdCliente, Estado)
    VALUES (@NombreCompleto, @NombreUsuario, @Contrasena, @IdRol, @IdCliente, @Estado);
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Usuario_Actualizar
    @NombreCompleto VARCHAR(150),
    @NombreUsuario VARCHAR(100),
    @Contrasena VARCHAR(100),
    @IdRol INT,
    @IdCliente INT,
    @Estado VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.Usuario
    SET NombreCompleto = @NombreCompleto,
        Contrasena = @Contrasena,
        IdRol = @IdRol,
        IdCliente = @IdCliente,
        Estado = @Estado
    WHERE NombreUsuario = @NombreUsuario;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Usuario_Eliminar
    @NombreUsuario VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM dbo.Usuario
    WHERE NombreUsuario = @NombreUsuario;
END;
GO

/*=============================================================
 11) STORED PROCEDURES DE MONEDA
=============================================================*/
CREATE OR ALTER PROCEDURE dbo.sp_Moneda_Listar
AS
BEGIN
    SET NOCOUNT ON;

    SELECT IdMoneda,
           CodigoMoneda AS Codigo,
           NombreMoneda AS Nombre,
           Simbolo,
           Estado
    FROM dbo.Moneda
    ORDER BY IdMoneda;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Moneda_ListarActivas
AS
BEGIN
    SET NOCOUNT ON;

    SELECT IdMoneda, NombreMoneda
    FROM dbo.Moneda
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

    INSERT INTO dbo.Moneda (CodigoMoneda, NombreMoneda, Simbolo, Estado)
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

    UPDATE dbo.Moneda
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

    DELETE FROM dbo.Moneda
    WHERE CodigoMoneda = @CodigoMoneda;
END;
GO

/*=============================================================
 12) STORED PROCEDURES DE PLAZO
=============================================================*/
CREATE OR ALTER PROCEDURE dbo.sp_Plazo_Listar
AS
BEGIN
    SET NOCOUNT ON;

    SELECT IdPlazo, Descripcion, Cantidad, Tipo, Estado
    FROM dbo.Plazo
    ORDER BY IdPlazo;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Plazo_ListarActivos
AS
BEGIN
    SET NOCOUNT ON;

    SELECT IdPlazo, Descripcion
    FROM dbo.Plazo
    WHERE Estado = 'Activo'
    ORDER BY IdPlazo;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Plazo_ListarPorProducto
    @IdProducto INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT DISTINCT p.IdPlazo, p.Descripcion
    FROM dbo.Tasa t
    INNER JOIN dbo.Plazo p ON t.IdPlazo = p.IdPlazo
    WHERE t.IdProducto = @IdProducto
      AND t.Estado = 'Activo'
      AND p.Estado = 'Activo'
    ORDER BY p.IdPlazo;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Plazo_ObtenerIdPorDescripcion
    @Descripcion VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT IdPlazo
    FROM dbo.Plazo
    WHERE Descripcion = @Descripcion;
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

    INSERT INTO dbo.Plazo (Descripcion, Cantidad, Tipo, Estado)
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

    UPDATE dbo.Plazo
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

    DELETE FROM dbo.Plazo
    WHERE Descripcion = @Descripcion;
END;
GO

/*=============================================================
 13) STORED PROCEDURES DE PRODUCTO
=============================================================*/
CREATE OR ALTER PROCEDURE dbo.sp_Producto_Listar
AS
BEGIN
    SET NOCOUNT ON;

    SELECT p.IdProducto,
           p.CodigoProducto,
           p.NombreProducto,
           m.NombreMoneda AS Moneda,
           p.Estado
    FROM dbo.Producto p
    INNER JOIN dbo.Moneda m ON p.IdMoneda = m.IdMoneda
    ORDER BY p.IdProducto;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Producto_ListarActivos
AS
BEGIN
    SET NOCOUNT ON;

    SELECT IdProducto, CodigoProducto, NombreProducto
    FROM dbo.Producto
    WHERE Estado = 'Activo'
    ORDER BY NombreProducto;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Producto_ObtenerIdPorCodigo
    @CodigoProducto VARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT IdProducto
    FROM dbo.Producto
    WHERE CodigoProducto = @CodigoProducto;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Producto_ObtenerMonedaPorCodigo
    @CodigoProducto VARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT m.NombreMoneda, m.Simbolo
    FROM dbo.Producto p
    INNER JOIN dbo.Moneda m ON p.IdMoneda = m.IdMoneda
    WHERE p.CodigoProducto = @CodigoProducto;
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

    INSERT INTO dbo.Producto (CodigoProducto, NombreProducto, IdMoneda, Estado)
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

    UPDATE dbo.Producto
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

    DELETE FROM dbo.Producto
    WHERE CodigoProducto = @CodigoProducto;
END;
GO

/*=============================================================
 14) STORED PROCEDURES DE TASA
=============================================================*/
CREATE OR ALTER PROCEDURE dbo.sp_Tasa_Listar
AS
BEGIN
    SET NOCOUNT ON;

    SELECT t.IdTasa,
           p.NombreProducto AS Producto,
           m.NombreMoneda AS Moneda,
           pl.Descripcion AS Plazo,
           t.TasaAnual AS Tasa
    FROM dbo.Tasa t
    INNER JOIN dbo.Producto p ON t.IdProducto = p.IdProducto
    INNER JOIN dbo.Moneda m ON p.IdMoneda = m.IdMoneda
    INNER JOIN dbo.Plazo pl ON t.IdPlazo = pl.IdPlazo
    ORDER BY p.NombreProducto, pl.IdPlazo;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Tasa_ObtenerPorProductoYPlazo
    @IdProducto INT,
    @IdPlazo INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT IdTasa, TasaAnual
    FROM dbo.Tasa
    WHERE IdProducto = @IdProducto
      AND IdPlazo = @IdPlazo;
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

    INSERT INTO dbo.Tasa (IdProducto, IdPlazo, TasaAnual, Estado)
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

    UPDATE dbo.Tasa
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

    DELETE FROM dbo.Tasa
    WHERE IdProducto = @IdProducto
      AND IdPlazo = @IdPlazo;
END;
GO

/*=============================================================
 15) STORED PROCEDURES DE COTIZACIÓN E HISTORIAL
=============================================================*/
CREATE OR ALTER PROCEDURE dbo.sp_Cotizacion_ObtenerSiguienteNumero
AS
BEGIN
    SET NOCOUNT ON;

    SELECT ISNULL(MAX(NumeroCotizacion), 0) + 1 AS SiguienteNumero
    FROM dbo.Cotizacion;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Cotizacion_Insertar
    @NumeroCotizacion INT,
    @IdCliente INT,
    @IdProducto INT,
    @IdPlazo INT,
    @IdTasa INT,
    @IdUsuario INT,
    @Monto DECIMAL(18,2),
    @TasaAnual DECIMAL(6,4),
    @TotalInteresBruto DECIMAL(18,2),
    @TotalImpuesto DECIMAL(18,2),
    @TotalNeto DECIMAL(18,2)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.Cotizacion
    (
        NumeroCotizacion,
        IdCliente,
        IdProducto,
        IdPlazo,
        IdTasa,
        IdUsuario,
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
        @IdUsuario,
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

    INSERT INTO dbo.DetalleCotizacion
    (IdCotizacion, Mes, Monto, InteresBruto, Impuesto, InteresNeto)
    VALUES
    (@IdCotizacion, @Mes, @Monto, @InteresBruto, @Impuesto, @InteresNeto);
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_HistorialCotizaciones_Buscar
    @Cliente VARCHAR(150) = '',
    @Producto VARCHAR(10) = '',
    @IdUsuario INT = NULL,
    @IdClienteUsuario INT = NULL,
    @EsAdministrador BIT = 0
AS
BEGIN
    SET NOCOUNT ON;

    SELECT c.NumeroCotizacion,
           cl.NombreCompleto AS Cliente,
           u.NombreUsuario AS Usuario,
           p.CodigoProducto AS Producto,
           c.Monto,
           pl.Descripcion AS Plazo,
           c.FechaCotizacion AS Fecha
    FROM dbo.Cotizacion c
    INNER JOIN dbo.Cliente cl ON c.IdCliente = cl.IdCliente
    INNER JOIN dbo.Producto p ON c.IdProducto = p.IdProducto
    INNER JOIN dbo.Plazo pl ON c.IdPlazo = pl.IdPlazo
    INNER JOIN dbo.Usuario u ON c.IdUsuario = u.IdUsuario
    WHERE (@Cliente = '' OR cl.NombreCompleto LIKE '%' + @Cliente + '%')
      AND (@Producto = '' OR p.CodigoProducto = @Producto)
      AND (@EsAdministrador = 1 OR c.IdCliente = @IdClienteUsuario)
    ORDER BY c.FechaCotizacion DESC;
END;
GO

/*=============================================================
 16) STORED PROCEDURES DE REPORTES
=============================================================*/
CREATE OR ALTER PROCEDURE dbo.sp_Reporte_CotizacionesPorCliente
    @IdCliente INT,
    @NumeroCotizacion INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT c.NumeroCotizacion,
           cl.NombreCompleto AS Cliente,
           u.NombreUsuario AS Usuario,
           p.NombreProducto AS Producto,
           c.Monto,
           pl.Descripcion AS Plazo,
           c.TasaAnual,
           c.TotalInteresBruto,
           c.TotalImpuesto,
           c.TotalNeto,
           c.FechaCotizacion AS Fecha
    FROM dbo.Cotizacion c
    INNER JOIN dbo.Cliente cl ON c.IdCliente = cl.IdCliente
    INNER JOIN dbo.Usuario u ON c.IdUsuario = u.IdUsuario
    INNER JOIN dbo.Producto p ON c.IdProducto = p.IdProducto
    INNER JOIN dbo.Plazo pl ON c.IdPlazo = pl.IdPlazo
    WHERE c.IdCliente = @IdCliente
      AND (@NumeroCotizacion IS NULL OR c.NumeroCotizacion = @NumeroCotizacion)
    ORDER BY c.FechaCotizacion DESC;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Reporte_PorUsuario
    @IdUsuario INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT u.NombreCompleto AS Usuario,
           COUNT(c.IdCotizacion) AS TotalCotizaciones
    FROM dbo.Usuario u
    LEFT JOIN dbo.Cotizacion c ON c.IdUsuario = u.IdUsuario
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
    FROM dbo.Cotizacion c
    INNER JOIN dbo.Producto p ON c.IdProducto = p.IdProducto
    GROUP BY p.NombreProducto
    ORDER BY p.NombreProducto;
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_Reporte_PorFecha
AS
BEGIN
    SET NOCOUNT ON;

    SELECT CONVERT(DATE, FechaCotizacion) AS Fecha,
           COUNT(IdCotizacion) AS TotalCotizaciones
    FROM dbo.Cotizacion
    GROUP BY CONVERT(DATE, FechaCotizacion)
    ORDER BY Fecha;
END;
GO

/*=============================================================
 17) CONSULTAS DE VERIFICACIÓN OPCIONALES
     Ejecuta estas consultas solo si quieres revisar datos.
=============================================================*/
-- SELECT * FROM dbo.Rol;
-- SELECT * FROM dbo.Cliente;
-- SELECT * FROM dbo.Usuario;
-- SELECT * FROM dbo.Moneda;
-- SELECT * FROM dbo.Plazo;
-- SELECT * FROM dbo.Producto;
-- SELECT * FROM dbo.Tasa ORDER BY IdProducto, IdPlazo;
-- SELECT * FROM dbo.Cotizacion;
-- SELECT * FROM dbo.DetalleCotizacion;
