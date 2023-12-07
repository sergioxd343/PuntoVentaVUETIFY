DROP DATABASE puntoVenta;

CREATE DATABASE puntoVenta;
go
USE puntoVenta;
go


CREATE TABLE Productos(
	IDProducto		INT IDENTITY(1,1) PRIMARY KEY,
	NombreProducto	VARCHAR(50),
	PesoAproximado  FLOAT,
	Descripcion		VARCHAR(300),
	Foto			TEXT
);

CREATE TABLE Ventas (
    IDVenta INT IDENTITY(1,1) PRIMARY KEY,
	IDProducto				INT,
    FechaVenta				DATE,
	Total					FLOAT,
	FOREIGN KEY (IDProducto) REFERENCES Productos(IDProducto)
);



CREATE TABLE Presentacion(
	IDPresentacion			INT IDENTITY(1,1) PRIMARY KEY,
	IDProducto				INT,
	NombrePresentacion		VARCHAR(50),
	PrecioPresentacion		FLOAT,
	Descripcion				VARCHAR(300),
	FOREIGN KEY (IDProducto) REFERENCES Productos(IDProducto)
);


-- Insertar datos en la tabla Productos
INSERT INTO Productos (NombreProducto, PesoAproximado, Descripcion, Foto)
VALUES
    ('Producto A', 2.5, 'Descripci�n del Producto A', 'URL_Foto_A'),
    ('Producto B', 1.8, 'Descripci�n del Producto B', 'URL_Foto_B'),
    ('Producto C', 3.2, 'Descripci�n del Producto C', 'URL_Foto_C');

-- Insertar datos en la tabla Ventas
INSERT INTO Ventas (IDProducto, FechaVenta,Total)
VALUES
    (1, '2023-01-01', 122.00),
    (2, '2023-02-15',200.00),
    (3, '2023-01-20', 150.00);

-- Insertar datos en la tabla Presentacion
INSERT INTO Presentacion (IDProducto, NombrePresentacion, PrecioPresentacion, Descripcion)
VALUES
    (1, 'Presentaci�n 1A', 10.5, 'Descripci�n Presentaci�n 1A'),
    (2, 'Presentaci�n 2B', 8.2, 'Descripci�n Presentaci�n 2B'),
    (3, 'Presentaci�n 3C', 12.0, 'Descripci�n Presentaci�n 3C');


select Total from Ventas order by FechaVenta ASC;
select Total from Ventas order by FechaVenta ASC;
select * from Productos;
select * from Presentacion;