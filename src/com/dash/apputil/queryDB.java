package com.dash.apputil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import com.dash.beans.ComponentInfo;
import com.dash.beans.ReleaseArtifactInfo;
import com.dash.beans.ServerInfo;
import com.dash.beans.releaseInfo;
import com.dash.dbutil.DbConnector;


public class queryDB {
	
	 private static List<ServerInfo> serverList = null;
	 private static List<ReleaseArtifactInfo> releaseArtifactList = null;
	 private static List<ComponentInfo> componentInfoList = null;
	 private static List<releaseInfo> releaseInfoList = null;
	
	public static String findServer(Connection conn, String hostName) throws SQLException {
		 
	      String sql = "Select a.hostname, a.environment from serverlist a "
	              + " where a.hostname = ?";
	 
	      PreparedStatement pstm = conn.prepareStatement(sql);
	      pstm.setString(1, hostName);
	      ResultSet rs = pstm.executeQuery();
	      
	      String environment = "";
	      if (rs.next()) {
	           environment = rs.getString("environment");
	      }
	      return environment;
	  }
	
	public static List<ServerInfo> getServerList() throws SQLException {
		 
		 Connection conn;
			try {
			conn = DbConnector.getConnection();
		
	      String sql = "Select * from serverlist";	             
	 
	      PreparedStatement pstm = conn.prepareStatement(sql);
	      ResultSet rs = pstm.executeQuery();
	      	      
	      //List<ServerInfo> serverList = new ArrayList<ServerInfo>();
	      serverList = new LinkedList<ServerInfo>();
	      
	      while(rs.next()) {
	    	  ServerInfo srvInfo = new ServerInfo();
	    	  srvInfo.setHostname(rs.getString("hostname"));
	          srvInfo.setEnvironment(rs.getString("environment"));
	          serverList.add(srvInfo);
	      }
	      
	  
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    return serverList;
	  }
	
	public static List<ServerInfo> getServerList(String env, String component) throws SQLException {
		 
		 Connection conn;
			try {
			conn = DbConnector.getConnection();
		
			String sql = "";
			PreparedStatement pstm = null;
	      //String sql = "SELECT * FROM testdb.serverlist where components_version like %" + component + "% and environment=" + env ;	             
	      if((env != null || env != "") && (component != null || component != ""))
	      {
	      sql = "SELECT * FROM testdb.serverlist WHERE components_version LIKE ? and environment=?";
	      pstm = conn.prepareStatement(sql);
	      pstm.setString(1, "%" + component + "%");
	      pstm.setString(2,  env);
	      }
	      else if(env != null || env != "")
	      {
	    	  sql = "SELECT * FROM testdb.serverlist WHERE environment=?";
	    	  pstm = conn.prepareStatement(sql);
	    	  pstm.setString(1,  env);
	      }
	    	  
	      ResultSet rs = pstm.executeQuery();
	      	      
	      serverList = new LinkedList<ServerInfo>();
	      
	      while(rs.next()) {
	    	  ServerInfo srvInfo = new ServerInfo();
	    	  srvInfo.setHostname(rs.getString("hostname"));
	          srvInfo.setEnvironment(rs.getString("environment"));
	          srvInfo.setComponent_version(rs.getString("components_version"));
	          serverList.add(srvInfo);
	      }
	      
	  
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    return serverList;
	  }
	
	
	public static void InsertServerInfo(Connection conn, List<ServerInfo> serverInfo) throws SQLException 
	{		
		  List<ServerInfo> serverList = serverInfo;
		  
		  String sql = "";
	      for (ServerInfo server : serverList) 
	      {
	    	 /* sql = "Insert into serverlist (hostname, environment, server_function) values(" 
	    			  + server.getHostname() + "," + server.getEnvironment() + "," +
	    			  server.getServerFunction() + ";"; */
	    	  sql = "Insert into serverlist (hostname, environment, server_function) values(?,?,?)";
	    	  PreparedStatement pstm = conn.prepareStatement(sql);
	    	  
	          pstm.setString(1, server.getHostname());
	          pstm.setString(2, server.getEnvironment());
	          pstm.setString(3, server.getComponent_version());
	     
	          pstm.executeUpdate();
	      }
	  }
	
	public static List<ReleaseArtifactInfo> getReleaseArtifactInfoList() throws SQLException {
		 
		 Connection conn;
			try {
			conn = DbConnector.getConnection();
		
	      String sql = "Select * from releaseartifactinfo";	             
	 
	      PreparedStatement pstm = conn.prepareStatement(sql);
	      ResultSet rs = pstm.executeQuery();
	      	      
	      //List<ServerInfo> serverList = new ArrayList<ServerInfo>();
	      releaseArtifactList = new LinkedList<ReleaseArtifactInfo>();
	      
	      while(rs.next()) {
	    	  ReleaseArtifactInfo rartifactInfo = new ReleaseArtifactInfo();
	    	  rartifactInfo.setRelease(rs.getString("release_number"));
	    	  rartifactInfo.setComponent(rs.getString("component"));
	    	  rartifactInfo.setCertifiedArtifactVersion(rs.getString("certifiedartifactversion"));
	    	  releaseArtifactList.add(rartifactInfo);
	      }
	      
	  
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    return releaseArtifactList;
	  }
	public static List<ReleaseArtifactInfo> getReleaseArtifactInfoList(String release) throws SQLException {
		 
		 Connection conn;
			try {
			conn = DbConnector.getConnection();
			
			
	      String sql = "Select * from releaseartifactinfo where release_number=" + release;	             
	 
	      PreparedStatement pstm = conn.prepareStatement(sql);
	      ResultSet rs = pstm.executeQuery();
	      	      
	      //List<ServerInfo> serverList = new ArrayList<ServerInfo>();
	      releaseArtifactList = new LinkedList<ReleaseArtifactInfo>();
	      
	      while(rs.next()) {
	    	  ReleaseArtifactInfo rartifactInfo = new ReleaseArtifactInfo();
	    	  rartifactInfo.setRelease(rs.getString("release_number"));
	    	  rartifactInfo.setComponent(rs.getString("component"));
	    	  rartifactInfo.setCertifiedArtifactVersion(rs.getString("certifiedartifactversion"));
	    	  rartifactInfo.setQAVersion(rs.getString("qa_env_version"));
	    	  rartifactInfo.setStageVersion(rs.getString("stage_env_version"));
	    	  rartifactInfo.setProdVersion(rs.getString("prod_env_version"));
	    	  releaseArtifactList.add(rartifactInfo);
	      }
	      
	  
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    return releaseArtifactList;
	  }
	
	public static List<ReleaseArtifactInfo> getArtifactInfoList(String release) throws SQLException {
		 
		 Connection conn;
			try {
			conn = DbConnector.getConnection();
			
			/*String sql=  "SELECT S.currentrelease_number, S.component, S.currentartifactversion as current_artifactversion, " 
					+ "C.certifiedartifactversion as certified_artifactVersion "
					+ "FROM releaseartifactinfo C RIGHT JOIN currentartifactinfo S " 
			        + "ON C.release_component= S.current_component where currentrelease_number=" + release; */
		
	      String sql = "Select * from testdb.releaseartifactinfo where release_number=" + release;	             
	 
	      PreparedStatement pstm = conn.prepareStatement(sql);
	      ResultSet rs = pstm.executeQuery();
	      	      
	      releaseArtifactList = new LinkedList<ReleaseArtifactInfo>();
	      
	      while(rs.next()) {
	    	  ReleaseArtifactInfo rartifactInfo = new ReleaseArtifactInfo();
	    	  rartifactInfo.setRelease(rs.getString("release_number"));
	    	  rartifactInfo.setComponent(rs.getString("component"));
	    	  String cert_version="Not Set";
	    	  if(rs.getObject("certifiedartifactversion") == null) {
	    		  cert_version = "Not available";
	    		}else{
	    		    cert_version =  rs.getString("certifiedartifactversion");
	    		}
	    	  rartifactInfo.setCertifiedArtifactVersion(cert_version);
	    	  rartifactInfo.setCurrentArtifactVersion(rs.getString("currentartifactversion"));
	    	  rartifactInfo.setQAVersion(rs.getString("qa_env_version"));
	    	  rartifactInfo.setStageVersion(rs.getString("stage_env_version"));
	    	  rartifactInfo.setProdVersion(rs.getString("prod_env_version"));
	    	  rartifactInfo.setprodComponentInSync(rs.getString("ProdComponentsInSync"));
	    	  rartifactInfo.setqaComponentInSync(rs.getString("QaComponentsInSync"));
	    	  rartifactInfo.setstageComponentInSync(rs.getString("stageComponentsInSync"));
	    	  releaseArtifactList.add(rartifactInfo);
	      }
	      
	  
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    return releaseArtifactList;
	  }
	
	public static List<ComponentInfo> getComponentSyncInfo() throws SQLException {
		 
		 Connection conn;
			try {
			conn = DbConnector.getConnection();
					
	      String sql = "select component, ProdComponentsInSync, QaComponentsInSync,stageComponentsInSync from testdb.componentlist";            
	 
	      PreparedStatement pstm = conn.prepareStatement(sql);
	      ResultSet rs = pstm.executeQuery();
	      	      
	      componentInfoList = new LinkedList<ComponentInfo>();
	      
	      while(rs.next()) {
	    	  ComponentInfo componenttInfo = new ComponentInfo();
	    	  componenttInfo.setComponent(rs.getString("component"));
	    	  componenttInfo.setprodComponentInSync(rs.getString("ProdComponentsInSync"));
	    	  componenttInfo.setqaComponentInSync(rs.getString("QaComponentsInSync"));
	    	  componenttInfo.setstageComponentInSync(rs.getString("stageComponentsInSync"));
	    	  componentInfoList.add(componenttInfo);
	      }
	      
	  
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    return componentInfoList;
	  }
	
	public static List<releaseInfo> getReleaseInfo() throws SQLException {
		 
		 Connection conn;
			try {
			conn = DbConnector.getConnection();
					
	      String sql = "select release_number, IsCurrentRelease from testdb.releaselist";            
	 
	      PreparedStatement pstm = conn.prepareStatement(sql);
	      ResultSet rs = pstm.executeQuery();
	      	      
	      releaseInfoList = new LinkedList<releaseInfo>();
	      
	      while(rs.next()) {
	    	  releaseInfo releaseInfo = new releaseInfo();
	    	  releaseInfo.setReleaseNumber(rs.getString("release_number"));
	    	  releaseInfo.setIsCurrentRelease(rs.getString("IsCurrentRelease"));	    	  
	    	  releaseInfoList.add(releaseInfo);
	      }
	      
	  
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    return releaseInfoList;
	  }


}
