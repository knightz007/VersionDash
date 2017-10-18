package com.dash.app;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.GenericServlet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;

import com.dash.apputil.queryDB;
import com.dash.beans.ReleaseArtifactInfo;

/**
 * Servlet implementation class ServerInfoList
 */
@WebServlet("/ServerInfoList")
public class ServerInfoList extends GenericServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see GenericServlet#GenericServlet()
     */
    public ServerInfoList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Servlet#service(ServletRequest request, ServletResponse response)
	 */
	public void service(ServletRequest request, ServletResponse response) throws ServletException, IOException {
		String env="";
		String component="";
	//response.getWriter().write(request.getParameter("env"));
		if(request.getParameter("env") != null && request.getParameter("component") != null)
		{
			 env = request.getParameter("env").toString();
			 component = request.getParameter("component").toString();
		}
		else
		{
			env = "";
			component = "";
		}
	
	request.setAttribute("environment", env);	
	request.setAttribute("component", component);	
	RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/ServerInfoList.jsp");
	dispatcher.forward(request, response);
	}

}
