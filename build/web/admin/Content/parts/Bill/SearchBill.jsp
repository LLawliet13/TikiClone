<%-- 
    Document   : Bill
    Created on : Oct 17, 2021, 12:36:59 PM
    Author     : DELL
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="css/admincontentstyle.css" rel="stylesheet" type="text/css">

    </head>
    <body>
        <% String uri = request.getRequestURI();
            String pageName = uri.substring(uri.lastIndexOf("/") + 1);
            Integer numberofentries = (Integer) request.getAttribute("numberofentries");
            String managerType = (String)request.getAttribute("managertype");
            String table = (String) request.getAttribute("table");
        %>
<!--        <form class=" md-form search " action="ControllerProject?action=selectbillpage&&other=search&&url=/<%=pageName%>&&numberofentries=<%=numberofentries%>" method="POST">

            <div class="form-group row">
                <label for="cusname" class="col-sm-3 col-form-label">customer name</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="cusname" name="cname" placeholder="cus name">
                </div>
            </div>
            <div class="form-group row">
                <label for="orderbyname" class="col-sm-2 col-form-label">order by(name)</label>
                <div class="col-sm-2">
                    <input type="text" class="form-control" id="orderbyname" name="cname" placeholder="cus name">
                </div>
            </div>
            <div class="form-group row">
            <label for="orderbyname" class="col-sm-2 col-form-label">order by(time)</label>
            <div class="col-sm-2">
                <input type="text" class="form-control" id="orderbyname" name="cname" placeholder="cus name">
            </div>
            </div>-->
<!--        <form class="form md-form search" >
            <div class="form-group row">
                <input class="form-control mr-sm-2" type="text" name="cname" value="" type="text" placeholder="Customer Name" aria-label="Search">

                <button class="btn aqua-gradient btn-rounded btn-sm my-0" type="submit">Search</button>
            </div>
            <div class="form-group row">
                <div class="form-check ">
                    <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio1" value="option1">
                    <label class="form-check-label" for="inlineRadio1">1</label>
                </div>
                <div class="form-check ">
                    <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio2" value="option2">
                    <label class="form-check-label" for="inlineRadio2">2</label>
                </div>
            </div>
        </form>-->
<form action="ControllerProject?action=selectbillpage&&other=search&&url=/<%=pageName%>&&numberofentries=<%=numberofentries%>&&managertype=<%=managerType%>&&option=listattribute" class="" method="POST">
            <div class="form-group row" >
                
                <div class="col-sm-12">
                    <input type="text" class="form-control" id="cname" name="cname" placeholder="Name">
                </div>
            </div>
            
            <fieldset class="form-group">
                <div class="row"><div class="col-sm-12"><h6>Sort by</h6></div></div>
                <div class="row">
                    <legend class="col-form-label col-sm-3 pt-0">Name</legend>
                    <div class="col-sm-9">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="orderName" id="gridRadios1" value="cname asc" >
                            <label class="form-check-label" for="gridRadios1">
                                ASC
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="orderName" id="gridRadios2" value="cname desc">
                            <label class="form-check-label" for="gridRadios2">
                                DESC
                            </label>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <legend class="col-form-label col-sm-3 pt-0">Date Created</legend>
                    <div class="col-sm-9">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="orderDate" id="gridRadios1" value="dateCreate asc">
                            <label class="form-check-label" for="gridRadios1">
                                ASC
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="orderDate" id="gridRadios2" value="dateCreate desc">
                            <label class="form-check-label" for="gridRadios2">
                                DESC
                            </label>
                        </div>
                    </div>
                </div>
            </fieldset>
           
            <div class="form-group row">
                <div class="col-sm-9">
                    <button type="submit" value="submit" class="btn btn-primary">Search</button>
                </div>
            </div>
        </form>




        <!--
        -->            
        <!--<table border="1">
        
                        <tbody>
                            <tr>
                                <td>customer name</td>
                                <td><input type="text" name="cname" value="" /></td>
                            </tr>
        
                            <tr>
                                <td>order by(name)</td>
                                <td>ASC<input type="radio" name="orderName" value="cname asc"  checked/>DESC<input type="radio" name="orderName" value="cname desc" /></td>
        
                            </tr>
                            <tr>
                                <td>order by(time)</td>
                                <td>ASC<input type="radio" name="orderDate" value="dateCreate asc"/>DESC<input type="radio" name="orderDate" value="dateCreate desc" /></td>
        
                            </tr>
                            <tr>
        
                                <td><input type="submit" value="submit" name="submit" /></td>
                                <td><input type="reset" value="reset" name="reset" /></td>
                            </tr>
                        </tbody>
                    </table>-->

    </form>
</body>
</html>
