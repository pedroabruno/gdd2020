-- Se cargan datos de la tabla 'cliente'
insert into gd_esquema.Cliente(CLIENTE_APELLIDO,CLIENTE_NOMBRE,CLIENTE_DIRECCION,CLIENTE_DNI,CLIENTE_FECHA_NAC,CLIENTE_MAIL) 
select distinct CLIENTE_APELLIDO,CLIENTE_NOMBRE,CLIENTE_DIRECCION,CLIENTE_DNI,CLIENTE_FECHA_NAC,CLIENTE_MAIL 
from gd_esquema.Maestra
where CLIENTE_APELLIDO is not null
union
select distinct FAC_CLIENTE_APELLIDO,FAC_CLIENTE_NOMBRE,FAC_CLIENTE_DIRECCION,FAC_CLIENTE_DNI,FAC_CLIENTE_FECHA_NAC,FAC_CLIENTE_MAIL 
from gd_esquema.Maestra m
where FAC_CLIENTE_APELLIDO is not null;
CREATE INDEX IX_CLIENTE_DNI ON gd_esquema.Cliente(CLIENTE_DNI);

-- Se cargan datos de la tabla 'sucursal'
insert into gd_esquema.Sucursal(SUCURSAL_ID,SUCURSAL_DIRECCION,SUCURSAL_MAIL,SUCURSAL_TELEFONO,SUCURSAL_CIUDAD)
select distinct CAST(SUBSTRING(SUCURSAL_MAIL, 12, 1) as numeric), SUCURSAL_DIRECCION, SUCURSAL_MAIL, SUCURSAL_TELEFONO, SUCURSAL_CIUDAD
from gd_esquema.Maestra
where SUCURSAL_MAIL is not null;

-- Se cargan datos de la tabla 'tipo_auto'
insert into gd_esquema.Tipo_Auto(TIPO_AUTO_CODIGO,TIPO_AUTO_DESC)
select distinct tipo_auto_codigo, tipo_auto_desc
from gd_esquema.Maestra
where tipo_auto_codigo is not null;

-- Se cargan datos de la tabla 'tipo_transmision'
insert into gd_esquema.Tipo_Transmision(TIPO_TRANSMISION_CODIGO,TIPO_TRANSMISION_DESC)
select distinct TIPO_TRANSMISION_CODIGO, TIPO_TRANSMISION_DESC
from gd_esquema.Maestra
where TIPO_TRANSMISION_CODIGO is not null;

-- Se cargan datos de la tabla 'tipo_caja'
insert into gd_esquema.Tipo_Caja(TIPO_CAJA_CODIGO,TIPO_CAJA_DESC)
select distinct TIPO_CAJA_CODIGO, TIPO_CAJA_DESC
from gd_esquema.Maestra
where TIPO_CAJA_CODIGO is not null;

-- Se cargan datos de la tabla 'fabricante'
insert into gd_esquema.Fabricante(FABRICANTE_NOMBRE)
select distinct FABRICANTE_NOMBRE
from gd_esquema.Maestra
where FABRICANTE_NOMBRE is not null;

-- Se cargan datos de la tabla 'modelo'
insert into gd_esquema.Modelo(MODELO_CODIGO,MODELO_NOMBRE,MODELO_FABRICANTE,MODELO_TIPO_TRANSMISION,MODELO_TIPO_CAJA,MODELO_TIPO_MOTOR,MODELO_TIPO_AUTO)
select distinct MODELO_CODIGO,MODELO_NOMBRE,f.fabricante_id,TIPO_TRANSMISION_CODIGO,TIPO_CAJA_CODIGO,TIPO_MOTOR_CODIGO,TIPO_AUTO_CODIGO
from gd_esquema.Maestra m
join gd_esquema.Fabricante f on f.FABRICANTE_NOMBRE = m.FABRICANTE_NOMBRE
where MODELO_CODIGO is not null and TIPO_AUTO_CODIGO is not null;

