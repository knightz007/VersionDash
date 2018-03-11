package com.dash.dbutil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.dash.beans.UserAccount;


public class DBUtils {
	
    public static UserAccount findUserByEmail(Connection conn, //
            String Email, String password) throws SQLException {
 
        String sql = "Select a.User_Name, a.Password, a.Email from user_account a " //
                + " where a.Email= ? and a.password= ?";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
        pstm.setString(1, Email);
        pstm.setString(2, password);
        ResultSet rs = pstm.executeQuery();
 
        if (rs.next()) {
            String userName = rs.getString("User_Name");
            UserAccount user = new UserAccount();
            user.setUserName(userName);
            user.setPassword(password);
            user.setEmail(Email);
            return user;
        }
        return null;
    }
    
    public static UserAccount findUser(Connection conn, //
            String userName, String password) throws SQLException {
 
        String sql = "Select a.User_Name, a.Password, a.Email from user_account a " //
                + " where a.User_Name = ? and a.password= ?";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
        pstm.setString(1, userName);
        pstm.setString(2, password);
        ResultSet rs = pstm.executeQuery();
 
        if (rs.next()) {
            String email = rs.getString("Email");
            UserAccount user = new UserAccount();
            user.setUserName(userName);
            user.setPassword(password);
            user.setEmail(email);
            return user;
        }
        return null;
    }
    
    public static UserAccount findUser(Connection conn, String userName) throws SQLException {
    	 
        String sql = "Select a.User_Name, a.Password, a.Email from user_account a "//
                + " where a.User_Name = ? ";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
        pstm.setString(1, userName);
 
        ResultSet rs = pstm.executeQuery();
 
        if (rs.next()) {
            String password = rs.getString("Password");
            String email = rs.getString("Email");
            UserAccount user = new UserAccount();
            user.setUserName(userName);
            user.setPassword(password);
            user.setEmail(email);
            return user;
        }
        return null;
    }
    
    
    

}
