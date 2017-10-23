<%@ include file="header.jsp" %>
<%@ page import="com.dash.beans.releaseInfo,com.dash.beans.releaseInfo,com.dash.apputil.queryDB"%>
<title>Set Current Release</title>
<!--  <link href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css" rel="stylesheet"> -->
<!-- <link href="https://cdn.datatables.net/1.10.16/css/dataTables.bootstrap4.min.css" rel="stylesheet">  -->
<script>
$(document).ready(function() {
    var table = $('#releaseInfo').DataTable( {
           "columnDefs": [ {
            "targets": -1,
            "data": null,
            "defaultContent": "<button>Delete</button>"
        } ]
    } );
 
    $('#releaseInfo tbody').on( 'click', 'button', function () {
        var data = table.row( $(this).parents('tr') ).data();
        var result = confirm("Are you sure?");
        if (result) {
        	 table.row($(this).parents('tr')).remove().draw( false );
        	 document.location.href = '${pageContext.request.contextPath}/ArtifactVersion';
        }        
    } );
} );
</script>

</head>
 <body class="fixed-nav sticky-footer bg-dark" id="page-top">
  <%@ include file="sidenav.jsp" %>
   <div class="content-wrapper">
   <div class="container-fluid">
           <!-- Breadcrumbs -->
        <ol class="breadcrumb">
          <li class="breadcrumb-item">
            <a href="ArtifactVersion">Dashboard</a>
          </li>
          <li class="breadcrumb-item active">Set current release</li>
        </ol>
        
     <!--    <button id="button">Delete</button> -->
        <div class="card mb-3">
		<div class="card-header">
   		<i class="fa fa-table"></i>
        Delete Release
		</div>
		<div class="card-body">
		<div class="table-responsive">
       <table id="releaseInfo" class="table table-bordered" width="100%" cellspacing="0">
       <thead>
           <tr>
               <th><u>Release</u></th>
               <th><u>IsCurrentRelease</u></th>
               <th></th>
           </tr>
       </thead>
       <tbody> 
      		<%        
              for (releaseInfo r: queryDB.getReleaseInfo()){ %>              
                    <tr>
	                    <td><%=r.getReleaseNumber()%></td>
	                    <td><%=r.getIsCurrentRelease()%></td>
	                    <td></td>
                    </tr>                	
       		<% } %>
   		</tbody>
</table>
     
   		</div>
</div>
</div>
</div>
</div>

  <%@ include file="footer.html" %> 
  
  </body>
  </html>