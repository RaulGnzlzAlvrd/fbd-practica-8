
--CREAMOS BASE DE DATOS

--Seleccionamos master para creación de base
USE Master;
--Validamos en sys si la base ya existe
PRINT N'Validamos si la base existe';
IF EXISTS (SELECT 1 FROM sys.databases WHERE [name] = 'FBD2020_1_5312')
BEGIN
PRINT N'Base ya existe';
DROP DATABASE FBD2020_1_5312;
END;
--Creamos la base
CREATE DATABASE FBD2020_1_5312
ON PRIMARY
(
NAME = 'FBD2020_1_5312',
FILENAME = '/fbd/fundamentos/FBD2020_1_5312.mdf',
SIZE = 5MB,
MAXSIZE = UNLIMITED,
FILEGROWTH = 100%
)
LOG ON
(
NAME = 'FBD2020_1_5312_Log',
FILENAME = '/fbd/fundamentos/FBD2020_1_5312_Log.ldf',
SIZE = 5MB,
MAXSIZE = 100MB,
FILEGROWTH = 5MB
);
PRINT N'Base de datos creada correctamente';

--CREAMOS TABLAS DE LA BASE DE DATOS
SET DATEFORMAT dmy
USE FBD2020_1_5312;
--Eliminar tablar si es que existen
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.DetallesPedido') )
	DROP TABLE "dbo"."DetallesPedido"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Pedidos') )
	DROP TABLE "dbo"."Pedidos"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Productos') )
	DROP TABLE "dbo"."Productos"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Categorias') )
	DROP TABLE "dbo"."Categorias"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Clientes') )
	DROP TABLE "dbo"."Clientes"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CompaniasEnvio') )
	DROP TABLE "dbo"."CompaniasEnvio"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Provedores') )
	DROP TABLE "dbo"."Provedores"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Empleados') )
	DROP TABLE "dbo"."Empleados"

--Crear tabla empleados
CREATE TABLE "Empleados" (
	"idEmpleado" "int" IDENTITY (1, 1) NOT NULL ,
	"apellido" nvarchar (20) NOT NULL ,
	"nombre" nvarchar (10) NOT NULL ,
	"titulo" nvarchar (30) NULL ,
	"tituloDeCortesia" nvarchar (25) NULL ,
	"fechaNacimiento" "datetime" NULL ,
	"fechaContratacion" "datetime" NULL ,
	"direccion" nvarchar (60) NULL ,
	"ciudad" nvarchar (15) NULL ,
	"region" nvarchar (15) NULL ,
	"codigoPostal" nvarchar (10) NULL ,
	"pais" nvarchar (15) NULL ,
	"telefonoCasa" nvarchar (24) NULL ,
	"extension" nvarchar (4) NULL ,
	"foto" "image" NULL ,
	"notas" "ntext" NULL ,
	"reportaAEmpleado" "int" NULL ,
	"pathFoto" nvarchar (255) NULL ,
	CONSTRAINT "PK_Empleados" PRIMARY KEY  CLUSTERED
	(
		"idEmpleado"
	),
	CONSTRAINT "FK_Empleados_Empleados" FOREIGN KEY
	(
		"reportaAEmpleado"
	) REFERENCES "dbo"."Empleados" (
		"idEmpleado"
	),
	CONSTRAINT "CK_FechaNacimiento" CHECK (fechaNacimiento < getdate())
)
--Indices para la tabla Empleado
 CREATE  INDEX "apellido" ON "dbo"."Empleados"("apellido")
 CREATE  INDEX "codigoPostal" ON "dbo"."Empleados"("codigoPostal")


 --Crear tabla Categorias
CREATE TABLE "Categorias" (
	"idCategoria" "int" IDENTITY (1, 1) NOT NULL ,
	"nombreCategoria" nvarchar (15) NOT NULL ,
	"descripcion" "ntext" NULL ,
	"imagen" "image" NULL ,
	CONSTRAINT "PK_Categorias" PRIMARY KEY  CLUSTERED
	(
		"idCategoria"
	)
)
--Indices para categoria
 CREATE  INDEX "nombreCategoria" ON "dbo"."Categorias"("nombreCategoria")


