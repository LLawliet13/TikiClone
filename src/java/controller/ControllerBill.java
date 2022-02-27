/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import entity.Bill;
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
import model.DAOBill;

/**
 *
 * @author DELL
 */
@WebServlet(name = "ControllerBill", urlPatterns = {"/ControllerBill"})
public class ControllerBill extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        DAOBill dao = new DAOBill();
        try (PrintWriter out = response.getWriter()) {

            String action = request.getParameter("action");
            String submit = request.getParameter("submit");
            if (action == null) {
                action = "listAll";
            }
            if (action.equals("listAll")) {
                ResultSet rs = dao.getData("select * from bill");
                request.setAttribute("rs", rs);
                dispatch(request, response, "/ViewBill.jsp");
            }

            if (action.equals("search")) {
                String urlJSP = request.getParameter("url");
                if (urlJSP == null) {
                    urlJSP = "ViewBill.jsp";
                }
                if (submit == null) {
                    ResultSet rs = dao.getData("select * from bill");
                } else {
                    String cname = request.getParameter("cname");
                    String orderDate = request.getParameter("orderDate");
                    String orderName = request.getParameter("orderName");
                    String otherOption = "";
                    if (orderName != null) {
                        otherOption += "order by " + orderName;
                        if (orderDate != null) {
                            otherOption += ", " + orderDate;
                        }

                    } else {
                        if (orderDate != null) {
                            otherOption += "order by " + orderDate;
                        }
                    }

                    ResultSet rs = dao.getData("select * from Bill  where cname like '%" + cname + "%' " + otherOption);
                    request.setAttribute("rs", rs);

                }
                dispatch(request, response, urlJSP);
            }
            if (action.equals("update")) {
                if (submit == null) {
                    String oid = request.getParameter("oid");
                    ResultSet rs = dao.getData("select * from bill where oid = '" + oid + "'");
                    request.setAttribute("rs", rs);
                    dispatch(request, response, "/UpdateBill.jsp");
                } else {
                    String oID = request.getParameter("oid");
                    ResultSet rs = dao.getData("select * from bill where oid = '" + oID + "'");
                    request.setAttribute("rs", rs);
//                    String dateCreate = request.getParameter("datecreate");
                    String cname = request.getParameter("cname");
                    String cphone = request.getParameter("cphone");
                    String cAddress = request.getParameter("caddress");
                    String status = request.getParameter("status");
                    String cid = request.getParameter("cid");

                    DAOBill DB = new DAOBill();
                    int n
                            = DB.updateBill(new Bill(oID, rs.getString("datecreate"),
                                    cname, cphone, cAddress, 0, Integer.parseInt(status), Integer.parseInt(cid)));
                    if (n == 1) {
                        response.sendRedirect("ControllerBill");
                    } else {
                        out.println("cant update");
                    }
                }
            }
            if (action.equals("delete")) {
                String oid = request.getParameter("oid");
                int n
                        = new DAOBill().removeBill(oid);
                if (n == 1) {
                    response.sendRedirect("ControllerBill");
                } else {
                    out.println("cant find" + oid);
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
            Logger.getLogger(ControllerBill.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ControllerBill.class.getName()).log(Level.SEVERE, null, ex);
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
