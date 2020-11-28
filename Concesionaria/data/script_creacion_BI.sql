USE [GD2C2020]
GO

-- Dropeo de tablas
IF (EXISTS (SELECT * FROM sys.objects WHERE name = 'VW_Auto_Cantidad_Ganancia')) 
	DROP VIEW NAPOLITANA_CON_FRITAS.VW_Auto_Cantidad_Ganancia
GO

IF (EXISTS (SELECT * FROM sys.objects WHERE name = 'VW_Auto_Stock_Precio_Promedio')) 
	DROP VIEW NAPOLITANA_CON_FRITAS.VW_Auto_Stock_Precio_Promedio
GO

IF (EXISTS (SELECT * FROM sys.objects WHERE name = 'VW_Autoparte_Ganancia')) 
	DROP VIEW NAPOLITANA_CON_FRITAS.VW_Autoparte_Ganancia
GO

IF (EXISTS (SELECT * FROM sys.objects WHERE name = 'VW_Autoparte_Precio_Promedio')) 
	DROP VIEW NAPOLITANA_CON_FRITAS.VW_Autoparte_Precio_Promedio
GO

IF (EXISTS (SELECT * FROM sys.objects WHERE name = 'VW_Autoparte_Maximo_Stock')) 
	DROP VIEW NAPOLITANA_CON_FRITAS.VW_Autoparte_Maximo_Stock
GO

IF (EXISTS (SELECT * FROM sys.objects WHERE name = 'BI_Venta_Auto')) 
	DROP TABLE NAPOLITANA_CON_FRITAS.BI_Venta_Auto
GO

IF (EXISTS (SELECT * FROM sys.objects WHERE name = 'BI_Compra_Auto')) 
	DROP TABLE NAPOLITANA_CON_FRITAS.BI_Compra_Auto
GO

IF (EXISTS (SELECT * FROM sys.objects WHERE name = 'BI_Venta_Autoparte')) 
	DROP TABLE NAPOLITANA_CON_FRITAS.BI_Venta_Autoparte
GO

IF (EXISTS (SELECT * FROM sys.objects WHERE name = 'BI_Compra_Autoparte')) 
	DROP TABLE NAPOLITANA_CON_FRITAS.BI_Compra_Autoparte
GO

IF (EXISTS (SELECT * FROM sys.objects WHERE name = 'BI_Autoparte')) 
	DROP TABLE NAPOLITANA_CON_FRITAS.BI_Autoparte
GO

IF (EXISTS (SELECT * FROM sys.objects WHERE name = 'BI_Modelo')) 
	DROP TABLE NAPOLITANA_CON_FRITAS.BI_Modelo
GO

IF (EXISTS (SELECT * FROM sys.objects WHERE name = 'BI_Sucursal')) 
	DROP TABLE NAPOLITANA_CON_FRITAS.BI_Sucursal
GO

IF (EXISTS (SELECT * FROM sys.objects WHERE name = 'BI_Tipo_Transmision')) 
	DROP TABLE NAPOLITANA_CON_FRITAS.BI_Tipo_Transmision
GO

IF (EXISTS (SELECT * FROM sys.objects WHERE name = 'BI_Tipo_Caja')) 
	DROP TABLE NAPOLITANA_CON_FRITAS.BI_Tipo_Caja
GO

IF (EXISTS (SELECT * FROM sys.objects WHERE name = 'BI_Tipo_Auto')) 
	DROP TABLE NAPOLITANA_CON_FRITAS.BI_Tipo_Auto
GO

IF (EXISTS (SELECT * FROM sys.objects WHERE name = 'BI_Fabricante')) 
	DROP TABLE NAPOLITANA_CON_FRITAS.BI_Fabricante
GO

IF (EXISTS (SELECT * FROM sys.objects WHERE name = 'BI_Potencia_Rango')) 
	DROP TABLE NAPOLITANA_CON_FRITAS.BI_Potencia_Rango
GO

IF (EXISTS (SELECT * FROM sys.objects WHERE name = 'BI_Mes')) 
	DROP TABLE NAPOLITANA_CON_FRITAS.BI_Mes
GO

IF (EXISTS (SELECT * FROM sys.objects WHERE name = 'BI_Cliente')) 
	DROP TABLE NAPOLITANA_CON_FRITAS.BI_Cliente
GO

IF (EXISTS (SELECT * FROM sys.objects WHERE name = 'BI_Cantidad_Cambios')) 
	DROP TABLE NAPOLITANA_CON_FRITAS.BI_Cantidad_Cambios
GO

IF (EXISTS (SELECT * FROM sys.objects WHERE name = 'BI_Tipo_Motor')) 
	DROP TABLE NAPOLITANA_CON_FRITAS.BI_Tipo_Motor
GO

