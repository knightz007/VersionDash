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
 
    $('#releaseInfo tbody').on( 'click', 'button', function (e) {
        var data = table.row( $(this).parents('tr') ).data();
        var result = confirm("Are you sure?");
        if (result) {
        	 table.row($(this).parents('tr')).remove().draw( false );
        	 //document.location.href = '${pageContext.request.contextPath}/ArtifactVersion';
        	 //e.preventDefault();
        	 //alert(data[0])
        	 $.ajax({
                 type:"POST",
                 data: { 'id': data[0], 'action':'deleteRelease' },
                 url : '${pageContext.request.contextPath}/myservlet',
                 dataType: "text",
                 success: function(data) {
                   alert('success');  // this alert is not working
                   location.reload();
                 },
                 error: function(data) {
                     alert('error');
                 }
             });
       
        }        
    } );
    
    //Add row
    
    var t = $('#releaseInfoAdd').DataTable();
    var counter = 0;  

 
    $('#btn_addRelease').on( 'click', function () {
        t
        .column( 1 )
        .data()
        .each( function ( value, index ) {
            console.log( 'Data in index: '+index+' is: '+value );
            if(value == "Yes")
            	{
            	counter=counter+1;
            	}
        } );
        
        //alert("counter: " + counter );
        
        if ( (counter >= 1  &&  $('#select_isCurrentRelease').val() != "Yes") || ( counter == 0 ))
	        {
		        t.row.add( [
		        	$('#input_release').val(),
		        	$('#select_isCurrentRelease').val()
		        ] ).draw( false ); 
		        
	        	 $.ajax({
	                 type:"POST",
	                 data: { 'id': $('#input_release').val(), 'IsCurrentRelease': $('#select_isCurrentRelease').val() , 'action':'addRelease' },
	                 url : '${pageContext.request.contextPath}/myservlet',
	                 dataType: "text",
	                 success: function(data) {
	                   alert('success'); 
	                   location.reload();
	                 },
	                 error: function(data) {
	                   alert('error');
	                 }
	             });
		        
	        }
        else 
        	{
        		alert("A current release is already set. Please update/delete the existing release before adding this.");
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
         <b>Delete Release </b>
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

       <div class="card mb-3">
		<div class="card-header">
   		<i class="fa fa-table"></i>
        <b>Add Release</b>
        </div>
        <div class="card-header">
	        <label for="input_release">Enter release to add:</label> 
	        <input type="text" id="input_release">
	        &#160; &nbsp;
	        <label for="select_isCurrentRelease">Is this a current release?</label>
	        <select id="select_isCurrentRelease">
			  <option value="No">No</option>
			  <option value="Yes">Yes</option>
			</select>
			 &#160; &nbsp;&#160; &nbsp;
			
			<input type="button" id="btn_addRelease" value="Add">		
        </div>
		
		<div class="card-body">
		<div class="table-responsive">
       <table id="releaseInfoAdd" class="table table-bordered" width="100%" cellspacing="0">
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
</div>
    
</div>
</div>

  <%@ include file="footer.html" %> 
  
  </body>
  </html>