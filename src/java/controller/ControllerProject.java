/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import com.google.gson.Gson;
import entity.Bill;
import entity.BillDetail;
import entity.Cart;
import entity.Customer;
import entity.Product;
import entity.ReceivingAddress;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.Normalizer;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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
import model.DAOAdmin;
import model.DAOBill;
import model.DAOBillDetail;
import model.DAOCart;
import model.DAOCustomer;
import model.DAOProduct;
import model.DBConnect;
import model.DaoReceivingAddress;
import sun.security.rsa.RSACore;

/**
 *
 * @author DELL
 */
@WebServlet(name = "ControllerProject", urlPatterns = {"/ControllerProject"})
public class ControllerProject extends HttpServlet {

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
                action = "selectcategory";

            }
            if (action.equals("viewdetail")) {
                String pid = request.getParameter("pid");
                ResultSet rs = dao.getData("with t as (select pid , count(*) as count from BillDetail group by pid)\n"
                        + "                       select product.*, productrate.rate, t.count,discount from product  left join productrate on product.pid = ProductRate.pid left join t on \n"
                        + "                       Product.pid = t.pid left join Discount on product.pid = discount.pid\n"
                        + "                        where product.pid = '" + pid + "'");
                request.setAttribute("rsPro", rs);
                request.setAttribute("isDispatched", true);
                dispatch(request, response, "user/pages/viewdetail/index.jsp");
            }
            if (action.equals("selectmanager")) {
                String option = request.getParameter("option");
                String managerType = request.getParameter("managertype");
                Boolean isDispatched = true;
                request.setAttribute("option", option);
                request.setAttribute("managertype", managerType);

                request.setAttribute("isDispatched", isDispatched);
                dispatch(request, response, "admin/AdminSettings.jsp");
            }
            if (action.equals("searchNavBar")) {
                String content = request.getParameter("content");
                content = new String(content.getBytes("ISO-8859-1"), "UTF-8");
                content = Normalizer.normalize(content, Normalizer.Form.NFD);
                content = content.replaceAll("[^\\p{ASCII}]", "");
                content = content.replace(" ", "");

//                ResultSet rs = dao.getData("Select pname from product where pname like '%" + content + "%'");
                ResultSet rs = dao.getData("select * from product where \n"
                        + "(select dbo.RemoveExtraChars(product.pname)) like '%" + content + "%'");
                while (rs.next()) {
                    out.println("<h4><a href=\"ControllerProject?action=viewdetail&&pid=" + rs.getString("pid") + "\">" + rs.getString("pname") + "</a></h4>");
                }

            }
            if (action.equals("canShowMore")) {
                String topic = request.getParameter("topic");
                String numberOfBox = request.getParameter("numberOfBox");
                if (numberOfBox == null) {
                    numberOfBox = "0";
                }
                ResultSet rs = null;
                if (topic.equals("hot_deal")) {
                    rs = (ResultSet) dao.getData("select * from product order by pname asc ");
                }
                if (topic.equals("newStuffs")) {
                    rs = (ResultSet) dao.getData("select * from product "
                            + "order by product.datecreated desc , pname asc ");
                }
                if (topic.equals("trend")) {
                    rs = (ResultSet) dao.getData("with t as (select product.pid as pid , count(*) as number\n"
                            + "from product inner join BillDetail on product.pid = BillDetail.pid\n"
                            + "\n"
                            + "group by product.pid)\n"
                            + "\n"
                            + "select product.* from product left join t on product.pid = t.pid\n"
                            + "order by t.number desc , product.pname asc\n"
                    );
                }
                if (topic.equals("big_discount")) {
                    rs = (ResultSet) dao.getData("select product.* from product left  join Discount on product.pid = discount.pid\n"
                            + "order by discount.discount desc");
                }
                int numberOfBoxesLeft = 0 - Integer.parseInt(numberOfBox) - 12;
                while (rs.next()) {
                    numberOfBoxesLeft++;
                }
                if (numberOfBoxesLeft <= 0) {
                    out.println("");
                } else {
                    out.println("<h1>Xem Thêm</h1>");
                }
            }
            if (action.equals("selectCategory_hotDeal")) {
                String topic = request.getParameter("topic");
                String numberOfBox = request.getParameter("numberOfBox");
                if (numberOfBox == null) {
                    numberOfBox = "0";
                }
                ResultSet rs = null;
                if (topic.equals("hot_deal")) {
                    rs = (ResultSet) dao.getData("select * from product order by pname asc offset " + numberOfBox + " row fetch next 12 rows only");
                }
                if (topic.equals("newStuffs")) {
                    rs = (ResultSet) dao.getData("select * from product "
                            + "order by product.datecreated desc , pname asc offset " + numberOfBox + " row fetch next 12 rows only");
                }
                if (topic.equals("trend")) {
                    rs = (ResultSet) dao.getData("with t as (select product.pid as pid , count(*) as number\n"
                            + "from product inner join BillDetail on product.pid = BillDetail.pid\n"
                            + "\n"
                            + "group by product.pid)\n"
                            + "\n"
                            + "select product.* from product left join t on product.pid = t.pid\n"
                            + "order by t.number desc , product.pname asc\n"
                            + "offset " + numberOfBox + " row fetch next 12 rows only");
                }
                if (topic.equals("big_discount")) {
                    rs = (ResultSet) dao.getData("select product.* from product left  join Discount on product.pid = discount.pid\n"
                            + "order by discount.discount desc offset " + numberOfBox + " row fetch next 12 rows only");
                }
                int index = 0;
                while (rs.next()) {
                    index = 0;

                    out.println("<div class=\"hot_item_list_row\">\n");
                    do {

                        out.println("<div class=\"product_card\">\n"
                                + "                    <div class=\"product_pic\"><img class=\"product_image\" src=\"" + rs.getString("image") + "\" alt=\"Product image\"></div>\n"
                                + "                    <p>" + rs.getString("pname") + "</p>\n"
                                + "\n"
                                + "                    <div class=\"product_info\">\n"
                                + "                        <div class=\"product_feedback\" >\n"
                                + "                            <div class=\"product_rate\">"
                        );
                        int i = 0;
                        while (i < 5) {
                            out.println("<i class=\"fas fa-star\"></i>");
                            i++;
                        }
                        out.println("</div>|<div class=\"number_product_sold\">đã bán 100</div>\n"
                                + "                        </div>\n"
                                + "                        <div class=\"product_price\">\n"
                                + "                            <div class=\"raw_price\">\n"
                                + "                                " + rs.getInt("price") + "₫\n"
                                + "                            </div>\n"
                                + "                            <div class=\"discount\">-30%</div>\n"
                                + "                        </div>\n"
                                + "\n"
                                + "\n"
                                + "                    </div>\n"
                                + "                    <div class=\"view_product\" onclick=\"openDetail(this)\" request=\"ControllerProject?action=viewdetail&&pid=" + rs.getString("pid") + "\">Xem Chi Tiết</div>\n"
                                + "                </div>\n"
                                + "\n"
                        );
                        index++;
                    } while (index < 6 && rs.next());
                    out.println("</div> ");
                }

            }
            if (action.equals("changeNumberOfProductCart")) {

                DAOCart daoc = new DAOCart();
                String cid = request.getParameter("cid");
                String pid = request.getParameter("pid");
                String quantity = request.getParameter("quantity");
                if (Integer.parseInt(quantity) > 0) {
                    ResultSet cart = dao.getData("select * from cart where pid = '" + pid + "' and cid = " + cid);
                    cart.next();
                    Cart updatecart = new Cart(Integer.parseInt(cid), pid, Integer.parseInt(quantity), 1);

                    daoc.updateCart(updatecart);

                } else {
                    daoc.removeCart(Integer.parseInt(cid), pid);
                }
                out.println("success");

            }

            if (action.equals("estimateTotal")) {
                String[] pid = request.getParameterValues("pid[]");
                String cid = request.getParameter("cid");
                String requireCalulate = request.getParameter("require");
                DAOCart daoc = new DAOCart();
                String allProduct = "'" + pid[0] + "'";
                for (int i = 1; i < pid.length; i++) {
                    allProduct = allProduct + ",'" + pid[i] + "'";
                }
                allProduct = "(" + allProduct + ")";
                ResultSet rs = null;
                if (requireCalulate.equals("total")) {
                    rs = daoc.getData("select cart.cid, sum(cart.quantity*(1-cast(discount.discount as float)/cast(100 as float))*price) as \n"
                            + "total_after_discount from cart join product on cart.pid = product.pid left join \n"
                            + "Discount on cart.pid = discount.pid where cart.pid in" + allProduct + " and cid = " + cid + "group by cart.cid");
                    rs.next();
                    out.println(rs.getInt("total_after_discount"));
                }
                if (requireCalulate.equals("estimatedTotal")) {
                    rs = daoc.getData("select cart.cid, sum(cart.quantity*price) as \n"
                            + "real_total from cart join product on cart.pid = product.pid  where cart.pid in " + allProduct + " and cid = " + cid
                            + "group by cart.cid");
                    rs.next();
                    out.println(rs.getInt("real_total"));
                }
                if (requireCalulate.equals("discount")) {
                    rs = daoc.getData("select cart.cid, sum(cart.quantity*(cast(discount.discount as float)/cast(100 as float))*price) as \n"
                            + "discount_amount from cart join product on cart.pid = product.pid left join \n"
                            + "Discount on cart.pid = discount.pid where cart.pid in " + allProduct + " and cid = " + cid
                            + "group by cart.cid");
                    rs.next();
                    out.println(rs.getInt("discount_amount"));

                }

            }

            if (action.equals("showbilldetail")) {
                String urlJSP = request.getParameter("url");
                if (urlJSP == null) {
                    urlJSP = "AdminSettings.jsp";
                }
                String oid = request.getParameter("oid");
                ResultSet rs = dao.getData("select * from billdetail where oid = '" + oid + "'");
                request.setAttribute("rs", rs);
                request.setAttribute("oid", oid);
                request.setAttribute("url", urlJSP);
                ResultSet rsbill = dao.getData("select * from bill where oid = '" + oid + "'");
                rsbill.next();
                request.setAttribute("statusbill", rsbill.getInt("status"));

                dispatch(request, response, "/UpdateBillDetail.jsp");
            }
            if (action.equals("changestatusbill")) {
                String urlJSP = request.getParameter("url");
                String oid = request.getParameter("oid");
                int status = Integer.parseInt(request.getParameter("status"));
                ResultSet rs = dao.getData("select * from Bill where oid='" + oid + "'");
                if (rs.next()) {
                    Bill updatedBill = new Bill(oid, rs.getString("datecreate"), rs.getString("cname"),
                            rs.getString("cphone"), rs.getString("caddress"),
                            rs.getDouble("total"), status, rs.getInt("cid"));
                    DAOBill daobill = new DAOBill();
                    int n = daobill.updateBill(updatedBill);

                    if (n == 1) {
                        urlJSP = "ControllerProject?action=selectbillpage&&managertype=billmanager&&option=listattribute";
                        out.println("<script type=\"text/javascript\">");
                        out.println("alert('update bill thành công!');");
                        out.println("location='" + urlJSP + "';");
                        out.println("</script>");
                    } else {

                        out.println("<script type=\"text/javascript\">");
                        out.println("alert('some error occured!');");
                        out.println("history.back();");
                        out.println("</script>");
                    }

                } else {
                    out.println("no " + oid);
                }
            }
            if (action.equals("showbilltest")) {
                String cid = request.getParameter("cid");
                String content = request.getParameter("content");
                if (cid != null) {
                    if (content.equals("showbill")) {
                        ResultSet rsBill = dao.getData("select * from bill where cid = " + cid + " order by bill.dateCreate desc ");
                        int rsBill_length = 0;
                        while (rsBill.next()) {
                            rsBill_length++;
                        }
                        if (rsBill_length > 0) {
                            String[] pnames = new String[rsBill_length];
                            for (int j = 0; j < rsBill_length; j++) {
                                pnames[j] = "";
                            }
                            rsBill.beforeFirst();

                            int i = 0;
                            while (rsBill.next()) {

                                ResultSet rsBill_getPnames = dao.getData("select billdetail.*, product.pname  from billdetail join product on billdetail.pid = product.pid where oid ='" + rsBill.getString("oid") + "'");
                                int j = 0;
                                while (pnames[i].length() < 50 && rsBill_getPnames.next()) {
                                    if (j == 0) {
                                        pnames[i] += rsBill_getPnames.getString("pname");
                                    } else {
                                        pnames[i] += "," + rsBill_getPnames.getString("pname");
                                    }
                                    j++;
                                }
                                if (pnames[i].length() > 50) {
                                    pnames[i].subSequence(0, 49);
                                    pnames[i] += "...";
                                }

                                i++;
                            }
                            rsBill.beforeFirst();
                            request.setAttribute("pnames", pnames);
                            request.setAttribute("rsBill", rsBill);
                            request.setAttribute("isDispatched", true);
                        }
                        dispatch(request, response, "user/pages/usermanager/showbill/index.jsp");
                    }
                    if (content.equals("userinfo")) {
                        ResultSet rsCus = dao.getData("select * from customer where cid = " + cid);
                        request.setAttribute("rsCus", rsCus);
                        request.setAttribute("isDispatched", true);
                        dispatch(request, response, "user/pages/usermanager/userInfo/index.jsp");
                    }
                }
            }
            if (action.equals("usermanager")) {
                String page = request.getParameter("page");
                String cid = request.getParameter("cid");
                String postfix = "";
                if (page != null && cid != null) {
                    postfix = "?page=" + page;
                    if (page.equals("showbill")) {
                        ResultSet rsBill = dao.getData("select * from bill where cid = " + cid + " order by bill.dateCreate desc ");
                        int rsBill_length = 0;
                        while (rsBill.next()) {
                            rsBill_length++;
                        }
                        if (rsBill_length > 0) {
                            String[] pnames = new String[rsBill_length];
                            for (int j = 0; j < rsBill_length; j++) {
                                pnames[j] = "";
                            }
                            rsBill.beforeFirst();

                            int i = 0;
                            while (rsBill.next()) {

                                ResultSet rsBill_getPnames = dao.getData("select billdetail.*, product.pname  from billdetail join product on billdetail.pid = product.pid where oid ='" + rsBill.getString("oid") + "'");
                                int j = 0;
                                while (pnames[i].length() < 50 && rsBill_getPnames.next()) {
                                    if (j == 0) {
                                        pnames[i] += rsBill_getPnames.getString("pname");
                                    } else {
                                        pnames[i] += "," + rsBill_getPnames.getString("pname");
                                    }
                                    j++;
                                }
                                if (pnames[i].length() > 50) {
                                    pnames[i].subSequence(0, 49);
                                    pnames[i] += "...";
                                }

                                i++;
                            }
                            rsBill.beforeFirst();
                            request.setAttribute("pnames", pnames);
                            request.setAttribute("rsBill", rsBill);
                        }
                        request.setAttribute("isDispatched", true);

                    }
                    if (page.equals("showbilldetail")) {
                        String oid = request.getParameter("oid");
                        ResultSet rsBillDetail = dao.getData("select * from billdetail where oid = " + oid);
                        request.setAttribute("rsBillDetail", rsBillDetail);
                    }
                    if (page.equals("showuserinfo")) {

                        ResultSet rsCus = dao.getData("select * from customer where cid = " + cid);
                        request.setAttribute("rsCus", rsCus);
                    }
                    request.setAttribute("isDispatched", true);
                    dispatch(request, response, "user/pages/usermanager/index.jsp" + postfix);
                } else {
                    dispatch(request, response, "user/pages/error404/index.jsp");
                }

            }
            if (action.equals("cart")) {
                // cập nhật số sản phẩm hiển thị ở navbar
                HttpSession session = request.getSession();
                Integer cid = (Integer) session.getAttribute("user");
                if (cid == null) {
                    out.println("0");
                } else {
                    ResultSet rs = dao.getData("select cid , count(*) as count from cart \n"
                            + "where cid = " + cid
                            + " group by cid");
                    if (rs.next()) {
                        out.println(rs.getInt("count"));
                    } else {
                        out.println("0");
                    }

                }
            }
            if (action.equals("showcart")) {
                // hiển thị danh sách sản phẩm trong giỏ hàng
                Integer cid = null;
                String cidSTR = request.getParameter("cid");
                if (cidSTR == null) {
                    response.sendRedirect("user/pages/login/index.jsp");
                } else {
                    cid = Integer.parseInt(cidSTR);
                }
                if (cid != null) {
                    ResultSet rs = dao.getData("select cart.*, product.image, product.pname,product.price,discount.discount ,product.quantity as maxquantity, cast(product.price as float)*(cast(1 as float)-cast(discount.discount as float)/cast(100 as float)\n"
                            + ")*cast(cart.quantity as float) as total  from\n"
                            + "cart inner join product on cart.pid = product.pid left join discount \n"
                            + "on cart.pid = discount.pid where cid = " + cid);
                    Boolean isEmpty = null;
                    while (rs.next()) {
                        isEmpty = false;
                        request.setAttribute("isEmpty", false);
                        break;
                    }
                    if (isEmpty != null) {
                        rs = dao.getData("select cart.*, product.image, product.pname,product.price,discount.discount ,product.quantity as maxquantity, cast(product.price as float)*(cast(1 as float)-cast(discount.discount as float)/cast(100 as float)\n"
                                + ")*cast(cart.quantity as float) as total  from\n"
                                + "cart inner join product on cart.pid = product.pid left join discount \n"
                                + "on cart.pid = discount.pid where cid = " + cid);
                        boolean allisInChoose = true;
                        while (rs.next()) {
                            if (rs.getInt("inchoose") == 0) {
                                allisInChoose = false;
                                break;
                            }
                        }
                        request.setAttribute("allisInChoose", allisInChoose);

                    } else {
                        request.setAttribute("allisInChoose", false);
                    }

                    rs = dao.getData("select cart.*, product.pname,product.image,product.price,discount.discount ,product.quantity as maxquantity, cast(product.price as float)*(cast(1 as float)-cast(discount.discount as float)/cast(100 as float)\n"
                            + ")*cast(cart.quantity as float) as total  from\n"
                            + "cart inner join product on cart.pid = product.pid left join discount \n"
                            + "on cart.pid = discount.pid where cid = " + cid);

                    request.setAttribute("rsPro", rs);
                    request.setAttribute("isDispatched", true);
                    rs = dao.getData("select count(*) as count  from cart where cid = " + cid + " and inchoose = 1");
                    rs.next();
                    String pid[] = new String[rs.getInt("count")];
                    rs = dao.getData("select * from cart where inchoose = 1 and cid= " + cid);
                    for (int i = 0; i < pid.length; i++) {
                        rs.next();
                        pid[i] = rs.getString("pid");
                    }

                    request.setAttribute("estimatedTotal", calculateTotal(cid, pid, "estimatedTotal"));
                    request.setAttribute("discount", calculateTotal(cid, pid, "discount"));
                    request.setAttribute("total", calculateTotal(cid, pid, "total"));
                    dispatch(request, response, "user/pages/showcart/index.jsp");
                }
            }
            if (action.equals("changeInChooseCart")) {
                String pids[] = request.getParameterValues("pid[]");
                String cid = request.getParameter("cid");
                if (pids == null || pids.length == 0) {
                    dao.setData("update cart set inchoose = 0 where  cid = " + cid);

                } else {
                    String allProduct = "'" + pids[0] + "'";

                    for (int i = 1; i < pids.length; i++) {
                        allProduct = allProduct + ",'" + pids[i] + "'";
                    }
                    allProduct = "(" + allProduct + ")";

                    dao.setData("update cart set inchoose = 1 where pid in" + allProduct + " and cid = " + cid);

                    dao.setData("update cart set inchoose = 0 where pid not in" + allProduct + " and cid = " + cid);

                }

            }
            if (action.equals("addtosession")) {
                String pid = request.getParameter("pid");
                String cidStr = request.getParameter("cid");
                int cid = 0;
                if (cidStr != null) {
                    cid = Integer.parseInt(cidStr);
                }
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                ResultSet rs = dao.getData("select * from product where pid = '" + pid + "'");
                rs.next();

                DAOCart cart = new DAOCart();
                if (cidStr == null) {
                    out.println("user/pages/login/index.jsp");
                } else {

                    Product product = new Product(rs.getString("pid"), rs.getString("pname"), rs.getString("image"), rs.getString("description"), rs.getInt("cateid"), quantity, rs.getDouble("price"), 1);
                    boolean isExisted = false;
                    ResultSet rsc = dao.getData("select * from cart where pid = '" + pid + "'" + " and cid=" + cid);
                    if (rsc.next()) {
                        isExisted = true;

                        cart.updateCart(new Cart(cid, pid, quantity + rsc.getInt("quantity"), 1));
                    } else {

                        cart.addCart(new Cart(cid, pid, quantity, 1));

                    }
                    out.println("Đã thêm " + quantity + " " + rs.getString("pname") + " vào giỏ hàng");
                }
            }
            if (action.equals("changeuserinfo")) {
                String cid = request.getParameter("cid");
                String cdob = request.getParameter("cdob");
                String cname =  new String(request.getParameter("cname").getBytes("ISO-8859-1"), "UTF-8");
;
                String csex = request.getParameter("csex");
        
                String caddress = new String(request.getParameter("caddress").getBytes("ISO-8859-1"), "UTF-8");
                if (cid != null) {
                    ResultSet rsCus = dao.getData("select * from customer where cid = " + cid);
                    rsCus.next();
                    DAOCustomer daoc = new DAOCustomer();
                    
                    daoc.updateCustomer(new Customer(Integer.parseInt(cid), 1, Integer.parseInt(csex), cname, rsCus.getString("cphone"),
                            caddress, rsCus.getString("username"), rsCus.getString("password"), cdob, rsCus.getString("cemail")));
                }
                out.write("Success");
            }
            if (action.equals("removecart")) {
                String[] pid = request.getParameterValues("pid[]");
                String cid = request.getParameter("cid");
                DAOCart daoc = new DAOCart();
                int n = 0;
                for (int i = 0; i < pid.length; i++) {
                    n = daoc.removeCart(Integer.parseInt(cid), pid[i]);
                }
                if (n == 1) {
                    out.println("success");
                }
            }
            if (action.equals("changeaddresscheckout")) {
                //chuwa viet

                String cid = request.getParameter("cid");
                String index = request.getParameter("index");
                submit = request.getParameter("submit");
                if (submit == null) {
                    ResultSet rs = dao.getData("select * from receivingaddress where cid = " + cid + " and index =" + index);
                    request.setAttribute("rsReceivingAddress", rs);
                    request.setAttribute("isDispatched", true);
                    dispatch(request, response, "user/pages/checkout/relatedPages/changeReceivingAddress/index.jsp");
                } else {
                    ResultSet rs = dao.getData("select * from receivingaddress where cid = " + cid + " and index =" + index);
                    rs.next();
                    String caddress = request.getParameter("caddress");
                    String cphone = request.getParameter("cphone");
                    String cname = request.getParameter("cname");
                    DaoReceivingAddress daor = new DaoReceivingAddress();
                    daor.updateCustomer(new ReceivingAddress(cname, Integer.parseInt(cid), caddress, cphone, Integer.parseInt(index), rs.getInt("inuse")));
                    request.setAttribute("isDispatched", true);

                    dispatch(request, response, "user/pages/checkout/index.jsp");

                }
            }
            if (action.equals("setcheckout")) {

                String cid = request.getParameter("cid");
                ResultSet rs = dao.getData("select * from cart  where cid = " + cid + " and inchoose = 1");
                if (rs.next()) {
                    out.println(1);
                } else {
                    out.println(0);
                }

            }
            if (action.equals("getcheckout")) {
                String cid = request.getParameter("cid");
                if (cid == null) {
                    response.sendRedirect("user/pages/login/index.jsp");
                } else {
                    ResultSet cus = dao.getData("select * from receivingaddress where cid =" + cid + " and inuse = 1");
                    request.setAttribute("cusInfo", cus);
                    ResultSet rsCart = dao.getData("select product.pname,product.price,product.image, cart.quantity from cart join product on cart.pid = product.pid where cid = " + cid + " and inchoose=1");
                    request.setAttribute("rsCart", rsCart);
                    request.setAttribute("isDispatched", true);
                    dispatch(request, response, "user/pages/checkout/index.jsp");
                }
            }
            if (action.equals("buycart")) {

                String cid = request.getParameter("cid");

                ResultSet cus = dao.getData("select * from receivingaddress where cid =" + cid + " and inuse = 1");
                cus.next();
                String cname = cus.getString("cname");
                String cphone = cus.getString("cphone");
                String cAddress = cus.getString("caddress");
                ResultSet prods = dao.getData("select product.pname,product.pid,product.price,cart.* from cart join product on cart.pid = product.pid where cid =" + cid + " and inchoose = 1");
                ResultSet rsCus = dao.getData("select * from customer where cid = " + cid);
                rsCus.next();
                Customer customer = new Customer(Integer.parseInt(cid), 1, rsCus.getInt("csex"), cname, cphone, cAddress, "", "", "", "");
                Boolean isEmpty = true;
                while (prods.next()) {
                    isEmpty = false;
                }

                if (!isEmpty) {

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
///////////////
                    String oid = hour + code + millis + second;
                    Bill newBill = new Bill(oid, strDate, customer.getCname(), customer.getCphone(), customer.getcAddress(), 0.0, 0, Integer.parseInt(cid));
                    int n = daobill.addBill(newBill);
//
                    double total = 0.0;
                    DAOBillDetail daodetail = new DAOBillDetail();
                    prods.beforeFirst();
                    prods.next();

                    String allProduct = "'" + prods.getString("pid") + "'";
                    while (prods.next()) {
                        allProduct = allProduct + ",'" + prods.getString("pid") + "'";
                    }
                    allProduct = "(" + allProduct + ")";
                    ResultSet rs = null;
//                  totalbill
                    rs = dao.getData("select cart.cid, sum(cart.quantity*(1-cast(discount.discount as float)/cast(100 as float))*price) as \n"
                            + "total_after_discount from cart join product on cart.pid = product.pid left join \n"
                            + "Discount on cart.pid = discount.pid where cart.pid in" + allProduct + " and cid = " + cid + "group by cart.cid");
                    rs.next();
                    total = rs.getDouble("total_after_discount");

                    prods.beforeFirst();
                    while (prods.next()) {

                        rs = dao.getData("select product.price ,isNULL(discount.discount,0) as discount, cart.quantity from cart join product on cart.pid = product.pid left join discount on cart.pid = discount.pid  where cart.pid ='" + prods.getString("pid") + "' and cid=" + cid);
                        rs.next();

                        int quantity = rs.getInt("quantity");
                        int price = rs.getInt("price");
                        int discount = rs.getInt("discount");

                        double detailTotal = quantity * price * (double) (100 - discount) / 100;

                        int m = daodetail.addBillDetail(new BillDetail(prods.getString("pid"), oid, quantity, price, detailTotal));
                    }

//
                    newBill.setTotal(total);
                    daobill.updateBill(newBill);
//                    /// xóa sản phẩm trong cart
                    DAOCart daoc = new DAOCart();
                    prods.beforeFirst();
                    while (prods.next()) {
                        daoc.removeCart(Integer.parseInt(cid), prods.getString("pid"));
                    }
                    request.setAttribute("isDispatched", true);
                    dispatch(request, response, "ControllerProject?action=usermanager&&page=showbill&&cid="+cid);
                } else {

                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Có lỗi không mong muốn xảy ra!, vui lòng thực hiện lại!');");
                    out.println("location='index.jsp';");
                    out.println("</script>");

                }

//
            }

            if (action.equals("deletebilldetail")) {
                String urlJSP = request.getParameter("url");
                Integer statusbill = Integer.parseInt(request.getParameter("statusbill"));
                request.setAttribute("statusbill", statusbill);
                if (urlJSP == null) {
                    urlJSP = "ControllerBillDetail";
                }
                String pid = request.getParameter("pid");
                String oid = request.getParameter("oid");
                if (pid == null || oid == null) {
                    out.println("cant find oid: " + oid + ", with pid= " + pid);
                }
                new DAOBillDetail().removeBillDetail(oid, pid);
                ResultSet rsdetail = dao.getData("select * from billdetail where oid = '" + oid + "'");
                request.setAttribute("rs", rsdetail);
                request.setAttribute("oid", oid);
                dispatch(request, response, "/" + urlJSP);

            }
            if (action.equals("selectbillpage")) {
                String urlJSP = request.getParameter("url");
                String currentpage = request.getParameter("currentpage");// stt của trang được chọn 
                String other = request.getParameter("other");//kiểm tra xem có  search yêu cầu hoặc khác hay k
                String message = request.getParameter("message");// tuyf chọn hiện thi danh sách theo thứ tự nào hoặc theo từ khóa nào
                request.setAttribute("managertype", "billmanager");
                String option = request.getParameter("option");
                request.setAttribute("option", option);
                String numberofentries = request.getParameter("numberofentries");
                if (numberofentries == null) {
                    numberofentries = "-1";
                }
                int numbofentries = 0;
                try {
                    numbofentries = Integer.parseInt(numberofentries);
                    if (numbofentries <= 0) {
                        numbofentries = -1;
                    }

                } catch (NumberFormatException E) {
                    numbofentries = -1;
                }

                if (urlJSP == null) {
                    urlJSP = "AdminSettings.jsp";
                }
                if (currentpage == null) {
                    currentpage = "1";
                }

                if (message == null) {
                    message = " order by oid\n";
                }
                if (other != null) {
                    if (other.equals("search")) {
                        message = searchBillMassage(request);
                    }
                }
                message = message.replace('_', '%');
                ResultSet rsCount = dao.getData("select * from Bill where status >= 0 " + message);
                int billPerPage = 4;// số lượng bill in ra 1 trang
                if (numbofentries > 0) {
                    billPerPage = numbofentries;// thay đổi số lương bill ở 1 page
                }
                int numberOfPage = countBillPage(billPerPage, rsCount);
                int billOnPage = billPerPage * Integer.parseInt(currentpage) - billPerPage;// hiển thị stt của sản phẩm đầu tiên ở page sắp hiện

                ResultSet rsBill = dao.getData("select * from Bill where status >= 0 " + message
                        + " offset " + billOnPage + " rows fetch next " + billPerPage
                        + " rows only");

                message = message.replace('%', '_');// vì request k nhận dấu % dấu % khi getParameter lại sẽ bị null
                request.setAttribute("numberofentries", billPerPage);
                request.setAttribute("message", message);
                request.setAttribute("currentpage", currentpage);
                request.setAttribute("numbofpage", numberOfPage);
                request.setAttribute("rs", rsBill);
                request.setAttribute("action", action);
                dispatch(request, response, urlJSP);
            }
            if (action.equals("selectproductpage")) {
                String urlJSP = request.getParameter("url");
                String currentpage = request.getParameter("currentpage");// stt của trang được chọn 
                String other = request.getParameter("other");//kiểm tra xem có  search yêu cầu hoặc khác hay k
                String message = request.getParameter("message");// tuyf chọn hiện thi danh sách theo thứ tự nào hoặc theo từ khóa nào
                request.setAttribute("managertype", "productmanager");
                String option = request.getParameter("option");
                request.setAttribute("action", action);
                request.setAttribute("option", option);
                String numberofentries = request.getParameter("numberofentries");
                if (numberofentries == null) {
                    numberofentries = "-1";
                }
                int numbofentries = 0;
                try {
                    numbofentries = Integer.parseInt(numberofentries);

                } catch (NumberFormatException E) {
                    numbofentries = -1;
                }

                if (urlJSP == null) {
                    urlJSP = "AdminSettings.jsp";
                }
                if (currentpage == null) {
                    currentpage = "1";
                }

                if (message == null) {
                    message = " order by pid\n";
                }
                if (other != null) {
                    if (other.equals("search")) {
                        message = searchProductMassage(request);
                    }
                }
                message = message.replace('_', '%');
                ResultSet rsCount = dao.getData("select * from product where status >= 0 " + message);
                int productperpage = 4;// số lượng bill in ra 1 trang
                if (numbofentries > 0) {
                    productperpage = numbofentries;// thay đổi số lương bill ở 1 page
                }
                int numberOfPage = countBillPage(productperpage, rsCount);
                int billOnPage = productperpage * Integer.parseInt(currentpage) - productperpage;// hiển thị stt của sản phẩm đầu tiên ở page sắp hiện

                ResultSet rsBill = dao.getData("select * from product where status >= 0 " + message
                        + " offset " + billOnPage + " rows fetch next " + productperpage
                        + " rows only");

                message = message.replace('%', '_');// vì request k nhận dấu % dấu % khi getParameter lại sẽ bị null
                request.setAttribute("numberofentries", productperpage);
                request.setAttribute("message", message);
                request.setAttribute("currentpage", currentpage);
                request.setAttribute("numbofpage", numberOfPage);
                request.setAttribute("rs", rsBill);
                request.setAttribute("action", action);

                dispatch(request, response, urlJSP);

            }
            if (action.equals("selectcustomerpage")) {
                String urlJSP = request.getParameter("url");
                String currentpage = request.getParameter("currentpage");// stt của trang được chọn 
                String other = request.getParameter("other");//kiểm tra xem có  search yêu cầu hoặc khác hay k
                String message = request.getParameter("message");// tuyf chọn hiện thi danh sách theo thứ tự nào hoặc theo từ khóa nào
                request.setAttribute("managertype", "customermanager");
                String option = request.getParameter("option");
                request.setAttribute("option", option);
                String numberofentries = request.getParameter("numberofentries");
                if (numberofentries == null) {
                    numberofentries = "-1";
                }
                int numbofentries = 0;
                try {
                    numbofentries = Integer.parseInt(numberofentries);

                } catch (NumberFormatException E) {
                    numbofentries = -1;
                }

                if (urlJSP == null) {
                    urlJSP = "AdminSettings.jsp";
                }
                if (currentpage == null) {
                    currentpage = "1";
                }

                if (message == null) {
                    message = " order by cid\n";
                }
                if (other != null) {
                    if (other.equals("search")) {
                        message = searchCustomerMassage(request);
                    }
                }
                message = message.replace('_', '%');
                ResultSet rsCount = dao.getData("select * from customer where status >= 0 " + message);
                int customerperpage = 4;// số lượng bill in ra 1 trang
                if (numbofentries > 0) {
                    customerperpage = numbofentries;// thay đổi số lương bill ở 1 page
                }
                int numberOfPage = countBillPage(customerperpage, rsCount);
                int customeronpage = customerperpage * Integer.parseInt(currentpage) - customerperpage;// hiển thị stt của sản phẩm đầu tiên ở page sắp hiện

                ResultSet rsCus = dao.getData("select * from customer where status >= 0 " + message
                        + " offset " + customeronpage + " rows fetch next " + customerperpage
                        + " rows only");

                message = message.replace('%', '_');// vì request k nhận dấu % dấu % khi getParameter lại sẽ bị null
                request.setAttribute("numberofentries", customerperpage);
                request.setAttribute("message", message);
                request.setAttribute("currentpage", currentpage);
                request.setAttribute("numbofpage", numberOfPage);
                request.setAttribute("rs", rsCus);
                request.setAttribute("action", action);
                dispatch(request, response, urlJSP);

            }
            if (action.equals("updatebilldetail")) {
                String urlJSP = request.getParameter("url");
                request.setAttribute("url", urlJSP);
                Integer statusbill = Integer.parseInt(request.getParameter("statusbill"));
                request.setAttribute("statusbill", statusbill);
                if (submit == null) {
                    String oid = request.getParameter("oid");
                    String pid = request.getParameter("pid");
                    ResultSet rs = dao.getData("select * from billdetail where pid = '" + pid + "' and oid = '" + oid + "'");
                    if (rs.next()) {
                        request.setAttribute("rs", rs);
                        dispatch(request, response, "/UpdateBillDetailForAdmin.jsp");
                    } else {
                        out.println("no oid:" + oid + " no pid:" + pid);
                    }

                } else {

                    if (urlJSP == null) {
                        urlJSP = "AdminSettings.jsp";
                    }
                    String pid = request.getParameter("pid");
                    String oid = request.getParameter("oid");
                    if (pid == null || oid == null) {
                        out.println("cant find oid: " + oid + ", with pid= " + pid);
                    } else {
                        String quantity = request.getParameter("quantity");
                        String price = request.getParameter("price");
                        int quantityNum = 1;
                        double priceNum = 0.0;
                        try {
                            quantityNum = Integer.parseInt(quantity);
                            priceNum = Double.parseDouble(price);
                        } catch (NumberFormatException E) {
                            out.println("quantity or price is not valid");
                        }
                        BillDetail updatedBillDetail = new BillDetail(pid, oid, quantityNum, priceNum, quantityNum * priceNum);
                        int n = new DAOBillDetail().updateBillDetail(updatedBillDetail);
                        if (n == 1) {
                            ResultSet total = dao.getData("select SUM(total) from billdetail\n"
                                    + "where oid = '" + oid + "'");
                            total.next();
                            ResultSet bill = dao.getData("select * from bill where oid = '" + oid + "'");
                            bill.next();
                            Bill updatedBill = new Bill(oid, bill.getString("datecreate"), bill.getString("cname"), bill.getString("cphone"), bill.getString("caddress"), total.getDouble(1), bill.getInt("status"), bill.getInt("cid"));
                            new DAOBill().updateBill(updatedBill);

                            ResultSet rsdetail = dao.getData("select * from billdetail where oid = '" + oid + "'");
                            request.setAttribute("rs", rsdetail);
                            request.setAttribute("oid", oid);
                            dispatch(request, response, "/" + urlJSP);
                        } else {
                            out.println("cant update");
                        }

                    }
                }
            }

            if (action.equals("userlogout")) {

                HttpSession session = request.getSession();
                String urlJSP = request.getParameter("url");
                if (session.getAttribute("user") != null) {
                    session.removeAttribute("user");
                    session.invalidate();
                }
                if (urlJSP == null) {
                    urlJSP = "index.jsp";
                }
                response.sendRedirect(urlJSP);

            }
            if (action.equals("showbillcustomer")) {
                String cid = request.getParameter("cid");
                String urlJSP = request.getParameter("url");
                ResultSet cus = dao.getData("select * from customer where cid = " + cid + "");
//                if (cus.next()) {
//                    
//                    ResultSet rsbill = dao.getData("select * from bill where cid = " + cid);
//                    request.setAttribute("rs", rsbill);
//                    request.setAttribute("showbill", "showbill");
//                    dispatch(request, response, urlJSP);
//
//                } else {
//                    out.println("cant find user " + cid);
//                }
                request.setAttribute("isDispatched", true);
                dispatch(request, response, "user/pages/showbill/index.jsp");
            }
            if (action.equals("selectcategory")) {
                String cateid = request.getParameter("cateid");
                String urlJSP = request.getParameter("url");
                String currentpage = request.getParameter("currentpage");
                String other = request.getParameter("other");//biểu thị yêu cầu trang cần vd:search,...
                String message = request.getParameter("message");// biểu thị list sản phẩm có nhũngư tiêu chí nào
                String numberofentries = request.getParameter("numberofentries");

                if (message == null) {
                    message = " order by pname ";
                } else {
                    if (message.equals("null")) {
                        message = " order by pname ";
                    }
                }
                if (currentpage == null) {
                    currentpage = "1";
                }
                if (cateid == null) {
                    cateid = "all";
                }
                if (urlJSP == null) {
                    urlJSP = "index.jsp";
                }
                if (other != null) {
                    if (other.equals("search")) {
                        message = searchProductMassage(request);
                    }
                }
                message = message.replace('_', '%');
                int proPerPage = 12;// hiển thị ra 3 sản phẩm trong 1 trang
                if (numberofentries != null) {
                    try {
                        proPerPage = Integer.parseInt(numberofentries);
                        if (proPerPage <= 0) {
                            proPerPage = 12;
                        }
                    } catch (NumberFormatException E) {
                        proPerPage = 12;
                    }
                }
                ResultSet rsProTime = dao.getData("with t as (select ISNULL(sum(BillDetail.quantity),0) as sold,product.pid from product left join billdetail on product.pid = BillDetail.pid\n"
                        + "group by product.pid )\n"
                        + "\n"
                        + "\n"
                        + "select    product.pid,t.sold, product.pname,product.price,product.image,discount.discount,max(Datepart(Day, bill.dateCreate)) as day \n"
                        + "from product left join billdetail on product.pid= BillDetail.pid left join bill on BillDetail.oID = bill.oID left join discount on product.pid = discount.pid join t on product.pid = t.pid\n"
                        + "group by product.pname,product.pname,product.price,product.image,discount.discount,product.pid ,t.sold\n"
                        + "\n"
                        + "order by max(Datepart(Day, bill.dateCreate)) desc offset 0 rows fetch next 10 rows only");

                int rsProTime_length = 0;
                while (rsProTime.next()) {
                    rsProTime_length++;
                }
                request.setAttribute("rsProTimelength", rsProTime_length);
                rsProTime.beforeFirst();
                ResultSet rsCate = dao.getData("select * from category");//danh sách category
                ResultSet rsPro = null;//danh sachs sản phẩm
                ResultSet rsCount = null;// mô phỏng danh sách tổng đang được search 
                int proOnPage = proPerPage * (Integer.parseInt(currentpage) - 1);// hiển thị stt của sản phẩm đầu tiên ở page sắp hiện
                if (cateid.equals("all")) {
                    rsPro = dao.getData("select * from product where status = 1\n"
                            + message
                            + " offset " + proOnPage + " rows fetch next " + proPerPage
                            + " rows only");
                    rsCount = dao.getData("select * from product where status = 1\n"
                            + message);

                } else {
                    rsPro = dao.getData("select * from product where cateid = " + cateid + "and status = 1\n"
                            + message
                            + " offset " + proOnPage + " rows fetch next " + proPerPage
                            + "rows only");
                    rsCount = dao.getData("select * from product where cateid = " + cateid + "and status = 1\n"
                            + message);
                }
                int numbOfCate = countCategory(rsCate);
                request.setAttribute("numbOfCate", numbOfCate);
                rsCate = dao.getData("select * from category");
                int numbOfPage = countProductPage(rsCount, proPerPage);// số lượng trang in ra

                message = message.replace('%', '_');
                request.setAttribute("rsProTime", rsProTime);
                request.setAttribute("numberofentries", numberofentries);
                request.setAttribute("message", message);
                request.setAttribute("cateid", cateid);
                request.setAttribute("currentpage", currentpage);
                request.setAttribute("rsPro", rsPro);
                request.setAttribute("numbofpage", numbOfPage);
                request.setAttribute("rscate", rsCate);
                request.setAttribute("isDispatched", true);
                if (urlJSP == null) {
                    urlJSP = "index.jsp";
                }
                dispatch(request, response, urlJSP);
            }
            if (action.equals("hotlistTime")) {

                String byWhen = request.getParameter("bywhen");
                ResultSet rsProTime = getRsProTime(byWhen);
                int rsProTimelength = 0;
                while (rsProTime.next()) {
                    rsProTimelength++;
                }
                rsProTime = getRsProTime(byWhen);
                if (rsProTimelength == 0) {
                    out.println("<div class=\"empty\"><img src=\"https://salt.tikicdn.com/desktop/img/mascot@2x.png\" alt=\"\" class=\"empty__img\"><p class=\"empty__note\">Không có sản phẩm nào trong giỏ hàng của bạn.</p><a data-view-id=\"cart_empty_continue.shopping\" href=\"index.jsp\" class=\"empty__btn\">Tiếp tục mua sắm</a></div>\n"
                            + "");
                } else {

                    while (rsProTime.next()) {
                        String image = rsProTime.getString("image");
                        int price = rsProTime.getInt("price");
                        int discount = rsProTime.getInt("discount");
                        int sold = rsProTime.getInt("sold");
                        String pid = rsProTime.getString("pid");

                        out.println("  <div class=\"item\" style=\"width:   " + (int) 1094 * 2 / rsProTimelength + "px;\"  onclick=\"openItem(this)\" src=\"" + pid + "\">\n"
                                + "                            <div class=\"img\"><img src=\"" + image + "\"></div>\n"
                                + "                            <div class=\"price\"><span class=\"price\">" + price + "đ</span>\n"
                                + "                                <span class=\"discount\">" + discount + "%</span>\n"
                                + "                            </div>\n"
                                + "                            <div class=\"w3-border sold\" style=\"width:  " + (int) 1094 * 2 / rsProTimelength + "px;\">\n"
                                + "                                <div class=\"w3-grey\" style=\"height:24px;width:" + (sold + 5) + "%;\"></div>\n"
                                + "                                <span id=\"sold_child\">" + (sold == 0 ? "Vừa Mở Bán" : "đã bán " + sold) + "</span>\n"
                                + "                            </div>\n"
                                + "\n"
                                + "\n"
                                + "                        </div>");

                    }
                }

            }
            if (action.equals("showbill")) {
                ResultSet rs = dao.getData("select * from Bill");
                request.setAttribute("rs", rs);
                dispatch(request, response, "/ViewBillProject.jsp");
            }
            if (action.equals("contentView")) {
                String cateid = request.getParameter("cateid");
                ResultSet rs = null;
                if (cateid == null) {
                    rs = dao.getData("select * from product");
                } else {
                    rs = dao.getData("select * from product where cateid = " + Integer.parseInt(cateid));
                }

                request.setAttribute("rs", rs);
                dispatch(request, response, "/Content.jsp");

            }
        }
    }

    int calculateTotal(int cid, String[] pid, String requireCalulate) throws SQLException {
        int total = 0;
        DBConnect dao = new DBConnect();
        if (pid.length > 0) {
            String allProduct = "'" + pid[0] + "'";
            for (int i = 1; i < pid.length; i++) {
                allProduct = allProduct + ",'" + pid[i] + "'";
            }
            allProduct = "(" + allProduct + ")";
            ResultSet rs = null;
            if (requireCalulate.equals("total")) {
                rs = dao.getData("select cart.cid, sum(cart.quantity*(1-cast(discount.discount as float)/cast(100 as float))*price) as \n"
                        + "total_after_discount from cart join product on cart.pid = product.pid left join \n"
                        + "Discount on cart.pid = discount.pid where cart.pid in" + allProduct + " and cid = " + cid + "group by cart.cid");
                rs.next();
                return rs.getInt("total_after_discount");
            }
            if (requireCalulate.equals("estimatedTotal")) {
                rs = dao.getData("select cart.cid, sum(cart.quantity*price) as \n"
                        + "real_total from cart join product on cart.pid = product.pid  where cart.pid in " + allProduct + " and cid = " + cid
                        + "group by cart.cid");
                rs.next();
                return rs.getInt("real_total");
            }
            if (requireCalulate.equals("discount")) {
                rs = dao.getData("select cart.cid, sum(cart.quantity*(cast(discount.discount as float)/cast(100 as float))*price) as \n"
                        + "discount_amount from cart join product on cart.pid = product.pid left join \n"
                        + "Discount on cart.pid = discount.pid where cart.pid in " + allProduct + " and cid = " + cid
                        + "group by cart.cid");
                rs.next();
                return rs.getInt("discount_amount");

            }
        }

        return total;
    }

    ResultSet getRsProTime(String byWhen) {
        ResultSet rsProTime = null;
        DBConnect dao = new DBConnect();
        if (byWhen.equals("byday")) {
            rsProTime = dao.getData("with t as (select ISNULL(sum(BillDetail.quantity),0) as sold,product.pid from product left join billdetail on product.pid = BillDetail.pid\n"
                    + "group by product.pid )\n"
                    + "\n"
                    + "\n"
                    + "select     product.pid,t.sold, product.pname,product.price,product.image,discount.discount,max(Datepart(Day, bill.dateCreate)) as day \n"
                    + "from product left join billdetail on product.pid= BillDetail.pid left join bill on BillDetail.oID = bill.oID left join discount on product.pid = discount.pid join t on product.pid = t.pid\n"
                    + "group by  product.pid,product.pname,product.pname,product.price,product.image,discount.discount ,t.sold\n"
                    + "\n"
                    + "order by max(Datepart(Day, bill.dateCreate)) desc offset 0 rows fetch next 10 rows only");

        }
        if (byWhen.equals("bymonth")) {
            rsProTime = dao.getData("with t as (select ISNULL(sum(BillDetail.quantity),0) as sold,product.pid from product left join billdetail on product.pid = BillDetail.pid\n"
                    + "group by product.pid )\n"
                    + "\n"
                    + "\n"
                    + "select     product.pid,t.sold, product.pname,product.price,product.image,discount.discount,max(Datepart(month, bill.dateCreate)) as month \n"
                    + "from product left join billdetail on product.pid= BillDetail.pid left join bill on BillDetail.oID = bill.oID left join discount on product.pid = discount.pid join t on product.pid = t.pid\n"
                    + "group by  product.pid,product.pname,product.pname,product.price,product.image,discount.discount ,t.sold\n"
                    + "\n"
                    + "order by max(Datepart(month, bill.dateCreate)) asc offset 0 rows fetch next 10 rows only");

        }
        if (byWhen.equals("byweek")) {
            rsProTime = dao.getData("with t as (select ISNULL(sum(BillDetail.quantity),0) as sold,product.pid from product left join billdetail on product.pid = BillDetail.pid\n"
                    + "group by product.pid )\n"
                    + "\n"
                    + "\n"
                    + "select    product.pid, t.sold, product.pname,product.price,product.image,discount.discount,max(Datepart(week, bill.dateCreate)) as week \n"
                    + "from product left join billdetail on product.pid= BillDetail.pid left join bill on BillDetail.oID = bill.oID left join discount on product.pid = discount.pid join t on product.pid = t.pid\n"
                    + "group by  product.pid, product.pname,product.pname,product.price,product.image,discount.discount ,t.sold\n"
                    + "\n"
                    + "order by max(Datepart(week, bill.dateCreate)) asc offset 0 rows fetch next 10 rows only");

        }
        return rsProTime;
    }

    void dispatch(HttpServletRequest request, HttpServletResponse response,
            String url) throws ServletException, IOException {
        RequestDispatcher disp = request.getRequestDispatcher(url);
        disp.forward(request, response);
    }

    static String searchBillMassage(HttpServletRequest request) {
        String massage = "";

        String cname = request.getParameter("cname").trim();
        String orderDate = request.getParameter("orderDate");
        String orderName = request.getParameter("orderName");

        if (cname != null) {
            massage += " and cname like '%" + cname + "%' ";
        }

        if (orderName != null) {
            massage += " order by " + orderName + " ";
            if (orderDate != null) {
                massage += ", " + orderDate + " ";
            }

        } else {
            if (orderDate != null) {
                massage += " order by " + orderDate + " ";
            }
        }
        if (orderDate == null && orderName == null) {
            massage += " order by datecreate desc ";
        }

        return massage;
    }

    static String searchProductMassage(HttpServletRequest request) {
        String massage = "";

        String pname = request.getParameter("pname").trim();
        String orderPrice = request.getParameter("orderPrice");
        String orderQuantity = request.getParameter("orderQuantity");
//        String pricelowtoup = request.getParameter("pricelowtoup");
        // form Low_Up
//        String pricelow = null;
//        String priceup = null;
//        if(pricelowtoup!=null){
//            pricelow = pricelowtoup;
//        }
        if (pname != null) {
            massage += " and pname like '%" + pname + "%' ";
        }

        if (orderPrice != null) {
            massage += " order by " + orderPrice + " ";
            if (orderQuantity != null) {
                massage += ", " + orderQuantity + " ";
            }

        } else {
            if (orderQuantity != null) {
                massage += " order by " + orderQuantity + " ";
            }
        }
        if (orderPrice == null && orderQuantity == null) {
            massage += " order by price asc ";
        }

        return massage;
    }

    static String searchCustomerMassage(HttpServletRequest request) {
        String massage = "";

        String cname = request.getParameter("cname").trim();
        String orderName = request.getParameter("order");
        if (cname != null) {
            massage += " and cname like '%" + cname + "%' ";
        }

        if (orderName != null) {
            massage += " order by " + orderName + " ";

        }

        return massage;
    }

    static int countProductPage(ResultSet rs, int proPerPage) throws SQLException {
        DAOProduct dao = new DAOProduct();

        int numOfPros = 0;
        while (rs.next()) {
            numOfPros++;
        }
        int numOfPage = (int) numOfPros / proPerPage;
        if (numOfPage * proPerPage != numOfPros) {
            return numOfPage + 1;
        }
        return numOfPage;
    }

    static int countBillPage(int proPerPage, ResultSet rs) throws SQLException {
        int numOfPros = 0;
        while (rs.next()) {
            numOfPros++;
        }
        rs.beforeFirst();
        int numOfPage = (int) numOfPros / proPerPage;
        if (numOfPage * proPerPage != numOfPros) {
            return numOfPage + 1;
        }
        return numOfPage;
    }

    public static void main(String[] args) throws SQLException {
//        DAOProduct dao = new DAOProduct();
//        ResultSet rs = null;
//        rs = dao.getData("select count(*) from product where status = 1");
//        rs.next();
//        int numOfPros = rs.getInt(1);
//        System.out.println(numOfPros);
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
            Logger.getLogger(ControllerProject.class.getName()).log(Level.SEVERE, null, ex);
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
        String objectToReturn = "";

        String action = request.getParameter("action");
        String submit = request.getParameter("submit");
        String massage = action;
        String urlJSP = request.getParameter("url");
        request.setAttribute("url", urlJSP);
        String username = request.getParameter("username");

        try {

            DBConnect dao = new DAOAdmin();
            if (action.equals("userlogin")) {

                ResultSet acc = dao.getData("select * from Customer where username = '" + username + "' and status = 1");
                if (acc.next()) {

                    String password = request.getParameter("password");
                    if (password.equals(acc.getString("password"))) {
                        HttpSession session = request.getSession();
                        session.setAttribute("user", acc.getInt("cid"));
                        massage = "Success";

                    } else {
                        massage = "Wrong password";

                        request.setAttribute("massage", massage);
                    }

                } else {

                    massage = "account doesnt exist or disabled";
                    request.setAttribute("massage", massage);
                }
                response.setContentType("text/html;charset=UTF-8");
//                objectToReturn = new Gson().toJson(massage);

//                    response.getWriter().println(objectToReturn);
//                    dispatch(request, response, "user/pages/login/index.jsp");
            }else{
                processRequest(request, response);
            }

        } catch (SQLException ex) {
            Logger.getLogger(ControllerProject.class.getName()).log(Level.SEVERE, null, ex);
        }
//        response.getWriter().println(urlJSP);
        response.getWriter().write(massage);
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

    private int countCategory(ResultSet rsCate) throws SQLException {
        int numberOfcate = 0;
        while (rsCate.next()) {
            numberOfcate++;
        }
        rsCate = new DBConnect().getData("select * from category");
        return numberOfcate;
    }

}
