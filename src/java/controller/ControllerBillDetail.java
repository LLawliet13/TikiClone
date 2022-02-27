package controller;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.DAOBillDetail;

/**
 *
 * @author DELL
 */
@WebServlet(urlPatterns = {"/ControllerBillDetail"})
public class ControllerBillDetail extends HttpServlet {

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
        DAOBillDetail dao = new DAOBillDetail();
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String action = request.getParameter("action");
            if(action==null){
                action="listAll";
            }
            if(action.equals("listAll")){
                ResultSet rs = dao.getData("select * from billdetail");
                request.setAttribute("rs", rs);
                dispatch(request, response, "/ViewBillDetail.jsp");
                
            }
            if(action.equals("update")){
                
                out.println("chưa viết tính năng này");
            }
            if(action.equals("search")){
                String oid = request.getParameter("oid");
                ResultSet rs = dao.getData("select * from billdetail where oid = '"+oid+"'");
                request.setAttribute("rs", rs);
                dispatch(request, response, "/ViewBillDetail.jsp");
                
            }
            if (action.equals("delete")) {
                String urlJSP = request.getParameter("url");
                if(urlJSP==null) urlJSP ="ControllerBillDetail";
                String pid = request.getParameter("pid");
                String oid = request.getParameter("oid");
                new DAOBillDetail().removeBillDetail(oid, pid);
                response.sendRedirect(urlJSP);

            }
        }
    }
     void dispatch(HttpServletRequest request, HttpServletResponse response,String url) throws ServletException, IOException{
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
