insert into tabel_barang (kode_barang,nama_barang,deskripsi_barang,harga_barang) values ('kb02','Thompson','SMG',3000000);
insert into tabel_barang (kode_barang,nama_barang,deskripsi_barang,harga_barang) values ('kb03','M16','AR',4500000);

-- update 
update tabel_barang set nama_barang='M4' where kode_barang ='kb03';

-- ubah nama kolom
alter table tabel_barang rename column deskripsi_barang to tipe;
-- ubah nama tabel 
alter table tabel_barang rename to weapons;

-- tambah kolom 
ALTER TABLE weapons ADD COLUMN stock INT;
insert into weapons (kode_barang,nama_barang,tipe,harga_barang,stock) values ('kb04','AWM','SNIPER',5000000,2);

-- select * from weapons order by nama_barang  asc;
SELECT * FROM weapons;

-- auto increment int
create table bag (
	kode_bag serial primary key,
	levl varchar(50)
);

insert into utility (nama_utility,stock) values('smoke',3);
-- tambah tabel 
alter table bag add column fk_weapon char(4);
-- hapus kolom 
alter table bag drop column fk_weapon; 

-- join PK to FK 
alter table bag add constraint fk_weapon foreign key (kode_barang) REFERENCES weapons (kode_barang);

-- mencari data 
select kode_barang, nama_barang from weapons where tipe ='AR';

-- update simpel
update weapons set stock=3 where kode_barang='kb02';
update weapons 
set nama_barang ='KAR98',
	stock =1
where kode_barang='kb04';

update weapons set stock=stock +2 where kode_barang='kb04';
-- delete
delete from weapons where kode_barang='kb01';

-- alias 
select kode_barang as "Kode Barang" 
from weapons;
select * from weapons;

update weapons set stock=3 where kode_barang='kb03';
-- alias pada tabel
from weapons as wp

-- sequence 
create sequence tes_sq;
select nextval('tes_sq');
-- value saat ini 
select currval('tes_sq');

-- perbandingan
select kode_barang,
	harga_barang,
	case
		when harga_barang <= 3000000 then 'cheap'
		when harga_barang <= 5000000 then 'expencive'
	end as "price"
from weapons;

-- rata rata
select avg(harga_barang) from weapons;
select count(kode_barang) from weapons;
select min(harga_barang) from weapons;

-- groupping 
select tipe, count(kode_barang) as "total weapons"
from weapons
group by tipe;

-- unique data 
create table palyer(
	id_player serial primary key,
	user_name varchar(100) not null,
	constraint unique_username unique (user_name)
);
alter table palyer rename to players;
-- hapus constraint / unique dari kolom 
alter table players drop constraint unique_username;
-- tambah constraint unique
alter table players add constraint unique_username unique(user_name);
insert into players (user_name) values ('player3');
delete from players where id_player = 5;

-- relasi antar tabel
create table maps(
	id_map serial not null,
	player int,
	primary key(id_map),
	constraint forkey foreign key(player) REFERENCES players(id_player)
); 

-- drop relasi 
alter table maps drop constraint forkey;
-- tambah relasi
alter table maps add constraint forkey foreign key(player) REFERENCES players(id_player);
-- try to insert data 
insert into maps (player) values (1);

-- join 
select * from maps join players on players.id_player = maps.player;
select maps.id_map, players.user_name as player from maps 
join players on players.id_player = maps.player;

alter table maps add column senjata char(4);
alter table maps 
add constraint forky foreign key (senjata) REFERENCES weapons(kode_barang);
insert into maps (player,senjata) values (1,'kb03');

-- multiple join 
select maps.id_map, players.user_name, weapons.nama_barang from maps
join players on players.id_player = maps.player
join weapons on weapons.kode_barang = maps.senjata;
select * from weapons;
