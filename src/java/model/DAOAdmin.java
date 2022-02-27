/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import entity.Admin;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author DELL
 */
public class DAOAdmin extends DBConnect {

    public boolean login(String username, String password) {
        String sql = "select * from Admin where username =? and password = ?";
        PreparedStatement pre;
        ResultSet rs = null;
        try {
            pre = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            pre.setString(1, username);
            pre.setString(2, password);
            rs = pre.executeQuery();
            return rs.next();
        } catch (SQLException ex) {
            Logger.getLogger(DAOAdmin.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    public int addAdmin(Admin ad) {
        int n = 0;
        String sql = "insert into admin values('" + ad.getUsername() + "'," + ad.getPassword() + ")";
        try {
            Statement state = conn.createStatement();
            n = state.executeUpdate(sql);

        } catch (SQLException ex) {
            Logger.getLogger(DAOAdmin.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;

    }

    public int UpdateAdmin(Admin ad) {
        int n = 0;
        String sql = "update Admin set password =? where"
                + " adminid=?";
        PreparedStatement pre;

        try {
            pre = conn.prepareStatement(sql);
            pre.setString(1, ad.getPassword());
            pre.setInt(2, ad.getAdminID());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOAdmin.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public int removeAdmin(int adminId) {
        int n = 0;
        //code here
        String sql = " DELETE From admin where adminid = " + adminId;
        try {
            Statement state = conn.createStatement();
            n = state.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(DAOAdmin.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public static void main(String[] args) {
        DAOAdmin dao = new DAOAdmin();
        int n = dao.addAdmin(new Admin("sa", "123456"));
        if (n > 0) {
            System.out.println("inserted");
        }
    }
}
