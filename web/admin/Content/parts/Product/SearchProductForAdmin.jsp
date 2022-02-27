<%-- 
    Document   : Product
    Created on : Oct 17, 2021, 10:35:34 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <% String uri = request.getRequestURI();
            String pageName = uri.substring(uri.lastIndexOf("/") + 1);
            Integer numberofentries = (Integer) request.getAttribute("numberofentries");
            String managerType = (String)request.getAttribute("managertype");
            String table = (String) request.getAttribute("table");
        %>

        <form action="ControllerProject?action=selectproductpage&&other=search&&url=/<%=pageName%>&&numberofentries=<%=numberofentries%>&&managertype=<%=managerType%>&&option=listattribute" class="" method="POST">
            <div class="form-group row" >

                <div class="col-sm-12">
                    <input type="text" class="form-control" id="pname" name="pname" placeholder="product name">
                </div>
            </div>

            <fieldset class="form-group">
                <div class="row"><div class="col-sm-12"><h6>Sort by</h6></div></div>
                <div class="row">
                    <legend class="col-form-label col-sm-3 pt-0">Price</legend>
                    <div class="col-sm-9">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="orderPrice" id="gridRadios1" value="price asc" checked>
                            <label class="form-check-label" for="gridRadios1">
                                ASC
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="orderPrice" id="gridRadios2" value="price desc">
                            <label class="form-check-label" for="gridRadios2">
                                DESC
                            </label>
                        </div>
                    </div>
<!--                    <div class="col-sm-4">
                        <button type="submit" value="submit" class="btn btn-primary">Search</button>
                    </div>-->
                </div>
                <div class="row">
                    <legend class="col-form-label col-sm-3 pt-0">Quantity</legend>
                    <div class="col-sm-9">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="orderQuantity" id="gridRadios1" value="Quantity asc" checked>
                            <label class="form-check-label" for="gridRadios1">
                                ASC
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="orderQuantity" id="gridRadios2" value="Quantity desc">
                            <label class="form-check-label" for="gridRadios2">
                                DESC
                            </label>
                        </div>
                    </div>
                    <div class="col-sm-9">
                        <button type="submit" value="submit" class="btn btn-primary">Search</button>
                    </div>
                </div>
            </fieldset>

            <div class="form-group row">

            </div>
        </form>
        <% //   ResultSet rs = (ResultSet) request.getAttribute("rs");%>
        <!--        <form action="ControllerProduct?action=search&&urlJSP=/Product.jsp" method="POST">
                    <table border="1">
                      
                        <tbody>
                            <tr>
                                <td>Product name</td>
                                <td><input type="text" name="pname" value="" /></td>
                            </tr>
                             <tr>
                                <td>order by(Price)</td>
                                <td>ASC<input type="radio" name="orderPrice" value="price asc"  />DESC<input type="radio" name="orderPrice" value="price desc" /></td>
                                
                            </tr>
                            <tr>
                                <td>order by(quantity)</td>
                                <td>ASC<input type="radio" name="orderQuantity" value="Quantity asc"  />DESC<input type="radio" name="orderQuantity" value="quantity desc" /></td>
                                
                            </tr>
                            <tr>
                               
                                <td><input type="submit" value="submit" name="submit" /></td>
                                <td><input type="reset" value="reset" name="reset" /></td>
                            </tr>
                        </tbody>
                    </table>
        
                </form>
        -->

    </body>
</html>
