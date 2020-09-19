--Creacion de estructuras
CREATE TABLE gd_esquema.Cliente
(ID_CLIENTE [numeric](12, 0) NOT NULL IDENTITY(1,1),
CLIENTE_APELLIDO [nvarchar](255) NULL,
CLIENTE_NOMBRE [nvarchar](255) NULL,
CLIENTE_DIRECCION [nvarchar](255) NULL,
CLIENTE_DNI [decimal](18, 0),
CLIENTE_FECHA_NAC [datetime2](3) NULL,
CLIENTE_MAIL [nvarchar](255) NULL,
PRIMARY KEY (ID_CLIENTE));

CREATE TABLE gd_esquema.Sucursal
(ID_SUCURSAL [numeric](4, 0) NOT NULL,
SUCURSAL_DIRECCION [nvarchar](255) NULL,
SUCURSAL_MAIL [nvarchar](255) NULL,
SUCURSAL_TELEFONO [decimal](18, 0) NULL,
SUCURSAL_CIUDAD [nvarchar](255) NULL,
PRIMARY KEY (ID_SUCURSAL));
