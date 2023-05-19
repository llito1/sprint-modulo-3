-- se crea la base de datos con el nombre 'sprint_telovendo'
create database sprint_telovendo;
-- se le indica al gestor de base de datos con cual BD vamos a trabajar en adelante
use sprint_telovendo;
-- se crea la tabla proveedores
create table proveedores (
	id_proveedor int(20) primary key auto_increment,
    nombre_representante varchar(50),
    nombre_comercial varchar(50),
    categoria_productos int(20),
    mail_facturas varchar(50)
    ) engine InnoDB;
-- se crea la tabla contactos
create table contactos (
	id_proveedor int(20),
    nombre varchar(50),
    fono int(15),
    FOREIGN KEY (id_proveedor) REFERENCES sprint_telovendo.proveedores (id_proveedor)
) engine InnoDB;
-- se crea la tabla categorias
create table categorias (
	categoria_id int(10) primary key auto_increment,
    nombre varchar(50)
) engine InnoDB;
-- se crea la tabla productos
create table productos (
	id_producto int(20) primary key auto_increment,
    nombre varchar(50), 
    descripcion text,
    color varchar(10),
    categoria_id int(10),
    id_proveedor int (20),
    stock int(10),
    precio decimal(20,2),
    FOREIGN KEY (categoria_id) REFERENCES sprint_telovendo.categorias (categoria_id)
) engine InnoDB;
-- se crea la tabla de stock_proveedores, para tener el stock de cada producto por cada proveedor
create table stock_proveedores (
    producto_id int(20),
    proveedor_id int(20),
    stock int(20),
    FOREIGN KEY (producto_id) REFERENCES sprint_telovendo.productos (id_producto),
    FOREIGN KEY (proveedor_id) REFERENCES sprint_telovendo.proveedores (id_proveedor),
    primary key (producto_id, proveedor_id)
);
-- se crea la tabla clientes
create table clientes(
	id_cliente int(20) primary key auto_increment,
    nombre varchar(50),
    apellido varchar(50),
    direccion varchar(50)
) engine InnoDB;
-- se crea la tabla intermedia de clientes con productos para ver los productos que ha comprado
create table cliente_productos(
	cliente_id int(20),
    producto_id int(20),
    cantidad decimal(20,2),
    FOREIGN KEY (producto_id) REFERENCES sprint_telovendo.productos (id_producto),
    FOREIGN KEY (cliente_id) REFERENCES sprint_telovendo.clientes (id_cliente),
    primary key (cliente_id, producto_id)
);

-- se insertan los clientes requeridos para el ejercicio
INSERT INTO clientes(nombre, apellido, direccion) VALUES
	('Roberto','Hernandez','Monte #325'),
	('Luis','Galvez','Santiago #104'),
	('Joe','Montes','Chels #55'),
	('Manuel','Pansez','Puerto Hell #666'),
	('Sofia','Turin','Yaleri #98');
-- se insertan los proveedores requeridos para el ejercicio
insert into proveedores (nombre_representante, nombre_comercial, categoria_productos, mail_facturas) values 
	('Jose Antonio', 'Smartech', 1, 'smartech@facturas.cl'),
    ('Marco Aurelio', 'ABCDIN', 2, 'ABCDIN@facturas.cl'),
    ('Pedro Donoso', 'Hites', 3, 'Hites@facturas.cl'),
    ('Felipe Kast', 'Falabella', 4, 'Falabella@facturas.cl'),
    ('Kenita Larrain', 'Paris', 5, 'Paris@facturas.cl');
-- se insertan los contactos de los proveedores requeridos para el ejercicio
insert into contactos (id_proveedor, nombre, fono) values 
	(1, 'maria', 111111),
    (1, 'roxana', 222222),
    (2, 'alondra', 333333),
    (2, 'consuelo', 444444),
    (3, 'irma', 555555),
    (3, 'claudia', 777777),
    (4, 'beatriz', 888888),
    (4, 'karina', 999999),
    (5, 'marianela', 123456),
    (5, 'romina', 654321);
