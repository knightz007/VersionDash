package com.dash.beans;

public class ComponentInfo {
	
	 public ComponentInfo(String component, String current_artifact_location, String component_server_location,
	 String component_current_version, String component_qa_version, String component_stage_version, String component_perf_version,
	  String component_prod_version, String qaComponentInSync, String stageComponentInSync, String perfComponentInSync,
	   String prodComponentInSync)
	   {    		    
	       this.component = component;
	       this.current_artifact_location = current_artifact_location;
	       this.component_server_location = component_server_location;
	       this.component_current_version = component_current_version;	       
	       this.component_qa_version = component_qa_version;
	       this.component_stage_version = component_stage_version;
	       this.component_perf_version = component_perf_version;
	       this.component_prod_version = component_prod_version;
	       this.qaComponentInSync = qaComponentInSync;
	       this.stageComponentInSync = stageComponentInSync;
	       this.perfComponentInSync = perfComponentInSync;
	       this.prodComponentInSync = prodComponentInSync;	       
	    
	   }
	   
	    private String component;	
	    private String current_artifact_location;
	    private String component_server_location;
	    private String component_current_version;
	    private String component_qa_version;
	    private String component_stage_version;
	    private String component_perf_version;
	    private String component_prod_version;
	    private String qaComponentInSync;
	    private String stageComponentInSync;
	    private String perfComponentInSync;
	    private String prodComponentInSync;
		
		public ComponentInfo() {
		}
		

		
		public String getComponent() {
			return component;
		}
		public void setComponent(String component) {
			this.component = component;
		}
		public String getCurrent_artifact_location() {
			return current_artifact_location;
		}
		public void setCurrent_artifact_location(String current_artifact_location) {
			this.current_artifact_location = current_artifact_location;
		}
		
		public String getcomponent_server_location() {
			return component_server_location;
		}
		public void setcomponent_server_location(String component_server_location) {
			this.component_server_location = component_server_location;
		}
		public String getcomponent_current_version() {
			return component_current_version;
		}
		public void setcomponent_current_version(String component_current_version) {
			this.component_current_version = component_current_version;
		}
		public String getcomponent_qa_version() {
			return component_qa_version;
		}
		public void setcomponent_qa_version(String component_qa_version) {
			this.component_qa_version = component_qa_version;
		}
		public String getcomponent_stage_version() {
			return component_stage_version;
		}
		public void setcomponent_stage_version(String component_stage_version) {
			this.component_stage_version = component_stage_version;
		}
		public String getcomponent_perf_version() {
			return component_perf_version;
		}
		public void setcomponent_perf_version(String component_perf_version) {
			this.component_perf_version = component_perf_version;
		}
		public String getcomponent_prod_version() {
			return component_prod_version;
		}
		public void setcomponent_prod_version(String component_prod_version) {
			this.component_prod_version = component_prod_version;
		}
		public String getqaComponentInSync() {
			return qaComponentInSync;
		}
		public void setqaComponentInSync(String qaComponentInSync) {
			this.qaComponentInSync = qaComponentInSync;
		}
		public String getstageComponentInSync() {
			return stageComponentInSync;
		}
		public void setstageComponentInSync(String stageComponentInSync) {
			this.stageComponentInSync = stageComponentInSync;
		}
		public String getperfComponentInSync() {
			return perfComponentInSync;
		}
		public void setperfComponentInSync(String perfComponentInSync) {
			this.perfComponentInSync = perfComponentInSync;
		}
		public String getprodComponentInSync() {
			return prodComponentInSync;
		}
		public void setprodComponentInSync(String prodComponentInSync) {
			this.prodComponentInSync = prodComponentInSync;
		}
}
