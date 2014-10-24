 movies = LOAD '/vagrant/files/data/movielens/ml-100k/u.item' 
    USING PigStorage('|')
    AS (movie_id:int, movie_title:chararray, release_date:chararray, video_release_date:chararray, IMDB_URL:chararray, unknown:int, Action:int, Adventure:int, Animation:int, Childrens:int, Comedy:int, Crime:int, Documentary:int, Drama:int, Fantasy:int, FilmNoir:int, Horror:int, Musical:int, Mystery:int, Romance:int, SciFi:int, Thriller:int, War:int, Western:int);

ratings = LOAD '/vagrant/files/data/movielens/ml-100k/u.data'
    AS (user_id:int, movie_id:int, rating:int, timestamp:chararray);

years = FOREACH movies GENERATE movie_id, GetYear(ToDate(release_date,'dd-MMM-yyyy')) AS year:int;

years_ratings = JOIN ratings by movie_id, years by movie_id;

gyear_rating = GROUP years_ratings BY year;

year_rating = FOREACH gyear_rating GENERATE group as year, AVG(years_ratings.ratings::rating) as rating, COUNT(years_ratings.ratings::rating);

gtotal_rating = GROUP ratings ALL;
total_rating = FOREACH gtotal_rating GENERATE AVG(ratings.rating) as rating;

STORE year_rating INTO 'output/year_rating';
DUMP total_rating;