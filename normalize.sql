create table user_sessions as 
	select user_session, user_id
	from staging_assets
	where user_session in 
		(select distinct user_session 
		from staging_assets);

create sequence session_ids
start with 1
increment by 1
minvalue 1
no maxvalue 
cache 1;

alter table user_sessions 
add id int default nextval('session_ids') primary key;

create table brands as
	select distinct brand
	from staging_assets;

create sequence brand_ids
start with 1
increment by 1
minvalue 1
no maxvalue 
cache 1;

alter table brands 
add id int default nextval('brand_ids') primary key;

---create fake ids for this table as category id is huge?
create table categories as
	select distinct category_id, category_code
	from staging_assets;


create sequence event_ids
start with 1
increment by 1
minvalue 1
no maxvalue
cache 1;

--create table events as
--	select event_type, event_time, product_id

create table events (
	id int constraint events_pk primary key,
	event_type varchar not null,
	event_time timestamp with time zone, 
	session_id int foreign key not null,
	product_id bigint foreign key not null
);



create table products (
	id bigint primary key,
	category_id bigint foreign key not null,
	brand_id int foreign key not null,
	price float8
);

create table categories (
	id bigint primary key,
	category_code varchar unique
);





