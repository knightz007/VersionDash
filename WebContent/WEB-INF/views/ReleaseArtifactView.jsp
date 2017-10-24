<%@ include file="header.jsp" %>

 <title>Release Artifact List</title>
 
<style>

/* body {
  font: 90%/1.45em "Helvetica Neue", HelveticaNeue, Verdana, Arial, Helvetica, sans-serif;
  margin: 0;
  padding: 0;
  color: #333;
  background-color: #fff;
} */

.red {
  background-color: #F08080 !important;
}

.txt:hover {
    text-decoration: underline;
}
td.highlight {
        font-weight: bold;
        color: red;
    }
</style>

 <script type="text/javascript">
 $(document).ready(function() {
	
	 
	 var table= $('#releaseArtifacts').DataTable({
		 	
		 "columnDefs": [
	    	    {  
	    	      className: "iframe cursor:pointer", "targets": [ 4, 5, 6 ]
	    	    }
	    	   
	    	  ],  		  

	    	  // Check if components for release is in sync
	    	  "createdRow": function( row, data, dataIndex ) {
	              if ( data[7] == "No" ) {        
	   	           	  $('td', row).eq(4).addClass('highlight');
	        		}
	              if ( data[8] == "No" ) {        
		            	  $('td', row).eq(5).addClass('highlight');
		        		}
	              if ( data[9] == "No" ) {        
		            	  $('td', row).eq(6).addClass('highlight');
		        		}	              
	      }	      
	    });
	    
	 	// Display server listing page based on environment clicked in table header column
	    $('#releaseArtifacts tbody').on('click', '.iframe', function(){
	    	var data = table.row( $(this).closest('tr') ).data();

	    	var idx = table.column( this ).index( 'visible' );
	    	var env="";
	    	if (idx == 4)
	    	{ 
	    		env = "qa";
	    	}
	    	if (idx == 5)
    		{ 
    			env = "stage";
    		}
	    	if (idx == 6)
	    	{ 
	    		env = "prod";
	    	}

	    	$(".iframe").colorbox({ iframe:true, innerWidth:"80%", innerHeight:"80%", href:"ServerInfoList?env="+env+"&component="+data[1]});

	    	});
	    
	 	// Display server listing based on version column selected - get results according to component and environment
	    $('#releaseArtifacts thead').on('click', '.iframe', function(){
	    	var idx = table.column( this ).index( 'visible' );
	    	var env="";
	    	if (idx == 4)
	    	{ 
	    		env = "qa";
	    	}
	    	if (idx == 5)
    		{ 
    			env = "stage";
    		}
	    	if (idx == 6)
	    	{ 
	    		env = "prod";
	    	}

	    	$(".iframe").colorbox({ iframe:true, innerWidth:"80%", innerHeight:"80%", href:"ServerInfoList?env="+env+"&component="});
	    	
	    });
	    
   
	      $("#msds-select").change(function () {
	          var x = $(this).val();		
	    	  $('#hiddenRelease').val(x);	         
	      });        
	      
	} ); 
 
 
 function Submit(value)
 {    
     document.getElementById("hiddenRelease").value = value;
     document.getElementById("artifactForm").submit();
 }

 </script>
</head>
 <body class="fixed-nav sticky-footer bg-dark" id="page-top">
   
 
 <%@ include file="sidenav.jsp" %>
 
   <div class="content-wrapper">
   <div class="container-fluid">
           <!-- Breadcrumbs -->
        <ol class="breadcrumb">
          <li class="breadcrumb-item">
            <a href="#">Dashboard</a>
          </li>
          <li class="breadcrumb-item active">My Dashboard</li>
        </ol>
   
   
<%String currentRelease = (String)request.getAttribute("currentRelease"); %>
<form id="artifactForm" action="ArtifactVersion"  method="POST">
<div>
 <!-- <h2>Release Artifacts dash</h2> -->
