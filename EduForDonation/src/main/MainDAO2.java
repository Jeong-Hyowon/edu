package main;

import java.sql.Connection;
import main.Main;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MainDAO2 {

	private Connection conn;
	private ResultSet rs;

	public MainDAO2() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/memberdb?characterEncoding=UTF-8&serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "20161139";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public String getDate() {

		try {
			PreparedStatement pstmt = conn.prepareStatement("SELECT NOW();");
			rs = pstmt.executeQuery();

			if (rs.next()) {
				return rs.getString(1);

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";

	}

	public int getNext() {

		try {
			PreparedStatement pstmt = conn
					.prepareStatement("SELECT SupportID FROM SUPPORTMAIN ORDER BY SupportID DESC;");
			rs = pstmt.executeQuery();

			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("게시글 번호 불러오기");
		return -1;
	}

	public int write(String Name, String EmailID, String ReasonForApplication, String ProsAndCons,
			String ProgramYouWant) {

		try {
			PreparedStatement pstmt = conn.prepareStatement("INSERT INTO SUPPORTMAIN VALUES (?,?,?,?,?,?,?,?)");

			pstmt.setInt(1, getNext());
			pstmt.setString(2, Name);
			pstmt.setString(3, EmailID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, ReasonForApplication);
			pstmt.setString(6, ProsAndCons);
			pstmt.setString(7, ProgramYouWant);
			pstmt.setInt(8, 1);

			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	public ArrayList<Main> getList(int pageNumber) {
		ArrayList<Main> list = new ArrayList<Main>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(
					"SELECT * FROM SUPPORTMAIN WHERE SupportID < ? AND ContentAvailable = 1 ORDER BY SupportID DESC LIMIT 10;");
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Main main = new Main();
				main.setSupportID(rs.getInt(1));
				main.setName(rs.getString(2));
				main.setEmailID(rs.getString(3));
				main.setSupportDate(rs.getString(4));
				main.setReasonForApplication(rs.getString(5));
				main.setProsAndCons(rs.getString(6));
				main.setProgramYouWant(rs.getString(7));
				main.setContentAvailable(rs.getInt(8));
				list.add(main);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage(int pageNumber) {
		try {
			PreparedStatement pstmt = conn
					.prepareStatement("SELECT * FROM SUPPORTMAIN WHERE SupportID < ? AND ContentAvailable = 1;");
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public Main getMain(int SupportID) {
		try {
			PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM SUPPORTMAIN WHERE SupportID = ?");
			pstmt.setInt(1, SupportID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Main main = new Main();
				main.setSupportID(rs.getInt(1));
				main.setName(rs.getString(2));
				main.setEmailID(rs.getString(3));
				main.setSupportDate(rs.getString(4));
				main.setReasonForApplication(rs.getString(5));
				main.setProsAndCons(rs.getString(6));
				main.setProgramYouWant(rs.getString(7));
				main.setContentAvailable(rs.getInt(8));
				return main;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public int update(String Name, String ReasonForApplication, String ProsAndCons, String ProgramYouWant,
			int SupportID) {
		try {
			PreparedStatement pstmt = conn.prepareStatement(
					"UPDATE SUPPORTMAIN SET Name=?, SET ReasonForApplication=?, SET ProsAndCons=?, SET ProgramYouWant=?, WHERE SupportID = ?");
			pstmt.setString(1, Name);
			pstmt.setString(2, ReasonForApplication);
			pstmt.setString(3, ProsAndCons);
			pstmt.setString(4, ProgramYouWant);
			pstmt.setInt(5, SupportID);
			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	public int delete(int SupportID) {
		try {
			PreparedStatement pstmt = conn.prepareStatement("DELETE FROM SUPPORTMAIN WHERE SupportID = ?");
			pstmt.setInt(1, SupportID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<Main> getList2(int pageNumber) {
		ArrayList<Main> list = new ArrayList<Main>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(
					"SELECT * FROM SUPPORTMAIN2 WHERE SupportID < ? AND ContentAvailable = 1 ORDER BY SupportID DESC LIMIT 10;");
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Main main = new Main();
				main.setSupportID(rs.getInt(1));
				main.setName(rs.getString(2));
				main.setEmailID(rs.getString(3));
				main.setSupportDate(rs.getString(4));
				main.setReasonForApplication(rs.getString(5));
				main.setProsAndCons(rs.getString(6));
				main.setProgramYouWant(rs.getString(7));
				main.setContentAvailable(rs.getInt(8));
				list.add(main);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

}
