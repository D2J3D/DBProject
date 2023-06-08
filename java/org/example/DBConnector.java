package org.example;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DBConnector {
    static final String DB_URL = "jdbc:postgresql://localhost:5432/db_project";
    static final String USER = "postgres";
    static final String PASSWORD = "1";
    private final Connection conn;

    public DBConnector() throws SQLException {
        this.conn = connectDB();
    }

    public Connection connectDB() throws SQLException {
        Connection connection = DriverManager.getConnection(DB_URL, USER, PASSWORD);
        return connection;
    }

    public void addFilm(int userId, String filmName, int durationInMinutes, String filmLanguage, int filmBudget, String filmGenre, String filmDescr, String filmLink, String country, int directorId) throws SQLException {
        PreparedStatement preparedStatement = conn.prepareStatement("INSERT INTO films VALUES (DEFAULT, " + userId+ ", '" + filmName + "', " + durationInMinutes + ", '" + filmLanguage + "', " + filmBudget + ",'" + filmGenre + "','" + filmDescr + "','" + filmLink + "','" + country + "'," + directorId + ", current_timestamp)");
        preparedStatement.execute();
        PreparedStatement preparedStatement1 = conn.prepareStatement("UPDATE Users SET uploadedFilmsAmount = uploadedFilmsAmount + 1 WHERE userId = " + userId);
        preparedStatement1.execute();
        PreparedStatement preparedStatement2 = conn.prepareStatement("UPDATE Users SET userrating = userrating + 1 WHERE userId = " + userId);
        preparedStatement2.execute();
    }
    public void addDirector(String[] directorName, int directedFilmsAmount, int birthYear, String mortherCountry) throws SQLException {
        PreparedStatement preparedStatement = conn.prepareStatement("INSERT INTO directors VALUES (DEFAULT, '" + directorName[0]+ "', '" + directorName[1] + "', " + directedFilmsAmount + ", '" + mortherCountry + "', " + birthYear + " )");
        preparedStatement.execute();
    }
}