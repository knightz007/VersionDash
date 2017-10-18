package com.dash.beans;

public class ArtifactInfo {
	
    public ArtifactInfo(String environment, String app, String component, String current_artifactVersion, 
    		 String release, String certified_artifactVersion, String qaComponentInSync, String stageComponentInSync, String perfComponentInSync,
    		   String prodComponentInSync)
    {    	
        this.environment = environment;
        this.app = app;
        this.component = component;
        this.current_artifactVersion = current_artifactVersion;
        this.release = release; 
        this.certified_artifactVersion = certified_artifactVersion;
        this.qaComponentInSync = qaComponentInSync;
       this.stageComponentInSync = stageComponentInSync;
       this.perfComponentInSync = perfComponentInSync;
       this.prodComponentInSync = prodComponentInSync;	 
        
    }
    
    private String environment;
    private String app;	
	private String component;	
    private String current_artifactVersion;
    private String release;	
	private String certified_artifactVersion;
    private String qaComponentInSync;
    private String stageComponentInSync;
    private String perfComponentInSync;
    private String prodComponentInSync;
	
	public ArtifactInfo() {
	}
	
	public String getEnvironment() {
		return environment;
	}
	public void setEnvironment(String environment) {
		this.environment = environment;
	}

	public String getApp() {
		return app;
	}
	public void setApp(String app) {
		this.app = app;
	}
	
	public String getcomponent() {
		return component;
	}
	public void setcomponent(String component) {
		this.component = component;
	}
	public String getCurrentArtifactVersion() {
		return current_artifactVersion;
	}
	public void setCurrentArtifactVersion(String current_artifactVersion) {
		this.component = current_artifactVersion;
	}
	public String getRelease() {
		return release;
	}
	public void setRelease(String release) {
		this.release = release;
	}
	public String getCertifiedArtifactVersion() {
		return certified_artifactVersion;
	}
	public void setCertifiedArtifactVersion(String certified_artifactVersion) {
		this.certified_artifactVersion = certified_artifactVersion;
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