IF (EXISTS (SELECT * FROM sys.objects WHERE name = 'BI_Rubro_Autoparte')) 
	DROP TABLE NAPOLITANA_CON_FRITAS.BI_Rubro_Autoparte
GO

-- Creacion de las tablas de dimensiones
CREATE TABLE NAPOLITANA_CON_FRITAS.BI_Sucursal (
SUCURSAL_ID [decimal](18, 0) PRIMARY KEY,
SUCURSAL_DIRECCION [nvarchar](255) NULL,
SUCURSAL_MAIL [nvarchar](255) NULL,
SUCURSAL_TELEFONO [decimal](18, 0) NULL,
SUCURSAL_CIUDAD [nvarchar](255) NULL
);

CREATE TABLE NAPOLITANA_CON_FRITAS.BI_Tipo_Transmision (
TIPO_TRANSMISION_CODIGO decimal(18,0) PRIMARY KEY,
TIPO_TRANSMISION_DESC nvarchar(255)
);

CREATE TABLE NAPOLITANA_CON_FRITAS.BI_Tipo_Caja (
TIPO_CAJA_CODIGO decimal(18,0) PRIMARY KEY,
TIPO_CAJA_DESC nvarchar(255)
);

CREATE TABLE NAPOLITANA_CON_FRITAS.BI_Tipo_Auto (
TIPO_AUTO_CODIGO decimal(18,0) PRIMARY KEY,
TIPO_AUTO_DESC nvarchar(255)
);

CREATE TABLE NAPOLITANA_CON_FRITAS.BI_Fabricante (
FABRICANTE_ID decimal(18,0) PRIMARY KEY,
FABRICANTE_NOMBRE nvarchar(255) 
);

CREATE TABLE NAPOLITANA_CON_FRITAS.BI_Modelo (
MODELO_CODIGO decimal(18,0) PRIMARY KEY,
MODELO_NOMBRE nvarchar(255),
MODELO_POTENCIA decimal(18,0)
);

CREATE TABLE NAPOLITANA_CON_FRITAS.BI_Autoparte (
AUTOPARTE_CODIGO decimal(18,0) PRIMARY KEY,
AUTOPARTE_DESCRIPCION nvarchar(255),
AUTOPARTE_MODELO decimal(18,0),
FOREIGN KEY (AUTOPARTE_MODELO) REFERENCES NAPOLITANA_CON_FRITAS.BI_Modelo(MODELO_CODIGO)
);

CREATE TABLE NAPOLITANA_CON_FRITAS.BI_Potencia_Rango (
ID int PRIMARY KEY,
RANGO varchar(10)
);

CREATE TABLE NAPOLITANA_CON_FRITAS.BI_Mes (
ID int IDENTITY PRIMARY KEY,
ANIO int,
MES int
);

CREATE TABLE NAPOLITANA_CON_FRITAS.BI_Cliente(
ID int PRIMARY KEY,
RANGO_EDAD varchar(15),
SEXO varchar(10)
);

CREATE TABLE NAPOLITANA_CON_FRITAS.BI_Cantidad_Cambios(
ID int PRIMARY KEY,
CANTIDAD varchar(4)
);

CREATE TABLE NAPOLITANA_CON_FRITAS.BI_Tipo_Motor(
ID int IDENTITY PRIMARY KEY,
CODIGO_MOTOR decimal(18,0)
);

CREATE TABLE NAPOLITANA_CON_FRITAS.BI_Rubro_Autoparte(
ID INT IDENTITY PRIMARY KEY,
RUBRO varchar(20)
);

