package model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBUtil {
	public static ResultSet findUser(Connection con, String EmailID) {
		String sqlSt = "SELECT Passwd FROM member WHERE EmailID=";

		Statement st;
		
		try {
			st = con.createStatement();

			if (st.execute(sqlSt + "'" + EmailID + "'")) {
				return st.getResultSet();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

}
