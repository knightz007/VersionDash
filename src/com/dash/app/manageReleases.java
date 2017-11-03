package com.dash.app;

import java.io.IOException;
import java.io.StringWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.GenericServlet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dash.apputil.UserUtil;
import com.dash.beans.UserAccount;
import com.dash.dbutil.DbConnector;

/**
 * Servlet implementation class SetCurrentRelease
 */
@WebServlet("/manageReleases")
public class manageReleases extends GenericServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see GenericServlet#GenericServlet()
     */
    public manageReleases() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Servlet#service(ServletRequest request, ServletResponse response)
	 */
	public void service(ServletRequest request, ServletResponse response) throws ServletException, IOException {
		
		
		HttpServletRequest httpreq = (HttpServletRequest)request;
		HttpSession session = httpreq.getSession();
		UserAccount loginedUser = UserUtil.getLoginedUser(session);
		
		String select_CurrentRelease = "";
		String releaseToDelete="";
		
			if( ((request.getParameter("select_CurrentRelease") != null && ! request.getParameter("select_CurrentRelease").isEmpty())				
					&& ( request.getParameter("release") != null && ! request.getParameter("release").isEmpty())) ) 
			{
				//do nothing
				select_CurrentRelease = request.getParameter("select_CurrentRelease").toString();
				releaseToDelete = request.getParameter("release").toString();

			}
			else
				{
				if (loginedUser != null)  //do no check for logged in user and redirect again to manageReleases.jsp 
				{
					/*if (loginedUser != null) { */
						request.setAttribute("user", loginedUser);
						
						RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/WEB-INF/views/manageReleases.jsp");
					    dispatcher.forward(request, response);	
			    }
				else
				{
					RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/WEB-INF/views/loginViewNew.jsp");
					dispatcher.forward(request, response);
				}
			}
			
	
		
		Connection conn = null;
		PreparedStatement pstm = null;
		int result=0;	
		
		try {
		
		if( (request.getParameter("id") != null && ! request.getParameter("id").isEmpty()) 
			 || ( request.getParameter("action") != null &&  ! request.getParameter("action").isEmpty() ))
		{
				String release_number = request.getParameter("id").toString();
				String isCurrentRelease = ""; 
				String action = request.getParameter("action").toString();
				String data = "";
				String deleteReleaseSql="";
				String addReleaseSql="";
				String editReleaseSql="";
					
	
		
				if (action.equals("deleteRelease"))
				{
					release_number = request.getParameter("id").toString();
				    deleteReleaseSql = "delete from testdb.releaselist where release_number='" + release_number + "'";
								
						    conn = DbConnector.getConnection();											
							pstm = conn.prepareStatement(deleteReleaseSql);
							result = pstm.executeUpdate();			 
		 			     
				}
				else if (action.equals("editRelease"))
				{
					release_number = request.getParameter("id").toString();
					isCurrentRelease = request.getParameter("IsCurrentRelease").toString();
					editReleaseSql = "Update testdb.releaselist set IsCurrentRelease='" + isCurrentRelease + "' where release_number='" + release_number + "'";
					  
						    conn = DbConnector.getConnection();											
							pstm = conn.prepareStatement(editReleaseSql);
							result = pstm.executeUpdate();		
				}
				else if (action.equals("addRelease"))
				{
					release_number = request.getParameter("id").toString();
					isCurrentRelease = request.getParameter("IsCurrentRelease").toString();
					addReleaseSql = "INSERT INTO testdb.releaselist (release_number, IsCurrentRelease) VALUES ('" + release_number + "','" + 
							isCurrentRelease + "')" ;					
					  
						    conn = DbConnector.getConnection();											
							pstm = conn.prepareStatement(addReleaseSql);
							result = pstm.executeUpdate();				 	
				}	
				else if (action.equals("setCurrentRelease"))
				{
					release_number = request.getParameter("id").toString();
					isCurrentRelease = request.getParameter("IsCurrentRelease").toString();
					addReleaseSql = "INSERT INTO testdb.releaselist (release_number, IsCurrentRelease) VALUES ('" + release_number + "','" + 
							isCurrentRelease + "')" ;					
					  
						    conn = DbConnector.getConnection();											
							pstm = conn.prepareStatement(addReleaseSql);
							result = pstm.executeUpdate();				 	
				}	
		
					conn.close();
					response.setContentType("text/plain");
					response.setCharacterEncoding("UTF-8");
					response.getWriter().write(result);
				}
		
		if( (request.getParameter("select_CurrentRelease") != null && ! request.getParameter("select_CurrentRelease").isEmpty())				
				&& ( request.getParameter("release") != null && ! request.getParameter("release").isEmpty() )) 
			{
			String release_number_current = request.getParameter("select_CurrentRelease").toString();
			String release_number_toUnset = request.getParameter("release").toString();
			StringWriter message = new StringWriter();
			RequestDispatcher dispatcher;
			
			if (loginedUser != null)  //do no check for logged in user and redirect again to manageReleases.jsp 
			{
				/*if (loginedUser != null) { */
					request.setAttribute("user", loginedUser);

		    }
			
			if(release_number_current.equals(release_number_toUnset))
			{
				message.append(release_number_current +  " is same as as current release. No action needed!!");
				request.setAttribute("SetReleaseMessage", message.toString());
				
				if( (request.getParameter("formAction") != null &&  request.getParameter("formAction").equals("delete")))
				{
					dispatcher = request.getServletContext().getRequestDispatcher("/WEB-INF/views/message.jsp");
				}
				else
				{
					dispatcher = request.getServletContext().getRequestDispatcher("/WEB-INF/views/manageReleases.jsp");
				}
				
			}
			else
			{
			
			String updateReleaseSql = "Update testdb.releaselist set IsCurrentRelease='Yes' where release_number='" + release_number_current + "'";
			
				    conn = DbConnector.getConnection();											
					pstm = conn.prepareStatement(updateReleaseSql);
					pstm.executeUpdate();
					
			
			String  unSetReleaseSql = "Update testdb.releaselist set IsCurrentRelease='No' where release_number='" + release_number_toUnset + "'";						
				pstm = conn.prepareStatement(unSetReleaseSql);
				pstm.executeUpdate();
		
				message.append(release_number_current +  " set as current release." +  release_number_toUnset + " has been updated.");
				request.setAttribute("SetReleaseMessage", message.toString());
				conn.close();

				
				if( (request.getParameter("formAction") != null &&  request.getParameter("formAction").equals("delete")))
				{
					 String deleteReleaseSql = "delete from testdb.releaselist where release_number='" + request.getParameter("release").toString() + "'";
					    conn = DbConnector.getConnection();											
						pstm = conn.prepareStatement(deleteReleaseSql);
						result = pstm.executeUpdate();	
					dispatcher = request.getServletContext().getRequestDispatcher("/WEB-INF/views/message.jsp");
				}
				else
				{
					dispatcher = request.getServletContext().getRequestDispatcher("/WEB-INF/views/manageReleases.jsp");				
				}
				
				
			}
			dispatcher.forward(request, response);
			}
				
		
		   }
		   catch (SQLException | ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}  
			finally
			{
	/*			try {
					//conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}*/
			}
		
	}

}