-- Se cargan datos de la tabla 'auto'
insert into gd_esquema.Auto(AUTO_NRO_CHASIS,AUTO_NRO_MOTOR,AUTO_PATENTE,AUTO_FECHA_ALTA,AUTO_CANT_KMS,AUTO_MODELO)
select distinct AUTO_NRO_CHASIS,AUTO_NRO_MOTOR,AUTO_PATENTE,AUTO_FECHA_ALTA,AUTO_CANT_KMS,MODELO_CODIGO
from gd_esquema.Maestra
where AUTO_NRO_CHASIS is not null;

-- Se cargan datos de la tabla 'autoparte'
INSERT INTO gd_esquema.Autoparte(AUTOPARTE_CODIGO, AUTOPARTE_DESCRIPCION, AUTOPARTE_MODELO)
SELECT DISTINCT AUTO_PARTE_CODIGO, AUTO_PARTE_DESCRIPCION, MODELO_CODIGO
FROM gd_esquema.Maestra
WHERE AUTO_PARTE_CODIGO IS NOT NULL;

-- Se cargan datos de Compras
begin
	select 
		CLIENTE_APELLIDO,CLIENTE_DNI,CLIENTE_MAIL,
		COMPRA_NRO,COMPRA_FECHA,COMPRA_CANT,COMPRA_PRECIO,
		CAST(SUBSTRING(SUCURSAL_MAIL, 12, 1) as numeric) AS sucursal, 
		(select a.AUTO_ID from gd_esquema.Auto a where a.AUTO_PATENTE = m.AUTO_PATENTE) AS auto_id, 
		AUTO_PARTE_CODIGO AS AUTOPARTE_ID
	into #tempCompras
	from gd_esquema.Maestra m
	where FACTURA_NRO is null;
	
	insert into gd_esquema.Compra(COMPRA_CLIENTE,COMPRA_NRO,COMPRA_FECHA,COMPRA_PRECIO,COMPRA_SUCURSAL)
	select 
		(select CLIENTE_ID from gd_esquema.Cliente c where c.CLIENTE_APELLIDO = t.CLIENTE_APELLIDO and c.CLIENTE_DNI = t.CLIENTE_DNI and c.CLIENTE_MAIL = t.CLIENTE_MAIL) cliente,
		COMPRA_NRO,
		COMPRA_FECHA,
		sum(isnull(COMPRA_CANT,1)*COMPRA_PRECIO) precio,
		sucursal
	from #tempCompras t
	group by CLIENTE_APELLIDO,CLIENTE_DNI,CLIENTE_MAIL,COMPRA_NRO,COMPRA_FECHA,sucursal;

	-- Se cargan datos de la tabla 'Compra_Auto'
	INSERT INTO gd_esquema.Item_Compra_Auto (ITEM_COMPRA_NRO, ITEM_AUTO_ID, ITEM_CANTIDAD, ITEM_PRECIO)
	SELECT COMPRA_NRO, AUTO_ID, ISNULL(COMPRA_CANT,1), COMPRA_PRECIO
	FROM #tempCompras
	WHERE AUTO_ID IS NOT NULL
	GROUP BY COMPRA_NRO,AUTO_ID,COMPRA_PRECIO;

	-- Se cargan datos de la tabla 'Compra_Autoparte'
	INSERT INTO gd_esquema.Item_Compra_Autoparte (ITEM_COMPRA_NRO, ITEM_AUTOPARTE_ID, ITEM_CANTIDAD, ITEM_PRECIO)
	SELECT COMPRA_NRO, AUTOPARTE_ID, SUM(COMPRA_CANT), COMPRA_PRECIO
	FROM #tempCompras
	WHERE AUTOPARTE_ID IS NOT NULL
	GROUP BY COMPRA_NRO,AUTOPARTE_ID,COMPRA_PRECIO;

	drop table #tempCompras
end