<label for="msds-select" style="font-weight:bold">Select Release:- </label>
 
<select id="msds-select" name="test" onchange="Submit(this.value);">
<% for (releaseInfo r: queryDB.getReleaseInfo()){
 String selected = "";
        if (r.getIsCurrentRelease().equals("Yes")) {
           selected = "selected"; } %> 
           
	 <option value="<%=r.getReleaseNumber()%>" <%=selected%>><%=r.getReleaseNumber()%></option>

<% } %> 
</select>

<input type="hidden" name="selectedValue" id="hiddenRelease" value=""/>
<input type="hidden" name="param" />  
<!-- <input type="submit" value="Load Release Artifacts"> -->
</div>

<p></p>
</form>

<div class="card mb-3">
<div class="card-header">
   <i class="fa fa-table"></i>
        Release Artifacts
</div>
<div class="card-body">
<div class="table-responsive">
<table id="releaseArtifacts" class="table table-bordered" width="100%" cellspacing="0">
       <thead>
           <tr>
               <th><u>Release</u></th>
               <th><u>Component</u></th>
               <th><u>Certified Artifact Version</u></th>  
               <th><u>Current Artifact Version</u></th> 
               <th><u>QA Artifact Version</u></th> 
               <th><u>Stage Artifact Version</u></th> 
               <th><u>Prod Artifact Version</u></th>   
          		<th></th>
          		<th></th>
          		<th></th>
           </tr>
       </thead>
       <tbody> 
      		<%        
        		String selectedValue = request.getParameter("selectedValue");
     			String releaseSelect =    request.getParameter("test"); 
        		if (releaseSelect == "" || releaseSelect == null)
        		{
        			releaseSelect=currentRelease;        	
        		} 
              for (ReleaseArtifactInfo r: queryDB.getArtifactInfoList(releaseSelect)){ %>              
                    <tr>
	                    <td><%=r.getRelease()%></td>
	                    <td><%=r.getComponent()%></td>
	                    <td><%=r.getCertifiedArtifactVersion()%></td>   
	                    <td><%=r.getCurrentArtifactVersion()%></td>
	                    <td style="cursor:pointer" class="txt"><%=r.getQAversion()%></td>  
	                    <td style="cursor:pointer" class="txt"><%=r.getStageversion()%></td>  
	                    <td style="cursor:pointer" class="txt"><%=r.getProdversion()%></td> 
	                    <td><%=r.getqaComponentInSync()%></td>
	                    <td><%=r.getstageComponentInSync()%></td>
	                    <td><%=r.getprodComponentInSync()%></td>
                    </tr>                	
       		<% } %>
   		</tbody>
</table>
</div>
</div>

</div>
</div>
</div>

<script>	
window.onload = function(){  
	    var value =<%=request.getParameter("selectedValue")%>; 	    
   		if(value !=null)  
	        {
	    	document.getElementById("msds-select").value = value;
	    	} 
   		  var table= $('#releaseArtifacts').DataTable();
   		  //hide column 7,8,9
   		  table.columns( [ 7, 8, 9 ] ).visible( false, false );
   		  
	      var hv = jQuery("#msds-select option:selected").text();

	      //Show all columns only for current release
	      if (hv !=  ${currentRelease})
	    	  {	    	  	
	      		table.columns( [ 3, 4, 5, 6 ] ).visible( false, false );  
	    	  } 
	} 
</script>

  <%@ include file="footer.html" %> 
 <!--  <footer class="sticky-footer">
      <div class="container">
        <div class="text-center">
          <small>Copyright &copy; Your Website 2017</small>
        </div>
      </div>
    </footer>
    
      <a class="scroll-to-top rounded" href="#page-top">
      <i class="fa fa-angle-up"></i>
    </a>

    Logout Modal
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-footer">
             <a class="btn btn-primary" href="login">Login</a>
          </div>
        </div>
      </div>
    </div> -->

</body>
</html>