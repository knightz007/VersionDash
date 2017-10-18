package com.dash.beans;

public class releaseInfo {

	public releaseInfo(String release_numer, String IsCurrentRelease)
	{
		 this.release_numer = release_numer;
	     this.IsCurrentRelease = IsCurrentRelease;
	}
	
	public releaseInfo() {
	}
	
	private String release_numer;	
    private String IsCurrentRelease;
    
    public String getReleaseNumber() {
		return release_numer;
	}
	public void setReleaseNumber(String release_numer) {
		this.release_numer = release_numer;
	}
	public String getIsCurrentRelease() {
		return IsCurrentRelease;
	}
	public void setIsCurrentRelease(String IsCurrentRelease) {
		this.IsCurrentRelease = IsCurrentRelease;
	}
}