-- Creacion de las tablas de hechos
CREATE TABLE NAPOLITANA_CON_FRITAS.BI_Venta_Auto(
MES_ID int,
SUCURSAL_ID decimal(18,0),
CLIENTE_ID int,
MODELO_ID decimal(18,0),
FABRICANTE_ID decimal(18,0),
TIPO_AUTO_ID decimal(18,0),
TIPO_CAJA_ID decimal(18,0),
TIPO_MOTOR_ID int,
CANTIDAD_CAMBIOS_ID int, 
TIPO_TRANSMISION_ID decimal(18,0),
POTENCIA_RANGO_ID int,
DIAS_PROMEDIO_STOCK int,
PRECIO decimal(18,2) DEFAULT 0,
CANTIDAD decimal(18,0) DEFAULT 0,
PRIMARY KEY (MES_ID,SUCURSAL_ID,CLIENTE_ID,MODELO_ID,FABRICANTE_ID,TIPO_AUTO_ID,TIPO_CAJA_ID,TIPO_MOTOR_ID,TIPO_TRANSMISION_ID,POTENCIA_RANGO_ID),
FOREIGN KEY (MES_ID) REFERENCES NAPOLITANA_CON_FRITAS.BI_Mes(ID),
FOREIGN KEY (SUCURSAL_ID) REFERENCES NAPOLITANA_CON_FRITAS.BI_Sucursal(SUCURSAL_ID),
FOREIGN KEY (CLIENTE_ID) REFERENCES NAPOLITANA_CON_FRITAS.BI_Cliente(ID),
FOREIGN KEY (MODELO_ID) REFERENCES NAPOLITANA_CON_FRITAS.BI_Modelo(MODELO_CODIGO),
FOREIGN KEY (FABRICANTE_ID) REFERENCES NAPOLITANA_CON_FRITAS.BI_Fabricante(FABRICANTE_ID),
FOREIGN KEY (TIPO_AUTO_ID) REFERENCES NAPOLITANA_CON_FRITAS.BI_Tipo_Auto(TIPO_AUTO_CODIGO),
FOREIGN KEY (TIPO_CAJA_ID) REFERENCES NAPOLITANA_CON_FRITAS.BI_Tipo_Caja(TIPO_CAJA_CODIGO),
FOREIGN KEY (TIPO_TRANSMISION_ID) REFERENCES NAPOLITANA_CON_FRITAS.BI_Tipo_Transmision(TIPO_TRANSMISION_CODIGO),
FOREIGN KEY (POTENCIA_RANGO_ID) REFERENCES NAPOLITANA_CON_FRITAS.BI_Potencia_Rango(ID),
FOREIGN KEY (TIPO_MOTOR_ID) REFERENCES NAPOLITANA_CON_FRITAS.BI_Tipo_Motor(ID),
FOREIGN KEY (CANTIDAD_CAMBIOS_ID) REFERENCES NAPOLITANA_CON_FRITAS.BI_Cantidad_Cambios(ID)
);

CREATE TABLE NAPOLITANA_CON_FRITAS.BI_Compra_Auto(
MES_ID int,
SUCURSAL_ID decimal(18,0),
CLIENTE_ID int,
MODELO_ID decimal(18,0),
FABRICANTE_ID decimal(18,0),
TIPO_AUTO_ID decimal(18,0),
TIPO_CAJA_ID decimal(18,0),
TIPO_MOTOR_ID int,
CANTIDAD_CAMBIOS_ID int,
TIPO_TRANSMISION_ID decimal(18,0),
POTENCIA_RANGO_ID int,
PRECIO decimal(18,2) DEFAULT 0,
CANTIDAD decimal(18,0) DEFAULT 0,
PRIMARY KEY (MES_ID,SUCURSAL_ID,CLIENTE_ID,MODELO_ID,FABRICANTE_ID,TIPO_AUTO_ID,TIPO_CAJA_ID,TIPO_MOTOR_ID,TIPO_TRANSMISION_ID,POTENCIA_RANGO_ID),
FOREIGN KEY (MES_ID) REFERENCES NAPOLITANA_CON_FRITAS.BI_Mes(ID),
FOREIGN KEY (SUCURSAL_ID) REFERENCES NAPOLITANA_CON_FRITAS.BI_Sucursal(SUCURSAL_ID),
FOREIGN KEY (CLIENTE_ID) REFERENCES NAPOLITANA_CON_FRITAS.BI_Cliente(ID),
FOREIGN KEY (MODELO_ID) REFERENCES NAPOLITANA_CON_FRITAS.BI_Modelo(MODELO_CODIGO),
FOREIGN KEY (FABRICANTE_ID) REFERENCES NAPOLITANA_CON_FRITAS.BI_Fabricante(FABRICANTE_ID),
FOREIGN KEY (TIPO_AUTO_ID) REFERENCES NAPOLITANA_CON_FRITAS.BI_Tipo_Auto(TIPO_AUTO_CODIGO),
FOREIGN KEY (TIPO_CAJA_ID) REFERENCES NAPOLITANA_CON_FRITAS.BI_Tipo_Caja(TIPO_CAJA_CODIGO),
FOREIGN KEY (TIPO_TRANSMISION_ID) REFERENCES NAPOLITANA_CON_FRITAS.BI_Tipo_Transmision(TIPO_TRANSMISION_CODIGO),
FOREIGN KEY (POTENCIA_RANGO_ID) REFERENCES NAPOLITANA_CON_FRITAS.BI_Potencia_Rango(ID),
FOREIGN KEY (TIPO_MOTOR_ID) REFERENCES NAPOLITANA_CON_FRITAS.BI_Tipo_Motor(ID),
FOREIGN KEY (CANTIDAD_CAMBIOS_ID) REFERENCES NAPOLITANA_CON_FRITAS.BI_Cantidad_Cambios(ID)
);

