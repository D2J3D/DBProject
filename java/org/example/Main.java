package org.example;


import java.sql.SQLException;
import java.util.Random;

public class Main {
    public static void main(String[] args) throws SQLException {
        DBConnector dbConnector = new DBConnector();
        // Массивы данных, необходимых для добавления строки в базу данных Films и Directors
        String[] directors = new String[] { "Кристофер Нолан", "Мартин Скорсезе", "Гай Ричи", "Джеймс Кэмерон", "Дэвид Финчер", "Тим Бёртон", "Стэнли Кубрик", "Люк Бессон", "Андрей Тарковский", "Хаяо Миядзаки", "Роберт Земекис", "Питер Джексон"};
        String[] countries = new String[] {"Россия","США", "Великобритания", "Франция", "Италия", "Япония"}; // Список стран для фильмов
        String[] filmNames = new String[] { "Тайна Коко", "Властелин Колец", "Интерстеллар",  "Бойцовский клуб", "Криминальное чтиво", "Иван Васильевич меняет профессию", "Назад в будущее", "Король Лев", "1+1", "Приключения Шерлока Холмса", "Шрек", "Москва слезам не верит", "Достучаться до небес", "Остров Проклятых", "Джентельмиены удачи", "Гарри Поттер и узник Азкабана", "Темный рыцарь", "Операция Ы", "Девчата", "Ходячий замок", "Терминатор", "Гарри Поттер и философский камень", "Пираты Карибского моря", "Джентельмены", "Гладиатор", "Поймая меня, если сможешь", "Игра на понижение", "Начало", "Титаник", "Большой куш", "Клаус", "Один дома", "Один дома 2", "Один дома 3", "Гарри Поттер и Тайная комната", "Гарри Поттер и Дары Смерти", "Бриллиантовая рука", "Зеленаяя книга", "Остров сокровищ", "Хатико", "Карты, деньги, 2 ствола", "Как приручить дракона", "Джанго", "Прислуга", "Шрэк 2", "Леон", "Пианист", "Песнь моря", "Пираты Карибского моря 2", "Рататуй",  "Крестный отец", "Укрощение строптивого", "Пеле", "Зверополис", "Запах женщины", "Хоббит", "Корпорация монстров", "Матрица", "Матрица 2", "Матрица 3", "Одержимость", "Мулан", "Гарри Поттер и Кубок огня", "Звездные войны. Эпизод 3", "Мадагаскар", "Крестный отец 2"};
        String[] filmGenres = new String[] {"Комедия", "Вестерн", "Фильм-катастрофа", "Документальный", "Фильм-ужасов"};
        // Скрипт для заполнения таблицы Directors
        for (int i = 0; i < directors.length; i++){
            String[] directorName = directors[i].split(" ");
            int directedFilmsAmount = (int) (Math.random() * 20);
            int birthYear = 1946 +  (int) (Math.random() * 20);
            int rnd = new Random().nextInt(countries.length);
            String mortherCountry = countries[rnd];
            System.out.println(directorName[0] + " " + directorName[1] + " " + directedFilmsAmount + " " + birthYear + " " + mortherCountry);
            dbConnector.addDirector(directorName, directedFilmsAmount, birthYear, mortherCountry);
        }
        // Скрипт для заполнения таблицы Films
        int userCounter = 1;
        int directorCounter = 4;
        for (int i = 0; i < filmNames.length; i++){
            if (directorCounter == 6){
                directorCounter++;
            }
            int userId = userCounter;
            String filmName = filmNames[i];
            int durationInMinutes = (int) (Math.random() * 180);
            String filmLanguage = "ru";
            int filmBudget =  (int) (Math.random() * 20) + 1;
            int genreRnd = new Random().nextInt(filmGenres.length);
            String filmGenre = filmGenres[genreRnd];
            String filmDescr = "";
            String filmLink = "google.com";
            int countryRnd = new Random().nextInt(filmGenres.length);
            String country = countries[countryRnd];
            int directorId = directorCounter;
            dbConnector.addFilm(userCounter, filmName, durationInMinutes, filmLanguage, filmBudget, filmGenre, filmDescr, filmLink, country, directorId);
            if (userCounter <= 7){
                userCounter++;
            } else{
                userCounter = 1;
            }
            if (directorCounter <= 17){
                directorCounter++;
            } else{
                directorCounter = 4;
            }
        }
        System.out.println(filmNames.length);
    }
}
