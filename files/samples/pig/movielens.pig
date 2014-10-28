
/* Cargar datos */

movies = LOAD 'hdfs:///user/vagrant/movielens/ml-100k/u.item' 
    USING PigStorage('|')
    AS (movie_id:int, movie_title:chararray, release_date:chararray, video_release_date:chararray, IMDB_URL:chararray, unknown:int, Action:int, Adventure:int, Animation:int, Childrens:int, Comedy:int, Crime:int, Documentary:int, Drama:int, Fantasy:int, FilmNoir:int, Horror:int, Musical:int, Mystery:int, Romance:int, SciFi:int, Thriller:int, War:int, Western:int);

ratings = LOAD 'hdfs:///user/vagrant/movielens/ml-100k/u.data'
    AS (user_id:int, movie_id:int, rating:int, timestamp:chararray);

/* generar medias de valoración de películas de cada año */
years = FOREACH movies GENERATE movie_id, GetYear(ToDate(release_date,'dd-MMM-yyyy')) AS year:int;

years_ratings = JOIN ratings by movie_id, years by movie_id;

gyear_rating = GROUP years_ratings BY year;

year_rating = FOREACH gyear_rating GENERATE group as year, AVG(years_ratings.ratings::rating) as rating, COUNT(years_ratings.ratings::rating);

STORE year_rating INTO 'output/year_rating';

/* calcular rating medio de todas las películas */
gtotal_rating = GROUP ratings ALL;
total_rating = FOREACH gtotal_rating GENERATE AVG(ratings.rating) as rating;
DUMP total_rating;

/* añadir indicador de años bisiestos mediante STREAM */
leap_years_stream = STREAM year_rating THROUGH `/vagrant/files/samples/pig/stream.py`;
DUMP leap_years_stream;

/* añadir indicador de años bisiestos mediante UDF */
REGISTER udf.jar;
leap_years_udf = FOREACH gyear_rating GENERATE group as year, AVG(years_ratings.ratings::rating) as rating, COUNT(years_ratings.ratings::rating), udf.LEAP(group) AS leap;
DUMP leap_years_udf;