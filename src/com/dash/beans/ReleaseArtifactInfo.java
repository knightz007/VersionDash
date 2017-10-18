package com.dash.beans;

public class ReleaseArtifactInfo {
	
   public ReleaseArtifactInfo(String release, String component, String certified_artifactVersion, String current_artifactVersion,
		   String qaComponentInSync, String stageComponentInSync, String perfComponentInSync,
		   String prodComponentInSync)
   {    	
       this.release = release;
       this.component = component;
       this.certified_artifactVersion = certified_artifactVersion;
       this.current_artifactVersion = current_artifactVersion;
       this.qaComponentInSync = qaComponentInSync;
      this.stageComponentInSync = stageComponentInSync;
      this.perfComponentInSync = perfComponentInSync;
      this.prodComponentInSync = prodComponentInSync;	 

   }
    
    private String release;
    private String component;	
    private String certified_artifactVersion;
    private String current_artifactVersion;
    private String qa_artifactVersion;
    private String stage_artifactVersion;
    private String prod_artifactVersion;
    private String qaComponentInSync;
    private String stageComponentInSync;
    private String perfComponentInSync;
    private String prodComponentInSync;
    
	
	public ReleaseArtifactInfo() {
	}
	
	public String getRelease() {
		return release;
	}
	public void setRelease(String release) {
		this.release = release;
	}
	
	public String getComponent() {
		return component;
	}
	public void setComponent(String component) {
		this.component = component;
	}
	public String getCertifiedArtifactVersion() {
		return certified_artifactVersion;
	}
	public void setCertifiedArtifactVersion(String certified_artifactVersion) {
		this.certified_artifactVersion = certified_artifactVersion;
	}
	public String getCurrentArtifactVersion() {
		return current_artifactVersion;
	}
	public void setCurrentArtifactVersion(String current_artifactVersion) {
		this.current_artifactVersion = current_artifactVersion;
	}
	public String getQAversion() {
		return qa_artifactVersion;
	}
	public void setQAVersion(String qa_artifactVersion) {
		this.qa_artifactVersion = qa_artifactVersion;
	}
	public String getStageversion() {
		return stage_artifactVersion;
	}
	public void setStageVersion(String stage_artifactVersion) {
		this.stage_artifactVersion = stage_artifactVersion;
	}
	public String getProdversion() {
		return prod_artifactVersion;
	}
	public void setProdVersion(String prod_artifactVersion) {
		this.prod_artifactVersion = prod_artifactVersion;
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
