<%-- 
    Document   : UpdateBill
    Created on : Oct 8, 2021, 1:47:27 PM
    Author     : DELL
--%>

<%@page import="entity.Bill"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

    </head>
    <body>
        <%  String urlAndAction = (String) request.getAttribute("urlandaction");
            ResultSet rs = (ResultSet) request.getAttribute("rs");// bill update trong cơ sở dữ liệu
            String preUrl = (String) request.getAttribute("preurl");
            Bill updateBillCart = (Bill) request.getAttribute("bill");//bill trong checkout
            Bill bill = null;
            if (rs != null) {
                if (rs.next()) {
                    bill = new Bill(rs.getString("oid"), rs.getString("datecreate"), rs.getString("cname"),
                            rs.getString("cphone"), rs.getString("caddress"), rs.getDouble("total"), rs.getInt("status"), rs.getInt("cid"));
                }
            } else {

                bill = updateBillCart;
            }
            if (urlAndAction == null) {
                urlAndAction = "ControllerBill?action=update";
            }

        %>
        <%if (bill != null) {%>
        <form action="<%=urlAndAction%>&&oid=<%=bill.getoID()%>" method="POST">

            <%if (updateBillCart == null) {%>
            <div class="form-group row">
                <label for="inputEmail3" class="col-sm-9 col-form-label">date create</label>
                <div class="col-sm-4">
                    <input type="date" class="form-control" id="inputEmail3" value="<%=bill.getDateCreate()%>" name="datecreate" placeholder="date create">
                </div>
            </div>

            <%}%>
            <div class="form-group row">
                <label for="inputEmail3" class="col-sm-9 col-form-label">Customer Name</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="inputEmail3" name="cname"  value="<%=bill.getCname()%>"  placeholder="Customer Name">
                </div>
            </div>
            <div class="form-group row">
                <label for="inputEmail3" class="col-sm-9 col-form-label">Customer Phone</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="inputEmail3" name="cphone" value="<%=bill.getCphone()%>" placeholder="Customer Phone">
                </div>
            </div>
            <div class="form-group row">
                <label for="inputPassword3" class="col-sm-9 col-form-label">Customer Address</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="inputPassword3" name="caddress" value="<%=bill.getcAddress()%>" placeholder="Customer Address">
                </div>
            </div>



            <%if (updateBillCart == null) {%>
            <fieldset class="form-group">
                <div class="row">
                    <legend class="col-form-label col-sm-9 pt-0">Status</legend>
                    <div class="col-sm-4">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="status" id="gridRadios1" value="1" <%=bill.getStatus() == 1 ? "checked" : ""%> />
                            <label class="form-check-label" for="gridRadios1">
                                Enable
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="status" id="gridRadios2" value="0"<%=bill.getStatus() == 0 ? "checked" : ""%>/>
                            <label class="form-check-label" for="gridRadios2">
                                Disable
                            </label>
                        </div>
                    </div>
                </div>
                <input type="hidden" name="total" value="<%=bill.getTotal()%>" />
            </fieldset>
            <div class="form-group row">
                <label for="inputPassword3" class="col-sm-9 col-form-label">Password</label>
                <div class="col-sm-4">
                    <input type="text" name="cid" value="<%=bill.getCid()%>" class="form-control" id="inputPassword3"  placeholder="cid">
                </div>
            </div>


            <%} else {%>
            <input type="hidden" name="cid" value="<%=bill.getCid()%>" />
            <%}%>

            <div class="form-group row">
                <div class="col-sm-4">
                    <button type="submit" value="submit" name="submit" class="btn btn-primary">Submit</button>
                </div>
            </div>
            <div class="form-group row">
                <div class="col-sm-4">
                    <button type="reset" value="reset" name="reset" class="btn btn-primary">Reset</button>
                </div>
            </div>

            <%}%>

        </tbody>
    </table>



</form>

</body>
</html>
