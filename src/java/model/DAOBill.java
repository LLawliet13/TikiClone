/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import entity.Bill;
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
public class DAOBill extends DBConnect {

    public int addBill(Bill bill) {
        int n = 0;
        String sql = "insert into Bill(oID, cname, cphone, cAddress, total,cid,dateCreate,status ) "
                + "values(?,?,?,?,?,?,?,?)";
        PreparedStatement pre;
        try {
            pre = conn.prepareStatement(sql);
            pre.setString(1, bill.getoID());
            pre.setString(2, bill.getCname());
            pre.setString(3, bill.getCphone());
            pre.setString(4, bill.getcAddress());
            pre.setDouble(5, bill.getTotal());
            pre.setInt(6, bill.getCid());
            pre.setString(7, bill.getDateCreate());
            pre.setInt(8, bill.getStatus());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOBill.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }


    public int updateBill(Bill bill) {
        int n = 0;
        String sql = "update Bill set dateCreate=?,cname=?,cphone=?,cAddress=?,total =?, status=?,cid=? where oID=?";
        PreparedStatement pre;
        try {
            pre = conn.prepareStatement(sql);
            pre.setString(1, bill.getDateCreate());
            pre.setString(2, bill.getCname());
            pre.setString(3, bill.getCphone());
            pre.setString(4, bill.getcAddress());
            pre.setDouble(5, bill.getTotal());
            pre.setInt(6, bill.getStatus());
            pre.setInt(7, bill.getCid());
            pre.setString(8, bill.getoID());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOBill.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }
    public void displayAll() {
        String sql = "select * from bill";
        ResultSet rs = getData(sql);
        try {
            while (rs.next()) {
                int cid = rs.getInt("cid");
                int status = rs.getInt("status");
                String oID = rs.getString("oID");
                String dateCreate = rs.getString("dateCreate");
                String cname = rs.getString("cname");
                String cphone = rs.getString("cphone");
                String cAddress = rs.getString("cAddress");
                Double total = rs.getDouble("total");
                Bill bill = new Bill(oID, cname, cphone, cAddress, total, cid);
                System.out.println(bill);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOBill.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void changeStatus(String oid, int status) {
        //code here
        String sql = "update bill set status =" + status + "where oid= '" + oid+"'";
        PreparedStatement pre;
        try {
            //Statemetn
            Statement state = conn.createStatement();
            state.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(DAOBill.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int removeBill(String oid) {
        int n = 0;
        //code here
        String checkMsg = "select * from Billdetail where oid = '" + oid + "'";
        ResultSet bills = getData(checkMsg);
        try {
            if (bills.next()) {
                changeStatus(oid, 0);
                n = 1;
            } else {
                String sql = " DELETE From Bill where oid ='" + oid + "'";
                try {
                    Statement state = conn.createStatement();
                    n = state.executeUpdate(sql);
                } catch (SQLException ex) {
                    Logger.getLogger(DAOBill.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOBill.class.getName()).log(Level.SEVERE, null, ex);
        }

        return n;
    }


}
