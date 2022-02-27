/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import entity.Category;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.DAOCategory;

/**
 *
 * @author DELL
 */
@WebServlet(name = "ControllerCategory", urlPatterns = {"/ControllerCategory"})
public class ControllerCategory extends HttpServlet {

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
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        DAOCategory dao = new DAOCategory();

        try (PrintWriter out = response.getWriter()) {
            String action = request.getParameter("action");
            String submit = request.getParameter("submit");
            if (action == null) {
                action = "listAll";
            }
            if (action.equals("listAll")) {
                ResultSet rs = dao.getData("select * from category");
                request.setAttribute("rs", rs);
                dispacth(request, response, "/ViewCategory.jsp");
            }
            if (action.equals("search")) {
                if (submit == null) {
                    response.sendRedirect("Category.jsp");

                } else {
                    String urlJSP = request.getParameter("urlJSP");
                    String catename = request.getParameter("catename");
                    String order = request.getParameter("order");
                    String otherOption = "";
                    if(order!=null) otherOption += order; 
                    ResultSet rs = dao.getData("select * from Category where catename like '%" + catename + "%' "+order);
                    request.setAttribute("rs", rs);
                    dispacth(request, response, urlJSP);

                }
            }
            if (action.equals("update")) {
                if (submit == null) {
                    ResultSet rs = dao.getData("select * from category where cateid =" + request.getParameter("cateid"));
                    request.setAttribute("rs", rs);
                    dispacth(request, response, "/UpdateCategory.jsp");
                } else {
                    String cateid = request.getParameter("cateid");
                    String catename = request.getParameter("catename");
                    String status = request.getParameter("status");
                    DAOCategory DC = new DAOCategory();
                    if (catename == null) {
                        out.println("no input");
                    } else {
                        int n = DC.UpdateCategory(new Category(Integer.parseInt(cateid), catename, Integer.parseInt(status)));
                        if (n == 1) {
                            response.sendRedirect("ControllerCategory");
                        } else {
                            out.println("server not responding");
                        }
                    }
                }
            }
            if (action.equals("delete")) {
                String cateId = request.getParameter("cateid");
                DAOCategory DC = new DAOCategory();
                DC.removeCategory(Integer.parseInt(cateId));
                response.sendRedirect("ControllerCategory");

            }
            if (action.equals("insert")) {
                
                if (submit == null) {
                    Boolean isDispatched = true;
                    request.setAttribute("isDispatched", isDispatched);
                    dispacth(request, response, "/InsertCategory.jsp");
                } else {
                    String catename = request.getParameter("catename");
                    String status = request.getParameter("status");
                    DAOCategory DC = new DAOCategory();
                    //chưa có check(trong bài)
                    if (catename == null) {
                        out.println("no input");
                    } else {
                        DC.addCategory(new Category(Integer.parseInt(status), catename));
                        response.sendRedirect("ControllerCategory");
                    }
                }
            }
        }
    }

    public void dispacth(HttpServletRequest request, HttpServletResponse response, String url) {
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
        processRequest(request, response);
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
        processRequest(request, response);
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
