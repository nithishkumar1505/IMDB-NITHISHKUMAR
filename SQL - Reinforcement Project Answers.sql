                                                               /* Reinforcement project Questions */
                                                           
/* 1. Find the total number of rows in each table of the schema */ 
USE imdb;

SELECT 'DIRECTOR_MAPPING' AS 'Table', COUNT(*) AS TOTALROWS FROM director_mapping
UNION ALL
SELECT 'GENRE' AS 'Table', COUNT(*) AS TOTALROWS FROM genre
UNION ALL
SELECT 'MOVIE' AS 'Table', COUNT(*) AS TOTALROWS FROM movie
UNION ALL
SELECT 'NAMES' AS 'Table', COUNT(*) AS TOTALROWS FROM names
UNION ALL
SELECT 'RATINGS' AS 'Table', COUNT(*) AS TOTALROWS FROM ratings

UNION ALL
SELECT 'ROLE_MAPPING' AS 'Table', COUNT(*) AS TOTALROWS FROM role_mapping;


 --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------   
 --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------   

/* 2. Which columns in the movie table have null values */ 

SELECT  'COUNTRY' AS column_name, COUNT(*) AS null_count FROM movie WHERE country IS NULL
UNION ALL
SELECT  'DATE_PUBLISHED' AS column_name, COUNT(*) AS null_count FROM movie WHERE date_published IS NULL
UNION ALL
SELECT  'DURATION' AS column_name, COUNT(*) AS null_count FROM movie WHERE duration IS NULL
UNION ALL
SELECT  'ID' AS column_name, COUNT(*) AS null_count FROM movie WHERE id IS NULL
UNION ALL
SELECT  'LANGUAGES' AS column_name, COUNT(*) AS null_count FROM movie WHERE languages IS NULL
UNION ALL
SELECT  'PRODUCTION_COMPANY' AS column_name, COUNT(*) AS null_count FROM movie WHERE production_company IS NULL
UNION ALL
SELECT  'TITLE' AS column_name, COUNT(*) AS null_count FROM movie WHERE title IS NULL
UNION ALL
SELECT  'WORLDWIDE_GROSS_INCOME' AS column_name, COUNT(*) AS null_count FROM movie WHERE worlwide_gross_income IS NULL
UNION ALL
SELECT  'YEAR' AS column_name, COUNT(*) AS null_count FROM movie WHERE YEAR IS NULL;
    
    
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------   
    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------   
 
 
/* 3. Find the total number of movies released each year.  */    

Select Year,Count(*) as TOTAL_MOVIES 
from movie
group by Year;

/* How does the trend look month-wise? */

Select month(date_published) as 'MONTH', Count(*) as TOTAL_MOVIES
from movie
group by MONTH
order by MONTH;

 --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------   
 --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------   


/* 4. How many movies were produced in the USA or India in the year 2019? */

Select YEAR, COUNTRY, COUNT(*) AS TOTAL_MOVIES
from movie
WHERE year = 2019 AND COUNTRY IN ("INDIA","USA")
GROUP BY COUNTRY
ORDER BY COUNTRY; 


   --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------   
   --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------   
                                                               

/* 5. Find the unique list of genres present in the dataset. */

Select distinct GENRE FROM GENRE;

/* how many movies belong to only one genre */

Select count(*) as Single_genre_movies 
	from genre
    where genre = "Drama"
    group by genre;
    
    
Select Count(movie_id) As Single_genre_movies
From (
    Select movie_id, Count(genre) As number_of_movies
    From genre
    Group by movie_id
    Having Count(genre) = 1
) As subquery;  


   --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------       
   --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------   
    
    
/* 6. Which genre had the highest number of movies produced overall? */  
 
Select GENRE, count(*) as NUMBEROFMOVIES 
	from genre
    group by genre
    ORDER BY NUMBEROFMOVIES DESC
    LIMIT 1;
    

 --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------       
 --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------       
    
    
/* 7. What is the average duration of movies in each genre? */    

Select g.genre, round(avg(m.duration),2) as Avg_duration 
	from genre g join movie m on g.movie_id = m.id
    group by g.genre
    order by avg_duration desc;
 
 
  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------       
  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------   
 
/* 8. Identify actors or actresses who have worked in more than three movies with an average rating below 5? */
 
use imdb;
Select n.name, count(*) as low_rated_movies 
	from names n join role_mapping rm on 
    n.id = rm.name_id join ratings r on 
    rm.movie_id = r.movie_id
    where r.avg_rating < 5
    group by n.id
    having Count(rm.movie_id) > 3 
    order by low_rated_movies desc;
     
 
  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------       
  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------    
 
 
 /* 9. Find the minimum and maximum values in each column of the ratings table except the movie_id column. */
 
 Select min(avg_rating) as min_rating, max(avg_rating) as max_rating,
		min(total_votes) as min_votes, max(total_votes) as max_votes,
        min(median_rating) as min_median_rating, max(median_rating) as max_median_rating
        from ratings;
   
   
  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------       
  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------            
   
   
/* 10. Which are the top 10 movies based on average rating */

Select m.title, r.avg_rating 
	from movie m join ratings r on 
    m.id = r.movie_id
    group by m.id
    order by r.avg_rating desc
    limit 10;
    
 
  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------       
  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------    
 
 
