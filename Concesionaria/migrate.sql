-- Se cargan datos de la tabla 'cliente'
insert into gd_esquema.Cliente(CLIENTE_APELLIDO,CLIENTE_NOMBRE,CLIENTE_DIRECCION,CLIENTE_DNI,CLIENTE_FECHA_NAC,CLIENTE_MAIL) 
select distinct CLIENTE_APELLIDO,CLIENTE_NOMBRE,CLIENTE_DIRECCION,CLIENTE_DNI,CLIENTE_FECHA_NAC,CLIENTE_MAIL 
from gd_esquema.Maestra;

-- Se cargan datos de la tabla 'sucursal'
insert into gd_esquema.Sucursal(SUCURSAL_ID,SUCURSAL_DIRECCION,SUCURSAL_MAIL,SUCURSAL_TELEFONO,SUCURSAL_CIUDAD)
select distinct CAST(SUBSTRING(SUCURSAL_MAIL, 12, 1) as numeric), SUCURSAL_DIRECCION, SUCURSAL_MAIL, SUCURSAL_TELEFONO, SUCURSAL_CIUDAD
from gd_esquema.Maestra
where SUCURSAL_MAIL is not null;

-- Se cargan datos de la tabla 'tipo_auto'
insert into gd.esquema.Tipo_Auto(TIPO_AUTO_CODIGO,TIPO_AUTO_DESC)
select distinct (tipo_auto_codigo), tipo_auto_desc
from gd_esquema.Maestra;
