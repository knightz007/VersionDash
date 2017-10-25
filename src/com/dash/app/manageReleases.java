package com.dash.app;

import java.io.IOException;
import javax.servlet.GenericServlet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.dash.apputil.UserUtil;
import com.dash.beans.UserAccount;

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
		
		if (loginedUser != null) {
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

}
