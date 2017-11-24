<%@ include file="header.jsp" %>
<%@ page import="com.dash.beans.releaseInfo,com.dash.beans.releaseInfo,com.dash.apputil.queryDB"%>
<title>Set Current Release</title>
<style>
#accordion .card-header:after {
    font-family: 'FontAwesome';  
    content: "\f068";
    float: right;
    padding: 0px;
    margin: 0px;
}
#accordion .card-header.collapsed:after {
    /* symbol for "collapsed" panels */
    content: "\f067"; 
}
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js" integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ" crossorigin="anonymous"></script> 

 	
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
	        		$.colorbox({width:"900px", height:"600px", iframe:true, escKey:false, href:"manageCurrentRelease?action=editRelease&window=delete&release=" +data[0], overlayClose:false,onClosed:function() { location.reload(true); } });
	        	}
	        else
	        	{        
		        var result = confirm("Are you sure?");
		        if (result) {
		        	 table.row($(this).parents('tr')).remove().draw( false );

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
    

    $('#collapseOne').on('show.bs.collapse', function () {
  	   Cookies.set('tabCookie', 'showTabOne');
  	 $('#headingOne').removeClass('collapsed');
  	})
  	$('#collapseTwo').on('show.bs.collapse', function () {
  	  Cookies.set('tabCookie', 'showTabTwo');
  	$('#headingTwo').removeClass('collapsed');
  	})
  	$('#collapseThree').on('show.bs.collapse', function () {
  	  Cookies.set('tabCookie', 'showTabThree');
  	$('#headingThree').removeClass('collapsed');
  	})
  	
  	
   $('#collapseOne').on('hide.bs.collapse', function () {
	   $('#headingOne').addClass('collapsed');
  	})
  $('#collapseTwo').on('hide.bs.collapse', function () {
	  $('#headingTwo').addClass('collapsed');
  	})
  	$('#collapseThree').on('hide.bs.collapse', function () {
  	  $('#headingThree').addClass('collapsed');
  	})

   	
   	var cookieValue=Cookies.get('tabCookie');
    if(cookieValue == "showTabOne")
    	{
   			$('#collapseOne').collapse('show');
   			$('#headingOne').removeClass('collapsed');
   			$('#headingTwo').addClass('collapsed');
   			$('#headingThree').addClass('collapsed');
    	}
    if(cookieValue == "showTabTwo")
	{
			$('#collapseTwo').collapse('show');
			$('#headingTwo').removeClass('collapsed');
   			$('#headingOne').addClass('collapsed');
   			$('#headingThree').addClass('collapsed');
	}
    if(cookieValue == "showTabThree")
	{
			$('#collapseThree').collapse('show');
			$('#headingThree').removeClass('collapsed');
   			$('#headingTwo').addClass('collapsed');
   			$('#headingOne').addClass('collapsed');
	}
    
    $( "#headingOne" ).click(function() {
    	$('#collapseOne').collapse('toggle');
    	});
    
    $( "#headingTwo" ).click(function() {
    	$('#collapseTwo').collapse('toggle');
    	});
    
    $( "#headingThree" ).click(function() {
    	$('#collapseThree').collapse('toggle');
    	});
    
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
       
  <div id="accordion" role="tablist" aria-multiselectable="true"> 
        
        <div class="card mb-3">
			<div class="card-header" role="tab" id="headingOne">
				<h6 class="mb-0">
			        <a data-toggle="collapse" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
			        <i class="fa fa-table"></i>
			        <b>Set Current Release</b>
			        </a>
		       </h6>  
        	</div>
	        <div id="collapseOne" class="collapse show" role="tabpanel" aria-labelledby="headingOne" data-parent="#accordion">
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
      </div>
  
    	 <div class="card mb-3">
			<div class="card-header" role="tab" id="headingTwo">
				<h6 class="mb-0">
		         <a class="collapsed" data-toggle="collapse" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
		        <i class="fa fa-table"></i>
		         <b>Delete Release </b>
		        </a>
		       </h6> 
			</div>		
			<div id="collapseTwo" class="collapse" role="tabpanel" aria-labelledby="headingTwo" data-parent="#accordion">
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
		</div>
 
 <div class="card mb-3">
		<div class="card-header" role="tab" id="headingThree">
			<h6 class="mb-0">
				<a class="collapsed" data-toggle="collapse" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
			   		<i class="fa fa-table"></i>
			        <b>Add Release</b>
		        </a>
		     </h6> 
        </div>
      	<div id="collapseThree" class="collapse" role="tabpanel" aria-labelledby="headingThree" data-parent="#accordion"> 
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
</div>
</div>
  <%@ include file="footer.html" %>   
  </body>
  </html>