<%@ include file="header.jsp" %>
<%@ page import="com.dash.beans.releaseInfo,com.dash.beans.releaseInfo,com.dash.apputil.queryDB"%>
<title>Set Certified Version</title>

<script>
 $(document).ready(function() {
    $("#select_release").change(function () {
        var x = $(this).val();		
  	  $('#hiddenRelease').val(x);	
  	    }); 

    var table = $('#CertifiedVersionTable').DataTable();  
    
    $('#btn_setCertifiedVersion').click( function() {
        var data = table.$('input, select').serialize();
        var image = "loader/loader1.gif";
        $('#loading').html("<img src='"+image+"' />");
        
   	 $.ajax({
         type:"POST",
         data: { 'data': data, 'action':'setCertifiedVersion' },
         url : '${pageContext.request.contextPath}/SetCertifiedVersion',
         cache: false,
         dataType: "text",
         success: function(data) {
           setTimeout(myTimer, 1500);
           },
         error: function(data) {
        	 $("#result").html('Could NOT update. There was a problem.');
         }
     });    	 

    } );
    
    function myTimer() {
    	$("#loading").html('Updated Successfully');        
    }    
});

function Submit(value)
{    
    document.getElementById("hiddenRelease").value = value;
    document.getElementById("certifiedArtifactForm").submit();
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
            <a href="ArtifactVersion">Dashboard</a>
          </li>
          <li class="breadcrumb-item active">Set Certified Version</li>
        </ol>
        
        
      <div class="card mb-3">
		<div class="card-header">
   		<i class="fa fa-table"></i>
        <b>Set Certified Version</b>
        </div>
        
       <form id="certifiedArtifactForm" autocomplete="off" action="SetCertifiedVersion"  method="POST"> 	
        <div class="card-header">
        
      	
	        <label for="input_release">Select the release:</label> 

		<select id="select_release" name="select_release" onchange="Submit(this.value);">
		<% for (releaseInfo r: queryDB.getReleaseInfo()){
		 String selected = "";
		        if (r.getIsCurrentRelease().equals("Yes")) {
		           selected = "selected"; } %> 
		           
			 <option value="<%=r.getReleaseNumber()%>" <%=selected%>><%=r.getReleaseNumber()%></option>
		
		<% } %> 
		</select>	
	        &#160; &nbsp;&#160; &nbsp;	        	
		   <input type="button" id="btn_setCertifiedVersion" value="SetCertifiedVersion">			
			  &#160; &nbsp;&#160; &nbsp;
			<label id="loading"></label>
        </div>
		<div class="card-body">
		<div class="table-responsive">
       <table id="CertifiedVersionTable" class="table table-bordered" width="100%" cellspacing="0">
		<thead>
           <tr>
               <th><u>Release</u></th>
               <th><u>Component</u></th>
               <th><u>Certified Artifact Version</u></th>    
           </tr>
       </thead>
       <tbody> 
      		<%       		
     		  String releaseSelect =  request.getParameter("select_release");
      		 
      		    if (releaseSelect == "" || releaseSelect == null)
        		{
        			releaseSelect=queryDB.getCurrentRelease();;        	
        		} 
      		    int count=0;
              for (ReleaseArtifactInfo r: queryDB.getArtifactInfoList(releaseSelect)){ %>              
                    <tr>
	                    <td><input type="text" style="border: 0" readonly id="row-release-<%=count%>" name="row-release-<%=count%>" value="<%=r.getRelease()%>"></td>
	                    <td><input type="text" style="border: 0" readonly id="row-component-<%=count%>" name="row-component-<%=count%>" value="<%=r.getComponent()%>"></td>
	                    <td><input type="text" class="certifiedVersionInput" autocomplete="off" style="outline-style: solid;" id="row-stageVersion-<%=count%>" name="row-stageVersion-<%=count%>" value="<%=r.getStageversion()%>"></td>
	                </tr>                	
       		<% count++;} %>
   		</tbody>
</table>
     
   		</div>
</div>        
        <input type="hidden" name="selectedValue" id="hiddenRelease" value=""/>
    </form>
        
        </div>          
 </div> 
 </div>
 
 <script>	
window.onload = function(){  
	    var value =<%=request.getParameter("select_release")%>; 	    
   		if(value !=null)  
	        {
	    	document.getElementById("select_release").value = value;
	    	}
   		
   	
   		//document.getElementById("certifiedArtifactForm").reset();
	} 
</script>
  <%@ include file="footer.html" %> 
  
  </body>
  </html>