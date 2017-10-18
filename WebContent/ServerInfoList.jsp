 <%@ include file="header.jsp" %>
 <title>Server List</title>
<%@ page import="com.dash.beans.ServerInfo,com.dash.apputil.queryDB" %>
 <script type="text/javascript">
 $(document).ready(function() {
	    $('#servers').DataTable();
	   } );
 </script>
</head>
<body>
<div id="container">
<!-- <h1>Servers</h1> -->
<%String env = (String)request.getAttribute("environment"); %>
<%String component = (String)request.getAttribute("component"); %>
</div>

<div class="card mb-3">
<div class="card-header">
   <i class="fa fa-table"></i>
       Servers
</div>
<div class="card-body">
<div class="table-responsive">
<table id="servers" class="table table-bordered" width="100%" cellspacing="0">
       <thead>
           <tr>
               <th><u>Host name</u></th>
               <th><u>Environment</u></th>
               <th><u>Components:Version</u></th>                          
           </tr>
       </thead>
       <tbody> 
                <% for (ServerInfo s: queryDB.getServerList(env, component)){ %>              
                    <tr>
                    <td><%=s.getHostname()%></td>
                     <td><%=s.getEnvironment()%></td>
                     <td><%=s.getComponent_version()%></td>                    
                    </tr>                
				<% } %>
   		</tbody>
</table>
</div>
</div>
</div>	

    <!-- <script src="sbdash/vendor/jquery/jquery.min.js"></script> -->
    <script src="sbdash/vendor/popper/popper.min.js"></script>
    <script src="sbdash/vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Plugin JavaScript -->
    <script src="sbdash/vendor/jquery-easing/jquery.easing.min.js"></script>
<!-- <script src="sbdash/vendor/chart.js/Chart.min.js"></script>  -->
    <script src="sbdash/vendor/datatables/jquery.dataTables.js"></script>
    <script src="sbdash/vendor/datatables/dataTables.bootstrap4.js"></script>
    

    <!-- Custom scripts for this template -->
    <script src="sbdash/js/sb-admin.min.js"></script>
</body>
</html>