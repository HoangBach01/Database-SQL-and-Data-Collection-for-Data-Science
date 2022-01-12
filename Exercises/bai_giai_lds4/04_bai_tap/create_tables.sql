CREATE TABLE testdb.drinks
(
    id int primary key,
    country varchar(50) not null unique,
    beer_servings int,
    spirit_servings int,
    wine_servings int,
    total_litres_of_pure_alcohol float,
    continent varchar(10)
);