/* 11. Summarise the ratings table based on the movie counts by median ratings */    

Select median_rating, count(*) as moviecounts
	from ratings
    group by median_rating
    order by median_rating;
    
    
  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------       
  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------        
        
        
/* 12.  How many movies released in each genre during March 2017 in the USA had more than 1,000 votes? */      

Select g.genre, count(*) as totalmovies 
	from genre g join movie m on 
    g.movie_id = m.id join ratings r on
    m.id = r.movie_id
    where m.Year = 2017 and m.country = "USA" and (r.total_votes > 1000) and month(m.date_published) = "3"	
    group by g.genre
    order by totalmovies desc;
    
  
  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------       
  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------       
  
  
  /* 13. Find movies of each genre that start with the word ‘The ’ and which have an average rating > 8 */
  
  Select g.genre, m.title, r.avg_rating 
	from genre g join movie m on 
    g.movie_id = m. id join ratings r on
    m.id = r.movie_id
    where (m.title like "The %") and r.avg_rating > 8
    order by g.genre;
    
    
  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------       
  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------        


/* 14. Of the movies released between 1 April 2018 and 1 April 2019, how many were given a median rating of 8? */  
  
Select Count(*) as totalmovies
	from movie m join ratings r on 
    m.id = r.movie_id
    where date_published between "2018-04-01" and "2019-04-01" and r.median_rating = 8;
    
    
  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------       
  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------        
 
 
/* 15. Do German movies get more votes than Italian movies? */ 

Select m.country, sum(r.total_votes) as total_votes 
	from movie m join ratings r on
    m.id = r.movie_id
    where m.country in ("Germany","Italy")
    group by m.country
    order by m.country;
    

  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------       
  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------        
    
    
/* 16. Which columns in the names table have null values */ 

SELECT  'Id' AS column_name, COUNT(*) AS null_count FROM names WHERE id IS NULL
UNION ALL
SELECT  'Name' AS column_name, COUNT(*) AS null_count FROM names WHERE Name IS NULL
UNION ALL
SELECT  'Height' AS column_name, COUNT(*) AS null_count FROM names WHERE height IS NULL
UNION ALL
SELECT  'Date_of_birth' AS column_name, COUNT(*) AS null_count FROM names WHERE date_of_birth IS NULL
UNION ALL
SELECT  'Known_for_movies' AS column_name, COUNT(*) AS null_count FROM names WHERE known_for_movies IS NULL;   


  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------       
  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------    
  

/* 17. Who are the top two actors whose movies have a median rating >= 8? */
  
SELECT n.name, count(*) AS totalmovies
FROM names n JOIN role_mapping rm ON 
n.id = rm.name_id JOIN ratings r ON 
rm.movie_id = r.movie_id
WHERE rm.category = 'actor' AND r.median_rating >= 8
GROUP BY n.name
ORDER BY totalmovies DESC
LIMIT 2;


  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------       
  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------    
    

/* 18. Which are the top three production houses based on the number of votes received by their movies? */

select m.production_company, sum(r.total_votes) as totalvotes 
	from movie m join ratings r on
    m.id = r.movie_id 
    group by m.production_company
    order by totalvotes desc
    limit 3;
    

  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------       
  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------        
    

/* 19. How many directors worked on more than three movies? */    

Select n.name, count(*) as total_movies
	from names n join director_mapping dm on
    n.id = dm.name_id 
    group by n.name
    having count(dm.movie_id) > 3
    order by total_movies desc;
    
    
  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------       
  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------        
    

/* 20. Find the average height of actors and actresses separately */

Select rm.Category, round(avg(n.height), 2) as avg_height 
	from role_mapping rm join names n on
    rm.name_id = n.id
    group by rm.category
    order by avg_height desc;

  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------       
  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------            


/* 21. Identify the 10 oldest movies in the dataset along with its title, country, and director */  

Select m.title, m.country, (n.name) as Director_name, m.date_published 
	from movie m join director_mapping dm on 
    m.id = dm.movie_id join names n on 
    dm.name_id = n.id 
    order by m.date_published,m.country
    limit 10;
    
    
  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------       
  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------            


/* 22. List the top 5 movies with the highest total votes and their genres */ 

Select m.title, g.genre, r.total_votes
	from movie m join genre g on 
    m.id = g.movie_id join ratings r on
    g.movie_id = r.movie_id 
    order by g.genre,total_votes desc
    limit 5;

    
  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------       
  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------            
    

/* 23. Find the movie with the longest duration, along with its genre and production company. */

Select m.title, m.duration, g.genre, m.production_company 
		from movie m join genre g on 
        m.id = g.movie_id
        order by duration desc
        limit 1;
    
    
  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------       
  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------            
    

/* 24. Determine the total votes received for each movie released in 2018 */    

Select m.title, sum(r.total_votes) as totalvotes
	from movie m join ratings r on
    m.id = r.movie_id 
    where year = 2018
    group by m.title
    order by totalvotes desc;
    
    
  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------       
  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------            
    
    
/* 25. Find the most common language in which movies were produced. */    

Select languages, count(*) as total_movies
	from movie
    group by languages
    order by total_movies desc
    limit 1;
   
   
  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------       
  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------           