--Crear tabla clientes
CREATE TABLE "Clientes" (
	"idCliente" nchar (5) NOT NULL ,
	"nombreCompania" nvarchar (40) NOT NULL ,
	"nombreContacto" nvarchar (30) NULL ,
	"cargoContacto" nvarchar (30) NULL ,
	"direccion" nvarchar (60) NULL ,
	"ciudad" nvarchar (15) NULL ,
	"region" nvarchar (15) NULL ,
	"codigoPostal" nvarchar (10) NULL ,
	"pais" nvarchar (15) NULL ,
	"telefono" nvarchar (24) NULL ,
	"fax" nvarchar (24) NULL ,
	CONSTRAINT "PK_Clientes" PRIMARY KEY  CLUSTERED
	(
		"idCliente"
	)
)
--Indices para Clientes
CREATE  INDEX "ciudad" ON "dbo"."Clientes"("ciudad")
CREATE  INDEX "nombreCompania" ON "dbo"."Clientes"("nombreCompania")
CREATE  INDEX "codigoPostal" ON "dbo"."Clientes"("codigoPostal")
CREATE  INDEX "region" ON "dbo"."Clientes"("region")

--Crear tabla para companias de envio
CREATE TABLE "CompaniasEnvio" (
	"idCompaniaEnvio" "int" IDENTITY (1, 1) NOT NULL ,
	"nombreCompania" nvarchar (40) NOT NULL ,
	"telefono" nvarchar (24) NULL ,
	CONSTRAINT "PK_CompaniasEnvio" PRIMARY KEY  CLUSTERED
	(
		"idCompaniaEnvio"
	)
)

--Crear tablas para provedores
CREATE TABLE "Provedores" (
	"idProvedor" "int" IDENTITY (1, 1) NOT NULL ,
	"nombreCompania" nvarchar (40) NOT NULL ,
	"nombreContacto" nvarchar (30) NULL ,
	"cargoContacto" nvarchar (30) NULL ,
	"direccion" nvarchar (60) NULL ,
	"ciudad" nvarchar (15) NULL ,
	"region" nvarchar (15) NULL ,
	"codigoPostal" nvarchar (10) NULL ,
	"pais" nvarchar (15) NULL ,
	"telefono" nvarchar (24) NULL ,
	"fax" nvarchar (24) NULL ,
	"paginaProvedor" "ntext" NULL ,
	CONSTRAINT "PK_Provedores" PRIMARY KEY  CLUSTERED
	(
		"idProvedor"
	)
)
--Incides para para tabla provedores
CREATE  INDEX "nombreCompania" ON "dbo"."Provedores"("nombreCompania")
CREATE  INDEX "codigoPostal" ON "dbo"."Provedores"("codigoPostal")


--Crear tabla para pedidos
CREATE TABLE "Pedidos" (
	"idPedido" "int" IDENTITY (1, 1) NOT NULL ,
	"idCliente" nchar (5) NULL ,
	"idEmpleado" "int" NULL ,
	"fechaPedido" "datetime" NULL ,
	"fechaEntrega" "datetime" NULL ,
	"fechaEnvio" "datetime" NULL ,
	"viaEnvio" "int" NULL ,
	"cargo" "money" NULL CONSTRAINT "DF_Pedidos_Cargo" DEFAULT (0),
	"nombreDestinatario" nvarchar (40) NULL ,
	"direccionDestinatario" nvarchar (60) NULL ,
	"ciudadDestinatario" nvarchar (15) NULL ,
	"regionDestinatario" nvarchar (15) NULL ,
	"condigoPostalDestinatario" nvarchar (10) NULL ,
	"paisDestinatario" nvarchar (15) NULL ,
	CONSTRAINT "PK_Pedidos" PRIMARY KEY  CLUSTERED
	(
		"idPedido"
	),
	CONSTRAINT "FK_Pedidos_Clientes" FOREIGN KEY
	(
		"idCliente"
	) REFERENCES "dbo"."Clientes" (
		"idCliente"
	),
	CONSTRAINT "FK_Pedidos_Empleados" FOREIGN KEY
	(
		"idEmpleado"
	) REFERENCES "dbo"."Empleados" (
		"idEmpleado"
	),
	CONSTRAINT "FK_Pedidos_CompaniasEnvio" FOREIGN KEY
	(
		"viaEnvio"
	) REFERENCES "dbo"."CompaniasEnvio" (
		"idCompaniaEnvio"
	)
)
--Indices para tabla pedidos
CREATE  INDEX "idCliente" ON "dbo"."Pedidos"("idCliente")
CREATE  INDEX "ClientesPedidos" ON "dbo"."Pedidos"("idCliente")
CREATE  INDEX "idEmpleado" ON "dbo"."Pedidos"("idEmpleado")
CREATE  INDEX "EmpleadosPedidos" ON "dbo"."Pedidos"("idEmpleado")
CREATE  INDEX "fechaPedido" ON "dbo"."Pedidos"("fechaPedido")
CREATE  INDEX "fechaEnvio" ON "dbo"."Pedidos"("fechaEnvio")
CREATE  INDEX "CompaniasEnvioPedidos" ON "dbo"."Pedidos"("viaEnvio")
CREATE  INDEX "condigoPostalDestinatario" ON "dbo"."Pedidos"("condigoPostalDestinatario")


