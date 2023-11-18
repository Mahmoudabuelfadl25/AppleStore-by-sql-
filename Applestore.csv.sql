-- union apple store desc tables

create table apple_store_desc as 
select* from appleStore_description1 
union all
SELECT* from appleStore_description2 
union all
select* from appleStore_description3 
union all
SELECT* from appleStore_description4 


------------------------------------------------------------------

-- Exploring data -- 

-- check the num of unique apps in both tables
SELECT count(DISTINCT id)
from apple_store_desc

select COUNT(DISTINCT id ) 
from Applestore
-- we determined the total num of apps is 7197 ✔

-- check for any missing values
SELECT * 
from Applestore 
where id is NULL or track_name is NULL or user_rating is NULL or prime_genre is NULL
-- there are not nay missing data ✔

-- find out the num of apps per genre
SELECT COUNT(DISTINCT id ) as NumOfApps, prime_genre
from Applestore 
GROUP by prime_genre
order by NumOfApps DESC
-- hight category by number of apps is games ( 3862 app ) ✔
--lowest category by num of apps is catalogs ✔

-- get an oerview of apps rating
SELECT COUNT(DISTINCT id) ,
CASE WHEN user_rating >= 4 THEN 'high_rated_apps'
     WHEN user_rating BETWEEN 2 AND 4 THEN 'moderately_rated_apps'
     ELSE 'low_rated_apps'
END AS rating_category
FROM Applestore
group by rating_category
-- most of apps is high rated (4781),low rated apps is 1029, moderatly rated apps is 1387 ✔

-----------------------------------------------------------------------



-- Analysis of data -- 

-- comparing between paid and free apps in rating 
SELECT avg(user_rating) as avg_user_rating, CASE
when price > 0 then "Paid"
else "Free"
end as FreeOrPaid 
from Applestore
GROUP by FreeOrPaid
order by price
-- average of user rating for free apps is 3.37 
--                        for paid app is 3.72 
-- low difference between them ✔


-- Relation between num of lang and rating
select Avg(user_rating) as avg_user_rating,
       case when lang_num > 10 then "many_lang"
            when lang_num BETWEEN 5 and 10 then "avg_lang_num"
            ELSE "few_lang"
            end as "lang_num_size"
    from Applestore
    group by lang_num_size
    order by avg_user_rating
-- apps with many languages are more user rating ✔
    
-- genres with low rating
SELECT prime_genre, Avg(user_rating) as avg_user_rating
from Applestore
GROUP by  prime_genre 
ORDER by avg_user_rating desc
-- sequence of rated genre is Productivity > Music > photo and video ..... catalog ✔


-- Relation between length of app description and user rating 
SELECT  Avg(user_rating) as avg_user_rating , 
case when length(d.app_desc) < 500 then "short_desc" 
     when length(d.app_desc) between 500 and 1000 then "medium_desc"
     ELSE "long_desc"
     end as "desc_size"
from Applestore as a 
JOIN apple_store_desc as d on a.id = d.id
group by desc_size
order by avg_user_rating DESC
-- Long description has more rating than short desc ✔

-- Conclusion & Recommendations -- 

-- we determined the total num of apps is 7197 ✔
-- highest category by number of apps is games ( 3862 app ) ✔
--- if you want to establish gaming app you should be unique because high competation of another apps 
-- lowest category by num of apps is catalogs ✔
-- most of apps is high rated (4781),low rated apps is 1029, moderatly rated apps is 1387 ✔
-- average of user rating for free apps is 3.37 , for paid app is 3.72 
-- low difference between them ✔
--- it will be good to make both type of app ( free or paid ).
-- apps with many languages are more user rating ✔
--- making app with several languages is bery well.
-- sequence of rated genre is Productivity > Music > photo and video ..... catalog ✔
--- it will better to choose between productivity or music or photo and video apps it will more attractive.
-- Long description has more rating than short desc ✔
--- users prefer long description than short one, so it's better to do that.








