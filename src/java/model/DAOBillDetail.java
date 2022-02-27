/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import entity.BillDetail;
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
public class DAOBillDetail extends DBConnect {

    public int addBillDetail(BillDetail billD) {
        int n = 0;
        String sql = "insert into BillDetail(pid, oid, price, quantity, total ) "
                + "values(?,?,?,?,?)";
        PreparedStatement pre;
        try {
            pre = conn.prepareStatement(sql);
            pre.setString(1, billD.getPid());
            pre.setString(2, billD.getoID());
            pre.setDouble(3, billD.getPrice());
            pre.setInt(4, billD.getQuantity());
            pre.setDouble(5, billD.getTotal());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOBillDetail.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }
    public int updateBillDetail(BillDetail billD) {
        int n = 0;
        String sql = "update BillDetail set  price =?, quantity =? , total=? where oID=? and pid=?";
        PreparedStatement pre;
        try {
            pre = conn.prepareStatement(sql);

            pre.setDouble(1, billD.getPrice());
            pre.setInt(2, billD.getQuantity());
            pre.setDouble(3, billD.getTotal());
            pre.setString(5, billD.getPid());
            pre.setString(4, billD.getoID());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOBillDetail.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;

    }
    public void displayAll() {
        String sql = "select * from BillDetail";
        ResultSet rs = getData(sql);
        try {
            while (rs.next()) {
                int quantity = rs.getInt("quantity");
                int price = rs.getInt("price");
                int total = rs.getInt("total");
                String pid = rs.getString("pid");
                String oID = rs.getString("oID");
                BillDetail billd = new BillDetail(pid, oID, quantity, price, total);
                System.out.println(billd);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOBillDetail.class.getName()).log(Level.SEVERE, null, ex);
        }
    }


    public int removeBillDetail(String oid, String pid) {
        int n = 0;
        //code here
        String sql = " DELETE From BillDetail where oid = '"+ oid + "'" + " and pid = '" + pid + "'";
        try {
            Statement state = conn.createStatement();
            n = state.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(DAOBillDetail.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }
}