-- Se cargan datos de la tabla 'factura'
INSERT INTO gd_esquema.Factura(FACTURA_NRO, FACTURA_FECHA, FACTURA_SUCURSAL, FACTURA_CLIENTE, FACTURA_PRECIO)
SELECT DISTINCT M.FACTURA_NRO, M.FACTURA_FECHA, CAST(SUBSTRING(M.FAC_SUCURSAL_MAIL,12,1) AS NUMERIC), C.CLIENTE_ID, NULL 
FROM gd_esquema.Maestra M
JOIN gd_esquema.Cliente C ON C.CLIENTE_DNI = M.FAC_CLIENTE_DNI AND C.CLIENTE_APELLIDO = M.FAC_CLIENTE_APELLIDO AND C.CLIENTE_NOMBRE = M.FAC_CLIENTE_NOMBRE
	AND C.CLIENTE_DIRECCION = M.FAC_CLIENTE_DIRECCION AND C.CLIENTE_FECHA_NAC = M.FAC_CLIENTE_FECHA_NAC
	AND C.CLIENTE_MAIL = M.FAC_CLIENTE_MAIL
WHERE FACTURA_NRO IS NOT NULL;

-- Se cargan datos de la tabla 'Item_Factura_Auto'
INSERT INTO gd_esquema.Item_Factura_Auto(ITEM_FACTURA_NRO, ITEM_AUTO_ID, ITEM_PRECIO)
SELECT DISTINCT M.FACTURA_NRO, A.AUTO_ID, M.PRECIO_FACTURADO
FROM gd_esquema.Maestra M
JOIN gd_esquema.Auto A ON A.AUTO_NRO_CHASIS = M.AUTO_NRO_CHASIS AND A.AUTO_NRO_MOTOR = M.AUTO_NRO_MOTOR 
    AND A.AUTO_PATENTE = M.AUTO_PATENTE AND A.AUTO_FECHA_ALTA = M.AUTO_FECHA_ALTA 
    AND A.AUTO_CANT_KMS = M.AUTO_CANT_KMS AND A.AUTO_MODELO = M.MODELO_CODIGO
WHERE M.FACTURA_NRO IS NOT NULL;

-- Se cargan datos de la tabla 'Item_Factura_Autoparte'
INSERT INTO gd_esquema.Item_Factura_Autoparte(ITEM_FACTURA_NRO, ITEM_AUTOPARTE_ID, ITEM_CANTIDAD, ITEM_PRECIO)
SELECT DISTINCT FACTURA_NRO, AUTO_PARTE_CODIGO, SUM(CANT_FACTURADA), PRECIO_FACTURADO
FROM gd_esquema.Maestra
WHERE FACTURA_NRO IS NOT NULL AND AUTO_PARTE_CODIGO IS NOT NULL
GROUP BY FACTURA_NRO, AUTO_PARTE_CODIGO, PRECIO_FACTURADO;

-- Update precio total de facturas
CREATE TABLE #PrecioFacturaTemp (
	FACTURA_NRO DECIMAL(18,0),
	PRECIO DECIMAL(18,2)
)

INSERT INTO #PrecioFacturaTemp
SELECT T.ITEM_FACTURA_NRO, SUM(T.PrecioItem)
FROM (SELECT ITEM_FACTURA_NRO, ITEM_CANTIDAD * ITEM_PRECIO AS PrecioItem FROM gd_esquema.Item_Factura_Auto) T
GROUP BY T.ITEM_FACTURA_NRO;

INSERT INTO #PrecioFacturaTemp
SELECT ITEM_FACTURA_NRO, SUM(T.PrecioItem)
FROM (SELECT ITEM_FACTURA_NRO, ITEM_CANTIDAD * ITEM_PRECIO AS PrecioItem FROM gd_esquema.Item_Factura_Autoparte) T
GROUP BY T.ITEM_FACTURA_NRO;


UPDATE gd_esquema.Factura
SET FACTURA_PRECIO = T.Precio
FROM gd_esquema.Factura F
JOIN #PrecioFacturaTemp T ON T.FACTURA_NRO = F.FACTURA_NRO;

DROP TABLE #PrecioFacturaTemp;
