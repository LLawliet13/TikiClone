/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import entity.Product;
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
import model.DAOProduct;
import model.DBConnect;

/**
 *
 * @author DELL
 */
@WebServlet(name = "ControllerProduct", urlPatterns = {"/ControllerProduct"})
public class ControllerProduct extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {

            DAOProduct dao = new DAOProduct();
            String action = request.getParameter("action");
            String submit = request.getParameter("submit");
            if (action == null) {
                action = "listAll";
            }
            if (action.equals("listAll")) {
                ResultSet rs = dao.getData("select * from product");
                String urlJSP = request.getParameter("url");
                request.setAttribute("rs", rs);
                request.setAttribute("url", urlJSP);
                //select view
                RequestDispatcher disp = request.getRequestDispatcher("/ViewProduct.jsp");
                disp.forward(request, response);
            }

            if (action.equals("search")) {
                if (submit == null) {
                    response.sendRedirect("Product.jsp");

                } else {
                    String urlJSP = request.getParameter("urlJSP");
                    String pname = request.getParameter("pname");
                    String orderQuantity = request.getParameter("orderQuantity");
                    String orderPrice = request.getParameter("orderPrice");

                    String otherOption = "";
                    if (orderPrice != null) {
                        otherOption += "order by " + orderPrice;
                        if (orderQuantity != null) {
                            otherOption += ", " + orderQuantity;
                        }

                    } else {
                        if (orderQuantity != null) {
                            otherOption += "order by " + orderQuantity;
                        }
                    }

                    ResultSet rs = dao.getData("select * from Product  where pname like '%" + pname + "%' " + otherOption);
                    request.setAttribute("rs", rs);
                    dispatch(request, response, urlJSP);
                }

            }
            if (action.equals("update")) {
                String urlJSP = request.getParameter("url");
                String managertype = request.getParameter("managertype");
                String option = request.getParameter("option");
                request.setAttribute("managertype", managertype);
                request.setAttribute("option", option);
                String formtype = request.getParameter("formtype");
                request.setAttribute("formtype", formtype);
                if (submit == null) {
                    if (urlJSP == null) {
                        urlJSP = "/UpdateProduct.jsp";
                    }
                    String pid = request.getParameter("pid");
                    ResultSet rs = dao.getData("select * from product where pid ='" + pid + "'");
                    request.setAttribute("url", urlJSP);
                    request.setAttribute("rs", rs);

                    ResultSet rscate = dao.getData("select * from category ");
                    request.setAttribute("rscate", rscate);
                    dispatch(request, response, urlJSP);

                } else {
                    String pid = request.getParameter("pid");
                    String pname = request.getParameter("pname");//not null
                    String quantity = request.getParameter("quantity");//>0
                    String image = request.getParameter("image");
                    String price = request.getParameter("price");//>0
                    String description = request.getParameter("description");
                    String status = request.getParameter("status");
                    String cateID = request.getParameter("cateid");
                    boolean isValid = true;
                    int quantityNum = 0;
                    double priceNum = 0;
                    try {
                        if (pname == null || status == null) {
                            isValid = false;
                        }

                        quantityNum = Integer.parseInt(quantity);
                        priceNum = Double.parseDouble(price);
                    } catch (NumberFormatException E) {
                        isValid = false;
                    }
                    if (urlJSP == null) {
                        urlJSP = "ControllerProduct";
                    } else {
                        urlJSP = "ControllerProject?action=selectproductpage&&managertype=productmanager&&option=listattribute";
                    }

                    if (isValid == true && priceNum >= 0 && quantityNum >= 0) {
                        int statusNum = Integer.parseInt(status);
                        int cateIdNum = Integer.parseInt(cateID);
                        DAOProduct Dp = new DAOProduct();
                        int n = Dp.updateProduct(new Product(pid, pname, image, description, cateIdNum, quantityNum, priceNum, statusNum));
                        if (n == 1) {

                            out.println("<script type=\"text/javascript\">");
                            out.println("alert('update sản phẩm thành công!');");
                            out.println("location='" + urlJSP + "';");
                            out.println("</script>");

                        } else {
                            out.println(pid);
                        }

                    } else {

                        out.println("<script type=\"text/javascript\">");
                        out.println("alert('Input invalid or pid duplicated!');");
                        out.println("history.back();");
                        out.println("</script>");
                    }
                }

            }
            if (action.equals("insert")) {

                String managertype = request.getParameter("managertype");
                String option = request.getParameter("option");
                String formtype = request.getParameter("formtype");
                request.setAttribute("formtype", formtype);
                request.setAttribute("managertype", managertype);
                request.setAttribute("option", option);
                request.setAttribute("isDispatched", true);
                request.setAttribute("isDispatched", true);
                if (submit == null) {

                    ResultSet rscate = dao.getData("select * from category");
                    request.setAttribute("rscate", rscate);

                    dispatch(request, response, "admin/AdminSettings.jsp");

                } else {
                    String pid = request.getParameter("pid");
                    String pname = request.getParameter("pname");//not null
                    String quantity = request.getParameter("quantity");//>0
                    String image = request.getParameter("image");
                    String price = request.getParameter("price");//>0
                    String description = request.getParameter("description");
                    String status = request.getParameter("status");
                    String cateID = request.getParameter("cateid");
                    boolean isValid = true;
                    int quantityNum = 0;
                    int priceNum = 0;
                    try {
                        if (pname == null) {
                            isValid = false;
                        }
                        quantityNum = Integer.parseInt(quantity);
                        priceNum = Integer.parseInt(price);
                    } catch (NumberFormatException E) {
                        isValid = false;
                    }
                    //check duplicated pid value
                    ResultSet curPro = new DBConnect().getData("select * from product");
                    while (curPro.next()) {
                        if (pid.equals(curPro.getString("pid"))) {
                            isValid = false;
                            break;
                        }
                    }

                    String urlJSP = "ControllerProject?action=selectproductpage&&managertype=productmanager&&option=listattribute";

                    if (isValid == true && priceNum >= 0 && quantityNum >= 0) {
                        int statusNum = Integer.parseInt(status);
                        int cateIdNum = Integer.parseInt(cateID);
                        DAOProduct Dp = new DAOProduct();
                        int n = Dp.addProduct(new Product(pid, pname, image, description, cateIdNum, quantityNum, priceNum, statusNum));
                        if (n == 1) {

                            out.println("<script type=\"text/javascript\">");
                            out.println("alert('insert sản phẩm thành công!');");
                            out.println("location='" + urlJSP + "';");
                            out.println("</script>");

                        }
                    } else {
                        out.println("<meta http-equiv='refresh' content='2;URL=" + urlJSP + "'>");//redirects after 3 seconds
                        out.println("<p style='color:red;'>Input invalid or pid duplicated!</p>");
                        out.println("<script type=\"text/javascript\">");
                        out.println("alert('Input invalid or pid duplicated!');");
                        out.println("history.back();");
                        out.println("</script>");
                    }
                }
            }
            if (action.equals("delete")) {
                String urlJSP = request.getParameter("url");

                String pid = request.getParameter("pid");
                DAOProduct DP = new DAOProduct();
                int n = DP.removeProduct(pid);
                if (urlJSP == null) {
                    urlJSP = "ControllerProduct";
                }
                if (n == 1) {

                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('delete sản phẩm thành công!');");
                    out.println("window.location=document.referrer;");
                    out.println("</script>");
                } else {

                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Status changed to disable!');");
                    out.println("window.location=document.referrer;");
                    out.println("</script>");
                }

            }
        }
    }

    public void dispatch(HttpServletRequest request, HttpServletResponse response, String url) throws IOException, ServletException {
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
            Logger.getLogger(ControllerProduct.class
                    .getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ControllerProduct.class
                    .getName()).log(Level.SEVERE, null, ex);
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