CREATE TABLE NAPOLITANA_CON_FRITAS.BI_Venta_Autoparte(
AUTOPARTE_ID decimal(18,0),
MES_ID int,
SUCURSAL_ID decimal(18,0),
CLIENTE_ID int,
FABRICANTE_ID decimal(18,0),
RUBRO_AUTOPARTE_ID int,
PRECIO decimal(18,2) DEFAULT 0,
CANTIDAD decimal(18,0) DEFAULT 0,
PRIMARY KEY (AUTOPARTE_ID,MES_ID,SUCURSAL_ID,CLIENTE_ID,FABRICANTE_ID,RUBRO_AUTOPARTE_ID),
FOREIGN KEY (AUTOPARTE_ID) REFERENCES NAPOLITANA_CON_FRITAS.BI_Autoparte(AUTOPARTE_CODIGO),
FOREIGN KEY (MES_ID) REFERENCES NAPOLITANA_CON_FRITAS.BI_Mes(ID),
FOREIGN KEY (SUCURSAL_ID) REFERENCES NAPOLITANA_CON_FRITAS.BI_Sucursal(SUCURSAL_ID),
FOREIGN KEY (CLIENTE_ID) REFERENCES NAPOLITANA_CON_FRITAS.BI_Cliente(ID),
FOREIGN KEY (FABRICANTE_ID) REFERENCES NAPOLITANA_CON_FRITAS.BI_Fabricante(FABRICANTE_ID),
FOREIGN KEY (RUBRO_AUTOPARTE_ID) REFERENCES NAPOLITANA_CON_FRITAS.BI_Rubro_Autoparte(ID)
);

CREATE TABLE NAPOLITANA_CON_FRITAS.BI_Compra_Autoparte(
AUTOPARTE_ID decimal(18,0),
MES_ID int,
SUCURSAL_ID decimal(18,0),
CLIENTE_ID int,
FABRICANTE_ID decimal(18,0),
RUBRO_AUTOPARTE_ID int,
PRECIO decimal(18,2) DEFAULT 0,
CANTIDAD decimal(18,0) DEFAULT 0,
STOCK int,
PRIMARY KEY (AUTOPARTE_ID,MES_ID,SUCURSAL_ID,CLIENTE_ID,FABRICANTE_ID,RUBRO_AUTOPARTE_ID),
FOREIGN KEY (AUTOPARTE_ID) REFERENCES NAPOLITANA_CON_FRITAS.BI_Autoparte(AUTOPARTE_CODIGO),
FOREIGN KEY (MES_ID) REFERENCES NAPOLITANA_CON_FRITAS.BI_Mes(ID),
FOREIGN KEY (SUCURSAL_ID) REFERENCES NAPOLITANA_CON_FRITAS.BI_Sucursal(SUCURSAL_ID),
FOREIGN KEY (CLIENTE_ID) REFERENCES NAPOLITANA_CON_FRITAS.BI_Cliente(ID),
FOREIGN KEY (FABRICANTE_ID) REFERENCES NAPOLITANA_CON_FRITAS.BI_Fabricante(FABRICANTE_ID),
FOREIGN KEY (RUBRO_AUTOPARTE_ID) REFERENCES NAPOLITANA_CON_FRITAS.BI_Rubro_Autoparte(ID)
);

-- se popula tabla BI_Potencia_Rango
INSERT INTO NAPOLITANA_CON_FRITAS.BI_Potencia_Rango (ID, RANGO) 
VALUES (1,'50-150cv'), (2,'151-300cv'), (3,'>300cv');

-- se popula tabla BI_Cliente
INSERT INTO NAPOLITANA_CON_FRITAS.BI_Cliente (ID, RANGO_EDAD, SEXO) 
VALUES (1,'18 - 30 años', 'MASCULINO'), (2,'31 - 50 años', 'MASCULINO'), (3,'> 50 años', 'MASCULINO'), 
	   (4,'18 - 30 años', 'FEMENINO'), (5,'31 - 50 años', 'FEMENINO'), (6,'> 50 años', 'FEMENINO'),
	   (7,'18 - 30 años', 'NO INFORMA'), (8,'31 - 50 años', 'NO INFORMA'), (9,'> 50 años', 'NO INFORMA');

-- se popula tabla BI_Cantidad_Cambios
INSERT INTO NAPOLITANA_CON_FRITAS.BI_Cantidad_Cambios
VALUES (1,'5'), (2,'6'), (3,'S/D');

-- se popula tabla BI_Rubro
INSERT INTO NAPOLITANA_CON_FRITAS.BI_Rubro_Autoparte (RUBRO)
VALUES ('S/D');

-- se popula tabla BI_Modelo
INSERT INTO NAPOLITANA_CON_FRITAS.BI_Tipo_Motor
SELECT DISTINCT MODELO_TIPO_MOTOR FROM NAPOLITANA_CON_FRITAS.Modelo

-- se popula tabla BI_Fabricante
INSERT INTO NAPOLITANA_CON_FRITAS.BI_Fabricante
SELECT * FROM NAPOLITANA_CON_FRITAS.Fabricante

