/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import entity.Category;
import java.sql.Connection;
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
public class DAOCategory extends DBConnect {
//    DBConnect dbconn;
//    Connection conn;
//    public DAOCategory(DBConnect dbconn, Connection conn){
//        this.dbconn = dbconn;
//        this.conn = conn;
//    }

    public int addCategory(Category cate) {
        int n = 0;
        String sql = "insert into Category values('" + cate.getCateName() + "'," + cate.getStatus() + ")";
        try {
            Statement state = conn.createStatement();
            n = state.executeUpdate(sql);

        } catch (SQLException ex) {
            Logger.getLogger(DAOCategory.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;

    }

    public int UpdateCategory(Category cate) {
        int n = 0;
        String sql = "update Category set catename = '" + cate.getCateName() + "'," + "status = " + cate.getStatus() + "where cateID = " + cate.getCateID();
        try {
            Statement state = conn.createStatement();
            n = state.executeUpdate(sql);

        } catch (SQLException ex) {
            Logger.getLogger(DAOCategory.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;

    }

    public void displayAll() {
        String sql = "select * from Category";
        ResultSet rs = getData(sql);
        try {
            while (rs.next()) {
                int cid = rs.getInt("cid");
                int status = rs.getInt("status");
                String cateName = rs.getString("cateName");
                Category cus = new Category(cid, cateName, status);
                System.out.println(cus);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOCategory.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void changeStatus(int cateid, int status) {
        //code here
        String sql = "update Category set status =" + status + "where cateid=" + cateid;
        PreparedStatement pre;
        try {
            //Statemetn
            Statement state = conn.createStatement();
            state.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(DAOCategory.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int removeCategory(int cateId) {
        int n = 0;
        //code here
        String checkMsg = "select * from product where cateid = " + cateId;
        ResultSet pros = getData(checkMsg);
        try {
            if (pros.next()) {
                changeStatus(cateId, 0);
            } else {
                String sql = " DELETE From category where cateId =" + cateId;
                try {
                    Statement state = conn.createStatement();
                    n = state.executeUpdate(sql);
                } catch (SQLException ex) {
                    Logger.getLogger(DAOCategory.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOCategory.class.getName()).log(Level.SEVERE, null, ex);
        }

        return n;
    }

    public static void main(String[] args) {
        DAOCategory dao = new DAOCategory();
        int n = dao.addCategory(new Category(1, "Sam Sung", 1));
        if (n > 0) {
            System.out.println("inserted");
        }
    }
}
