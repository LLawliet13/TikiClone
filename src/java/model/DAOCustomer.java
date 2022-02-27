/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import entity.Customer;
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
public class DAOCustomer extends DBConnect {

    public int addCustomer(Customer cus) {
        int n = 0;
        String sql = "insert into Customer( cname, cphone, username, password,caddress,status ) "
                + "values(?,?,?,?,?,?)";
        PreparedStatement pre;
        try {
            pre = conn.prepareStatement(sql);
            pre.setString(1, cus.getCname());
            pre.setString(2, cus.getCphone());
            pre.setString(3, cus.getUsername());
            pre.setString(4, cus.getPassword());
            pre.setString(5, cus.getcAddress());
            pre.setInt(6, cus.getStatus());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOCustomer.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public int updateCustomer(Customer cus) {
        int n = 0;
        String sql = "update Customer set cname=?,cphone=?,username = ? , password = ? , cAddress=?, status=? ,csex = ? , cemail=? ,cdob=? where cID=?";
        PreparedStatement pre;
        try {
            pre = conn.prepareStatement(sql);
            pre.setString(1, cus.getCname());
            pre.setString(2, cus.getCphone());
            pre.setString(3, cus.getUsername());
            pre.setString(4, cus.getPassword());
            pre.setString(5, cus.getcAddress());
            pre.setInt(6, cus.getStatus());
            pre.setInt(7, cus.getCsex());
            pre.setString(8, cus.getCemail());
            pre.setString(9, cus.getCdob());
            pre.setInt(10, cus.getCid());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOCustomer.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public void changeStatus(int cid, int status) {
        //code here
        String sql = "update Customer set status =" + status + "where cid=" + cid;
        PreparedStatement pre;
        try {
            //Statemetn
            Statement state = conn.createStatement();
            state.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(DAOCustomer.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int removeCustomer(int cid) {
        int n = 0;
        //code here
        String checkMsg = "select * from bill where cid= " + cid;
        ResultSet bills = getData(checkMsg);
        try {
            if (bills.next()) {
                changeStatus(cid, 0);
            } else {
                String sql = " DELETE From Customer where cid =" + cid;
                try {
                    Statement state = conn.createStatement();
                    n = state.executeUpdate(sql);
                } catch (SQLException ex) {
                    Logger.getLogger(DAOCustomer.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOCustomer.class.getName()).log(Level.SEVERE, null, ex);
        }

        return n;
    }

}
