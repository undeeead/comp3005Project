create table bookStoreStock(isbn integer unique primary key, inStock integer);
create table author(id integer primary key, fname varchar(25), lname varchar(25));
create table publishers(id integer primary key, companyName varchar(50), adr varchar(50), email varchar(50), phoneNumber integer, bankAccount varchar(50), percentageSales decimal);
create table genres(id integer primary key, genreType varchar(50));
create table usersInfo(id integer primary key, fname varchar(50), lname varchar(50), billingAddress varchar(50), shippingAddress varchar(50));
create table books(isbn serial primary key, title varchar(50), authorId integer, publisherId integer, numPages integer, cost decimal, genreId integer);
create table orders(orderId serial primary key, idBuyer integer, trackingNum varchar(50));
create table booksSold(isbn integer primary key, saleAmount integer);
create table shoppingCart(id serial primary key, userId integer, isbn integer);
