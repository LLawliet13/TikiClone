/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import entity.Cart;
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
public class DAOCart extends DBConnect {

    public int addCart(Cart cart) {
        int n = 0;
        String sql = "insert into Cart(cid, pid, quantity,status) "
                + "values(?,?,?,?)";
        PreparedStatement pre;
        try {
            pre = conn.prepareStatement(sql);

            pre.setInt(1, cart.getCid());
            pre.setString(2, cart.getPid());
            pre.setInt(3, cart.getQuantity());
            pre.setInt(4, cart.getStatus());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOCart.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public int updateCart(Cart cart) {
        int n = 0;
        String sql = "update Cart set quantity=?,status=? where cid=? and pid ='"+cart.getPid()+"'";
        PreparedStatement pre;
        try {
            pre = conn.prepareStatement(sql);
           
            pre.setInt(1, cart.getQuantity());
            pre.setInt(2, cart.getStatus());
            pre.setInt(3, cart.getCid());

            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOCart.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }



    public int removeCart(int cid,String pid) {
        int n = 0;
        //code here

        String sql = " DELETE From Cart where cid =" + cid + " and pid ='"+pid+"'";
        try {
            Statement state = conn.createStatement();
            n = state.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(DAOCart.class.getName()).log(Level.SEVERE, null, ex);
        }

        return n;
    }



}
