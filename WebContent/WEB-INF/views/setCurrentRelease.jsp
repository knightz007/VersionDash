<%@ include file="header.jsp" %>
<%@ page import="com.dash.beans.releaseInfo,com.dash.beans.releaseInfo,com.dash.apputil.queryDB"%>
<title>Set Current Release</title>
<link href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css" rel="stylesheet">
<link href="https://cdn.datatables.net/1.10.16/css/dataTables.bootstrap4.min.css" rel="stylesheet"> 
<script>
$(document).ready(function() {
    var table = $('#releaseInfo').DataTable();
 
    $('#releaseInfo tbody').on( 'click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
        }
        else {
            table.$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
        
        var data = table.row( $(this).closest('tr') ).data();
        //alert(data[1]);
        
    } );
 
    $('#button').click( function () {
    	//alert("hello");
    	var datarow =  table.rows('.selected').data();
    	
        alert(datarow[0]);
        
        
       // table.row('.selected').remove().draw( false );
     
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
        
        <button id="button">Delete</button>
        
       <table id="releaseInfo" class="table table-bordered" width="100%" cellspacing="0">
       <thead>
           <tr>
               <th><u>Release</u></th>
               <th><u>IsCurrentRelease</u></th>
           </tr>
       </thead>
       <tbody> 
      		<%        
              for (releaseInfo r: queryDB.getReleaseInfo()){ %>              
                    <tr>
	                    <td><%=r.getReleaseNumber()%></td>
	                    <td><%=r.getIsCurrentRelease()%></td>
                    </tr>                	
       		<% } %>
   		</tbody>
</table>
        
   </div>
</div>

  <%@ include file="footer.html" %> 
  
  </body>
  </html>