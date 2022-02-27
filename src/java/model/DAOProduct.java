/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import entity.Product;
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
public class DAOProduct extends DBConnect {
//    DBConnect dbConn;
//    Connection connect;
//
//    public DAOProduct(DBConnect dbconn) {
//        this.dbConn=dbconn;
//        connect=dbconn.conn;
//    }
//    DAO: insert, update,delete,search(select)

    public int insertProduct(Product pro) {
        int n = 0;
        String sql = "insert into Product(pid,pname,quantity,price,image,description,status,cateID) "
                + "values('" + pro.getPid() + "','" + pro.getPname() + "'," + pro.getQuantity()
                + "," + pro.getPrice() + ",'" + pro.getImage() + "','" + pro.getDescription() + "'," + pro.getStatus() + ","
                + pro.getCateID() + ")";
        // System.out.println(sql);
        try {
            //Statemetn
            Statement state = conn.createStatement();
            n = state.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(DAOProduct.class.getName()).log(Level.SEVERE, null, ex);
        }

        return n;
    }

    public int addProduct(Product pro) {
        int n = 0;
        String sql = "insert into Product(pid,pname,quantity,price,image,description,status,cateID) "
                + "values(?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
//            set parameter ?
//            pre.setDataType(index,value);
//            DataType is datatype of field (attribute of table)
//            index of position of ? start 1
//            value is value parameter (pro)
            pre.setString(1, pro.getPid());
            pre.setString(2, pro.getPname());
            pre.setInt(3, pro.getQuantity());
            pre.setDouble(4, pro.getPrice());
            pre.setString(5, pro.getImage());
            pre.setString(6, pro.getDescription());
            pre.setInt(7, pro.getStatus());
            pre.setInt(8, pro.getCateID());
            System.out.println(pro.toString());
            n = pre.executeUpdate();
            
        } catch (SQLException ex) {
            Logger.getLogger(DAOProduct.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public int updateProduct(Product pro) {
        int n = 0;
        String sql = "update Product set pname=?,quantity=?,price=?,image=?,description=?,"
                + "status=?,cateID=? where pid=?";
        //code here
        PreparedStatement pre;
        try {
            pre = conn.prepareStatement(sql);
            pre.setString(8, pro.getPid());
            pre.setString(1, pro.getPname());
            pre.setInt(2, pro.getQuantity());
            pre.setDouble(3, pro.getPrice());
            pre.setString(4, pro.getImage());
            pre.setString(5, pro.getDescription());
            pre.setInt(6, pro.getStatus());
            pre.setInt(7, pro.getCateID());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOProduct.class.getName()).log(Level.SEVERE, null, ex);
        }

        return n;
    }

    public void updateQuantity(String id, int quan) {
        //code here
        String sql = "update Product "
                + "set quantity=quantity+? where pid=?";
        PreparedStatement pre;
        try {
            //Statemetn
            pre = conn.prepareStatement(sql);
            pre.setInt(1, quan);
            pre.setString(2, id);
            pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOProduct.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void changeStatus(String id, int status) {
        //code here
        String sql = "update Product set status =" + status + "where pid=" + "'" + id + "'";
        PreparedStatement pre;
        try {
            //Statemetn
            Statement state = conn.createStatement();
            state.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(DAOProduct.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int removeProduct(String id) {
        int n = 0;
        //code here
        String checkMsg = "select * from billDetail where pid='" + id + "'";
        ResultSet bill = getData(checkMsg);
        try {
            if (bill.next()) {
                changeStatus(id, 0);
            } else {
                String sql = " DELETE From Product where pid ='" + id + "'";
                try {
                    Statement state = conn.createStatement();
                    n = state.executeUpdate(sql);
                } catch (SQLException ex) {
                    Logger.getLogger(DAOProduct.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOProduct.class.getName()).log(Level.SEVERE, null, ex);
        }

        return n;
    }

    public void displayAll() {
        String sql = "Select * from product";
        try {
            Statement state = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                String pid = rs.getString("pid");
                String pname = rs.getString("pname");
                String discription = rs.getString("description");
                String image = rs.getString("image");
                int cateId = rs.getInt("cateid");
                int quantity = rs.getInt("quantity");
                double price = rs.getDouble("price");
                int status = rs.getInt("status");
                Product pro = new Product(pid, pname, image, discription, cateId, quantity, price, status);
                System.out.println(pro);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOProduct.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public static void main(String[] args) {
        DAOProduct dao = new DAOProduct();
//        int n=dao.insertProduct(new Product("P02","HP G6",2, 500,"no image","second hand",1,1));
//        if(n>0)
//            System.out.println("inserted");
        int n = dao.addProduct(new Product("P04", "HP G7", "image", " secondhand", 1, 1, 1, 1));
        if (n > 0) {
            System.out.println("inserted");
        }
    }

}