-- se popula tabla BI_Tipo_Auto
INSERT INTO NAPOLITANA_CON_FRITAS.BI_Tipo_Auto
SELECT * FROM NAPOLITANA_CON_FRITAS.Tipo_Auto

-- se popula tabla BI_Tipo_Caja
INSERT INTO NAPOLITANA_CON_FRITAS.BI_Tipo_Caja
SELECT * FROM NAPOLITANA_CON_FRITAS.Tipo_Caja

-- se popula tabla BI_Tipo_Transmision
INSERT INTO NAPOLITANA_CON_FRITAS.BI_Tipo_Transmision
SELECT * FROM NAPOLITANA_CON_FRITAS.Tipo_Transmision

-- se popula tabla BI_Modelo
INSERT INTO NAPOLITANA_CON_FRITAS.BI_Modelo
SELECT MODELO_CODIGO, MODELO_NOMBRE, MODELO_POTENCIA FROM NAPOLITANA_CON_FRITAS.Modelo

-- se popula tabla BI_Sucursal
INSERT INTO NAPOLITANA_CON_FRITAS.BI_Sucursal
SELECT * FROM NAPOLITANA_CON_FRITAS.Sucursal

-- se popula tabla BI_Autoparte
INSERT INTO NAPOLITANA_CON_FRITAS.BI_Autoparte
SELECT * FROM NAPOLITANA_CON_FRITAS.Autoparte

-- se popula tabla BI_Mes
INSERT INTO NAPOLITANA_CON_FRITAS.BI_Mes
SELECT DISTINCT YEAR(COMPRA_FECHA), MONTH(COMPRA_FECHA) FROM NAPOLITANA_CON_FRITAS.Compra
UNION
SELECT DISTINCT YEAR(FACTURA_FECHA), MONTH(FACTURA_FECHA) FROM NAPOLITANA_CON_FRITAS.Factura

-- creacion de tabla temporal para calcular rango de edad de clientes
SELECT CLIENTE_ID,
	(CASE WHEN DATEDIFF(YEAR,CLIENTE_FECHA_NAC,GETDATE()) BETWEEN 18 AND 30 THEN (SELECT TOP 1 A.ID FROM NAPOLITANA_CON_FRITAS.BI_Cliente A WHERE A.SEXO = 'NO INFORMA' AND A.RANGO_EDAD = '18 - 30 años')
		WHEN DATEDIFF(YEAR,CLIENTE_FECHA_NAC,GETDATE()) BETWEEN 31 AND 50 THEN (SELECT TOP 1 A.ID FROM NAPOLITANA_CON_FRITAS.BI_Cliente A WHERE A.SEXO = 'NO INFORMA' AND A.RANGO_EDAD = '31 - 50 años')
		WHEN DATEDIFF(YEAR,CLIENTE_FECHA_NAC,GETDATE()) > 50 THEN (SELECT TOP 1 A.ID FROM NAPOLITANA_CON_FRITAS.BI_Cliente A WHERE A.SEXO = 'NO INFORMA' AND A.RANGO_EDAD = '> 50 años')
		ELSE NULL
	END) as cliente_edad
INTO #ClienteRangoTemp
FROM NAPOLITANA_CON_FRITAS.Cliente;

-- creacion de tabla temporal para calcular tiempo en stock de cada auto
SELECT A.AUTO_MODELO, DATEDIFF(DAY,C.COMPRA_FECHA,F.FACTURA_FECHA) DIAS_STOCK
INTO #TiempoStockTemp
FROM NAPOLITANA_CON_FRITAS.Compra C
JOIN NAPOLITANA_CON_FRITAS.Item_Compra_Auto IC ON IC.ITEM_COMPRA_NRO = C.COMPRA_NRO
JOIN NAPOLITANA_CON_FRITAS.Auto A ON A.AUTO_ID = IC.ITEM_AUTO_ID
JOIN NAPOLITANA_CON_FRITAS.Item_Factura_Auto ItF ON itF.ITEM_AUTO_ID = A.AUTO_ID
JOIN NAPOLITANA_CON_FRITAS.Factura F ON F.FACTURA_NRO = ItF.ITEM_FACTURA_NRO;

