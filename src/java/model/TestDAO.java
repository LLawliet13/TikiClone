/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import entity.Admin;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author DELL
 */
public class TestDAO extends DBConnect{

    class TestAdmin {

        DAOAdmin ad = new DAOAdmin();

        public void add() {
            
            Admin ex_1 = new Admin("user", "123456");
            String sql = "insert into admin(username, password) values(?,?)";
            PreparedStatement pre ;
            try {
                pre = conn.prepareStatement(sql);
                pre.setString(1, ex_1.getUsername());
                pre.setString(2, ex_1.getPassword());
                pre.executeUpdate();
            } catch (SQLException ex) {
                Logger.getLogger(TestDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        public void update() {
            

        }

        public void remove() {

        }
    }

    class TestBill {

        DAOAdmin ad = new DAOAdmin();

        public void add() {

        }

        public void update() {

        }

        public void remove() {

        }
    }

    class TestBillDetail {

        DAOAdmin ad = new DAOAdmin();

        public void add() {

        }

        public void update() {

        }

        public void remove() {

        }
    }

    class TestCategory {

        DAOAdmin ad = new DAOAdmin();

        public void add() {

        }

        public void update() {

        }

        public void remove() {

        }
    }

    class TestCustomer {

        DAOAdmin ad = new DAOAdmin();

        public void add() {

        }

        public void update() {

        }

        public void remove() {

        }
    }

    class TestProduct{

        DAOAdmin ad = new DAOAdmin();

        public void add() {

        }

        public void update() {

        }

        public void remove() {

        }
    }

    public static void main(String[] args) {

    }
}
