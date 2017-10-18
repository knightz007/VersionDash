package com.dash.beans;

public class ServerInfo {
	
    public ServerInfo(String hostname,String environment, String componentsVersion)
    {      
        this.hostname = hostname;
        this.environment = environment;
        this.componentsVersion = componentsVersion;      
    }
	
	
	private String hostname;
	private String environment;
	private String componentsVersion;
	public ServerInfo() {
	}
	public String getHostname() {
		return hostname;
	}
	public void setHostname(String hostname) {
		this.hostname = hostname;
	}

	public String getEnvironment() {
		return environment;
	}
	public void setEnvironment(String environment) {
		this.environment = environment;
	}
	
	public String getComponent_version() {
		return componentsVersion;
	}
	public void setComponent_version(String componentsVersion) {
		this.componentsVersion = componentsVersion;
	}

}