-- creacion de tabla temporalpara calcular delta de stock autopartes mensual por sucursal
SELECT M.ID AS MES, C.COMPRA_SUCURSAL AS SUCURSAL, IC.ITEM_AUTOPARTE_ID AS AUTOPARTE, SUM(IC.ITEM_CANTIDAD) - SUM(ItF.ITEM_CANTIDAD) DELTA_STOCK
INTO #StockSucursalTemp
FROM NAPOLITANA_CON_FRITAS.Compra AS C
JOIN NAPOLITANA_CON_FRITAS.Item_Compra_Autoparte AS IC ON C.COMPRA_NRO = IC.ITEM_COMPRA_NRO
JOIN NAPOLITANA_CON_FRITAS.Autoparte AS AP ON AP.AUTOPARTE_CODIGO = IC.ITEM_AUTOPARTE_ID
JOIN NAPOLITANA_CON_FRITAS.Item_Factura_Autoparte AS ItF ON ItF.ITEM_AUTOPARTE_ID = IC.ITEM_AUTOPARTE_ID
JOIN NAPOLITANA_CON_FRITAS.Factura AS F ON F.FACTURA_NRO = ItF.ITEM_FACTURA_NRO
JOIN NAPOLITANA_CON_FRITAS.BI_Mes M ON M.ANIO = YEAR(C.COMPRA_FECHA) AND M.MES = MONTH(C.COMPRA_FECHA)
GROUP BY M.ID, C.COMPRA_SUCURSAL, IC.ITEM_AUTOPARTE_ID;

-- se popula la tabla BI_Compra_Autoparte
INSERT INTO NAPOLITANA_CON_FRITAS.BI_Compra_Autoparte (AUTOPARTE_ID,MES_ID,SUCURSAL_ID,CLIENTE_ID,FABRICANTE_ID,RUBRO_AUTOPARTE_ID,PRECIO,CANTIDAD,STOCK)
SELECT IC.ITEM_AUTOPARTE_ID, MES.ID, C.COMPRA_SUCURSAL,CL.cliente_edad, M.MODELO_FABRICANTE, 1 as rubro, AVG(IC.ITEM_PRECIO), SUM(IC.ITEM_CANTIDAD), SUM(S.DELTA_STOCK)
FROM NAPOLITANA_CON_FRITAS.Compra AS C
JOIN NAPOLITANA_CON_FRITAS.Item_Compra_Autoparte AS IC ON C.COMPRA_NRO = IC.ITEM_COMPRA_NRO
JOIN NAPOLITANA_CON_FRITAS.BI_Mes AS MES ON YEAR(C.COMPRA_FECHA) = MES.ANIO AND MONTH(C.COMPRA_FECHA) = MES.MES
JOIN NAPOLITANA_CON_FRITAS.Autoparte AS AP ON AP.AUTOPARTE_CODIGO = IC.ITEM_AUTOPARTE_ID
JOIN NAPOLITANA_CON_FRITAS.Modelo AS M ON AP.AUTOPARTE_MODELO = M.MODELO_CODIGO
JOIN #ClienteRangoTemp AS CL ON CL.CLIENTE_ID = C.COMPRA_CLIENTE
JOIN #StockSucursalTemp AS S ON S.SUCURSAL = C.COMPRA_SUCURSAL AND S.AUTOPARTE = IC.ITEM_AUTOPARTE_ID AND S.MES <= MES.ID
GROUP BY IC.ITEM_AUTOPARTE_ID, MES.ID, C.COMPRA_SUCURSAL, M.MODELO_FABRICANTE, CL.cliente_edad;

-- Se popula la tabla BI_Venta_Autoparte
INSERT INTO NAPOLITANA_CON_FRITAS.BI_Venta_Autoparte (AUTOPARTE_ID,MES_ID,SUCURSAL_ID,CLIENTE_ID,FABRICANTE_ID,RUBRO_AUTOPARTE_ID,PRECIO,CANTIDAD)
SELECT ItF.ITEM_AUTOPARTE_ID, MES.ID, F.FACTURA_SUCURSAL, CL.cliente_edad, M.MODELO_FABRICANTE, 1, AVG(ItF.ITEM_PRECIO), SUM(ItF.ITEM_CANTIDAD)
FROM NAPOLITANA_CON_FRITAS.Factura AS F
JOIN NAPOLITANA_CON_FRITAS.Item_Factura_Autoparte AS ItF ON F.FACTURA_NRO = ItF.ITEM_FACTURA_NRO
JOIN NAPOLITANA_CON_FRITAS.BI_Mes AS MES ON YEAR(F.FACTURA_FECHA) = MES.ANIO AND MONTH(F.FACTURA_FECHA) = MES.MES
JOIN NAPOLITANA_CON_FRITAS.Autoparte AS AP ON AP.AUTOPARTE_CODIGO = ItF.ITEM_AUTOPARTE_ID
JOIN NAPOLITANA_CON_FRITAS.Modelo AS M ON AP.AUTOPARTE_MODELO = M.MODELO_CODIGO
JOIN #ClienteRangoTemp AS CL ON CL.CLIENTE_ID = F.FACTURA_CLIENTE
GROUP BY ItF.ITEM_AUTOPARTE_ID, MES.ID, F.FACTURA_SUCURSAL, M.MODELO_FABRICANTE, CL.cliente_edad

