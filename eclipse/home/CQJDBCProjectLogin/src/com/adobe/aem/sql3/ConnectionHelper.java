package com.adobe.aem.sql3;
 
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
   
public class ConnectionHelper
{
  private String url;
  private static ConnectionHelper instance;
  private ConnectionHelper()
  {
    try {
      Class.forName("com.mysql.jdbc.Driver").newInstance();
      url = "jdbc:mysql://94.229.79.19:3306/aaronmul_nbGardens";
    }
    catch (Exception e) {
      e.printStackTrace();
    }
  }
  public static Connection getConnection() throws SQLException {
    if (instance == null) {
      instance = new ConnectionHelper();
    }
    try {
      return DriverManager.getConnection(instance.url, "aaronmul_blehman", "Netbuilder12");
    }
    catch (SQLException e) {
      throw e;
    }
  }
  public static void close(Connection connection)
  {
    try {
      if (connection != null) {
      connection.close();
   }
  }
    catch (SQLException e) {
      e.printStackTrace();
    }
  }
}