-- make product table
create table product();

alter table product
add column ProductId int,
add column Name varchar(200),
add column Description varchar(500),
add column UnitWeight int,
add column UnitVolume int,
add column Dimensions int;

alter table product
add primary key (ProductId);

-- make site table
create table site (
	SiteId int primary key,
	name varchar(200),
	type varchar(200),
	adress varchar(200),
	region varchar(200),
	capacity int
	);

-- make inventory table
create table inventory (
	InventoryId int,  
	ProductId int,
	SiteId int,
	QuantityOnHand int,
	QuantityAvailable int,
	ReservedQty int,
	ExpiryDate date,
	primary key (InventoryId),
	foreign key (ProductId) references product(ProductId),
	foreign key (SiteId) references site(SiteId)
);

-- already make the supplier table using user interface
-- make supplier table
alter table supplier 
add column name varchar(200),
add column adress varchar(200),
add column contactinfo varchar(200),
add column region varchar(200),
add column leadtimedays int;

-- make customer table
create table customer (
	customerid int primary key,
	name varchar(200),
	adress varchar(200),
	email varchar(200),
	phone varchar(200)
	);


-- make carrier table
create table carrier (
	carrierid int primary key,
	name varchar(200),
	contactinfo varchar(200),
	region varchar(200),
	performancerating int
	);

-- make product category table
create table productcategory (
	productcategoryid int primary key,
	productid int,
	productcategory varchar(200),
	foreign key (productid) references product (productid)
	);

-- make purchase order table
create table purchaseorder (
	po_id int primary key,
	supplierid int,
	foreign key (supplierid) references supplier (supplierid),
	orderdate timestamp,
	expecteddeliveudate timestamp,
	status varchar(200),
	totalqty int
	);

-- make shipment lot table
create table shipment_lot (
	shipmentlotid int primary key,
	inboundshipmentid int,
	foreign key (inboundshipmentid) references inbound_shipment (inboundshipmentid),
	productid int,
	foreign key (productid) references product (productid),
	lot_number int,
	quantity int,
	manufacturingdate date,
	expirydate date
	);

-- make inbound shipment table
create table inbound_shipment (
	inboundshipmentid int primary key,
	po_id int,
	foreign key (po_id) references purchaseorder (po_id),
	supplierid int,
	foreign key (supplierid) references supplier (supplierid),
	shiptositeid int,
	foreign key (shiptositeid) references site (SiteId),
	scheduled_arrival timestamp,
	actual_arrival timestamp,
	carrierid int,
	foreign key (carrierid) references carrier (carrierid),
	transport_mode varchar(200),
	status varchar(200)
	);

-- make customer order table
create table customer_order (
	order_id int primary key,
	customerid int,
	foreign key (customerid) references customer (customerid),
	orderdate timestamp,
	orderstatus varchar(200),
	totalvalue decimal (100,2),
	shippingaddress varchar(200),
	paymentmethod varchar(200)
	);
	
-- make order line table
create table order_line (
	order_line_id int primary key,
	order_id int,
	foreign key (order_id) references customer_order (order_id),
	productid int,
	foreign key (productid) references product (productid),
	quantity_order int,
	price_per_unit decimal (100,2),
	discount decimal (3,2),
	line_status varchar (200)
	);
	

-- make outbund shipment table
create table outbound_shipment (
	outbound_shipment_id int primary key,
	order_id int,
	foreign key (order_id) references customer_order (order_id),
	ship_from_site_id int,
	foreign key (ship_from_site_id) references site (siteid),
	carrierid int,
	foreign key (carrierid) references carrier (carrierid),
	productid int,
	foreign key (productid) references product (productid),
	qty_shipped int,
	expected_ship_date timestamp,
	actual_ship_date timestamp,
	tracking_number varchar (200),
	shipment_status varchar(200),
	delivery_date timestamp
	);
	

-- make returns table
create table returns (
	return_id int primary key,
	order_id int,
	foreign key (order_id) references customer_order (order_id),
	order_line_id int,
	foreign key (order_line_id) references order_line (order_line_id),
	productid int,
	foreign key (productid) references product (productid),
	qty_returned int,
	return_reason varchar(200),
	return_date timestamp,
	refund_status varchar(200),
	restock_status varchar(200),
	warehouse_destination int,
	foreign key (warehouse_destination) references site (siteid)
	);