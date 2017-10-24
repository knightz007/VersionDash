package com.dash.app;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dash.dbutil.DbConnector;

/**
 * Servlet implementation class myservlet
 */
@WebServlet("/myservlet")
public class myservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public myservlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
	
		
		String release_number = request.getParameter("id").toString();
		String isCurrentRelease = ""; 
		String action = request.getParameter("action").toString();
		String data = "";
		String deleteReleaseSql="";
		String addReleaseSql="";
		int result=0;
		Connection conn = null;
		PreparedStatement pstm = null;
		
		try {
		
				if (action.equals("deleteRelease"))
				{
					release_number = request.getParameter("id").toString();
				    deleteReleaseSql = "delete from testdb.releaselist where release_number='" + release_number + "'";
								
						    conn = DbConnector.getConnection();											
							pstm = conn.prepareStatement(deleteReleaseSql);
							result = pstm.executeUpdate();			 
		 			     
				}
				else if (action.equals("addRelease"))
				{
					release_number = request.getParameter("id").toString();
					isCurrentRelease = request.getParameter("IsCurrentRelease").toString();
					addReleaseSql = "INSERT INTO testdb.releaselist (release_number, IsCurrentRelease) VALUES ('" + release_number + "','" + 
							isCurrentRelease + "')" ;
					
					   try {
						    conn = DbConnector.getConnection();											
							pstm = conn.prepareStatement(addReleaseSql);
							result = pstm.executeUpdate();					
					   } catch (SQLException | ClassNotFoundException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}  	
				}
	
	   }
	   catch (SQLException | ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  
		finally
		{
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(result);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub]

		doGet(request, response);
	}

}
