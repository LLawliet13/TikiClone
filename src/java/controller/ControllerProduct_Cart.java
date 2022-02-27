/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import entity.Bill;
import entity.BillDetail;
import entity.Customer;
import entity.Product;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.DAOBill;
import model.DAOBillDetail;
import model.DAOProduct;

/**
 *
 * @author DELL
 */
@WebServlet(name = "ControllerProduct_Cart", urlPatterns = {"/ControllerProduct_Cart"})
public class ControllerProduct_Cart extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
            DAOProduct dao = new DAOProduct();
            String action = request.getParameter("action");
            String submit = request.getParameter("submit");
            if (action == null) {
                action = "listAll";
            }
            if(action.equals("print")){
                out.println("done");
            }

            if (action.equals("listAll")) {
                ResultSet rs = dao.getData("select * from product");
                request.setAttribute("rs", rs);

                RequestDispatcher disp = request.getRequestDispatcher("/Item_list.jsp");
                disp.forward(request, response);
            }
            if (action.equals("addtocart")) {
                String urlJSP = request.getParameter("url");// lay link trng jsp tra ve
                if (urlJSP == null) {
                    urlJSP = "ShowCartProject.jsp";
                }
                ResultSet rs = dao.getData("select * from product where pid = '" + request.getParameter("pid") + "'");
                HttpSession session = request.getSession();

                if (rs.next()) {
                    String pid = rs.getString("pid");
                    Product productSess = (Product) session.getAttribute(pid);
                    if (productSess == null) {
                        int cateID = rs.getInt("cateid");
                        int quantity = rs.getInt("quantity");
                        double price = rs.getDouble("price");
                        String pname = rs.getString("pname");
                        Product newPro = new Product(pid, pname, "", "", cateID, 1, price, 0);
                        session.setAttribute(pid, newPro);
                    } else {
                        productSess.setQuantity(productSess.getQuantity() + 1);
                        session.setAttribute(pid, productSess);
                    }

                    response.sendRedirect(urlJSP);
                }
            }
            if (action.equals("createbillform")) {
//                String cid = request.getParameter("cid");
//                ResultSet rs = dao.getData("select * from customer where cid = " + cid);
//                if (rs.next()) {
//                    Bill bill = new Bill("0", "0", rs.getString("cname"), rs.getString("cphone"), rs.getString("caddress"), 0.0, 1, Integer.parseInt(cid));
//                    request.setAttribute("bill", bill);
//                    dispatch(request, response, "/ViewBillInCheckOut.jsp");
//                } else {
//                    out.println("no" + cid);
//                }// form for checkout with search customer

                String urlJSP = request.getParameter("url");
                HttpSession session = request.getSession();
                String user = (String) session.getAttribute("user");
                ResultSet rscus = dao.getData("select * from customer where username='" + user + "'");
                rscus.next();
                Bill bill = new Bill("0", "0", rscus.getString("cname"), rscus.getString("cphone"), rscus.getString("caddress"), 0.0, 1, rscus.getInt("cid"));
//                out.println(bill);
                request.setAttribute("bill", bill);
                dispatch(request, response, urlJSP);

            }
            if (action.equals("changebilldetail")) {
                if (submit == null) {
                    String cid = request.getParameter("cid");
                    ResultSet rs = dao.getData("select * from customer where cid = " + cid);
                    if (rs.next()) {
                        Bill bill = new Bill("0", "0", rs.getString("cname"), rs.getString("cphone"), rs.getString("caddress"), 0.0, 1, Integer.parseInt(cid));
                        request.setAttribute("bill", bill);
                        String urlandaction = "ControllerProduct_Cart?action=changebilldetail";
                        request.setAttribute("urlandaction", urlandaction);
                        dispatch(request, response, "/UpdateBill.jsp");
                    } else {
                        out.println("no" + cid);
                    }
                } else {
                    String cname = request.getParameter("cname");
                    String cphone = request.getParameter("cphone");
                    String cAddress = request.getParameter("caddress");
                    String cid = request.getParameter("cid");
                    Bill bill = new Bill("0", "0", cname, cphone, cAddress, 0.0, 1, Integer.parseInt(cid));
                    request.setAttribute("bill", bill);
                    dispatch(request, response, "/ViewBillInCheckOut.jsp");
                }
            }
            if (action.equals("update")) {
                if (submit == null) {

                } else {
                    String urlJSP = request.getParameter("url");
                    if (urlJSP == null) {
                        urlJSP = "user/pages/showcart/index.jsp";
                    }
                    String value[] = request.getParameterValues("quantity");
                    String pid[] = request.getParameterValues("pid");
                    HttpSession session = request.getSession();
//                    out.println(value+ ", "+pid+"\n");
                     Boolean quantityError = false;
                    if (value == null || pid == null) {

                    } else {
                       
                        for (int i = 0; i < pid.length; i++) {
                            Product pro = (Product) session.getAttribute(pid[i]);
                            int quantity = pro.getQuantity();

                            if (value[i] == null) {
                                continue;
                            }
                            try {
                                quantity = Integer.parseInt(value[i]);

                            } catch (NumberFormatException E) {
                                continue;
                            }
                            ResultSet rspro = dao.getData("select * from product where pid = '" + pid[i] + "'");
                            
                            
                            if (rspro.next()) {
                                if (rspro.getInt("quantity") < quantity) {
                                    quantityError = true;
                                } else {
                                    pro.setQuantity(quantity);
                                }
                            }
                            

                        }
                    }
                    if(quantityError==true){
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('1 vài sản phẩm vượt quá số lượng cho phép');");
                    out.println("location='" + urlJSP + "';");
                    out.println("</script>");
                    }else{
                        response.sendRedirect(urlJSP);
                    }

                }

            }
            if (action.equals("import")) {

                String cname = request.getParameter("cname");
                String cphone = request.getParameter("cphone");
                String cAddress = request.getParameter("caddress");
                String cid = request.getParameter("cid");

                ResultSet cus = dao.getData("select * from customer where cid =" + cid);
                cus.next();

//                Customer customer = new Customer(1, cname != null ? cname : cus.getString("cname"), cphone != null ? cphone : cus.getString("cphone"), cAddress != null ? cAddress : cus.getString("cAddress"), "", "");

                HttpSession session = request.getSession();
                Enumeration all = session.getAttributeNames();
                int size = 0;// trong session có sản phẩm k

                while (all.hasMoreElements()) {
                    String stuff = all.nextElement().toString();

                    if (stuff.equals("user") || stuff.equals("admin")) {
                        continue;
                    } else {
                        ResultSet isPro = dao.getData("select * from product where pid ='" + stuff + "'");
                        if (isPro != null) {

                            size++;
                            break;
                        }
                    }
                }

                if (size > 0) {

//                  
                    DAOBill daobill = new DAOBill();
                    Date date = Calendar.getInstance().getTime();
                    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                    String strDate = dateFormat.format(date);
                    Calendar c = Calendar.getInstance();
                    dateFormat = new SimpleDateFormat("yyyyMMdd");
                    String code = dateFormat.format(date);
                    int hour = c.get(Calendar.HOUR);
                    int second = c.get(Calendar.SECOND);
                    int millis = c.get(Calendar.MILLISECOND);

                    String oid = hour + code + millis + second;
//                    Bill newBill = new Bill(oid, strDate, customer.getCname(), customer.getCphone(), customer.getcAddress(), 0.0, 0, Integer.parseInt(cid));
//                    int n = daobill.addBill(newBill);
//
                    double total = 0.0;
                    DAOBillDetail daodetail = new DAOBillDetail();
                    Product pro = null;
                    all = session.getAttributeNames();
//
                    while (all.hasMoreElements()) {
                        String pid = all.nextElement().toString();
                        if (pid.equals("user") || pid.equals("admin")) {
                            continue;
                        }
//
                        pro = (Product) session.getAttribute(pid);
                        int quantity = pro.getQuantity();
                        double price = pro.getPrice();
                        double detailTotal = quantity * price;
                        total += detailTotal;
                        int m = daodetail.addBillDetail(new BillDetail(pro.getPid(), oid, quantity, price, detailTotal));
//
                    }

//                    newBill.setTotal(total);
//                    daobill.updateBill(newBill);
//                    /// xóa sản phẩm
                    String pid = "";
                    all = session.getAttributeNames();
                    while (all.hasMoreElements()) {
                        pid = all.nextElement().toString();
                        if (pid.equals("user") || pid.equals("admin")) {
                            continue;
                        }
                        session.removeAttribute(pid);
                    }
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Mua hàng thành công!');");
                    out.println("location='index.jsp';");
                    out.println("</script>");

                } else {

                    out.println("<meta http-equiv='refresh' content='2;URL=index.jsp'>");//redirects after 3 seconds
                    out.println("<p style='color:red;'>You didnt buy anything!</p>");

                }

//
            }
            if (action.equals("removeCart")) {
                String urlJSP = request.getParameter("url");
                if (urlJSP == null) {
                    urlJSP = "ShowCartProject.jsp";
                }
                String pid = request.getParameter("pid");

                HttpSession session = request.getSession();
                if (pid.equals("all")) {

                    java.util.Enumeration all = session.getAttributeNames();
                    while (all.hasMoreElements()) {
                        pid = all.nextElement().toString();
                        if (pid.equals("user") || pid.equals("admin")) {
                            continue;
                        }
                        session.removeAttribute(pid);
                    }
                } else {
                    session.removeAttribute(pid);
                }
                response.sendRedirect(urlJSP);

            }

            if (action.equals("search")) {
                String url = request.getParameter("url");

                String search = request.getParameter("search");
                if (search == null) {
                } else {
                    String name = request.getParameter("cname");
                    ResultSet rs = dao.getData("select * from customer where cname LIKE '%" + name + "%'");

                    request.setAttribute("rs", rs);
                    dispatch(request, response, url);

                }
            }
        }
    }

    void dispatch(HttpServletRequest request, HttpServletResponse response,
            String url) throws IOException, ServletException {
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
            Logger.getLogger(ControllerProduct_Cart.class
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
            Logger.getLogger(ControllerProduct_Cart.class
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
