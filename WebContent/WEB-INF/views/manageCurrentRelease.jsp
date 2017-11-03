<%@ include file="header.jsp" %>
<title>Manage Current Release</title>

<script>

$("#btn_setCurrentRelease").click(function () { 
alert("Hello");
});

</script>


</head>

<body class="fixed-nav sticky-footer bg-dark" id="page-top">
   
 
 <%-- <%@ include file="sidenav.jsp" %> --%>
 <%String action = (String)request.getAttribute("action"); %>
 <%String window = (String)request.getAttribute("window"); %>
 <%String release = (String)request.getAttribute("release"); %>
 
   <div class="content-wrapper">
   <div class="container-fluid">
   
	    <form id="setCurrentReleaseForm" action="manageReleases"  method="POST">
		
	<div class="card mb-3">
		<div class="card-header">
   		<i class="fa fa-table"></i>
        <b>Set Current Release</b>
        </div>
        <!-- <div class="card-header">
	        <label for="input_CurrentRelease">Enter release to be set as current:</label> 
			 &#160; &nbsp;&#160; &nbsp;			
			<input type="button" id="btn_setCurrentRelease" value="Add">		
        </div> -->
     
       <%  if(window.equals("delete")) { %>
        <div class="card-body">  
       
        <b>You are deleting the current release. Please set a new current release before proceeding.</b>
         <p></p>
        <label for="input_CurrentRelease">Enter release to be set as current:</label> 
  		<!--  <input type="text" id="input_CurrentRelease"> -->
        <select id="select_CurrentRelease" name="select_CurrentRelease">
			<% for (releaseInfo r: queryDB.getReleaseInfo()){ %>            
				 <option value="<%=r.getReleaseNumber()%>"><%=r.getReleaseNumber()%></option>
			<% } %> 
		</select>
		<%-- <label for="input_CurrentRelease">Release to delete: <%=release%></label> --%>
		<input type="hidden" name="formAction" id="formAction" value="delete" />
		<input type="hidden" name="release" id="releaseToDelete" value="<%=release%>" />
		
        
			 &#160; &nbsp;&#160; &nbsp;			
			<input type="submit" id="btn_setCurrentRelease" value="Set Current Release" >	
			
		
        </div>
        <% } %>        
        
       
      </div>
	</form>
	
</div>
</div>
 <%--  <%@ include file="footer.html" %>  --%>
</body>
</html>