<%-- 
    Document   : UpdateCustomer
    Created on : Oct 11, 2021, 9:49:05 PM
    Author     : DELL
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <% ResultSet rs = (ResultSet) request.getAttribute("rs");
            String urlJSP = (String) request.getAttribute("url");
        %>
        <%if (rs.next()) {%>
        <form action="ControllerCustomer?action=update&&cateid=<%=rs.getInt("cid")%>&&url=<%=urlJSP%>" method="POST">
            <div class="form-group row">
                <!--<label for="inputEmail3" class="col-sm-2 col-form-label">Customer ID</label>-->
                <!--<div class="col-sm-10">-->
                    <input type="hidden" class="form-control" id="inputEmail3" name="cid" placeholder="Customer Name" value="<%=rs.getInt("cid")%>" >
                <!--</div>-->
            </div>
            <div class="form-group row">
                <label for="inputEmail3" class="col-sm-2 col-form-label">Customer Name</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="inputEmail3" name="cname" placeholder="Customer Name" value="<%=rs.getString("cname")%>" >
                </div>
            </div>
            <div class="form-group row">
                <label for="inputPassword3" class="col-sm-2 col-form-label">Customer Phone Number</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="inputPassword3" name="cphone" placeholder="Customer Phone Number" value="<%=rs.getString("cphone")%>" >
                </div>
            </div>
            <div class="form-group row">
                <label for="inputPassword3" class="col-sm-2 col-form-label">Customer Address</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="inputPassword3" name="caddress" placeholder="Customer Address" value="<%=rs.getString("caddress")%>">
                </div>
            </div>
            <div class="form-group row">
                <label for="inputPassword3" class="col-sm-2 col-form-label">User Name</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="inputPassword3" name="username" placeholder="User Name" value="<%=rs.getString("username")%>">
                </div>
            </div>
            <div class="form-group row">
                <label for="inputPassword3" class="col-sm-2 col-form-label">Password</label>
                <div class="col-sm-10">
                    <input type="password" class="form-control" id="inputPassword3" name="password" placeholder="Password" value="<%=rs.getString("password")%>">
                </div>
            </div>

            <fieldset class="form-group">
                <div class="row">
                    <legend class="col-form-label col-sm-2 pt-0">Status</legend>
                    <div class="col-sm-10">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="status" id="gridRadios1" value="1" <%=rs.getInt("status") == 1 ? "checked" : ""%>>
                            <label class="form-check-label" for="gridRadios1">
                                Enable
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="status" id="gridRadios2" value="0" <%=rs.getInt("status") == 0 ? "checked" : ""%>>
                            <label class="form-check-label" for="gridRadios2">
                                Disable
                            </label>
                        </div>
                    </div>
                </div>
            </fieldset>
            <div class="form-group row">
                <div class="col-sm-10">
                    <button type="submit" value="submit" name="submit" class="btn btn-primary">Submit</button>
                </div>
            </div>

        </form>
        <%}%>

    </body>
</html>
