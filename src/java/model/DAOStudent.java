/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import entity.Student;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author DELL
 */
public class DAOStudent extends DBConnect {

    public int insert(Student student) {
        int n = 0;
        String sql = "insert into student(stuid,name,birthday,deleted,classid) values(?,?,?,?,?) ";
        PreparedStatement pre ;
        try {
            pre = conn.prepareStatement(sql);
            pre.setString(1, student.getStuId());
            pre.setString(2, student.getName());
            pre.setString(3, student.getBirthday());
            pre.setInt(4, student.getDeleted());
            pre.setInt(5, student.getClassId());
            n = pre.executeUpdate();
        } catch (SQLException ex) {

            Logger.getLogger(DAOStudent.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public int update(Student student) {
        int n = 0;
        String sql = "update  student set name=?,birthday=?,deleted=?,classid=? where stuid =?";
        PreparedStatement pre = null;
        try {
            pre = conn.prepareStatement(sql);
            pre.setString(5, student.getStuId());
            pre.setString(1, student.getStuId());
            pre.setString(2, student.getBirthday());
            pre.setInt(3, student.getDeleted());
            pre.setInt(4, student.getClassId());
            n = pre.executeUpdate();
        } catch (SQLException ex) {

            Logger.getLogger(DAOStudent.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public int delete(String id) {
        int n = 0;
        String sql = "delete from student  where stuid =?";
        PreparedStatement pre = null;

        try {
            pre = conn.prepareStatement(sql);
            pre.setString(1, id);
            n = pre.executeUpdate();
        } catch (SQLException ex) {

            Logger.getLogger(DAOStudent.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }
}
