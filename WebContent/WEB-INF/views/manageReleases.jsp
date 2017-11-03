<%@ include file="header.jsp" %>
<%@ page import="com.dash.beans.releaseInfo,com.dash.beans.releaseInfo,com.dash.apputil.queryDB"%>
<title>Set Current Release</title>
<!--  <link href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css" rel="stylesheet"> -->
<!-- <link href="https://cdn.datatables.net/1.10.16/css/dataTables.bootstrap4.min.css" rel="stylesheet">  -->


<!-- <script src="https://editor.datatables.net/extensions/Editor/js/dataTables.editor.min.js" type="text/javascript"></script> -->
<script>

$(document).ready(function() {

	
    var table = $('#releaseInfo').DataTable( {
           "columnDefs": [ {
            "targets": -1,
            "data": null,
            "defaultContent": '<button id="delete">Delete</button>'
        } ]
    } );
    
    $('#releaseInfo tbody').on( 'click', 'link', function (e) {
    	 var data = table.row( $(this).parents('tr') ).data();
    	 //alert("hello");
    });
    
    
    
 
    $('#releaseInfo tbody').on( 'click', 'button', function (e) {
        var data = table.row( $(this).parents('tr') ).data();
        //alert(this.id);
        
 
        if(this.id == "delete")
    	{
	        if(data[1] == "Yes")      
	        	{
	        		//alert("You are deleting a current release");
	        		//$(".iframe").colorbox({ iframe:true, innerWidth:"80%", innerHeight:"80%", href:"ArtifactVersion"});
	        		//$.colorbox({width:"900px", height:"600px", iframe:true, href:"manageCurrentRelease?action=editRelease&window=delete&release=" +data[0] });
	        		$.colorbox({width:"900px", height:"600px", iframe:true, escKey:false, href:"manageCurrentRelease?action=editRelease&window=delete&release=" +data[0], overlayClose:false,onClosed:function() { location.reload(true); } });
	        		//location.reload();
	        	}
	        else
	        	{        
		        var result = confirm("Are you sure?");
		        if (result) {
		        	 table.row($(this).parents('tr')).remove().draw( false );
		        	 //document.location.href = '${pageContext.request.contextPath}/ArtifactVersion';
		        	 //e.preventDefault();
		        	 //alert(data[0])
		        	 $.ajax({
		                 type:"POST",
		                 data: { 'id': data[0], 'action':'deleteRelease' },
		                 url : '${pageContext.request.contextPath}/manageReleases',
		                 dataType: "text",
		                 success: function(data) {
		                   //alert('success'); 
		                   location.reload();
		                 },
		                 error: function(data) {
		                     alert('error');
		                 }
		             });
		       
		        	} 
	       		}
    	}
/*         else if(this.id == "edit")
        	{
        	alert("Its edit")
        	if(data[1] == "Yes")      
	        	{
	        		$.colorbox({width:"900px", height:"600px", iframe:true, escKey:false, href:"manageCurrentRelease?action=editRelease&window=edit&release=" +data[0], overlayClose:false,onClosed:function() { location.reload(true); } });	        		
	        	}
        	
        	} */

        

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
        
      
        if ( (counter >= 1  &&  $('#select_isCurrentRelease').val() != "Yes") || ( counter == 0 ))
	        {
		        t.row.add( [
		        	$('#input_release').val(),
		        	$('#select_isCurrentRelease').val()
		        ] ).draw( false ); 
		        
	        	 $.ajax({
	                 type:"POST",
	                 data: { 'id': $('#input_release').val(), 'IsCurrentRelease': $('#select_isCurrentRelease').val() , 'action':'addRelease' },
	                 url : '${pageContext.request.contextPath}/manageReleases',
	                 dataType: "text",
	                 success: function(data) {
	                   //alert('success'); 
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
          <li class="breadcrumb-item active">Manage Release</li>
        </ol>
        
        
        <div class="card mb-3">
		<div class="card-header">
   		<i class="fa fa-table"></i>
        <b>Set Current Release</b>
        </div>
     
        <div class="card-body">  
        <%String SetReleaseMessage = (String)request.getAttribute("SetReleaseMessage"); %>
        		<% if (SetReleaseMessage != null && ! SetReleaseMessage.isEmpty())
		{ %>		
			<h4><label><%=SetReleaseMessage%></label> </h4>
		<%} else {%>
        <form id="setCurrentReleaseForm" action="manageReleases"  method="POST">    
        <label for="input_CurrentRelease">Enter release to be set as current:</label> 
  		<!--  <input type="text" id="input_CurrentRelease"> -->
        <select id="select_CurrentRelease" name="select_CurrentRelease">
			<% String current_release= queryDB.getCurrentRelease();
			for (releaseInfo r: queryDB.getReleaseInfo()){ 	%>            
				 <option value="<%=r.getReleaseNumber()%>"><%=r.getReleaseNumber()%></option>				 
			<% } %> 
		</select>
		
					
        	<input type="hidden" name="release" id="currentReleaseToUnset" value="<%=current_release%>" />
			 &#160; &nbsp;&#160; &nbsp;			
			<input type="submit" id="btn_setCurrentRelease" value="Set Current Release" >		
		</form>
		<%} %>
        </div>       
      </div>
        
        
        
        
        
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
      			Integer count = 0;              
      			for (releaseInfo r: queryDB.getReleaseInfo()){       				
              	%>              
                    <tr>
	                    <td><%=r.getReleaseNumber()%></td>
	                    <td><%=r.getIsCurrentRelease()%></td>
	                    <%-- <td><input type="text" id="row-<%=count%>" name="row-<%=count%>" value="<%=r.getIsCurrentRelease()%>"></td> --%>
	                    <td></td>
                    </tr>                	
       		<% count = count + 1;} %>
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