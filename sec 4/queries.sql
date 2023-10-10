-- INDICE
    -- Nombre, apellido e IP, donde la última conexión se dió de 221.XXX.XXX.XXX
    -- Nombre, apellido y seguidores(followers) de todos a los que lo siguen más de 4600 personas
    -- Funciones de agregación
    -- Personas con maximo y minimo de followers
    -- Conteo de personas con el minimo y el maximo de followers
    -- Conteo de personas segun su pais	usando (having)
    -- Listando de paises, sin duplicados		(distinct)
    -- Conteo de diferentes provedores de email 
    -- Sub queries 


-- Nombre, apellido e IP, donde la última conexión se dió de 221.XXX.XXX.XXX
select
	first_name,
	last_name,
	last_connection
from
	users u
where
	last_connection like '221.%';


-- Nombre, apellido y seguidores(followers) de todos a los que lo siguen más de 4600 personas
select
	first_name,
	last_name,
	followers 
from
	users u
where
    followers between 3095 and 3100 or
	followers >= 4600
order by 
	followers asc;
	
-- Funciones de agregación
select
	count(*) as total_users, 
	sum(followers) as sumatoria,  
	min( followers ) as min_followers,
	max( followers ) as max_followers,
	avg( followers ) as avg_followers,
	round( avg( followers ) ) as avg_followers_rounded,
	sum(followers) / count(*) as avg_manual 
from
	users u; 

-- Personas con maximo y minimo de followers
select
	first_name,
	last_name,
	followers
from
	users u
where
	followers = 4 or followers = 4999; 

-- Conteo de personas con el minimo y el maximo de followers
select
	count(*) as contador, 
	followers
from
	users u
where
	-- followers = 4 or followers = 4999
	-- followers >= 4000
	followers between 100 and 2000
group by 
  followers 
order by contador desc; 

-- Conteo de personas segun su pais	usando (having)
select
	count(*),
	country
from
	users u
group by
	country
having
	-- count(*) >= 6
	count(*) between 2 and 5
order by
	count(*) desc; 

-- Listando de paises, sin duplicados		(distinct)
select distinct country from users u; 


-- Conteo de diferentes provedores de email 
select
	count(*) as total,
	SUBSTRING( email, position('@' in email)+ 1 ) as dominio
from
		users u
group by
	SUBSTRING( email, position('@' in email)+ 1 )
having
	count(*) > 1
order by
	count(*) desc; 


-- Sub queries 
select
	dominio,
	total
from
	(
	select
		count(*) as total,
		SUBSTRING( email, position('@' in email)+ 1 ) as dominio
	from
		users u
	group by
		SUBSTRING( email, position('@' in email)+ 1 )
	--having
		--count(*) > 1
	order by
		count(*) desc 
) as email_domains
where
	total > 1;