-- Se popula la tabla BI_Compra_Auto
INSERT INTO NAPOLITANA_CON_FRITAS.BI_Compra_Auto (MES_ID,SUCURSAL_ID,CLIENTE_ID,MODELO_ID,FABRICANTE_ID,TIPO_AUTO_ID,TIPO_CAJA_ID,TIPO_MOTOR_ID,TIPO_TRANSMISION_ID,POTENCIA_RANGO_ID,PRECIO,CANTIDAD)
SELECT MES.ID, C.COMPRA_SUCURSAL, CL.cliente_edad, M.MODELO_CODIGO, M.MODELO_FABRICANTE, M.MODELO_TIPO_AUTO, M.MODELO_TIPO_CAJA, 
	(select id from NAPOLITANA_CON_FRITAS.BI_Tipo_Motor where CODIGO_MOTOR = M.MODELO_TIPO_MOTOR), 
	M.MODELO_TIPO_TRANSMISION, 
	(CASE WHEN M.MODELO_POTENCIA BETWEEN 50 AND 150 THEN (SELECT TOP 1 P.ID FROM NAPOLITANA_CON_FRITAS.BI_Potencia_Rango P WHERE P.RANGO = '50-150cv')
		WHEN M.MODELO_POTENCIA BETWEEN 151 AND 300 THEN (SELECT TOP 1 P.ID FROM NAPOLITANA_CON_FRITAS.BI_Potencia_Rango P WHERE P.RANGO = '151-300cv')
		WHEN M.MODELO_POTENCIA > 300 THEN (SELECT TOP 1 P.ID FROM NAPOLITANA_CON_FRITAS.BI_Potencia_Rango P WHERE P.RANGO = '>300cv')
		ELSE NULL
	END)
	, AVG(IC.ITEM_PRECIO), SUM(IC.ITEM_CANTIDAD)
FROM NAPOLITANA_CON_FRITAS.Compra AS C
JOIN NAPOLITANA_CON_FRITAS.Item_Compra_Auto AS IC ON C.COMPRA_NRO = IC.ITEM_COMPRA_NRO
JOIN NAPOLITANA_CON_FRITAS.BI_Mes AS MES ON YEAR(C.COMPRA_FECHA) = MES.ANIO AND MONTH(C.COMPRA_FECHA) = MES.MES
JOIN NAPOLITANA_CON_FRITAS.Auto AS A ON A.AUTO_ID = IC.ITEM_AUTO_ID
JOIN NAPOLITANA_CON_FRITAS.Modelo AS M ON A.AUTO_MODELO = M.MODELO_CODIGO
JOIN #ClienteRangoTemp AS CL ON CL.CLIENTE_ID = C.COMPRA_CLIENTE
GROUP BY MES.ID, C.COMPRA_SUCURSAL, M.MODELO_CODIGO, M.MODELO_FABRICANTE, M.MODELO_TIPO_AUTO, M.MODELO_TIPO_CAJA, M.MODELO_TIPO_MOTOR, M.MODELO_TIPO_TRANSMISION, M.MODELO_POTENCIA, CL.cliente_edad

-- Se popula la tabla BI_Venta_Auto
INSERT INTO NAPOLITANA_CON_FRITAS.BI_Venta_Auto (MES_ID,SUCURSAL_ID,CLIENTE_ID,MODELO_ID,FABRICANTE_ID,TIPO_AUTO_ID,TIPO_CAJA_ID,TIPO_MOTOR_ID,TIPO_TRANSMISION_ID,POTENCIA_RANGO_ID,PRECIO,CANTIDAD,DIAS_PROMEDIO_STOCK)
SELECT MES.ID, F.FACTURA_SUCURSAL, CL.cliente_edad, M.MODELO_CODIGO, M.MODELO_FABRICANTE, M.MODELO_TIPO_AUTO, M.MODELO_TIPO_CAJA, 
	(select id from NAPOLITANA_CON_FRITAS.BI_Tipo_Motor where CODIGO_MOTOR = M.MODELO_TIPO_MOTOR), 
	M.MODELO_TIPO_TRANSMISION, 
	(CASE WHEN M.MODELO_POTENCIA BETWEEN 50 AND 150 THEN (SELECT TOP 1 P.ID FROM NAPOLITANA_CON_FRITAS.BI_Potencia_Rango P WHERE P.RANGO = '50-150cv')
		WHEN M.MODELO_POTENCIA BETWEEN 151 AND 300 THEN (SELECT TOP 1 P.ID FROM NAPOLITANA_CON_FRITAS.BI_Potencia_Rango P WHERE P.RANGO = '151-300cv')
		WHEN M.MODELO_POTENCIA > 300 THEN (SELECT TOP 1 P.ID FROM NAPOLITANA_CON_FRITAS.BI_Potencia_Rango P WHERE P.RANGO = '>300cv')
		ELSE NULL
	END)
	, AVG(ItF.ITEM_PRECIO), SUM(ItF.ITEM_CANTIDAD), AVG(Stock.DIAS_STOCK)
