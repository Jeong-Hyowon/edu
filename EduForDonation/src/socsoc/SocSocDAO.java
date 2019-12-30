package socsoc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class SocSocDAO {

	private Connection conn;
	private ResultSet rs;

	public SocSocDAO() {
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
					.prepareStatement("SELECT SupportID FROM SUPPORTSOCSOC ORDER BY SupportID DESC;");
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

	public int write(String Name, String EmailID, String Department, String Size) {

		try {
			PreparedStatement pstmt = conn.prepareStatement("INSERT INTO SUPPORTSOCSOC VALUES (?,?,?,?,?,?,?)");

			pstmt.setInt(1, getNext());
			pstmt.setString(2, Name);
			pstmt.setString(3, EmailID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, Department);
			pstmt.setString(6, Size);
			pstmt.setInt(7, 1);

			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	public ArrayList<SocSoc> getList(int pageNumber) {
		ArrayList<SocSoc> list = new ArrayList<SocSoc>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(
					"SELECT * FROM SUPPORTSOCSOC WHERE SupportID < ? AND ContentAvailable = 1 ORDER BY SupportID DESC LIMIT 10;");
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				SocSoc main = new SocSoc();
				main.setSupportID(rs.getInt(1));
				main.setName(rs.getString(2));
				main.setEmailID(rs.getString(3));
				main.setSupportDate(rs.getString(4));
				main.setDepartment(rs.getString(5));
				main.setSize(rs.getString(6));
				main.setContentAvailable(rs.getInt(7));
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
					.prepareStatement("SELECT * FROM SUPPORTSOCSOC WHERE SupportID < ? AND ContentAvailable = 1;");
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

	public SocSoc getSocSoc(int SupportID) {
		try {
			PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM SUPPORTSOCSOC WHERE SupportID = ?");
			pstmt.setInt(1, SupportID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				SocSoc main = new SocSoc();
				main.setSupportID(rs.getInt(1));
				main.setName(rs.getString(2));
				main.setEmailID(rs.getString(3));
				main.setSupportDate(rs.getString(4));
				main.setDepartment(rs.getString(5));
				main.setSize(rs.getString(6));
				main.setContentAvailable(rs.getInt(7));
				return main;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public int update(String Name, String Department, String Size,
			int SupportID) {
		try {
			PreparedStatement pstmt = conn.prepareStatement(
					"UPDATE SUPPORTSOCSOC SET Title=?, SET Department=?, SET Size=?, WHERE SupportID = ?");
			pstmt.setString(1, Name);
			pstmt.setString(2, Department);
			pstmt.setString(3, Size);
			pstmt.setInt(4, SupportID);
			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int delete(int SupportID) {
		try {
			PreparedStatement pstmt = conn.prepareStatement(
					"DELETE FROM SUPPORTSOCSOC WHERE SupportID = ?");
			pstmt.setInt(1, SupportID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
}
