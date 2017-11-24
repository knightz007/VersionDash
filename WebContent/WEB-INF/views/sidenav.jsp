<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ page import="com.dash.beans.UserAccount"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 <script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	var cookieValue = Cookies.get('hiddenCookie');
	var ulClassName = $('#collapseComponents').attr('class');
	
   if(cookieValue == "hidden")
		{
		$('#page-top').removeClass('sidenav-toggled');	
		}
	
   if((cookieValue == "show"))
		
		{		
		$('#page-top').addClass('sidenav-toggled');	
		} 
	
		
       $('#sidenavToggler').click(function(){
			var className = $('#page-top').attr('class');
			
			if (className == 'fixed-nav sticky-footer bg-dark')
				{
				Cookies.set('hiddenCookie', 'hidden', { expires: 1 });	
				$('#page-top').removeClass('sidenav-toggled');	
				 Cookies.set('hiddenCookie', 'hidden');
				}
			if (className == 'fixed-nav sticky-footer bg-dark sidenav-toggled')
			{
			Cookies.set('hiddenCookie', 'show', { expires: 1 });	
			$('#page-top').addClass('sidenav-toggled');
			Cookies.set('hiddenCookie', 'show');
			}  	   	
			
		});
      
       $('#collapseComponents').on('click', function (event) {
    	   if (event.target != this) {    	     
				$('#page-top').removeClass('sidenav-toggled');	
				 Cookies.set('hiddenCookie', 'hidden');
    	   } else {
    	     //alert('You actually clicked #container itself.');
    	   }
    	 }); 

});
</script>

	

   <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top" id="mainNav">
      <a class="navbar-brand" href="#">Stars Dash</a>
      <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav navbar-sidenav" id="exampleAccordion">
          <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Dashboard">
            <a class="nav-link" href="ArtifactVersion">
              <i class="fa fa-fw fa-table"></i>
              <span class="nav-link-text">
                Artifact Versions</span>               
            </a>
          </li>
          <%UserAccount user = (UserAccount)request.getAttribute("user");  %>
            <%      		
       		 if (user != null)
        		{ %>
          <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Components">
            <a class="nav-link nav-link-collapse collapsed" data-toggle="collapse" href="#collapseComponents" data-parent="#exampleAccordion">
              <i class="fa fa-fw fa-wrench"></i>
              <span class="nav-link-text">
                Administration</span>
            </a>
            <ul class="sidenav-second-level collapse" id="collapseComponents">
              <li>
                <a href="manageReleases">Manage Release</a>
              </li>
              <li>
                <a href="SetCertifiedVersion">Set Certified Version</a>
              </li>
            </ul>
          </li>
           <% }  %> 
        </ul>
        <ul class="navbar-nav sidenav-toggler">
          <li class="nav-item">
            <a class="nav-link text-center" id="sidenavToggler">
              <i class="fa fa-fw fa-angle-left"></i>
            </a>
          </li>
        </ul>
        <ul class="navbar-nav ml-auto">
        
        <%      		
        if (user != null)
        		{ %>
        <li class="nav-item">
        <i style="text-align: center;color: floralwhite;padding:.5rem 1rem;display: block;">Hello ${user.userName} </i>         
        </li>
        <% }  %>      
        
          <li class="nav-item">
            <form class="form-inline my-2 my-lg-0 mr-lg-2">
              <div class="input-group">
                <input type="text" class="form-control" placeholder="Search for...">
                <span class="input-group-btn">
                  <button class="btn btn-primary" type="button">
                    <i class="fa fa-search"></i>
                  </button>
                </span>
              </div>
            </form>
          </li>
               <%      		
        		if (user == null)
        		{ %>
		         <li class="nav-item">
		         <form method="post" action="login" >
		            <a class="nav-link" href="login">
		              <i class="fa fa-fw"></i>
		              Login</a>
		          </form>
		          </li>        			      	
        		<% } else { %>                       	
       	
		         <li class="nav-item">
		            <a class="nav-link" data-toggle="modal" data-target="#exampleModal">
		              <i class="fa fa-fw fa-sign-out"></i>
		              Logout</a>
		          </li>
		          
		          <% } %>
        </ul>
      </div>
    </nav>
    
        <script>
        $(function () {
            setNavigation();
        });

        function setNavigation() {
            var path = window.location.pathname;
            path = path.split("/")[2];
            path = decodeURIComponent(path);

            $("#exampleAccordion a").each(function () {
                var href = $(this).attr('href');
                if (path.substring(0, href.length) === href) {
                    $(this).closest('li').addClass('active');                    
                    $(this).closest('ul').addClass('show');                      
                    $(this).closest('ul').parent().children('a.nav-link').removeClass('collapsed');                   
                }
            });
        }
    </script>