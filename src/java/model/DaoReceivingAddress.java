/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import entity.ReceivingAddress;
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
public class DaoReceivingAddress extends DBConnect {

    public int addReceivingAddress(ReceivingAddress ra) {
        int n = 0;
        int index = 1;
        try {
            ResultSet indexs = conn.createStatement().executeQuery("select * from ReceivingAddress where cid ="+ ra.getCid());
            while(indexs.next()){
                index++;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoReceivingAddress.class.getName()).log(Level.SEVERE, null, ex);
        }
        String sql = "insert into ReceivingAddress( cname, cphone, username, index,inuse,cid ) "
                + "values(?,?,?,?,?,?)";
        PreparedStatement pre;
        try {
            pre = conn.prepareStatement(sql);
            pre.setString(1, ra.getCname());
            pre.setString(2, ra.getCphone());
            pre.setString(3, ra.getCaddress());
            pre.setInt(4, index);
            pre.setInt(5, ra.getInuse());
            pre.setInt(6, ra.getCid());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DaoReceivingAddress.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public int updateCustomer(ReceivingAddress ra) {
        int n = 0;
        String sql = "update ReceivingAddress set cname=?,cphone=?, cAddress=?, inuse=? where index=? and cID=?";
        PreparedStatement pre;
        try {
            pre = conn.prepareStatement(sql);
            pre.setString(1, ra.getCname());
            pre.setString(2, ra.getCphone());
            pre.setString(3, ra.getCaddress());
            pre.setInt(5, ra.getIndex());
            pre.setInt(4, ra.getInuse());
            pre.setInt(6, ra.getCid());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DaoReceivingAddress.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }




//    public int removeReceivingAddress(int cid) {
//        int n = 0;
//        //code here
//       
//        try {
//            if () {
//                changeStatus(cid, 0);
//            } else {
//                String sql = " DELETE From ReceivingAddress where cid =" + cid;
//                try {
//                    Statement state = conn.createStatement();
//                    n = state.executeUpdate(sql);
//                } catch (SQLException ex) {
//                    Logger.getLogger(DaoReceivingAddress.class.getName()).log(Level.SEVERE, null, ex);
//                }
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(DaoReceivingAddress.class.getName()).log(Level.SEVERE, null, ex);
//        }
//
//        return n;
//    }
}
