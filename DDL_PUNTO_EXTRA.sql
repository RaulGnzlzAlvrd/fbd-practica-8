 USE FBD2020_1_5312;
 CREATE TABLE "Regiones"(
 	"idRegion" "int" IDENTITY (1, 1) NOT NULL,
 	"decripcion" nvarchar (50) NULL,
 	CONSTRAINT "PK_ID_Region" PRIMARY KEY (
 		"idRegion"
 	)
 )
 CREATE  INDEX "idRegion" ON "dbo"."Regiones"("idRegion")

 CREATE TABLE "Territorios"(
 	"idTerritorio" nvarchar (5) NOT NULL,
 	"descripcionTerritorio" nvarchar (50) NULL,
 	"idRegion" "int" NOT NULL,
 	CONSTRAINT "PK_ID_Territorio" PRIMARY KEY (
 		"idTerritorio"
 	),
 	CONSTRAINT "FK_ID_Region" FOREIGN KEY (
 		"idRegion"	
 	) REFERENCES "dbo"."Regiones"(
 		"idRegion"
 	)
 )
 CREATE  INDEX "idTerritorio" ON "dbo"."Territorios"("idTerritorio")
 
 CREATE TABLE "EmpleadoTerritorio"(
 	"idEmpleado" "int" NOT NULL,
 	"idTerritorio" nvarchar (5) NOT NULL,
 	CONSTRAINT "PK_ID_Epleado_Territorio" PRIMARY KEY (
 		"idEmpleado",
 		"idTerritorio"
 	),
 	CONSTRAINT "FK_ID_Empleado" FOREIGN KEY (
 		"idEmpleado"
 	) REFERENCES "dbo"."Empleados"(
 		"idEmpleado"
 	),
 	CONSTRAINT "FK_ID_Territorio" FOREIGN KEY (
 		"idTerritorio"
 	) REFERENCES "dbo"."Territorios"(
 		"idTerritorio"
 	)
 )
