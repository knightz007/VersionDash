<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.dash.beans.ReleaseArtifactInfo,com.dash.beans.releaseInfo,com.dash.apputil.queryDB"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Release Artifact List</title>
  
<link rel="stylesheet" href="bootstrap/css/bootstrap-theme.css" type="text/css" />  
<LINK href="https://cdn.datatables.net/1.10.15/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css"/>
<LINK href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="colorbox/example1/colorbox.css" type="text/css" />
  
<script type="text/javascript" src="//code.jquery.com/jquery-1.12.4.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/1.10.15/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/1.10.15/js/dataTables.jqueryui.min.js"></script>
 <script src="colorbox/jquery.colorbox.js" type="text/javascript"></script>


 <style>

body {
  font: 90%/1.45em "Helvetica Neue", HelveticaNeue, Verdana, Arial, Helvetica, sans-serif;
  margin: 0;
  padding: 0;
  color: #333;
  background-color: #fff;
}

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
<body>
<%String currentRelease = (String)request.getAttribute("currentRelease"); %>
<form id="artifactForm" action="ArtifactVersion"  method="POST">
<div>
 <h2>Release Artifacts dash</h2>
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
<table id="releaseArtifacts" class="display responsive nowrap" width="100%" cellspacing="0">
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
				String releaseSelect = request.getParameter("test"); 
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
</body>
</html>