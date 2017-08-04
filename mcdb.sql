% http://www.nparikh.org/unix/mysql.php
% 

> mysql -u shadi -p
Enter password: shadi

create database miniconomy;
use miniconomy
create table ProductsGeneral(idprod tinyint not null primary key unsigned, name varchar(30), url varchar(75), unit decimal(4,2), size decimal(4,2), vat tinyint unsigned);
create table ProductsMyQty( idprod tinyint not null primary key unsigned, instock smallint unsigned, inshop smallint unsigned );

create table ShopsData(city varchar(30), street varchar(30), shopname varchar(30), shopnumber smallint, ownername varchar(30), qt smallint, pd varchar(30), px decimal(6,2)); # DONE

create table ShopsGeneral(idshop tinyint not null auto_increment primary key, name varchar(30), idcity tinyint unsigned, url varchar(75) ); # DONE
create table ShopsProducts(idshop tinyint not null primary key, idprod tinyint unsigned, price decimal(4,2), qty smallint unsigned, freespace decimal(4,2)); # DONE
#create table ShopsMy(idshop tinyint unsigned, name varchar(30), idcity tinyint unsigned, url varchar(75));

create table WarehouseProducts( idprod tinyint unsigned, qty smallint unsigned );

create table CitiesGeneral( idcity tinyint unsigned, name varchar(30) );
create table PortsGeneral( idport tinyint unsigned, idcity tinyint unsigned, url varchar(75) );
create table PortsTrips( idport tinyint unsigned, idcityFrom tinyint unsigned, idcityTo tinyint unsigned, price decimal(4,2), spaceavail decimal(4,2) );
create table DbMyState( timestamp date, cash decimal(4,2), bank decimal(4,2), pos smallint unsigned, idcity tinyint unsigned );
create table DbSynchronization( timestamp date, idcity tinyint unsigned );
create table Auctions( timestamp date, idprod tinyint unsigned, lastprice decimal(4,2), gotIt tinyint unsigned, profit decimal(4,2) );
create table ExIm( idprod tinyint unsigned, timepassed decimal(4,2), blocksize tinyint unsigned, blockprice decimal(4,2), numblocks smallint unsigned );
create table StocksGeneral( idstock tinyint unsigned, name varchar(10) );
create table StocksPrices( idstock tinyint unsigned, timestamp date, price decimal(4,2) );
create table StocksAccount( idstock tinyint unsigned, timestamp date, accountvalue decimal(4,2) );
