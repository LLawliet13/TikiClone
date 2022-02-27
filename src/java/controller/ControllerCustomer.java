/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import entity.Customer;
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
import model.DAOCustomer;
import model.DBConnect;

/**
 *
 * @author DELL
 */

/*
    sơ đồ các tính năng theo từ khóa
    
    
    
    */
@WebServlet(name = "ControllerCustomer", urlPatterns = {"/ControllerCustomer"})
public class ControllerCustomer extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        DAOCustomer dao = new DAOCustomer();
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Category</title>");
            out.println("</head>");
            out.println("<body>");
            String action = request.getParameter("action");
            String submit = request.getParameter("submit");

            if (action == null) {
                action = "listAll";
            }
            if (action.equals("login")) {
                String urlJSP = request.getParameter("urlJSP");
                request.setAttribute("urlJSP", urlJSP);
                if (submit == null) {
                    dispatch(request, response, "/Login.jsp");
                } else {
                    String username = request.getParameter("username");
                    ResultSet acc = dao.getData("select * from Customer where username = '" + username + "'");
                    if (acc.next()) {
                        String password = request.getParameter("password");
                        if (password.equals(acc.getString("password"))) {
                            HttpSession session = request.getSession();
                            session.setAttribute("user", username);

                        } else {

                            String massage = "Wrong password";
                            request.setAttribute("massage", massage);
                        }

                    } else {

                        String massage = "account doesnt exist";
                        request.setAttribute("massage", massage);
                    }

                    dispatch(request, response, "/Login.jsp");
                }
            }
            if (action.equals("search")) {
                String urlJSP = request.getParameter("urlJSP");
                if (submit == null) {
                    response.sendRedirect("Customer.jsp");
                } else {
                    String order = request.getParameter("order");
                    String otherOption = "";
                    if (order != null) {
                        otherOption += order;
                    }
                    ResultSet rs = dao.getData("select * from customer where cname like '%" + request.getParameter("cname") + "%' " + otherOption);
                    request.setAttribute("rs", rs);
                    dispatch(request, response, urlJSP);

                }

            }
            if (action.equals("update")) {
                String urlJSP = request.getParameter("url");// url trang gọi tính năg update
                String managertype = request.getParameter("managertype");
                String option = request.getParameter("option");
                request.setAttribute("managertype", managertype);
                request.setAttribute("option", option);
                String formtype = request.getParameter("formtype");
                request.setAttribute("formtype", formtype);

                if (submit == null) {
                    String cid = request.getParameter("cid");
                    ResultSet rsCus = new DBConnect().getData("select * from customer where cid = " + cid);
                    request.setAttribute("url", urlJSP);
                    request.setAttribute("rs", rsCus);
                    if (urlJSP == null) {
                        urlJSP = "/UpdateCustomer.jsp";
                    }
                    dispatch(request, response, urlJSP);

                } else {
                    String username = request.getParameter("username");
                    String password = request.getParameter("password");
                    String cname = request.getParameter("cname");
                    String cphone = request.getParameter("cphone");
                    String caddress = request.getParameter("caddress");
                    String status = request.getParameter("status");
                    String cid = request.getParameter("cid");
                    boolean isValid = true;
                    if (username == null) {
                        isValid = false;

                    } else {

                        ResultSet rsCus = new DBConnect().getData("select * from Customer");
                        while (rsCus.next()) {
                            if (rsCus.getInt("cid") != Integer.parseInt(cid)) {
                                if (rsCus.getString("username").equals(username)) {

                                    isValid = false;
                                    break;
                                }
                            }
                        }
                    }
                    if (urlJSP == null) {
                        urlJSP = "ControllerCustomer";
                    } else {
                        urlJSP = "ControllerProject?action=selectcustomerpage&&managertype=customermanager&&option=listattribute";
                    }
                    if (isValid == true && password.length() >= 8) {
                        int n = 0;
                        DAOCustomer DC = new DAOCustomer();
//                        int n = DC.updateCustomer(new Customer(Integer.parseInt(cid), Integer.parseInt(status), cname, cphone, caddress, username, password));

                        if (n == 1) {
                            out.println("<script type=\"text/javascript\">");
                            out.println("alert('update thông tin khác hàng thành công!');");
                            out.println("location='" + urlJSP + "';");
                            out.println("</script>");

                        }
                    } else {

                        out.println("<script type=\"text/javascript\">");
                        out.println("alert('Input invalid or username duplicated!');");
                        out.println("history.back();");
                        out.println("</script>");
                    }
                }
            }
            if (action.equals("insert")) {

                String register = request.getParameter("register");
                String formtype = request.getParameter("formtype");
                String option = request.getParameter("option");
                String managertype = request.getParameter("managertype");
                request.setAttribute("managertype", managertype);
                request.setAttribute("option", option);
                request.setAttribute("formtype", formtype);
                request.setAttribute("register", register);
                request.setAttribute("isDispatched", true);
                if (submit == null) {

                    dispatch(request, response, "admin/AdminSettings.jsp");
                } else {
                    String username = request.getParameter("username");
                    String password = request.getParameter("password");
                    String cname = request.getParameter("cname");
                    String cphone = request.getParameter("cphone");
                    String caddress = request.getParameter("caddress");
                    String status = "1";
                    boolean isValid = true;

                    if (username == null || password == null || cname == null || cphone == null || caddress == null) {
                        isValid = false;
                    } else {
                        ResultSet cusSet = new DBConnect().getData("select * from Customer");
                        while (cusSet.next()) {
                            if (username.equals(cusSet.getString("username"))) {
                                isValid = false;
                            }
                        }
                    }

                    String urlJSP = "ControllerProject?action=selectcustomerpage&&managertype=customermanager&&option=listattribute";

                    if (isValid == true && password.length() >= 8) {
                        DAOCustomer DC = new DAOCustomer();
                        int statusnum = Integer.parseInt(status);
//                        DC.addCustomer(new Customer(statusnum, cname, cphone, caddress, username, password));

                        out.println("<script type=\"text/javascript\">");
                        out.println("alert('Đăng kí thành công!');");
                        out.println("location='" + urlJSP + "';");
                        out.println("</script>");
                    } else {

                        out.println("<script type=\"text/javascript\">");
                        out.println("alert('Input invalid or username duplicated!');");
                        out.println("history.back();");
                        out.println("</script>");
                    }

                }
            }
            if (action.equals("changepass")) {
            }

            if (action.equals("delete")) {
                String urlJSP = request.getParameter("url");
                String cid = request.getParameter("cid");
                DAOCustomer dc = new DAOCustomer();
                int n = dc.removeCustomer(Integer.parseInt(cid));
                if (urlJSP == null) {
                    urlJSP = "ControllerCustomer";
                }
                if (n == 1) {
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Delete khách hàng thành công!');");
                    out.println("window.location=document.referrer;");
                    out.println("</script>");
                } else {

                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Status Changed to disable!');");
                    out.println("window.location=document.referrer;");
                    out.println("</script>");
                }

            }
            if (action.equalsIgnoreCase("listAll")) {
                String urlJSP = request.getParameter("url");
                ResultSet rs = dao.getData("select * from customer");
                request.setAttribute("rs", rs);
                request.setAttribute("url", urlJSP);
                dispatch(request, response, "/ViewCustomer.jsp");

            }
            out.println("</body>");
            out.println("</html>");
        } catch (SQLException ex) {
            Logger.getLogger(ControllerAdmin.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void dispatch(HttpServletRequest request, HttpServletResponse response, String url) {
        RequestDispatcher disp = request.getRequestDispatcher(url);
        try {
            disp.forward(request, response);
        } catch (ServletException ex) {
            Logger.getLogger(ControllerCategory.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(ControllerCategory.class.getName()).log(Level.SEVERE, null, ex);
        }
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
            Logger.getLogger(ControllerCustomer.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ControllerCustomer.class.getName()).log(Level.SEVERE, null, ex);
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
