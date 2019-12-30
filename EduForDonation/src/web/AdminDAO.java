package web;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import main.Main;

public class AdminDAO {

	private Connection conn;
	private ResultSet rs;

	public AdminDAO() {
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
					.prepareStatement("SELECT SupportID FROM EDU ORDER BY SupportID DESC;");
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
	
	public boolean nextPage(int pageNumber) {
		try {
			PreparedStatement pstmt = conn
					.prepareStatement("SELECT * FROM EDU WHERE SupportID < ?");
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
	
	public MemberDto getData(String EmailID){
		MemberDto dto = null;
		try {
			PreparedStatement pstmt = conn.prepareStatement("select EmailID, Passwd, CPhone from member where EmailID like ?");
			pstmt.setString(1, EmailID);
			rs = pstmt.executeQuery();
			if(rs.next()){
				dto = new MemberDto();
				dto.setEmailID(rs.getString("EmailID"));
				dto.setPasswd(rs.getString("Passwd"));
				dto.setcPhone(rs.getString("CPhone"));
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		
		}
		return dto;
	}
	
	public boolean admin_login(String admin_id,String admin_pass){
		boolean b = false;
		try {
			PreparedStatement pstmt = conn.prepareStatement("select * from admin where admin_id = ? and admin_pass = ?");
			pstmt.setString(1, admin_id);
			pstmt.setString(2, admin_pass);
			rs = pstmt.executeQuery();
			b=rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		return b;
	}
	
	public ArrayList<MemberDto> getMemberAll(){
		ArrayList<MemberDto> list = new ArrayList<MemberDto>();
		try {
			PreparedStatement pstmt = conn.prepareStatement("select * from member");
			rs = pstmt.executeQuery();
			while(rs.next()){
				MemberDto dto =  new MemberDto();
				dto.setEmailID(rs.getString("EmailID"));
				dto.setPasswd(rs.getString("Passwd"));
				dto.setcPhone(rs.getString("CPhone"));
				list.add(dto);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			}
		return list;
	}

	public int write(String title, String text , String admin_id) {
	
		try {
			PreparedStatement pstmt = conn.prepareStatement("INSERT INTO EDU VALUES (?,?,?,?,?)");
			
			pstmt.setInt(1, getNext());
			pstmt.setString(2, title);
			pstmt.setString(3, text);
			pstmt.setString(4, admin_id);
			pstmt.setString(5, getDate());
			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<AdminEdu> getList(int pageNumber) {
		ArrayList<AdminEdu> list = new ArrayList<AdminEdu>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(
					"SELECT * FROM EDU WHERE SupportID < ? ORDER BY SupportID DESC LIMIT 10;");
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				AdminEdu main = new AdminEdu();
				main.setSupportID(rs.getInt(1));
				main.setTitle(rs.getString(2));
				main.setText(rs.getString(3));
				main.setAdmin_id(rs.getString(4));
				main.setSupportDate(rs.getString(5));
				list.add(main);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public AdminEdu getMain(int SupportID) {
		try {
			PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM EDU WHERE SupportID = ?");
			pstmt.setInt(1, SupportID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				AdminEdu main = new AdminEdu();
				main.setSupportID(rs.getInt(1));
				main.setTitle(rs.getString(2));
				main.setText(rs.getString(3));
				main.setAdmin_id(rs.getString(4));
				main.setSupportDate(rs.getString(5));
				return main;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(String title, String text ,
			int SupportID) {
		try {
			PreparedStatement pstmt = conn.prepareStatement(
					"UPDATE EDU SET title=?, SET text=?, WHERE SupportID = ?");
			pstmt.setString(1, title);
			pstmt.setString(2, text);
			pstmt.setInt(3, SupportID);
			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	public int delete(int SupportID) {
		try {
			PreparedStatement pstmt = conn.prepareStatement("DELETE FROM EDU WHERE SupportID = ?");
			pstmt.setInt(1, SupportID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	
	}


