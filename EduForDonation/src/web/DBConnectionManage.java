package web;

import java.sql.*;
import java.util.Properties;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

/**
 * Application Lifecycle Listener implementation class DBConnectionManage
 *
 */
@WebListener
public class DBConnectionManage implements ServletContextListener {

	/**
	 * Default constructor.
	 */
	public DBConnectionManage() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see ServletContextListener#contextDestroyed(ServletContextEvent)
	 */
	public void contextDestroyed(ServletContextEvent sce) {
		Connection conn = (Connection) sce.getServletContext().getAttribute("DBconnection");

		try {
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * @see ServletContextListener#contextInitialized(ServletContextEvent)
	 */
	public void contextInitialized(ServletContextEvent sce) {
		Connection conn = null;
		Properties connectionProps = new Properties();

		try {
			Class.forName("com.mysql.jdbc.Driver");
		
		} catch (Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
			return;
		}

		ServletContext sc = sce.getServletContext();
		String url = sc.getInitParameter("dburl");
		String user = sc.getInitParameter("dbuser");
		String passwd = sc.getInitParameter("dbpasswd");

		connectionProps.put("user", user);
		connectionProps.put("password", passwd);

		try {
			conn = DriverManager.getConnection(url, connectionProps);
			if (conn != null)
				sc.setAttribute("DBconnection", conn);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
