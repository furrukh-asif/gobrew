create table staging_assets (
	event_time text,
	event_type text, 
	product_id text, 
	category_id text,
	category_code text,
	brand text,
	price text,
	user_id text,
	user_session text
);


--- import data from csv while accounting for missing values
insert into staging_assets 
(event_time, event_type, product_id, category_id, category_code, brand, price, user_id, user_session)
(select split_part(entries, ',', 1) as col1,
split_part(entries, ',', 2) as col2,
split_part(entries, ',', 3) as col3,
split_part(entries, ',', 4) as col4,
split_part(entries, ',', 5) as col5,
split_part(entries, ',', 6) as col6,
split_part(entries, ',', 7) as col7,
split_part(entries, ',', 8) as col8,
split_part(entries, ',', 9) as col9
from pre_staging_assets);

--- delete rows with any missing column
delete 
from staging_assets
where not (event_time <> '' and event_type <> '' and  product_id <> '' and category_id <> '' and category_code <> '' and  brand <> '' and 
price <> '' and user_id <> '' and user_session <> '');

--- check all rows with any missing data were deleted (should return nothing)
select * from staging_assets
where (event_time = '' or event_type = '' or product_id = '' or category_id = '' or category_code = '' or brand = '' 
or price = '' or user_id = '' or user_session = '');

--- changing datatypes
alter table staging_assets 
alter column event_time type timestamp with time zone
using (event_time::timestamp with time zone);


alter table staging_assets 
alter column user_id type float8
using (user_id::float8);

update staging_assets 
set user_id = floor(user_id);

alter table staging_assets 
alter column user_id type bigint
using (user_id::bigint);

alter table staging_assets 
alter column category_id type bigint
using (category_id::bigint);

alter table staging_assets 
alter column product_id type bigint
using (product_id::bigint);

alter table staging_assets 
alter column price type float8
using (price::float8);

alter table staging_assets 
alter column event_type type varchar
using (event_type::varchar);

alter table staging_assets 
alter column category_code type varchar
using (category_code::varchar);

alter table staging_assets 
alter column brand type varchar
using (brand::varchar);

alter table staging_assets 
alter column user_session type varchar
using (user_session::varchar);



