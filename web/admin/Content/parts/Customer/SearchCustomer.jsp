<%-- 
    Document   : Customer
    Created on : Oct 17, 2021, 8:48:26 PM
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
            String managerType = (String) request.getAttribute("managertype");
        %>

        <form action="ControllerProject?action=selectcustomerpage&&other=search&&url=/<%=pageName%>&&numberofentries=<%=numberofentries%>&&managertype=<%=managerType%>&&option=listattribute" class="" method="POST">
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
                            <input class="form-check-input" type="radio" name="order" id="gridRadios1" value="cname asc" checked>
                            <label class="form-check-label" for="gridRadios1">
                                ASC
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="order" id="gridRadios2" value="cname desc">
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
    </body>
</html>
