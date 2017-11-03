<%@ include file="header.jsp" %>
<title>Message</title>
  	 <%String message = (String)request.getAttribute("SetReleaseMessage"); %>
</head>

<body class="fixed-nav sticky-footer bg-dark" id="page-top">
<div class="content-wrapper">
   <div class="container-fluid">
	  <h3>
	 	<%=message%>
	 </h3>
   </div>
</div>
</body>
</html>