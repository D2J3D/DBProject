create table Users(
    userId serial PRIMARY KEY,
    userNick VARCHAR(31) UNIQUE NOT NULL,
    userRating integer DEFAULT 0,
    uploadedFilmsAmount integer  DEFAULT 0,
    collectionsAmount integer DEFAULT 0
);
INSERT INTO Users VALUES (DEFAULT, 'Den');
INSERT INTO Users VALUES (DEFAULT, 'Oleg');
INSERT INTO Users VALUES (DEFAULT, 'Marat');
INSERT INTO Users VALUES (DEFAULT, 'Danil');
INSERT INTO Users VALUES (DEFAULT, 'Dasha');
INSERT INTO Users VALUES (DEFAULT, 'Kristina');
INSERT INTO Users VALUES (DEFAULT, 'AK-47 Marat');
INSERT INTO Users VALUES (DEFAULT, 'Olegka');
INSERT INTO Users VALUES (DEFAULT, 'Timur');
INSERT INTO Users VALUES (DEFAULT, 'Artem');
INSERT INTO Users VALUES (DEFAULT, 'Terminator');
INSERT INTO Users VALUES (DEFAULT, 'Ben');
INSERT INTO Users VALUES (DEFAULT, 'Хан Соло');
INSERT INTO Users VALUES (DEFAULT, 'Киноман');
SELECT * FROM Films;
create table Films(
    filmId serial PRIMARY KEY,
    userId integer NOT NULL REFERENCES Users (userId),
    filmName VARCHAR(127) NOT NULL,
    durationInMinutes integer CHECK ( durationInMinutes > 0 ),
    filmLanguage VARCHAR(63) NOT NULL,
    filmBudget integer CHECK ( filmBudget > 0 ),
    filmGenre VARCHAR(31),
    filmDescr VARCHAR(255),
    filmLink VARCHAR NOT NULL,
    country VARCHAR(63),
    directorId integer REFERENCES Directors (directorId),
    uploadingDate timestamp,
    UNIQUE (filmName, filmLanguage)
);
SELECT * FROM Users;
create table Directors(
    directorId serial PRIMARY KEY,
    directorName VARCHAR(63) NOT NULL,
    directorSurname VARCHAR(63) NOT NULL,
    directedFilmsAmount integer CHECK ( directedFilmsAmount > 0 ),
    birthYear integer CHECK ( birthYear < 2010),
    motherCountry VARCHAR(63),
    UNIQUE (directorName, directorSurname)
);


create table UserCollection(
    userCollectionId serial PRIMARY KEY,
    userId integer NOT NULL REFERENCES Users (userId),
    filmsAmount integer NOT NULL DEFAULT 0
);

create table FilmsByCollection(
    userCollectionId integer NOT NULL REFERENCES UserCollection (userCollectionId),
    filmId integer NOT NULL REFERENCES Films (filmId),
    PRIMARY KEY (userCollectionId, filmId)
);

SELECT * FROM Users;
SELECT * FROM Films;

UPDATE Users SET uploadedFilmsAmount = uploadedFilmsAmount + 1 WHERE userId = 1;


SELECT filmGenre, COUNT(*) FROM Films WHERE Films.userId = 1 GROUP BY filmGenre;

SELECT * FROM Films WHERE uploadingDate LIKE '2023-06%';
/* Узнать сколько фильмов 1 режиссера загруэены пользователем */
SELECT * FROM usercollection;
INSERT INTO UserCollection VALUES (DEFAULT, 1, 7);
UPDATE Users SET collectionsAmount = collectionsAmount + 1 WHERE userId  = 1;
INSERT INTO UserCollection VALUES (DEFAULT, 14, 3);
UPDATE Users SET collectionsAmount = collectionsAmount + 1 WHERE userId  = 14;
INSERT INTO UserCollection VALUES (DEFAULT, 11, 5);
UPDATE Users SET collectionsAmount = collectionsAmount + 1 WHERE userId  = 5;
INSERT INTO UserCollection VALUES (DEFAULT, 9, 2);
UPDATE Users SET collectionsAmount = collectionsAmount + 1 WHERE userId  = 9;
INSERT INTO UserCollection VALUES (DEFAULT, 12, 2);
UPDATE Users SET collectionsAmount = collectionsAmount + 1 WHERE userId  = 12;
INSERT INTO UserCollection VALUES (DEFAULT, 13, 4);
UPDATE Users SET collectionsAmount = collectionsAmount + 1 WHERE userId  = 13;
INSERT INTO UserCollection VALUES (DEFAULT, 10, 4);
UPDATE Users SET collectionsAmount = collectionsAmount + 1 WHERE userId  = 10;
INSERT INTO UserCollection VALUES (DEFAULT, 14, 4);
UPDATE Users SET collectionsAmount = collectionsAmount + 1 WHERE userId  = 14;
INSERT INTO UserCollection VALUES (DEFAULT, 14, 3);
UPDATE Users SET collectionsAmount = collectionsAmount + 1 WHERE userId  = 14;
INSERT INTO UserCollection VALUES (DEFAULT, 14, 5);
UPDATE Users SET collectionsAmount = collectionsAmount + 1 WHERE userId  = 14;
INSERT INTO UserCollection VALUES (DEFAULT, 1, 2);
UPDATE Users SET collectionsAmount = collectionsAmount + 1 WHERE userId  = 1;

