/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import entity.Admin;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.DAOAdmin;
import model.DBConnect;

/**
 *
 * @author DELL
 */
@WebServlet(name = "ControllerAdmin", urlPatterns = {"/ControllerAdmin"})
public class ControllerAdmin extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    /*
    sơ đồ các tính năng theo từ khóa
    
    
    
    */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        DAOAdmin dao = new DAOAdmin();
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String action = request.getParameter("action");
            if (action == null) {
                action = "login";
            }
            if (action.equals("login")) {
                String submit = request.getParameter("submit");
                Boolean isDispatched = true;
                request.setAttribute("isDispatched", isDispatched);
                if (submit == null) {
                    dispatch(request, response, "admin/Panner/feature/Admin/Adminlogin.jsp");
                } else {
                    String username = request.getParameter("username");
                    ResultSet acc = dao.getData("select * from admin where username = '" + username + "'");
                    if (acc.next()) {
                        String password = request.getParameter("password");
                        if (password.equals(acc.getString("password"))) {
                            HttpSession session = request.getSession();
                            session.setAttribute("admin", username);
                        } else {
                            String massage = "Wrong password";
                            request.setAttribute("massage", massage);
                        }

                    } else {

                        String massage = "account doesnt exist";
                        request.setAttribute("massage", massage);
                    }
                    dispatch(request, response, "admin/Panner/feature/Admin/Adminlogin.jsp");
                }

            }
            if (action.equals("listAll")) {
                ResultSet rs = dao.getData("select * from admin");
                request.setAttribute("rs", rs);
                dispatch(request, response, "/ViewAdmin.jsp");
            }
            if (action.equals("update")) {
                String submit = request.getParameter("submit");
                if (submit == null) {
                    ResultSet rs = dao.getData("select * from admin where adminid =" + request.getParameter("adminid"));
                    request.setAttribute("rs", rs);
                    dispatch(request, response, "/UpdateAdmin.jsp");
                } else {
                    String adminId = request.getParameter("adminid");
                    String enteredoldpassword = request.getParameter("enteredoldpassword");
                    ResultSet adSet = new DAOAdmin().getData("select * from admin where adminid = " + adminId);
                    String oldpassword = "";
                    if (adSet.next()) {
                        oldpassword = adSet.getString("password");
                    }
                    String newpassword = request.getParameter("newpassword");
                    String renewpassword = request.getParameter("renewpassword");
                    if (enteredoldpassword.equals(oldpassword)) {
                        if (!oldpassword.equals(newpassword)) {
                            if (newpassword.length() >= 8) {
                                if (newpassword.equals(renewpassword)) {

                                    DAOAdmin ad = new DAOAdmin();
                                    Admin adEx = new Admin(Integer.parseInt(adminId), newpassword);
                                    ad.UpdateAdmin(adEx);
                                    response.sendRedirect("ControllerAdmin");
                                } else {
                                    out.println("new Password and re-entered New password are not the same");
                                }
                            } else {
                                out.println("password length is not valid");

                            }
                        } else {
                            out.println("old and new password are the same");

                        }
                    } else {
                        out.println("old password Wrong");

                    }
                }
            }
              if (action.equals("adminlogout")) {

                HttpSession session = request.getSession();
                
                if (session.getAttribute("admin") != null) {
                    session.removeAttribute("admin");
                }
                
                  String urlJSP = "admin/AdminSettings.jsp";
               
                response.sendRedirect(urlJSP);

            }
            if (action.equals("delete")) {
                String adminId = request.getParameter("adminid");
                DAOAdmin DA = new DAOAdmin();
                DA.removeAdmin(Integer.parseInt(adminId));
                response.sendRedirect("ControllerAdmin");

            }
            if (action.equals("insert")) {
                String submit = request.getParameter("submit");
                if (submit == null) {
                    dispatch(request, response, "/InsertAdmin.jsp");
                } else {
                    String userName = request.getParameter("username");
                    String password = request.getParameter("password");
//                    String gen = request.getParameter("gender");
//                    String hb[] = request.getParameterValues("hb");
//                    String lang = request.getParameter("lang");
                    String getSet = "select * from admin";
                    ResultSet adminset = new DBConnect().getData(getSet);
                    boolean isExisted = false;
                    while (adminset.next()) {
                        if (adminset.getString("username").equals(userName)) {
                            //duplicate userName;
                            isExisted = true;
                            break;
                        }
                    }

                    if (password.length() >= 8 && isExisted == false) {
                        DAOAdmin ad = new DAOAdmin();
                        Admin adEx = new Admin(userName, password);
                        ad.addAdmin(adEx);
                        response.sendRedirect("ControllerAdmin");
                    } else {
                        out.println("Input Error or Duplicated");
                    }
                }
            }
        }
    }

    void dispatch(HttpServletRequest request, HttpServletResponse response, String url) throws ServletException, IOException {
        RequestDispatcher disp = request.getRequestDispatcher(url);
        disp.forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ControllerAdmin.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ControllerAdmin.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
