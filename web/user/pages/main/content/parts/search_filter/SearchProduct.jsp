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
        <%
            Boolean isDispatched = (Boolean) request.getAttribute("isDispatched");
            if(isDispatched==null){
                isDispatched = false;
            }
            String uri = request.getRequestURI();
            String pageName = uri.substring(uri.lastIndexOf("/") + 1);
            String[] parts = uri.split("/");
            int numberofSlash = parts.length - 3;
            String backPrefixLink = "";
            while (numberofSlash > 0) {
                backPrefixLink += "../";
                numberofSlash--;
            }

            String numberofentries = (String) request.getAttribute("numberofentries");
            String cateid = (String) request.getAttribute("cateid");

        %>
     

        <form action="<%=(isDispatched==true?"":backPrefixLink)%>ControllerProject?action=selectcategory&&other=search&&url=<%=pageName%>&&cateid=<%=cateid%>&&numberofentries=<%=numberofentries%>" class="" method="POST">
            <div class="form-group row" >

                <div class="col-sm-12">
                    <input type="text" class="form-control" id="pname" name="pname" placeholder="product name">
                </div>
                <!--                <div class="col-sm-12">
                                    <input type="text" class="form-control" id="pname" name="pricelowtoup" placeholder="khoảng giá theo form Low_Up">
                                </div>-->
            </div>

            <fieldset class="form-group">
                <div class="row"><div class="col-sm-12"><h6>Sort by</h6></div></div>
                <div class="row">
                    <legend class="col-form-label col-sm-3 pt-0">Price</legend>
                    <div class="col-sm-9">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="orderPrice" id="gridRadios1" value="price asc" >
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
                            <input class="form-check-input" type="radio" name="orderQuantity" id="gridRadios1" value="Quantity asc" >
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


    </body>
</html>