SELECT * FROM FilmsByCollection;
SELECT * FROM Films;
SELECT * FROM UserCollection;
SELECT COUNT(*) FROM UserCollection GROUP BY filmsAmount;
INSERT INTO FilmsByCollection VALUES (1, 1);
INSERT INTO FilmsByCollection VALUES (1, 2);
INSERT INTO FilmsByCollection VALUES (1, 3);
INSERT INTO FilmsByCollection VALUES (1, 4);
INSERT INTO FilmsByCollection VALUES (1, 5);
INSERT INTO FilmsByCollection VALUES (1, 6);
INSERT INTO FilmsByCollection VALUES (1, 7);

INSERT INTO FilmsByCollection VALUES (2, 1);
INSERT INTO FilmsByCollection VALUES (2, 2);
INSERT INTO FilmsByCollection VALUES (2, 3);

INSERT INTO FilmsByCollection VALUES (3, 1);
INSERT INTO FilmsByCollection VALUES (3, 2);
INSERT INTO FilmsByCollection VALUES (3, 3);
INSERT INTO FilmsByCollection VALUES (3, 4);
INSERT INTO FilmsByCollection VALUES (3, 5);

INSERT INTO FilmsByCollection VALUES (4, 1);
INSERT INTO FilmsByCollection VALUES (4, 2);

INSERT INTO FilmsByCollection VALUES (5, 1);
INSERT INTO FilmsByCollection VALUES (5, 2);

INSERT INTO FilmsByCollection VALUES (6, 22);
INSERT INTO FilmsByCollection VALUES (6, 72);
INSERT INTO FilmsByCollection VALUES (6, 31);
INSERT INTO FilmsByCollection VALUES (6, 54);

INSERT INTO FilmsByCollection VALUES (7, 90);
INSERT INTO FilmsByCollection VALUES (7, 84);
INSERT INTO FilmsByCollection VALUES (7, 45);
INSERT INTO FilmsByCollection VALUES (7, 34);

INSERT INTO FilmsByCollection VALUES (8, 38);
INSERT INTO FilmsByCollection VALUES (8, 37);
INSERT INTO FilmsByCollection VALUES (8, 19);
INSERT INTO FilmsByCollection VALUES (8, 12);

INSERT INTO FilmsByCollection VALUES (10, 43);
INSERT INTO FilmsByCollection VALUES (10, 40);
INSERT INTO FilmsByCollection VALUES (10, 31);
INSERT INTO FilmsByCollection VALUES (10, 7);
INSERT INTO FilmsByCollection VALUES (10, 64);

INSERT INTO FilmsByCollection VALUES (11, 62);
INSERT INTO FilmsByCollection VALUES (11, 57);

/* Самый популярный фильм в коллекциях */
SELECT userCollectionId, COUNT(filmId) FROM FilmsByCollection GROUP BY userCollectionId;
SELECT * from films;
SELECT filmName FROM Films WHERE filmId = (SELECT filmId FROM FilmsByCollection GROUP BY filmId ORDER BY COUNT(*) DESC limit 1);
/* Фильмы какого жанра нравятся пользователю? То есть какие он добавляет в коллекции*/
SELECT filmGenre FROM Films WHERE filmId IN (SELECT filmId FROM FilmsByCollection WHERE userCollectionId IN (SELECT userCollectionId FROM UserCollection WHERE userId = 1)) GROUP BY filmGenre ORDER BY COUNT(*) DESC LIMIT 1;
SELECT filmGenre,  COUNT(*) FROM Films WHERE (userId = 1) GROUP BY filmGenre ORDER BY COUNT(*) DESC LIMIT 1;

/* Рейтинг */
SELECT uploadingDate FROM Films WHERE  filmId = 1;
UPDATE Films SET uploadingDate = current_timestamp - interval '1 month' WHERE filmId = 1;
/* Задание рейтинга */
UPDATE Users SET userRating = (SELECT COUNT(*) FROM Films WHERE ( userId = 8 and uploadingDate < timestamp '2023-06-01 00:00:00' AND uploadingDate > timestamp '2023-05-01 00:00:00') GROUP BY userId) WHERE userId = 8;
SELECT * FROM Users;

/* Получить пользователя с максимальным рейтингом */
SELECT userId, userNick FROM Users WHERE userRating = (SELECT MAX(userRating) FROM Users);

/* Получить самую популярную страну фильма за последний год*/
SELECT country FROM Films WHERE (uploadingDate <= current_timestamp and uploadingDate >= current_timestamp - interval '1 year') GROUP BY country ORDER BY COUNT(*) DESC LIMIT 1;
SELECT * FROM Films WHERE (uploadingDate <= current_timestamp and uploadingDate >= current_timestamp - interval '1 year');
/* Запрос 5 */
SELECT COUNT(*) FROM Films WHERE uploadingDate < timestamp '2023-06-01 00:00:00' AND uploadingDate >= timestamp '2023-05-01 00:00:00'; /**/
SELECT COUNT(*) FROM Films WHERE uploadingDate > current_timestamp - interval '1 month' AND uploadingDate <= current_timestamp;
/* Получить лучшего режиссера */


SELECT country, COUNT(*) FROM Films WHERE (uploadingDate <= current_timestamp and uploadingDate >= current_timestamp - interval '1 year') GROUP BY country ORDER BY COUNT(*);
