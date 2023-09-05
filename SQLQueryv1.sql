SELECT TOP (1000) [price]
      ,[area]
      ,[bedrooms]
      ,[bathrooms]
      ,[stories]
      ,[mainroad]
      ,[guestroom]
      ,[basement]
      ,[hotwaterheating]
      ,[airconditioning]
      ,[parking]
      ,[prefarea]
      ,[furnishingstatus]
  FROM [Portfolio Project].[dbo].[Housing$]

 -- Q1: what is the maximum and the minimum of the houses 
 -- Q2: what is the maximum prices for each furnished status
 -- Q3: what are the count of each furnishingstatus average_prices and their average_area respectively
 -- Q4: what is the count of each furnishing status
 -- Q5: using a case statement determine the following
  -- (a) the houses with area greater than the average area
  -- (b) how many houses had more than three bathrooms and their furnished status its furnished status was furnished 
 -- Q6: how many houses had its furnishingstatus unfurnished 
 -- Q7: the total number of each furnishingstatus 
 -- Q8: how many houses had three bedrooms and its furnishingstatus was semi-furnished 
 -- Q9: how many houses had guestroom according to its furnishingstatuss
 --Q10: how does the price of the house influence the furnishingstatus of the housing
 --Q11: find the houses whose area is more than the average area of all the houses according its furnishingstatus
 --Q12: find the number of houses who has the highest price in each furnishing status
 --Q13: find the number of houses that had  hotwaterheating and its furnishingstatus
 --Q14: find the number houses in each furnishingstatus which has more than the average price in its furnishingstatus
 --Q15: find the number of houses in its furnished status who do not have airconditioning in their houses and also those houses with airconditioning
 --Q16: find furnishingstatus whose price were better than the average price accross all furnishingstatus
 --(a); we find the total price for each furnishingstatus. (b); find the average price for all furnishingstatus. (c); compare 1 and 2

 select furnishingstatus,  max(price) as maxprice
 from Housing$
 group by furnishingstatus 
 order by maxprice desc

  select furnishingstatus,  min(price) as maxprice
 from Housing$
 group by furnishingstatus 
 order by maxprice desc

  select furnishingstatus, area, price
 , COUNT(furnishingstatus) over ( partition by  furnishingstatus) as furnishingstatuscount
 , AVG(price) over (partition by  furnishingstatus) as avgprices
 , AVG(area) over (partition by furnishingstatus) as avg_area
  from Housing$

  

 select furnishingstatus, COUNT(furnishingstatus) as furnishingstatuscount
 from Housing$
 group by furnishingstatus 
 order by furnishingstatuscount  desc


ALTER TABLE Housing$ ADD COLUMN_NAME avg_area

select *
from Housing$

ALTER TABLE Housing$
ADD avg_area int 

update Housing$
  SET avg_area = 5299
WHERE furnishingstatus =  'unfurnished'

ALTER TABLE Housing$
DROP COLUMN ADDED_BY  

select  count(furnishingstatus) as num_bathrooms_furn_state
from Housing$
WHERE  furnishingstatus = 'furnished'  and  bathrooms > 3 

select  count(furnishingstatus) as num_bathroom_unfurn_state
from Housing$
WHERE  furnishingstatus = 'unfurnished'   and bathrooms > 3

select  count(furnishingstatus) as num_bathroom_semifurn_state
from Housing$
WHERE  furnishingstatus = 'semi-furnished'   and bathrooms > 3

select furnishingstatus, count(furnishingstatus) as furnishstatus_count
from Housing$                                                                           
group by furnishingstatus

select  COUNT(furnishingstatus) as three_beds_semi_furn_count
from Housing$ 
where furnishingstatus = 'semi-furnished' and bedrooms = 3

--With cte_Housing$ as 
--(select *,row_number() over (partition by furnishingstatus order by price desc) as rn
--from Housing$

--union 
--from cte_Housing$
--where rn <= 10

select furnishingstatus, COUNT(guestroom) as houseswith_guestroom
from Housing$
where guestroom = 'yes'
group by furnishingstatus

select *
from Housing$
where area >
     (select  AVG(area) from Housing$)

select *
from Housing$
where price in
          (select MAX(price) as max_price from Housing$
           group by  furnishingstatus); 
     
select *
from Housing$

select furnishingstatus,count(hotwaterheating) as with_water_heater from Housing$
where  hotwaterheating = 'yes'
group by furnishingstatus

select *
from Housing$
where furnishingstatus not in
        (select  from Housing$);
-- the beginning of the correlated subquery     

select avg(price) from Housing$ where furnishingstatus = "specific_furnishingstatus"

select *
from Housing$ h1
where price > (select avg(price) 
              from Housing$ h2
			  where h2.furnishingstatus = h1.furnishingstatus
			  );
--- The query above to be done manually

select furnishingstatus, AVG(price) Avg_price
from Housing$
group by furnishingstatus

select *
from Housing$
ALTER TABLE Housing$
ADD Avg_price int

UPDATE Housing$
  SET Avg_price = 5476469
WHERE furnishingstatus = 'furnished'

UPDATE Housing$
  SET Avg_price = 4930676
WHERE furnishingstatus = 'semi-furnished'

UPDATE Housing$
  SET Avg_price = 3999977
WHERE furnishingstatus = 'unfurnished'

--select *
--from Housing$ h1
--where price >
--            (select AVG(price) from Housing$ h2
--            where h1.furnishingstatus = 'furnished');

--select *
--from Housing$ h1
--where price >
--            (select AVG(price) from Housing$ h2
--            where h1.furnishingstatus = 'semi-furnished');

--select *
--from Housing$ h1
--where price >
--            (select AVG(price) from Housing$ h2
            --where h1.furnishingstatus = 'unfurnished');

select count(airconditioning) no_airconditioningcount, furnishingstatus
from Housing$
where airconditioning = 'no'
group by furnishingstatus

select count(airconditioning) no_airconditioningcount, furnishingstatus
from Housing$
where airconditioning = 'yes'
group by furnishingstatus

select AVG(total_price) as avg_price
from (select furnishingstatus, sum(price) as total_price
      from Housing$
      group by furnishingstatus) st

	  