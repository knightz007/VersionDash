<%@ include file="header.jsp" %>
<title>Manage Current Release</title>
</head>

<body class="fixed-nav sticky-footer bg-dark" id="page-top">
   
 
 <%-- <%@ include file="sidenav.jsp" %> --%>
 
   <div class="content-wrapper">
   <div class="container-fluid">
	<form id="currentReleaseForm" action="manageCurrentRelease"  method="POST">
		
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
        
        <div class="card-body">        
        <label for="input_CurrentRelease">Enter release to be set as current:</label> 
        <input type="text" id="input_CurrentRelease">
			 &#160; &nbsp;&#160; &nbsp;			
			<input type="button" id="btn_setCurrentRelease" value="Add">		
        </div>
      </div>
	
	</form>  
</div>
</div>
 <%--  <%@ include file="footer.html" %>  --%>
</body>
</html>