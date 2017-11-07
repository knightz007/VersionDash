package com.dash.app;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dash.apputil.UserUtil;
import com.dash.beans.UserAccount;
import com.dash.dbutil.DbConnector;
import com.google.gson.JsonObject;

/**
 * Servlet implementation class SetCertifiedVersion
 */
@WebServlet("/SetCertifiedVersion")
public class SetCertifiedVersion extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SetCertifiedVersion() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		HttpSession session = request.getSession();
		UserAccount loginedUser = UserUtil.getLoginedUser(session);
		if (loginedUser != null)  //do no check for logged in user and redirect again to manageReleases.jsp 
		{
				request.setAttribute("user", loginedUser);
				RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/WEB-INF/views/setCertifiedVersion.jsp");
			    dispatcher.forward(request, response);	
	    }
		else
		{
			RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/WEB-INF/views/loginViewNew.jsp");
			dispatcher.forward(request, response);
		}
  		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		String data ="";
		if(request.getParameter("data") != null &&  ! request.getParameter("data").isEmpty())
				{
				 data = request.getParameter("data").toString();
			     
			
		
		
		try
		{
		Connection conn = null;
		PreparedStatement pstm = null;
		
		
		//System.out.println(data);		
		
		String[] dataArray=data.split("&");
		System.out.println("data:" + data);
		System.out.println("length:" + dataArray.length);
		int count=0;
		String[] release = new String[dataArray.length];
		String[] component = new String[dataArray.length];;
		String[] certifiedArtifactVersion = new String[dataArray.length];;
		int tempCounter=0;
		
	
		for(String dataitem:dataArray)
		{
			if(count<=2)
			{
				if(count==0)
				{
					release[tempCounter] = dataitem.split("=")[1];
					count++;
					continue;
				}
				if(count==1)
				{
					component[tempCounter] = dataitem.split("=")[1];
					count++;
					continue;
				}
				if(count==2)
				{
					certifiedArtifactVersion[tempCounter] = dataitem.split("=")[1];
					count=0;
					tempCounter++;
					continue;
				}				
			}			
		}
		
		
		
		
		System.out.println("release:" + release[0]);
		System.out.println("component:" + component[0]);
		System.out.println("certifiedArtifactVersion:" + certifiedArtifactVersion[0]);
		
		System.out.println("release:" + release[1]);
		System.out.println("component:" + component[1]);
		System.out.println("certifiedArtifactVersion:" + certifiedArtifactVersion[1]);
		
		System.out.println("release:" + release.length/3);
		
	   int numberOfComponents = release.length/3;
	   String updateArtifactsSQL = "";
	   conn = DbConnector.getConnection();	
		
		for(int i=0; i<numberOfComponents;i++)
		{
			updateArtifactsSQL = "Update testdb.releaseartifactinfo set certifiedartifactversion='" + certifiedArtifactVersion[i] +  "' where release_number='" + release[i] + "' "
					+ "and component='" + component[i] + "'";
			pstm = conn.prepareStatement(updateArtifactsSQL);
			pstm.executeUpdate();				
		}
		
		
		     //  JsonObject jobj = new JsonObject();
			//	String urlToRedirect = "/WEB-INF/views/setCertifiedVersion.jsp";
			//	jobj.addProperty("url", urlToRedirect);
				//jobj.put("url",urlToRedirect);
			//	response.getWriter().write(jobj.toString());
		//request.setAttribute("SetReleaseMessage", "Update Certified Version for " + release[0] );
		//RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/WEB-INF/views/setCertifiedVersion.jsp");
		//dispatcher.forward(request, response);
		
		}
		catch(SQLException | ClassNotFoundException e)
			{
				e.printStackTrace();
			}
		
		}
		else
		{
			 doGet(request, response);
		}
		

	}

}
