CREATE DATABASE Vinito;
GO

USE Vinito;
GO

CREATE TABLE DocumentoIdentidad (
    id_documento INT PRIMARY KEY,
    tipo_documento VARCHAR(30) NOT NULL,
    longitud INT NOT NULL 
);

CREATE TABLE Persona (
    id_persona INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(50) NOT NULL,
    apellido_paterno VARCHAR(50) NOT NULL,
    apellido_materno VARCHAR(50) NOT NULL,
    id_documento INT NOT NULL,
    numero_documento VARCHAR(15) NOT NULL,
    tipo_persona VARCHAR(20) NOT NULL,
    correo VARCHAR(50),
    telefono VARCHAR(15),
    direccion VARCHAR(100),

    CONSTRAINT FK_Persona_Documento FOREIGN KEY (id_documento) REFERENCES DocumentoIdentidad(id_documento),
    CONSTRAINT UQ_Persona_Documento UNIQUE (id_documento, numero_documento)
);

CREATE TABLE Cliente (
    id_persona INT PRIMARY KEY,
    fecha_registro DATE DEFAULT GETDATE(),

    CONSTRAINT FK_Cliente_Persona FOREIGN KEY (id_persona) REFERENCES Persona(id_persona)
);

CREATE TABLE Proveedor (
    id_persona INT PRIMARY KEY,
    empresa VARCHAR(100),

    CONSTRAINT FK_Proveedor_Persona FOREIGN KEY (id_persona) REFERENCES Persona(id_persona)
);

CREATE TABLE Empleado (
    id_persona INT PRIMARY KEY,
    fecha_contratacion DATE NOT NULL,
    puesto VARCHAR(50) NOT NULL,
    salario MONEY NOT NULL,

    CONSTRAINT FK_Empleado_Persona FOREIGN KEY (id_persona) REFERENCES Persona(id_persona)
);

CREATE TABLE Categoria (
    id_categoria INT PRIMARY KEY IDENTITY(1,1),
    nombre_categoria VARCHAR(30) NOT NULL UNIQUE,
    descripcion TEXT
);

CREATE TABLE Producto (
    id_producto INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT,
    precio_compra MONEY,
    precio_venta MONEY,
    stock_actual INT,
    id_categoria INT,
    tipo_producto VARCHAR(30),

    FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)
);

CREATE TABLE BebidaAlcoholica (
    id_producto INT PRIMARY KEY,
    tipo_bebida VARCHAR(30),
    fecha_elaboracion DATE,
    pais_origen VARCHAR(30),
    productor VARCHAR(50),
    grado_alcohol DECIMAL(4,2),

    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

CREATE TABLE Accesorio (
    id_producto INT PRIMARY KEY,
    material VARCHAR(50),
    color VARCHAR(30),
    dimensiones VARCHAR(50),
    tipo_accesorio VARCHAR(30),

    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

CREATE TABLE Venta (
    id_venta INT PRIMARY KEY IDENTITY(1,1),
    id_persona INT NOT NULL,
    fecha DATE,
    total MONEY,
    metodo_pago VARCHAR(30),

    CONSTRAINT FK_Venta_Persona FOREIGN KEY (id_persona) REFERENCES Persona(id_persona)
);

CREATE TABLE DetalleVenta (
    id_detalle INT PRIMARY KEY IDENTITY(1,1),
    id_venta INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT,
    precio_unitario MONEY,
    subtotal MONEY,

    CONSTRAINT FK_DetalleVenta_Venta FOREIGN KEY (id_venta) REFERENCES Venta(id_venta),
    CONSTRAINT FK_DetalleVenta_Producto FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

CREATE TABLE Entrada (
    id_entrada INT PRIMARY KEY IDENTITY(1,1),
    id_persona INT NOT NULL,
    fecha DATE NOT NULL,
    tipo_entrada VARCHAR(30), 
    total MONEY,

    CONSTRAINT FK_Entrada_Persona FOREIGN KEY (id_persona) REFERENCES Persona(id_persona)
);

CREATE TABLE DetalleEntrada (
    id_detalle INT PRIMARY KEY IDENTITY(1,1),
    id_entrada INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario MONEY NOT NULL,
    subtotal MONEY NOT NULL,

    CONSTRAINT FK_DetalleEntrada_Entrada FOREIGN KEY (id_entrada) REFERENCES Entrada(id_entrada),
    CONSTRAINT FK_DetalleEntrada_Producto FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

CREATE TABLE Historico (
    id_historico INT PRIMARY KEY IDENTITY(1,1),
    tabla_afectada VARCHAR(50) NOT NULL,       
    id_registro INT NOT NULL,                  
    accion VARCHAR(10) NOT NULL,               
    fecha_hora DATETIME DEFAULT GETDATE(),     
    id_empleado INT,
    descripcion TEXT,

    CONSTRAINT FK_Historico_Empleado FOREIGN KEY (id_empleado) REFERENCES Empleado(id_persona)
);

CREATE TABLE Rol (
    id_rol INT PRIMARY KEY IDENTITY(1,1),
    nombre_rol VARCHAR(50) NOT NULL UNIQUE,
    descripcion TEXT
);

CREATE TABLE Permiso (
    id_permiso INT PRIMARY KEY IDENTITY(1,1),
    nombre_permiso VARCHAR(50) NOT NULL UNIQUE,
    descripcion TEXT
);

CREATE TABLE Rol_Permiso (
    id_rol INT NOT NULL,
    id_permiso INT NOT NULL,

    PRIMARY KEY (id_rol, id_permiso),
    FOREIGN KEY (id_rol) REFERENCES Rol(id_rol),
    FOREIGN KEY (id_permiso) REFERENCES Permiso(id_permiso)
);

CREATE TABLE Empleado_Rol (
    id_persona INT NOT NULL,
    id_rol INT NOT NULL,

    PRIMARY KEY (id_persona, id_rol),
    FOREIGN KEY (id_persona) REFERENCES Empleado(id_persona),
    FOREIGN KEY (id_rol) REFERENCES Rol(id_rol)
);