FROM NAPOLITANA_CON_FRITAS.Factura AS F
JOIN NAPOLITANA_CON_FRITAS.Item_Factura_Auto AS ItF ON F.FACTURA_NRO = ItF.ITEM_FACTURA_NRO
JOIN NAPOLITANA_CON_FRITAS.BI_Mes AS MES ON YEAR(F.FACTURA_FECHA) = MES.ANIO AND MONTH(F.FACTURA_FECHA) = MES.MES
JOIN NAPOLITANA_CON_FRITAS.Auto AS A ON A.AUTO_ID = ItF.ITEM_AUTO_ID
JOIN NAPOLITANA_CON_FRITAS.Modelo AS M ON A.AUTO_MODELO = M.MODELO_CODIGO
JOIN #ClienteRangoTemp AS CL ON CL.CLIENTE_ID = F.FACTURA_CLIENTE
JOIN #TiempoStockTemp As Stock ON Stock.AUTO_MODELO = M.MODELO_CODIGO
GROUP BY MES.ID, F.FACTURA_SUCURSAL, M.MODELO_CODIGO, M.MODELO_FABRICANTE, M.MODELO_TIPO_AUTO, M.MODELO_TIPO_CAJA, M.MODELO_TIPO_MOTOR, M.MODELO_TIPO_TRANSMISION, M.MODELO_POTENCIA, CL.cliente_edad

DROP TABLE #ClienteRangoTemp;
DROP TABLE #StockSucursalTemp;
DROP TABLE #TiempoStockTemp;
GO

-- Vista de Auto: Compras, Ventas y Ganancias, por Sucursal y Mes
CREATE VIEW NAPOLITANA_CON_FRITAS.VW_Auto_Cantidad_Ganancia AS
SELECT V.MES_ID, V.SUCURSAL_ID, SUM(V.CANTIDAD) AS CANTIDAD_VENDIDA, SUM(C.CANTIDAD) AS CANTIDAD_COMPRADA, SUM(V.PRECIO) - SUM(C.PRECIO) AS GANANCIAS
FROM NAPOLITANA_CON_FRITAS.BI_Venta_Auto AS V
JOIN NAPOLITANA_CON_FRITAS.BI_Compra_Auto AS C ON C.MODELO_ID = V.MODELO_ID
GROUP BY V.MES_ID, V.SUCURSAL_ID;
GO

-- Vista de Auto: promedios de Compras, Ventas por Modelo
CREATE VIEW NAPOLITANA_CON_FRITAS.VW_Auto_Stock_Precio_Promedio AS
SELECT V.MODELO_ID, AVG(V.PRECIO) AS PROMEDIO_VENDIDO, AVG(C.PRECIO) AS PROMEDIO_COMPRADO
FROM NAPOLITANA_CON_FRITAS.BI_Venta_Auto AS V
JOIN NAPOLITANA_CON_FRITAS.BI_Compra_Auto AS C ON C.MODELO_ID = V.MODELO_ID
GROUP BY V.MODELO_ID;
GO

-- Vista de Autoparte: Ganancias por Sucursal y Mes
CREATE VIEW NAPOLITANA_CON_FRITAS.VW_Autoparte_Ganancia AS
SELECT V.MES_ID, V.SUCURSAL_ID, SUM(V.PRECIO) - SUM(C.PRECIO) AS GANANCIAS
FROM NAPOLITANA_CON_FRITAS.BI_Venta_Autoparte AS V
JOIN NAPOLITANA_CON_FRITAS.BI_Compra_Autoparte AS C ON C.AUTOPARTE_ID = V.AUTOPARTE_ID
GROUP BY V.MES_ID, V.SUCURSAL_ID;
GO

-- Vista de Autoparte: precio promedio (venta y compra), por Autoparte
CREATE VIEW NAPOLITANA_CON_FRITAS.VW_Autoparte_Precio_Promedio AS
SELECT V.AUTOPARTE_ID, AVG(V.PRECIO) AS PROMEDIO_VENDIDO
FROM NAPOLITANA_CON_FRITAS.BI_Venta_Autoparte AS V
JOIN NAPOLITANA_CON_FRITAS.BI_Compra_Autoparte AS C ON C.AUTOPARTE_ID = V.AUTOPARTE_ID
GROUP BY V.AUTOPARTE_ID;
GO

-- Autoparte: Maximo stock anual por Sucursal
CREATE VIEW NAPOLITANA_CON_FRITAS.VW_Autoparte_Maximo_Stock AS
SELECT M.ANIO, C.SUCURSAL_ID, MAX(C.STOCK) AS MAXIMO_STOCK
FROM NAPOLITANA_CON_FRITAS.BI_Compra_Autoparte C 
JOIN NAPOLITANA_CON_FRITAS.BI_Mes M ON M.ID = C.MES_ID
GROUP BY M.ANIO, C.SUCURSAL_ID;
GO
