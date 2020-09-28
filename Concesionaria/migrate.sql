declare @cliDNI decimal(18, 0),
		@cliApellido nvarchar(255),
		@cliNombre nvarchar(255),
		@cliDireccion nvarchar(255),
		@cliFechaNac datetime2(3),
		@cliMail nvarchar(255)

declare CUR cursor for 
		SELECT distinct CLIENTE_DNI,CLIENTE_APELLIDO,CLIENTE_NOMBRE,CLIENTE_DIRECCION,CLIENTE_FECHA_NAC,CLIENTE_MAIL
		from gd_esquema.Maestra
		WHERE CLIENTE_DNI IS NOT NULL;

OPEN CUR
	fetch CUR into @cliDNI,@cliApellido,@cliNombre,@cliDireccion,@cliFechaNac,@cliMail
	while @@FETCH_STATUS = 0
	BEGIN
	insert into gd_esquema.Cliente(CLIENTE_APELLIDO,CLIENTE_NOMBRE,CLIENTE_DIRECCION,CLIENTE_DNI,CLIENTE_FECHA_NAC,CLIENTE_MAIL) 
	values (@cliApellido,@cliNombre,@cliDireccion,@cliDNI,@cliFechaNac,@cliMail)
	fetch CUR into @cliDNI,@cliApellido,@cliNombre,@cliDireccion,@cliFechaNac,@cliMail
	end	
	CLOSE CUR
	DEALLOCATE CUR
	
	

declare @sucId numeric(4, 0),
		@sucDireccion nvarchar(255),
		@sucMail nvarchar(255),
		@sucTelefono decimal(18,0),
		@sucCiudad nvarchar(255)

declare CUR cursor for 
		select distinct SUBSTRING(SUCURSAL_MAIL, 12, 1), SUCURSAL_DIRECCION, SUCURSAL_MAIL, SUCURSAL_TELEFONO, SUCURSAL_CIUDAD 
		from gd_esquema.Maestra
		where SUCURSAL_DIRECCION is not null;

OPEN CUR
	fetch CUR into @sucId,@sucDireccion,@sucMail,@sucTelefono,@sucCiudad
	while @@FETCH_STATUS = 0
	BEGIN
	insert into gd_esquema.Sucursal(SUCURSAL_ID,SUCURSAL_DIRECCION,SUCURSAL_MAIL,SUCURSAL_TELEFONO,SUCURSAL_CIUDAD) 
	values (@sucId,@sucDireccion,@sucMail,@sucTelefono,@sucCiudad)
	fetch CUR into @sucId,@sucDireccion,@sucMail,@sucTelefono,@sucCiudad
	end	
	CLOSE CUR
	DEALLOCATE CUR