-- se insertan las categorias de los productos
insert into categorias (nombre) values
	('Celulares'),
    ('Laptops'),
    ('Linea blanca'),
    ('Electrodomesticos de cocina'),
    ('Lavado y secado'),
    ('accesorios celular'),
    ('Iluminación'),
    ('Accesorios computacion'),
    ('Articulos de escritorio'),
    ('Varios');
-- se insertan los productos
INSERT INTO productos(nombre, descripcion, color, categoria_id, id_proveedor, stock, precio ) VALUES
('cargador normal', 'descripción del producto', 'violeta',1, 1, 14, 25000 ),
('cargador inalambrico', 'descripción del producto', 'rojo',2, 2, 10, 35000 ),
('galaxy s21', 'descripción del producto', 'azul',1, 3, 25, 95000 ),
('nokia 3395', 'descripción del producto', 'azul',1, 3, 10, 105000 ),
('nokia 3396', 'descripción del producto', 'negro',4, 6, 36, 455000 ),
('plancha a vapor', 'descripción del producto', 'blanco',8, 5, 95, 84000 ),
('lavadora frontal', 'descripción del producto', 'blanco',8, 5, 95, 83000 ),
('lavadora superior', 'descripción del producto', 'blanco',8, 5, 95, 82000 ),
('secadora', 'descripción del producto', 'blanco',8, 5, 95, 81000 ),
('laptop dell', 'descripción del producto', 'verde',7, 4, 7, 91000 );
-- se inserta el stock de cada producto para cada proveedor
insert into stock_proveedores (producto_id, proveedor_id, stock) values
	(1, 1, 345), (1, 2, 125), (1, 3, 845), (1, 4, 654), (1, 5, 132),
    (2, 1, 345), (2, 2, 423), (2, 3, 354), (2, 4, 347), (2, 5, 321),
    (3, 1, 351), (3, 2, 254), (3, 3, 268), (3, 4, 134), (3, 5, 159),
    (4, 1, 265), (4, 2, 478), (4, 3, 152), (4, 4, 314), (4, 5, 247),
    (5, 1, 652), (5, 2, 458), (5, 3, 758), (5, 4, 874), (5, 5, 324);

-- Cuál es la categoría de productos que más se repite.
select productos.categoria_id, count(productos.categoria_id) as repetidos, categorias.nombre from productos
inner join categorias on productos.categoria_id = categorias.categoria_id
 group by productos.categoria_id order by repetidos desc;
 -- para nuestro trabajo la categoria mas repetida es la Accesorios computacion
 
-- Cuáles son los productos con mayor stock
select * from productos order by stock desc;
 -- para nuestro trabajo el producto con mas stock son 4, plancha a vapor, lavadora fronta, lavadora superior y secadora, todos estos productos con un stock de 95 unidades

-- Qué color de producto es más común en nuestra tienda.
select id_producto, color, count(color) as repetidos from productos group by color order by repetidos desc;
-- para nuestro trabajo el color mas repetido es el color blanco.

-- Cual o cuales son los proveedores con menor stock de productos.
select proveedores.id_proveedor, proveedores.nombre_comercial, stock_proveedores.producto_id, productos.nombre, stock_proveedores.stock from proveedores
inner join stock_proveedores on proveedores.id_proveedor = stock_proveedores.proveedor_id
inner join productos on stock_proveedores.producto_id = productos.id_producto
order by stock_proveedores.stock asc;
-- para nuestro trabajo, el producto que cuenta con menor stock por parte de los proveedores es el cargador normal, con un stock de 125 con el proveedor ABCDIN

-- Cambien la categoría de productos más popular por ‘Electrónica y computación’.
UPDATE categorias
SET nombre = 'Electrónica y computación'
WHERE categoria_id = (
  SELECT productos.categoria_id
  FROM productos
  GROUP BY productos.categoria_id
  ORDER BY COUNT(*) DESC
  LIMIT 1
);