--Tabla para productos
CREATE TABLE "Productos" (
	"idProducto" "int" IDENTITY (1, 1) NOT NULL ,
	"nombreProducto" nvarchar (40) NOT NULL ,
	"idProvedor" "int" NULL ,
	"idCategoria" "int" NULL ,
	"cantidadPorUnidad" nvarchar (20) NULL ,
	"precioUnitario" "money" NULL CONSTRAINT "DF_Productos_PrecioUnitario" DEFAULT (0),
	"unidadesEnStock" "smallint" NULL CONSTRAINT "DF_Productos_UnidadesEnStock" DEFAULT (0),
	"unidadesEnPedido" "smallint" NULL CONSTRAINT "DF_Productos_UnidadesEnPedido" DEFAULT (0),
	"nivelReorden" "smallint" NULL CONSTRAINT "DF_Productos_NivelReorden" DEFAULT (0),
	"descontinuado" "bit" NOT NULL CONSTRAINT "DF_Productos_Descontinuado" DEFAULT (0),
	CONSTRAINT "PK_Productos" PRIMARY KEY  CLUSTERED
	(
		"idProducto"
	),
	CONSTRAINT "FK_Productos_Categorias" FOREIGN KEY
	(
		"idCategoria"
	) REFERENCES "dbo"."Categorias" (
		"idCategoria"
	),
	CONSTRAINT "FK_Productos_Provedores" FOREIGN KEY
	(
		"idProvedor"
	) REFERENCES "dbo"."Provedores" (
		"idProvedor"
	),
	CONSTRAINT "CK_Productos_PrecioUnitario" CHECK (precioUnitario >= 0),
	CONSTRAINT "CK_NivelReorden" CHECK (nivelReorden >= 0),
	CONSTRAINT "CK_UnidadesEnStock" CHECK (unidadesEnStock >= 0),
	CONSTRAINT "CK_UnidadesEnPedido" CHECK (unidadesEnPedido >= 0)
)

--Indices para tabla Productos
CREATE  INDEX "CategoriasProductos" ON "dbo"."Productos"("idCategoria")
CREATE  INDEX "idCategoria" ON "dbo"."Productos"("idCategoria")
CREATE  INDEX "nombreProducto" ON "dbo"."Productos"("nombreProducto")
CREATE  INDEX "idProvedor" ON "dbo"."Productos"("idProvedor")
CREATE  INDEX "ProvedoresProductos" ON "dbo"."Productos"("idProvedor")

--Crear tabla para los detalles del pedido
CREATE TABLE "DetallesPedido" (
	"idPedido" "int" NOT NULL ,
	"idProducto" "int" NOT NULL ,
	"precioUnitario" "money" NOT NULL CONSTRAINT "DF_Detalles_Pedido_PrecioUnitario" DEFAULT (0),
	"cantidad" "smallint" NOT NULL CONSTRAINT "DF_Detalles_Pedido_Cantidad" DEFAULT (1),
	"descuento" "real" NOT NULL CONSTRAINT "DF_Detalles_Pedido_Descuento" DEFAULT (0),
	CONSTRAINT "PK_Detalles_Pedidos" PRIMARY KEY  CLUSTERED
	(
		"idPedido",
		"idProducto"
	),
	CONSTRAINT "FK_Pedido_Detalles_Pedidos" FOREIGN KEY
	(
		"idPedido"
	) REFERENCES "dbo"."Pedidos" (
		"idPedido"
	),
	CONSTRAINT "FK_Pedido_Detalles_Productos" FOREIGN KEY
	(
		"idProducto"
	) REFERENCES "dbo"."Productos" (
		"idProducto"
	),
	CONSTRAINT "CK_Descuento" CHECK (descuento >= 0 and (descuento <= 1)),
	CONSTRAINT "CK_Cantidad" CHECK (cantidad > 0),
	CONSTRAINT "CK_PrecioUnitario" CHECK (precioUnitario >= 0)
)
--Indices para la tabla detalles pedido
 CREATE  INDEX "idPedido" ON "dbo"."DetallesPedido"("idPedido")
 CREATE  INDEX "PedidosDetalles_Pedido" ON "dbo"."DetallesPedido"("idPedido")
 CREATE  INDEX "idProducto" ON "dbo"."DetallesPedido"("idProducto")
 CREATE  INDEX "ProductosDetalles_Pedido" ON "dbo"."DetallesPedido"("idProducto")
 